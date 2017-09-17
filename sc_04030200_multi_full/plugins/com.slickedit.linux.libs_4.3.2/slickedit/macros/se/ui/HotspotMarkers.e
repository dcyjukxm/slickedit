////////////////////////////////////////////////////////////////////////////////////
// $Revision: 38278 $
////////////////////////////////////////////////////////////////////////////////////
// Copyright 2012 SlickEdit Inc. 
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
#import "notifications.e"
#import "recmacro.e"
#require "se/ui/IEventListener.e"
#require "se/ui/ITextChangeListener.e"
#require "se/ui/NavMarker.e"
#import "se/ui/EventUI.e"
#import "se/ui/TextChange.e"
#endregion

namespace se.ui;

class HotspotMarkers : IEventListener, ITextChangeListener {
   private static int s_markerType = -1;

   private static int getMarkerType()
   {
      if (s_markerType < 0) {
         s_markerType = _MarkerTypeAlloc();
         _MarkerTypeSetFlags(s_markerType, 0);
      }
      return s_markerType;
   }

   static void initMarkerType()
   {
      s_markerType = -1;
   }

   /************************************************************/
   private NavMarker m_markers[];
   private int m_range = -1;

   HotspotMarkers()
   {
   }

   private void onCreate(long (&hotspotOffsets)[])
   {
      long startOffset = hotspotOffsets[0];
      long endOffset = startOffset;
      foreach (auto offset in hotspotOffsets) {
         NavMarker m;
         id := m_markers._length();
         m_markers[id] = m;
         m_markers[id].set(offset);

         if (offset < startOffset) {
            startOffset = offset;
         }
         if (offset > endOffset) {
            endOffset = offset;
         }
      }

      m_range = _StreamMarkerAdd(p_window_id, startOffset, endOffset - startOffset, true, 0, getMarkerType(), null);
   }

   private void freeMarker()
   {
      foreach (auto marker in m_markers) {
         marker.remove();
      }
      if (m_range >= 0) {
         _StreamMarkerRemove(m_range);
         m_range = -1;
      }
      TextChangeNotify.removeListener(&this);
   }

   private void doExit()
   {
      EventUI.removeListener(&this);
   }

   private boolean onEscape()
   {
      doExit();
      return(true);
   }

   private boolean onNextPrev(boolean next)
   {
      current := 0;
      if (m_markers._length() > 1) {
         offset := _QROffset();

         int i;
         // find next
         if (next) {
            for (i = 0; i < m_markers._length(); ++i) {
               if (m_markers[i].getOffset() > offset) {
                  break;
               }
            }
            current = i;
            if (current >= m_markers._length()) {
               current = 0;
            }

         } else {
            for (i = 0; i < m_markers._length(); ++i) {
               if (m_markers[i].getOffset() >= offset) {
                  break;
               }
            }
            current = i - 1;
            if (current < 0) {
               current = m_markers._length() - 1;
            }
         }
      }
      m_markers[current].gotoMarker();
      return(true);
   }

   boolean onKey(_str &key)
   {
      if (m_markers._isempty() || m_markers._length() == 0) {
         doExit();
         return(false);
      }

      offset := _QROffset();
      if (m_range < 0 || _StreamMarkerGet(m_range, auto info) ||
          info.Length == 0) {
         doExit();
         return(false);
      }
      if (offset < info.StartOffset || offset > info.StartOffset + info.Length) {
         doExit();
         return(false);
      }

      switch (key) {
      case ESC:
         return(onEscape());
      case TAB:
         return(onNextPrev(true));
      case S_TAB:
         return(onNextPrev(false));
      }
      return(false);
   }

   void onRemove()
   {
      freeMarker();
      removeMarker(this);
   }

   void onPush()
   {
      if (m_markers._isempty() || m_markers._length() == 0) {
         return;
      }

      _str keyarray[];  // this could be static
      keyarray[0] = ESC;
      keyarray[1] = TAB;
      keyarray[2] = S_TAB;
      EventUI.setCallbacks(keyarray);

      foreach (auto marker in m_markers) {
         marker.show();
      }
      return;
   }

   void onPop()
   {
      foreach (auto marker in m_markers) {
         marker.hide();
      }
   }

   void onTextChange(long startOffset, long endOffset)
   {
      if (p_TextWrapChangeNotify) {
         return;
      }

      VSSTREAMMARKERINFO info;
      if (m_range < 0 || _StreamMarkerGet(m_range, info) ||
          info.Length == 0) {
         doExit();
         return;
      }
      if (endOffset < info.StartOffset || startOffset >= info.StartOffset + info.Length) {
         doExit();
         return;
      }

      int i, id;
      for (i = m_markers._length() - 1; i >= 0; --i) {
         id = m_markers[i].getMarkerID();
         if (_StreamMarkerGet(id, info) || info.Length == 0 || info.StartOffset == endOffset) {
            m_markers[i].remove();
            m_markers._deleteel(i);
            continue;
         }
      }

      if (m_markers._length() == 0) {
         doExit();
         return;
      }
   }

   /************************************************************/
   private static HotspotMarkers s_marker[];

   static void createMarker(long (&hotspotOffsets)[])
   {
      // check def_hotspot_navigation??
      _updateTextChange();
      if (!hotspotOffsets._length()) {
         return;
      }

      HotspotMarkers marker;
      marker.onCreate(hotspotOffsets);
      id := s_marker._length();
      s_marker[id] = marker;
      TextChangeNotify.addListener(&s_marker[id]);
      EventUI.addListener(&s_marker[id]);
   }

   private static void removeMarker(HotspotMarkers &marker)
   {
      for (id := 0; id < s_marker._length(); ++id) {
         if (s_marker[id] == marker) {
            s_marker[id] = null;
            s_marker._deleteel(id);
            break;
         }
      }
   }

   static void exit()
   {
      s_marker._makeempty();
   }
};

namespace default;
using namespace se.ui.HotspotMarkers;

definit()
{
   HotspotMarkers.initMarkerType();
}

void _exit_se_ui_AutoBracketMarker()
{
   HotspotMarkers.exit();
}

