////////////////////////////////////////////////////////////////////////////////////
// $Revision: 49468 $
////////////////////////////////////////////////////////////////////////////////////
// Copyright 2010 SlickEdit Inc. 
// You may modify, copy, and distribute the Slick-C Code (modified or unmodified) 
// only if all of the following conditions are met: 
//   (1) You do not include the Slick-C Code in any product or application 
//       designed to run independently of SlickEdit software programs; 
//   (2) You do not use the SlickEdit name, logos or other SlickEdit 
//       trademarks to market Your application; 
//   (3) You provide a copy of this license with the Slick-C Code; and 
//   (4) You agree to indemnify, hold harmless and defend SlickEdit from and 
//       against any loss, damage, claims or lawsuits, including attorney's fees, 
//       that arise or result from the use or distribution of Your application.
////////////////////////////////////////////////////////////////////////////////////
#pragma option(pedantic,on)
#region Imports
#include "slick.sh"
#import "bgsearch.e"
#import "bufftabs.e"
#import "compile.e"
#import "eclipse.e"
#import "files.e"
#import "ftp.e"
#import "hotfix.e"
#import "listbox.e"
#import "makefile.e"
#import "main.e"
#import "menu.e"
#import "moveedge.e"
#import "options.e"
#import "os2cmds.e"
#import "project.e"
#import "restore.e"
#import "saveload.e"
#import "sellist.e"
#import "slickc.e"
#import "stdcmds.e"
#import "stdprocs.e"
#import "tags.e"
#import "wkspace.e"
//for Unix only
#import "util.e"
#endregion

enum_flags SaveConfigFlags {
   EXIT_CONFIG_ALWAYS   = 0x1,
   EXIT_CONFIG_PROMPT   = 0x2,
   //EXIT_CONFIG_NEVER =0x4,
   //EXIT_FILES_ALWAYS =0x8,
   //EXIT_FILES_PROMPT =0x10,
   //EXIT_FILES_NEVER  =0x20,
   EXIT_CONFIRM         = 0x40,
   SAVE_CONFIG_IMMEDIATELY = 0x80
};

static int Nofwindows_count=0;

// global array of window ids that can be accessed by the selllist callback
// to associate sellist slots with their window ids. 
static int g_awinid[];
static _str g_awinname[];

int _OnUpdate_next_window(CMDUI &cmdui,int target_wid,_str command)
{
   if (isEclipsePlugin()) {
      return(MF_ENABLED);
   }
   if (target_wid==_cmdline) {
      target_wid=_mdi.p_child;
   }
   if ( !target_wid || !target_wid._isEditorCtl()) {
      return(MF_GRAYED);
   }
   if (!target_wid.p_mdi_child || (target_wid.p_window_flags & HIDE_WINDOW_OVERLAP)) {
      return(MF_GRAYED);
   }
   int orig_wid=p_window_id;
   p_window_id=_mdi.p_child;
   _next_window('fR' /* no setfocus */);
   int next_wid=p_window_id;
   p_window_id=orig_wid;
   if (next_wid!=target_wid) {
      return(MF_ENABLED);
   }
   return(MF_GRAYED);
}
static void doSmartNextWindow(_str options, boolean isNext) {
   //say('doSmartNextWindow');
   int orig_wid=0;
   get_window_id(orig_wid);

   int orig_mdi_wid=_mdi.p_child;
   if (isNext) {
      _mdi.p_child._next_window(options);
   } else {
      _mdi.p_child._prev_window(options);
   }
   if (orig_wid==_cmdline) {
      _set_focus();
   }
   refresh();
   mou_mode(1);
   mou_capture();
   _str event;
   for (;;) {
      event=get_event();
      if (event:==name2event("C-TAB")) {
         _mdi.p_child._next_window(options);
         if (orig_wid==_cmdline) {
            activate_window(orig_wid);
            _set_focus();
         }
      } else if (event:==name2event("C-S-TAB")) {
         _mdi.p_child._prev_window(options);
         if (orig_wid==_cmdline) {
            activate_window(orig_wid);
            _set_focus();
         }
      } else if (event:==ON_KEYSTATECHANGE) {
         if (!_IsKeyDown(CTRL)) {
            break;
         }
      } else {
         int ev=event2index(event);
         if(!vsIsMouseEvent(ev)) {
            break;
         //This is added to catch a bug in the Gnome environment with the
         //'Highlight the pointer when you press Ctrl' mouse option.  See #11070
         } else if (!_IsKeyDown(CTRL)) {
            break;
         }
      }
   }
   mou_mode(0);
   mou_release();
   if (orig_wid!=_cmdline) {
      p_window_id=_mdi.p_child;
   } else {
      p_window_id=_cmdline;
   }
   if (event!=ON_KEYSTATECHANGE) {
      call_key(event);
   }

   int final_wid = _mdi.p_child;
   if (!(final_wid.p_window_flags & HIDE_WINDOW_OVERLAP) &&
        (_iswindow_valid(orig_mdi_wid) && orig_mdi_wid.p_mdi_child) &&
       final_wid!=orig_mdi_wid) {
      // Put final before original
      //say('doSmartNextWindow: reorder N='orig_mdi_wid.p_buf_name' f='final_wid.p_buf_name);
      orig_mdi_wid._MDIReorder(final_wid);
   }
}
/**
 * Switches to next window.
 * 
 * @see prev_window
 * @see window_left
 * @see window_right
 * @see window_above
 * @see window_below
 * 
 * @appliesTo Edit_Window
 * 
 * @categories Window_Functions
 * 
 */
_command void next_window(_str options="") name_info(','VSARG2_ICON|VSARG2_READ_ONLY|VSARG2_CMDLINE|VSARG2_MARK|VSARG2_REQUIRES_MDI_EDITORCTL|VSARG2_LINEHEX|VSARG2_NOEXIT_SCROLL|VSARG2_LASTKEY)
{
#if 0
   // If currently in output toolbar, put focus back to previous edit window:
   if (outputIsInTabShell()) {
      p_window_id=_mdi.p_child;
      _set_focus();
      return;
   }
#endif
   if (p_window_id!=_cmdline) {
      if (!p_mdi_child || (_mdi.p_child.p_window_flags & HIDE_WINDOW_OVERLAP)) {
         return;
      }
   }

   if(isEclipsePlugin()){
      _eclipse_next_window();
      return;
   }

   _str event=last_event();
   //int ev=event2index(event);

   if (_default_option(VSOPTION_NEXTWINDOWSTYLE)!=1 || event!=name2event('c-tab')) {
      int orig_wid=0;
      get_window_id(orig_wid);
      p_window_id=_mdi.p_child;
      _next_window(options);
      if (orig_wid==_cmdline) {
         activate_window(orig_wid);
         _set_focus();
      }
      return;
   }
   doSmartNextWindow(options,true);
}


