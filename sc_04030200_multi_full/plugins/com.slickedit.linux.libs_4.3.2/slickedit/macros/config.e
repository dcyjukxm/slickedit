////////////////////////////////////////////////////////////////////////////////////
// $Revision: 62120 $
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
#include "search.sh"
#include "vsockapi.sh"
#import "clipbd.e"
#import "color.e"
#import "complete.e"
#import "eclipse.e"
#import "ex.e"
#import "fileman.e"
#import "guifind.e"
#import "guiopen.e"
#import "mouse.e"
#import "main.e"
#import "math.e"
#import "keybindings.e"
#import "options.e"
#import "optionsxml.e"
#import "pmatch.e"
#import "pushtag.e"
#import "recmacro.e"
#import "search.e"
#import "sellist.e"
#import "stdcmds.e"
#import "stdprocs.e"
#import "tagform.e"
#import "window.e"
#import "dlgman.e"
#endregion

/**
 * Draw box around current line options 
 * @see _default_option
 */
 enum VSCurrentLineBoxOptions {
    VSCURRENT_LINE_BOXFOCUS_NONE     = 0,    // no box
    VSCURRENT_LINE_BOXFOCUS_ONLY     = 1,    // only the box, no ruler
    VSCURRENT_LINE_BOXFOCUS_TABS     = 2,    // tabs ruler
    VSCURRENT_LINE_BOXFOCUS_INDENT   = 3,    // syntax indent ruler
    VSCURRENT_LINE_BOXFOCUS_DECIMAL  = 4,    // decimal ruler
    VSCURRENT_LINE_BOXFOCUS_COBOL    = 5,    // cobol ruler
 };

#define MAXSPECIALCHARS 7

 enum_flags VSShowSpecialChars {
    SHOWSPECIALCHARS_NLCHARS    = 0x01,
    SHOWSPECIALCHARS_TABS       = 0x02,
    SHOWSPECIALCHARS_SPACES     = 0x04,
    SHOWSPECIALCHARS_EOF        = 0x08,
    SHOWSPECIALCHARS_FORMFEED   = 0x10,
    SHOWSPECIALCHARS_ALL        = 0xff,
 };

enum SpecialCharacters{
   SC_END_OF_LINE_1  = 1,
   SC_END_OF_LINE_2  = 2,
   SC_TAB            = 3,
   SC_SPACE          = 4,
   SC_VIRTUAL_SPACE  = 5,
   SC_END_OF_FILE    = 6,
   SC_FORM_FEED      = 7,
};
 
static _str _ignore_change=0;
static _str _special_char_option='D';
static _str _default_special_chars='';

_str _cua_textbox(_str cua = '')
{
   // if default value is used, we return current value
   if (cua == '') {
      cua = (int)(def_cua_textbox != 0);
   } else {
      def_cua_textbox = cua;
      _macro_append("def_cua_textbox="def_cua_textbox";");
   
      int cb_index=find_index('_ul2_combobx',EVENTTAB_TYPE);
      int tb_index=find_index('_ul2_textbox',EVENTTAB_TYPE);
      if (cua) {
         int tb2=find_index('_ul2_textbox2',EVENTTAB_TYPE);
         if (cb_index) eventtab_inherit(cb_index,tb2);
         if (tb_index) eventtab_inherit(tb_index,tb2);
      } else {
         if (cb_index) eventtab_inherit(cb_index,0);
         if (tb_index) eventtab_inherit(tb_index,0);
         _cmdline.p_eventtab=0;
      }
   }

   return cua;
}

#if 0
/*List Configuration and Forms Button Section*/
defeventtab _listforms_form;
_ok.lbutton_up()
{
   // Return booleans separated by space  "<usersys> <user>"
   result=_modifiedsys_forms.p_value' '_userforms.p_value;
   p_active_form._delete_window(result);//_listforms_form
}

#endif

defeventtab _emulation_form;

#region Options Dialog Helper Functions

void _emulation_form_init_for_options()
{
   _ctlemu_ok.p_user = p_active_form;

   _ctlemu_ok.p_visible = false;
   _ctlcancel.p_visible = false;
   _ctlhelp.p_visible = false;

   // get the options purpose to determine whether to show our button
   form := getOptionsFormFromEmbeddedDialog();
   purpose := _GetDialogInfoHt(PURPOSE, form);
   if (purpose == OP_QUICK_START) {
      _btn_restore.p_visible = false;

      heightDiff := _btn_restore.p_y - ctldescription.p_y;
      ctldescription.p_y += heightDiff;
      _ctl_customize_emulation_link.p_y += heightDiff;
      _ctl_customize_emulation_link.p_visible = true;
   } 
}

