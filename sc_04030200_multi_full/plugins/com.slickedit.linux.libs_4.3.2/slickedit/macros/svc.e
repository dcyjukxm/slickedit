////////////////////////////////////////////////////////////////////////////////////
// $Revision: 47195 $
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
#include "subversion.sh"
#include "markers.sh"
#include "cvs.sh"
#include "svc.sh"
#include "diff.sh"
#import "backtag.e"
#import "main.e"
#import "sellist.e"
#import "stdcmds.e"
#import "stdprocs.e"
#import "vc.e"
#endregion

#define VERSION_CONTROL_LOG         'versionControl'

/**
 * This file contains an API of "Specialized Version Control" calls.  For lack
 * of better terminology, a Specialized Version Control system is a system
 * like CVS or Subversion that we provide specialized support
 * for.  To keep things a bit generic these functions will find
 * the approprieate one based on what is returned by
 * _GetVCSystemName().  Some of these functions are support
 * functions that are specific to this functionality, but not to
 * a particular version control system.
 * 
 * I wanted to make these work automatically, by detecting which system the
 * file was checked out from, but since most of these take lists of files we 
 * just cannot do it.
 */

/**
 * Gets the index to the "vcs specific" version of <b>functionName</b>
 * @param vcs Name of a version control system from _GetVCSystemName()
 * @param functionName
 * 
 * @return int index of function, 0 if not found
 */
static int _SVCGetIndex(_str vcs,_str functionName)
{
   switch (vcs) {
   case 'Subversion':
      vcs='SVN';break;
   }
   int index=find_index('_'vcs:+functionName,PROC_TYPE);
   return(index);
}

/**
 * Calls the VC specific function to add files
 * @param filelist list of files to add
 * @param OutputFilename Filename that gets the output of add command.  If "" is passed in, this will be filled in with a filename for the calller to delete
 * @param append_to_output set to true if the output should be appended to rather than overwritten
 * @param pFiles array of System specific file structures.  If this param is non-zero, the 
 *        GetVerboseFileInfo for this system is called to get status on the newly added files
 * @param updated_new_dir set to true if a new directory was added
 * @param add_options Options passed to the *BuildAddCommand callback
 * 
 * @return int 0 if successful
 */
int _SVCAdd(_str filelist[],_str &OutputFilename='',
            boolean append_to_output=false,
            /*CVS_LOG_INFO*/typeless (*pFiles)[]=null,
            boolean &updated_new_dir=false,
            _str add_options='')
{
   int index=_SVCGetIndex(_GetVCSystemName(),"Add");
   if ( !index ) {
      return(COMMAND_NOT_FOUND_RC);
   }
   int status=call_index(filelist,OutputFilename,append_to_output,
                         pFiles,updated_new_dir,add_options,index);
   return(status);
}

/**
 * Show list_modified if any of the files in <b>file_array</b> are modified
 * @param file_array list of files to check for modification
 * 
 * @return int 0 if succesful
 */
int _SVCListModified(_str file_array[])
{
   boolean any_modified=false;

   if (file_array!=null) {
      int index;
      for (index=0;(!any_modified)&&(index<file_array._length());++index) {
         if (file_array[index]!='' && buf_match(maybe_quote_filename(file_array[index]),1,'hx')!='') {
            int temp_view_id,orig_view_id;
            int status=_open_temp_view(file_array[index],temp_view_id,orig_view_id);
            if (!status) {
               if (p_modify) {
                  any_modified=true;
               }
               _delete_temp_view(temp_view_id);
               activate_window(orig_view_id);
            }
         }
      }
   }

   if (!any_modified) {
      return 0;
   }

   return(list_modified());
}

/**
 * Checks <b>filename</b> for CVS/Subversion style conflict markers
 * @param filename file to check
 * @param conflict set to true if there is a comment
 * 
 * @return int 0 if succesful.  Return value pertains to success of 
 * opening/closing file
 */
