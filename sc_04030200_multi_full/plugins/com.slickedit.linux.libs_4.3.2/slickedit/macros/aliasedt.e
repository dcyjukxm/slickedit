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
#require "se/lang/api/LanguageSettings.e"
#import "commentformat.e"
#import "files.e"
#import "listbox.e"
#import "main.e"
#import "mprompt.e"
#import "optionsxml.e"
#import "picture.e"
#import "savecfg.e"
#import "setupext.e"
#import "slickc.e"
#import "stdcmds.e"
#import "stdprocs.e"
#import "surround.e"
#import "xmlwrap.e"
#import "xmlwrapgui.e"
#endregion

using se.lang.api.LanguageSettings;

//DIALOG BOX MAY BE SHOWN MODELESSLY

/*
p_user's:

   ALIAS_TABLE - _ctlae_ok.p_user - is the hash table that holds the aliases.  Every function that
                needs it saves and restores it.

   LAST_EDITED_ALIAS - _ctlae_alias_list.p_user - This is the last alias that was edited.  It is
                              saved so that before we fill in the alias selected
                              in the alias list box, we can save the last one
                              that was edited.

   ALIAS_MODIFIED - _ctlae_edit_window.p_user - Modify flag.
   ALIAS_PARAMS_MODIFIED - _ctlae_param_tree.p_user  - alias parameters modified
   ALIAS_FILE_TYPE - ctlAliasEscapeSeqButton.p_user - alias file type
   SURROUND_MODE _ctlae_surround.p_user - whether we're in surround mode
*/
#define ORIG_FILENAME            _ctlae_param_add.p_user
#define SURROUND_MODE            _ctlae_surround.p_user
#define ALIAS_TABLE              _ctlae_ok.p_user
#define ALIAS_MODIFIED           _ctlae_edit_window.p_user
#define LAST_EDITED_ALIAS        _ctlae_alias_list.p_user
#define ALIAS_FILE_TYPE          ctlAliasEscapeSeqButton.p_user
#define ALIAS_LANGUAGE           ctl_escapeSeq_label.p_user
#define ALIAS_PARAMS_MODIFIED    _ctlae_param_tree.p_user
/*
#define ORIG_EXPAND_VALUE        _ctl_expand_on_space.p_user
*/

#define SURROUND_PREFIX '=surround_with_'
struct ALIAS_TYPE{
   _str value[];
};

/**
 * Retrieves the filename where language-specific aliases are kept for the given 
 * language.  Does not include the path, as file is assumed to be in the user's 
 * config dir. 
 * 
 * @param langID        language ID of language to fetch alias file name for`
 * @param create        whether to create a new entry if one 
 *                      does not exist
 * 
 * @return              file name
 */
_str getAliasFileNameForLang(_str langID, boolean createEntry = true)
{
   aliasFilename := LanguageSettings.getAliasFilename(langID);
   if (aliasFilename == '' && createEntry && langID!="") {
      aliasFilename = langID'.als';
      LanguageSettings.setAliasFilename(langID, aliasFilename);
   }

   return aliasFilename;
}

defeventtab _alias_editor_form;

#region Options Dialog Helper Functions

void _alias_editor_form_init_for_options(_str options = '')
{  
   _str a[];
   _str langID = '', surround = '', initialAliasName = '';
   split(options, ' ', a);
   switch (a._length()) {
   case 3:
      initialAliasName = a[2];
   case 2:
      surround = a[1];
   case 1:
      langID = a[0];
      break;
   }

   aliasFilename := getAliasFilename(langID);
   _SetDialogInfoHt('aliasFilename', aliasFilename);

   initAliasEditor(aliasFilename, surround, initialAliasName);
   _ctl_filename.p_visible = true;
   _ctl_filename.p_caption = "Alias file:  "aliasFilename;

   _ctlae_ok.p_visible = false;
   _ctlae_cancel.p_visible = false;
   _ctlae_help.p_visible = false;
   _ctlae_delete.p_x = _ctlae_new.p_x;
   _ctlae_new.p_x = _ctlae_ok.p_x;

   _set_language_form_lang_id(langID);
   /*
   if (langID == '') {
      _ctl_expand_on_space.p_visible = _ctl_lower_divider.p_visible = false;
   } else {
      _ctl_expand_on_space.p_value = (int)LanguageSettings.getExpandAliasOnSpace(langID);
   }
   */
}

void _alias_editor_form_save_settings()
{
   /*
   if (_ctl_expand_on_space.p_visible) {
      ORIG_EXPAND_VALUE = _ctl_expand_on_space.p_value;
   }
   */
}

boolean _alias_editor_form_is_modified()
{
   modified := (ALIAS_MODIFIED != 0 || _ctlae_edit_window.p_modify || ALIAS_PARAMS_MODIFIED);

   /*
   // see if the expand on space value has changed
   if (_ctl_expand_on_space.p_visible) {
      modified = modified || (ORIG_EXPAND_VALUE != _ctl_expand_on_space.p_value);
   }
   */

   return modified;

}

boolean _alias_editor_form_apply()
{
   status := 0;

   /*
   if (_ctl_expand_on_space.p_visible && ORIG_EXPAND_VALUE != _ctl_expand_on_space.p_value) {
      langID := _get_language_form_lang_id();
      if (langID != '') {
         LanguageSettings.setExpandAliasOnSpace(langID, (_ctl_expand_on_space.p_value != 0));
      } 
   }
   */

   if (ALIAS_MODIFIED != 0 || _ctlae_edit_window.p_modify || ALIAS_PARAMS_MODIFIED) {
   
      ALIAS_TYPE alias_table:[];
      status=_ctlae_alias_list.call_event(CHANGE_OTHER,1,_ctlae_alias_list,ON_CHANGE,'');
      if (status) {
         return (status == 0);
      }
   
      ALIAS_MODIFIED=0;
      ALIAS_PARAMS_MODIFIED=0;
      _ctlae_edit_window.p_modify = 0;
   
      alias_table=ALIAS_TABLE;
   
      if ( ALIAS_FILE_TYPE == SYMTRANS_ALIAS_FILE) {
         _str ST_symbols[];
         typeless name;
         for (name._makeempty();;) {
            alias_table._nextel(name);
            if (name._isempty()) break;
            ST_symbols[ST_symbols._length()] = name;
         }
         //save the possible expansions.
         ST_storeSymbols(ALIAS_LANGUAGE, ST_symbols);
      }
   
      _str aliasfilename=ORIG_FILENAME;
      aliasfilename=usercfg_init_write(aliasfilename);
      status=write_alias_file(aliasfilename,alias_table);
   }

   return (status == 0);
}