int _OnUpdate_prev_window(CMDUI &cmdui,int target_wid,_str command)
{
   return(_OnUpdate_next_window(cmdui,target_wid,command));
}
/**
 * Switches to previous window.  Hidden windows are skipped.
 * 
 * @see next_window
 * @see window_left
 * @see window_right
 * @see window_above
 * @see window_below
 * 
 * @categories Window_Functions
 * 
 */ 
_command void prev_window(_str options="") name_info(','VSARG2_ICON|VSARG2_READ_ONLY|VSARG2_CMDLINE|VSARG2_MARK|VSARG2_REQUIRES_MDI_EDITORCTL|VSARG2_LINEHEX|VSARG2_NOEXIT_SCROLL|VSARG2_LASTKEY)
{
#if 0
   // If currently in output toolbar, put focus back to previous edit window:
   if (outputIsInTabShell()) {
      p_window_id=_mdi.p_child;
      _set_focus();
      return;
   }
#endif
   if (p_window_id!=_cmdline) {
      if (!p_mdi_child || (_mdi.p_child.p_window_flags & HIDE_WINDOW_OVERLAP)) {
         return;
      }
   }

   if(isEclipsePlugin()){
      _eclipse_prev_window();
      return;
   }

   _str event=last_event();
   //int ev=event2index(event);

   if (_default_option(VSOPTION_NEXTWINDOWSTYLE)!=1 || event!=name2event('c-s-tab')) {
      int orig_wid=0;
      get_window_id(orig_wid);
      p_window_id=_mdi.p_child;
      _prev_window(options);
      if (orig_wid==_cmdline) {
         activate_window(orig_wid);
         _set_focus();
      }
      return;
   }
   doSmartNextWindow(options,false);
}
int _OnUpdate_next_buffer(CMDUI &cmdui,int target_wid,_str command)
{
   if ( !target_wid || !target_wid._isEditorCtl()) {
      return(MF_GRAYED);
   }
   if(_Nofbuffers(2)>=2) {
      return(MF_ENABLED);
   }
   return(MF_GRAYED);
}
/**
 * Switches to view of the next buffer within the current window.
 * 
 * @appliesTo Edit_Window
 * 
 * @categories Buffer_Functions
 * 
 */
_command void next_buffer(_str options="") name_info(','VSARG2_READ_ONLY|VSARG2_ICON|VSARG2_MARK|VSARG2_REQUIRES_MDI_EDITORCTL|VSARG2_LINEHEX)
{
   if(isEclipsePlugin()){
      eclipse_navigate_buffers();
      return;
   }

   _str old_buffer_name="";
   typeless swold_pos="";
   int swold_buf_id=0;
   set_switch_buffer_args(old_buffer_name,swold_pos,swold_buf_id);
   int orig_buf_id=p_buf_id;
   _next_buffer(options);
   switch_buffer(old_buffer_name,'',swold_pos,swold_buf_id);
   if (def_one_file!='') {
      _correct_window(orig_buf_id);
   }
}
int _OnUpdate_prev_buffer(CMDUI &cmdui,int target_wid,_str command)
{
   return(_OnUpdate_next_buffer(cmdui,target_wid,command));
}
/**
 * Switches to view of the previous buffer within the current window.
 * 
 * @appliesTo Edit_Window, Editor_Control
 * 
 * @categories Buffer_Functions, Edit_Window_Methods, Editor_Control_Methods
 * 
 */ 
_command void prev_buffer(_str options="") name_info(','VSARG2_READ_ONLY|VSARG2_ICON|VSARG2_MARK|VSARG2_REQUIRES_MDI_EDITORCTL|VSARG2_LINEHEX)
{
   if(isEclipsePlugin()){
      eclipse_navigate_buffers();
      return;
   }
   _str old_buffer_name="";
   typeless swold_pos="";
   int swold_buf_id=0;
   set_switch_buffer_args(old_buffer_name,swold_pos,swold_buf_id);
   int orig_buf_id=p_buf_id;
   _prev_buffer(options);
   switch_buffer(old_buffer_name,'',swold_pos,swold_buf_id);
   if (def_one_file!='') {
      _correct_window(orig_buf_id);
   }
}
/**
 * Switches to the next window if One File per Window is on.  Otherwise, 
 * switches to the next buffer.
 * 
 * @return prev_doc
 * 
 * @appliesTo Edit_Window
 * 
 * @categories Buffer_Functions, Window_Functions
 * 
 */
_command void next_doc(_str options="") name_info(','VSARG2_READ_ONLY|VSARG2_ICON|VSARG2_MARK|VSARG2_REQUIRES_MDI_EDITORCTL|VSARG2_LINEHEX)
{
   if (def_one_file=='') {
      next_buffer(options);
   } else {
      next_window(options);
   }
}
/**
 * Switches to the previous window if One File per Window is on.  
 * Otherwise, switches to the previous buffer.
 * 
 * @return next_doc
 * 
 * @appliesTo Edit_Window
 * 
 * @categories Buffer_Functions, Window_Functions
 * 
 */ 
_command void prev_doc(_str options="") name_info(','VSARG2_READ_ONLY|VSARG2_ICON|VSARG2_MARK|VSARG2_REQUIRES_MDI_EDITORCTL|VSARG2_LINEHEX)
{
   if (def_one_file=='') {
      prev_buffer(options);
   } else {
      prev_window(options);
   }
}
/**
 * Quits the current buffer.  Prompt whether to save
 * changes if the buffer is modified.  If no non-hidden
 * buffers are left close remaining MDI child windows.
 *
 * @param doDeleteMDIWindows
 *               delete_edit_windows is called to deleted all remaining
 *               mdi windows viewing this buffer if it is the last
 *               buffer.
 * @param saveBufferPos
 *               Buffer pos should be saved if buffer is deleted.
 * @param allowQuitIfHiddenWindowActive
 *               Indicates that you can quit buffer in hidden windows
 * @param justSaveBuffer
 *               Just save file if necessary. Don't delete buffer.
 *               Still prompt whether to save changes.
 * @return Returns 0 if successful
 */