boolean _emulation_form_validate(int action)
{
   _str new_keys, emu;
   getKeysAndEmulation(new_keys, emu);

   if (def_keys != new_keys) {

      se.options.OptionsConfigTree * optionsConfigTree = _GetDialogInfoHtPtr(OPTIONS, getOptionsForm());

      // we gotta do crazy stuff now
      typeless result=0;
      if (optionsConfigTree -> areOptionsModified(false)) {
         result = _message_box("All other changes must be applied before changing emulation.  Do you wish to ":+
                               "apply other changes before applying emulation change?\n        Select Yes to ":+
                               "apply other changes, then apply emulation change.\n        Select No to cancel ":+
                               "other changes and then apply emulation change.","", MB_YESNOCANCEL);
         if (result == IDCANCEL) {
            setupEmulation();
            return false;
         } else if (result == IDNO) {
            wid := p_window_id;        
            _emulation_form_apply();
            p_window_id = wid;

            // cancel all the other options
            optionsConfigTree -> cancel();
            p_window_id = wid;

         } else if (result == IDYES) {
            wid := p_window_id;
            // apply the other changes
            // give focus to options form
            p_window_id = getOptionsFormFromEmbeddedDialog();
            optionsConfigTree -> apply(true, false);
            p_window_id = wid;
            _emulation_form_apply();
            p_window_id = wid;
         }
      } else {
         // just apply it without worrying about the other stuff
         _emulation_form_apply();
      }

      // reload options - we need to catch all the changes that 
      // might have happened by changing the emulation
      optionsConfigTree -> reloadOptionsTree();
   }

   // return 0 - we can switch away from this panel
   return true;
}

void _emulation_form_restore_state()
{
   _btn_restore.p_enabled = false;

   // check to see if this emulation has any custom keybindings - if so, enable the RESTORE button
   boolean firstInit = _GetDialogInfoHt("firstInit", p_active_form, true);
   if (!firstInit) { 
      _str keys, emu;
      getKeysAndEmulation(keys, emu);
      if (hasSavedKeybindings(emu, keys)) {
         _btn_restore.p_enabled = true;
      } 
   }

   // this is really only for quick start
   form := getOptionsFormFromEmbeddedDialog();
   purpose := _GetDialogInfoHt(PURPOSE, form);
   if (purpose == OP_QUICK_START) {
      setupEmulation();
   }
}

void _emulation_form_apply()
{
   formWid := _ctlemu_ok.p_user;
   boolean firstInit = _GetDialogInfoHt("firstInit", formWid, true);

   _str set_emulation='';
   _str new_keys='';
   _str export_keys='1';
   _str import_keys='1';
   getKeysAndEmulation(new_keys, set_emulation);

   def_emulation_was_selected=true;
   if (def_keys == new_keys) {
      return;
   }

   // we always save the keybindings from the old emulation 
   // AND restore the keybindings from the new one
   switchEmulation(set_emulation, 1, 1);
   se.options.OptionsConfigTree * optionsConfigTree = _GetDialogInfoHtPtr(OPTIONS, getOptionsForm());
   if (optionsConfigTree) {
      optionsConfigTree -> markEmulationNodeInOptionsHistory();
   }
}

boolean _emulation_form_is_modified()
{
   return false;
}

#endregion Options Dialog Helper Functions

_ctlemu_ok.on_create(boolean firstInit = false)
{
   _ctl_customize_emulation_link.p_mouse_pointer = MP_HAND;
   _ctl_customize_emulation_link.p_visible = false;

   _ctlemu_ok.p_user = 0;
   _ctlemu_cua_windows.p_user=0;
   _ctlemu_cua_mac.p_user=0;
   _ctlemu_slickedit.p_user=0;
   _ctlemu_brief.p_user=0;
   _ctlemu_emacs.p_user=0;
   _ctlemu_vi.p_user=0;
   _ctlemu_gnu.p_user=0;
   _ctlemu_vcpp.p_user=0;
   _ctlemu_vsnet.p_user=0;
   _ctlemu_ispf.p_user=0;
   _ctlemu_codewarrior.p_user=0;
   _ctlemu_bbedit.p_user=0;
   _ctlemu_xcode.p_user=0;
   _ctlemu_eclipse.p_user=0;
   if (firstInit) _ctlcancel.p_enabled = false;
   _SetDialogInfoHt("firstInit", firstInit, p_active_form, true);

   setupEmulation();
   call_event(_ctlemu_cua_windows,LBUTTON_UP,'');
}

void _btn_restore.lbutton_up()
{
   _str keys = '', emulation = '';
   getKeysAndEmulation(keys, emulation);

   // delete the saved file
   fileName := longEmulationName(keys)'.user.xml';
   fileName = _ConfigPath() :+ 'keybindings' :+ FILESEP :+ fileName;
   delete_file(fileName);

   // if this is the current emulation, then we need to 
   // reset the current keybindings
   if (keys == def_keys) {
      resetEmulationKeyBindings();

      // reload the keybindings options
      se.options.OptionsTree * optionsTree = _GetDialogInfoHtPtr(OPTIONS, getOptionsForm());
      if (optionsTree) optionsTree -> reloadOptionsNode('Key Bindings');
   }

   _btn_restore.p_enabled = false;
}

void _ctl_customize_emulation_link.lbutton_up()
{
   origWid := p_window_id;

   boolean nextEnabled, prevEnabled;
   disableEnableNextPreviousOptionsButtons(true, nextEnabled, prevEnabled);

   optionsWid := config('Emulation', 'N');
   _modal_wait(optionsWid);

   p_window_id = origWid;

   disableEnableNextPreviousOptionsButtons(false, nextEnabled, prevEnabled);

   // we need to refresh this stuff in case they changed anything
   _emulation_form_restore_state();
}

static boolean hasSavedKeybindings(_str emulation, _str keys)
{
   // if this is the current emulation, we can check for keybindings 
   // that haven't been written yet
   if (keys == def_keys && isEmulationCustomized()) return true;

   // we also check to see if we've written any custom stuff
   importFileName := longEmulationName(keys)'.user.xml';
   importFileName = _ConfigPath() :+ 'keybindings' :+ FILESEP :+ importFileName;
   
   return file_exists(importFileName);
}