_str _alias_editor_form_export_settings(_str &file, _str &importArgs, _str langID = '')
{
   error := '';
   
   // get the alias file for this language and lack thereof
   aliasFile := getAliasFilename(langID, false);

   // is this a whole path or just a file name?
   if (aliasFile != '') {
      if (!pathlen(aliasFile)) {
         // get the file, probably in the config dir
         aliasFile = usercfg_path_search(aliasFile);
      } else {
         // this a path to somewheres
         aliasFile = absolute(aliasFile);
      }
   }

   // make sure we have a path here
   if (aliasFile != '' && (file_exists(aliasFile))) {
      // rip out just the file name
      justFile := _strip_filename(aliasFile, 'P');
      if (copy_file(aliasFile, file :+ justFile)) {
         if (langID != '') {
            error = 'Error copying alias file for '_LangId2Modename(langID)', 'aliasFile'.';
         } else {
            error = 'Error copying global alias file, 'aliasFile'.';
         }
      }
      file = justFile;
   }

   // save some values for our import args
   if (langID != '') {
      importArgs = 'expand='LanguageSettings.getExpandAliasOnSpace(langID);
   } 
   
   return error;
}

_str _alias_editor_form_import_settings(_str file, _str importArgs, _str langID = '')
{
   error := '';
   status := 0;

   if (file != '') {
      // get the filename for this alias
      curFile := getAliasFilename(langID);
   
      // is this a whole path or just a file name?
      if (!pathlen(curFile)) {
         // get the file, probably in the config dir
         curFile = usercfg_init_write(curFile);
      } else {
         // this a path to somewheres
         curFile = absolute(curFile);
      }
      if (curFile == '') curFile = _ConfigPath() :+ getAliasFilename(langID);
   
   
      if (file_exists(curFile)) {
         // we append to the original file, rather than replace it
         status = mergeAliasFiles(curFile, file);
      } else {
         // easy!  we just copy
         status = copy_file(file, curFile);
      }
   }

   if (langID != '') {
      parse importArgs with 'expand=' auto expandValue;
      LanguageSettings.setExpandAliasOnSpace(langID, ((int)expandValue) != 0);
   }

   if (status) {
      if (langID != '') {
         error = 'Error copying aliases from alias file for '_LangId2Modename(langID)', 'file'.';
      } else {
         error = 'Error copying aliases from global alias file, 'file'.';
      }
   }

   return error;
}

static _str getAliasFilename(_str langID, boolean createEntry = true)
{
   // if we have a language, load the alias file for that language
   aliasFilename := '';
   if (langID != '') {
      aliasFilename = getAliasFileNameForLang(langID, createEntry);
   } else {
      // here we use the directory aliases file
      aliasFilename = get_env(_SLICKALIAS);
      if (aliasFilename == '') {
         aliasFilename = VSCFGFILE_ALIASES;
      }
   }

   return aliasFilename;
}

/**
 * Combines the aliases in two files into one file.  The merged 
 * file is saved in the same path as the first file.  If there 
 * are any aliases which have the same name in both files, 
 * aliases in file2 are given precedence. 
 * 
 * @param file1            first file to merge, path where the 
 *                         merged file is saved
 * @param file2            second file to merge, any aliases 
 *                         named in this file have precedence
 *                         over same named aliases in file1
 */
static int mergeAliasFiles(_str file1, _str file2)
{
   ALIAS_TYPE aliasTable:[];

   status := 0;
   do {

      // read the first file
      status = load_alias_file(file1, aliasTable);
      if (status) break;
   
      // read the second file - stuff will be overwritten
      status = load_alias_file(file2, aliasTable, true);
      if (status) break;
   
      // write everything out to the first path
      status = write_alias_file(file1, aliasTable);

   } while (false);

   return status;
}

/**
 * 
 * Test to see if the symbol translation data for this lang type is 
 * loaded.  If not, cache the data from the symbol translation alias 
 * files to optimize the lookup. 
 */
void _buffer_add_loadSymbolTransData() {
   if (ST_needToLoadSymbols()) {
      ALIAS_TYPE alias_table:[];

      ALIAS_TYPE junk;junk.value[0]=0;
      alias_table:[0]=junk;alias_table._deleteel(0);

      _str aliasfilename = getSymbolTransaliasFile(p_LangId);
      if (aliasfilename=='') {
         return;
      }
      load_alias_file(aliasfilename,alias_table);
      _str ST_symbols[];
      typeless name;
      for (name._makeempty();;) {
         alias_table._nextel(name);
         if (name._isempty()) break;
         ST_symbols[ST_symbols._length()] = name;
      }
      //save the possible expansions.
      ST_storeSymbols(p_LangId, ST_symbols);
   }
   return;
}

#endregion Options Dialog Helper Functions

_command void aliasEscapeSeqInsert(_str seq = '') { 
   _ctlae_edit_window._insert_text(seq);
}
_command void aliasEscapeSeqInsertAndBackspace(_str seq = '') { 
   _ctlae_edit_window._insert_text(seq);
   _ctlae_edit_window.p_col -= 1;
}