int _window_quit(boolean doDeleteMDIWindows=true,
                 boolean saveBufferPos=false,
                 boolean allowQuitIfHiddenWindowActive=false,
                 boolean justSaveBuffer=false
                 )
{

   //if (p_mode_name=='Fileman') {return(1);}
   if (_isdiffed(p_buf_id)) {
      _message_box(nls("You cannot close this file because it is being diffed."));
      return(1);
   }
   // Don't allow buffers in a hidden window to be quit unless override given.
   if ( (p_window_flags&HIDE_WINDOW_OVERLAP) && !allowQuitIfHiddenWindowActive) {
      return(1);
   }
  if ( _process_info('b') ) {  /* does this buffer have the build window? */
#if __UNIX__
      if ( _rsprocessbug() ) {
         message("Sorry, can't quit build tab on RS6000");
         return(1);
      }
#endif
     if ( def_exit_process ) {
        //p_buf_flags&= ~VSBUFFLAG_KEEP_ON_QUIT; No hard to leave this and always keep this buffer
        exit_process();
     } else {
        // Need to remove window, otherwise opening different project causes
        // open windows to grow and grow and grow
        p_buf_flags|= VSBUFFLAG_KEEP_ON_QUIT;
        //message(nls('Please exit build window.'));
        //return(1);
     }
  }

  if (isEclipsePlugin()) {
     if (isInternalCallFromEclipse()) {
        p_buf_flags |= VSBUFFLAG_THROW_AWAY_CHANGES;
     } else {
        return quit(saveBufferPos,allowQuitIfHiddenWindowActive);
     }
  }
  boolean changes_written=1;
  if (!justSaveBuffer && !(p_buf_flags&VSBUFFLAG_KEEP_ON_QUIT)) {
     if ( index_callable(find_index("delphiIsRunning",PROC_TYPE)) ) {
        if ( delphiIsRunning() && delphiIsBufInDelphi(p_buf_name) ) {
           delphiCloseBuffer( p_buf_name );
           return( 0 );
        }
     }
  }
  typeless status=0;
  typeless result=0;
  if ( p_modify && ! (p_buf_flags&VSBUFFLAG_THROW_AWAY_CHANGES) ) {
     flush_keyboard();
     //result=_message_box(nls("Save changes to '%s'?",_build_buf_name()),'',MB_ICONQUESTION|MB_YESNOCANCEL)
     result=prompt_for_save(nls("Save changes to '%s'?",_build_buf_name()));
     if (result==IDCANCEL) {
        return(COMMAND_CANCELLED_RC);
     }
     if (result==IDYES) {
         status=save();
         if ( status ) { return(status); }
     }
     if (result==IDNO) {
        changes_written=0;
        //jguiSendFileInfo(true);
     }
  }
#if !_MDI_INTERFACE
  if (last_buffer()) {
     exit_list();
  }
#endif
  int buf_flags=0;
  typeless encoding=0;
  if ( p_modify && (p_buf_flags&VSBUFFLAG_REVERT_ON_THROW_AWAY) ) {
     buf_flags=p_buf_flags;
     encoding=p_encoding;
     status=load_files(def_load_options' -l -E +r +d 'p_buf_name);
     if ( status ) {
        message(nls('Warning: could not revert to saved'));
     }
     p_buf_flags=buf_flags;
     p_encoding=encoding;
  }
  // IF just save buffer but do not delete buffer.
  if (justSaveBuffer) {
     if (saveBufferPos && changes_written) _add_filepos_info(p_buf_name);
     return(0);
  }
  if (last_buffer() && doDeleteMDIWindows) {
     /* If deleting last buffer. Delete all mdi child windows but hidden window. */
     if (saveBufferPos && changes_written) _add_filepos_info(p_buf_name);
     if ( !(p_buf_flags&VSBUFFLAG_KEEP_ON_QUIT)) {
        if (_DialogViewingBuffer(p_buf_id,p_window_id)) {
           p_buf_flags=p_buf_flags|VSBUFFLAG_HIDDEN|VSBUFFLAG_DELETE_BUFFER_ON_CLOSE;
           call_list('_cbmdibuffer_hidden_');
        } else {
           quit_file();
        }
     } else {
        p_buf_flags=p_buf_flags|VSBUFFLAG_HIDDEN;
        call_list('_cbmdibuffer_hidden_');
     }
     _MDIDeleteWindows();
  } else {
     int buf_id=p_buf_id;
     if ( p_buf_flags&VSBUFFLAG_KEEP_ON_QUIT) {
        p_buf_flags=p_buf_flags|VSBUFFLAG_HIDDEN;
        call_list('_cbmdibuffer_hidden_');
        if(buf_id==p_buf_id) _MDIKeepQuit(p_buf_id);
     } else {
        if (saveBufferPos && changes_written) _add_filepos_info(p_buf_name);
        if (_DialogViewingBuffer(p_buf_id,p_window_id)) {
           p_buf_flags=p_buf_flags|VSBUFFLAG_HIDDEN|VSBUFFLAG_DELETE_BUFFER_ON_CLOSE;
           call_list('_cbmdibuffer_hidden_');
           if(buf_id==p_buf_id) _MDIKeepQuit(p_buf_id);
        } else {
           quit_file();
        }
     }
  }
  return(0);

}

/*
    Delete all the mdi children with edit buffers
*/
void _MDIDeleteWindows()
{
   // Just incase being called from list box (list-buffers),
   // save and restore the current window
   typeless orig_wid=p_window_id;
   int wid;
   for (wid=1;wid<=_last_window_id();++wid) {
      if (_iswindow_valid(wid) && wid.p_mdi_child && wid!=VSWID_HIDDEN) {
         wid._delete_window();
         if (wid==orig_wid) {
            orig_wid='';
         }

      }
   }
   if (orig_wid!='') {
      p_window_id=orig_wid;
   }
}
static void _MDIKeepQuit(int buf_id)
{
   int wid;
   for (wid=1;wid<=_last_window_id();++wid) {
      if (_iswindow_valid(wid) && wid.p_mdi_child && wid!=VSWID_HIDDEN &&
          wid.p_buf_id==buf_id) {
         wid._prev_buffer();
      }
   }
}
int _OnUpdate_arrange_icons(CMDUI &cmdui,int target_wid,_str command)
{
   if (_Noficons()) {
      return(_OnUpdateDefault(cmdui,target_wid,command));
   }
   return(MF_GRAYED);
}
/**
 * Arranges the iconized editor windows.
 * @categories Window_Functions
 */
_command void arrange_icons()  name_info(','VSARG2_READ_ONLY|VSARG2_ICON|VSARG2_REQUIRES_MDI_EDITORCTL|VSARG2_REQUIRES_MINMAXRESTOREICONIZE_WINDOW)
{
   _mdi._arrange_icons();

}
void _countwindows()
{
   if ( ! (p_window_flags&(HIDE_WINDOW_OVERLAP)) ) {
      Nofwindows_count++;
   }

}
/** 
 * @return Returns the number of MDI edit windows not including hidden 
 * windows.
 * 
 * @categories Window_Functions
 * 
 */
int Nofwindows()
{
   if (_no_child_windows()) {
      return(0);
   }
   Nofwindows_count=0;
   for_each_mdi_child('-countwindows','',1);
   return(Nofwindows_count);

}


/** 
 * Executes <i>command</i> for each MDI edit window.  <i>command</i> must be 
 * a Slick-C&reg; function if <i>_external_cmd</i> is '' or not specified.  Otherwise 
 * <i>command</i> may be any external macro or program.  Windows with 
 * (<b>p_window_flags</b> & HIDE_WINDOW_OVERLAP) true, are skipped.
 * 
 * @return  Returns 0 if successful.  Common return codes are 
 * STRING_NOT_FOUND_RC, TOO_MANY_SELECTIONS_RC, and FILE_NOT_FOUND_RC.
 * 
 * @categories Window_Functions
 */