static void setupEmulation()
{
   switch (lowcase(def_keys)) {
   case '':
      _ctlemu_slickedit.p_value=1;
      break;
   case 'macosx-keys':
      _ctlemu_cua_mac.p_value=1;
      break;
   case 'windows-keys':
      _ctlemu_cua_windows.p_value=1;
      break;
   case 'brief-keys':
      _ctlemu_brief.p_value=1;
      break;
   case 'emacs-keys':
      _ctlemu_emacs.p_value=1;
      break;
   /* 4/18/94 HERE - add check for vi emulation */
   case 'vi-keys':
      _ctlemu_vi.p_value=1;
      break;
   /* add check for Gnu EMACS emulation */
   case 'gnuemacs-keys':
      _ctlemu_gnu.p_value=1;
      break;
   /* 2/9/1999 add check for Visual C++ emulation */
   case 'vcpp-keys':
      _ctlemu_vcpp.p_value=1;
      break;
   /* 10/26/2004 add check for Visual Studio .NET emulation */
   case 'vsnet-keys':
      _ctlemu_vsnet.p_value=1;
      break;
   /* 11-21-99 add check for ISPF emulation */
   case 'ispf-keys':
      _ctlemu_ispf.p_value=1;
      break;
   /* 08-10-2001 add check for CodeWarrior emulation */
   case 'codewarrior-keys':
      _ctlemu_codewarrior.p_value=1;
      break;
   case 'codewright-keys':
      _ctlemu_codewright.p_value=1;
      break;
   /* 08-12-2004 add check for BBEdit emulation */
   case 'bbedit-keys':
      _ctlemu_bbedit.p_value=1;
      break;
   /* 08-12-2004 add check for Xcode emulation */
   case 'xcode-keys':
      _ctlemu_xcode.p_value=1;
      break;
   case 'eclipse-keys':
      _ctlemu_eclipse.p_value=1;
   }
}

void switchEmulation(_str set_emulation, _str export_keys, _str import_keys) 
{
   _str macro='emulate';
   _str filename=get_env('VSROOT')'macros':+FILESEP:+(macro:+_macro_ext'x');
   if (filename=='') {
      filename=get_env('VSROOT')'macros':+FILESEP:+(macro:+_macro_ext);
   }
   if (filename=='') {
      _message_box("File '%s' not found",macro:+_macro_ext'x');
      return;
   }
   int orig_wid=p_window_id;
   p_window_id=_mdi.p_child;
   _macro('m',0);
   _no_mdi_bind_all=1;
   macro=maybe_quote_filename(macro);
   typeless status=shell(macro' 'set_emulation' 'export_keys' 'import_keys);
   _no_mdi_bind_all=0;
   _macro('m',_macro('s'));
   p_window_id=orig_wid;
   _macro_call('shell',macro' 'set_emulation);
   if (status) {
      _message_box(nls("Unable to set emulation.\n\nError probably caused by missing macro compiler or incorrect macro compiler version."));
      return;
   }
   /**
    * Unused as of 5/2/07 because we removed the native Eclipse 
    * emulation form for the SlickEdit form. 
    */
/*   if (isEclipsePlugin()) {
      eclipseChangeKeyConfiguration(set_emulation);
   }*/
}

/**
 * Returns the currently selected emulation and cooresponding 
 * key name. 
 * 
 * @param new_keys      emulation name
 * @param new_emu       key set for emulation
 */
void getKeysAndEmulation(_str &new_keys, _str &new_emu)
{
   if (_ctlemu_cua_windows.p_value) {
      new_emu='windows';
      new_keys="windows-keys";
   } else if (_ctlemu_cua_mac.p_value) {
      new_emu='macosx';
      new_keys="macosx-keys";
   } else if (_ctlemu_slickedit.p_value) {
      new_emu='slick';
      new_keys="";
   } else if (_ctlemu_brief.p_value) {
      new_emu='brief';
      new_keys="brief-keys";
   } else if (_ctlemu_emacs.p_value) {
      new_emu='emacs';
      new_keys="emacs-keys";
   } else if (_ctlemu_vi.p_value) {
      new_emu='vi';
      new_keys="vi-keys";
   } else if (_ctlemu_gnu.p_value) {
      new_emu='gnu';
      new_keys="gnuemacs-keys";
   } else if (_ctlemu_vcpp.p_value) {
      new_emu='vcpp';
      new_keys="vcpp-keys";
   } else if (_ctlemu_vsnet.p_value) {
      new_emu='vsnet';
      new_keys="vsnet-keys";
   } else if (_ctlemu_ispf.p_value) {
      new_emu='ispf';
      new_keys="ispf-keys";
   } else if (_ctlemu_codewarrior.p_value) {
      new_emu='codewarrior';
      new_keys="codewarrior-keys";
   } else if (_ctlemu_codewright.p_value) {
      new_emu='codewright';
      new_keys="codewright-keys";
   } else if (_ctlemu_bbedit.p_value) {
      new_emu='bbedit';
      new_keys="bbedit-keys";
   } else if (_ctlemu_xcode.p_value) {
      new_emu='xcode';
      new_keys="xcode-keys";
   } else if (_ctlemu_eclipse.p_value) {
      new_emu='eclipse';
      new_keys="eclipse-keys";
   }
}

