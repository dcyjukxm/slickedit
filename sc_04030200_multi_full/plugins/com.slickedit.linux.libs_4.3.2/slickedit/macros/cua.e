////////////////////////////////////////////////////////////////////////////////////
// $Revision: 46700 $
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
#import "commentformat.e"
#import "clipbd.e"
#import "help.e"
#import "ispf.e"
#import "main.e"
#import "markfilt.e"
#import "recmacro.e"
#import "stdcmds.e"
#import "stdprocs.e"
#import "util.e"
#import "vc.e"
#import "vi.e"
#import "xmlwrap.e"
#endregion

/*
  When true and there is no selection, Shift+Down or Shift+Up will select the
  current line (like MultiEdit).
*/
boolean def_shift_updown_line_select;

/*
   Possible new implementation for selection styles

   Variables                   CUA  CUA-ADV  SE  BRIEF  EMACS
   def_advanced_selstyle       CN   PCN      PEI  PCI    PCN
   def_selstyle                CN    CN      PEN   CN     CN
   def_mouse_selstyle          CN    CN      PEN   CN     CN


boolean def_auto_deletesel     1     1       0     0       0
boolean def_deselect_paste     1     1       0     1       1

+-Advanced selection (frame options) --+
|    Extend as Cursor Moves            |
|    Inclusive Character Selections    |
|    Allow Advanced Selections         |
+--------------------------------------+
Deselect after paste
Delete selection when Insert Text
Auto Deselect (effects non-advanced selections)

SHIFT ARROW KEYS DESELECT
   if(!select_active() || !(_selection_locked() && _cua_select==0)) {
     ...
     _deselect

Search locks and start from top of selection when
   !pos("P",def_advanced_selstyle) && !_selection_locked()
*/

// Using array for DBCS support
static _str gsaa_mark_keys[]={
    S_LEFT,S_RIGHT,S_DOWN,S_UP,S_PGUP,S_PGDN,S_HOME,S_END
};
#define NOFREPEAT_KEYS 4
static _str gsaa_map_keys[]={
   LEFT,RIGHT,DOWN,UP,PGUP,PGDN,HOME,END
};

static _str cua_col;
static _str last_cua_key;

/** 
 * Toggles the type of default selections (using mouse and arrow 
 * keys) between character and block.  Used in Eclipse 
 * emulation. 
 * 
 */
_command void toggle_select_type() name_info(','VSARG2_MARK|VSARG2_READ_ONLY|VSARG2_TEXT_BOX|VSARG2_REQUIRES_EDITORCTL)
{
   def_select_type_block = !def_select_type_block;
   _config_modify_flags(CFGMODIFY_DEFVAR); 
   if (select_active()) {
      begin_select();
      save_pos(auto p);
      end_select();
      save_pos(auto p2);
      restore_pos(p);
      deselect();
      if (def_select_type_block) {
         _select_block("",'C');
      } else {
         _select_char("",'C');
      }
      restore_pos(p2);
      if (def_select_type_block) {
         _select_block("",'C');
      } else {
         _select_char("",'C');
      }
   }
}

/**
 * Starts or extends a character selection.  This command is intended
 * to be bound to Shift+cursor keys.
 *
 * @appliesTo  Edit_Window, Editor_Control, Text_Box, Combo_Box
 * @categories Combo_Box_Methods, Edit_Window_Methods, Editor_Control_Methods, Selection_Functions, Text_Box_Methods
 */
