////////////////////////////////////////////////////////////////////////////////////
// $Revision: 47146 $
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
#include "markers.sh"
#import "bind.e"
#import "files.e"
#import "main.e"
#import "stdprocs.e"
#import "util.e"
#endregion

struct VS_HOTSPOT_MARKER {
   int id;
   int line_offset;
   int column_offset;
};

/**
 * If enabled, alias and syntax expansion can define hotspots
 * in order to have multiple cursor stops.
 * <p>
 * For example, if you have an alias such as:
 * <pre>
 *     if ( %\c) {
 *         %\c
 *     }
 * </pre>
 * <p>
 * Initially the cursor will be positioned at the first cursor
 * stops (%\c), when you hit Ctrl+[ (next_hotspot), the cursor
 * will jump to the next hotspot within the brace block.
 * 
 * @default true
 * @categories Configuration_Variables
 * 
 * @see expand_alias
 * @see c_space
 * @see next_hotspot
 * @see prev_hotspot
 */
boolean def_hotspot_navigation=true;

static int ghotspot_marker_type = -1;
static VS_HOTSPOT_MARKER ghotspot_marker_ids[];

definit()
{
   ghotspot_marker_type = -1;
   ghotspot_marker_ids._makeempty();
}

static boolean _goto_hotspot(VS_HOTSPOT_MARKER& hotspot) {
   VSSTREAMMARKERINFO info;

   // look up the cursor location for mark that we found
   if (_StreamMarkerGet(hotspot.id, info)) {
      return false;
   }

   // go to the location of the hotspot
   _GoToROffset(info.StartOffset);
   int orig_col = p_col;

   // now adjust our line position
   if (hotspot.line_offset > 0) {
      down(hotspot.line_offset);
   }

   // now adjust the column position
   begin_line();
   if (hotspot.line_offset == 0 && hotspot.column_offset <= orig_col) {
      // special case, same line, may have shifted right
      p_col = orig_col+1;
      if (get_text():==' ') {
         right();
      }
   } else {
      // just use the column we were supposed to use
      p_col = hotspot.column_offset;
   }
   return true;
}

// Helper for the beautfier that saves hotspots that are in the range about to be
// beautified, so they can be restored in their new positions after the text is beautified.
void save_hotspots_to(SavedStreamMarkers& state, long (&markers)[], long start_offset, long end_offset) {

   if (def_beautifier_debug > 1) 
      say('save_hotspots_to(state='(state!=null?'nonnull':'null')' start_offset='start_offset' end_offset='end_offset' )');

   int i; 
   VS_HOTSPOT_MARKER   filtered[];

   _save_pos2(auto p);
   state.num_hotspots = 0;
   for (i = 0; i < ghotspot_marker_ids._length(); i++) {
      VSSTREAMMARKERINFO sm;

      if (_StreamMarkerGet(ghotspot_marker_ids[i].id, sm) == 0) {
         long m_end = sm.StartOffset + sm.Length;

         if (def_beautifier_debug > 1) 
            say("save_hotspots_to:     "i": start="sm.StartOffset", end="m_end);

         if (_ranges_overlap(sm.StartOffset, m_end,
                             start_offset, end_offset)) {
            _goto_hotspot(ghotspot_marker_ids[i]);
            cline_len := _text_colc();
            if (p_col > cline_len) {
               // We don't like markers that are in virtual columns.
               _end_line();
            }
            markers[markers._length()] = _QROffset();
            state.num_hotspots += 1;
            _StreamMarkerRemove(ghotspot_marker_ids[i].id);
         } else {
            if (def_beautifier_debug > 1) 
               say("save_hotspots_to:     pmismatch");
            filtered[filtered._length()] = ghotspot_marker_ids[i];
         }
      }
   }
   ghotspot_marker_ids = filtered;
   _restore_pos2(p);
}

// Use the information saved by the beautifier to recreate
// any of our stream markers that got whacked.
void restore_hotspots_from(SavedStreamMarkers& state, long (&markers)[]) {
// say('restore_hotspots_from(state.num_hotspots='state.num_hotspots', state.first_hotspot_index='state.first_hotspot_index')');
   int i;
   int end_hs = state.first_hotspot_index + state.num_hotspots;

   _save_pos2(auto p);
   for (i = state.first_hotspot_index; i < end_hs; i++) {
//    say("   "i": "markers[i]);
      _GoToROffset(markers[i]);
      add_hotspot(true);
   }
}

