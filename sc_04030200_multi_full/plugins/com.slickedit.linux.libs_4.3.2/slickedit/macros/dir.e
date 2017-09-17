////////////////////////////////////////////////////////////////////////////////////
// $Revision: 47103 $
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
#import "alias.e"
#import "complete.e"
#import "dsutil.e"
#import "fileman.e"
#import "files.e"
#import "forall.e"
#import "fsort.e"
#import "listbox.e"
#import "main.e"
#import "os2cmds.e"
#import "recmacro.e"
#import "stdcmds.e"
#import "stdprocs.e"
//for Unix only
#import "doscmds.e"
#endregion

_str def_sort_dir=1;  /* Option to sort directory by name & path  */

/**
 * Temporarily switches to fundamental mode for the next key press.
 * Useful for getting to a fundamental mode key binding when the
 * current mode has changed the binding of that key.
 *
 * @categories Keyboard_Functions
 *
 */
_command void root_keydef() name_info(','VSARG2_REQUIRES_EDITORCTL)
{
   _macro('m',_macro('s'));
   _macro_delete_line();
   _str mode_name=p_mode_name;
   fundamental_mode();
   _macro_call('fundamental_mode');
   message(nls('Fundamental mode active for next key sequence'));
   typeless k=get_event();
   if ( ! iscancel(k) ) {
      clear_message();
      call_key(k);
   }
   if( command_state() ) {
      // Calling mode selection commands while on the command line is bad
      // because things like p_LangId, etc. are checked and assume the
      // active window is an edit window.
      command_toggle();
   }
   int index= find_index(mode_name'-mode',PROC_TYPE|COMMAND_TYPE);
   if (!index) {
      index= find_index(mode_name'-mode',PROC_TYPE|COMMAND_TYPE|IGNORECASE_TYPE);
   }
   if ( index_callable(index) ) {
      _macro_call(translate(name_name(index),'_', '-'));
      call_index(index);
   } else {
      _macro_call('_SetEditorLanguage');
      _SetEditorLanguage(_get_extension(p_buf_name));
   }
   if ( iscancel(k) ) {
      cancel();
      return;
   }

}
_dirs_to_top()
{
   boolean modify=p_modify;
   int after_line=0;
   int old_line=0;
   top();up();
   _str dirline='';
   typeless done=0;
   while (!search('<DIR>','>@')) {
      get_line(dirline);
      done=_delete_line();
      old_line=p_line;
      p_line=after_line;++after_line;
      insert_line(dirline);
      p_line=old_line;
      _end_line();
      if (done) break;
   }
   p_modify=modify;
   top();
}
_command listds(_str path='') name_info(FILE_ARG'*,'VSARG2_REQUIRES_MDI)
{
   _DataSetUtilList(path);
}


/**
 * Creates a buffer and inserts a list of the files specified with columns
 * for size, date, time, attributes (UNIX: permissions), and name.  The mode
 * is changed to fileman mode.  When in fileman mode, there are some additions
 * and changes to the key bindings.  See help on <b>fileman_mode</b>.
 *
 * @param   command_line   has the following syntax:<br>
 *          {[ [- | +] <i>option_letters</i>] [ [@]<i>filespec </i>]}
 *
 * @param option_letters   may be 'H','S','D','P','T' with the following meaning:
 * <DL compact style="margin-left:20pt;">
 *   <DT>H<DD>Include hidden files.  Default is off.  Ignored by UNIX version.
 *    This option is always turned on under Windows if the "Show all files" explorer option is set.
 *   <DT>S<DD>Include system files.  Default is off.  Ignored by UNIX version.
 *    This option is always turned on under Windows if the "Show all files" explorer option is set.
 *   <DT>D <DD>Include directory files.  Defaults to on.
 *   <DT>P<DD>Append path.  Default is on.
 *   <DT>T<DD>Tree file list.  Default is off.
 * </DL>
 * @param  filespec  may contain operating system wild cards such as '*' and '?'.  If <i>filespec</i> is not specified, the current directory is used.  '@' sign prefix to <i>filespec</i> indicates that <i>filespec</i> is a file or buffer which contains a list of file names to be used as arguments to this command.
 *
 * @example
 * <pre>
 * dir   List file and directory entries of the current directory.
 * dir @backup.lst
 *    List file or directory entries specified by each line of the file "backup.lst".
 * dir c:\  List file and directory entries in the root directory of drive C.
 * dir +HS c:\ List file and directory entries in the root directory of drive C including hidden and system files.
 * </pre>
 * @return  Returns 0 if successful.  Common return values are TOO_MANY_FILES_RC, FILE_NOT_FOUND_RC, PATH_NOT_FOUND_RC, and TOO_MANY_SELECTIONS_RC.  On error, message is displayed.
 *
 * @see fileman
 * @categories File_Functions
 */