initAliasEditor(_str aliasfilename='', 
                _str editSurroundAliases='', 
                _str initialAliasName='',
                int aliasFileType=REGULAR_ALIAS_FILE,
                _str lang='')
{
   SURROUND_MODE = false;

   update_surround_definitions();

   //say('Save alias file type 'lang);
   ALIAS_FILE_TYPE = aliasFileType;
   ALIAS_LANGUAGE = lang;
   if (aliasFileType == DOCCOMMENT_ALIAS_FILE) {
      _ctlae_surround.p_enabled = false;
      //_ctlae_surround.p_visible = false;
      _ctlae_new.p_enabled = false;
      _ctlae_delete.p_enabled = false;
   } else if (aliasFileType == SYMTRANS_ALIAS_FILE) {
      _ctlae_surround.p_enabled = false;
      //_ctlae_surround.p_visible = false;
      _ctlae_new.p_enabled = true;
      _ctlae_delete.p_enabled = true;
      ALIAS_LANGUAGE = lang;
   } else {
      update_surround_definitions();
      _ctlae_surround.p_enabled = true;
      //_ctlae_surround.p_visible = true;
      _ctlae_new.p_enabled = true;
      _ctlae_delete.p_enabled = true;
      _ctlae_surround.p_value = (editSurroundAliases=='1')? 1:0;
   }

   ALIAS_TYPE alias_table:[];

   ALIAS_TYPE junk;junk.value[0]=0;
   alias_table:[0]=junk;alias_table._deleteel(0);

   ORIG_FILENAME=aliasfilename;
   if (aliasfilename=='') {
      aliasfilename=VSCFGFILE_ALIASES;
   }
   if (!pathlen(aliasfilename)) {
      aliasfilename=usercfg_path_search(aliasfilename);
      if (aliasfilename=='') {
         if (file_eq(ORIG_FILENAME,VSCFGFILE_ALIASES)) {
            aliasfilename=_ConfigPath():+VSCFGFILE_ALIASES;
         } else {
            aliasfilename=_ConfigPath():+ORIG_FILENAME;
         }
      }
   } else {
      aliasfilename=absolute(aliasfilename);
   }

   ALIAS_MODIFIED=0;
   ALIAS_PARAMS_MODIFIED=0;
   load_alias_file(aliasfilename,alias_table);
   _str fname='';
   typeless fsize='';
   typeless fflags='';
   parse _default_font(CFG_WINDOW_TEXT) with fname','fsize','fflags','. ;
   _ctlae_edit_window.p_font_name=fname;
   _ctlae_edit_window.p_font_size=fsize;
   _ctlae_edit_window.p_font_bold=fflags&F_BOLD;
   _ctlae_edit_window.p_font_italic=fflags&F_ITALIC;
   _ctlae_edit_window.p_font_strike_thru=fflags&F_STRIKE_THRU;
   _ctlae_edit_window.p_font_underline=fflags&F_UNDERLINE;
   ALIAS_TABLE=alias_table;
   _ctlae_surround.p_value = (editSurroundAliases=='1')? 1:0;
   int wid=p_window_id;p_window_id=_control _ctlae_alias_list;
   _update_alias_list();
   _ctlae_alias_list.p_text = initialAliasName;
   _ctlae_alias_list.p_case_sensitive=(lowcase(def_alias_case)=='e');

   _ctlae_param_tree._TreeSetColButtonInfo(0, 1500, -1, -1, 'Name');
   _ctlae_param_tree._TreeSetColButtonInfo(1, 3500, -1, -1, 'Prompt');
   _ctlae_param_tree._TreeSetColButtonInfo(2, 1500, -1, -1, 'Initial Value');
}

_ctlae_ok.on_create(_str aliasfilename='', 
                    _str editSurroundAliases='', 
                    _str initialAliasName='',
                    int aliasFileType=REGULAR_ALIAS_FILE,
                    _str lang='')
{
   _alias_editor_form_initial_alignment();

   if (aliasfilename != '') {
      initAliasEditor(aliasfilename, editSurroundAliases, initialAliasName, aliasFileType, lang);
      /*
      _ctl_expand_on_space.p_visible = _ctl_lower_divider.p_visible = false;
      */
   }
   _SetDialogInfoHt('aliasFilename', aliasfilename);

   if (aliasFileType == DOCCOMMENT_ALIAS_FILE) {
      p_active_form.p_caption='Doc Comment Editor - 'aliasfilename;
      p_active_form.p_help = 'Doc Comment Editor dialog';
      ctlAliasEscapeSeqButton.p_command = '_aliasEscapeSeq_menuDocCommentVersion';
      _ctl_filename.p_visible = false;
   } else if (aliasFileType == SYMTRANS_ALIAS_FILE) {
      p_active_form.p_caption='Symbol Translation Editor - 'aliasfilename;
      p_active_form.p_help = 'Symbol Translation Editor';
      ctlAliasEscapeSeqButton.p_command = '_aliasEscapeSeq_menuDocCommentVersion';
      _ctl_filename.p_visible = false;
   } else {
      p_active_form.p_caption='Alias Editor - 'aliasfilename;
      ctlAliasEscapeSeqButton.p_command = '_aliasEscapeSeq_menu';
   }
}

void _update_alias_list(int forceUpdate=0)
{
   ALIAS_TYPE alias_table:[];
   alias_table=ALIAS_TABLE;
   
   int surround_prefix_length=length(SURROUND_PREFIX);
   SURROUND_MODE=_ctlae_surround.p_value==1;

   int wid=p_window_id;p_window_id=_control _ctlae_alias_list;
   _lbclear();
   typeless i;
   for (i._makeempty();;) {
      alias_table._nextel(i);
      if (i._isempty()) break;
      boolean is_surround=(substr(i,1,surround_prefix_length)==SURROUND_PREFIX);
      if (is_surround && SURROUND_MODE) {
         _lbadd_item(substr(i,surround_prefix_length+1));
      } else if (!is_surround && !SURROUND_MODE) {
         _lbadd_item(i);
      }
   }
   _lbsort();
   _lbtop();_lbselect_line();
   p_window_id=wid;
   _ctlae_alias_list.call_event(CHANGE_OTHER,forceUpdate,defeventtab _alias_editor_form._ctlae_alias_list,ON_CHANGE,'E');
}

void _ctlae_surround.lbutton_up()
{
   _update_alias_list(1);
}

static _str GetListBoxText()
{
   _str text = _ctlae_alias_list._lbget_text();

   if ((text:!='')&&(SURROUND_MODE)) {
      text = SURROUND_PREFIX:+text;
   }

   return text;
}

static int ProcessVariableLengthEnding(int i,_str ch2,_str &alias,_str &aliasOut)
{
   startCol := i;
   endChar := '%';
   if (ch2=='(') endChar=')';
   i += 2;
   col := pos(endChar, alias, i);

   if (col == 0) {
      aliasOut = aliasOut :+ substr(alias, startCol);
      col = length(alias) + 1;
   } else {
      aliasOut = aliasOut :+ substr(alias, startCol, col + 1 - startCol);
   }
   return col;
}