static int get_hotspots_marker_type()
{
   if (ghotspot_marker_type < 0) {
      ghotspot_marker_type = _MarkerTypeAlloc();
      _MarkerTypeSetFlags(ghotspot_marker_type,
                          VSMARKERTYPEFLAG_AUTO_REMOVE|VSMARKERTYPEFLAG_UNDO
                          //|VSMARKERTYPEFLAG_DRAW_FOCUS_RECT
                          );
   }
   return ghotspot_marker_type;
}

/**
 * Clear all hotspot information.
 * 
 * @see expand_alias
 * @see add_hotspot
 * @see next_hotspot
 * @see prev_hotspot
 * 
 * @appliesTo  Edit_Window, Editor_Control
 * @categories Bookmark_Functions
 */
_command void clear_hotspots()
{
   if (ghotspot_marker_type >= 0) {
      _StreamMarkerRemoveAllType(ghotspot_marker_type);
      ghotspot_marker_ids._makeempty();
   }
}


/**
 * Post a message to the status bar about hotspot navigation bindings.
 * 
 * @param include_prev  create message about prev-hotspot
 */
static void message_hotspots(boolean include_prev=false)
{
   // check for key binding for next-hotspot
   int n = ghotspot_marker_ids._length();
   _str msg = '';
   if (n > 1) {
      _str next_key = where_is("next_hotspot",1);
      parse next_key with . . . . next_key;
      if (next_key != '') {
         msg = "Press "next_key" to go to next part of the statement.";
      }
   }

   // optionally check for prev-hotspot
   if (include_prev && n > 2) {
      _str prev_key = where_is("prev_hotspot",1);
      parse prev_key with . . . . prev_key;
      if (prev_key != '') {
         msg = msg:+" Press "prev_key" to go to previous part.";
      }
   }

   // if we have key bindings, tell them about it
   if (msg != '') {
      message(msg);
   }
}

/**
 * If the cursor is not on a specific hotspot, depending on the 
 * direction argument return the nearest hotspot before or after 
 * the cursor, wrapping in either direction. 
 *  
 * @return Return the index of the current hotspot under
 *         the cursor.  Return -1 on error.
 */
static int current_hotspot(_str dir='')
{
   // look up the current cursor position
   long curOffset = _QROffset();

   // locate the nearest hotspot location to the cursor
   VSSTREAMMARKERINFO info;
   int nearest_marker_id = -1;
   long nearest_distance = MAXINT;
   int  first_marker_id  = -1;
   long first_marker_offset = MAXINT;
   int  last_marker_id = -1;
   long last_marker_offset = 0;
   int marker_id=0;
   int i,n=ghotspot_marker_ids._length();
   for (i=0; i<n; ++i) {
      marker_id  = ghotspot_marker_ids[i].id;
      if (_StreamMarkerGet(marker_id, info)) continue;
      if (info.buf_id != p_buf_id) {
         break;
      }
      if (info.StartOffset <= curOffset && curOffset < info.StartOffset+info.Length ) {
         return i;
      }
      // find first hotspot in buffer
      if (info.StartOffset < first_marker_offset) {
         first_marker_id = i;
         first_marker_offset = info.StartOffset;
      }
      // find last hotspot in buffer
      if (info.StartOffset+info.Length > last_marker_offset) {
         last_marker_id = i;
         last_marker_offset = info.StartOffset+info.Length;
      }
      // find nearest hotspot before cursor
      if (dir=='+' && info.StartOffset+info.Length < curOffset && curOffset-(info.StartOffset+info.Length) < nearest_distance) {
         nearest_marker_id = i;
         nearest_distance  = curOffset - (info.StartOffset+info.Length);
      }
      // find nearest hotspot after cursor
      if (dir=='-' && curOffset < info.StartOffset && info.StartOffset-curOffset < nearest_distance) {
         nearest_marker_id = i;
         nearest_distance  = info.StartOffset - curOffset;
      }
   }

   // nearest hotspot before cursor
   if (nearest_marker_id >= 0) {
      return nearest_marker_id;
   }
   // first hotspot in buffer
   if (dir=='+') {
      return last_marker_id;
   } else {
      return first_marker_id;
   }
}