_str getEmulationFromKeys(_str keys)
{
   emulation := '';
   switch (keys) {
   case "windows-keys":
      emulation = 'windows';
      break;
   case "macosx-keys":
      emulation = 'macosx';
      break;
   case "":
      emulation = 'slick';
      break;
   case "brief-keys":
      emulation = 'brief';
      break;
   case "emacs-keys":
      emulation = 'emacs';
      break;
   case "vi-keys":
      emulation = 'vi';
      break;
   case "gnuemacs-keys":
      emulation = 'gnu';
      break;
   case "vcpp-keys":
      emulation = 'vcpp';
      break;
   case "vsnet-keys":
      emulation = 'vsnet';
      break;
   case "ispf-keys":
      emulation = 'ispf';
      break;
   case "codewarrior-keys":
      emulation = 'codewarrior';
      break;
   case "codewright-keys":
      emulation = 'codewright';
      break;
   case "bbedit-keys":
      emulation = 'bbedit';
      break;
   case "xcode-keys":
      emulation = 'xcode';
      break;
   }
      
   return emulation;
}

void _ctlemu_ok.lbutton_up()
{
   _emulation_form_apply();
   p_active_form._delete_window(0);
}

void _ctlemu_cua_windows.lbutton_up()
{
   // select the help item according to the selected emulation
   _str help_message = '';
   _str new_keys = '';
   _str new_emulation = '';

   getKeysAndEmulation(new_keys, new_emulation);
   switch(new_emulation) {
   case 'macosx':
      help_message = "The Mac OS X keyboard emulation uses a command set similar to that used in TextEdit.";
      break;
   case 'windows':
      help_message = "The CUA (Common User Access) keyboard emulation uses a command set similar to that used in Microsoft Word and Notepad.";
      break;
   case 'slick':
      help_message = "The SlickEdit keyboard emulation uses a command set similar to that used by the text mode edition of SlickEdit (circa 1995).";
      break;
   case 'brief':
      help_message = "The Brief keyboard emulation uses a command set similar to the Brief editor which was famous on DOS.  This emulation relies heavily on Alt-key combinations.";
      break;
   case 'emacs':
      help_message = "The Epsilon keyboard emulation uses a command set similar to the Epsilon editor which was famous on DOS and very similar to Emacs.  This emulation relies heavily on Ctrl-X and Escape (meta) key combinations.";
      break;
   case 'vi':
      help_message = "The Vim keyboard emulation behaves like the Unix Vim editor, including support of the ex command line.  It supports some, but not all Vim extensions.";
      break;
   case 'gnu':
      help_message = "The GNU Emacs keyboard emulation uses a command set similar to the GNU Emacs editor.  This emulation relies heavily on Ctrl-X and escape (meta) key combinations.  It does not include an emacs lisp emulator.";
      break;
   case 'vcpp':
      help_message = "The Visual C++ keyboard emulation uses a command set similar to that used by Microsoft Visual C++ 6.0.";
      break;
   case 'vsnet':
      help_message = "The Visual Studio .NET keyboard emulation uses a command set similar to that used by Microsoft Visual Studio .NET.";
      break;
   case 'ispf':
      help_message = "The ISPF keyboard emulation behaves like the IBM System/390 ISPF editor.  It includes support for the ISPF prefix line commands, the ISPF command line, rulers, line numbering, and some XEDIT extensions.";
      break;
   case 'codewarrior':
      help_message = "The CodeWarrior keyboard emulation uses command set similar to the Metrowerks CodeWarrior IDE.";
      break;
   case 'codewright':
      help_message = "The CodeWright keyboard emulation uses a command set similar to the CodeWright editor for Windows formerly produced by Premia.";
      break;
   case 'bbedit':
      help_message = "The BBEdit keyboard emulation uses a command set similar to the BBEdit (Bare Bones editor) famous on MacOS.";
      break;
   case 'xcode':
      help_message = "The XCode keyboard emulation uses a command set similar to the XCode IDE found on Mac OSX.";
      break;
   case 'eclipse':
      help_message = "The Eclipse emulation uses a command set similar to the Eclipse IDE.";
      break;
   }

   // fill in the hint
   ctldescription.p_caption = help_message;

   // check to see if this emulation has any custom keybindings - if so, enable the RESTORE button
   boolean firstInit = _GetDialogInfoHt("firstInit", p_active_form, true);
   if (!firstInit && hasSavedKeybindings(new_emulation, new_keys)) {
      _btn_restore.p_enabled = true;
   } else _btn_restore.p_enabled = false;

}

//-----------------------------------------------------------

/**
 * The <b>setup_general</b> command displays the <b>General
 * Options dialog  box</b>.
 * 
 * @param showTab    tab number to display initially
 *                   (general, search, select, chars, more, exit, memory)
 * 
 * @categories Miscellaneous_Functions
 */ 
_command void setup_general(_str showTab='')
{
   switch (showTab) {
   case 'general':   showTab=0; break;
   case 'search':    showTab=1; break;
   case 'select':    showTab=2; break;
   case 'chars':     showTab=3; break;
   case 'more':      showTab=4; break;
   case 'exit':      showTab=5; break;
   case 'memory':    showTab=6; break;
   }

   show_general_options(showTab);
}