static _str ProcessEscapeSequences(_str alias)
{
   aliasOut := '';
   searchString := '%';

   int lastCol, col;
   lastCol = col = 1;
   col = pos(searchString,  alias,  col,  'IR');
   while (col > 0) {
      // add up to this point
      aliasOut :+= substr(alias, lastCol, col - lastCol);

      // look for %/ combos
      ch := substr(alias, col + 1 ,1);
      switch (ch) {
      case '\':
         ch2 := upcase(substr(alias, col + 2, 1));
         if (ch2 == 'L' || ch2 == 'S') {
            lastCol = col = col + 3;
         } else if (ch2 == 'M') {
            lastCol = col = ProcessVariableLengthEnding(col, ch, alias, aliasOut) + 1;
         } else {
            aliasOut = aliasOut :+ substr(alias, col, 3);
            lastCol = col = col + 3;
         }
         break;
      default:
         lastCol = col = ProcessVariableLengthEnding(col, ch, alias, aliasOut) + 1;
         break;
      }

      col = pos(searchString,  alias,  col,  'IR');
   }

   aliasOut :+= substr(alias, lastCol, col - lastCol);

   return aliasOut;
}

//static void reallign(ALIAS_TYPE &alias)
static void reallign(_str (&alias)[])
{
   int size=alias._length();

   // one line alias - easy case
   if (size==1) {
      alias[0]=ProcessEscapeSequences(alias[0]);
      alias[0]=strip(alias[0],'l');
      if (substr(alias[0],1,1)=='(') alias[0]='%\L'alias[0];
      //This is a hack so that we can tell the paramaterized aliases from ones
      //that just start with a "("
      return;
   }

   //Is is a parameterized alias?
   boolean isparameterized=substr(alias[0],1,1)=='(';

   int firstaliasbodyline=0;
   int i=0;

   // get past the parameters
   if (isparameterized) {
      for (i=0;i<size;++i) {
         if (strip(alias[i])==')') {
            firstaliasbodyline=i+1;
            break;
         }
      }
   }

   //Now, lets line them up
   //First, make sure all are indented as far as first.
   int firstnonblank=pos('~[ ]',alias[0],1,'r');
   int curfirstnonblank=0;
   for (i=1;i<size;++i) {
      curfirstnonblank=pos('~[ ]',alias[i],1,'r');
      if (curfirstnonblank<firstnonblank) {
         int difference=firstnonblank-curfirstnonblank;
         alias[i]=substr('',1,difference,' '):+alias[i];
      }
   }

   //Next, find out which line has the fewest leading spaces, and eliminate
   //that many from the beginning of each line
   typeless leastblanks='';
   for (i=firstaliasbodyline;i<size;++i) {
      int numblanks=pos('~[ ]',alias[i],1,'r')-1;
      if (leastblanks==''||numblanks<leastblanks) {
         leastblanks=numblanks;
      }
   }
   for (i=firstaliasbodyline;i<size;++i) {
      alias[i]=substr(alias[i],leastblanks+1 );
      alias[i]=ProcessEscapeSequences(alias[i]);
   }

   if (!isparameterized && substr(alias[0],1,1)=='(') {
      alias[0]='%\L'alias[0];
   }
}

/**
 * Loads the aliases in the given file into the hash table.
 * 
 * @param filename            filename where aliases are located
 * @param hashtab             hashtable in which to load aliases
 * @param overwrite           whether to overwrite same named 
 *                            aliases.  If we find an alias with
 *                            the same name as one already in
 *                            the table, do we overwrite the
 *                            first one or ignore the second
 *                            one?
 *  
 * @return                    0 for success, error code 
 *                            otherwise
 */
int load_alias_file(_str filename, ALIAS_TYPE (&hashtab):[], boolean overwrite = false)
{
   mou_hour_glass(1);
   int inmem=1;
   int orig_view_id=p_window_id;
   int alias_view_id=0;
   int status=_open_temp_view(filename,alias_view_id,orig_view_id);
   if (status) {
      p_window_id=orig_view_id;
      mou_hour_glass(0);
      return status;
   }
   _str line='';
   _str name='';
   int done=0;
   p_window_id=alias_view_id;
   top();up();
   //find anything not a blank line
   while (!search('^?@( |$|\()','@r')){
      get_line(line);
      //skip lines that start with whitespace
      if (strip(line, 'L'):!=line) {
         if(down())break;
         continue;
      }
      int p=pos('( |$|\()',line,1,'r');
      name=substr(line,1,p-1);
      //if nothing after name
      if (pos('$',line,1,'r')==pos(name,line,1,'r')+1) {
         if(down())break;
         continue;
      }
      int value_count=0;
      if (overwrite || !hashtab._indexin(name)) {
         for (;;) {
            if (p) {
               //has parameter defs
               if (substr(line,p,1)=='(') {
                  hashtab:[name].value[value_count]=substr(line,p);
               }else{
                  //everything after space that follows name
                  _str value=substr(line,p+1);
                  _str prefix=substr('',1,p,' ');
                  hashtab:[name].value[value_count]=prefix:+substr(line,p+1);
               }
               for (;;) {
                  done=down();
                  if (done) break;
                  ++value_count;
                  get_line(line);
                  //next line that has something in first column signals end of alias
                  _str lastline=substr(line,1,1)!=' ';
                  if (lastline) break;
                  hashtab:[name].value[value_count]=line;
               }
            }
            break;
         }
      }else{
         if(down()) break;
         continue;
      }
      reallign(hashtab:[name].value);
      if (done) break;
      _begin_line();
   }
   _delete_temp_view(alias_view_id);
   p_window_id=orig_view_id;
   mou_hour_glass(0);
   return(0);
}

