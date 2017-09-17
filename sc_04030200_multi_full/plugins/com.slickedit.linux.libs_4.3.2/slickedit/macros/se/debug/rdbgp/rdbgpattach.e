////////////////////////////////////////////////////////////////////////////////////
// $Revision:  $
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
#include "se/debug/rdbgp/rdbgpattach.sh"
#include "vsockapi.sh"
#import "se/debug/rdbgp/rdbgp.e"
#import "se/debug/rdbgp/rdbgputil.e"
#import "se/debug/dbgp/dbgputil.e"
#import "debug.e"
#import "debuggui.e"
#import "listbox.e"
#import "main.e"
#import "stdprocs.e"
#endregion

namespace se.debug.rdbgp;

/**
 * Start actively listening for connection from rdbgp. The user
 * is prompted for host:port settings. 
 * 
 * @return 0 on success, <0 on error.
 */
_command int rdbgp_attach()
{
   if( debug_active() ) {
      _str msg = "Already debugging.";
      _message_box(msg,"",MB_OK|MB_ICONEXCLAMATION);
      return 0;
   }

   // Fire up the rdbgp Attach dialog which will prompt for host:port
   // parameters and accept a rdbgp connection.
   _str attach_info = show("-modal _debug_rdbgp_remote_form");
   if( attach_info == "" ) {
      // User cancelled
      return COMMAND_CANCELLED_RC;
   }
   _str fileuri = "";
   _str debugger_args = "";
   _str session_name = "";
   parse attach_info with 'file='fileuri ',' . ',' 'path=' . ',' 'debugger_args='debugger_args",session="session_name;
   int status = debug_remote("rdbgp",attach_info,session_name);
   if( status != 0 ) {
      // Clean up
      typeless socket = INVALID_SOCKET;
      parse debugger_args with . '-socket='socket .;
      if( isinteger(socket) && socket >= 0 ) {
         vssSocketClose((int)socket);
      }
   }
   return status;
}


namespace default;

using namespace se.debug.rdbgp;
using namespace se.net;

//
// _debug_rdbgp_remote_form
//

defeventtab _debug_rdbgp_remote_form;

void _debug_rdbgp_remote_form.'!'(se.net.ServerConnection* server=null, se.net.SERVER_CONNECTION_STATUS status=SCS_NONE)
{
   if( !server ) {
      // User hit '!' in the form, so ignore it
      return;
   }

   switch( status ) {
   case SCS_LISTEN:
      int timeout = server->getTimeout();
      int elapsed = server->getElapsedTime();
      int remain = 0;
      if( timeout < 0 ) {
         // Infinite
         remain = elapsed;
      } else {
         remain = timeout - elapsed;
      }
      if( remain < 0 ) {
         remain = 0;
      }
      // Seconds please
      remain = remain intdiv 1000;
      // The actual host:port we are listening on
      _str host = server->getHost(true);
      _str port = server->getPort(true);
      ctl_status_label.p_caption = nls("Listening for a connection on %s:%s...%s",host,port,remain);
      break;
   case SCS_PENDING:
      ctl_status_label.p_caption = "A connection is pending.";
      break;
   case SCS_ERROR:
      int error_rc = server->getError();
      ctl_status_label.p_caption = nls("Error listening for connection. %s",get_message(error_rc));
      break;
   }
}

static void onResizeSessionFrame()
{
   int childW = ctl_session_frame.p_width;
   int childH = ctl_session_frame.p_height;

   ctl_session_combo.p_width = childW - ctl_session_label.p_x - ctl_session_combo.p_x;
}

static void onResizeStatusFrame()
{
   int childW = ctl_status_frame.p_width;
   int childH = ctl_status_frame.p_height;

   ctl_status_label.p_width = childW - ctl_status_label.p_x - 180;
}

static void onResizeServerFrame()
{
   int childW = ctl_server_frame.p_width;
   int childH = ctl_server_frame.p_height;

   ctl_server_host.p_width = childW - ctl_server_host.p_x - 180;
   ctl_server_port.p_width = ctl_server_host.p_width;
}

static void onResizeServerSettingsFrame()
{
   int childW = ctl_settings_frame.p_width;
   int childH = ctl_settings_frame.p_height;

   // ctl_server frame
   ctl_server_frame.p_width = childW - 2*ctl_server_frame.p_x;
   ctl_server_frame.p_y = childH - ctl_server_frame.p_height - 180;
   onResizeServerFrame();

   // ctl_note
   ctl_note.p_width = childW - ctl_note.p_x - 180;
   ctl_note.p_height = childH - ctl_note.p_y - 180 - ctl_server_frame.p_height;
}

#define RDBGP_ATTACH_FORM_MINWIDTH 8640
#define RDBGP_ATTACH_FORM_MINHEIGHT 7665