_command toggle_so_matchcase()
{
   // Get current search options
   int currentSO = (int) _default_option('S');
   // Check for the presence of regex in these options
   if ((currentSO & VSSEARCHFLAG_IGNORECASE) > 0) {
      currentSO = currentSO & ~VSSEARCHFLAG_IGNORECASE;
   }
   else {
      currentSO |= VSSEARCHFLAG_IGNORECASE;
   }
   _default_option('S', currentSO);
}
_command toggle_so_regex()
{
   // Get current search options
   int currentSO = (int) _default_option('S');
   // Check for the presence of regex in these options
   if ((currentSO & def_re_search) > 0) {
      currentSO = currentSO & ~def_re_search;
   }
   else {
      currentSO |= def_re_search;
   }
   _default_option('S', currentSO);
}

_command toggle_so_matchword()
{
   // Get current search options
   int currentSO = (int) _default_option('S');
   // Check for the presence of regex in these options
   if ((currentSO & VSSEARCHFLAG_WORD) > 0) {
      currentSO = currentSO & ~VSSEARCHFLAG_WORD;
   }
   else {
      currentSO |= VSSEARCHFLAG_WORD;
   }
   _default_option('S', currentSO);
}
_command toggle_so_backwards()
{
   // Get current search options
   int currentSO = (int) _default_option('S');
   // Check for the presence of regex in these options
   if ((currentSO & VSSEARCHFLAG_REVERSE) > 0) {
      currentSO = currentSO & ~VSSEARCHFLAG_REVERSE;
   }
   else {
      currentSO |= VSSEARCHFLAG_REVERSE;
   }
   _default_option('S', currentSO);
}
_command toggle_so_cursorend()
{
   // Get current search options
   int currentSO = (int) _default_option('S');
   // Check for the presence of regex in these options
   if ((currentSO & VSSEARCHFLAG_POSITIONONLASTCHAR) > 0) {
      currentSO = currentSO & ~VSSEARCHFLAG_POSITIONONLASTCHAR;
   }
   else {
      currentSO |= VSSEARCHFLAG_POSITIONONLASTCHAR;
   }
   _default_option('S', currentSO);
}
_command toggle_so_hiddentext()
{
   // Get current search options
   int currentSO = (int) _default_option('S');
   // Check for the presence of regex in these options
   if ((currentSO & VSSEARCHFLAG_HIDDEN_TEXT) > 0) {
      currentSO = currentSO & ~VSSEARCHFLAG_HIDDEN_TEXT;
   }
   else {
      currentSO |= VSSEARCHFLAG_HIDDEN_TEXT;
   }
   _default_option('S', currentSO);
}

defload()
{
   _default_special_chars = _default_option('Q');
}

defeventtab _special_characters_form;

#region Options Dialog Helper Functions

void _special_characters_form_apply()
{
   typeless ht:[];
   ht = _ctlViewHex.p_user;

   _macro('m',_macro('s'));
   _str byte_table;
   byte_table = "";
   int i;
   _str vim_list = '';
   boolean badInput=false;
   for (i=1; i<=MAXSPECIALCHARS; i++) {
      _str ctlName;
      ctlName = "_ctlSpecialCharC" :+ i;
      int wid;
      wid = _find_control(ctlName);
      typeless dec=wid.p_text;
      if (_ctlViewHex.p_value) {
         dec=hex2dec(dec);
      }
      if (!isinteger(dec) || dec<0 || dec>=256) {
         badInput=true;
      } else {
         byte_table = byte_table :+ _chr(dec);
         // Clark: I have not studied the vi code path
         // close enough to know what is supposed to be done here.
         // I suspect this code is wrong. For simplicity the VI functions
         // should take a character code and NOT the actual character.
         // This would require a lot of changes in the vi code though.
         // Maybe passing the values in an array (utf-8 array?) would
         // be better.
         //
         //If the vi code path is broken. It's no worse that v17.0 or v17.0.1
         _str ch = _UTF8ToMultiByte(_UTF8Chr(dec));
         // Building the Vim special char list string here - RH
         // Currently only supporting EOL, Tab, Virtual Space
         if (i == 1) {
            vim_list = 'eol:' :+ ch :+ ',';
         } else if (i == 3) {
            vim_list = vim_list :+ 'tab:' :+ ch;
         } else if (i == 5) {
            vim_list = vim_list :+ ch;
         }
      }
   }
   
   if (!badInput) {
      // notice that _default_option('Q') and _default_option(VSOPTIONZ_SPECIAL_CHAR_XLAT_TAB) 
      // do the same exact thing.  I don't know why, but that's the way it is.
      _default_option(VSOPTIONZ_SPECIAL_CHAR_XLAT_TAB,byte_table);

      // When the special chars are updated from Tools->General, update the Vim list also - RH
      if (def_keys == 'vi-keys') {
         __ex_set_listchars(vim_list);
      }
      if (byte_table != ht:["specialChars"]) {
         _macro_append("_default_option(VSOPTIONZ_SPECIAL_CHAR_XLAT_TAB,"_quote(byte_table)");");
      }
   }
   _special_char_option=_ctlViewDec.p_user;
   _config_modify_flags(CFGMODIFY_OPTION);
}

#endregion Options Dialog Helper Functions