_command dir,ls(_str path='') name_info(FILENOAUTODIR_ARG'*,'VSARG2_REQUIRES_MDI)
{
  if ( path=='<' ) {
     path=prompt();
  }
  if (_DataSetIsFile(path)) {
     _DataSetUtilList(path);
     return(0);
  }
  typeless status=edit('+futf8 +t');
  if ( status ) {
     return(status);
  }
  /* list directory entryies (D). */
  /* show path (P) */
  int undo_steps=p_undo_steps;
  p_undo_steps=0;
  fileman_mode();
  status=append_list(path,'','+DP','Directory of ');
  p_modify=0;p_undo_steps=undo_steps;
  _str line='';
  get_line(line);
  if ( line=='' ) {
     quit();
  } else {
     if(!status && def_sort_dir){
        message('Sorting...');
        fsort('f');
        _dirs_to_top();
        clear_message();
        p_modify=0;
     }
  }
  return(status);

}
/**
 * Creates a buffer and inserts a tree directory list of the files specified
 * with columns for size, date, time, attributes, and name.  The mode is changed
 * to fileman mode.  When in fileman mode F1 becomes help on file management
 * keys and the right mouse button brings up a menu of file management commands.
 *
 * @param cmdline has the following syntax:<br>
 * <pre>
 *      {[ [- | +] <i>option_letters</i>] [ [@]<i>filespec </i>]}
 * </pre>
 *
 * @param option_letters may be 'H','S','D','P','T' with the following
 * meaning:
 *
 * <dl>
 * <dt>H</dt><dd>Include hidden files.  Defaults to off.  Ignored by UNIX version.
 * This option is always turned on under Windows if the "Show all
 * files" explorer option is set.</dd>
 * <dt>S</dt><dd>Include system files.  Defaults to off.  Ignored by UNIX version.
 * This option is always turned on under Windows if the "Show all
 * files" explorer option is set.</dd>
 * <dt>D</dt><dd>Include directory files.  Defaults to off.</dd>
 * <dt>P</dt><dd>Append path.  Defaults to on.</dd>
 * <dt>T</dt><dd>Tree file list.  Defaults to on.</dd>
 * </dl>
 *
 * @param filespec may contain operating system wild cards such as '*' and '?'.
 * If <i>filespec</i> is not specified, the current directory is used.  '@' sign
 * prefix to <i>filespec</i> indicates that <i>filespec</i> is a file or buffer
 * which contains a list of file names to be used as arguments to this command.
 *
 * <p>Command line examples:</p>
 * <dl>
 * <dt>list c:\</dt><dd>List all files on drive C.</dd>
 * <dt>list @backup.lst</dt><dd>List files specified by each line of the file
 * "backup.lst".</dd>
 * <dt>list</dt><dd>List all files starting from the current directory.</dd>
 * <dt>list +HS c:\</dt><dd>List all files on drive C including hidden and system
 * files.</dd>
 * </dl>
 *
 * @return Returns 0 if successful.  Common return codes are
 * TOO_MANY_SELECTIONS_RC, FILE_NOT_FOUND_RC, PATH_NOT_FOUND_RC, and
 * TOO_MANY_SELECTIONS_RC.  On error, message is displayed.
 *
 * @see dir
 *
 * @appliesTo Edit_Window
 *
 * @categories File_Functions
 *
 */