static int SVCCheckLocalFileForConflict(_str filename,boolean &conflict)
{
   conflict=false;
   int temp_view_id,orig_view_id;
   int status=_open_temp_view(filename,temp_view_id,orig_view_id);
   if ( status ) {
      return(status);
   }
   top();
   status=search('^\<\<\<\<\<\<\< ','@rh');
   conflict=!status;

   p_window_id=orig_view_id;
   _delete_temp_view(temp_view_id);

   return(0);
}

/**
 * Checks <b>filelist</b> for CVS/Subversion style conflict markers
 * @param filelist list of files to check
 * 
 * @return int 0 if succesful.  This means either no conflicts, or the user 
 * acknowledged the conflicts and said it was ok to continue
 */
int _SVCCheckLocalFilesForConflicts(_str (&filelist)[])
{
   _str pluralstr= ( filelist._length() > 1 ) ? 's':'';
   int i;
   STRARRAY dirList;
   for ( i=0;i<filelist._length();++i ) {
      boolean conflict=false;
      _str curfile=filelist[i];
      if (isdirectory(curfile)) {
         dirList[dirList._length()] = curfile;
         continue;
      }
      // DJB 08-31-2006
      // if this happens, the file was probably removed using cvs rm -f
      if (!file_exists(curfile)) continue;
      int status=SVCCheckLocalFileForConflict(curfile,conflict);
      if ( status ) {
         int result=_message_box(nls("Could not open file '%s' to check for conflict indicators.\n\nCommit file%s anyway?",curfile,pluralstr),'',MB_YESNO);
         if ( result!=IDYES ) {
            return(1);
         }
      }
      if ( conflict ) {
         int result=_message_box(nls("The file '%s' contains conflict indicators.\n\nCommit file %s anyway?",curfile,pluralstr),'',MB_YESNO);
         if ( result==IDNO ) {
            return(IDNO);
         }
      }
   }
   if ( dirList._length() ) {
      result := _message_box(nls("If you continue you will commit directories.\nThis will automatically commit the files and directories under those directories.\n\nContinue?"),'',MB_YESNO);
      if ( result==IDNO ) {
         for ( i=0;i<dirList._length();++i ) {
            for ( j:=0;j<filelist._length();++j ) {
               if ( file_eq(dirList[i],filelist[j]) ) {
                  filelist._deleteel(j);--j;
               }
            }
         }
         return(IDNO);
      }
   }
   return(0);
}

/**
 * Commits the files in <b>filelist</b> using <b>comment</b>
 * @param filelist list of files to commit
 * @param comment comment for the files to commit
 * @param OutputFilename file for output. If "" is passed in, this will be filled in with a filename for the calller to delete
 * @param comment_is_filename if true, the <b>comment</b> param is the name of a file that contains the comment
 * @param commit_options options that get passed to SVNBuildCommitCommand
 * @param append_to_output if true <b>OutputFilename</b> is appended to instead of overwritten
 * @param pFiles array of System specific file structures.  If this param is non-zero, the 
 *        GetVerboseFileInfo for this system is called to get status on the newly committed files
 * @param taglist list of tags to apply to files afterwards
 * 
 * @return int 0 if successful
 */
int _SVCCommit(_str filelist[],_str comment,_str &OutputFilename='',
               boolean comment_is_filename=false,_str commit_options='',
               boolean append_to_output=false,typeless (*pFiles)[]=null,
               _str taglist='')
{

   int index=_SVCGetIndex(_GetVCSystemName(),"Commit");
   if ( !index ) {
      return(COMMAND_NOT_FOUND_RC);
   }
   int status=call_index(filelist,comment,OutputFilename,
                         comment_is_filename,commit_options,append_to_output,
                         pFiles,taglist,index);
   return(status);
}

