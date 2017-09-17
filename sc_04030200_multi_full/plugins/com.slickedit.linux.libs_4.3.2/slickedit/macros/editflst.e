////////////////////////////////////////////////////////////////////////////////////
// $Revision: 46085 $
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
#import "complete.e"
#endregion

defload()
{
   _str info='a:'(FILE_CASE_MATCH|AUTO_DIR_MATCH)MORE_ARG','(VSARG2_CMDLINE);
   set_name_info(find_index('e',COMMAND_TYPE),info);
   set_name_info(find_index('edit',COMMAND_TYPE),info);

}
_str def_binary_ext='.sx .ex .obj .exe .lib ';

_str a_match(_str name,boolean find_first)
{
   if (def_keys!='brief-keys') {
      return(f_match(name,find_first));
   }
   name=f_match(name,find_first);
   for (;;) {
      if ( name=='' ) {
         return('');
      }
      if ( ! pos('.'_get_extension(name)' ',def_binary_ext,1,_fpos_case) ) {
         break;
      }
      name=f_match(name,false);
   }
   return name;

}
