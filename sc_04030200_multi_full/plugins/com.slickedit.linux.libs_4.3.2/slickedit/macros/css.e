////////////////////////////////////////////////////////////////////////////////////
// $Revision: 42496 $
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
#import "adaptiveformatting.e"
#require "se/lang/api/LanguageSettings.e"
#import "c.e"
#import "cutil.e"
#import "pmatch.e"
#import "slickc.e"
#import "smartp.e"
#import "stdcmds.e"
#import "stdprocs.e"
#endregion

using se.lang.api.LanguageSettings;

#define CSS_LANG_ID    'css'
#define CSS_MODE_NAME  'CSS'
#define CSS_LEXERNAME  'CSS'
#define CSS_WORDCHARS  'A-Za-z0-9_'

defload()
{
   _str setup_info='MN='CSS_MODE_NAME',TABS=+4,MA=1 74 1,':+
                   'KEYTAB='CSS_LANG_ID'-keys,WW=1,IWT=0,ST=0,IN=2,WC='CSS_WORDCHARS',LN='CSS_LEXERNAME',CF=1,LNL=0,TL=0,BNDS=,CAPS=0,SW=0,SOW=0,';
   _str compile_info='';
   _str syntax_info='4 1 1 0 0 3 0';
   _str be_info='';
   _CreateLanguage(CSS_LANG_ID, CSS_MODE_NAME, setup_info, compile_info, syntax_info, be_info);
   _CreateExtension("css", CSS_LANG_ID);
}

_command void css_mode() name_info(','VSARG2_REQUIRES_EDITORCTL|VSARG2_READ_ONLY|VSARG2_ICON)
{
   _SetEditorLanguage(CSS_LANG_ID);
}

defeventtab css_keys;
def 'ENTER'=css_enter;
def '}'=css_endbrace;

static int _css_indent_brace(int syntax_indent)
{
   int col = 0;
   save_pos(auto p);
   left(); _clex_skip_blanks('-');
   int status = search('[{};]', "-rh@XSC");
   for (;;) {
      if (status) {
         restore_pos(p);
         return(0);
      }
      _str ch = get_text();
      switch (ch) {
      case '{':
         first_non_blank();
         col = p_col + syntax_indent;
         restore_pos(p);
         return(col);
      case '}':
         save_search(auto s1, auto s2, auto s3, auto s4, auto s5);
         status = _find_matching_paren(def_pmatch_max_diff, true);
         restore_search(s1, s2, s3, s4, s5);
         if (status) {
            restore_pos(p);
            return(0);
         }
         first_non_blank();
         col = p_col;
         restore_pos(p);
         return(col);
      case ';':
         restore_pos(p);
         return(0);
      }
      if (!status) {
         status = repeat_search();
      }
   }
   restore_pos(p);
   return(0);
}

boolean _css_expand_enter()
{
   updateAdaptiveFormattingSettings(AFF_SYNTAX_INDENT);
   syntax_indent := p_SyntaxIndent;
   
   if (name_on_key(ENTER):=='nosplit-insert-line') {
      _end_line();
   }
   int col = _css_indent_brace(syntax_indent);
   if (col) {
      indent_on_enter(0, col);
      return(false);
   }
   return(true);
}

_command void css_enter() name_info(','VSARG2_CMDLINE|VSARG2_REQUIRES_EDITORCTL|VSARG2_LASTKEY)
{
   generic_enter_handler(_css_expand_enter);
}

static int _css_endbrace_col(int be_style)
{
   save_pos(auto p);
   --p_col;
   // Find matching begin brace
   int status=_find_matching_paren(def_pmatch_max_diff);
   if (status) {
      restore_pos(p);
      return(0);
   }
   // Assume end brace is at level 0
   if (p_col==1) {
      restore_pos(p);
      return(1);
   }
   first_non_blank();
   int col = p_col;
   if (be_style == BES_BEGIN_END_STYLE_3) {
      col+=p_SyntaxIndent;
   }
   restore_pos(p);
   return(col);
}

_command void css_endbrace() name_info(','VSARG2_CMDLINE|VSARG2_REQUIRES_EDITORCTL)
{
   keyin('}');
   if ( command_state() || p_window_state:=='I' ||
      p_SyntaxIndent<0 || p_indent_style!=INDENT_SMART ||
      _in_comment() ) {
   } else if (_argument=='') {
      _str line="";
      get_line(line);
      if (line=='}') {
         int col=_css_endbrace_col(LanguageSettings.getBeginEndStyle(p_LangId));
         if (col) {
            replace_line(indent_string(col-1):+'}');
            p_col=col+1;
         }
      }
      _undo('S');
   }
}

int css_smartpaste(boolean char_cbtype,int first_col,int Noflines,boolean allow_col_1=false)
{
   return(c_smartpaste(char_cbtype,first_col,Noflines,allow_col_1));
}