/**
 * Displays error output if <b>last_operation_status</b> is non-zero, or certain
 *          "trigger words" occur in <b>error_filename</b>
 * @param error_filename File with output to check
 * @param last_operation_status status from the operation that we are checking on
 * @param focus_wid window id to set focus to when done
 * @param JumpToBottom if true, jumps to the bottom after 
 *                     inserting text
 * @param clearBuffer if true (default), clear other output 
 *                    FIRST
 * 
 * @return int 0 if successful
 */
int _SVCDisplayErrorOutputFromFile(_str error_filename,int last_operation_status=0,int focus_wid=0,
                                   boolean JumpToBottom=false,boolean clearBuffer=true)
{
   if ( clearBuffer ) _SccDisplayOutput('',true);
   int temp_view_id,orig_view_id;
   int status=_open_temp_view(error_filename,temp_view_id,orig_view_id);
   if ( status ) {
      return(status);
   }
   if ( !last_operation_status ) {
      status=search('aborted','@h');
      if ( !status ) {
         last_operation_status=1;
      }
   }
   if ( last_operation_status ) {
      p_window_id=orig_view_id;
      _VCErrorForm(temp_view_id,-1,'',JumpToBottom);
   } else {
      top();up();
      boolean clear=true;
      while ( !down() ) {
         get_line(auto line);
         _SccDisplayOutput(line,clear);
         clear=false;
      }
      p_window_id=orig_view_id;
      _delete_temp_view(temp_view_id);
   }
   if ( focus_wid ) {
      focus_wid._set_focus();
   }
   return(0);
}

/**
 * Displays error output if <b>last_operation_status</b> is non-zero, or certain
 *          "trigger words" occur in <b>error_filename</b>
 * 
 * @param error_output String that has the error output
 * @param last_operation_status status from the operation that we are checking on
 * @param focus_wid window id to set focus to when done
 * @param JumpToBottom if true, jumps to the bottom after inserting text
 * 
 * @return int 0 if successful
 */
int _SVCDisplayErrorOutputFromString(_str error_output,int last_operation_status=0,int focus_wid=0,
                                   boolean JumpToBottom=false)
{
   if ( !last_operation_status ) {
      int p=pos('aborted',error_output);
      if ( p ) {
         last_operation_status=1;
      }
   }
   if ( last_operation_status ) {
      _SccDisplayOutput(error_output,true);
   }
   return(0);
}

/**
 * Tag the items in <b>filelist</b> with <b>tag_options_and_tagname</b>
 * @param filelist files to tag
 * @param OutputFilename Filename that gets the output of tag command.  If "" is passed in, this will be filled in with a filename for the calller to delete
 * @param append_to_output set to true if the output should be appended to rather than overwritten
 * @param tag_options_and_tagname options and tag to usee
 * @param append_to_output set to true if the output should be appended to rather than overwritten
 * @param pFiles array of System specific file structures.  If this param is non-zero, the 
 *        GetVerboseFileInfo for this system is called to get status on the newly tagged files
 * @param updated_new_dir set to true if a new directory was added
 * 
 * @return int
 */
int _SVCTag(_str filelist[],_str &OutputFilename='',_str tag_options_and_tagname='',
            boolean append_to_output=false,typeless (*pFiles)[]=null,
            boolean &included_dir=false)
{
   int index=_SVCGetIndex(_GetVCSystemName(),"Tag");
   if ( !index ) {
      return(COMMAND_NOT_FOUND_RC);
   }
   int status=call_index(filelist,OutputFilename,tag_options_and_tagname,
                         append_to_output,pFiles,included_dir,index);
   return(status);
}

/**
 * Calls relative, but gets the FILESEP chars right for that system 
 * (this is mostly for CVS, but Subversion works either way).
 * @param filename to convert to relative
 * @param dir directory to make <b>filename</b> relative to.  If this is null, 
 *        the current directory is used.
 *
 * @return _str <b>filename</b> relative to <b>dir</b> or the current directory if
 * <b>dir</b> is null
 */