/**
 * Author: David A. O'Brien
 * Date:   11/19/2007
 * 
 * Save information to restore hotspots.
 * 
 * Parameter information:
 * @param _str(&hotSpotOffsets)[] hotSpotOffsets 
 */
void getHotSpotOffsets(_str (&hotSpotOffsets)[])
{
   hotSpotOffsets._makeempty();
   VSSTREAMMARKERINFO info;
   int marker_id=0;
   int i,n=ghotspot_marker_ids._length();
   //Move to first hotspot
   int current = current_hotspot('-');
   if (current < 0) return;
   for (i = 0; (current) && (i < (n - current)); i++) {
      next_hotspot();
   }
   hotSpotOffsets[hotSpotOffsets._length()] = point() " "point('L') " "p_col;
   for (i=1; i<n; ++i) {
      next_hotspot();
      hotSpotOffsets[hotSpotOffsets._length()] = point() " "point('L') " "p_col;
   }
}
/**
 * Author: David A. O'Brien
 * Date:   11/19/2007
 * 
 * Restore hotspots that were save from a call to getHotSpotOffsets();
 * 
 * Parameter information:
 * @param _str[] hotSpotOffsets 
 */
void setHotSpotOffsets(_str hotSpotOffsets[])
{
   clear_hotspots();
   int i;
   typeless stop_point='';
   typeless stop_line='';
   typeless stop_col='';
   for (i = 0; i < hotSpotOffsets._length(); ++i) {
      parse hotSpotOffsets[i] with stop_point stop_line stop_col;
      goto_point(stop_point,stop_line);p_col=stop_col;
      add_hotspot();
   }
   if (hotSpotOffsets._length()) {
      parse hotSpotOffsets[0] with stop_point stop_line stop_col;
      goto_point(stop_point,stop_line);p_col=stop_col;
   }
}

/**
 * Jump to the next or previous hotspot marker.
 * 
 * @param dir     + means forward, - means backwards
 * 
 * @return true if successful
 * 
 * @see add_hotspot
 * @see next_hotspot
 * @see prev_hotspot
 */
static boolean nextprev_hotspot(_str dir, boolean wrap=true)
{
   //  ignore hotspot navigation?
   if (!def_hotspot_navigation) {
      return false;
   }

   // not an editor control?
   if (!_isEditorCtl()) {
      return false;
   }

   // do we have any hotspot markers set?
   if (ghotspot_marker_ids._length() < 2) {
      clear_hotspots();
      return false;
   }

   // look up the current hotspot
   int n=ghotspot_marker_ids._length();
   int i = current_hotspot(dir);
   if (i < 0 || i >= n) {
      return false;
   }

   from_offset := _QROffset();

   // adjust the offset of the original hotspot, this allows
   // us to return to the exact spot of the marker the
   // if they do prev-hotspot
   VSSTREAMMARKERINFO info;
   VS_HOTSPOT_MARKER hotspot = ghotspot_marker_ids[i];
   if (_StreamMarkerGet(hotspot.id, info)) {
      return false;
   }

   // only adjust hotspot cursor position if current_hotspot found
   // an exact match for the cursor location
   save_pos(auto p);
   long currentOffset = _QROffset();
   if (currentOffset >= info.StartOffset && currentOffset <= info.StartOffset+info.Length) {
      _GoToROffset(info.StartOffset);
      int startLine = p_line;
      restore_pos(p);
      ghotspot_marker_ids[i].line_offset = p_line - startLine;
      ghotspot_marker_ids[i].column_offset = p_col;
   }

   // depending on the direction, move forward or backward
   if (dir == '-') {
      if (i <= 0) {
         if (!wrap) return false;
         i = ghotspot_marker_ids._length()-1;
      } else {
         i--;
      }
   } else {
      if (i >= n-1) {
         if (!wrap) return false;
         i = 0;
      } else {
         i++;
      }
   }

   // look up the cursor location for mark that we found
   hotspot = ghotspot_marker_ids[i];

   if (!_goto_hotspot(hotspot)) {
      return false;
   }

   // success
   call_list('_nextprev_hotspot_', from_offset, _QROffset());
   message_hotspots(true);
   return true;
}