static int data_not_valid()
{
   _str old_format=_ctlViewDec.p_user;
   _str text=p_text;
   //message 'old_format='old_format
   switch (old_format) {
   case 'H':
      _str dec=hex2dec(text);
      if (dec=='') {
         return(1);
      }
      break;
   case 'A':
      if (length(text)!=1) {
         return(1);
      }
      break;
   default:
      if (!(isinteger(text) && text<=255 && text>=0)) {
         return(1);
      }
   }
   return(0);
}
void _ctlSpecialCharC1.on_got_focus()
{
   if (data_not_valid() && p_text:!="") {
      _beep();
   }
}
void _ctlSpecialCharC1.on_lost_focus()
{
   _set_sel(1);
   if (data_not_valid() && p_text:!="") {
      _beep();
   }
}
void _ctlSpecialCharC1.on_got_focus()
{
   if (data_not_valid() && p_text:!="") {
      _beep();
   }
}
void _ctlSpecialCharC1.on_lost_focus()
{
   _set_sel(1);
   if (data_not_valid() && p_text:!="") {
      _beep();
   }
}
void _ctlViewDec.lbutton_up()
{
   configSpecialCharNumToggle('D');
}
void _ctlViewHex.lbutton_up()
{
   configSpecialCharNumToggle('H');
}

static void setSpecialCode(int val)
{
   if ( _ctlViewDec.p_user == 'D' ) {
      p_text = val;
   } else {
      _str text;
      text = dec2hex(val);
      text = substr(text,3);
      if (length(text) < 2) {
         text = "0x0" :+ text;
      } else {
         text = "0x" :+ text;
      }
      p_text = text;
   }
   p_user=val;
}

static void setSpecialChar(int val)
{
   // this is ain't pretty, but normal textbox will not display the special character's correctly
   if (val!=p_user) {
      p_user=val;
      p_enabled=1;
      p_ReadOnly=0;
      delete_all(); top();
      if ( val >= 0 && val <= 255 ) {
         insert_line(_MultiByteToUTF8(_chr(val)));
         top(); _SetTextColor( CFG_WINDOW_TEXT, 1 ); top();
      }
      p_ReadOnly=1;
      p_enabled=0;
   }
}

void _ctlSpecialCharC1.on_change()
{
   if (_ignore_change) return;
   _str text=lowcase(p_text);
   if ( (text=='x' || text=='0x' ) && ( _ctlViewDec.p_user!='H' ) ) {
      configSpecialCharNumToggle('H',p_window_id);
      _ctlViewHex.p_value=1;
   }

   int value=0;
   if (_ctlViewDec.p_user=='H') {
      typeless dec=hex2dec(p_text);
      if (dec!='') {
         value=dec;
      }
   } else {
      if (isinteger(p_text) && p_text<=255 && p_text>=0) {
         value=(int)p_text;
      }
   }
   if ( p_user != value )
   {
      p_user=value;
      p_prev.setSpecialChar(value);
   }
}
void _ctlSpecialCharSpin.on_spin_up(_str direction='')
{
   int textwid;
   textwid = p_prev;
   typeless dec=textwid.p_user;
   if (direction!='') {
      if (dec>0) {
         --dec;
      }
   } else {
      if (dec<255) {
         ++dec;
      }
   }
   textwid.setSpecialCode(dec);
   textwid.p_prev.setSpecialChar(dec);
}

void _ctlSpecialCharSpin.on_spin_down()
{
   call_event('-',p_window_id,ON_SPIN_UP,'');
}

static void configSpecialCharNumToggle(_str mode,int ignore_wid=0)
{
   if ( _ctlViewDec.p_user == mode )
      return;

   _ctlViewDec.p_user=mode;
   int i;
   for (i=1; i<=MAXSPECIALCHARS; i++) {
      int wid;
      _str ctlName;
      ctlName = "_ctlSpecialCharC" :+ i;
      wid = _find_control(ctlName);
      if ( ignore_wid != wid ) {
         int val=wid.p_user;
         wid.setSpecialCode(val);
      }
   }
}

void _ctlSpecialCharReset.on_create()
{
   typeless ht:[];

   _str byte_table = _default_option('Q');
   ht:["specialChars"] = byte_table;
   _ctlViewHex.p_user = ht;
   _ctlViewDec.p_user = _special_char_option;
   if ( _ctlViewDec.p_user == 'D' )
      _ctlViewDec.p_value = 1;
   else
      _ctlViewHex.p_value = 1;

   int i;
   for (i=1; i<=MAXSPECIALCHARS; i++) {
      int val;
      int wid;
      _str ctlName;
      val = _asc(substr(byte_table, i, 1));

      ctlName = "_ctlSpecialCharE" :+ i;
      wid = _find_control(ctlName);
      wid._use_edit_font();
      wid.p_height=_dy2ly(SM_TWIP,wid.p_font_height)+wid._top_height()*2;
      wid.p_line_numbers_len=0;
      wid.p_LCBufFlags&=~(VSLCBUFFLAG_LINENUMBERS|VSLCBUFFLAG_READWRITE);
      wid.p_user=-1;
      wid.setSpecialChar(val);
      wid=wid.p_next;
      //wid._use_edit_font();
      wid.setSpecialCode(val);
   }
}

void _ctlSpecialCharReset.lbutton_up()
{
   typeless ht:[];
   ht:["specialChars"] = _default_special_chars;
   _ctlViewHex.p_user = ht;
   int i;
   for (i=1; i<=MAXSPECIALCHARS; i++) {
      int val;
      int wid;
      _str ctlName;
      val = _asc(substr(_default_special_chars, i, 1));
      ctlName = "_ctlSpecialCharE" :+ i;
      wid = _find_control(ctlName);
      wid._use_edit_font();
      wid.setSpecialChar(val);
      wid.p_next.setSpecialCode(val);
   }
}

// END -- defeventtab _special_characters_form;

defeventtab _selections_options_form;