_command list(_str path='') name_info(FILENOAUTODIR_ARG'*,'VSARG2_REQUIRES_MDI)
{
  if ( path=='<' ) {
     path=prompt();
  }
  if (_DataSetIsFile(path)) {
     _DataSetUtilList(path);
     return(0);
  }
  typeless status=edit('+futf8 +t');
  if ( status ) {
     return(status);
  }
  /* Search directory tree(T). */
  /* show path (P) */
  int undo_steps=p_undo_steps;
  p_undo_steps=0;
  fileman_mode();
  get_line(auto line);
  status=append_list(path,'','+TP','List of ');
  p_modify=0;p_undo_steps=undo_steps;
  if (status==VSRC_OPERATION_CANCELLED) {
     if (line=='') {
        p_modify=0;
        quit();
     }
     _message_box(get_message(VSRC_OPERATION_CANCELLED));
  } else {
     get_line(line);
     if ( line=='') {
        quit();
     } else {
        if(!status && def_sort_dir){
           message('Sorting...');
           fsort('f');
           clear_message();
           p_modify=0;
        }
     }
  }
  return(status);

}
/**
 * Appends a directory list of the files specified to the current buffer.  If filespec
 * is not specified, files in the current directory are listed.  This command is
 * useful when in fileman mode.  An '@' sign prefix to filespec indicates that
 * filespec is a file or buffer which contains a list of file names to be used
 * as arguments to this command.  Use the <b>dir</b> or <b>list</b> command to change the mode
 * to fileman mode.
 *
 * <i>cmdline</i> is a string in the format: [@]filespec  [ [@]filespec ... ]
 *
 * @return
 * @see dir
 * @see list
 * @see append_list
 * @categories File_Functions
 */
_command append_dir(_str path='') name_info(FILE_ARG'*,'VSARG2_REQUIRES_FILEMAN_MODE|VSARG2_REQUIRES_MDI_EDITORCTL)
{
  if ( path=='<' ) {
     path=prompt();
  }
  return(append_list(path,'','+PD'));

}
/**
 * Appends a tree directory list of the files specified to the current buffer.
 * If filespec is not specified, the current directory list is used.  This
 * command is useful when in fileman mode.  An '@' sign prefix to filespec
 * indicates that filespec is a file or buffer which contains a list of
 * file names to be used as arguments to this command.  Use the dir or
 * list command to change the mode to fileman mode.
 *
 * @param cmdline a string in the format: [@]filespec [[@]filespec ... ]
 *
 * @return Returns 0 if successful.  Common return codes are
 * TOO_MANY_SELECTIONS_RC, TOO_MANY_FILES_RC, TOO_MANY_OPEN_FILES_RC (OS limit).
 * On error, message is displayed.
 *
 * @see dir
 * @see list
 * @see append_dir
 * @see append_list
 * @see fileman
 * @categories File_Functions
 */
_command append_list(_str path='', _str arg2='', _str arg3='', _str arg4='') name_info(FILE_ARG'*,'VSARG2_REQUIRES_FILEMAN_MODE|VSARG2_REQUIRES_MDI_EDITORCTL)
{
   if ( path=='<' ) {
      path=prompt();
   }
   _str cmdline=path;
   _str options='';
   _str filespec='';
   _str ch='';
   _str word_nq='';
   _str param='';
   typeless status=0;
   mou_hour_glass(1);
   for (;;) {
      filespec=parse_file(cmdline);
      ch=substr(filespec,1,1);
      if ( ch:=='-' || ch:=='+' ) {
         options=options " "filespec;
         continue;
      }
      word_nq=strip(filespec,'B','"');
      if ( substr(word_nq,1,1)=='@' ) {
         arg4='';
         param=maybe_quote_filename(substr(word_nq,2));

         status=read_list(param,'',arg3);
         if ( status ) {
            break;
         }
/*
         if option<>'' then
            activate_window list_view_id
            quit_view
            activate_window view_id
         endif
*/
      } else {
         if ( isdirectory(filespec) ) {
            // isdirectory converts filespec to absolute so we have to
            // add quotes
            param=maybe_quote_filename(strip(isdirectory(filespec,1):+ALLFILES_RE));
         } else {
            param=filespec;
         }
         /* Search directory tree(T). */
         /* show path (P) */
         bottom();
         if ( arg3!='' ) {
            status=insert_file_list(arg3 " "options " "param);
         } else {
            status=insert_file_list('+TP 'options " "param);
         }
         if ( status ) {
            message(get_message(status));
            break;
         }
      }
      if ( arg4!='' ) {
        if ( def_exit_file_list ) {
           p_buf_flags=p_buf_flags|VSBUFFLAG_THROW_AWAY_CHANGES;
        }
        typeless junk;
        docname(arg4:+absolute(strip_options(param,junk)));
        top();_delete_line();
        p_modify=0;
        arg4='';
      } else {
        _str line='';
        int old_line=p_line;
        top();get_line(line);
        if ( line=='' ) {
           _delete_line();
           old_line=old_line-1;
        }
        p_line=old_line;
      }
      if ( cmdline=='' ) {
         status=0;
         break;
      }
   }
   mou_hour_glass(0);
   return(status);

}