typeless for_each_mdi_child(_str command,...)
{
   if (_no_child_windows()) {
      return(0);
   }
  _prev_window('HF');
  int lastwindow_id=p_window_id;
  _next_window('HF');
  /* for each window in the active ring of windows. */
  boolean done=0;
  int index=0;
  _str cmdname="", cmdline="";
  parse command with cmdname cmdline ;
  if ( arg(2)=='' ) {
     index= find_index(cmdname,PROC_TYPE|COMMAND_TYPE);
     if ( ! index_callable(index) ) {
       messageNwait(nls("Command '%s' not found",cmdname)". "get_message(rc));
       return(rc);
     }
  }
  for (;;) {
    if ( p_window_id== lastwindow_id ) {
      done=1;
    }
    if ( ! (p_window_flags&(HIDE_WINDOW_OVERLAP)) || arg(3)!='' ) {
       if ( arg(2)=='' ) {
          call_index(cmdline,index);
       } else {
          execute(command);
       }
    }
    if ( done ) {
      _next_window('HR');
      break;
    }
    _next_window('HR');
  }
  return(0);

}


typeless for_each_window(typeless index)
{
   if (!isinteger(index)) {
      index=find_index(index,PROC_TYPE|COMMAND_TYPE);
   }
   int i,last=_last_window_id();
   for (i=1;i<=last;++i) {
      if (_iswindow_valid(i) ) {
         typeless status=call_index(i,arg(2),arg(3),arg(4),arg(5),arg(6),index);
         if (status) {
            return(status);
         }
      }
   }
   return(0);
}

/** 
 * Executes <i>command</i> for each buffer.  <i>command</i> must be a Slick-C&reg; 
 * function if <i>_external_cmd</i> is '' or not specified.  Otherwise 
 * <i>command</i> may be any external macro or program.  <i>command</i> is only 
 * executed on buffers "visible" to user.  If <i>command</i> returns a non-zero 
 * value, this function stops iterating buffers and returns that value.  Buffers 
 * with (p_buf_flags & VSBUFFLAG_HIDDEN) false are visible to the user.
 *  
 * @param command  Command to be run on each open buffer 
 * @param external_cmd set to true if <B>command</B> is not a 
 *                     Slick-C command
 * @param pAllowedBufferHT  Pointer to a hashtable indexed by 
 *                 filenames that are valid to run command on.
 *                 This parameter may be null.  This is used to
 *                 keep from running file operations on file
 *                 systems that are slow
 * 
 * @return  Returns 0 if successful.  Common return codes are 
 * STRING_NOT_FOUND_RC, TOO_MANY_SELECTIONS_RC, and FILE_NOT_FOUND_RC.
 * @categories Buffer_Functions
 */
typeless for_each_buffer(_str command,boolean external_cmd=false,
                         AUTORELOAD_FILE_INFO (*pAllowedBufferHT):[]=null
                         )
{
   typeless cmdname="", cmdline="";
   parse command with cmdname cmdline;
   int index=0;
   typeless status=0;
   if ( !external_cmd ) {
      index= find_index(cmdname,PROC_TYPE|COMMAND_TYPE);
      /* messageNwait('index='index' is callable='index_callable(index)' cmdname='cmdname) */
      if ( ! index_callable(index) ) {
        messageNwait(nls("Command '%s' not found",cmdname)". "get_message(rc));
        return(rc);
      }
   }
   int temp_view_id=0;
   int orig_view_id=_create_temp_view(temp_view_id);
   int first_buf_id=p_buf_id;
   for (;;) {
     _next_buffer('HNR');    /* Must include hidden buffers, because */
                            /* active buffer could be a hidden buffer */
     int buf_id=p_buf_id;
     if ( ! (p_buf_flags & VSBUFFLAG_HIDDEN) ) {
        // fastBuffer is true if no table was passed, or the filename we are looking
        // for is in the hash table
        boolean fastBuffer = !pAllowedBufferHT || pAllowedBufferHT->_indexin(_file_case(p_buf_name));
        if ( !fastBuffer ) {
           continue;
        }
        if ( !external_cmd ) {
           status=call_index(cmdline,index);
        } else {
           execute(command);
           status=rc;
        }
        if ( status ) {
           break;
        }
     }
     if ( buf_id== first_buf_id ) {
       break;
     }
   }
   _delete_temp_view(temp_view_id);
   activate_window(orig_view_id);
   return(status);

}
/**
 * Saves all modified forms currently being edited.
 * 
 * @return Returns 0 if successful.  Common return codes are 
 * ACCESS_DENIED_RC, ERROR_OPENING_FILE_RC, 
 * ERROR_WRITING_FILE_RC, INSUFFICIENT_DISK_SPACE_RC, 
 * DRIVE_NOT_READY_RC, and PATH_NOT_FOUND_RC.  On 
 * error, message box is displayed.
 * 
 * @see save_all
 * 
 * @categories File_Functions
 * 
 */ 
_command save_all_forms()
{
   typeless status=0;
   int orig_wid=p_window_id;
   boolean need_to_save_config=0;
   int i, last=_last_window_id();
   for (i=1;i<=last;++i) {
      if (_iswindow_valid(i) && i.p_edit && i.p_object==OI_FORM &&
           i.p_object_modify) {
         p_window_id=i;refresh();_set_focus();
         int result=prompt_for_save(nls("Save changes to form '%s'?",p_name));
         if (result==IDCANCEL) {
            return(COMMAND_CANCELLED_RC);
         }
         if (result==IDYES) {
            int form_wid=i;
            status=form_wid._update_template();
            if (status<0) {
               _message_box(nls("Failed to update form '%s'.\n",form_wid.p_name)get_message(status));
               return(status);
            }
            form_wid.p_object_modify=0;
            _set_object_modify(status);
            need_to_save_config=1;
         }
      }
   }
   if (need_to_save_config) {
      status=save_config();
      if (status) {
         return(status);
      }
   }
   p_window_id=orig_wid;
   return(0);
}
/**
 * Saves all modified buffers.
 * 
 * @return Returns 0 if successful.  Common return codes are 
 * INVALID_OPTION_RC, ACCESS_DENIED_RC, 
 * ERROR_OPENING_FILE_RC, ERROR_WRITING_FILE_RC, 
 * INSUFFICIENT_DISK_SPACE_RC, DRIVE_NOT_READY_RC, 
 * and PATH_NOT_FOUND_RC.  On error, message box is displayed.
 * 
 * @see save_all_forms
 * 
 * @categories File_Functions
 * 
 */ 