_str _SVCRelative(_str filename,_str dir=null)
{
   filename=relative(filename,dir);
#if !__UNIX__
   filename=stranslate(filename,FILESEP2,FILESEP);
#endif
   return(filename);
}

/**
 * 
 * @param path
 * @param Files
 * @param module_name
 * @param recurse
 * @param run_from_path
 * @param treat_as_wildcard
 * @param pfnPreShellCallback
 * @param pfnPostShellCallback
 * @param pData
 * @param IndexHTab
 * @param RunAsynchronous
 * @param pid1
 * @param pid2
 * @param StatusOutputFilename
 * @param UpdateOutputFilename
 * 
 * @return int
 */
int _SVCGetVerboseFileInfo(_str path,typeless (&Files)[],_str &module_name,
                           boolean recurse=true,_str run_from_path='',
                           boolean treat_as_wildcard=true,
                           typeless *pfnPreShellCallback=null,
                           typeless *pfnPostShellCallback=null,
                           typeless *pData=null,
                           int (&IndexHTab):[]=null,
                           boolean RunAsynchronous=false,
                           int &pid1=-1,
                           int &pid2=-1,
                           _str &StatusOutputFilename='',
                           _str &UpdateOutputFilename=''
                           )
{
   int index=_SVCGetIndex(_GetVCSystemName(),"GetVerboseFileInfo");
   if ( !index ) {
      return(COMMAND_NOT_FOUND_RC);
   }
   int status=call_index(path,Files,module_name,recurse,run_from_path,
                         treat_as_wildcard,pfnPreShellCallback,pfnPostShellCallback,
                         pData,IndexHTab,RunAsynchronous,
                         pid1,pid2,StatusOutputFilename,UpdateOutputFilename,index);
                           
   return(status);
}

int _SVCUpdate(_str filelist[],_str &OutputFilename='',
               boolean append_to_output=false,typeless (*pFiles)[]=null,
               boolean &updated_new_dir=false,_str UpdateOptions='',
               int gaugeParent=0)
{
   int index=_SVCGetIndex(_GetVCSystemName(),"Update");
   if ( !index ) {
      return(COMMAND_NOT_FOUND_RC);
   }
   int status=call_index(filelist,OutputFilename,append_to_output,pFiles,
                         updated_new_dir,UpdateOptions,gaugeParent,index);
                           
   return(status);
}

static _str getSystemPrefix(_str filename)
{
   _str system_name="";
   if ( filename=="" ) {
      system_name=_GetVCSystemName();
      system_name=lowcase(system_name);
      if ( system_name=='subversion' ) system_name='svn';
   }else{
      filePath := _file_path(filename);
      svnDir := filePath:+".svn":+FILESEP:+".";
      cvsDir := filePath:+"CVS":+FILESEP:+".";
      if ( file_exists(svnDir) ) {
         system_name = "svn";
      }else if ( file_exists(cvsDir) ) {
         system_name = "cvs";
      }
   }
   return system_name;
}

/**
 * Finds a function for the specified system.  Uses a lowcased version of 
 * system_name.  Then looks for '_':+system_name:+'_':+function_suffix
 * 
 * @param system_name if '', use get value from _GetVCSystem() and convert, we
 *                    use "svn" as a prefix instead of subversion
 */
int _SVCGetProcIndex(_str function_suffix,_str system_name='',_str filename="")
{
   if ( system_name=='' ) {
      system_name=getSystemPrefix(filename);
   }
   _str funcname='_':+system_name:+'_':+function_suffix;
   int index=find_index(funcname,PROC_TYPE);
   return(index);
}
/**
 * Finds a command for the specified system.  Uses a lowcased version of
 * system_name.  Then looks for system_name:+'_':+function_suffix
 * 
 * @param function_suffix
 *               Suffix for funciton, for example to find "svn_history", use "history"
 * @param system_name
 *               if '', use get value from _GetVCSystem() and convert, we
 *               use "svn" as a prefix instead of subversion
 * @param filename 
 *               filename that the command will be run on 
 * 
 * @return Index to command if found, else 0
 */