/**
 * The fileman mode keys are activated after executing the
 * <b>fileman_mode</b>, <b>dir</b>, <b>list</b>, or <b>fileman</b> commands.
 * The keys are redefined as indicated below
 *
 * <DL compact style="margin-left:20pt;">
 *    <DT>Alt+Shift+A   <DD>Select all files.
 *    <DT>Alt+Shift+B   <DD>Backup selected files.
 *    <DT>Alt+Shift+C   <DD>Copy selected files.
 *    <DT>Alt+Shift+D   <DD>Delete selected files.
 *    <DT>Alt+Shift+E   <DD>Edit selected files.
 *    <DT>Alt+Shift+G   <DD>Search and Replace on selected files.
 *    <DT>Alt+Shift+M   <DD>Move select files.
 *    <DT>Alt+Shift+N   <DD>Keyin current line filename.
 *    <DT>Alt+Shift+O   <DD>File Sort dialog box.
 *    <DT>Alt+Shift+R   <DD>Repeat Command on Selected dialog box.
 *    <DT>Alt+Shift+T   <DD>Fileman Set Attributes dialog box.
 *    <DT>ENTER         <DD>Edit current file or insert directory files.
 *    <DT>Space bar     <DD>Select current file toggle.
 *    <DT>'8'           <DD>Select and cursor up.
 *    <DT> '2'          <DD>Select and cursor down.
 *    <DT>'9'           <DD>Deselect and cursor up.
 *    <DT>'3'           <DD>Deselect and cursor down.
 *    <DT>RButtonDown
 *                      <DD>Displays file manager pop-up menu.
 * </DL>
 * Selected directories are skipped by Backup, Move, Delete, Edit, and Set
 * file attribute commands.
 * @categories File_Functions
 */
_command void fileman_mode() name_info(','VSARG2_READ_ONLY|VSARG2_REQUIRES_MDI_EDITORCTL)
{
   _SetEditorLanguage('fileman');
}
/**
 * If the cursor is on the command line, the binding to the last key pressed
 * is executed.  Otherwise the command <b>key_not_defined</b> is called.  Used
 * by fileman mode.
 *
 * @appliesTo Edit_Window, Editor_Control
 *
 * @categories Miscellaneous_Functions
 *
 */
_command void maybe_normal_character() name_info(','VSARG2_LASTKEY|VSARG2_CMDLINE|VSARG2_REQUIRES_EDITORCTL)
{
   if ( command_state() ) {
      int index=eventtab_index(_default_keys,
                              _default_keys,event2index(last_event()));
      if ( index ) {
         try_calling(index);
      } else {
         normal_character();
      }
   } else {
      key_not_defined();
   }

}


/**
 * Opens the file at the cursor or inserts directory file list.  Used by
 * <b>fileman</b> mode.
 * @categories File_Functions
 */
