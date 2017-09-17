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
#ifndef SVC_SH
#define SVC_SH

#if __UNIX__
   #define VCSYSTEM_FILE       'uvcsys.slk'
   #define VC_ERROR_FILENAME   'vcs.slk'
   #define VC_ERROR_FILENAME2  'vcs2.slk'
   #define VC_COMMENT_FILENAME 'cmt.slk'
#else
   #define VCSYSTEM_FILE       'vcsystem.slk'
   #define VC_ERROR_FILENAME   '$vcs.slk'
   #define VC_ERROR_FILENAME2  '$vcs2.slk'
   #define VC_COMMENT_FILENAME '$cmt.slk'
#endif


struct SVC_AUTHENTICATE_INFO {
   _str username;
   _str password;
};

struct SVC_ANNOTATION {
   _str userid;
   _str date;
   _str version;
   long seek;
};

struct SVC_FILE_INFO {
   int annotationMarkerType;
   SVC_ANNOTATION annotations[];
};

struct SVC_QUEUE_ITEM {
   _str filename;
   _str VCSystem;
};
#endif   // SVC_SH
