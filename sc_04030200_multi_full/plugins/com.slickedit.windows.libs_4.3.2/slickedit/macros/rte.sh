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
extern void dllinit_vsRTE();
extern void vsRTE_startup();
extern int rteAddProject(int hProject);
extern int rteAddFile(int handle, _str _fileName);
extern void rteMaybeAddToSourcePath(int handle, _str _fileName);
extern int rteSetClassPath(int projectHandle, _str _classPath);
extern int rteSetJvmLibPath(int projectHandle, _str _jvmPath);
extern void rteClearProjects();
extern void rteUpdate();
extern int rteUpdateEditor(int wid, _str szFileName, int buf_id);
extern void rteAddBuffer(int buf_id, _str szFileName, int flags);
extern int rteNextError(int line_no, _str bufName);
extern void rtePushBuffer(int wid, int buf_id, _str bufName);
extern int rteSetActiveBuffer(int window_id, int buf_id, _str bufName);
extern int rteRemoveProject(int hProject);
extern int rteSetJDKPath(_str _path);
extern void rteShutdown(int clear_errors);

extern int rteSetEnableJavaLiveErrors(int value);
extern int rteSetEnableDeprecationWarnings(int value);
extern int rteSetNoWarnings(int value);
extern int rteSetTargetComplianceLevel(_str complianceLevel);
extern int rteSetSourceComplianceLevel(_str complianceLevel);
extern int rteSetOutputDir(int projectHandle, _str outputDir);
extern int rteSetSleepInterval(int value);
extern int rteSetIncrementalCompile(int value);
extern int rteSetOtherOptions(_str optionsString);
