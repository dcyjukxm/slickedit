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
#require "DialogTransformer.e"
#import "listbox.e"
#import "treeview.e"
#endregion Imports

namespace se.options;

#define COMMON_WORDS       ' an and are by cancel from help in is of ok or that the this to when with '

/**
 * This class is used to embed an existing, freestanding dialog
 * in the options dialog.
 * 
 */
class DialogTagger : DialogTransformer
{
   private _str m_complexControlsToTag = '';

   /**
    * DialogTagger Constructor.  Initializes callback
    * functions based on the form name.
    * 
    * @param caption    caption associated with this dialog in the options tree
    * @param panelHelp  help info to be displayed when the form is displayed
    * @param systemHelp p_help entry for this dialog in the help system
    * @param form       the form name of this form
    * @param index      index in the XML DOM for the options
    * 
    */
   DialogTagger(_str caption = '', _str panelHelp = '', _str systemHelp = '', 
                     _str form = '', int index = 0, _str inheritsFromForm = '') 
   {
      DialogTransformer(caption, panelHelp, systemHelp, form, index, inheritsFromForm);
   }

   /**
    * Sets the "complex" controls that we want to go through and add tags for. 
    * Complex controls include trees and combo boxes and list boxes. 
    * 
    * @param controls            list of controls, comma delimited
    */
   public void setComplexControlsToTag(_str controls)
   {
      m_complexControlsToTag = controls;
   }

   /**
    * Sets the window id for this dialog transformer
    * 
    * @param value      window id
    */
   public void setWID(int value)
   {
      m_wid = value;
   }

   /**
    * Generates a list of search tags for this dialog.  Search tags include words 
    * that appear on GUI controls on this form. 
    * 
    * @param tags                list of tags that we definitely want included in 
    *                            the final listbox
    * @param allowLangs          true if we allow language ids and mode names to be 
    *                            search tags for this form
    * 
    * @return                    the list of search tags we found
    */
   public _str generateSearchTags(_str tags, boolean allowLangs)
   {
      // maybe add in a language id or a version control id?
      if (m_langID != '') tags :+= ' 'm_langID;
      if (m_vcProviderID != '') tags :+= ' 'm_vcProviderID;

      getSearchTags(m_wid.p_child, tags);

      // now we remove all the duplicates, please
      newTags := lowcase(m_wid.p_caption);
      word := '';
      rest := '';

      while (true) {
         parse tags with word rest;
         if (word == '') break;

         do {

            // we don't want single letters here
            if (length(word) == 1) break;

            // we don't want words that are only numbers in disguise
            if (isinteger(word)) break;

            // we don't want these words, they suck
            if (pos(' 'word' ', COMMON_WORDS)) break;

            // sometimes we don't allow language ids or names
            if (!allowLangs && (_LangId2Modename(word) != '' || _Modename2LangId(word) != '')) {

               // we will allow the lang id or name for this section of the options
               if (word != m_langID && word != _LangId2Modename(m_langID)) {                           
                  break;
               }
            }

            // make sure we this isn't already in something we 
            // already have or something we will look at later
            if (!pos(word, rest) && !pos(word, newTags)) newTags :+= ' 'word;

         } while (false);
            
         tags = rest;
      }

      return newTags;
   }

   /**
    * Retrieves all search tags from a control and its siblings.  This may be 
    * called recursively on any child controls. 
    * 
    * @param firstWid            first control to check
    * @param tags                running list of search tags
    */
   private void getSearchTags(int firstWid, _str &tags)
   {
      // traverse the form, looking for labels and such...
      if (!firstWid) return;

      wid := firstWid;
      for(;;) {

         if (wid.p_visible) {

            text := '';
            switch (wid.p_object) {
            case OI_COMMAND_BUTTON:
            case OI_CHECK_BOX:
            case OI_FRAME:
            case OI_LABEL:
            case OI_RADIO_BUTTON:
               text = lowcase(wid.p_caption);
               break;
            case OI_SSTAB:
               // add the caption of each tab
               numTabs := wid.p_NofTabs;
               for (i := 0; i < numTabs; i++) {
                  wid.p_ActiveTab = i;
                  text :+= ' 'lowcase(wid.p_ActiveCaption);
               }
               break;
            case OI_SSTAB_CONTAINER:
               text = lowcase(wid.p_ActiveCaption);
               break;
            case OI_COMBO_BOX:
               // a complex control - must check if we want it
               if (pos(' 'wid.p_name' ', ' 'm_complexControlsToTag' ')) {
                  text = getTagsFromListBox(wid);
               }
               break;
            case OI_LIST_BOX:
               // a complex control - must check if we want it
               if (pos(' 'wid.p_name' ', ' 'm_complexControlsToTag' ')) {
                  text = getTagsFromListBox(wid);
               }
               break;
            case OI_TREE_VIEW:

               // go ahead and get any column captions we might have
               numCols := wid._TreeGetNumColButtons();
               for (i = 0; i < numCols; i++) {
                  wid._TreeGetColButtonInfo(i, auto width, auto flags, auto state, auto caption);
                  if (caption != '') text :+=' 'lowcase(caption);
               }

               // a complex control - must check if we want it
               if (pos(' 'wid.p_name' ', ' 'm_complexControlsToTag' ')) {
                  text :+= getTagsFromTree(wid);
               }
               break;
            }

            if (text != '') {
               // replace all hyphens, underscores, slashes, tabs, and newlines with spaces
               text = stranslate(text, ' ', '(-|_|\\|/|\t|\r|\)|\()', 'R');

               // remove leading and trailing spaces
               text = strip(text, 'B');

               // remove non-alphanumeric, non-space characters
               text = stranslate(text, '', '[~a-z ]', 'R');
               
               // remove these - they are common buttons
               if (text == 'ok' || text == 'help' || text == 'cancel') text = '';

               // add it in there - we will remove duplicates later
               if (text != '') {
                  tags :+= ' 'text;
               }
            }
         }
         
         // check out the children
         if (wid.p_child) {
            getSearchTags(wid.p_child, tags);
         }

         // go on to the next one
         wid = wid.p_next;
         if (wid == firstWid) break;
      }
   }

   /**
    * Goes through a list box and retrieves each line to be used as a search tag. 
    * Can also be called with the p_cb_list_box property of a combo box. 
    * 
    * @param lb         window id of the list box (or p_cb_list_box property of a 
    *                   combo box)
    * 
    * @return           list of search tags for this list box
    */
   private _str getTagsFromListBox(int lb)
   {
      text := '';

      // let's start at the very beginning
      lb._lbtop();

      while (true) {
         // grab each line and then ease on down the road
         text :+= ' 'lowcase(lb._lbget_text());
         if (lb._lbdown()) break;
      }

      return text;
   }

   /**
    * Goes through a tree view and retrieves each line to be used as a search tag. 
    * 
    * @param tree       window id of the tree
    * 
    * @return           list of search tags for this tree
    */
   private _str getTagsFromTree(int tree)
   {
      text := '';

      // let's start at the very beginning
      tree._TreeTop();

      while (true) {
         // grab each line and then ease on down the road
         text :+= ' 'lowcase(tree._TreeGetCurCaption());
         if (tree._TreeDown()) break;
      }

      return text;
  } 

   /**
    * Returns the type of panel for this object.
    * 
    * @return        the OPTIONS_PANEL_TYPE of this object
    */
   public int getPanelType()
   {
      return OPT_DIALOG_TAGGER;
   }
};