_command int save_all(int sv_flags=-1,boolean skip_unnamed_files=false,boolean only_save_workspace_files=false) name_info(','VSARG2_NOEXIT_SCROLL|VSARG2_REQUIRES_MDI_EDITORCTL|VSARG2_READ_ONLY|VSARG2_ICON)
{
#if 1
   if (isEclipsePlugin()) {
      _eclipse_execute_command('org.eclipse.ui.file.saveAll','','');
      return 0;
   }
   typeless status=0;
   int workspace_files_view_id=0;
   int orig_view_id=0;
   get_window_id(orig_view_id);
   if (only_save_workspace_files) {
      _str project_list[];
      status=_GetWorkspaceFiles(_workspace_filename,project_list);
      if (status) {
         only_save_workspace_files=false;
      } else {
         _create_temp_view(workspace_files_view_id);
         int i;
         _str WorkspacePath=_strip_filename(_workspace_filename,'N');
         for (i=0;i<project_list._length();++i) {
            _str CurFilename=absolute(project_list[i],WorkspacePath);
            status=GetProjectFiles(
               CurFilename,workspace_files_view_id,"",null,"",false,
               true  // Convert to absolute
                     // Since we are check all project files can't
                     // use relative since the projects might be
                     // in different directories.
               );
            if (status) {
               _delete_temp_view(workspace_files_view_id);
               only_save_workspace_files=false;
               break;
            }
         }
         activate_window(orig_view_id);
      }
   }

   int save_buf_id[];
   _str save_buf_name[];

   typeless orig_buf_id='';
   if (!_no_child_windows() && def_one_file=='') {
      orig_buf_id=_mdi.p_child.p_buf_id;
   }

   int orig_mdi_child=_mdi.p_child;
   int focus_wid=_get_focus();
   int temp_view_id=0;
   int junk_view_id=0;
   status=_open_temp_view('.command',temp_view_id,junk_view_id,'+b');
   if (status) {
      return(status);
   }
   int wid=0;
   _str buf_name="";
   boolean modify=false;
   _TagDelayCallList();
   int first_buf_id=p_buf_id;
   for (;;) {
      modify=p_modify;
      if (modify &&  _need_to_save() && (!skip_unnamed_files || p_buf_name!='')) {
         boolean skip_this_file=false;
         if (only_save_workspace_files) {
            int orig_view_id2;
            get_window_id(orig_view_id2);
            buf_name=p_buf_name;
            activate_window(workspace_files_view_id);
            top();
            status=search('^'_escape_re_chars(buf_name)'$','@rh'_fpos_case);
            skip_this_file=status!=0;
            activate_window(orig_view_id2);
         }

         if (!skip_this_file) {
            save_buf_id[save_buf_id._length()] = p_buf_id;
            save_buf_name[save_buf_name._length()] = p_buf_name;
         }
      }
      // Include hidden, No old view info updating,
      // No refresh flag updating,
      _next_buffer('HNR');
      if ( p_buf_id == first_buf_id ) {
         status=0;
         break;      }
   }

   int i;
   for (i = 0; i < save_buf_id._length(); ++i) {
      _str sv_buf_name = save_buf_name[i];
      _str sv_buf_id = save_buf_id[i];

      if (def_one_file!='') {
         if (orig_mdi_child!=VSWID_HIDDEN &&
             orig_mdi_child.p_buf_name == sv_buf_name) {
            wid = orig_mdi_child;
         } else {
            wid = window_match(sv_buf_name , 1, 'xn');
         }
         if (!wid) {
            status = _mdi.p_child.edit('+q +bi 'sv_buf_id);
            if (status) {
               _sv_message_box(sv_flags, nls("Unable to active file '%s'\n",sv_buf_name)get_message(status));
               break;
            }
         } else {
            // don't set focus here. _save_status function will set the
            // focus if there is an error.
            p_window_id = wid;
         }
         status = save('',sv_flags);
         if (status) {
            break;
         }
      } else {
         // -bp Don't reinsert buffer.
         status = _mdi.p_child.edit('-bp +q +bi 'sv_buf_id);
         if (status) {
            _sv_message_box(sv_flags, nls("Unable to active file '%s'\n",sv_buf_name)get_message(status));
            break;
         }
         status = _mdi.p_child.save('', sv_flags);
         if (status) {
            break;
         }
      }
   }

   _delete_temp_view(temp_view_id);
   if (!status && focus_wid) {
      focus_wid._set_focus();
   }
   if (!status && orig_buf_id!='') {
      _mdi.p_child.p_buf_id=orig_buf_id;
   }
   _TagProcessCallList();
   if (only_save_workspace_files) {
      _delete_temp_view(workspace_files_view_id);
   }
   activate_window(orig_view_id);
   //jguiSaveAll();
   return(status);
   // return(for_each_buffer('_maybe_save'))
#else
   _TagDelayCallList();
   orig_wid=p_window_id;
   orig_view_id='';
   if (def_one_file!='') {
      orig_view_id=p_window_id
      activate_window VSWID_HIDDEN
   }
   _safe_hidden_window();
   save_pos(p)
   first_buf_id=p_buf_id;
   do_delete_window=0;
   for (;;) {
      modify=p_modify;
      if (modify &&  _need_to_save() && (!skip_unnamed_files || p_buf_name!='')) {
         buf_name=p_buf_name
         if (def_one_file!='') {
            if (orig_wid.p_buf_name==p_buf_name) {
               wid=orig_wid;
            } else {
               wid=window_match(p_buf_name,1,'xn');
            }
            if (!wid) {
               status=orig_wid.edit('+q +bi 'p_buf_id)
               if (status) {
                  _sv_message_box(sv_flags,nls("Unable to active file '%s'\n",buf_name)get_message(status))
                  break;
               }
            } else {
               // don't set focus here. _save_status function will set the
               // focus if there is an error.
               p_window_id=wid;
            }
            status=save('',sv_flags)
            if (status) {
               break;
            }
            if (!wid) {
               _delete_window
            }
            activate_window VSWID_HIDDEN
         } else {
            if (p_window_flags &HIDE_WINDOW_OVERLAP) {
               status=edit('+q +bi 'p_buf_id)
               if (status) {
                  _sv_message_box(sv_flags,nls("Unable to active file '%s'\n",buf_name)get_message(status))
                  break;
               }
               do_delete_window=1
            }
            status=save('',sv_flags)
            if (status) {
               break;
            }
         }

      }
      // Include hidden, No old view info updating,
      // No refresh flag updating,
      _next_buffer 'HNR'
      if ( p_buf_id==first_buf_id ) {
         status=0;
         break
      }
   }
   if (status) {
      // Force refresh flag updating.
      _next_buffer 'H';_prev_buffer 'H';
      buf_id=p_buf_id
      p_buf_id=first_buf_id
      restore_pos(p);
      p_buf_id=buf_id;
   } else if (do_delete_window) {
      _delete_window
      activate_window VSWID_HIDDEN
   } else if (def_one_file==''){
      restore_pos(p);
   }
   if (p_window_id==VSWID_HIDDEN && orig_view_id!='') {
      p_window_id=orig_view_id
   }
   _TagProcessCallList();
   return(status);
   // return(for_each_buffer('_maybe_save'))
#endif
}

#if 0
typeless _fast_call_list(_str list)
{
   for (;;) {
      typeless index;
      parse list with index list ;
      if ( index=='' ) {
         break
      }
      if ( index_callable(index) ) {
         call_index(arg(2),arg(3),arg(4),arg(5),index)
      }
   }
}
#endif