_command void fileman_enter() name_info(','VSARG2_CMDLINE|VSARG2_ICON|VSARG2_REQUIRES_FILEMAN_MODE|VSARG2_REQUIRES_MDI_EDITORCTL)
{
   if ( command_state() || p_window_state:=='I' ) {
      try_calling(eventtab_index(_default_keys,
                          _default_keys,event2index(ENTER)));
   } else {
      _str line='';
      get_line(line);
      if ( pos('<DIR>',line) ) {
         _lbclear();
         _str filename=strip(pcfilename(line),'B','"'):+FILESEP:+ALLFILES_RE;
         filename=maybe_quote_filename(filename);
         int status=insert_file_list('+PRD 'filename);
         if (status) {
            message(get_message(status));
         }
         if(!status && def_sort_dir){
            message('Sorting...');
            fsort('f');
            _dirs_to_top();
            clear_message();
         }
         docname('Directory of 'absolute(filename));
         p_modify=0;
         top();
      } else {
         edit(pcfilename(line),EDIT_DEFAULT_FLAGS);
      }
   }

}
static boolean gAllowProcessCD;
static _str gDirectoryStack[]= null;
void _clear_dir_stack()
{
   gDirectoryStack._makeempty();
}
void _cd_process()
{
   if (!gAllowProcessCD) {
      return;
   }
   if (isinteger(def_cd) && (def_cd & CDFLAG_CHANGE_DIR_IN_BUILD_WINDOW)) {
      _process_cd(getcwd());
   }
}
static int _cd2(_str cmdline="",_str quiet="", _str arg3='')
{
   _str path=cmdline;
   _str options='';
   path=strip_options(path,options,true);
   boolean do_process_cd=(def_cd & CDFLAG_CHANGE_DIR_IN_BUILD_WINDOW) || pos('(^| )\+p',options,1,'ri');
   if (pos('(^| )-p',options,1,'ri')) {
      do_process_cd=0;
   }
   boolean do_alias=(def_cd & CDFLAG_EXPAND_ALIASES_IN_CD_FORM) || pos('(^| )\+a',options,1,'ri');
   if (pos('(^| )-a',options,1,'ri')) {
      do_alias=0;
   }
   if (do_alias && path!='') {
      typeless multi_line_info='';
      _str new_path = get_alias(path,multi_line_info,'','',quiet!='');
      typeless multi_line_flag='';
      typeless file_already_loaded='';
      typeless old_view_id='';
      typeless alias_view_id='';
      parse multi_line_info with multi_line_flag file_already_loaded old_view_id alias_view_id .;
      if ( multi_line_flag ) {
         if (quiet=="") {
            message('Multi-line alias not allowed.');
         }
         return(1);
      }
      if (new_path!='') {
         path=new_path;
      }
   }
   int status=0;
   if ( cmdline!='' ) {
      if ( ! isdirectory(path) ) {
         if (quiet=='') {
            message(nls('Path "%s" not found',strip(path,'B','"')));
         }
         return(PATH_NOT_FOUND_RC);
      }
      if ( arg3!='' || do_process_cd) {
         _process_cd(path);
      }
      path=strip(path,'B','"');
      status=chdir(path,1);    /* change drive and directory. */
      if (status) {
         if (quiet=="") {
            if (status==PATH_NOT_FOUND_RC) {
               message(nls('Path "%s" not found',path));
            } else {
               message(get_message(status));
            }
         }
         return(status);
      }
      gAllowProcessCD=false;
      if (!status) {
         call_list('_cd_',getcwd());
      }
      gAllowProcessCD=true;
   }
   if (quiet=='') {
      _str msg=nls('Current directory is %s',getcwd());
      message(msg);
   }
   gAllowProcessCD=true;
   return(status);

}


/**
 *
 * Changes the current working directory to the drive and path if given.
 * A current directory message is displayed.  By default, this command
 * supports specifying directory aliases for <i>driveNpath</i> and will
 * change directory in the build window.  Use the <b>Change
 * Directory dialog box</b> ("File", "Change Directory...") to change
 * these defaults and press the save settings button.
 *
 * @param cmdline is a  string in the format: [+p | -p] [+a | -a] <i>driveNpath</i>
 * <pre>
 *  The options have the following meaning:
 *  +p      Change directory in the build window.
 *  -p      Don't change directory in the build window.
 *  +a      Support directory aliases for <i>driveNpath</i>.
 *  -a      Do not support directory aliases for <i>driveNpath</i>.
 * </pre>
 * @return  Returns 0 if successful.  Common error code is PATH_NOT_FOUND_RC.
 *
 * @see cdd
 * @see gui_cd
 * @see alias_cd
 *
 *
 * @categories File_Functions
 */