int _ctlae_alias_list.on_change(int reason)
{
   ALIAS_TYPE alias_table:[];
   alias_table=ALIAS_TABLE;
   _str alias[];

   typeless p;
   int wid=0;
   int isparameterized=0;
   int offset=0;
   _str varname='';
   _str prompt='';
   _str init='';
   _str line='';
   int status=0;
   int lp=0;
   int format=0;
   int i=0;

   switch (reason) {
   case CHANGE_CLINE:
   case CHANGE_OTHER:
   case CHANGE_SELECTED:
      _lbselect_line();
      if (LAST_EDITED_ALIAS==GetListBoxText()
          && arg(2)!=1) {
         return(0);
      }
      wid=p_window_id;p_window_id=_ctlae_edit_window;
      save_pos(p);
      p_line=0;
      if (!search('\t','r@')) {
         _message_box(nls("You cannot put tab characters in an alias.  Use %\\i for indenting - This will cause the alias to expand with tabs for buffers where Indent With Tabs is turned on."));
         _ctlae_alias_list._lbsearch(LAST_EDITED_ALIAS,def_alias_case);
         _ctlae_alias_list._lbselect_line();
         return(1);
      }
      restore_pos(p);
      isparameterized=0;offset=0;
      // IF there are any aliases
      if (_ctlae_alias_list.p_line) {
         // IF we need to save the previous alias value
         if (LAST_EDITED_ALIAS!='' &&
            (p_modify || ALIAS_PARAMS_MODIFIED)) {
            if (!p_Noflines) {//Dan added to handle the "No Line" case 10:37am 5/22/1996
               insert_line('');
            }

            // mark modified
            ALIAS_MODIFIED=1;

            // get any parameters that are there
            child := _ctlae_param_tree._TreeGetFirstChildIndex(TREE_ROOT_INDEX);
            if (child > 0) {
               ALIAS_PARAMS_MODIFIED=0;
               isparameterized=1;

               paramNum := 0;
               while (child > 0) {
                  ++offset;

                  caption := _ctlae_param_tree._TreeGetCaption(child);
                  parse caption with varname"\t"prompt"\t"init;
                  if (!paramNum) {
                     alias[paramNum]='('varname' "'prompt'" 'init;
                  }else{
                     alias[paramNum]=' 'varname' "'prompt'" 'init;
                  }
                  paramNum++;

                  // get the next one
                  child = _ctlae_param_tree._TreeGetNextSiblingIndex(child);
               }
               alias[paramNum]=' )';
               ++offset;
            }

            top();up();
            while (!down()) {
               get_line(line);
               if (substr(line,1,1)=='(') {
                  line='%\L'line;
               }
               p=pos('\%\(:v\)',line,1,'r');
               while (p) {
                  if (p) {
                     lp=pos(')',line,p);
                     _str varwp=substr(line,p,lp-p+1);
                     _str varwop=substr(varwp,3,length(varwp)-3);

                     index := _ctlae_param_tree._TreeSearch(TREE_ROOT_INDEX, varwop"\t",'ip');
                     if (index < 0 && get_env(varwop)=='') {
                        cont := _message_box(nls("Warning:\n\nThere is no environment variable or parameter for '%s'.  ":+
                                                 "Continue?",varwop), "Alias Parameters", MB_YESNO | MB_ICONEXCLAMATION);
                        if (cont == IDNO) {
                           _ctlae_alias_list._lbsearch(LAST_EDITED_ALIAS,def_alias_case);
                           _ctlae_alias_list._lbselect_line();
                           return(1);
                        }
                     }
                  }
                  p=pos('\%\(:v\)',line,lp+1,'r');
               }
               // set a blank line to %\l to preserve the spaces
               if (line=='') line='%\l';

               if (p_line>1 || offset) {
                  alias[p_line-1+offset]=/*prefix:+*/line;
               }else{
                  if (!(p_line-1) && substr(line,1,1)=='(') {
                     alias[p_line-1+offset]='%\L'line;
                  }else{
                     alias[p_line-1+offset]=line;
                  }
               }
            }
            alias_table:[LAST_EDITED_ALIAS].value=alias;
         }else if (p_modify) {
            ALIAS_MODIFIED=1;
         }

         // Switch to the new alias
         LAST_EDITED_ALIAS=GetListBoxText();
         _lbclear();
         _ctlae_param_tree._TreeDelete(TREE_ROOT_INDEX, 'C');
         //lastevent=event2name(test_event());
         alias=alias_table:[strip(GetListBoxText())].value;
         format=alias._varformat();
         for (i=0;i<alias._length();++i) {
            if (i) {
               line=alias[i];//substr(alias[i],2);
            }else{
               if (substr(alias[i],1,1)=='(') {
                  i+=fill_in_params(alias);
                  continue;
               }else if (substr(alias[i],1,3)=='%\L') {
                  line=substr(alias[i],4);
               }else{
                  line=alias[i];
               }
            }
            insert_line(line);
         }
         refresh();
         top();
         _begin_line();
         if (!p_Noflines) insert_line('');
         p_modify=0;
      } else {
         // there are no aliases to display, but we could
         // be switching in or out of  surround mode
         _ctlae_edit_window._lbclear();
         _ctlae_param_tree._TreeDelete(TREE_ROOT_INDEX, 'C');
         p_modify=0;
      }
   }
   typeless enabled='';
   if (!_ctlae_edit_window.p_enabled && _ctlae_alias_list.p_Noflines) {
      enabled=1;
   } else if (_ctlae_edit_window.p_enabled && !_ctlae_alias_list.p_Noflines) {
      enabled=0;
   }
   if (enabled!='') {
      _ctlae_edit_window.p_enabled=enabled;
      _ctlae_delete.p_enabled=enabled;
      _ctlae_param_tree.p_enabled=enabled;
      _ctlae_param_add.p_enabled=enabled;
      _ctlae_param_remove.p_enabled=enabled;
      _ctlae_param_edit.p_enabled=enabled;
      _ctlae_param_up.p_enabled=enabled;
      _ctlae_param_down.p_enabled=enabled;
   }

   enableParamButtons();

   ALIAS_TABLE=alias_table;
   return(0);
}

void _ctlae_param_tree.on_change(int reason)
{
   if (reason == CHANGE_SELECTED) enableParamButtons();
}

static void enableParamButtons()
{
   if (_ctlae_param_tree.p_enabled) {
      curIndex := _ctlae_param_tree._TreeCurIndex();
      if (curIndex > 0) {
         _ctlae_param_remove.p_enabled = _ctlae_param_edit.p_enabled = true;
         _ctlae_param_up.p_enabled = (_ctlae_param_tree._TreeGetPrevSiblingIndex(curIndex) > 0);
         _ctlae_param_down.p_enabled = (_ctlae_param_tree._TreeGetNextSiblingIndex(curIndex) > 0);
      } else {
         _ctlae_param_remove.p_enabled = _ctlae_param_edit.p_enabled =
            _ctlae_param_up.p_enabled = _ctlae_param_down.p_enabled = false;
      }
   }
}