/** 
 * Calls all Slick-C&reg; macro procedures whose name has prefix "_exit_" before 
 * SlickEdit is terminated by one of the commands <b>safe_exit</b>, 
 * <b>save_exit</b> (BRIEF emulation), or <b>quit</b>.
 * 
 * @param endingSession    (Windows only) Is the user logging out
 *                         rather than just closing SlickEdit?
 * 
 * @categories Miscellaneous_Functions
 */
void exit_list(boolean endingSession=false)
{
   // Don't want on_got_focus to call switchbuf list durring exit_list
   call_list('-exit-', endingSession);

}
/**
 * Exits editor.  If any files need to be saved, the number of buffers 
 * which need to be saved is displayed and you are asked whether you 
 * want to exit any way or write them all.
 * 
 * @param doExit           force exit when this macro is finished
 * @param endingSession    (Windows only) Is the user logging out 
 *                         rather than just closing SlickEdit?
 * 
 * @return Exits editor if successful.  Common return codes are 
 * COMMAND_CANCELLED_RC, ACCESS_DENIED_RC, and 
 * INSUFFICIENT_DISK_SPACE_RC.  On error, message is displayed.
 * 
 * @categories Miscellaneous_Functions
 * 
 */ 
_command safe_exit(_str doNotExit='', _str endingSession=false) name_info(','VSARG2_EDITORCTL|VSARG2_REQUIRES_MDI)
{
   boolean bInEclipseMode = false;

   // If were started as part of the eclipse plug-in then
   // we need to save the "Eclipse" way
   //
   if (isEclipsePlugin()) {
      message("safe-exit command not allowed from the SlickEdit Core for Eclipse");
      return 0;
   }

   if(_DebugMaybeTerminate()) {
      return(1);
   }
   slickc_debug(0);
   _project_disable_auto_build(true);

   if (!p_mdi_child && !p_DockingArea && p_object==OI_EDITOR &&
          p_active_form.p_object==OI_FORM) {
      if (last_event():==A_F4) {
         call_event(defeventtab _ainh_dlg_manager,last_event(),'e');
      }
      return(1);
   }
   int wid=_find_formobj('_diff_form','N');
   _nocheck _control _ctlfile1;
   _nocheck _control _ctlfile2;
   if (wid&&
       (wid._ctlfile1.p_modify ||
        wid._ctlfile2.p_modify) ) {
      _message_box(nls("Please close diff first"));
      wid._set_foreground_window();
      return(1);
   }
   typeless result=0;
   if( index_callable(find_index('_ftpInProgress',PROC_TYPE)) && _ftpInProgress() ) {
      result=_message_box("There is an FTP operation in progress.\n\nDo you really want to exit?","",MB_YESNO|MB_ICONQUESTION);
      if( result!=IDYES ) return(1);
   }
   if (index_callable(find_index('_QueryEndSession',PROC_TYPE)) && _QueryEndSession()) {
      return(1);
   }
   // Under OS/2 Menu font can be changed by droping configured ICON onto
   // editor
   if ((def_exit_flags&EXIT_CONFIRM) && !bInEclipseMode) {
      result=_message_box(nls("Exit SlickEdit?"),'',MB_YESNOCANCEL|MB_ICONQUESTION);
      if (result!=IDYES) return(1);
   }
   typeless status=save_all_forms();
   if (status) {
      return(status);
   }
   if (!bInEclipseMode) {
      status=list_modified(nls('Exiting with Modified Buffers'),true);
      if (status) {
         return(status);
      }
   }
   stop_search('quiet');
   p_window_id=_mdi.p_child;
   if ( _process_info() ) {  /* is a process running ? */
      if ( def_exit_process ) {
         exit_process(1);
      } else {
         message(nls('Please exit build window.'));
         return(1);
      }
   }

   quit_error_file();
   status=save_window_config(false,0,true /* exiting editor */);
   if ( status ) {
      message(get_message(status));
      return(status);
   }

   // see if we have any hotfixes that need to be applied
   hotfixAutoApplyOnExit();

   if (def_exit_flags&EXIT_CONFIG_PROMPT) {
      status=gui_save_config();
      if (status) {
         return(status);
      }
   } else {
      status=save_config();
      if (status) {
         //_message_box(nls("Could not save configuration.\n%s",get_message(status)));
         return(status);
      }
   }
   /*
      _exit_<callback> callback functions can only get
      called when there is the editor is guarenteed to
      exit.
   */
   exit_list(endingSession==true);
   if (doNotExit=='') {
      exit(0);
   }
   return(0);
}


_command eclipse_safe_exit(...) name_info(','VSARG2_EDITORCTL|VSARG2_REQUIRES_MDI)
{

   if(_DebugMaybeTerminate()) {
      return(1);
   }
   if (!p_mdi_child && !p_DockingArea && p_object==OI_EDITOR &&
          p_active_form.p_object==OI_FORM) {
      if (last_event():==A_F4) {
         call_event(defeventtab _ainh_dlg_manager,last_event(),'e');
      }
      return(1);
   }
   int wid=_find_formobj('_diff_form','N');
   _nocheck _control _ctlfile1;
   _nocheck _control _ctlfile2;
   if (wid&&
       (wid._ctlfile1.p_modify ||
        wid._ctlfile2.p_modify) ) {
      _message_box(nls("Please close diff first"));
      wid._set_foreground_window();
      return(1);
   }
   typeless result=0;
   if( index_callable(find_index('_ftpInProgress',PROC_TYPE)) && _ftpInProgress() ) {
      result=_message_box("There is an FTP operation in progress.\n\nDo you really want to exit?","",MB_YESNO|MB_ICONQUESTION);
      if( result!=IDYES ) return(1);
   }
   if (index_callable(find_index('_QueryEndSession',PROC_TYPE)) && _QueryEndSession()) {
      return(1);
   }
   typeless status=save_all_forms();
   if (status) {
      return(status);
   }
   p_window_id=_mdi.p_child;
   if ( _process_info() ) {  /* is a process running ? */
      if ( def_exit_process ) {
         exit_process();
      } else {
         message(nls('Please exit build window.'));
         return(1);
      }
   }
   quit_error_file();
   status=save_window_config(false,0,true /* exiting editor */);
   if ( status ) {
      message(get_message(status));
      return(status);
   }
   if (def_exit_flags&EXIT_CONFIG_PROMPT) {
      status=gui_save_config();
      if (status) {
         return(status);
      }
   } else {
      status=save_config();
      if (status) {
         //_message_box(nls("Could not save configuration.\n%s",get_message(status)));
         return(status);
      }
   }
   /*
      _exit_<callback> callback functions can only get
      called when there is the editor is guarenteed to
      exit.
   */
   exit_list();
   exit(0);
   return(0);
}




/** 
 * @return Returns non-zero value if there are more non-hidden buffers.
 * 
 * @categories Buffer_Functions
 * 
 */
boolean last_buffer()
{
   _str info=buf_match('',1,'V');
   for (;;) {
      if ( rc ) { return(1); }
      typeless buf_id, modify, buf_flags, buf_name;
      parse info with buf_id modify buf_flags buf_name ;
      if ( p_buf_id!=buf_id ) {
         return(0);
      }
      info=buf_match('',0,'V');
   }
}
/** 
 * If the current window is maximized (<b>p_window_state</b>=='M'), all 
 * windows with the same tile id (<b>p_tile_id</b>) as the current window (not 
 * including the current window) are deleted.
 * 
 * @see one_window
 * 
 * @appliesTo Edit_Window
 * 
 * @categories Window_Functions
 * 
 */