void _debug_rdbgp_remote_form.on_resize()
{
   // Enforce sanity on size
   // if the minimum width has not been set, it will return 0
   if (!_minimum_width()) {
      _set_minimum_size(RDBGP_ATTACH_FORM_MINWIDTH, RDBGP_ATTACH_FORM_MINHEIGHT);
   }

   int formW = _dx2lx(SM_TWIP,p_active_form.p_client_width);
   int formH = _dy2ly(SM_TWIP,p_active_form.p_client_height);

   // Listen, Cancel buttons
   ctl_listen.p_y = formH - ctl_listen.p_height - 180;
   ctl_cancel.p_y = ctl_listen.p_y;

   // Session frame
   ctl_session_frame.p_width = formW - ctl_session_frame.p_x - 180;
   ctl_session_frame.p_y = ctl_listen.p_y - 180 - ctl_session_frame.p_height;
   ctl_session_frame.onResizeSessionFrame();

   // Status frame
   ctl_status_frame.p_width = formW - ctl_status_frame.p_x - 180;
   ctl_status_frame.p_y = ctl_listen.p_y - 180 - ctl_status_frame.p_height - 180 - ctl_session_frame.p_height;
   ctl_status_frame.onResizeStatusFrame();

   // Server settings frame
   ctl_settings_frame.p_width = formW - ctl_settings_frame.p_x - 180;
   ctl_settings_frame.p_height = formH - ctl_settings_frame.p_y  - 180 - ctl_session_frame.p_height- 180 - ctl_status_frame.p_height - 180 - ctl_listen.p_height - 180;
   ctl_settings_frame.onResizeServerSettingsFrame();
}

/**
 * @param settings_only  If set to true then only settings
 *                        are returned without starting up a
 *                        listener.
 */
void ctl_listen.on_create(boolean settings_only=false)
{
   // get all the available debugger sessions
   _str session_name = "";
   max_width := ctl_session_combo.debug_load_session_names("rdbgp", session_name);
   if (session_name == "") session_name = ctl_session_combo.p_text;

   // If set to true then only settings are returned without starting up a
   // listener - _param1=host, _param2=port.
   _SetDialogInfoHt("settings_only",settings_only);

   ctl_server_host.p_text = ctl_server_host._retrieve_value();
   ctl_server_port.p_text = ctl_server_port._retrieve_value();
   ctl_status_label.p_caption = "";
   ctl_note.p_text = RDBGP_ATTACH_NOTE;
   // Dialog color
   ctl_note.p_backcolor = 0x80000022;

   // select the default session name
   if (session_name != "") {
      ctl_session_combo._cbset_text(session_name);
   } else if (ctl_session_combo.p_text == "") {
      ctl_session_combo._cbset_text(VSDEBUG_NEW_SESSION);
   }
}

void ctl_listen.lbutton_up()
{
   _str host = ctl_server_host.p_text;
   if( host == "" ) {
      _str msg = "Invalid host.";
      _message_box(msg,"",MB_OK|MB_ICONEXCLAMATION);
      p_window_id = ctl_server_host;
      _set_sel(1,length(p_text)+1);
      _set_focus();
      return;
   }
   _str port = ctl_server_port.p_text;
   if( port == "" ) {
      _str msg = "Invalid port.";
      _message_box(msg,"",MB_OK|MB_ICONEXCLAMATION);
      p_window_id = ctl_server_port;
      _set_sel(1,length(p_text)+1);
      _set_focus();
      return;
   }

   ctl_server_host._append_retrieve(ctl_server_host,ctl_server_host.p_text);
   ctl_server_port._append_retrieve(ctl_server_port,ctl_server_port.p_text);

   boolean settings_only = (0 != _GetDialogInfoHt("settings_only"));
   if( settings_only ) {
      _param1 = host;
      _param2 = port;
      p_active_form._delete_window(0);
      return;
   }
   int timeout = 1000*def_debug_timeout;
   se.net.ServerConnectionObserverFormInstance dlg(p_active_form);
   int status_or_socket = rdbgp_wait_and_accept(host,port,timeout,&dlg,true);
   if( status_or_socket < 0 ) {
      // Error
      if( status_or_socket != COMMAND_CANCELLED_RC ) {
         _str msg = nls("Failed to accept a connection. %s",get_message(status_or_socket));
         _message_box(msg,"",MB_OK|MB_ICONEXCLAMATION);
         p_active_form._delete_window("");
      } else {
         // COMMAND_CANCELLED_RC - the form is already gone, so this comment
         // is coming to you from beyond the grave.
      }
      return;
   }

   // Peek for the <init> packet so we can give this session a good name
   int handle = rdbgp_peek_packet(status_or_socket);
   if( handle < 0 ) {
      // Error
      _str msg = nls("Could not parse <init> packet. %s",handle);
      _message_box(msg,"",MB_OK|MB_ICONEXCLAMATION);
      vssSocketClose(status_or_socket);
      p_active_form._delete_window("");
      return;
   }
   int node = _xmlcfg_find_simple(handle,"/init");
   // <init ... fileuri="file:///C:/inetpub/wwwroot/index.php" ...>...</init>
   _str fileuri = _xmlcfg_get_attribute(handle,node,"fileuri","UNKNOWN");
   _xmlcfg_close(handle);

   // Debugger arguments
   _str debugger_args = '-socket='status_or_socket' -step-into';
   // DBGp features
   RdbgpOptions rdbgp_opts;
   rdbgp_make_default_options(rdbgp_opts);
   debugger_args = debugger_args' 'se.debug.dbgp.dbgp_make_debugger_args(rdbgp_opts.dbgp_features);

   // get the session name
   _str session_name = ctl_session_combo.p_text;
   
   _str attach_info = 'file='fileuri',,path=,args='debugger_args",session="session_name;
   p_active_form._delete_window(attach_info);
}

void ctl_cancel.lbutton_up()
{
   se.net.ServerConnectionObserverFormInstance* pobserver = _GetDialogInfoHt("ServerConnectionObserverFormInstance");
   if( pobserver ) {
      pobserver->onCancel();
   }
   p_active_form._delete_window("");
}