#define CUA_STYLE 'CN D 1 .'
#define CUAADV_STYLE 'CN D 1 P'
#define SLICKEDITEXT_STYLE 'CI Y 0 P'

#define SELECTIONS_TABLE _userdefined.p_user
#define PRODUCT_DEFAULT _product_default.p_user

#region Options Dialog Helper Functions

void _selections_options_form_init_for_options()
{
   config_initSelStyle();
}

boolean _selections_options_form_apply()
{
   typeless ht:[];
   ht = SELECTIONS_TABLE;

   _macro('m',_macro('s'));

   def_advanced_select='P';
   //_macro_append('def_advanced_select='_quote(def_advanced_select)';');

   if(ctldelsel.p_value) {
      def_persistent_select='D';
   } else {
      if (ctlautodeselect.p_value) {
         def_persistent_select='N';
      } else {
         def_persistent_select='Y';
      }
   }
   if (def_persistent_select != ht:["def_persistent_select"]) {
     _macro_append('def_persistent_select='_quote(def_persistent_select)';');
   }

   def_deselect_paste= _deselect_after_paste.p_value!=0;
   if (_deselect_after_paste.p_value != ht:["_deselect_after_paste.p_value"]) {
      _macro_append('def_deselect_paste='def_deselect_paste';');
   }

   def_deselect_copy= _deselect_after_copy.p_value!=0;
   if (_deselect_after_copy.p_value != ht:["_deselect_after_copy.p_value"]) {
      _macro_append('def_deselect_copy='def_deselect_copy';');
   }

   def_select_style=upcase(def_select_style);

   _str style1=_extend.p_value?'C':'E';
   _str style2=_inclusive_char.p_value?'I':'N';
   def_select_style=style1:+style2;

   if (def_select_style != ht:["def_select_style"]) {
      _macro_append('def_select_style='_quote(def_select_style)';');
   }

   def_scursor_style= !_shiftcursor.p_value;
   if (_shiftcursor.p_value != ht:["_shiftcursor.p_value"]) {
      _macro_append('def_scursor_style='def_scursor_style';');
   }

   def_autoclipboard=ctlmouseclipboard.p_value!=0;
   if (ctlmouseclipboard.p_value != ht:["ctlmouseclipboard.p_value"]) {
      _macro_append('def_autoclipboard='def_autoclipboard';');
   }

   def_cursor_beginend_select=ctlbeginendselect.p_value!=0;
   if (ctlbeginendselect.p_value != ht:["ctlbeginendselect.p_value"]) {
      _macro_append('def_cursor_beginend_select='def_cursor_beginend_select';');
   }

   def_mouse_menu_style = (_enable_block_select.p_value != 0) ? MM_MARK_FIRST : MM_TRACK_MOUSE;
   if (_enable_block_select.p_value != ht:['_enable_block_select.p_value']) {
      _macro_append('def_mouse_menu_style='def_mouse_menu_style';');
   }

   def_modal_tab = ctlIndentSelection.p_value;
   if (ctlIndentSelection.p_value != ht:['ctlIndentSelection.p_value']) {
      _macro_append('def_modal_tab='def_modal_tab';');
   }

   _str clipFormats = "";
#if __PCDOS__ || __MACOSX__
   if (_cfHTML.p_value) {
      clipFormats = clipFormats:+'H';
   }
#endif
   if (clipFormats != def_clipboard_formats) {
      def_clipboard_formats = clipFormats;
      _macro_append('def_clipboard_formats="'def_clipboard_formats'";');
   }
   _config_modify_flags(CFGMODIFY_DEFVAR);

   return true;
}

#endregion Options Dialog Helper Functions

