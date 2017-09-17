////////////////////////////////////////////////////////////////////////////////////
// $Revision: 46084 $
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
#include "tagsdb.sh"
#include "color.sh"
#import "adaptiveformatting.e"
#import "alias.e"
#import "autocomplete.e"
#import "c.e"
#import "cutil.e"
#import "notifications.e"
#import "pmatch.e"
#import "se/lang/api/LanguageSettings.e"
#import "setupext.e"
#import "slickc.e"
#import "stdcmds.e"
#import "stdprocs.e"
#import "surround.e"
#import "tags.e"
#import "util.e"
#endregion

using se.lang.api.LanguageSettings;

/*
  Don't modify this code unless defining extension specific
  aliases do not suit your needs.   For example, if you
  want your brace style to be:

       if [] {
          }

  Use the Extension Options dialog box ("Other", "Configuration...",
  "File Extension Setup...") and press the the "Alias" button to
  display the Alias Editor dialog box.  Press the New button, type
  "if" for the name of the alias and press <Enter>.  Enter the
  following text into the upper right editor control:

       if [%\c] {
       %\i}

  The  %\c indicates where the cursor will be placed after the
  "if" alias is expanded.  The %\i specifies to indent by the
  Extension Specific "Syntax Indent" amount define in the
  "Extension Options" dialog box.  Check the "Indent With Tabs"
  check box on the Extension Options dialog box if you want
  the %\i option to indent using tab characters.

*/
/*
  Options for TCL syntax expansion/indenting may be accessed from the
  Extension Options dialog ("Other", "Configuration...",
  "File Extension Setup...").

  The extension specific options is a string of five numbers separated
  with spaces with the following meaning:

    Position       Option
       1             Minimum abbreviation.  Defaults to 1.  Specify large
                     value to avoid abbreviation expansion.
       2             reserved.
       3             begin/end style.  Begin/end style may be 0,1, or 2
                     as show below.  Add 4 to the begin end style if you
                     want braces inserted when syntax expansion occurs
                     (main and do insert braces anyway).  Typing a begin
                     brace, '{', inserts an end brace when appropriate
                     (unless you unbind the key).  If you want a blank
                     line inserted in between, add 8 to the begin end
                     style.  Default is 4.

                      Style 0
                          if [] {
                             ++i;
                          }

                      Style 1
                          if []
                          {
                             ++i;
                          }

                      Style 2
                          if []
                            {
                            ++i;
                            }


       4             Indent first level of code.  Default is 1.
                     Specify 0 if you want first level statements to
                     start in column 1.
*/

#define TCL_MODE_NAME 'Tcl'
#define TCL_LANGUAGE_ID 'tcl'

defeventtab tcl_keys;
def  ' '= tcl_space;
def  '{'= tcl_begin;
def  '}'= tcl_endbrace;
def  'ENTER'= tcl_enter;

defload()
{
   _str setup_info='MN='TCL_MODE_NAME',TABS=+8,MA=1 74 1,':+
               'KEYTAB='TCL_MODE_NAME'-keys,WW=1,IWT=0,ST=0,':+
               'IN=2,WC=A-Za-z0-9_$,LN=tcl,CF=1,';
   _str compile_info='0 tcl *;';
   _str syntax_info='4 1 1 0 4 1 0';
   _str be_info='';
   
   _CreateLanguage(TCL_LANGUAGE_ID, TCL_MODE_NAME,
                   setup_info, compile_info, syntax_info, be_info);
   _CreateExtension('tcl', TCL_LANGUAGE_ID);
   _CreateExtension('itk', TCL_LANGUAGE_ID);
   _CreateExtension('exp', TCL_LANGUAGE_ID);
   _CreateExtension('tlib', TCL_LANGUAGE_ID);
   _CreateExtension('itcl', TCL_LANGUAGE_ID);
}

_command void tcl_mode() name_info(','VSARG2_REQUIRES_EDITORCTL|VSARG2_READ_ONLY|VSARG2_ICON)
{
   _SetEditorLanguage(TCL_LANGUAGE_ID);
}
_command void tcl_enter() name_info(','VSARG2_CMDLINE|VSARG2_ICON|VSARG2_REQUIRES_EDITORCTL|VSARG2_READ_ONLY)
{
   generic_enter_handler(_tcl_expand_enter, true);
}
_command void tcl_space() name_info(','VSARG2_CMDLINE|VSARG2_REQUIRES_EDITORCTL|VSARG2_LASTKEY)
{
   if ( command_state() || ! doExpandSpace(p_LangId) || p_SyntaxIndent<0 ||
      _in_comment() ||
         tcl_expand_space() ) {
      if ( command_state() ) {
         call_root_key(' ');
      } else {
         keyin(' ');
      }
   } else if (_argument=='') {
      _undo('S');
   }
}
_command void tcl_begin() name_info(','VSARG2_REQUIRES_EDITORCTL|VSARG2_CMDLINE)
{
   if ( command_state() || _in_comment() || tcl_expand_begin() ) {
      call_root_key('{');
   } else if (_argument=='') {
      _undo('S');
   }

}
_command void tcl_endbrace() name_info(','VSARG2_CMDLINE|VSARG2_REQUIRES_EDITORCTL)
{
   keyin('}');

   if ( command_state() || p_window_state:=='I' ||
      p_SyntaxIndent<0 || p_indent_style!=INDENT_SMART ||
      _in_comment() ) {
   } else if (_argument=='') {
      _str line="";
      get_line(line);
      if (line=='}') {
         typeless col=tcl_endbrace_col();
         if (col) {
            replace_line(indent_string(col-1):+'}');
            p_col=col+1;
         }
      }
      _undo('S');
   }
}

/* Returns column where end brace should go.
   Returns 0 if this function does not know the column where the
   end brace should go.
 */