_command cd,pwd(_str cmdline="",_str quiet="") name_info(FILE_ARG " "MORE_ARG',')
{
   _str ssmessage=get_message();
   int sticky=rc;
   int status=_cd2(cmdline,quiet);
   // Don't change this to ==.  Here we are restoring the original
   // message and NOT displaying a new message
   if (quiet!='') {
      if (ssmessage!='') {
         if (sticky) {
            sticky_message(ssmessage);
         } else {
            message(ssmessage);
         }
      }
   }
   return(status);
}
/**
 * Adds the current working directory to the top of the 
 * directory stack and makes the supplied directory (cmdline) 
 * the new working directory.  With no arguments (cmdline==''), 
 * swaps the current working directory with the top of the 
 * directory stack. 
 * 
 * @param cmdline    directory to switch to
 * @param quiet      suppress messages
 * 
 * @return 0 on success, <0 on error 
 *  
 * @see cd 
 * @see popd 
 *  
 * @categories File_Functions
 */
_command int pd,pushd(_str cmdline="",_str quiet="") name_info(FILE_ARG " "MORE_ARG',')
{
   cur_dir := getcwd();
   if (cmdline=='' && gDirectoryStack._length() >= 1) {
      cmdline = maybe_quote_filename(gDirectoryStack[gDirectoryStack._length()-1]);
      gDirectoryStack._deleteel(gDirectoryStack._length()-1);
   }
   status := cd(cmdline,quiet);
   if (!status) {
      gDirectoryStack[gDirectoryStack._length()]=cur_dir;
   }
   return(status);
}
/**
 * Removes the top directory from the directory stack and makes 
 * it the new working directory.   
 * 
 * @param quiet      suppress messages
 * 
 * @return 0 on success, <0 on error 
 *  
 * @see cd 
 * @see pushd 
 *  
 * @categories File_Functions
 */
_command int popd(_str quiet="") name_info(MORE_ARG',')
{
   int n=gDirectoryStack._length();
   if (n<=0 || gDirectoryStack[n-1]=='') {
      if (quiet=='') {
         message(nls("No directories to pop"));
      }
      return(1);
   }
   _str cmdline=gDirectoryStack[n-1];
   gDirectoryStack._deleteel(n-1);
   return cd(cmdline,quiet);
}
/**
 * Changes current drive and directory in the build window (.process).
 *
 * @categories Miscellaneous_Functions
 *
 */
void _process_cd(_str param)
{
   if (!_process_info()) {
      return;
   }
   if ( last_char(param)==FILESEP || last_char(param)==FILESEP2 ) {
      _str new_param=substr(param,1,length(param)-1);
      if ( ! isdrive(new_param) && ! (new_param=='') ) {
         param=new_param;
      }
   }
   int orig_view_id=0;
   get_window_id(orig_view_id);
   p_window_id=_mdi.p_child;

   param=strip(param,"B","\"");
   if ( isdrive(substr(param,1,2)) ) {
      if (_win32s()) {
         concur_command(substr(param,1,2),false,true,false);
         param=maybe_quote_filename(param);
         if (pos('&',param,1) && substr(param,1,1)!='"') {
             param='"'param'"';
         }
         concur_command('cd 'param,false,true,false);
      } else {
         _str drive=substr(param,1,2);
         param=maybe_quote_filename(param);
         if (pos('&',param,1) && substr(param,1,1)!='"') {
             param='"'param'"';
         }
         concur_command(drive' & cd 'param,false,true,false);
      }
   } else {
      param=maybe_quote_filename(param);
      if (pos('&',param,1) && substr(param,1,1)!='"') {
         param='"'param'"';
      }
      concur_command('cd 'param,false,true,false);
   }
   activate_window(orig_view_id);
}


/**
 * For file system with drive letters, when a command of the syntax "<b>d:</b>" is
 * executed, the editor translates the command into "<b>change-drive d:</b>" which
 * calls this command procedure.  The <b>change_drive</b> command changes the current
 * working directory to the drive and path specified.  A current directory message is displayed.
 *
 * @return  Returns 0 if successful.  Common error code is PATH_NOT_FOUND_RC.
 *
 * @categories File_Functions
 */
_command change_drive(_str drive_path='')
{
   /* if cd is changed. May have to change this. */
   return(cd(drive_path));
}

/**
 * Displays the OS-specific file manager. (eg: Windows Explorer
 * on Windows, Finder on Mac OS.) Optionally browses to a
 * directory or file.
 *
 * @param directory Optional directory or file to browse to. If
 *                  empty, defaults to current working directory
 *                  or currently active file. Use - to ignore
 *                  current file or current directory and browse
 *                  from the system root.
 */