int _SVCGetCommandIndex(_str function_suffix,_str system_name='',_str filename="")
{
   // If we have a filename that we are working with, check to see what this
   // directory was checked out from
   if ( filename!="" ) {
         system_name =getSystemPrefix(filename);
      }

   if ( system_name=="" ) {
      if ( system_name=='' ) {
         system_name=_GetVCSystemName();
         system_name=lowcase(system_name);
      }
      if ( lowcase(system_name)=='subversion' ) system_name='svn';
   }
   _str funcname=system_name:+'_':+function_suffix;
   int index=find_index(funcname,COMMAND_TYPE);
   return(index);
}

int _SVCRemove(_str filelist[],_str &OutputFilename='',
               boolean append_to_output=false,CVS_LOG_INFO (*pFiles)[]=null,
               boolean &updated_new_dir=false,
               _str remove_options='')
{
   int index=_SVCGetIndex(_GetVCSystemName(),"Remove");
   if ( !index ) {
      return(COMMAND_NOT_FOUND_RC);
   }
   int status=call_index(filelist,OutputFilename,append_to_output,pFiles,
                         updated_new_dir,remove_options,index);
                           
   return(status);
}
/**
 * Dialog that prompts the user for the username and the password
 */
defeventtab _svc_auth_form;

#define SVC_AUTH_INFO_INDEX 0

void ctlok.on_create(SVC_AUTHENTICATE_INFO *pinfo)
{
   pinfo->password=null;
   pinfo->username=null;
   _SetDialogInfo(SVC_AUTH_INFO_INDEX,pinfo);
}

int ctlok.lbutton_up()
{
   SVC_AUTHENTICATE_INFO *pinfo=_GetDialogInfo(SVC_AUTH_INFO_INDEX);
   _SetDialogInfo(SVC_AUTH_INFO_INDEX,null);
   pinfo->password=ctlpassword.p_text;
   pinfo->username=ctluser_name.p_text;
   p_active_form._delete_window(0);
   return(0);
}

/**
 * 
 * @param pinfo pointer to SVC_AUTHENTICATE_INFO struct that has the user name
 *              and password
 * 
 * @return int returns 0 if successful
 */
int _SVCGetAuthInfo(SVC_AUTHENTICATE_INFO *pinfo)
{
   int status=show('-modal _svc_auth_form',pinfo);
   return(status);
}

static int _SVCCallCommand(_str command_suffix,_str filename)
{
   int index=_SVCGetCommandIndex(command_suffix);
   if ( !index ) {
      return(COMMAND_NOT_FOUND_RC);
   }
   int status=0;
   status=call_index(filename,index);
   return(status);
}

/**
 * Runs the history command for a specialized version control system
 */
int _SVCCommit_command(_str filename='',_str comment=NULL_COMMENT)
{
   int index=_SVCGetCommandIndex('commit');
   if ( !index ) {
      return(COMMAND_NOT_FOUND_RC);
   }
   int status=0;
   status=call_index(filename,comment,index);
   return(status);
}

/**
 * Runs the update command for a specialized version control system
 */
int _SVCUpdate_command(_str filename='')
{
   int status=_SVCCallCommand("update",filename);
   return(status);
}

/**
 * Runs the add command for a specialized version control system
 */
int _SVCAdd_command(_str filename='')
{
   int status=_SVCCallCommand("add",filename);
   return(status);
}

/**
 * Runs the history command for a specialized version control system
 */
int _SVCHistory_command(_str filename='')
{
   int status=_SVCCallCommand("history",filename);
   return(status);
}

/**
 * Runs the diff_with_tip command for a specialized version control system
 */
