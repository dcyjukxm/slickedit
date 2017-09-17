////////////////////////////////////////////////////////////////////////////////////
// $Revision: 38578 $
////////////////////////////////////////////////////////////////////////////////////
// Copyright 2010 SlickEdit Inc.
////////////////////////////////////////////////////////////////////////////////////
#ifdef VSUSE_QT

#ifndef __VSQT_H__
#define __VSQT_H__


EXTERN_C_BEGIN
/*
   Would have liked to use QWidget here but QT has big problems with
   order of header files.  Specifically X11 header files which we
   include a lot.  In addition, we might defined a vlayer interface
   which would have to abstract the widget type any way.
*/   
typedef void vsUserWidget;
typedef void vsUserPopupMenu;

/********************************************************/
// functions defined in vs that must be called

// This argument should be typed as XEvent *xevent but 
// QT does not seem to work this way
bool VSAPI vsqt_x11EventFilter(void * xevent);
void VSAPI vsqt_eventLoopTimerEvent();
void VSAPI vsqt_executeMenuItem(void *pParameter);

/********************************************************/
// Functions that must be implemented
bool VSAPI vsqt_hasPendingEvents();
void VSAPI vsqt_processEvents();
Window VSAPI vsqt_QWidget_winId(vsUserWidget* pvsUserWidget);
vsUserWidget * VSAPI vsqt_QWidget_parentWidget(vsUserWidget* pvsUserWidget);
void VSAPI vsqt_QWidget_setEnabled(vsUserWidget *pvsUserWidget,bool enabled);
bool VSAPI vsqt_QWidget_isEnabled(vsUserWidget *pvsUserWidget);
void VSAPI vsqt_QWidget_setFocus(vsUserWidget *pvsUserWidget);
vsUserWidget * VSAPI vsqt_QWidget_create(vsUserWidget *pvsParentUserWidget);

bool VSAPI vsqt_allowKeyboardInput(vsUserWidget *pvsUserWidget /* may be null*/);
bool VSAPI vsqt_cancelMenu(vsUserWidget *pvsUserWidget);

void VSAPI vsqt_setClipboardData(const char *pszFormatName,const char *pbuf,int len,bool isClipboard);
int VSAPI vsqt_getClipboardData(const char *pszFormatName,char **ppBuf,int *pBufLen,bool isClipboard);
bool VSAPI vsqt_isClipboardFormatAvailable(const char *pszFormatName,bool isClipboard);
long VSAPI vsqt_registerClipboardFormat(const char *pszFormatName);
const char * VSAPI vsqt_cf_to_str(long atom);
void VSAPI vsqt_emptyClipboard(bool isClipboard);

vsUserPopupMenu* VSAPI vsqt_PopupMenuAppendSubMenu(vsUserPopupMenu *parent,const char *pszText,bool enabled,int reserved=0,void *preserved=0);
vsUserPopupMenu* VSAPI vsqt_createPopupMenu(vsUserWidget *parent,void *reserved);
void VSAPI vsqt_destroyPopupMenu(vsUserPopupMenu *pvsUserPopupMenu,void *);
void VSAPI vsqt_PopupMenuAppendTextItem(
   vsUserPopupMenu *pvsUserPopupMenu,const char *pszText,void *pParameter,bool enabled,
   bool checkable,bool checkState,int reserved=0,void *preserved=0);
void VSAPI vsqt_showPopupMenu(vsUserPopupMenu *pvsUserPopupMenu,int x=0x7fffffff,int y=0x7fffffff,int flags=0);

EXTERN_C_END
/*
   Might need vsqt_getShellFocus later if have problems restoring
   focus to control which had focus last within a particular shell.
*/
//vsUserWidget *vsqt_getShellFocus(vsUserWidget *pvsUserWidget);



#endif

#endif