void one_tile()
{
  if ( p_window_state=='M' && def_one_file=='') {
     if ( p_tile_id>0 ) {
        p_tile_id=-p_tile_id;
     }
     /* remove tiled windows */
     //for_each_mdi_child('_delete_tile_id '(-p_tile_id),'',1)

     int orig_wid=p_window_id;
     int tile_id= -p_tile_id;

     int wid;
     for (wid=1;wid<=_last_window_id();++wid) {
        if (_iswindow_valid(wid) && wid.p_mdi_child && wid!=VSWID_HIDDEN &&
            wid.p_tile_id==tile_id && wid!=orig_wid) {
           wid._delete_window();
        }
     }
     p_window_id=orig_wid;

     p_tile_id=-p_tile_id;
  }

}
static typeless cv_key(_str key)
{
    _str name=name_on_key(key);
    if ( name=='cursor-left' ) {
       key=LEFT;
    } else if ( name=='cursor-right' ) {
       key=RIGHT;
    } else if ( name=='cursor-down' ) {
       key=DOWN;
    } else if ( name=='cursor-up' ) {
       key=UP;
    }
    return(key);

}


/**
 * Creates a new window viewing the current buffer.  The window size of the 
 * original window is not duplicated.
 * 
 * @appliesTo  Edit_Window
 * @categories Edit_Window_Methods, Window_Functions
 */
_command duplicate_window() name_info(','VSARG2_READ_ONLY|VSARG2_REQUIRES_MDI_EDITORCTL|VSARG2_REQUIRES_TILED_WINDOWING|VSARG2_NOEXIT_SCROLL)
{
   int status=edit('+i +bi 'p_buf_id);
   return(status);
}

/**
 * Allows you to create a new tiled window by pointing to edge for new window 
 * with cursor keys.
 * 
 * @return  Returns 0 if successful.  Common return codes are 1 (window too 
 * small to split), COMMAND_CANCELLED_RC, TOO_MANY_WINDOWS_RC, and 
 * TOO_MANY_SELECTIONS_RC.  On error, message is displayed.
 * 
 * @see move_edge
 * @see next_window
 * @see _prev_window
 * @see change_window
 * @see delete_tile
 * @see window_left
 * @see window_right
 * @see window_above
 * @see window_below
 * 
 * @appliesTo  Edit_Window
 * @categories Window_Functions
 */
_command create_tile() name_info(','VSARG2_READ_ONLY|VSARG2_REQUIRES_MDI_EDITORCTL)
{
  if (!isEclipsePlugin()) {
    int apiflags=_default_option(VSOPTION_APIFLAGS);
    if (!(apiflags & VSAPIFLAG_ALLOW_TILED_WINDOWING)){
      return 1;
    }
  }
  message(nls('Point to edge for new window with cursor keys'));
  one_tile();
  mou_capture();
  int old_mouse_pointer=p_mouse_pointer;
  p_mouse_pointer=MP_SIZE;

  int mx,my;
  mou_get_xy(mx,my);
  int x=p_x+p_width intdiv 2;
  int y=p_y+p_height intdiv 2;
  _map_xy(_mdi,0,x,y);
  mou_set_xy(x,y);

  for (;;) {
    _str key=get_event();
    if ( iscancel(key) ) {
      cancel();
      p_mouse_pointer=old_mouse_pointer;
      mou_release();
      mou_set_xy(mx,my);
      return(COMMAND_CANCELLED_RC);
    }
    key=cv_key(key);
    if ( key:==LEFT || key:==RIGHT ) {
      p_mouse_pointer=old_mouse_pointer;
      clear_message();
      typeless status=vsplit_window();
      if ( ! status && key:==LEFT ) {
         _prev_window('H');
      }
      mou_release();
      mou_set_xy(mx,my);
      return(status);
    } else if ( key:==UP || key:==DOWN ) {
      p_mouse_pointer=old_mouse_pointer;
      clear_message();
      typeless status=hsplit_window();
      if ( ! status && key:==UP ) {
         _prev_window('H');
      }
      mou_release();
      mou_set_xy(mx,my);
      return(status);
    }
  }


}
int _OnUpdate_one_window(CMDUI &cmdui,int target_wid,_str command)
{
   // DJB - 12/29/2005  -- Do not check one file per window
   //                      User won't understand why "One Window" is disabled.
   //if (def_one_file!='') {
   //    return(MF_GRAYED);
   //}
   
   // should be disabled if there are no buffers
   if (buf_match('',1,'v')=='') {
      return(MF_GRAYED);
   }

   // sure, enable it
   return(MF_ENABLED);
}
/**
 * Deletes all windows except the current one, which will be
 * zoomed.  No files will be closed.
 * 
 * @see one_tile
 * 
 * @appliesTo Edit_Window
 * 
 * @categories Window_Functions
 * 
 */
_command void one_window() name_info(','VSARG2_ICON|VSARG2_READ_ONLY|VSARG2_REQUIRES_MDI_EDITORCTL|VSARG2_REQUIRES_TILED_WINDOWING|VSARG2_NOEXIT_SCROLL)
{
   if ( p_window_id==VSWID_HIDDEN ) {
      return;
   }
   /* quit all windows but the active window. */
   int window_id= p_window_id;

   int i;
   for (i=1;i<=_last_window_id();++i) {
      if (_iswindow_valid(i) && i!=window_id && i.p_mdi_child &&
          !(i.p_window_flags & HIDE_WINDOW_OVERLAP)) {
         i.quit_window();
      }
   }
   p_window_id=window_id;

   /* Zoom the one window left. */
   p_window_state='M';

}
static void quit_window()
{
   int buf_id=p_buf_id;
   int orig_buf_flags=p_buf_flags;
   // Make sure we don't delete the buffer
   p_buf_flags&=~VSBUFFLAG_DELETE_BUFFER_ON_CLOSE;
   _delete_window();
   _BufSetFlags(buf_id,orig_buf_flags);
}
/**
 * Zooms the current window to as large as possible.  If the current 
 * window has already been zoomed, the previous window configuration 
 * is restored.
 * 
 * @from Unicode.doc
 * 
 * @categories Window_Functions
 * 
 */ 
