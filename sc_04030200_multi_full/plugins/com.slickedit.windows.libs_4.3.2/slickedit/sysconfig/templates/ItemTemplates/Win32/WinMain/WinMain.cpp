
/*
 * Optional #defines for targeting this application for specific
 * windows versions and SDK features            
#ifndef WINVER
#define WINVER 0x0500     
#endif

#ifndef _WIN32_WINNT      
#define _WIN32_WINNT 0x0500   
#endif                        

#ifndef _WIN32_WINDOWS        
#define _WIN32_WINDOWS 0x0410 
#endif

#define WIN32_LEAN_AND_MEAN
*/

#include <windows.h>

#include <stdlib.h>
#include <malloc.h>
#include <memory.h>
#include <tchar.h>
#include "$fileinputname$_res.h"

// WinMain and Window Procedures forward declarations
WORD Register$safeitemname$Class(HINSTANCE hInstance);
int Init$safeitemname$Instance(HINSTANCE, int);
LRESULT CALLBACK $safeitemname$WndProc(HWND, UINT, WPARAM, LPARAM);
int CALLBACK About$safeitemname$(HWND, UINT, WPARAM, LPARAM);

const int nMaxStringResource = 100;

HINSTANCE h$safeitemname$AppInst;                               
TCHAR szTitle[nMaxStringResource];                  
TCHAR szWindowClass[nMaxStringResource];            

int APIENTRY _tWinMain(HINSTANCE hInstance, HINSTANCE hPrevInstance,
                       LPTSTR lpCmdLine,int nCmdShow)
{
    MSG msg;
    HACCEL hAccelTable;

    // Load resource strings for window title
    LoadString(hInstance, IDS_$safeitemname$_APP_TITLE, szTitle, nMaxStringResource);
    LoadString(hInstance, IDC_$safeitemname$, szWindowClass, nMaxStringResource);

    // Register the window class
    Register$safeitemname$Class(hInstance);

    // Create and show the $itemname$ window
    if (!Init$safeitemname$Instance (hInstance, nCmdShow))
    {
        return FALSE;
    }

    // Load resources for keyboard shortcuts
    hAccelTable = LoadAccelerators(hInstance, MAKEINTRESOURCE(IDC_$safeitemname$));

    // Main message loop
    while (GetMessage(&msg, NULL, 0, 0))
    {
        if (!TranslateAccelerator(msg.hwnd, hAccelTable, &msg))
        {
            TranslateMessage(&msg);
            DispatchMessage(&msg);
        }
    }

    return (int) msg.wParam;

    UNREFERENCED_PARAMETER(hPrevInstance);
    UNREFERENCED_PARAMETER(lpCmdLine);
}

/*
 *   Register$safeitemname$Class
 *       Register the WNDCLASS(EX) that defines the main application window
 */
ATOM Register$safeitemname$Class(HINSTANCE hInstance)
{
    WNDCLASSEX wcex;

    wcex.cbSize = sizeof(WNDCLASSEX);

    wcex.style          = CS_HREDRAW | CS_VREDRAW;
    wcex.lpfnWndProc    = $safeitemname$WndProc;
    wcex.cbClsExtra     = 0;
    wcex.cbWndExtra     = 0;
    wcex.hInstance      = hInstance;
    wcex.hIcon          = LoadIcon(hInstance, MAKEINTRESOURCE(IDI_$safeitemname$));
    wcex.hCursor        = LoadCursor(NULL, IDC_ARROW);
    wcex.hbrBackground  = (HBRUSH)(COLOR_WINDOW+1);
    wcex.lpszMenuName   = MAKEINTRESOURCE(IDC_$safeitemname$);
    wcex.lpszClassName  = szWindowClass;
    wcex.hIconSm        = LoadIcon(wcex.hInstance, MAKEINTRESOURCE(IDI_$safeitemname$_SMALL));

    return RegisterClassEx(&wcex);
}

/*
 *   Init$safeitemname$Instance
 *       Create and display the main application window.
 */
BOOL Init$safeitemname$Instance(HINSTANCE hInstance, int nCmdShow)
{
   HWND hWnd;

   h$safeitemname$AppInst = hInstance; 

   hWnd = CreateWindow(szWindowClass, szTitle, WS_OVERLAPPEDWINDOW,
      CW_USEDEFAULT, 0, CW_USEDEFAULT, 0, NULL, NULL, hInstance, NULL);

   if (!hWnd)
   {
      return FALSE;
   }

   ShowWindow(hWnd, nCmdShow);
   UpdateWindow(hWnd);

   return TRUE;
}

/*
 * $safeitemname$WndProc
 *   Event loop for the main window
 */
LRESULT CALLBACK $safeitemname$WndProc(HWND hWnd, UINT message, WPARAM wParam, LPARAM lParam)
{
    int wmId, wmEvent;
    PAINTSTRUCT ps;
    HDC hdc;

    switch (message)
    {
    case WM_COMMAND:
        wmId    = LOWORD(wParam);
        wmEvent = HIWORD(wParam);
        // Parse the menu selections:
        switch (wmId)
        {
        case IDM_ABOUT:
            DialogBox(h$safeitemname$AppInst, MAKEINTRESOURCE(IDD_ABOUTBOX), hWnd, About$safeitemname$);
            break;
        case IDM_EXIT:
            DestroyWindow(hWnd);
            break;
        default:
            return DefWindowProc(hWnd, message, wParam, lParam);
        }
        break;
    case WM_PAINT:
        hdc = BeginPaint(hWnd, &ps);
        // TODO: Add any drawing code here...
        EndPaint(hWnd, &ps);
        break;
    case WM_DESTROY:
        PostQuitMessage(0);
        break;
    default:
        return DefWindowProc(hWnd, message, wParam, lParam);
    }
    return 0;
}

/* 
 *   Message handler for the about box
 */
int CALLBACK About$safeitemname$(HWND hDlg, UINT message, WPARAM wParam, LPARAM lParam)
{
    switch (message)
    {
    case WM_INITDIALOG:
        return (INT_PTR)TRUE;

    case WM_COMMAND:
        if (LOWORD(wParam) == IDOK || LOWORD(wParam) == IDCANCEL)
        {
            EndDialog(hDlg, LOWORD(wParam));
            return (INT_PTR)TRUE;
        }
        break;
    }
    return (LRESULT)FALSE;
    UNREFERENCED_PARAMETER(lParam);
}