_command void explore,finder(_str directory = '') name_info(FILE_MAYBE_LIST_BINARIES_ARG'*,'VSARG2_CMDLINE)
{
   _str cmdline = '';
   _str selectedFile = '';
   if (directory == '') {
      // No directory supplied.
      // Use the directory for the current document, if any.
      if (_mdi.p_child.p_window_id && _mdi.p_child.p_buf_name != '' && file_exists(_mdi.p_child.p_buf_name)) {
         directory = _strip_filename(_mdi.p_child.p_buf_name, 'NE');
         selectedFile = _mdi.p_child.p_buf_name;
      } else {
         // Default to the current working directory
         directory = getcwd();
      }
   } else if (directory == '-') {
      // "Special" argument
      // Ignore any open document or working directory. Go to system root.
      directory = '';
   } else {
      // User supplied a directory argument
      if (def_unix_expansion) {
         directory = _unix_expansion(directory);
      }
      if (!isdirectory(directory)) {
         // Supplied argument not a valid directory
         // See if the 'directory' argument is actually a file
         if (file_exists(directory)) {
            selectedFile = directory;
            directory = _strip_filename(selectedFile, 'NE');
         } else {
            // Default to the current working directory
            directory = getcwd();
         }
      }
   }

#if __PCDOS__
   // Invoking Windows Explorer
   // explorer /e,/select,"Path to file"
   // or
   // explorer /e,"Directory"
   // Note: /e usage will display in "full" explorer view, using the folders sidebar
   // Remove the /e for a "bare" folder view
   // This could be made an option or a def-var
   if (selectedFile != '') {
      cmdline = strip('explorer /e,/select,':+maybe_quote_filename(selectedFile));
   } else if (directory != '') {
      cmdline = strip('explorer /e,':+maybe_quote_filename(directory));
   } else {
      cmdline = 'explorer';
   }

#elif __UNIX__
   if(_isMac()) {
      // Invoking MacOS finder
      cmdline = "osascript -e 'tell application \"Finder\" to activate";
      // If we have a particular file or directory we want to show, reveal them
      if (selectedFile != '') {
         cmdline = cmdline" reveal posix file \""selectedFile"\"";
      } else if (directory != '') {
         cmdline = cmdline" reveal posix file \""directory"\"";
      } else if (def_unix_expansion) { //fall through to user's home directory
         cmdline = cmdline" reveal posix file \""_unix_expansion("~")"\"";
      } else { //fall even further through to the startup disk
         cmdline = cmdline" make new Finder window to startup disk";
      }
      cmdline = cmdline"'";
   } else {

      _str session_name = get_xdesktop_session_name();
      if (session_name == 'gnome') {

         // GNOME desktop environment.  Nautilus doesn't seem to be able to 
         // select a file.
         _str fmpath = path_search('nautilus');
         if (fmpath != '') {
            cmdline = fmpath;
            if (directory != '') {
               cmdline = cmdline :+ ' ' :+ maybe_quote_filename(directory);
            }
         }

      } else if (session_name == 'kde') {

         // KDE desktop environment
         _str fmpath = path_search('konqueror');
         if (fmpath != '') {
            cmdline = fmpath;
            if (selectedFile != '') {
               cmdline = cmdline :+ ' --select ' :+ maybe_quote_filename(selectedFile);
            } else if (directory != '') {
               cmdline = cmdline :+ ' ' :+ maybe_quote_filename(directory);
            }
         }

      } else if (file_exists("/usr/dt/bin/dtfile")) {
         cmdline = "/usr/dt/bin/dtfile -dir " :+ maybe_quote_filename(directory); 

      } else if (machine() == "SGMIPS") {

         _str fmpath = path_search('fm');
         if (fmpath != '') {
            cmdline = fmpath;
            if (directory != '') {
               cmdline = cmdline :+ ' ' :+ maybe_quote_filename(directory);
            }
         }

      } else {
         message('Unable to determine desktop session');
         return;
      }

   }

#endif

   if (cmdline != '') {
      if (_isMac()) {
         shell(cmdline); //osascript doesn't like the 'N' option.
      } else {
         shell(cmdline, 'NA');
      }
   }
}
