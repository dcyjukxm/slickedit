////////////////////////////////////////////////////////////////////////////////////
// $Revision: 38278 $
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
#import "vi.e"
#require "se/ui/IEventListener.e"
#endregion

namespace se.ui;

class EventUI {
   private IEventListener *m_modeList[];

   EventUI()
   {
   }

   private void add(IEventListener *ui)
   {
      if (m_modeList._length() > 0) {
         IEventListener *event = m_modeList._lastel();
         (*event).onPop();
      }
      m_modeList[m_modeList._length()] = ui;
      (*ui).onPush();
   }

   private void remove(IEventListener *ui)
   {
      for (id := 0; id < m_modeList._length(); ++id) {
         if (m_modeList[id] == ui) {
            (*m_modeList[id]).onRemove();
            m_modeList[id] = null;
            m_modeList._deleteel(id);
            break;
         }
      }
      if (!m_modeList._isempty() && m_modeList._length() > 0) {
         IEventListener *event = m_modeList._lastel();
         (*event).onPush();
      } else {
         setCallbacks(null);
      }
   }

   void removeAll()
   {
      foreach (auto m in m_modeList) {
         m->onRemove();
      }
      m_modeList._makeempty();
      setCallbacks(null);
   }

   boolean onKey(_str &key)
   {
      if (m_modeList._isempty()) {
         return(false);
      }
      status := false;
      cnt := m_modeList._length();
      id := m_modeList._length() - 1;
      while (!status && id >= 0) {
         status = m_modeList[id]->onKey(key);
         --id;
      }
      if (status) {
         if (key :== ESC && def_keys == 'vi-keys' && def_vim_esc_codehelp) {
            vi_escape();
         }
      }
      return(status);
   }

   /************************************************************/
   private static EventUI s_buffers:[];

   static void init()
   {
      s_buffers._makeempty();
   }

   static void removeBuffer(int bufID)
   {
      if (s_buffers._indexin(bufID)) {
         s_buffers:[bufID].removeAll();
         s_buffers._deleteel(bufID);
      }
   }

   static void addListener(IEventListener *ui)
   {
      bufID := p_buf_id;
      if (!s_buffers._indexin(bufID)) {
         EventUI ev;
         s_buffers:[bufID] = ev;
      }
      s_buffers:[bufID].add(ui);
   }

   static void removeListener(IEventListener *ui)
   {
      bufID := p_buf_id;
      if (s_buffers._indexin(bufID) && !s_buffers:[bufID]._isempty()) {
         s_buffers:[bufID].remove(ui);
      }
   }

   private static boolean onKeyCallback(_str key)
   {
      bufID := p_buf_id;
      if (!s_buffers._indexin(bufID) || s_buffers:[bufID]._isempty()) {
         return(false);
      }
      return(s_buffers:[bufID].onKey(key));
   }

   static void setCallbacks(_str (&keyarray)[])
   {
      _kbd_add_callback(find_index('se.ui.EventUI.onKeyCallback', PROC_TYPE), keyarray);
   }

   static void initCallbacks()
   {
      _kbd_add_callback(find_index('se.ui.EventUI.onKeyCallback', PROC_TYPE), null);
   }
};

namespace default;
using namespace se.ui.EventUI;

definit()
{
   EventUI.init();
}

void _exit_se_ui_EventUI()
{
   EventUI.init();
}

void _cbquit_se_ui_EventUI(int bufID, _str name)
{
   EventUI.removeBuffer(bufID);
}

void setEventUICallbacks()
{
   EventUI.initCallbacks();
}