/**
 * Determine whether next/prev hotspot should be enabled.
 */
int _OnUpdate_next_hotspot(CMDUI &cmdui,int target_wid,_str command)
{
   if (_no_child_windows()) return MF_GRAYED;
   if (!target_wid._isEditorCtl()) return MF_GRAYED;
   return (target_wid.current_hotspot('+') < 0)? MF_GRAYED:MF_ENABLED;
}
int _OnUpdate_prev_hotspot(CMDUI &cmdui,int target_wid,_str command)
{
   if (_no_child_windows()) return MF_GRAYED;
   if (!target_wid._isEditorCtl()) return MF_GRAYED;
   return (target_wid.current_hotspot('-') < 0)? MF_GRAYED:MF_ENABLED;
}

/**
 * Navigate from the current hotspot to the previous hotspot.
 * 
 * @return true if we jumped to the hotspot, false otherwise
 * 
 * @see add_hotspot
 * @see next_hotspot
 * @see clear_hotspots
 * 
 * @appliesTo  Edit_Window, Editor_Control
 * @categories Bookmark_Functions
 */
_command boolean prev_hotspot() name_info(','VSARG2_EDITORCTL|VSARG2_REQUIRES_EDITORCTL)
{
   return nextprev_hotspot('-');
}

/**
 * Navigate from the current hotspot to the next hotspot.
 * 
 * @return true if we jumped to the hotspot, false otherwise
 * 
 * @see add_hotspot
 * @see prev_hotspot
 * @see clear_hotspots
 * 
 * @appliesTo  Edit_Window, Editor_Control
 * @categories Bookmark_Functions
 */
_command boolean next_hotspot() name_info(','VSARG2_EDITORCTL|VSARG2_REQUIRES_EDITORCTL)
{
   return nextprev_hotspot('+');
}

/**
 * Add a hotspot at the current cursor location within the current
 * buffer.  The range of the hotspot is extended from the cursor
 * location backwards to the first non-blank character and forward
 * to the first non-blank character after the cursor.
 * 
 * @appliesTo  Edit_Window, Editor_Control
 * @categories Bookmark_Functions
 */
void add_hotspot(boolean quiet = false)
{
   // is this feature disabled?
   if (!def_hotspot_navigation) {
      return;
   }

   // find the next non-blank character
   save_pos(auto p);
   search('[^ \t\n\r]','@rh');
   long endOffset = _QROffset();

   // find the next non-blank character
   restore_pos(p);
   left();
   search('[^ \t\n\r]','-@rh');
   long startOffset = _QROffset();
   int startColumn = p_col;
   int startLine   = p_line;
   restore_pos(p);

   // add the marker between the previous non-blank character
   // and the next non-blank character
   VS_HOTSPOT_MARKER hotspot;
   int i,n = ghotspot_marker_ids._length();
   int type = get_hotspots_marker_type();
   hotspot.id = _StreamMarkerAdd(p_window_id, startOffset,
                                 endOffset-startOffset+1,
                                 true, 0, type, null);

   // add the cursor offset from the begining of the hotspot
   hotspot.line_offset   = p_line - startLine;
   hotspot.column_offset = p_col;

   // bubble the new item up so list is sorted by offset
   ghotspot_marker_ids[n] = hotspot;
   VSSTREAMMARKERINFO info1;
   VSSTREAMMARKERINFO info2;
   for (i=n; i>0; --i) {
      // get this item
      int id = ghotspot_marker_ids[i].id;
      if (_StreamMarkerGet(id, info1)) continue;
      // get the previous item
      id  = ghotspot_marker_ids[i-1].id;
      if (_StreamMarkerGet(id, info2)) continue;

      // check if not sorted
      if (info1.StartOffset < info2.StartOffset) {
         // swap marker IDs
         hotspot = ghotspot_marker_ids[i-1];
         ghotspot_marker_ids[i-1] = ghotspot_marker_ids[i];
         ghotspot_marker_ids[i]   = hotspot;
      }
   }

   // tell user they can hit Ctrl+[
   if (!quiet) {
      message_hotspots(false);
   }
}