_command void cua_select() name_info(','VSARG2_MARK|VSARG2_READ_ONLY|VSARG2_TEXT_BOX|VSARG2_REQUIRES_EDITORCTL)
{
   if ( command_state() ) {
      command_cua_select(last_event());
      return;
   }
   _macro_delete_line();
   int index=last_index('','c');
   _str key=last_event();
   _str last_command=name_name(prev_index('','c'));
   //last=name_name(last_index('','c'));
   //message("last="event2name(last_event()));delay(100);clear_message();
   //message("last="last_command);delay(100);clear_message();
   boolean do_kbd_macro_repeat=(last_command=='cua-select');
   if ((_cua_select && last_command!='cua-select' && def_persistent_select=='Y') ||
      ! select_active() ||
      (! _cua_select && _select_type('','U')=='P' && _select_type('','s')=='E')
   ) {
      /* (not _cua_select and not select_active()) then */
      do_kbd_macro_repeat=0;
      _macro_call('deselect');
      _deselect();
      /* bprint(last_command) */
   }
   if (last_command != 'cua-select') {
      last_cua_key = '';
   }
   _str inclusive='';
   if ( _select_type()!='' && _select_type('','I') ) {
      inclusive='I';
   }
   _str mstyle='';
   if ( def_persistent_select=='Y' ) {
      mstyle='EP':+inclusive;
   } else {
      mstyle='E':+inclusive;
   }
   typeless status=0;
   if ( _select_type()=='' ) {
      cua_col=p_col;
      do_kbd_macro_repeat=0;
      if ((def_shift_updown_line_select || def_scursor_style) && (key:==S_DOWN || key:==S_UP)) {
         _macro_call('_select_line','',mstyle);
         status=_select_line('',mstyle);
         last_index(index,'c');

         _cua_select=1;
         if (_argument=='') _undo('s');
         last_event(key);
         return;
      }
      if (def_select_type_block) {
         _macro_call('_select_block','',mstyle);
         status=_select_block('',mstyle);
      } else {
         _macro_call('_select_char','',mstyle);
         status=_select_char('',mstyle);
      }
      if (status) {
         message(get_message(status));
         return;
      }
      /* _macro_call('select_char','',mstyle) */
   }
   p_hex_nibble=0;
   int i,was_recording=_macro();
   for (i=0;;++i) {
      if (i>=gsaa_mark_keys._length()) {
         i=-1;
         break;
      }
      if (gsaa_mark_keys[i]:==key) {
         break;
      }
   }

   // Were we previously in a situation where the newline chars were selected
   // because of def_wpselect_flags flags?
   boolean was_NewlineSelectionCase = false;
   if( def_wpselect_flags&VS_WPSELECT_NEWLINE && !def_scursor_style &&
       _select_type()=='CHAR' && _select_type('','I')=='1' ) {
      typeless p; save_pos(p);
      int dupmark = _duplicate_selection();
      _end_select(dupmark);
      if( p_col>_text_colc() ) {
         was_NewlineSelectionCase=true;
      }
      restore_pos(p);
      _free_selection(dupmark);
   }

   _str this_cmd='';
   if (was_recording) {
      if(do_kbd_macro_repeat) {
         _macro_delete_line();   //  Delete the select_it call
      }
      if ( i>=0 ) {
         for (;;) {
            if (i<NOFREPEAT_KEYS) {
               this_cmd=name_on_key(gsaa_map_keys[i]);
               _kbd_macro_repeat2(this_cmd);
               _macro('m',0);     //  Dont want call_key to generate macro code.
               // Don't want on_select called because the selection will
               // go away, These keys are ok in read only mode.
               call_key(gsaa_map_keys[i],'','s');
            } else {
               // Don't want on_select called because the selection will
               // go away, These keys are ok in read only mode.
               _macro('m',_macro('s'));  // 1.5 recording fix
               call_key(gsaa_map_keys[i],'','s');
            }
            if (!p_hex_nibble) break;
         }
      } else {
         if ( key:==name2event('s-c-home') ) {
            _macro_call('top_of_buffer');
            top_of_buffer();
         } else if ( key:==name2event('s-c-end') ) {
            _macro_call('bottom_of_buffer');
            bottom_of_buffer();
         } else if ( key:==name2event('s-c-left') ) {
            _macro_call('prev_word');
            prev_word();
         } else if ( key:==name2event('s-c-right') ) {
            _macro_call('next_word');
            next_word();
         } else if ( key:==name2event('s-m-up') ) {
            _macro_call('top_of_buffer');
            top_of_buffer();
         } else if ( key:==name2event('s-m-down') ) {
            _macro_call('bottom_of_buffer');
            bottom_of_buffer();
         } else if ( key:==name2event('s-m-left') ) {
            _macro_call('begin_line');
            begin_line();
         } else if ( key:==name2event('s-m-right') ) {
            _macro_call('end_line');
            end_line();
         } else if ( key:==name2event('s-m-home') ) {
            _macro_call('top_of_buffer');
            top_of_buffer();
         } else if ( key:==name2event('s-m-end') ) {
            _macro_call('bottom_of_buffer');
            bottom_of_buffer();
         } else if ( key:==name2event('a-s-up') ) {
            _macro_call('top_left_of_window');
            top_left_of_window();
         } else if ( key:==name2event('a-s-down') ) {
            _macro_call('bottom_left_of_window');
            bottom_left_of_window();
         } else if ( key:==name2event('a-s-left') ) {
            _macro_call('prev_word');
            prev_word();
         } else if ( key:==name2event('a-s-right') ) {
            _macro_call('next_word');
            next_word();
         }
      }
   } else {
      if ( i>=0) {
         for (;;) {
            //if (substr(SAA_MAP_KEYS,i,2)==DOWN) trace
            // Don't want on_select called because the selection will
            // go away, These keys are ok in read only mode.
            _macro('m',_macro('s'));  // 1.5 recording fix
            //last_event(substr(SAA_MAP_KEYS,i,2));
            //messageNwait("b4 "event2name(last_event())" _select_type()="_select_type());
            call_key(gsaa_map_keys[i],'','s');
            //messageNwait("got here _select_type()="_select_type());
            if (!p_hex_nibble) break;
         }
      } else {
         if ( key:==name2event('s-c-home') ) {
            _macro_call('top_of_buffer');
            top_of_buffer();
         } else if ( key:==name2event('s-c-end') ) {
            _macro_call('bottom_of_buffer');
            bottom_of_buffer();
         } else if ( key:==name2event('s-c-left') ) {
            _macro_call('prev_word');
            prev_word();
         } else if ( key:==name2event('s-c-right') ) {
            _macro_call('next_word');
            next_word();
         } else if ( key:==name2event('s-m-up') ) {
            _macro_call('top_of_buffer');
            top_of_buffer();
         } else if ( key:==name2event('s-m-down') ) {
            _macro_call('bottom_of_buffer');
            bottom_of_buffer();
         } else if ( key:==name2event('s-m-left') ) {
            _macro_call('begin_line');
            begin_line();
         } else if ( key:==name2event('s-m-right') ) {
            _macro_call('end_line');
            end_line();
         } else if ( key:==name2event('s-m-home') ) {
            _macro_call('top_of_buffer');
            top_of_buffer();
         } else if ( key:==name2event('s-m-end') ) {
            _macro_call('bottom_of_buffer');
            bottom_of_buffer();
         } else if ( key:==name2event('a-s-up') ) {
            _macro_call('top_left_of_window');
            top_left_of_window();
         } else if ( key:==name2event('a-s-down') ) {
            _macro_call('bottom_left_of_window');
            bottom_left_of_window();
         } else if ( key:==name2event('a-s-left') ) {
            _macro_call('prev_word');
            prev_word();
         } else if ( key:==name2event('a-s-right') ) {
            _macro_call('next_word');
            next_word();
         }
      }
   }
   if ( i < 0 ) {
      last_cua_key = '';
   } else {
      last_cua_key = name_on_key(gsaa_map_keys[i]);
   }
   _macro('m',was_recording);

   /* IF start line same as end line. */
   if (!def_scursor_style) {
      select_it(_select_type(),'',mstyle);
      _macro_call('select_it',_select_type(),'',mstyle);
      boolean startCol1 = ( key==S_LEFT || key==S_RIGHT || key==S_HOME || key==S_END );
      if( _WPSelectIsNewlineSelectionCase('',startCol1) ) {
         // Select newline chars at end of last line of selection.
         // See the comment on VS_WPSELECT_NEWLINE if you do not
         // understand what is going on here.
         // Change to inclusive CHAR selection so that we include the
         // newline chars.
         _select_type('','I',1);
      } else if( was_NewlineSelectionCase ) {
         // Example:
         // 1) Start in column 1
         // 2) Shift+End to select entire line, including newline chars
         // 3) Shift+Left
         // The CHAR selection should no longer be inclusive if the default
         // style is non-inclusive.
         int ival = pos('I',upcase(def_select_style),1,'e') ? 1 : 0;
         _select_type('','I',ival);
      }
   } else if (_begin_select_compare()==0 && _end_select_compare()==0) {
      boolean do_switch=0;
      if (_select_type()!='CHAR'){
         do_switch=1;
         _select_type('','T','CHAR');
      }
      select_it(_select_type(),'',mstyle);

      if (def_scursor_style && _isnull_selection()) {
         if (_select_type()!='LINE'){
            _macro_call('_select_type','','T','LINE');
            _select_type('','T','LINE');
            do_switch=0;
         }
      }
      if (do_switch) {
         _macro_call('_select_type','','T','CHAR');
      }
      _macro_call('select_it',_select_type(),'',mstyle);
   } else {
#if 1
      _str cc=_select_type('','P');
      int bcol=0, ecol=0;
      typeless junk;
      _get_selinfo(bcol,ecol,junk);
      int col=0;
      if (cc!='EB' && cc!='BB') {
         col=ecol;
      } else {
         col=bcol;
      }
      // Just mouse starting this selection, set cua_col to something
      // reasonable.
      if (cua_col!=col && cua_col!=col-1 && cua_col!=col+1) {
         cua_col=col;
      }
#endif
      if (cua_col==p_col /* && _select_type()!='BLOCK'*/) {
         /* We want a line mark. */
         if (_select_type()!='LINE' ) {
            _macro_call('_select_type','','T','LINE');
            _select_type('','T','LINE');
         }
         _macro_call('select_it',_select_type(),'',mstyle);
         select_it(_select_type(),'',mstyle);
      } else {
         /* We want a block mark. */
         if (_select_type()!='BLOCK') {
            _macro_call('_select_type','','T','NBLOCK');
            _select_type('','T','NBLOCK');
         }
         if (cua_col<p_col) {
            /* We want a non-inclusive block mark. */
            _str line="--p_col;select_it(_select_type(),'','"mstyle"');++p_col;";
            _macro_append(line);
            --p_col;
            select_it(_select_type(),'',mstyle);
            ++p_col;
         } else {
            _macro_call('select_it',_select_type(),'',mstyle);
            select_it(_select_type(),'',mstyle);
         }
      }
   }


   last_index(index,'c');

   _cua_select=1;
   if (_argument=='') _undo('s');
   /* call_key set the last_event to the wrong key. */
   /* Correct it here. */
   last_event(key);
}

