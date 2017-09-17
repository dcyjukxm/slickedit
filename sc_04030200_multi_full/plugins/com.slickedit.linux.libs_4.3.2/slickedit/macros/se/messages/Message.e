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
#pragma option(pedantic, on)
#region Imports
#import "slick.sh"
#import "stdprocs.e"
#import "files.e"
#import "markers.sh"
#require "se/lineinfo/LineInfo.e"
#endregion

#define MSGCLEAR_NEVER     0x00000000   // Never auto-clear (future).
#define MSGCLEAR_BUFFER    0x00000001   // Auto-clear on buffer switch.
#define MSGCLEAR_PROJECT   0x00000002   // Auto-clear on project close.
#define MSGCLEAR_WKSPACE   0x00000004   // Auto-clear on workspace close.
#define MSGCLEAR_EDITOR    0x00000008   // Auto-clear on editor close.
#define MSGCLEAR_ALWAYS    0x0000000F   // Always auto-clear.

namespace se.messages;



class MenuItem {
   _str m_callback;
   _str m_menuText;

   MenuItem ()
   {
      m_callback = '';
      m_menuText = '';
   }
   ~MenuItem () {}
};



class Message : se.lineinfo.LineInfo {
   public void makeCaption ();
   public boolean goToCodeLocation ();
   public void removeMarker ();
   public void delete ();

   _str m_creator;
   _str m_date;
   _str m_description;
   _str m_deleteCallback;
   int m_lineNumber;
   int m_colNumber;
   int m_length;
   int m_markerPic;
   int m_markerType; // returned by _MarkerTypeAlloc()
   int m_autoClear; // MSGCLEAR flag
   boolean m_markerTypeAllocated;
   typeless m_attributes:[]; // Attribute/value pairs that are available for any
                             // use.
   MenuItem m_menuItems[];


   Message ()
   {
      m_creator = "";
      m_date = "";
      m_description = "";
      m_deleteCallback = "";
      m_lineNumber = 0;
      m_colNumber = 0;
      m_length = 1;
      m_markerPic = 0;
      m_markerType = -1;
      m_autoClear = MSGCLEAR_WKSPACE;
      m_markerTypeAllocated = false;
   }
   ~Message ()
   {
   }

   
   public void makeCaption ()
   {
      m_preview = m_preview'<code>Creator:</code><br>'m_creator'<br><br>';
      m_preview = m_preview'<code>Type:</code><br>'m_type'<br><br>';
      m_preview = m_preview'<code>Date:</code><br>'m_date'<br><br>';
      m_preview = m_preview'<code>Description:</code><br>'m_description'<br>';
   }


   /**
    * Opens the file associated with the message and goes to the 
    * proper line and, possibly, column. If the marker isn't where
    * it was last reported, update the message to the new location. 
    *  
    * @return Returns true if the message's location was updated.
    * 
    */
   public boolean goToCodeLocation ()
   {
      _str sourceFile = '';
      boolean isChanged = false;
      
      sourceFile = maybe_quote_filename(m_sourceFile);
      if (sourceFile == '') {
         return false;
      }
      edit(sourceFile, EDIT_DEFAULT_FLAGS);

      // Prefer stream markers to line markers.
      if (m_smarkerID > -1) {
         VSSTREAMMARKERINFO sInfo;
         if (_StreamMarkerGet(m_smarkerID, sInfo)) {
            m_lineVisited = true;
            return isChanged;
         }
         _GoToROffset(sInfo.StartOffset);
      } else if (m_lmarkerID > -1) {
         VSLINEMARKERINFO lInfo;
         if (_LineMarkerGet(m_lmarkerID, lInfo)) {
            m_lineVisited = true;
            return isChanged;
         }
         if (lInfo.LineNum > 0) {
            _mdi.p_child.p_RLine = lInfo.LineNum;
            _mdi.p_child.p_col = 1;
         }
      }

      if (m_lineNumber != _mdi.p_child.p_RLine) {
         m_lineNumber = _mdi.p_child.p_RLine;
         isChanged = true;
      }
      if (m_colNumber != _mdi.p_child.p_col) {
         m_colNumber = _mdi.p_child.p_col;
         isChanged = true;
      }

      m_lineVisited = true;
      return isChanged;
   }


   public void removeMarker ()
   {
      if (m_lmarkerID > -1) {
         _LineMarkerRemove(m_lmarkerID);
      }
      if (m_smarkerID > -1) {
         _StreamMarkerRemove(m_smarkerID);
      }
   }


   public void delete ()
   {
      int callbackIDX = find_index(m_deleteCallback, COMMAND_TYPE|PROC_TYPE);
      if (callbackIDX && index_callable(callbackIDX)) {
         call_index(&this, callbackIDX);
      }
   }
};
