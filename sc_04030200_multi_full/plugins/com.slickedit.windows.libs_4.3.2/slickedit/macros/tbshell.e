////////////////////////////////////////////////////////////////////////////////////
// $Revision: 38654 $
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
#import "stdcmds.e"
#import "stdprocs.e"
#import "toolbar.e"
#endregion

defeventtab _tbshell_form;

static void resizeShell()
{
   int clientW = _dx2lx(p_active_form.p_xyscale_mode,p_active_form.p_client_width);
   int clientH = _dy2ly(p_active_form.p_xyscale_mode,p_active_form.p_client_height);

   _shellEditor.p_width = clientW - 2 * _shellEditor.p_x;
   _shellEditor.p_height = clientH - _shellEditor.p_y - _shellEditor.p_x;
}

void _tbshell_form.on_resize()
{
   resizeShell();
}


// Desc:  Need to handle this event here because anywhere else on the
//     tab control or form will kill existing handlers.
static void connectExistingProcessBuffer()
{
   // If the Shell output tab is the active tab, look for the
   // build window and use it:
   if (p_buf_name == ".process") return;
   //parse buf_match('.process','vhx') with buf_id name;

   int oriBufId;
   oriBufId = p_buf_id;
   for (;;) {
      if (p_buf_name == ".process") {
         // Reuse existing .process buffer and delete the one that was create
         // with the editor control:
         //say( "Found and reuse existing .process" );
         int tempId;
         tempId = p_buf_id;
         p_buf_id = oriBufId;
         //close_buffer();
         _delete_buffer();
         p_buf_id = tempId;

         bottom();
         break;
      }
      _next_buffer( "HR" );
      if (p_buf_id == oriBufId) {
         p_buf_name=".process";
         _SetEditorLanguage();
         p_undo_steps=0;
         break;
      }
   }
}

void _shellEditor.'ENTER'()
{
   if (_process_info('B')) {
      process_enter();
      return;
   }
   if (_shellEditor.p_line != _shellEditor.p_Noflines) {
      process_enter();
      //bottom();
      return;
   }
   _str line;
   _shellEditor.get_line(line);
   if (line == "") return;

   // Start the concur process buffer and queue the command:
   start_process_tab();
   if ( _process_info() ) {
      int orig_wid=p_window_id;
      int temp_view_id=0;
      int orig_view_id=0;
      int status=_open_temp_view('.process',temp_view_id,orig_view_id,'+b');
      if (!status) {
         _str command=line;
         bottom();
         get_line(line);
         if ( _process_info('c') ) {
            line=expand_tabs(_rawText(line),1,_process_info('c')-1,'S');
         } else {
            line='';
         }
         replace_line(line:+command);
         insert_line("");
         refresh();
         _delete_temp_view(temp_view_id,0);
         p_window_id=orig_wid;
      }
   }
}

void _shellEditor.'TAB'()
{
   process_tab();
}

void _shellEditor.on_create()
{
   connectExistingProcessBuffer();
   p_MouseActivate = MA_NOACTIVATE;
}

void _tbshell_form.on_destroy()
{
   // Call user-level2 ON_DESTROY so that tool window docking info is saved
   call_event(p_window_id,ON_DESTROY,'2');
}

void toolShellConnectProcess()
{
   int formwid = _tbIsVisible("_tbshell_form");
   if( formwid==0 ) {
      return;
   }
   int shellEditWid = formwid._find_control("_shellEditor");
   shellEditWid.connectExistingProcessBuffer();
}

int toolShowShell()
{
   int formwid = activate_toolbar("_tbshell_form","");
   if( formwid>0 ) {
      return (formwid._find_control("_shellEditor"));
   }
   return 0;
}
