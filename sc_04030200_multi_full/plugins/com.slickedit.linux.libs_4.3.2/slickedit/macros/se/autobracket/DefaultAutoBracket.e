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
#import "c.e"
#endregion

namespace se.autobracket;

class DefaultAutoBracket
{
   protected boolean checkCommentsAndStrings()
   {
      // options to allow auto brackets in string/comment?
      if (_text_colc() == 0) {  // handle multiline comment/string continuation
         flags := _lineflags();
         return (_clex_InComment(flags) || _clex_InString(flags));
      }

      clexflags := _clex_translate(_clex_find(0, 'g'));
      if (clexflags & (COMMENT_CLEXFLAG|STRING_CLEXFLAG)) {
         if (p_col > 1) {
            left(); status := _clex_find(clexflags, 't'); right();
            return(status != 0);
         }
      }
      return(false);
   }

   protected boolean checkParens()
   {
      return(0);
   }

   protected boolean checkBracket()
   {
      return(0);
   }

   protected boolean checkAngleBracket()
   {
      return(0);
   }

   protected boolean checkQuote(_str &key)
   {
      return(0);
   }

   boolean onKey(_str key)
   {      
      if (checkCommentsAndStrings()) {
         return(false);
      }
      switch (key) {
      case '(':
         return (!checkParens());

      case '[':
         return (!checkBracket());

      case '<':
         return (!checkAngleBracket());

      case "'":
      case '"':
         return (!checkQuote(key));
      }
      return(false);
   }
};

