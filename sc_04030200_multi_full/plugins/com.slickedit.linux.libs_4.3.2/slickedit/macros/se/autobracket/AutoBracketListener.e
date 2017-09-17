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
#import "codehelp.e"
#import "recmacro.e"
#import "slickc.e"
#import "se/lang/api/LanguageSettings.e"
#require "se/autobracket/DefaultAutoBracket.e"
#require "se/lang/generic/GenericAutoBracket.e"
#require "se/lang/cpp/CPPAutoBracket.e"
#require "se/lang/objectivec/ObjectiveCAutoBracket.e"
#require "se/ui/AutoBracketMarker.e"
#endregion

namespace se.autobracket;

using namespace se.lang.api;
using namespace se.lang.generic;
using namespace se.lang.cpp;
using namespace se.lang.objectivec;

using se.ui.AutoBracketMarker;

class AutoBracketListener {
   private static boolean s_cancelInsert = false;

   static void cancelBracketInsert()
   {
      s_cancelInsert = true;
   }

   private static boolean doLanguageKey(_str langID, _str &key)
   {
      switch (langID) {
      case "ansic":
      case "c":
         CPPAutoBracket c;
         return c.onKey(key);

      case "cs":
         CSharpAutoBracket cs;
         return cs.onKey(key);
         
      case "d":
         DAutoBracket dlang;
         return dlang.onKey(key);

      case "lua":
         LuaAutoBracket l;
         return l.onKey(key);

      case "m":
         ObjectiveCAutoBracket o;
         return o.onKey(key);

      case "phpscript":
      case "pl":
         PerlAutoBracket p;
         return p.onKey(key);

      case "as":
      case "awk":
      case "cfscript":
      case "ch":
      case "e":
      case "java":
      case "js":
      case "jsl":
      case "py":
      case "powershell":
      case "vera":
         GenericAutoBracket g;
         return g.onKey(key);

      case "html":
      case "xml":
      case "vpj":
      case "vpw":
      case "docbook":
         break;
      }
      DefaultAutoBracket d;
      return d.onKey(key);
   }

   private static boolean getSettings(_str key, _str &close_ch, boolean &insertPad)
   {
      if (p_readonly_mode || p_hex_mode == HM_HEX_ON) {
         return(false);
      }
      keyEnabled := false;
      insertPad = false;
      close_ch = '';
      opts := LanguageSettings.getAutoBracket(p_LangId);
      if (opts & AUTO_BRACKET_ENABLE) {
         switch (key) {
         case '(':
            close_ch = ')';
            keyEnabled = (opts & AUTO_BRACKET_PAREN) ? true : false;
            insertPad = (opts & AUTO_BRACKET_PAREN_PAD) ? true : false;
            break;

         case '[':
            close_ch = ']';
            keyEnabled = (opts & AUTO_BRACKET_BRACKET) ? true : false;
            insertPad = (opts & AUTO_BRACKET_BRACKET_PAD) ? true : false;
            break;

         case '<':
            close_ch = '>';
            keyEnabled = (opts & AUTO_BRACKET_ANGLE_BRACKET) ? true : false;
            insertPad = (opts & AUTO_BRACKET_ANGLE_BRACKET_PAD) ? true : false;
            break;

         case '"':
            close_ch = '"';
            keyEnabled = (opts & AUTO_BRACKET_DOUBLE_QUOTE) ? true : false;
            break;

         case "'":
            close_ch = "'";
            keyEnabled = (opts & AUTO_BRACKET_SINGLE_QUOTE) ? true : false;
            break;
         }
         if (keyEnabled) {
            return doLanguageKey(p_LangId, key);
         }
      }
      return false;
   }

   private static void insertTextMarker(_str open_ch, _str close_ch, boolean insertPad, int openCol)
   {
      _macro('m', _macro('s'));
      closeCol := p_col;
      p_col = openCol;
      openOffset := _QROffset();
      openLen := length(open_ch);
      if (insertPad) {
         p_col += openLen;
         padOffset := closeCol - p_col;
         _insert_text(" ");
         closeCol += 1;
         _macro_append("p_col -= "padOffset";");
         _macro_call('_insert_text', " ");
         _macro_append("p_col += "padOffset";");
      }
      p_col = closeCol;
      text := (insertPad ? " " : "") :+ close_ch;
      _insert_text(text);
      closeLen := length(close_ch);
      closeOffset := _QROffset() - closeLen;
      colOffset := insertPad ? closeLen + 1 : closeLen;
      p_col -= colOffset;
      _macro_call('_insert_text', text);
      _macro_append("p_col -= "colOffset";");
      AutoBracketMarker.createMarker(close_ch, openOffset, openLen, closeOffset, closeLen);
   }

   private static void addMarker(_str close_ch, boolean insertPad, long openOffset, long openLen)
   {
      text := (insertPad ? "  " : "") :+ close_ch;
      _insert_text(text);
      closeLen := length(close_ch);
      closeOffset := _QROffset() - closeLen;
      colOffset := insertPad ? closeLen + 1 : closeLen;
      p_col -= colOffset;

      _macro('m', _macro('s'));
      _macro_call('_insert_text', text);
      _macro_append("p_col -= "colOffset";");
      AutoBracketMarker.createMarker(close_ch, openOffset, openLen, closeOffset, closeLen);
   }

   private static boolean onKey(_str key)
   {
      cancelInsert := s_cancelInsert;
      s_cancelInsert = false;
      embedded_status := _EmbeddedStart(auto orig_values);
      result := getSettings(key, auto close_ch, auto insertPad);
      if (result) {
         openCol := p_col;
         call_key(key, '', '1');
         if (!s_cancelInsert) {
            openLen := length(key);
            if (p_col > openCol + openLen) {
               insertTextMarker(key, close_ch, insertPad, openCol);
            } else {
               openOffset := _QROffset() - openLen;
               addMarker(close_ch, insertPad, openOffset, openLen);
            }
            RefreshListHelp();
         }
      }
      if (embedded_status == 1) {
         _EmbeddedEnd(orig_values);
      }
      s_cancelInsert = cancelInsert;
      return(result);
   }

   static boolean onKeyin(_str key)
   {
      s_cancelInsert = true;  // ensure keyin callback gets canceled
      embedded_status := _EmbeddedStart(auto orig_values);
      result := getSettings(key, auto close_ch, auto insertPad);
      if (result) {
         text := key :+ (insertPad ? "  " : "") :+ close_ch;
         _insert_text(text);
         openLen := length(key);
         closeLen := length(close_ch);
         openOffset := _QROffset() - length(text);
         closeOffset := _QROffset() - closeLen;
         colOffset := closeLen + (insertPad ? 1 : 0);
         p_col -= colOffset;
         AutoBracketMarker.createMarker(close_ch, openOffset, openLen, closeOffset, closeLen);
      } 
      if (embedded_status == 1) {
         _EmbeddedEnd(orig_values);
      }
      return(result);
   }

   static void initCallback(boolean enabled)
   {
      _str keyarray[];
      if (enabled) {
         keyarray[0] = '(';
         keyarray[1] = '[';
         keyarray[2] = '<';
         keyarray[3] = '"';
         keyarray[4] = "'";
      }
      _kbd_add_callback(find_index('se.autobracket.AutoBracketListener.onKey', PROC_TYPE), keyarray);
   }
};