int _SVCDiffWithTip_command(_str filename='')
{
   int status=_SVCCallCommand("diff_with_tip",filename);
   return(status);
}

/**
 * Runs the diff_with_tip command for a specialized version control system
 */
int _SVCRemove_command(_str filename='')
{
   int status=_SVCCallCommand("remove",filename);
   return(status);
}

_str _SVCGetEXEName()
{
   exeName := "";
   switch (upcase(def_vc_system)) {
   case "CVS":
      exeName = def_cvs_info.cvs_exe_name;
      break;
   case "SUBVERSION":
      exeName = def_svn_info.svn_exe_name;
      break;
   }
   return exeName;
}

/**
 * @param dataToWrite Data to write to log file
 * @param writeToScreen If true, also write <B>dataToWrite</B> 
 *                      to the say window
 * @return int 0 if successful
 */
void _SVCLog(_str dataToWrite,boolean writeToScreen=true)
{
   dsay(dataToWrite, VERSION_CONTROL_LOG);
   if ( writeToScreen ) {
      say(dataToWrite);
   }
}

/** 
 * @param StdErrData stderr output from a specialized version control system
 * 
 * @return boolean true if <B>StdErrData</B> contains a string that indicates that 
 * the user needs to be prompted for login info 
 */
boolean _SVCNeedAuthenticationError(_str StdErrData)
{
   int index=_SVCGetIndex(_GetVCSystemName(),"NeedAuthenticationError");
   if ( !index ) {
      return false;
   }
   boolean status=call_index(StdErrData,index);
                           
   return(status);
}

_command void svc_history(_str filename=p_buf_name) name_info(',')
{
   index := _SVCGetCommandIndex("history",def_vc_system,filename);
   if ( index ) {
      call_index(filename,index);
   }
}

_command void svc_diff_with_tip(_str filename=p_buf_name) name_info(',')
{
   index := _SVCGetCommandIndex("diff_with_tip",def_vc_system,filename);
   if ( index ) {
      call_index(filename,index);
   }
}

static _str svc_get_system(_str filename)
{
   filePath := _file_path(filename);
   svnDir := filePath:+".svn":+FILESEP:+".";
   cvsDir := filePath:+"CVS":+FILESEP:+".";
   system_name := "";
   if ( file_exists(svnDir) ) {
      system_name = "svn";
   }else if ( file_exists(cvsDir) ) {
      system_name = "cvs";
   }
   return system_name;
}

//boolean svc_file_is_up_to_date(_str filename)
//{
//   // Default to true because if FileIsUpToDate is not supported, we don't want 
//   // to try to update
//   rv := true;
//
//   do {
//      index := _SVCGetProcIndex("FileIsUpToDate","",filename);
//      say('svc_file_is_up_to_date index='index);
//      if ( !index ) break;
//      rv = call_index(filename,index);
//   } while ( false );
//
//   return rv;
//}
//
//void _buffer_add_maybe_update(int newBufID, _str filename, int flags = 0)
//{
//   say('_buffer_add_maybe_update in');
//   isUpToDate := svc_file_is_up_to_date(filename);
//}

#if 0
_command int svc_annotate(_str filename="") name_info(',')
{
   if ( filename=="" ) {
      if (_no_child_windows()) {
         _str result=_OpenDialog('-modal',
                                 'Select file to annotate',// Dialog Box Title
                                 '',                   // Initial Wild Cards
                                 def_file_types,       // File Type List
                                 OFN_FILEMUSTEXIST,
                                 '',
                                 ''
                                );
         if ( result=='' ) return(COMMAND_CANCELLED_RC);
         filename=result;
      } else {
         filename=p_buf_name;
      }
   }
   int status=svcAnnotateEnqueueBuffer(filename,def_vc_system);
   return status;
}

static int gAnnotateTimerHandle=-1;
static SVC_FILE_INFO gFileInfo:[];
static SVC_QUEUE_ITEM gAnnotationQueue[];