int tcl_endbrace_col()
{
   if (p_lexer_name=='') {
      return(0);
   }
   save_pos(auto p);
   --p_col;
   // Find matching begin brace
   typeless status=_find_matching_paren(def_pmatch_max_diff);
   if (status) {
      restore_pos(p);
      return(0);
   }
   // Assume end brace is at level 0
   if (p_col==1) {
      restore_pos(p);
      return(1);
   }
   int begin_brace_col=p_col;
   // Check if the first char before open brace is close paren
   int col= find_block_col();
   if (!col) {
      restore_pos(p);
      return(0);
   }
   updateAdaptiveFormattingSettings(AFF_BEGIN_END_STYLE);
   if (p_begin_end_style == BES_BEGIN_END_STYLE_2 || p_begin_end_style == BES_BEGIN_END_STYLE_3) {
      restore_pos(p);
      return(begin_brace_col);
   }
   restore_pos(p);
   return(col);
}
static boolean linecont()
{
   _end_line();
   left();
   return(get_text()=='\');
}
#define BLOCK_WORDS ' for foreach if elseif proc switch while '
static int find_block_col()
{
   --p_col;
   if (_clex_skip_blanks('-')) return(0);
   /*
       Take advange of the fact that code is written like

          foreach -option {
          }
          foreach -option \
          {
          }

       and not like
          foreach -option
                {
          }

       This function does not find always find the beginning
       of a block in BLOCK_WORDS, but it helps in implementing
       the tcl_endbrace_col function.

   */
   while (get_text()=='}' || get_text()==']') {
      if (_find_matching_paren(def_pmatch_max_diff)) return(0);
      if (p_col==1) return(1);
      --p_col;
      if (_clex_skip_blanks('-')) return(0);
   }
   for (;;) {
      up();
      if (!linecont()) {
         down();
         break;
      }
   }
   first_non_blank();
   return(p_col);
}
#if 0
static int find_block_col()
{
   --p_col;
   if (_clex_skip_blanks('-')) return(0);
   while (_clex_find(0,'g')!=CFG_KEYWORD) {
      if (get_text()=='}') {
         if (_find_matching_paren(def_pmatch_max_diff)) return(0);
      } else {
         word_chars := _clex_identifier_chars();
         if (search('\c[~'word_chars']','@rh-')) return(0);
      }
      if (p_col==1) return(1);
      --p_col;
      if (_clex_skip_blanks('-')) return(0);
   }
   word=cur_word(col);
   if (pos(' 'word' ',BLOCK_WORDS)) {
      first_non_blank();
      return(p_col);
      //return(p_col-length(word)+1);
   }
   return(0);
}
#endif


/*
   TCL built-ins

AddErrInfo
after
Alloc
AllowExc
append
AppInit
array
AssocData
Async
BackgdErr
Backslash
bgerror
binary
BoolObj
break
CallDel
case
catch
cd
clock
close
CmdCmplt
Concat
concat
continue
CrtChannel
CrtChnlHdlr
CrtCloseHdlr
CrtCommand
CrtFileHdlr
CrtInterp
CrtMathFnc
CrtObjCmd
CrtSlave
CrtTimerHdlr
CrtTrace
DetachPids
DoOneEvent
DoubleObj
DoWhenIdle
DString
eof
error
Eval
eval
EvalObj
exec
Exit
exit
expr
ExprLong
ExprLongObj
fblocked
fconfigure
fcopy
file
fileevent
filename
FindExec
flush
for
foreach
format
GetIndex
GetInt
GetOpnFl
gets
GetStdChan
glob
global
Hash
history
http
if
incr
info
Interp
interp
IntObj
join
lappend
library
license.ter
lindex
LinkVar
linsert
list
ListObj
llength
load
lrange
lreplace
lsearch
lsort
man.macr
namespace
Notifier
Object
ObjectType
ObjSetVar
open
OpenFileChnl
OpenTcp
package
pid
pkgMkIndex
PkgRequire
Preserve
PrintDbl
proc
puts
pwd
read
RecEvalObj
RecordEval
RegExp
regexp
registry
regsub
rename
resource
return
safe
scan
seek
set
SetErrno
SetRecLmt
SetResult
SetVar
Sleep
socket
source
split
SplitList
SplitPath
StaticPkg
string
StringObj
StrMatch
subst
switch
Tcl
Tcl_Main
tclsh
tclvars
tell
time
trace
TraceVar
Translate
unknown
unset
update
uplevel
UpVar
upvar
variable
vwait
while
WrongNumAr
*/



#define TCL_EXPAND_WORDS ' catch for foreach if elseif proc switch while '
static SYNTAX_EXPANSION_INFO tcl_space_words:[] = {
   'after'              => { "after" },
   'append'             => { "append" },
   'array'              => { "array" },
   'array anymore'      => { "array anymore" },
   'array donesearch'   => { "array donesearch" },
   'array names'        => { "array names" },
   'array nextelement'  => { "array nextelement" },
   'array size'         => { "array size" },
   'array startsearch'  => { "array startsearch" },
   'bgerror'            => { "bgerror" },
   'binary'             => { "binary" },
   'break'              => { "break;" },
   'case'               => { "case" },
   'catch'              => { "catch { ... }" },
   'cd'                 => { "cd" },
   'clock'              => { "clock" },
   'concat'             => { "concat" },
   'continue'           => { "continue;" },
   'default'            => { "default" },
   'else'               => { "else { ... }" },
   'elseif'             => { "elseif { ... } { ... }" },
   'eof'                => { "eof" },
   'error'              => { "error" },
   'exec'               => { "exec" },
   'exit'               => { "exit" },
   'expr'               => { "expr" },
   'fconfigure'         => { "fconfigure" },
   'fcopy'              => { "fcopy" },
   'file'               => { "file" },
   'file atime'         => { "file atime" },
   'file dirname'       => { "file dirname" },
   'file executable'    => { "file executable" },
   'file exists'        => { "file exists" },
   'file extension'     => { "file extension" },
   'file isdirectory'   => { "file isdirectory" },
   'file isfile'        => { "file isfile" },
   'file lstat'         => { "file lstat" },
   'file mtime'         => { "file mtime" },
   'file owned'         => { "file owned" },
   'file readable'      => { "file readable" },
   'file readlink'      => { "file readlink" },
   'file rootname'      => { "file rootname" },
   'file size'          => { "file size" },
   'file stat'          => { "file stat" },
   'file tail'          => { "file tail" },
   'file type'          => { "file type" },
   'file writable'      => { "file writable" },
   'fileevent'          => { "fileevent" },
   'filename'           => { "filename" },
   'flbocked'           => { "flbocked" },
   'flush'              => { "flush" },
   'for'                => { "for { ... } { ... } { ... } { ... }" },
   'foreach'            => { "foreach ... { ... }" },
   'format'             => { "format" },
   'gets'               => { "gets" },
   'glob'               => { "glob" },
   'global'             => { "global" },
   'history'            => { "history" },
   'history keep'       => { "history keep" },
   'history nextid'     => { "history nextid" },
   'history redo'       => { "history redo" },
   'history substitute' => { "history substitute" },
   'http'               => { "http" },
   'if'                 => { "if { ... } { ... }" },
   'incr'               => { "incr" },
   'info'               => { "info" },
   'info args'          => { "info args" },
   'info body'          => { "info body" },
   'info cmdcount'      => { "info cmdcount" },
   'info commands'      => { "info commands" },
   'info default'       => { "info default" },
   'info exists'        => { "info exists" },
   'info globals'       => { "info globals" },
   'info level'         => { "info level" },
   'info library'       => { "info library" },
   'info locals'        => { "info locals" },
   'info procs'         => { "info procs" },
   'info script'        => { "info script" },
   'info tclversion'    => { "info tclversion" },
   'info vars'          => { "info vars" },
   'join'               => { "join" },
   'lappend'            => { "lappend" },
   'library'            => { "library" },
   'lindex'             => { "lindex" },
   'linsert'            => { "linsert" },
   'list'               => { "list" },
   'llength'            => { "llength" },
   'load'               => { "load" },
   'lrange'             => { "lrange" },
   'lreplace'           => { "lreplace" },
   'lsearch'            => { "lsearch" },
   'lsort'              => { "lsort" },
   'namespace'          => { "namespace" },
   'open'               => { "open" },
   'package'            => { "package" },
   'pid'                => { "pid" },
   'proc'               => { "proc ... { ... } { ... }" },
   'puts'               => { "puts" },
   'pwd'                => { "pwd" },
   'read'               => { "read" },
   'regexp'             => { "regexp" },
   'registry'           => { "registry" },
   'regsub'             => { "regsub" },
   'rename'             => { "rename" },
   'resource'           => { "resource" },
   'return'             => { "return" },
   'safe'               => { "safe" },
   'scan'               => { "scan" },
   'seek'               => { "seek" },
   'set'                => { "set" },
   'socket'             => { "socket" },
   'source'             => { "source" },
   'split'              => { "split" },
   'string'             => { "string" },
   'string compare'     => { "string compare" },
   'string first'       => { "string first" },
   'string index'       => { "string index" },
   'string last'        => { "string last" },
   'string length'      => { "string length" },
   'string match'       => { "string match" },
   'string range'       => { "string range" },
   'string tolower'     => { "string tolower" },
   'string toupper'     => { "string toupper" },
   'string trim'        => { "string trim" },
   'string trimleft'    => { "string trimleft" },
   'string trimright'   => { "string trimright" },
   'subst'              => { "subst" },
   'switch'             => { "switch ... { ... }" },
   'tclsh'              => { "tclsh" },
   'tclvars'            => { "tclvars" },
   'tell'               => { "tell" },
   'then'               => { "then" },
   'time'               => { "time" },
   'trace'              => { "trace" },
   'trace variable'     => { "trace variable" },
   'trace vdelete'      => { "trace vdelete" },
   'trace vinfo'        => { "trace vinfo" },
   'unknown'            => { "unknown" },
   'unset'              => { "unset" },
   'update'             => { "update" },
   'uplevel'            => { "uplevel" },
   'variable'           => { "variable" },
   'vwait'              => { "vwait" },
   'while'                => { "while { ... } { ... }" },
};

int tcl_get_info(var Noflines,var cur_line,var first_word,var last_word,
                 var rest,var non_blank_col,var semi,var prev_semi,
                 boolean in_smart_paste=false)
{
   typeless old_pos;
   save_pos(old_pos);
   first_word='';last_word='';non_blank_col=p_col;
   int i=0;
   int j=0;
   int orig_col=0;
   _str kwd="";
   _str line="";
   _str before_brace="";
   typeless p2=0;
   typeless junk=0;
   typeless status=0;
   if (in_smart_paste) {
      for (j=0; ; ++j) {
         get_line_raw(cur_line);
         if ( cur_line!='' ) {
            parse cur_line with line '#',p_rawpos; /* Strip comment on current line. */
            parse line with before_brace '{',p_rawpos +0 last_word;
            parse strip(line,'L') with first_word '[({:; \t]',(p_rawpos'r') +0 rest;
            last_word=strip(last_word);
            if (last_word=='{' && !(p_begin_end_style == BES_BEGIN_END_STYLE_3)) {
               save_pos(p2);
               p_col=text_col(before_brace);
               _clex_skip_blanks('-');
               status=1;
               if (get_text()==')') {
                  status=_find_matching_paren(def_pmatch_max_diff);
               }
               if (!status) {
                  status=1;
                  if (p_col==1) {
                     up();_end_line();
                  } else {
                     left();
                  }
                  _clex_skip_blanks('-');
                  if (_clex_find(0,'g')==CFG_KEYWORD) {
                     kwd=cur_word(junk);
                     status=!pos(' 'kwd' ',BLOCK_WORDS);
                  }
               }
               if (status) {
                  non_blank_col=text_col(line,pos('[~ \t]|$',line,1,p_rawpos'r'),'I');
                  restore_pos(p2);
               } else {
                  get_line_raw(line);
                  non_blank_col=text_col(line,pos('[~ \t]|$',line,1,p_rawpos'r'),'I');
                  /* Use non blank of start of if, do, while, foreach, unless, or for. */
               }
            } else {
               non_blank_col=text_col(line,pos('[~ \t]|$',line,1,p_rawpos'r'),'I');
            }
            Noflines=j;
            break;
         }
         if ( up() ) {
            restore_pos(old_pos);
            return(1);
         }
         if (j>=100) {
            restore_pos(old_pos);
            return(1);
         }
      }
   } else {
      orig_col=p_col;
      for (j=0;  ; ++j) {
         get_line_raw( cur_line);
         _begin_line();
         i=verify(cur_line,' '\t);
         if ( i ) p_col=text_col(cur_line,i,'I');
         if ( cur_line!='' && _clex_find(0,'g')!=CFG_COMMENT) {
            parse cur_line with line '#',p_rawpos; /* Strip comment on current line. */
            parse line with before_brace '{',p_rawpos +0 last_word;
            parse strip(line,'L') with first_word '[({:; \t]',(p_rawpos'r') +0 rest;
            last_word=strip(last_word);
            if (last_word=='{' && !(p_begin_end_style == BES_BEGIN_END_STYLE_3)) {
               save_pos(p2);
               p_col=text_col(before_brace);
               _clex_skip_blanks('-');
               status=1;
               if (get_text()==')') {
                  status=_find_matching_paren(def_pmatch_max_diff);
               }
               if (!status) {
                  status=1;
                  if (p_col==1) {
                     up();_end_line();
                  } else {
                     left();
                  }
                  _clex_skip_blanks('-');
                  if (_clex_find(0,'g')==CFG_KEYWORD) {
                     kwd=cur_word(junk);
                     status=!pos(' 'kwd' ',BLOCK_WORDS);
                  }
               }
               if (status) {
                  non_blank_col=text_col(line,pos('[~ \t]|$',line,1,p_rawpos'r'),'I');
                  restore_pos(p2);
               } else {
                  get_line_raw(line);
                  non_blank_col=text_col(line,pos('[~ \t]|$',line,1,p_rawpos'r'),'I');
                  /* Use non blank of start of if, do, while, unless, foreach, or for. */
               }
            } else {
               non_blank_col=text_col(line,pos('[~ \t]|$',line,1,p_rawpos'r'),'I');
            }
            Noflines=j;
            break;
         }
         if ( up() ) {
            restore_pos(old_pos);
            return(1);
         }
         if (j>=100) {
            restore_pos(old_pos);
            return(1);
         }
      }
      if (!j) p_col=orig_col;
   }
   typeless p='';
   if ( j ) {
      p=1;
   }
   semi=stat_has_semi(p);
   prev_semi=prev_stat_has_semi();
   restore_pos(old_pos);
   return(0);
}
/* Returns non-zero number if pass through to enter key required */
boolean _tcl_expand_enter()
{
   updateAdaptiveFormattingSettings(AFF_SYNTAX_INDENT | AFF_BEGIN_END_STYLE);
   syntax_indent := p_SyntaxIndent;
   be_style := p_begin_end_style;
   expand := LanguageSettings.getSyntaxExpansion(p_LangId);

   int Noflines=0;
   typeless cur_line="", first_word="", last_word="", rest="";
   typeless non_blank_col="", semi="", prev_semi="";
   typeless status=tcl_get_info(Noflines,cur_line,first_word,last_word,rest,
                        non_blank_col,semi,prev_semi);
   if (status) return(1);
   status=0;
   if ( expand && ! Noflines ) {
      if ( (first_word=='for' || first_word=='foreach') &&
            name_on_key(ENTER):=='nosplit-insert-line' ) {
         if ( name_on_key(ENTER):!='nosplit-insert-line' ) {
            if ( (be_style == BES_BEGIN_END_STYLE_2) || semi ) {
               return(1);
            }
            indent_on_enter(syntax_indent);
            return(0);
         }
         /* tab to fields of TCL for statement */
         _str line=expand_tabs(cur_line);
         int semi1_col=pos(';',line,p_col);
         if ( semi1_col>0 && semi1_col>=p_col ) {
            p_col=semi1_col+2;
         } else {
            int semi2_col=pos(';',line,semi1_col+1);
            if ( (semi2_col>0) && (semi2_col>=p_col) ) {
               p_col=semi2_col+2;
            } else {
               if ( be_style == BES_BEGIN_END_STYLE_2 || semi ) {
                  return(1);
               }
               indent_on_enter(syntax_indent);
            }
         }
      } else {
         status=1;
      }
   } else {
     status=1;
   }
   if ( status ) {  /* try some more? Indenting only. */
      status=0;
      typeless col=tcl_indent_col(non_blank_col);
      indent_on_enter(0,col);
   }
   return(status);

}

int tcl_indent_col(int non_blank_col, boolean pasting_open_block = false)
{
   int Noflines=0;
   typeless cur_line="", first_word="", last_word="", rest="";
   typeless semi="", prev_semi="";
   typeless status=tcl_get_info(Noflines,cur_line,first_word,last_word,rest,
                        non_blank_col,semi,prev_semi);
   if (status) return(1);

   typeless syntax_indent=p_SyntaxIndent;
   indent_fl := LanguageSettings.getIndentFirstLevel(p_LangId);
   if ( syntax_indent=='' ) {
      return(non_blank_col);
   }
   updateAdaptiveFormattingSettings(AFF_BEGIN_END_STYLE);
   boolean style2=(p_begin_end_style == BES_BEGIN_END_STYLE_3);
   int is_structure=pos(' 'first_word' ',BLOCK_WORDS);
   _str level1_brace=substr(cur_line,1,1)=='{';
   boolean past_non_blank=p_col>non_blank_col || name_on_key(ENTER)=='nosplit-insert-line';
   /* messageNwait('is_struct='is_structure' semi='semi' psemi='prev_semi' firstw='first_word' lastw='last_word) */

   int i=0;
   int j=0;
   save_pos(auto p);
   up(Noflines);
   _str line="";
   get_line_raw(line);
   // Check for statement like this
   //
   //   if ( func(a,b,
   //          c,(d),(e) )) return;
   //
   //  look for last paren which matches to paren on different line.
   //
   if (Noflines) {
      i=length(line);
   } else {
      i=text_col(line,p_col,'p')-1;
   }
   //i=text_col(expand_tabs(line,1,p_col-1));
   //messageNwait('line='line' i='i);
   //old_col=p_col;
   typeless pline=point();
   for (;;) {
      if (i<=0) break;
      j=lastpos(')',line,i,p_rawpos);
      if (!j) break;
      p_col=text_col(line,j,'I');
      int color=_clex_find(0,'g');
      //messageNwait('h1');
      if (color==CFG_COMMENT || color==CFG_STRING) {
         i=j-1;
         continue;
      }
      //messageNwait('try');
      status=_find_matching_paren(def_pmatch_max_diff);
      if (status) break;
      if (pline!=point()) {
         //messageNwait('special case');
         first_non_blank();
         non_blank_col=p_col;
         get_line_raw(line);
         _str word="";
         parse line with word . ;
         is_structure=pos(' 'word' ',BLOCK_WORDS,1,p_rawpos);
         //restore_pos(p);
         //return(col);
      }
      i=j-1;
   }
   restore_pos(p);
   if (
      (last_word=='{' && (! style2 || level1_brace) && indent_fl && past_non_blank) ||     /* Line end with '{' ?*/
      (is_structure && ! semi && past_non_blank && pasting_open_block!=1) ||
       pos('(\}|)else$',strip(cur_line),1,'r') || (first_word=='else' && !semi) ||
       pos('(\}|)elseif',strip(cur_line),1,'r') || (first_word=='elseif' && !semi) ||
       (is_structure && last_word=='{' && past_non_blank) ) {
      //messageNwait('case1');
      return(non_blank_col+syntax_indent);
      /* Look for spaces, end brace, spaces, comment */
   } else if ( (pos('^([ \t])*\}([ \t]*)(\\|\#|$)',cur_line,1,'r') && style2)|| (semi && ! prev_semi)) {
      // OK we are a little lazy here. If the dangling statement is not indented
      // correctly, then neither will this statement.
      //
      //     if (
      //             )
      //             i=1;
      //         <end up here> and should be aligned with if
      //
      //messageNwait('case2');
      int col=non_blank_col-syntax_indent;
      if ( col<=0 ) {
         col=1;
      }
      if ( col==1 && indent_fl ) {
         return(non_blank_col);
      }
      return(col);
   }
   return(non_blank_col);

}
static typeless tcl_expand_space()
{
   updateAdaptiveFormattingSettings(AFF_SYNTAX_INDENT);
   syntax_indent := p_SyntaxIndent;
   be_style := p_begin_end_style;

   typeless status=0;
   _str orig_line="";
   get_line(orig_line);
   _str line=strip(orig_line,'T');
   _str orig_word=strip(line);
   if ( p_col!=text_col(_rawText(line))+1 ) {
      return(1);
   }
   int if_special_case=0;
   _str first_word="", second_word="", rest="";
   _str aliasfilename='';
   _str word=min_abbrev2(orig_word,tcl_space_words,name_info(p_index),aliasfilename);

   // can we expand an alias?
   if (!maybe_auto_expand_alias(orig_word, word, aliasfilename, auto expandResult)) {
      // if the function returned 0, that means it handled the space bar
      // however, we need to return whether the expansion was successful
      return expandResult;
   }

   if ( word=='') {
      // Check for } else
      parse orig_line with first_word second_word rest;
      if (first_word=='}' && second_word!='' && rest=='' && second_word:==substr('els',1,length(second_word))) {
         keyin(substr('else ',length(second_word)+1));
         return(0);
      }
      // Check for else if or } else if
      if (first_word=='elseif' && orig_word==substr('elseif',1,length(orig_word))) {
         word='elseif';
         if_special_case=1;
      } else if (second_word=='elseif' && rest=='' && orig_word==substr('} elseif',1,length(orig_word))) {
         word='} elseif';
         if_special_case=1;
      } else if (first_word=='}elseif' && second_word=='' && orig_word==substr('}elseif',1,length(orig_word))) {
         word='}elseif';
         if_special_case=1;
      } else {
         return(1);
      }
   }
   if ( word=='') return(1);

   updateAdaptiveFormattingSettings(AFF_NO_SPACE_BEFORE_PAREN | AFF_BEGIN_END_STYLE);
   _str maybespace=p_no_space_before_paren?'':' ';
   line=substr(line,1,length(line)-length(orig_word)):+word;
   int width=text_col(_rawText(line),_rawLength(line)-_rawLength(word)+1,'i')-1;
   _str e1=' {';
   if ( be_style == BES_BEGIN_END_STYLE_2 || be_style == BES_BEGIN_END_STYLE_3 ) {
      e1=' \';
   }
   if ( !LanguageSettings.getInsertBeginEndImmediately(p_LangId) ) e1='';
   
   doNotify := true;
   set_surround_mode_start_line();
   if ( word=='if' || word=='elseif' || if_special_case) {
      replace_line(line:+maybespace:+'{}'e1);
      maybe_insert_braces(syntax_indent,be_style,width,word);
   } else if ( pos('else',word) ) {
      newLine := line:+e1;
      replace_line(newLine);
      maybe_insert_braces(syntax_indent,be_style,width,word);
      doNotify = (newLine != orig_line);
   } else if ( word=='for' ) {
      replace_line(line:+maybespace'{}'maybespace'{}'maybespace'{}'e1);
      maybe_insert_braces(syntax_indent,be_style,width,word);
   } else if ( word=='foreach' || word=='switch') {
      newLine := line' 'e1;
      replace_line(newLine);
      maybe_insert_braces(syntax_indent,be_style,width,word);
      doNotify = (newLine != orig_line);
   } else if ( word=='return' ) {
      if (orig_word=='return') {
         keyin(' ');
         doNotify = false;
      } else {
         newLine := indent_string(width)'return ';
         replace_line(newLine);
         _end_line();
         doNotify = (newLine != orig_line);
      }
   } else if ( word=='proc' ) {
      tcl_insert_proc();

      doNotify = LanguageSettings.getInsertBeginEndImmediately(p_LangId);
   } else if ( word=='while' ) {
      replace_line(line:+maybespace'{}'e1);
      maybe_insert_braces(syntax_indent,be_style,width,word);
   } else if ( word=='catch' ) {
      replace_line(line:+maybespace'{}');
      _end_line();left();
   } else if ( pos(' 'word' ',TCL_EXPAND_WORDS) ) {
      newLine := indent_string(width)word' ';
      replace_line(newLine);
      _end_line();
      doNotify = (newLine != orig_line);
   } else if ( word=='continue' || word=='break' ) {
      replace_line(indent_string(width)word';');
      _end_line();
   } else if (word != orig_word) {
      replace_line(indent_string(width)word' ');
      _end_line();
   } else {
      status=1;
      doNotify = false;
   }

   if (!do_surround_mode_keys(false, NF_SYNTAX_EXPANSION) && doNotify) {
      // notify user that we did something unexpected
      notifyUserOfFeatureUse(NF_SYNTAX_EXPANSION);
   }

   return(status);
}
int _tcl_get_syntax_completions(var words, _str prefix="", int min_abbrev=0)
{
   return AutoCompleteGetSyntaxSpaceWords(words, tcl_space_words, prefix, min_abbrev);
}
static tcl_expand_begin()
{
   updateAdaptiveFormattingSettings(AFF_SYNTAX_INDENT | AFF_BEGIN_END_STYLE);
   syntax_indent := p_SyntaxIndent;
   be_style := p_begin_end_style;
   expand := LanguageSettings.getAutoBracketEnabled(p_LangId, AUTO_BRACKET_BRACE);


   typeless brace_indent=0;
   keyin('{');
   _str line="";
   get_line_raw(line);
   int col=0;
   int pcol=text_col(line,p_col,'P');
   _str last_word='';
   if ( pcol-2>0 ) {
      int i=lastpos('[~ ]',line,pcol-2,p_rawpos'r');
      if ( i && substr(line,i,1)=='}' ) {
         parse substr(line,pcol-1) with  last_word '/\*|//',(p_rawpos'r');
      }
   }
   
   if ( line!='{' ) {
      if ( last_word!='{' ) {
         _str first_word="", second_word="";
         parse line with first_word second_word;
         _str word="";
         parse line with '}' word '{',p_rawpos +0 last_word '#',p_rawpos;
         if ( (last_word!='{' || word!='else') ) {
            return(0);
         }
      }
      if ( be_style == BES_BEGIN_END_STYLE_3 ) {
         brace_indent=syntax_indent;
         be_style= 0;
      }
   } else if ( be_style != BES_BEGIN_END_STYLE_3 ) {
      if ( ! prev_stat_has_semi() ) {
         int old_col=p_col;
         up();
         if ( ! rc ) {
            first_non_blank();p_col=p_col+syntax_indent+1;
            down();
         }
         col=p_col-syntax_indent-1;
         if ( col<1 ) {
            col=1;
         }
         if ( col<old_col ) {
            replace_line(indent_string(col-1)'{');
         }
      }
   }
   first_non_blank();
   if ( expand ) {
      col=p_col-1;
      indent_fl := LanguageSettings.getIndentFirstLevel(p_LangId);
      if ( (col && (be_style == BES_BEGIN_END_STYLE_3)) || (! (indent_fl+col)) ) {
         syntax_indent=0;
      }
      insert_line(indent_string(col+brace_indent));
      tcl_endbrace();
      up();_end_line();
      if (LanguageSettings.getInsertBlankLineBetweenBeginEnd(p_LangId) ) {
         tcl_enter();
      }

      // notify user that we did something unexpected
      notifyUserOfFeatureUse(NF_SYNTAX_EXPANSION);
   } else {
      _end_line();
   }
   return(0);

}
static typeless prev_stat_has_semi()
{
   int col=0;
   _str line="";
   typeless status=1;
   up();
   if ( ! rc ) {
      col=p_col;_end_line();get_line_raw(line);
      parse line with line '\#',(p_rawpos'r');
      /* parse line with line '{' +0 last_word ; */
      /* parse line with first_word rest ; */
      /* status=stat_has_semi() or line='}' or line='' or last_word='{' */
      line=strip(line,'T');
      if (raw_last_char(line)==')') {
         save_pos(auto p);
         p_col=text_col(line);
         status=_find_matching_paren(def_pmatch_max_diff);
         if (!status) {
            status=search('[~( \t]','@-rh');
            if (!status) {
               if (!_clex_find(0,'g')==CFG_KEYWORD) {
                  status=1;
               } else {
                  int junk=0;
                  _str kwd=cur_word(junk);
                  status=!pos(' 'kwd' ',BLOCK_WORDS);
               }
            }
         }
         restore_pos(p);
      } else {
         status=raw_last_char(line)!=')' && ! pos('(\}|)else$',line,1,p_rawpos'r');
      }
      down();
      p_col=col;
   }
   return(status);
}
static typeless stat_has_semi(...)
{
   _str line="";
   get_line_raw(line);
   parse line with line '#',p_rawpos;
   line=strip(line,'T');
   return((raw_last_char(line):==';' || raw_last_char(line):=='}') &&
            (
               ! (( _will_split_insert_line()
                    ) && (p_col<=text_col(line) && arg(1)=='')
                   )
            )
         );

}
static void maybe_insert_braces(int syntax_indent,int be_style,int width,_str word)
{
   int col = width + length(word);
   get_line(auto line);
   if( substr(line,col+2,1) == '{' ) {
      // Position inside {}.
      // Used by control-structures like if, for, while, etc. where
      // syntax expansion automatically inserts a '{condition}' after
      // the keyword.
      col += 3;
   } else {
      // Position 1 space past the word.
      // Used by control-structures like foreach where placing a
      // brace-ified list after the keyword is optional and therefore
      // omitted by syntax expansion.
      col += 2;
   }
   if ( be_style == BES_BEGIN_END_STYLE_3 ) {
      width=width+syntax_indent;
   }
   if (p_no_space_before_paren) --col;
   if (LanguageSettings.getInsertBeginEndImmediately(p_LangId)) {
      int up_count=1;
      if ( be_style == BES_BEGIN_END_STYLE_2 || be_style == BES_BEGIN_END_STYLE_3 ) {
         up_count=up_count+1;
         insert_line (indent_string(width)'{');
      }
      if ( LanguageSettings.getInsertBlankLineBetweenBeginEnd(p_LangId)) {
         up_count=up_count+1;
         insert_line(indent_string(width+syntax_indent));
      }
      insert_line(indent_string(width)'}');
      set_surround_mode_end_line();
      up(up_count);
   }
   p_col=col;
   if ( ! _insert_state() ) { _insert_toggle(); }
}
/*
   It is no longer necessary to modify this function to
   create your own sub style.  Just define an extension
   specific alias.  See comment at the top of this file.
*/
static typeless tcl_insert_proc()
{
   updateAdaptiveFormattingSettings(AFF_SYNTAX_INDENT | AFF_BEGIN_END_STYLE | AFF_NO_SPACE_BEFORE_PAREN);
   syntax_indent := p_SyntaxIndent;
   
   if( !LanguageSettings.getInsertBeginEndImmediately(p_LangId) || p_begin_end_style != BES_BEGIN_END_STYLE_3 ) {
      syntax_indent=0;
   }
   int up_count=0;
   if( LanguageSettings.getInsertBeginEndImmediately(p_LangId)) {
      up_count=1;
      _str maybespace=(p_no_space_before_paren)? '':' ';
      if( (p_begin_end_style == BES_BEGIN_END_STYLE_2) || (p_begin_end_style == BES_BEGIN_END_STYLE_3) ) {
         ++up_count;
         replace_line('proc  {}');
         insert_line(indent_string(syntax_indent):+'{');
      } else {
         replace_line('proc 'maybespace'{} {');
      }
      if( LanguageSettings.getInsertBlankLineBetweenBeginEnd(p_LangId)) {
         ++up_count;
         insert_line('');
      }
      insert_line(indent_string(syntax_indent):+'}');
   } else {
      replace_line('proc ');
      _end_line();
   }

   up(up_count);
   p_col=6;   // Put cursor after 'proc ' so user can keyin the name

   return(0);
}


/* =========== TCL Tagging Support ================== */
typeless def_tcl_proto;

#define TCL_MODIFIER "public|private|protected|static"
#define TCL_MODIFIER2 "export|eval"
#define TCL_TAGTYPE  "body|configbody|global|variable|set|proc|method|constructor|destructor|class|namespace"

typeless tcl_proc_search(var proc_name,boolean find_first)
{
   static _str cur_class_name;
   _str class_name='';
   _str name="";
   _str kind="";
   if ( find_first ) {
      cur_class_name='';
      word_chars := _clex_identifier_chars();
      _str variable_re='([/'word_chars']#)';
      if ( proc_name:=='' ) {
         // not searching for a specific tag
         name=variable_re;
      } else {
         // searching for a specific tag
         int df=0;
         tag_tree_decompose_tag(proc_name, name, class_name, kind, df);
         name=stranslate(name,'\:',':');
      }
      // groups:     #0 (modifier)                     #1 (proc_type)        #2 (modifier2)           #3 :: #4 (class_name)       #5 (proc_name)             #6 arguments
      search('^[ \t]@{'TCL_MODIFIER'|}[ \t]@(itcl\:\:|){'TCL_TAGTYPE'}[ \t]#({'TCL_MODIFIER2'}[ \t]#|){[:]@}{('variable_re'\:\:)@}{'variable_re'@}\c[ \t]@(\{{[ \t'word_chars']@}\}|)','@erh');
   } else {
      // next please
      repeat_search();
   }
   if ( rc ) {
      return rc;
   }
   int tag_flags=0;
   _str modifier=get_match_text(0);
   _str proc_type=get_match_text(1);
   _str modifier2=get_match_text(2);
   typeless is_global=get_match_text(3);
   class_name=get_match_text(4);
   if (class_name!='') {
      class_name=substr(class_name,1,length(class_name)-2);
      class_name=stranslate(class_name,':','::');
   }
   proc_name=get_match_text(5);
   _str proc_args=get_match_text(6);
   if (is_global!='') cur_class_name='';
   switch (proc_type) {
   case 'namespace':
      proc_type="package";
      if (modifier2=='export') {
         return tcl_proc_search(proc_name,false);
      }
      proc_args='';
      cur_class_name=proc_name;
      if (class_name!='') {
         cur_class_name=class_name':'proc_name;
         proc_name=cur_class_name;
         class_name='';
      }
      break;
   case 'configbody':
      proc_type="prop";
      break;
   case 'body':
      proc_type="func";
      break;
   case 'proc':
      if (cur_class_name!='') {
         class_name=cur_class_name;
      }
      if (class_name!='') {
         tag_flags|=VS_TAGFLAG_inclass;
      }
      proc_type="func";
      break;
   case 'method':
      class_name=cur_class_name;
      tag_flags|=VS_TAGFLAG_inclass;
      proc_type="proto";
      break;
   case 'constructor':
   case 'destructor':
      if (cur_class_name!='' && class_name=='') {
         class_name=cur_class_name;
         tag_flags|=VS_TAGFLAG_inclass;
      }
      if (proc_type=='constructor') {
         tag_flags=VS_TAGFLAG_constructor;
      } else {
         tag_flags=VS_TAGFLAG_destructor;
      }
      tag_flags|=VS_TAGFLAG_inclass;
      if (proc_name=='') {
         proc_name=proc_type;
         if (pos('::',cur_class_name)) {
            proc_name=substr(cur_class_name,lastpos('::',cur_class_name)+2);
         }
      }
      proc_type="proto";
      break;
   case 'class':
      proc_args='';
      cur_class_name=proc_name;
      if (class_name!='') {
         cur_class_name=class_name':'proc_name;
         proc_name=cur_class_name;
         class_name='';
      }
      break;
   case 'variable':
   case 'global':
   case 'set':
      proc_args='';
      proc_type='var';
      class_name=cur_class_name;
      tag_flags|=VS_TAGFLAG_inclass;
      break;
   }
   switch (modifier) {
   case 'static':
      tag_flags|=VS_TAGFLAG_static;
      break;
   case 'public':
      tag_flags|=VS_TAGFLAG_public;
      break;
   case 'protected':
      tag_flags|=VS_TAGFLAG_protected;
      break;
   case 'private':
      tag_flags|=VS_TAGFLAG_private;
      break;
   }
   if (proc_name=='constructor') {
      tag_flags|=VS_TAGFLAG_constructor;
   } else if (proc_name=='destructor') {
      tag_flags|=VS_TAGFLAG_destructor;
   }
   if (proc_name=='') {
      return tcl_proc_search(proc_name,0);
   }
   proc_name=tag_tree_compose_tag(proc_name,class_name,proc_type,tag_flags,proc_args);
   return(0);
}

int _tcl_MaybeBuildTagFile(int &tfindex)
{
   // maybe we can recycle tag file(s)
   _str ext='tcl';
   _str tagfilename='';
   if (ext_MaybeRecycleTagFile(tfindex,tagfilename,ext,ext)) {
      return(0);
   }

   // The user does not have an extension specific tag file for TCL
   int status=0;
   _str tcl_binary='';
#if !__UNIX__
   status = _ntRegFindValue(HKEY_LOCAL_MACHINE,
                            "SOFTWARE\\Scriptics\\TclPro\\1.2",
                            "PkgPath", tcl_binary);
   if (status || tcl_binary=='') {
      status = _ntRegFindValue(HKEY_LOCAL_MACHINE,
                               "SOFTWARE\\Scriptics\\TclPro\\1.1",
                               "PkgPath", tcl_binary);
   }
   if (!status) {
      tcl_binary = tcl_binary :+ "\\win32-ix86\\bin\\procomp.exe";
   }
   if (status || tcl_binary=='') {
      status = _ntRegFindValue(HKEY_LOCAL_MACHINE,
                               "SOFTWARE\\Scriptics\\Tcl\\8.0",
                               "", tcl_binary);
      if (tcl_binary!='') {
         tcl_binary=tcl_binary:+"\\bin";
      }
   }
#endif
   if (tcl_binary=='') {
      tcl_binary=path_search("procomp","","P");
   }
#if !__UNIX__
   if (tcl_binary=='') {
      tcl_binary=_ntRegGetPythonPath();
      if (tcl_binary!='') {
         if (last_char(tcl_binary)!=FILESEP) {
            tcl_binary=tcl_binary:+FILESEP;
         }
         tcl_binary=tcl_binary:+"tcl":+FILESEP:+"tcl8.3";
      }
   }
#else
   if (tcl_binary=='' || tcl_binary=='/' || tcl_binary=='/usr/') {
      tcl_binary=latest_version_path('/usr/lib/tcl');
      if (tcl_binary=='') {
         tcl_binary=latest_version_path('/opt/tcl');
      }
      if (tcl_binary!='') {
         tcl_binary=tcl_binary:+"bin/tcl";
      }
   }
#endif
   _str std_libs="";
   if (tcl_binary!="") {
      _str path=_strip_filename(tcl_binary,"n");
      if (last_char(path)==FILESEP) {
         path=substr(path,1,length(path)-1);
      }
      _str name=_strip_filename(path,"p");
      if (file_eq(name,"bin")) {
         path=_strip_filename(path,"n");
         if (last_char(path)==FILESEP) {
            path=substr(path,1,length(path)-1);
         }
      }
      name=_strip_filename(path,"p");
      if (file_eq(name,"win32-ix86")) {
         path=_strip_filename(path,"n");
      }
      if (last_char(path)!=FILESEP) {
         path=path:+FILESEP;
      }
      _str source_path=file_match(maybe_quote_filename(path:+"lib"), 1);
      if (source_path!='') {
         path=path:+"lib":+FILESEP;
      }
      std_libs=maybe_quote_filename(path:+"*.tcl"):+' ':+maybe_quote_filename(path:+"*.itk");
      //say("_tcl_MaybeBuildTagFile: path="path" std_libs="std_libs);
   }

   return ext_BuildTagFile(tfindex,tagfilename,ext,"TCL Libraries",
                           true,std_libs,ext_builtins_path(ext,ext));
}

/**
 * Checks to see if the first thing on the current line is an 
 * open brace.  Used by comment_erase (for reindentation). 
 * 
 * @return Whether the current line begins with an open brace.
 */
boolean tcl_is_start_block()
{
   return c_is_start_block();
}