/**
 * @return true if current CHAR selection should have the newline chars of the
 * last selected line included in the selection.
 * 
 * @param mark_id
 * @param startCol1 Set to true when selecting a single line and you only
 *                  want the newline chars selected when the beginning of
 *                  the selection starts in column 1 (e.g. Shift+Home).
 */
boolean _WPSelectIsNewlineSelectionCase(_str mark_id='', boolean startCol1=false)
{
   boolean is_newline_case = false;

   _str mark_name = _select_type(mark_id,'T');
   if( mark_name=='CHAR' && def_wpselect_flags&VS_WPSELECT_NEWLINE ) {
      // Check for special cases of selecting past end of line, where
      // we will want to select the newline chars (like a word processor).
      // See the comment on def_mou_char_line_select if you do not
      // understand what is going on here.
      int start_col, end_col, not_used;
      _get_selinfo(start_col,end_col,not_used,mark_id);
      typeless p; save_pos(p);
      int dupmark = mark_id=='' ? _duplicate_selection(null) : _duplicate_selection(mark_id);
      _end_select(dupmark);
      // We only count 1 column past the end as being past the end of line
      // because any more than that will end up including the newline chars
      // anyway, so there is no need to do anything special. We do not
      // consider ourselves past the end if the end of selection is at
      // beginning of line.
      boolean past_end = ( p_col==(_text_colc()+1) && end_col>1 );
      restore_pos(p);
      _free_selection(dupmark);
      if( past_end ) {
         // End of selected text is past end of line
         if( _begin_select_compare(mark_id)==0 && _end_select_compare(mark_id)==0 ) {
            // Selection begins and ends on same line
            if( startCol1 && start_col==1 ) {
               // Beginning of selection is at beginning of line, so we want
               // the newline chars of the current selected line.
               is_newline_case = true;
            } else if( !startCol1 ) {
               // Selection ends at end of line, so we want the newline chars
               // of the current selected line.
               is_newline_case = true;
            }
         } else if( _end_select_compare(mark_id)<0 ) {
            // Selecting backward and current line is before last line of selection,
            // so we want the newline chars of last line selected.
            is_newline_case = true;
         } else if( _begin_select_compare(mark_id)>0 ) {
            // Selecting forward and current line is after first line of selection,
            // so we want the newline chars of last line selected.
            is_newline_case = true;
         }
      }
   }

   return is_newline_case;
}