static int fill_in_params(_str alias[])
{
   int i,found=0;
   for (i=0;i<alias._length();++i) {
      found=-1;
      if (strip(alias[i]==')')) {
         found=i;break;
      }
   }
   if (found<0) {
      for (i=0;i<alias._length();++i) {
         if (pos(')',alias[i])) {
            found=i;break;
         }
      }
   }
   if (found<0) {
      //Warn user or something (there is no closing paren
      _beep();
      _message_box(nls("PROBLEM"));
   }
   _str line='';
   for (i=0;i<alias._length();++i) {
      if (strip(alias[i])==')') break;
      if (substr(alias[i],1,1)=='(') {
         line=substr(alias[i],2);
      }else{
         line=alias[i];
      }
      _str varname='';
      _str prompt='';
      _str init='';
      parse line with varname '"' prompt '"' init;
      caption := strip(varname)"\t"strip(prompt)"\t"strip(init);
      _ctlae_param_tree._TreeAddItem(TREE_ROOT_INDEX, caption, TREE_ADD_AS_CHILD, 0, 0, TREE_NODE_LEAF);
   }
   return(i);
}

static int write_alias_file(_str filename,ALIAS_TYPE (&alias_table):[])
{
   //ALIAS_TYPE alias_table;
   int alias_view_id=0;
   int orig_view_id=0;
   int status=_open_temp_view(filename,alias_view_id,orig_view_id);
   if (status) {
      orig_view_id=_create_temp_view(alias_view_id);
      p_buf_name=absolute(filename);
   }
   p_window_id=alias_view_id;
   _lbclear();

   _str line='';
   _str prefix='';
   typeless curalias;
   int size=0;
   int count=0;
   int i=0;
   boolean isparameterized=0;

   // go through each of the aliases in the table
   typeless name;
   for (name._makeempty();;) {

      // get the name of the next one
      alias_table._nextel(name);
      if (name._isempty()) break;

      // get the alias itself
      curalias=alias_table:[name].value;
      size=curalias._length();
      isparameterized=substr(curalias[0],1,1)=='(';

      // does this alias have parameters?
      if (isparameterized) {
         //First we'll write out all the parameter stuff
         insert_line(name:+curalias[0]);
         count=1;
         do {
            line=strip(curalias[count]);
            line=substr('',1,length(name' '),' '):+line;
            insert_line(line);
         } while ( strip(curalias[count++])!=')' );

         //Now do the body part
         for (i=count;i<size;++i) {
            if (i==count && substr(curalias[i],1,1)==' ') {
               curalias[i]='%\L':+curalias[i];
            }
            if (last_char(curalias[i]):==' ') {
               curalias[i]=curalias[i]'%\S';
            }
            insert_line(' 'curalias[i]);
         }
      }else{
         // no parameters here, this should be simple
         // we have leading spaces, better let them stay
         if (substr(curalias[0],1,1)==' ') {
            curalias[0]='%\L'curalias[0];
         }

         prefix._makeempty();
         for (i=0;i<size;++i) {
            // does this end with a space?  preserve it!
            if (curalias[i] == '') {
               curalias[i]='%\l';
            } else if (last_char(curalias[i]):==' ') {
               curalias[i]=curalias[i]'%\S';
            }

            if (i) {
               insert_line(prefix' 'curalias[i]);
            }else{
               insert_line(name' 'curalias[0]);
               prefix=substr('',1,length(name),' ');
            }
         }
      }
   }
   status=_save_config_file(filename);//Backup options?
   if (status) {
      _message_box(nls("Could not save file %s.\n\n%s",filename,get_message(status)));
      return(status);
   }
   _delete_temp_view(alias_view_id);
   orig_view_id=p_window_id;
   return(status);
}

static int lastpixel_y(int wid)
{
   return(wid.p_y+wid.p_height);
}

void _ctlae_ok.lbutton_up()
{
   int fid=p_active_form;

   status := false;
   if (_alias_editor_form_is_modified()) {
      status = _alias_editor_form_apply();
   }

   fid._delete_window(status);
}

int _validnewaliasname(_str name,typeless *hashtabptr)
{
   _str test_name=strip(name); // first thing done after dialog returns

   if (SURROUND_MODE) {
      // surround with aliases can contain whitespace since the user
      // won't be typing these in to expand them
      test_name=translate(SURROUND_PREFIX:+test_name,'__'," \t");
   }
   if (pos(" |\t",test_name,1,'r')) {
      _message_box(nls("Alias names may not contain whitespace."));
      return(1);
   }
   if (pos('\(|\)|\$',test_name,1,'r')) {
      _message_box(nls("Alias names may not contain (, ), or $.  "));
      return(1);
   }
   if (hashtabptr->_indexin(test_name)) {
      _message_box(nls("An alias %s already exists.",strip(name)));
      return(1);
   }
   return(0);
}

void _ctlae_new.lbutton_up()
{
   ALIAS_TYPE alias_table:[];
   alias_table=ALIAS_TABLE;
   status := 1;
   _str newaliasname = '';
   while (true) {
      result := textBoxDialog('Enter New Alias Name',                 // form caption
                    0,                                      // flags
                    0,                                      // text box width
                    'Enter New Alias Name dialog',          // help item
                    '',                                     // buttons and captions
                    '',                                     // retrieve name
                    'Alias Name:'newaliasname);             // prompt

      if (result == COMMAND_CANCELLED_RC || _param1 == '') return;

      newaliasname = strip(_param1);

      if (!_validnewaliasname(newaliasname, &alias_table)) break;

   }
   
   ALIAS_MODIFIED=1;
   _str newaliastext='';
   // alias_table:[newaliasname][0][0]
   //trace
   _str fullaliasname='';
   if (SURROUND_MODE) {
      newaliasname=translate(newaliasname,'__'," \t");
      fullaliasname=SURROUND_PREFIX:+newaliasname;
      newaliastext="%\\m sur_text -indent%";
   } else {
      fullaliasname=newaliasname;
   }
   alias_table:[fullaliasname].value[0]='';
   int wid=p_window_id;p_window_id=_ctlae_alias_list;
   _lbdeselect_all();
   _lbadd_item(newaliasname);
   _lbsort();
   _lbsearch(newaliasname,def_alias_case);
   // This call centers the line in the list box.
   //set_scroll_pos(p_left_edge,p_client_height intdiv 2);
   _lbselect_line();
   p_window_id=wid;
   typeless x=ALIAS_TABLE;

   _ctlae_alias_list.call_event(CHANGE_OTHER,defeventtab _alias_editor_form._ctlae_alias_list,ON_CHANGE,'E');
   //Dan added this to save blank aliases 10:20am 5/22/1996
   //LAST_EDITED_ALIAS=newaliasname;

   //DJB 11-19-2006 -- insert %\m sur_text -indent% for surround aliases
   _ctlae_edit_window._insert_text(newaliastext);

   //Dan added this to save blank aliases 10:20am 5/22/1996
   _ctlae_edit_window.p_modify=1;

   _ctlae_edit_window._set_focus();
}