_command void zoom_window() name_info(','VSARG2_ICON|VSARG2_READ_ONLY|VSARG2_REQUIRES_MDI_EDITORCTL|VSARG2_LINEHEX|VSARG2_REQUIRES_MINMAXRESTOREICONIZE_WINDOW|VSARG2_NOEXIT_SCROLL)
{
   if ( p_window_state:=='M' ) {
      p_window_state='N';
   } else {
      p_window_state='M';
   }
}
void _on_close()
{
   // Save non active buffer cursor position information
   _next_buffer('H');_prev_buffer('H');
   close_window('',true /* save buffer position */);
}
typeless _on_exit(boolean endSession)
{
   typeless status=safe_exit(1,endSession);
   return(status);
}
void _on_drop_files()
{
   if( upcase(_mdi.p_window_state)=='I' ) _mdi.p_window_state='N';
   for (;;) {
      _str filename=_next_drop_file();
      if (filename=='') break;
      int status=edit(maybe_quote_filename(filename),EDIT_DEFAULT_FLAGS);
      if (status) break;
   }
   // Most users want to be able to edit files after they
   // are dropped on the editor. If the editor did not have
   // focus before the drag-drop operation started, then it
   // will not have focus when it is finished...unless we
   // force it. Unfortunately, we cannot call _AppHasFocus()
   // to test for application focus because it will always
   // return true during the drop operation.
   _mdi._set_foreground_window();
}

_str winlist_callback(_str event, var return_value, typeless data);

static typeless curr_window_name;

//_command winlist() name_info(','VSARG2_READ_ONLY)
// This function is not called under windows.
_command void on_more_windows()
{
   _on_more_windows();
}
void _on_more_windows()
{
   int i=0;
   typeless wid=0;
   curr_window_name=p_caption;


   g_awinname._makeempty();
   g_awinid._makeempty();
#if 1
   int orig_view_id=p_window_id;
   int first_wid=p_window_id=_mdi.p_child;

   if (_no_child_windows()) {
      // This should never happen
      return;
   }
   _str line="";
   boolean inserted=0;
   for (;;) {
      if (p_window_id!=VSWID_HIDDEN) {
         inserted=1;
         if (p_DocumentName!='') {
            line=p_DocumentName;
         } else if (p_buf_name != '') {
            line=p_buf_name;
         } else {
            line = FILETABS_NO_NAME:+p_buf_id'>';
         }
         g_awinname[g_awinname._length()]=line"\t"p_window_id;
      }
      _next_window('hf');
      if (p_window_id==first_wid) {
         break;
      }
   }
   p_window_id=orig_view_id;
#else
   boolean inserted=0;
   int last=_last_window_id();
   for (i=1;i<=last;++i) {
      if (_iswindow_valid(i) && i.p_window_id!=VSWID_HIDDEN
           && i.p_mdi_child /*&& !(i._mdi_child_in_menu()) */
           /*((option=='' || (option=='E' && i.p_edit) ||
                   (option=='N' && !i.p_edit)
           )*/
         ) {
         inserted=1;
         if (p_DocumentName!='') {
            g_awinname[g_awinname._length()]=i.p_DocumentName;
         } else {
            g_awinname[g_awinname._length()]=i.p_buf_name;
         }
         g_awinid[g_awinid._length()]=i;
      }
   }
#endif
   if (inserted==1) {
      g_awinname._sort(_fpos_case);
      for (i=0;i<g_awinname._length();++i) {
         parse g_awinname[i] with g_awinname[i] "\t" wid;
         g_awinid[g_awinid._length()]=wid;
      }

      // Make sure to show from _mdi. Just show will cause a crash
      // because the dialog will be parented to the current topmost
      // window and if this is closed in the dialog then a crash will result.
      typeless result=_mdi.show('-modal _sellist_form',
                  'Select Window',
                  SL_DEFAULTCALLBACK | SL_ALLOWMULTISELECT  ,
                  //SL_VIEWID|SL_DEFAULTCALLBACK,
                  //winname_view_id,
                  g_awinname,
                  'Ok,Close Window(s),Help',//Buttons
                  '',//Help Item
                  '',//Font
                  winlist_callback);

      if (result!='') {
         int NextWindow_wid=_mdi.p_child;
         int final_wid=g_awinid[result-1];
         if (!(final_wid.p_window_flags & HIDE_WINDOW_OVERLAP) &&
              (_iswindow_valid(NextWindow_wid) && NextWindow_wid.p_mdi_child) &&
             final_wid!=NextWindow_wid) {
            if (_default_option(VSOPTION_NEXTWINDOWSTYLE)==1) {
               final_wid._MDIReorder(NextWindow_wid);
            } else if (_default_option(VSOPTION_NEXTWINDOWSTYLE)==0){
               NextWindow_wid._MDIReorder(final_wid);
            }
         }

         final_wid._set_focus();
      }
   }

   g_awinname._makeempty();
   g_awinid._makeempty();

   //_delete_temp_view(winid_view_id);
}

_str winlist_callback(_str event, var return_value, typeless info)
{
   int items_to_delete[];
   int line=0;

   switch (event) {
   case SL_ONINIT:
      _sellist._lbsearch(curr_window_name);
      line=_sellist.p_line;
      _sellist._lbtop();_sellist._lbup();
      while (!_sellist._lbdown()) {
         if (line==_sellist.p_line) {
            break;
         }
      }
      
      _sellist._lbselect_line();
      return('');

   case SL_ONUSERBUTTON :
      
      // keep global list of names and remove items to be deleting from
      // the global winname list. Then clear the list and readd the elements
      // in the winname list instead of removing elements from the list.
      
      int i,initial_window_id = p_window_id;
      int next_window_id=0;

      if( info == 3 ) {// Close window button
         int status=_sellist._lbfind_selected(1);
         while (!status) {
            // Save current window_id
            int current_window_id = p_window_id;

            int nSlotToRemove = _sellist.p_line-1;

            p_window_id=g_awinid[ nSlotToRemove ];

            // Find a window to switch focus to if the window
            // being deleted is the focused window.
            if( p_window_id == current_window_id ) {
               _next_window('HF');
               next_window_id=p_window_id;
               p_window_id=g_awinid[ nSlotToRemove ];
            }
            else
               next_window_id = current_window_id;

            p_window_id._set_focus();

            if( close_window('',true ) == 0 ) {
               // Go to next window. Just in case the window we are closing is the current one
               next_window_id._set_focus();
               p_window_id = next_window_id;
               items_to_delete[ items_to_delete._length() ] = nSlotToRemove;
            }
            else {
               p_window_id = next_window_id;
               break;
            }

            // Get next multiple selection
            status=_sellist._lbfind_selected(0);
         }

         // Delete from highest indices to lowest indices so when items are removed
         // the indices don't become invalid.
         items_to_delete._sort("DNI");
         for( i = 0 ; i < items_to_delete._length() ; i++ ) {
            g_awinid._deleteel( items_to_delete[i] );
            g_awinname._deleteel( items_to_delete[i] );
         }

         // Rebuild list of windows in dialog
         _sellist._lbclear( );
         for( i = 0 ; i < g_awinname._length( ) ; i++ )
            _sellist._lbadd_item( g_awinname[i] );

         return_value = '';
     }
     return('');
   case SL_ONDEFAULT:
      // Don't return the current line if there are no windows shown.
      if( _sellist.p_Noflines != 0 ) {
         return_value= _sellist.p_line;
         return 0;
      }
      else {
         return_value = '';
         return 0;
      }
   }
   return('');
}