void maybe_deselect(boolean cancel_extend=false)
{
   if (!command_state() && select_active()) {
      if (cancel_extend && _select_type('','S')=='C') {

         //select_it(_select_type(),'');  /* lock the mark. */
         //select_it(_select_type(),'',_select_type('','I'):+def_advanced_select)
         //_select_type('','S','E');
         lock_selection();
         //select_line();
         return;
      }
      //if ( _select_type('','U')=='P' && _select_type('','S')=='C' ) {
      //   return;
      //}
      //def_persistent_select=upcase(def_persistent_select);
      if ( upcase(def_persistent_select)=='Y' ) {
         return;
      }
      if ( _select_type('','u')=='') {
         _deselect();
      }
   }
}
/**
 * Deletes the selection if a CUA selection style is being used and the 
 * selection is not locked.
 * 
 * @return Returns 1 if the selection was deleted.  Otherwise, 0 is 
 * returned.
 * 
 * @appliesTo Edit_Window, Editor_Control
 * 
 * @categories Selection_Functions
 * 
 */
int maybe_delete_selection()
{
   int status=0;
   if (!command_state() && select_active()) {
      if ( _select_type('','U')=='P' && _select_type('','S')=='E' ) {
         return(0);
      }
      if ( def_persistent_select=='D'  &&
          !_QReadOnly()) {
          _begin_select();
          status=1;
          if (_select_type()=='LINE') {
             status=2;
             typeless p=point();
             p_col=1;
             commentwrap_DeleteSelection();
             if (p!=point()) {
                //  Last line of buffer was deleted causing line number to change.
                insert_line('');
                status=4;
             }
          } else if (_select_type()=='CHAR') {
             typeless p=point();
             commentwrap_DeleteSelection();
             if (p!=point()) {
                //  Last line of buffer was deleted causing line number to change.
                insert_line('');
                status=4;
             }
          } else {
             _delete_selection();
          }
      }
   }
   return(status);
}
boolean _within_char_selection()
{
   boolean call_delete=true;
   if (select_active() && _select_type()=="CHAR" &&
      !_select_type("","i")) {
      call_delete=false;
      int first_col=0;
      int last_col=0;
      typeless junk;
      _get_selinfo(first_col,last_col,junk);
      if (_begin_select_compare()==0) {
         if (p_col>=first_col && _end_select_compare()<0) {
            call_delete=true;
         } else if (_end_select_compare()==0) {
            if (p_col>=first_col && p_col<=last_col) {
               call_delete=true;
            }
         }
      } else if (_begin_select_compare()>0) {
         if (_end_select_compare()<0 ||
                    (_end_select_compare()==0 && p_col<=last_col)) {
            call_delete=true;
         }
      }
   }
   return(call_delete);
}
boolean _within_selection()
{
   if (!select_active2()) {
      return false;
   }

   int start_col;
   int end_col;
   int buf_id;

   _get_selinfo(start_col,end_col,buf_id);
   int beginCompare=_begin_select_compare();
   if (beginCompare<0) {
      return false;
   }
   boolean isLineSelection=(_select_type():=='LINE');
   if ((beginCompare==0)&&(!isLineSelection)&&(p_col<start_col)) {
      return false;
   }

   int endCompare=_end_select_compare();
   if (endCompare>0) {
      return false;
   }
   if ((endCompare==0)&&(!isLineSelection)&&(p_col>end_col)) {
      return false;
   }

   boolean isBlockSelection=(_select_type():=='BLOCK');
   if (isBlockSelection) {
      if (p_col<start_col) {
         return false;
      }
      if (p_col>end_col) {
         return false;
      }
   }
   return true;
}
boolean _LCDoKey(_str key)
{
   switch (key) {
   case LEFT:
      _macro_call("_LCLeft");
      _LCLeft();
      return(true);
   case RIGHT:
      _macro_call("_LCRight");
      _LCRight();
      return(true);
   case END:
      _macro_call("_LCEnd");
      _LCEnd();
      return(true);
   case BACKSPACE:
      _macro_call("_LCBackspace");
      _LCBackspace();
      return(true);
   case DEL:
      _macro_call("_LCDel");
      _LCDel();
      return(true);
   case TAB:
      _macro_call("_LCTab");
      _LCTab();
      return(true);
   case S_TAB:
      _macro_call("_LCS_Tab");
      _LCS_Tab();
      return(true);
   case S_RIGHT:
      _macro_call("_LCTab");
      _LCTab();
      return(true);
   case S_LEFT:
      _macro_call("up");
      _macro_call("_LCEnd");
      up();
      _LCEnd();
      return(false);
   case S_DOWN:
   case S_UP:
   case S_PGUP:
   case S_PGDN:
      _macro_call("cua_select");
      origLCColumn := p_LCCol;
      _LCTab();
      cua_select();
      p_LCCol = origLCColumn;
      return(true);
   case S_HOME:
   case S_END:
         _macro_call("_LCTab");
         _LCTab();
         return(false);
   case name2event("S_ENTER"):
      _macro_call("_LCS_Enter");
      _LCS_Enter();
      return(true);
   }
   _str keya=key;
   /*if (!command_index) */keya=key2ascii(key);
   if (length(keya)==1 && _asc(_maybe_e2a(keya))>=32) {
      _LCKeyin(keya);
      return(true);
   }
   return(false);
}
#if 1
/*
  This function is only called when text is marked in the current buffer
  and the cursor is in the text area.
*/
void _on_select()
{
   //for certain cases in xml derived languages we want to save the selection contents.
   //XW_getSelection();
   _str key=last_event();                /* Key that was actually pressed. */

   typeless p;
   int kt_index=last_index('','k');
   int command_index=eventtab_index(kt_index,kt_index,event2index(key));
   typeless flags='';
   parse name_info(command_index) with ',' flags ',';
   if ( flags=='' ) {
      flags=0;
   }
   int iscommand=(name_type(command_index) & COMMAND_TYPE);
   if (p_scroll_left_edge>=0 &&
       !(flags &VSARG2_NOEXIT_SCROLL) &&
       (iscommand ||!command_index) &&
       ((flags & VSARG2_REQUIRES_MDI_EDITORCTL) || !command_index)
       ) {
      p_scroll_left_edge= -1;
   }
   /*
      There might be some problems here with having doBlockModeKey depend on
      just_call_key.  So far, it looks good.  We need this to handle some
      brief specified key bindings for the key pad keys.  Especially PadPlus,PadMinus,
      and PadStar keys.
   */
   boolean just_call_key=(flags & VSARG2_MARK) ||
       (iscommand &&
        (!(flags & VSARG2_REQUIRES_MDI_EDITORCTL) || (flags & (VSARG2_REQUIRES_BLOCK_SELECTION|VSARG2_REQUIRES_AB_SELECTION|VSARG2_REQUIRES_SELECTION)))
       ) ||
       (command_index && !iscommand);
   _str keya=key2ascii(key);
   boolean maybeBlockModePaste=false;
   boolean InsertingChar=(length(keya)<=4 && event2index(keya)>=32) &&
      (substr(event2name(key),1,2):!="S-") &&
       !_QReadOnly() && !(flags & VSARG2_READ_ONLY) &&
        !(def_keys=='vi-keys' && vi_get_vi_mode()=='C');
   if (_select_type('')=='BLOCK') {
      // DJB 11-15-2005
      // add handling for block indent, block unindent, and backspace / rubout
      // RH 03-10-2006
      // do not wanna do this stuff in vim visual mode
      if (key:==TAB) {
         if ( !p_indent_with_tabs && (def_keys == 'vi-keys' && vi_get_vi_mode() != 'V') ) {
            save_pos(p);
            int start_col=0,end_col=0,buf_id=0;
            _get_selinfo(start_col,end_col,buf_id);
            p_col=start_col;
            ptab();    
            int syntax_indent=p_col-start_col;
            restore_pos(p);
            if (syntax_indent > 0) {
               keya=substr('',1,syntax_indent);
               InsertingChar=true;
               just_call_key=false;
            }
         } else if(def_keys == 'vi-keys' && vi_get_vi_mode() != 'V'){
            InsertingChar=true;
            just_call_key=false;
         }
      } else if (key:==S_TAB && name_name(prev_index('','C'))=='doBlockModeKey' && (def_keys == 'vi-keys' && vi_get_vi_mode() != 'V')) {
         just_call_key=false;
         InsertingChar=true;
         keya='';      
      } else if (key:==BACKSPACE && name_name(prev_index('','C'))=='doBlockModeKey' && (def_keys == 'vi-keys' && vi_get_vi_mode() != 'V')) {
         just_call_key=false;
         InsertingChar=true;
         keya='';
      } else if (key:==DEL && name_name(prev_index('','C'))=='doBlockModeKey' && (def_keys == 'vi-keys' && vi_get_vi_mode() != 'V')) {
         just_call_key=false;
         InsertingChar=true;
         keya='';
      } else {
         _str cmdname=name_name(command_index);
         if (cmdname=='paste' || cmdname=='brief-paste' || cmdname=='emacs-paste') {
            _str cbtype=_getClipboardMarkType();
            if (cbtype!='BLOCK' && cbtype!='') {
               // Returns
               keya=_getClipboardText(true);
               if (keya!=null) {
                  just_call_key=false;
                  InsertingChar=true;
               }
            }
         }
      }
   }
   if (!p_hex_mode && doBlockModeKey(key,keya,InsertingChar && !just_call_key)) {
      _macro_call('doBlockModeKey',key,keya,(InsertingChar && !just_call_key));
      last_index(find_index('doBlockModeKey',PROC_TYPE|COMMAND_TYPE),'C');
      return;
   }
   int keymsg=last_index('','p');    /* Prefix key(s) message */
   /* IF mark is persistent AND mark is begin/end sytle mark */
   if (_select_type('','U')=='P' && _select_type('','S')=='E' ) {
      call_key(key,keymsg,'s');
      return;
   }
   def_persistent_select=upcase(def_persistent_select);
   if ( def_persistent_select=='Y' ) {
      /* set_eventtab_index  _default_keys,event2index(on_select),0 */
      call_key(key,keymsg,'s');
      return;
   }

   if (p_LCHasCursor && _LCIsReadWrite()) {
      if (_LCDoKey(key)) {
         return;
      }
   }
   typeless call_delete='';
   if (just_call_key) {
      call_key(key,keymsg,'s');

      // log this guy in the pip 
      if (def_pip_on) {
         _pip_log_command_event(name_name(command_index), PCLM_KEYBINDING, event2name(key));
      }

   } else if ( def_persistent_select=='D' && keymsg:=='' &&
       //(length(keya)==1 && _asc(_maybe_e2a(keya))>=32) &&
               InsertingChar

       ) {
      call_delete=_within_char_selection();
      if (call_delete) {
         _macro_append("maybe_delete_selection();");
         boolean was_on_line0=_on_line0();
         maybe_delete_selection();
         if (!was_on_line0 && _on_line0()) {
            insert_line('');
            _macro_append("_end_line();split_insert_line();_begin_line();");
         }
      } else {
         _macro_append("_deselect();");
         _deselect();
      }
      if ( ! _insert_state() ) {
         _macro_call('_insert_state',1);
         _insert_toggle();
         if ( key:==TAB ) {
            _macro_append('keyin("\t");');
            keyin("\t");
         } else {
            call_key(key,keymsg,'s');
         }
         if ( ! (length(key)==1 && _asc(_maybe_e2a(key))>=32) ) {
            _macro_call('_insert_state',0);
            _insert_toggle();
         }
      } else {
         if ( key:==TAB ) {
            _macro_append('keyin("\t");');
            keyin("\t");
         } else {
            call_key(key,keymsg,'s');
         }
      }
   } else if ( def_persistent_select=='D' && keymsg:=='' &&
          (key:==BACKSPACE || key:==DEL) && !_QReadOnly() && _within_char_selection()) {
      if( _select_type()=='LINE' ) {
         // Guarantee that the cursor does not end up in the middle of
         // virtual space after call to delete_selection().
         _macro_append('if (_select_type()=="LINE") {');
         _macro_append('   p_col=1;');
         _macro_append('}');
         p_col=1;
      }
      _macro_append("delete_selection();");
      delete_selection();
      last_index(0);
   } else if ( def_persistent_select=='D' && keymsg:=='' &&
          (key:==ENTER && 
           (name_on_key(ENTER)=='split-insert-line' || name_on_key(ENTER)=='nosplit-insert-line')
           ) && !_QReadOnly() && _within_char_selection()) {
      _macro_append('line_case=_select_type()==''LINE'';');
      _macro_append('_begin_select();');
      _macro_append('p=point();');
      boolean line_case=_select_type()=='LINE';
      _begin_select();
      p=point();
      if( _select_type()=='LINE' ) {
         // Guarantee that the cursor does not end up in the middle of
         // virtual space after call to delete_selection().
         _macro_append('if (_select_type()=="LINE") {');
         _macro_append('   p_col=1;');
         _macro_append('}');
         p_col=1;
      }
      _macro_append("delete_selection();");
      delete_selection();
      last_index(0);
      _macro_append('if( line_case) {');
      _macro_append('   if (p!=point()) {');
      _macro_append('       _end_line();');
      _macro_append('   }');
      _macro_append('}');
      if( line_case) {
         if (p!=point()) {
            _end_line();
         }
      }
      //call_key(key,keymsg,'s');
      _macro_append('last_event(ENTER);'); //translate(name_name(command_index),'_','-')"();");
      _macro_append('call_key(ENTER);'); //translate(name_name(command_index),'_','-')"();");
      call_key(key,keymsg,'s');
      //execute(name_name(command_index));
      last_index(0);
   } else {
      if ( _select_type('','u')=='' ) {
         if (def_cursor_beginend_select && select_active2() && _within_selection()) {
            switch (key) {
            case LEFT:
            case UP:
               _macro_append("_begin_select('',false,false);");
               _begin_select('',false,false);
               if (key:==UP) break;
               _macro_append('_deselect();');
               _deselect();
               return;
            case RIGHT:
            case DOWN:
               _macro_append("_end_select('',false,false);");
               _end_select('',false,false);
               if (key:==DOWN) break;
               _macro_append('_deselect();');
               _deselect();
               return;
            }
         }
         _macro_append('_deselect();');
         _deselect();
      }
      /* message 'h2 flags='flags' en='event2name(key)' name='name_name(command_index)' command_index='command_index;delay(70);clear_message */
      if( _QReadOnly() && !(flags&VSARG2_READ_ONLY) ) {
         if (!index_callable(find_index('_readonly_error',PROC_TYPE))) {
            popup_message(nls('The key you pressed is not allowed in Read Only mode.'));
            return;
         }
         _readonly_error(key);
         return;
      }
      call_key(key,keymsg,'s');
   }

}
#endif