void _ctlae_delete.lbutton_up()
{
   ALIAS_TYPE alias_table:[];
   alias_table=ALIAS_TABLE;
   ALIAS_MODIFIED=1;
   int wid=p_window_id;p_window_id=_ctlae_alias_list;
   _str name=GetListBoxText();
   _lbdelete_item();
   alias_table._deleteel(name);
   _lbdeselect_all();
   _ctlae_alias_list.call_event(CHANGE_SELECTED,defeventtab _alias_editor_form._ctlae_alias_list,ON_CHANGE,'E');
   _lbselect_line();
   if (!p_Noflines) {
      _ctlae_edit_window._lbclear();
   }
   p_window_id=wid;
   ALIAS_TABLE=alias_table;
}

void _ctlae_cancel.lbutton_up()
{
   if (ALIAS_MODIFIED || _ctlae_edit_window.p_modify) {
      aliasfilename := _GetDialogInfoHt('aliasFilename');
      if (aliasfilename == '' || aliasfilename == null || !file_exists(aliasfilename)) {
         return;
      }
      aliasfilename = strip(maybe_quote_filename(aliasfilename));
      int result = _message_box(nls("%s has been modified.\n\nExit anyway?", aliasfilename),
                          '',
                          MB_YESNO|MB_ICONQUESTION);
      if (result != IDYES) return;
   }

   // return the value false to state that we did not modify anything
   p_active_form._delete_window(false);
}

int _validnewparamcheck(_str str,_str fieldnum)
{
   int status=0;
   typeless wid=0;
   _str data='';
   parse fieldnum with fieldnum '$' data ;
   switch (fieldnum) {
   case 1://Varname
      wid=data;
      if (!isid_valid(str)) {
         _message_box(nls("%s is not a valid identifier.",str));
         return(1);
      }
      status=wid._TreeSearch(TREE_ROOT_INDEX, str"\t",'ip');
      if (status>0) {
         _message_box(nls("%s already exists.",str));
         return(1);
      }
      return(0);
   case 2://Prompt
      if (str=='') {
         _message_box(nls("You must specify a prompt."));
         return(1);
      }
      if (pos('"',str)) {
         _message_box(nls("Prompt may not contain quotes."));
         return(1);
      }
      return(0);
   case 3://Varname, don't check to see if exists
      if (!isid_valid(str)) {
         _message_box(nls("%s is not a valid identifier.",str));
         return(1);
      }
      return(0);
   }
   return(0);
}

void _ctlae_param_add.lbutton_up()
{
   typeless result=show('-modal _textbox_form',
               'Enter Alias Parameter',
               0,//Flags,
               '',//Tb width
               'Enter Alias Parameter dialog',//help item
               '',//Buttons and captions
               '',//retrieve name
               '-e _validnewparamcheck:1$'_ctlae_param_tree' Parameter Name:',
               '-e _validnewparamcheck:2 Prompt:',
               'Initial Value:');
   if (result=='') return;
   _str varname=_param1;
   _str promptstr=_param2;
   _str initval=_param3;
   int wid=p_window_id;
   caption := varname"\t"promptstr"\t"initval;
   _ctlae_param_tree._TreeAddItem(TREE_ROOT_INDEX, caption, TREE_ADD_AS_CHILD, 0, 0, TREE_NODE_LEAF);
   enableParamButtons();
   ALIAS_PARAMS_MODIFIED=1;
}

void _ctlae_param_edit.lbutton_up()
{
   curIndex := _ctlae_param_tree._TreeCurIndex();
   if (curIndex < 0) return;
   _str varname='';
   _str promptstr='';
   _str initval='';
   caption := _ctlae_param_tree._TreeGetCaption(curIndex);
   parse caption with varname"\t"promptstr"\t"initval;
   typeless result=show('-modal _textbox_form',
               'Edit Alias Parameter',
               0,//Flags,
               '',//Tb width
               'Edit Alias Parameter dialog',//help item
               '',//Buttons and captions
               '',//retrieve name
               '-e _validnewparamcheck:3 Parameter Name:'varname,
               '-e _validnewparamcheck:2 Prompt:'promptstr,
               'Initial Value:'initval);
   if (result=='') return;
   varname=_param1;
   promptstr=_param2;
   initval=_param3;
   _ctlae_param_tree._TreeSetCaption(curIndex, varname"\t"promptstr"\t"initval);
   ALIAS_PARAMS_MODIFIED=1;
}

_ctlae_param_up.lbutton_up()
{
   ALIAS_MODIFIED=1;
   ALIAS_PARAMS_MODIFIED=1;
   index := _ctlae_param_tree._TreeCurIndex();
   _ctlae_param_tree._TreeMoveUp(index);
   enableParamButtons();
}

_ctlae_param_down.lbutton_up()
{
   ALIAS_MODIFIED=1;
   ALIAS_PARAMS_MODIFIED=1;
   index := _ctlae_param_tree._TreeCurIndex();
   _ctlae_param_tree._TreeMoveDown(index);
   enableParamButtons();
}

void _ctlae_param_remove.lbutton_up()
{
   index := _ctlae_param_tree._TreeCurIndex();
   _ctlae_param_tree._TreeDelete(index);
   enableParamButtons();
   ALIAS_MODIFIED=1;
   ALIAS_PARAMS_MODIFIED=1;
}

static void set_vis_all(int parentwid,boolean vis_val)
{
   int first=parentwid.p_child;
   int wid=parentwid.p_child;
   for (;;) {
      wid.p_visible=vis_val;
      wid=wid.p_next;
      if (wid==first) break;
   }
}

static void children_visible(int widlist){set_vis_all(widlist,1);}

static void children_invisible(int widlist){set_vis_all(widlist,0);}