definit()
{
   gFileInfo=null;
}

static void svcAnnotateCallback()
{
   _kill_timer(gAnnotateTimerHandle);
   gAnnotateTimerHandle=-1;

   SVC_QUEUE_ITEM newlyCompletedFiles[];

   int i,len=gAnnotationQueue._length();
   for (i=0;i<len;++i) {
      _str fileIndex=_file_case(gAnnotationQueue[i].filename);
      SVC_ANNOTATION annotationInfo[];
      int status=_SVCGetFileAnnotations(gAnnotationQueue[i].VCSystem,gAnnotationQueue[i].filename,annotationInfo);
      if (!status) {
         gFileInfo:[fileIndex].annotations=annotationInfo;
         newlyCompletedFiles[newlyCompletedFiles._length()]=gAnnotationQueue[i];
         gAnnotationQueue._deleteel(i);
         --i;--len;
      }
   }

   if ( gAnnotationQueue._length() ) {
      gAnnotateTimerHandle=_set_timer(1000,svcAnnotateCallback);
   }else{
      len=newlyCompletedFiles._length();
      for (i=0;i<len;++i) {
         mou_hour_glass(1);
         svcAnnotateBuffer(newlyCompletedFiles[i]);
         mou_hour_glass(0);
      }
   }
}

int _CVS_unmark_buffer(int annotated_wid)
{
   int markid=_alloc_selection();
   if ( markid  >= 0 ) {
      int orig_wid=p_window_id;
      p_window_id=annotated_wid;

      top();p_col=1;
      _select_block(markid);

      bottom();p_col=35;
      _select_block(markid);

      _delete_selection(markid);

      _free_selection(markid);

      p_window_id=orig_wid;
   }
   return markid  >= 0 ? 0:markid;
}

#define USE_STREAM_MARKER 1

static int svcAnnotateBuffer(SVC_QUEUE_ITEM file)
{
   int status=0;
   _str fileIndex=_file_case(file.filename);
   int annotatedPicIndex=find_index('_arrowgt.ico');
   int modifiedPicIndex=find_index('_breakpt.ico');

   do {
      _str bufname=buf_match(file.filename,1);
      if ( bufname=="" ) {
         status=FILE_NOT_FOUND_RC;break;
      }

      int orig_wid=p_window_id,annotated_wid;
      _SVCGetAnnotatedBuffer(file.VCSystem,file.filename,annotated_wid);
   
      int index=_SVCGetIndex(file.VCSystem,"_unmark_buffer");
      if ( !index ) {
         status=PROCEDURE_NOT_FOUND_RC;break;
      }
      status=call_index(annotated_wid,index);
      if ( status ) break;

      long seekPositions[];
      int localfile_wid;
      status=_open_temp_view(bufname,localfile_wid,orig_wid,"+b");
      p_view_id=orig_wid;
      if ( status ) break;

      _GetLineSeekPositions(localfile_wid,seekPositions);
      Diff(annotated_wid,localfile_wid,
           DIFF_NO_BUFFER_SETUP|DIFF_DONT_COMPARE_EOL_CHARS|DIFF_DONT_MATCH_NONMATCHING_LINES,
           0,0,0,
           def_load_options,0,0,def_max_fast_diff_size,"","",def_smart_diff_limit,"");

      int vector[];
      _DiffGetMatchVector(vector);
      int len=vector._length();
      int i;

      p_view_id=localfile_wid;

      int markerType=_MarkerTypeAlloc();
      _MarkerTypeSetFlags(markerType,VSMARKERTYPEFLAG_AUTO_REMOVE);
      gFileInfo:[fileIndex].annotationMarkerType=markerType;

      int annotated:[];
      for (i=0;i<len;++i) {
         if ( vector[i] ) {
            _str msg=gFileInfo:[fileIndex].annotations[i].date;
            msg=msg:+",":+gFileInfo:[fileIndex].annotations[i].userid;
            msg=msg:+",":+gFileInfo:[fileIndex].annotations[i].version;
            _StreamMarkerAdd(localfile_wid,seekPositions[vector[i]],1,1,annotatedPicIndex,markerType,msg);
            annotated:[vector[i]]=1;
         }
      }

      _str userName="";
      #if __UNIX__
      userName=get_env("USER");
      #else 
      userName=get_env("USERNAME");
      #endif 
      for (i=1;i<=p_Noflines;++i) {
         if ( annotated:[i]==null ) {
            _StreamMarkerAdd(localfile_wid,seekPositions[i],1,1,modifiedPicIndex,markerType,"Local modification");
         }
      }

      _delete_temp_view(localfile_wid);
      _delete_temp_view(annotated_wid);
      p_view_id=orig_wid;


   } while ( false );

   _SVCFreeAnnotationInfo(file.VCSystem,file.filename);
   refresh('A');
   return status;
}