void _on_key()
{
   if (def_keys=='vi-keys' && vi_get_vi_mode()!='I') {
      key:=last_event();
      call_key(key, '', '1');
      return;
   }
   _kbd_try_callbacks();
}

static void command_cua_select(_str key)
{
   int begin_col=0,col=0;
   typeless junk;
   _get_sel(begin_col,col);
   if ( key:==S_LEFT ) {
      left();
      _get_sel(junk,col);
   } else if ( key:==S_RIGHT ) {
      right();
      _get_sel(junk,col);
   } else if ( key:==name2event('s-c-left') ) {
      prev_word();
      col=_get_sel();
   } else if ( key:==name2event('s-c-right') ) {
      next_word();
      col=_get_sel();
   } else if ( key:==S_HOME ) {
      col=1;
   } else if ( key:==S_END ) {
      _str line='';
      get_command(line);
      col=length(line)+1;
   }
   _set_sel(begin_col,col);
}
static void _kbd_macro_repeat2(_str this_cmd='')
{
   if (_macro()) {
      if (this_cmd=='') {
         this_cmd=name_name(last_index());
      }
      this_cmd=translate(this_cmd,'_','-');
      _str line=_macro_get_line();
      _str param='';
      _str rest='';
      parse line with line '(' param ')' rest;
      if (line==this_cmd && (rest=='' || rest==";")) {
         if (param=='') {
            param=2;
         } else {
            ++param;
         }
         _macro_replace_line(this_cmd'('param');');
      } else {
         _macro_call(this_cmd);
      }
   }
}

_str get_last_cua_key()
{
   return last_cua_key;
}