static void config_initSelStyle()
{
   typeless ht:[];

   _macro('m',_macro('s'));
   _cuaadv.p_user=CUAADV_STYLE;

   // we set and save all the current values

   // def-persistent-select value goes with ctldelsel and ctlautodeselect
   def_persistent_select = upcase(def_persistent_select);
   ht:["def_persistent_select"] = def_persistent_select;
   ctldelsel.p_value = (int)(def_persistent_select=='D');
   ctlautodeselect.p_value = (int)(def_persistent_select!='Y');

   // def-deselect-paste goes with _deselect_after_paste
   ht:["_deselect_after_paste.p_value"] = _deselect_after_paste.p_value;
   _deselect_after_paste.p_value = (int)def_deselect_paste;

   // def-deselect-copy goes with _deselect_after_copy
   if (def_deselect_copy == "") def_deselect_copy = true;
   if (def_deselect_copy == null) def_deselect_copy = false;
   ht:["_deselect_after_copy.p_value"] = _deselect_after_copy.p_value;
   _deselect_after_copy.p_value= (int)def_deselect_copy;

   // def-select-style goes with _inclusive_char and _extend
   def_select_style = upcase(def_select_style);
   ht:["def_select_style"] = def_select_style;
   _inclusive_char.p_value=pos('I',def_select_style);
   _extend.p_value=pos('C',def_select_style);

   // def-scursor-style goes with _shiftcursor
   _shiftcursor.p_value= (int)(def_scursor_style==0);
   ht:["_shiftcursor.p_value"] = _shiftcursor.p_value;

   // def-autoclipboard goes with ctlmouseclipboard
   ctlmouseclipboard.p_value=(int)(def_autoclipboard!=0);
   ht:["ctlmouseclipboard.p_value"] = ctlmouseclipboard.p_value;

   // def-cursor-beginend-select goes with ctlbeginendselect
   ctlbeginendselect.p_value=(int)(def_cursor_beginend_select!=0);
   ht:["ctlbeginendselect.p_value"] = ctlbeginendselect.p_value;

   // def_mouse_menu_style goes with _enable_block_select
   _enable_block_select.p_value=(int)(def_mouse_menu_style==MM_MARK_FIRST);
   ht:["_enable_block_select.p_value"] = _enable_block_select.p_value;

   ctlIndentSelection.p_value = (int)def_modal_tab;
   ht:["ctlIndentSelection.p_value"] = ctlIndentSelection.p_value;

   // shift cursor is enabled in cua mode
   _shiftcursor.p_enabled=(name_on_key(S_UP)=='cua-select');

   // here we enable stuff
   boolean enabled = !(def_keys=='brief-keys' || def_keys=='emacs-keys');
   _userdefined.p_enabled=enabled;
   _deselect_after_copy.p_enabled=enabled;
   _deselect_after_paste.p_enabled=enabled;
   _inclusive_char.p_enabled=enabled;
   _extend.p_enabled=enabled;
   ctldelsel.p_enabled=enabled;
   ctlautodeselect.p_enabled=enabled;

/*
   cursor extend   Inclusive/non inclusive char
   C|E             I|N                         
cua                                            
   Not allowed in brief emulation              
   CN D 1 .                                    
                                               
cua advanced                                   
   CN D 1 P                                    
                                               
product default                                
   CN D 1 P   Windows                          
   EI Y 0 P   slickedit                        
   CI N 1 P   BRIEF                            
   CN N 1 P   EMACS                            
   CN N 1 P   GNU EMACS                        
   CN D 1 P   Visual C++                       
                                               
slick edit + cursor extends mark               
                                               
When in windows emulation only enable          
     cua and cua advanced.                     
*/

   switch(lowcase(def_keys)) {
   case 'vcpp-keys':
   case 'windows-keys':
   case 'macosx-keys':
   case 'ispf-keys':
   case 'codewarrior-keys':
   case 'vsnet-keys':
   case 'codewright-keys':
   case 'xcode-keys':
   case 'bbedit-keys':
   case 'eclipse-keys':
      PRODUCT_DEFAULT='CN D 1 P';
      _product_default.p_enabled=0;
      break;
   case '':
      PRODUCT_DEFAULT='EI Y 0 P';
      break;
   case 'brief-keys':
      PRODUCT_DEFAULT='CI N 1 P';
      _product_default.p_caption='Brief Default';
      break;
   case 'emacs-keys':
      PRODUCT_DEFAULT='CN N 1 P';
      _product_default.p_caption='Epsilon Default';
      break;
   case 'vi-keys':
      PRODUCT_DEFAULT='CI Y 0 P';
      _product_default.p_caption='VI Default';
      break;
   case 'gnuemacs-keys':
      PRODUCT_DEFAULT='CN N 1 P';
      _product_default.p_caption='GNU EMACS Default';
      break;
   default:
      PRODUCT_DEFAULT='CN D 1 P';
      _product_default.p_enabled=0;
      break;
   }
   _update_style();

   // Copy as RTF and HTML formats only available
   // on Windows and Mac
#if (!__PCDOS__) && (!__MACOSX__)
   _clipformats.p_enabled = false;
   _clipformats.p_visible = false;
#endif
   _cfHTML.p_value = pos('H',def_clipboard_formats);

   SELECTIONS_TABLE = ht;
}

void _extend.lbutton_up()
{
   _userdefined.p_value = 1;
   _userdefined.p_enabled = true;
}

void ctldelsel.lbutton_up()
{
   if (ctldelsel.p_value) {
      ctlautodeselect.p_value=1;
   } 
}
void ctlautodeselect.lbutton_up()
{
   if (!ctlautodeselect.p_value) {
      ctldelsel.p_value=0;
   }
}

void _cuaadv.lbutton_up()
{
   typeless select_style='';
   typeless persistent='';
   typeless deselect='';
   typeless advselect='';
   parse p_user with select_style persistent deselect advselect . ;

   _extend.p_value= (int)(substr(select_style,1,1)=='C');
   _inclusive_char.p_value= (int)(substr(select_style,2,1)=='I');

   switch (persistent) {
   case 'D':
      ctldelsel.p_value=1;
      ctlautodeselect.p_value=1;
      break;
   case 'Y':
   case 'N':
      ctldelsel.p_value=0;
      ctlautodeselect.p_value=(int)(persistent=='N');
      break;
   }

   _deselect_after_paste.p_value=(int)deselect;
}

static _str _get_style()
{
   _str result='';
   result=((_extend.p_value)?'C':'E');
   result=result:+((_inclusive_char.p_value)?'I':'N');

   result=result:+' ';
   if (ctldelsel.p_value) {
      result=result:+'D';
   } else {
      if (ctlautodeselect.p_value) {
         result=result:+'N';
      } else {
         result=result:+'Y';
      }
   }

   result=result:+' ';
   result=result:+_deselect_after_paste.p_value;

   result=result:+' ';
   result=result:+'P';
   return(result);
}

static void _update_style()
{
   typeless style = _get_style();
   if (style == CUAADV_STYLE && _cuaadv.p_enabled){
      _cuaadv.p_value=1;
   } else if (style == PRODUCT_DEFAULT){
      _product_default.p_value=1;
   } else {
      _userdefined.p_enabled = true;
      _userdefined.p_value = 1;
   }
}