#define gui_small_gap      30
#define gui_medium_gap     90
#define gui_large_gap      180
#define gui_xlarge_gap     315


/**
 * Does any necessary adjustment of auto-sized controls.
 */
static void _alias_editor_form_initial_alignment()
{
   ctlAliasEscapeSeqButton.p_x = (_ctlae_edit_window.p_x + _ctlae_edit_window.p_width) - ctlAliasEscapeSeqButton.p_width;
   ctl_escapeSeq_label.p_x = ctlAliasEscapeSeqButton.p_x - (ctl_escapeSeq_label.p_width + 25);

   // set this right on top of the editor control
   if (ctlAliasEscapeSeqButton.p_height > ctl_escapeSeq_label.p_height) {
      ctlAliasEscapeSeqButton.p_y = _ctlae_edit_window.p_y - ctlAliasEscapeSeqButton.p_height;
      _ctlae_surround.p_y = ctl_escapeSeq_label.p_y = ctlAliasEscapeSeqButton.p_y - ((ctlAliasEscapeSeqButton.p_height - ctl_escapeSeq_label.p_height) intdiv 2);
   } else {
      _ctlae_surround.p_y = ctl_escapeSeq_label.p_y = _ctlae_edit_window.p_y - ctl_escapeSeq_label.p_height;
      ctlAliasEscapeSeqButton.p_y = ctl_escapeSeq_label.p_y + ((ctl_escapeSeq_label.p_height - ctlAliasEscapeSeqButton.p_height) intdiv 2);
   }

   _ctlae_param_edit.p_auto_size = false;
   _ctlae_param_edit.p_width = _ctlae_param_add.p_width;
   _ctlae_param_edit.p_height = _ctlae_param_add.p_height;

   // parameter tree buttons
   alignUpDownListButtons(_ctlae_param_tree, _ctlae_edit_window.p_x + _ctlae_edit_window.p_width,
                          _ctlae_param_add, _ctlae_param_edit, _ctlae_param_up, _ctlae_param_down,
                          _ctlae_param_remove);
}

static void shift_alias_controls_up()
{
   yDiff := _ctlae_alias_list.p_y - _ctl_filename.p_y;

   _ctlae_alias_list.p_y -= yDiff;
   _ctlae_alias_list.p_height += yDiff;
   _ctlae_surround.p_y -= yDiff;
   ctl_escapeSeq_label.p_y -= yDiff;
   ctlAliasEscapeSeqButton.p_y -= yDiff;
   _ctlae_edit_window.p_y -= yDiff;
   _ctlae_edit_window.p_height += yDiff;
}

void _alias_editor_form.on_resize()
{
   optionsDialog := !_ctlae_ok.p_visible;
   /*
   expandVisible := _ctl_expand_on_space.p_visible;
   */

   // the filename label goes away outside the options dialog
   if (p_active_form.p_visible && !optionsDialog && (_ctlae_alias_list.p_y != _ctl_filename.p_y)) {
      shift_alias_controls_up();
   }

   _control _ctlae_help;
   children_invisible(p_active_form);

   padding := _ctlae_alias_list.p_x;
   widthDiff := p_width - (_ctlae_edit_window.p_x + _ctlae_edit_window.p_width + padding);
   heightDiff := 0;

   /*
   if (expandVisible) {
      heightDiff = p_height - (_ctl_expand_on_space.p_y + _ctl_expand_on_space.p_height + padding);
      _ctl_expand_on_space.p_y += heightDiff;

      _ctl_lower_divider.p_y+=heightDiff;
      _ctl_lower_divider.p_width+=widthDiff;
   } else {
      */
      heightDiff = p_height - (_ctlae_param_tree.p_y + _ctlae_param_tree.p_height + padding);
      /*
   }
   */

   _ctlae_alias_list.p_height+=heightDiff;
   _ctlae_edit_window.p_height+=heightDiff;
   _ctlae_edit_window.p_width+=widthDiff;

   // row of alias buttons
   _ctlae_help.p_y+=heightDiff;
   _ctlae_ok.p_y=_ctlae_new.p_y=_ctlae_delete.p_y=_ctlae_cancel.p_y=_ctlae_help.p_y;

   // divider
   _ctlae_labeldiv.p_y+=heightDiff;
   _ctlae_labeldiv.p_width+=widthDiff;

   // parameter list
   _ctlae_param_labelt.p_y += heightDiff;
   _ctlae_param_labelt.p_width += widthDiff;
   _ctlae_param_tree.p_y+=heightDiff;
   _ctlae_param_tree.p_width+=widthDiff;

   // parameter buttons
   _ctlae_param_down.p_y+=heightDiff;
   _ctlae_param_add.p_y+=heightDiff;
   _ctlae_param_remove.p_y+=heightDiff;
   _ctlae_param_edit.p_y+=heightDiff;
   _ctlae_param_up.p_y+=heightDiff;

   _ctlae_param_add.p_x+=widthDiff;
   _ctlae_param_remove.p_x=_ctlae_param_edit.p_x=_ctlae_param_up.p_x=_ctlae_param_down.p_x=_ctlae_param_add.p_x;

   // insert escape sequence stuff
   ctlAliasEscapeSeqButton.p_x += widthDiff;
   ctl_escapeSeq_label.p_x += widthDiff;

   // show everything again
   children_visible(p_active_form);
   if (optionsDialog) {
      _ctlae_ok.p_visible = false;
      _ctlae_cancel.p_visible = false;
      _ctlae_help.p_visible = false;
   } else {
      _ctl_filename.p_visible = false;
   }

   /*
   if (!expandVisible) {
      _ctl_expand_on_space.p_visible = false;
      _ctl_lower_divider.p_visible = false;
   }
   */
}
_command int edit_extension_alias(_str ext='')
{
   // do they want to edit surround with aliases?
   boolean editSurround=false;
   _str option, rest;
   parse ext with option rest;
   if (option=='-surround') {
      ext = rest;
      editSurround=true;
   }

   // make sure we have the file extension
   lang := ext;
   if ( ext != '' ) {
      lang = _Ext2LangId(ext);
      if (lang == '') {
         // if nothing came up, try the lowcase version
         lang = _Ext2LangId(lowcase(ext));
      }
   }else{
      lang = p_LangId;
   }

   modeName := _LangId2Modename(lang);
   showOptionsForModename(modeName, 'Aliases');
   return(0);
}