static int svcAnnotateEnqueueBuffer(_str filename,_str VCSystemName=def_vc_system)
{
   int status=0;
   do {
      status=_SVCCreateVCI(VCSystemName,'c:\cygwin\bin\cvs.exe');
      if ( status ) {
         return status;
      }
      _str fileIndex=_file_case(filename);
      _SVCFreeAnnotationInfo(VCSystemName,fileIndex);
      if ( gFileInfo:[fileIndex]!=null ) {
         _StreamMarkerRemoveAllType(gFileInfo:[fileIndex].annotationMarkerType);
      }
      int fileid=0;
      if ( gFileInfo:[fileIndex]!=null ) {
         gFileInfo:[fileIndex].annotationMarkerType=0;
         gFileInfo:[fileIndex].annotations=null;
      }
      status=_SVCGetFile(VCSystemName,filename,fileid);
      if ( status==SVC_FILE_NOT_FOUND_RC ) {
         status=_SVCGetNewFile(VCSystemName,filename,fileid);
         if (status) break;
      }

      _SVCNewAnnotationInfo(VCSystemName,filename);
      SVC_ANNOTATION fileAnnotations[];
      status=_SVCGetFileAnnotations(VCSystemName,filename,fileAnnotations);
      if (!status) {
         gFileInfo:[fileIndex].annotations=fileAnnotations;
         gFileInfo:[fileIndex].annotationMarkerType=-1;
      }else{
         _SVCAnnotationQueueAppend(filename,VCSystemName);
         if ( gAnnotateTimerHandle<0 ) {
            gAnnotateTimerHandle=_set_timer(1000,svcAnnotateCallback);
         }
      }
   
   } while ( false );
   return status;
}
static void _SVCAnnotationQueueAppend(_str filename,_str VCSystemName)
{
   SVC_QUEUE_ITEM item;
   item.filename=filename;
   item.VCSystem=VCSystemName;

   gAnnotationQueue[gAnnotationQueue._length()]=item;
}

static _str svc_get_message(int status)
{
   switch (status) {
   case SVC_COULD_NOT_GET_VC_INTERFACE_RC:
      return "SVC_COULD_NOT_GET_VC_INTERFACE_RC";
   case SVC_VC_INTERFACE_NOT_AVAILABLE_RC:
      return "SVC_VC_INTERFACE_NOT_AVAILABLE_RC";
   case SVC_COULD_NOT_GET_VC_FILE_INTERFACE_RC:
      return "SVC_COULD_NOT_GET_VC_FILE_INTERFACE_RC";
   case SVC_FILE_INTERFACE_NOT_AVAILABLE_RC:
      return "SVC_FILE_INTERFACE_NOT_AVAILABLE_RC";
   case SVC_FILE_NOT_FOUND_RC:
      return "SVC_FILE_NOT_FOUND_RC";
   default:
      return get_message(status);
   }
}
#endif
