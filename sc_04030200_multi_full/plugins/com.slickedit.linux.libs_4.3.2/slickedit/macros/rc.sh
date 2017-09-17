///////////////////////////////////////////////////////////////////////////////
// $Revision: 52754 $
///////////////////////////////////////////////////////////////////////////////

#ifndef RC_SH
#define RC_SH

///////////////////////////////////////////////////////////////////////////////
// FIO
///////////////////////////////////////////////////////////////////////////////

// File not found
#define FILE_NOT_FOUND_RC -2
// Path not found
#define PATH_NOT_FOUND_RC -3
// Too many open files
#define TOO_MANY_OPEN_FILES_RC -4
// Access denied
#define ACCESS_DENIED_RC -5
// Memory control blocks destroyed.  Save files and reboot.
#define MEMORY_CONTROL_BLOCKS_RC -7
// Insufficient memory
#define INSUFFICIENT_MEMORY_RC -8
// File exceeds size limit
#define FILE_TOO_LARGE_RC -9
// Invalid drive
#define INVALID_DRIVE_RC -15
// No more files
#define NO_MORE_FILES_RC -18
// Disk is write-protected
#define DISK_IS_WRITE_PROTECTED_RC -19
// Unknown unit
#define UNKNOWN_UNIT_RC -20
// Drive not ready
#define DRIVE_NOT_READY_RC -21
// Bad device command
#define BAD_DEVICE_COMMAND_RC -22
// Data error (CRC)
#define DATA_ERROR_RC -23
// Bad request structure length
#define BAD_REQUEST_STRUCTURE_LENGTH_RC -24
// Seek error
#define SEEK_ERROR_RC -25
// Unknown media type
#define UNKNOWN_MEDIA_TYPE_RC -26
// Sector not found
#define SECTOR_NOT_FOUND_RC -27
// Printer out of paper
#define PRINTER_OUT_OF_PAPER_RC -28
// Write fault
#define WRITE_FAULT_RC -29
// Read fault
#define READ_FAULT_RC -30
// General failure
#define GENERAL_FAILURE_RC -31
// Error opening file
#define ERROR_OPENING_FILE_RC -32
// Error reading file
#define ERROR_READING_FILE_RC -33
// Error writing file
#define ERROR_WRITING_FILE_RC -34
// Error closing file
#define ERROR_CLOSING_FILE_RC -35
// Insufficient disk space
#define INSUFFICIENT_DISK_SPACE_RC -36
// Program can not be run in OS/2 mode
#define PROGRAM_CAN_NOT_BE_RUN_IN_OS2_RC -37
// Error creating directory entry
#define ERROR_CREATING_DIRECTORY_RC -38
// Session parent already exists
#define SESSION_PARENT_EXISTS_RC -39
// PIF file vsshell.pif or vsproces.pif not found
#define PIF_FILE_NOT_FOUND_RC -40
// Bad PIF file size or format
#define BAD_PIF_FILE_RC -41
// Error creating PIF file.
#define UNABLE_TO_CREATE_PIF_FILE_RC -42
// Unable to open error code temp file.
#define UNABLE_TO_OPEN_ERROR_CODE_TEMP_FILE_RC -43
// Unable to open PIF temp file.
#define UNABLE_TO_OPEN_PIF_TEMP_FILE_RC -44
// Bad error code temp file
#define BAD_ERROR_CODE_TEMP_FILE_RC -45
// Invalid executable format
#define INVALID_EXECUTABLE_FORMAT_RC -46
// System failed to execute program
#define SYSTEM_FAILED_TO_EXECUTE_PROGRAM_RC -47
// Program WDOSRC.EXE not found.
#define WDOSRC_FILE_NOT_FOUND_RC -48
// Unable to create timer
#define FIOERROR_CREATING_TIMER_RC -49
// Unable to create timer
#define FIOBREAK_KEY_PRESSED_RC -50
// Program SLKSHELL.EXE not found.
#define SLKSHELL_FILE_NOT_FOUND_RC -51
// Invalid argument
#define FIOINVALID_ARGUMENT_RC -52
// End of file reached
#define EOF_RC -53
// File '%s1' not found
#define ARGFILE_NOT_FOUND_RC -54
// Access denied to file %s1
#define ARGACCESS_DENIED_RC -55
// Path not found for file %s1
#define ARGPATH_NOT_FOUND_RC -56
// Unable to open file %s1
#define ARGUNABLE_TO_OPEN_FILE_RC -57
// Member in use
#define MEMBER_IN_USE_RC -58
// Data set in use
#define DATASET_IN_USE_RC -59
// Data set or member in use
#define DATASET_OR_MEMBER_IN_USE_RC -60
// Volume out of space
#define VOLUME_OUT_OF_SPACE_RC -61
// Data set out of extent
#define DATASET_OUT_OF_EXTENT_RC -62
// PDS directory out of space
#define PDS_DIR_OUT_OF_SPACE_RC -63
// Data set I/O error
#define DATASET_IO_RC -64
// Unsupported data set type
#define UNSUPPORTED_DATASET_TYPE_RC -65
// Data set not PDS
#define DATASET_NOT_PDS_RC -66
// PDS member not found
#define PDS_MEMBER_NOT_FOUND_RC -67
// No more available DD name
#define NO_MORE_DDNAME_RC -68
// Unable to allocate DD name to data set
#define UNABLE_TO_ALLOCATE_DDNAME_TO_DATASET_RC -69
// Data set not sequential
#define DATASET_NOT_SEQUENTIAL_RC -70
// Unsupported data set operation
#define UNSUPPORTED_DATASET_OPERATION_RC -71
// Invalid data set name
#define INVALID_DATASET_NAME_RC -72
// Invalid PDS member name
#define INVALID_PDS_MEMBER_NAME_RC -73
// Insufficient access to data set
#define INSUFFICIENT_ACCESS_TO_DATASET_RC -74
// Unable to update PDS member directory
#define UNABLE_TO_UPDATE_PDS_MEMBER_DIRECTORY_RC -75
// Invalid data set password
#define INVALID_DATASET_PASSWORD_RC -76
// Data set not found
#define DATASET_NOT_FOUND_RC -77
// Cannot access internal reader
#define CANT_ACCESS_INTERNAL_READER_RC -78
// Cannot write to syslog
#define CANT_WRITE_TO_SYSLOG_RC -79
// Cannot load assembler modules
#define CANT_LOAD_ASSEMBLER_MODULES_RC -80
// Cannot query system data set listing
#define CANT_QUERY_SYSTEM_DATASET_LISTING_RC -81
// Insufficient spill disk space. Please inform the system programmers and check your SlickEdit log /tmp/vslog.YourUSERID for more information.
#define INSUFFICIENT_SPILL_DISK_SPACE_RC -82
// Insufficient user log disk space. Please inform the system programmers and check your SlickEdit log /tmp/vslog.YourUSERID for more information.
#define INSUFFICIENT_LOG_DISK_SPACE_RC -83
// User log /tmp/vslog.YourUSERID too large. All further logging suppressed.
#define USER_LOG_TOO_LARGE_RC -84
// Bad URL
#define URL_BAD_RC -85
// URL protocol not supported
#define URL_PROTO_NOT_SUPPORTED_RC -86
// Error reading response or response invalid
#define URL_ERROR_READING_RESPONSE_RC -87
// URL status condition - %s1
#define URL_STATUS_RC -88
// URL moved
#define URL_MOVED_RC -89
// URL response not supported - %s1
#define URL_RESPONSE_NOT_SUPPORTED_RC -90
// Invalid argument
#define VSRC_INVALID_ARGUMENT -91
// Buffer overflow
#define BUFFER_OVERFLOW_RC -92
// Error creating or setting registry value %s1
#define ERROR_CREATING_REGISTRY_VALUE_RC -93
// Error creating registry key %s1
#define ERROR_CREATING_REGISTRY_KEY_RC -94
// Operation cancelled
#define VSRC_OPERATION_CANCELLED -95
// Operation not yet finished
#define VSRC_OPERATION_NOT_FINISHED -96
// Attempt to obtain write lock would result in deadlock.
#define VSRC_POTENTIAL_DEADLOCK_DETECTED -97

///////////////////////////////////////////////////////////////////////////////
// SOCK
///////////////////////////////////////////////////////////////////////////////

// General socket error
#define SOCK_GENERAL_ERROR_RC -100
// Socks system failed to initialize
#define SOCK_INIT_FAILED_RC -101
// Socks system not initialized
#define SOCK_NOT_INIT_RC -102
// Bad host address or host not found
#define SOCK_BAD_HOST_RC -103
// No more sockets available
#define SOCK_NO_MORE_SOCKETS_RC -104
// Socket timed out
#define SOCK_TIMED_OUT_RC -105
// Bad port
#define SOCK_BAD_PORT_RC -106
// Bad socket
#define SOCK_BAD_SOCKET_RC -107
// Socket not connected
#define SOCK_SOCKET_NOT_CONNECTED_RC -108
// Socket would have blocked
#define SOCK_WOULD_BLOCK_RC -109
// Network down
#define SOCK_NET_DOWN_RC -110
// Not enough memory
#define SOCK_NOT_ENOUGH_MEMORY_RC -111
// Argument not large enough
#define SOCK_SIZE_ERROR_RC -112
// No more data
#define SOCK_NO_MORE_DATA_RC -113
// Address not available
#define SOCK_ADDR_NOT_AVAILABLE_RC -114
// Socket not listening
#define SOCK_NOT_LISTENING_RC -115
// No pending connections
#define SOCK_NO_CONN_PENDING_RC -116
// Connection aborted
#define SOCK_CONN_ABORTED_RC -117
// Connection reset
#define SOCK_CONN_RESET_RC -118
// Socket shut down
#define SOCK_SHUTDOWN_RC -119
// Connection closed
#define SOCK_CONNECTION_CLOSED_RC -120
// No protocol available
#define SOCK_NO_PROTOCOL_RC -121
// Connection refused
#define SOCK_CONN_REFUSED_RC -122
// Nonauthoritative host not found
#define SOCK_TRY_AGAIN_RC -123
// Host not found
#define SOCK_NO_RECOVERY_RC -124
// Socket or address in use
#define SOCK_IN_USE_RC -125

///////////////////////////////////////////////////////////////////////////////
// CFORMAT
///////////////////////////////////////////////////////////////////////////////

// General error
#define CFERROR_GENERAL_ERROR_RC -200
// Unexpected end-of-file
#define CFERROR_EOF_UNEXPECTED_RC -201
// Unexpected symbol
#define CFERROR_SYMBOL_UNEXPECTED_RC -202
// Right paren expected
#define CFERROR_RIGHTPAREN_EXPECTED_RC -203
// Right brace expected
#define CFERROR_RIGHTBRACE_EXPECTED_RC -204
// Right bracket expected
#define CFERROR_RIGHTBRACKET_EXPECTED_RC -205
// Left paren expected
#define CFERROR_LEFTPAREN_EXPECTED_RC -206
// Left brace expected
#define CFERROR_LEFTBRACE_EXPECTED_RC -207
// Left bracket expected
#define CFERROR_LEFTBRACKET_EXPECTED_RC -208
// Unexpected right paren
#define CFERROR_RIGHTPAREN_UNEXPECTED_RC -209
// Unexpected right brace, possible missing ;
#define CFERROR_RIGHTBRACE_UNEXPECTED_RC -210
// Unexpected right bracket
#define CFERROR_RIGHTBRACKET_UNEXPECTED_RC -211
// Unexpected left paren
#define CFERROR_LEFTPAREN_UNEXPECTED_RC -212
// Unexpected left brace
#define CFERROR_LEFTBRACE_UNEXPECTED_RC -213
// Unexpected left bracket
#define CFERROR_LEFTBRACKET_UNEXPECTED_RC -214
// Unexpected case
#define CFERROR_CASE_UNEXPECTED_RC -215
// Expected colon
#define CFERROR_COLON_EXPECTED_RC -216
// Expected semicolon
#define CFERROR_SEMI_EXPECTED_RC -217
// Unexpected preprocessor
#define CFERROR_PP_UNEXPECTED_RC -218
// Expected while
#define CFERROR_WHILE_EXPECTED_RC -219
// Unexpected else
#define CFERROR_ELSE_UNEXPECTED_RC -220
// Error in template
#define CFERROR_ERROR_IN_TEMPLATE_RC -221
// Unexpected endsubmenu
#define CFERROR_ENDSUBMENU_UNEXPECTED_RC -222
// Unexpected submenu
#define CFERROR_SUBMENU_UNEXPECTED_RC -223
// Unexpected _menu
#define CFERROR_MENU_UNEXPECTED_RC -224
// Unexpected catch
#define CFERROR_CATCH_UNEXPECTED_RC -225
// Unexpected finally
#define CFERROR_FINALLY_UNEXPECTED_RC -226
// Unhandled syntax
#define CFERROR_UNHANDLED_SYNTAX_RC -227

///////////////////////////////////////////////////////////////////////////////
// VSUPDATE
///////////////////////////////////////////////////////////////////////////////

// Serial number and license information successfully transferred
#define VSUPDATE_LICENSE_TRANSFERRED_RC -350
// 
// vsupdate Version 12.0
// 
// This program is used to copy the serial number and license information from one SlickEdit executable to another.
// 
// Usage:
// 	vsupdate old-exe-name new-exe-name
// 
// 	old-exe-name	Name of original executable to take license info from.
// 	new-exe-name	Name of new executable to transfer license info to.
#define VSUPDATE_HELP_RC -351
// Invalid serial number
#define VSUPDATE_INVALID_SERIAL_NUMBER_RC -352
// Version 12.0
// 
// This program is used to copy the serial number and license information from one SlickEdit executable to another.
// 
// Usage:
// 	vsupdatw old-exe-name new-exe-name
// 
// 	old-exe-name	Name of original executable to take license info from.
// 	new-exe-name	Name of new executable to transfer license info to.
#define VSUPDATE_HELP_WIN_RC -353
// Invalid or missing license
#define VSUPDATE_INVALID_LICENSE_RC -354
// Invalid or missing packages
#define VSUPDATE_INVALID_PACKS_RC -355
// Hot fix file is not for this machine architecture
#define VSUPDATE_INCORRECT_ARCHITECTURE_RC -356
// Hot fix contains DLLs that are for Windows platforms only
#define VSUPDATE_DLL_ONLY_FOR_WINDOWS_RC -357

///////////////////////////////////////////////////////////////////////////////
// KBIO
///////////////////////////////////////////////////////////////////////////////

// Unable to initialize console
#define UNABLE_TO_INIT_CONSOLE_RC -500

///////////////////////////////////////////////////////////////////////////////
// HFORMAT
///////////////////////////////////////////////////////////////////////////////

// General error
#define HFERROR_GENERAL_ERROR_RC -700
// Unexpected end-of-file
#define HFERROR_EOF_UNEXPECTED_RC -701

///////////////////////////////////////////////////////////////////////////////
// SLICKEDITOR
///////////////////////////////////////////////////////////////////////////////

// 
#define SLICK_EDITOR_VERSION_RC -2000
// Spill file too large. Save files and exit
#define SPILL_FILE_TOO_LARGE_RC -2001
// ON
#define ON_RC -2002
// OFF
#define OFF_RC -2003
// Expecting ignore or exact
#define EXPECTING_IGNORE_OR_EXACT_RC -2004
// Error in margin settings
#define ERROR_IN_MARGIN_SETTINGS_RC -2005
// Error in tab settings
#define ERROR_IN_TAB_SETTINGS_RC -2006
// Unknown command
#define UNKNOWN_COMMAND_RC -2007
// Missing filename
#define MISSING_FILENAME_RC -2008
// Too many files
#define TOO_MANY_FILES_RC -2009
// Too many selections
#define TOO_MANY_SELECTIONS_RC -2010
// Lines truncated
#define LINES_TRUNCATED_RC -2011
// Text already selected
#define TEXT_ALREADY_SELECTED_RC -2012
// Text not selected
#define TEXT_NOT_SELECTED_RC -2013
// Invalid selection type
#define INVALID_SELECTION_TYPE_RC -2014
// Source destination conflict
#define SOURCE_DEST_CONFLICT_RC -2015
// New file
#define NEW_FILE_RC -2016
// Line selection required
#define LINE_SELECTION_REQUIRED_RC -2017
// Block selection required
#define BLOCK_SELECTION_REQUIRED_RC -2018
// Too many window groups
#define TOO_MANY_GROUPS_RC -2019
// Macro file %s1 not found
#define MACRO_FILE_NOT_FOUND_RC -2020
// Cannot delete root node
#define TREE_CANNOT_DELETE_ROOT_NODE_RC -2021
// Hit any key to continue
#define HIT_ANY_KEY_RC -2023
// Bottom of file
#define BOTTOM_OF_FILE_RC -2024
// Top of file
#define TOP_OF_FILE_RC -2025
// Invalid point
#define INVALID_POINT_RC -2026
// .  Type any key.
#define TYPE_ANY_KEY_RC -2027
// Too many windows
#define TOO_MANY_WINDOWS_RC -2028
// Not enough memory
#define NOT_ENOUGH_MEMORY_RC -2029
// Press any key to continue
#define PRESS_ANY_KEY_TO_CONTINUE_RC -2030
// Spill file I/O error
#define SPILL_FILE_IO_ERROR_RC -2031
// .  Type new drive letter
#define TYPE_NEW_DRIVE_LETTER_RC -2032
// Nothing to undo
#define NOTHING_TO_UNDO_RC -2033
// Nothing to redo
#define NOTHING_TO_REDO_RC -2034
// Line or block selection required
#define LINE_OR_BLOCK_SELECTION_REQUIRED_RC -2035
// Invalid selection handle
#define INVALID_SELECTION_HANDLE_RC -2036
// Searching and Replacing...
#define SEARCHING_AND_REPLACING_RC -2037
// Command cancelled
#define COMMAND_CANCELLED_RC -2038
// Error creating semaphore
#define ERROR_CREATING_SEMAPHORE_RC -2039
// Error creating thread
#define ERROR_CREATING_THREAD_RC -2040
// Error creating queue
#define ERROR_CREATING_QUEUE_RC -2041
// Process already running
#define PROCESS_ALREADY_RUNNING_RC -2042
// Cannot find process init program 'ntpinit'
#define CANT_FIND_INIT_PROGRAM_RC -2043
// Command line too long.  Place wild card filespecs in double quotes.
#define CMDLINE_TOO_LONG_RC -2044
// 
#define SERIAL_NUMBER_RC -2045
// '%s1' is not recognized as a compatible state file or pcode file
#define UNRECOGNIZED_STATE_FILE_FORMAT_RC -2046
// 
#define PACKAGE_LICENSES_RC -2047
// Unable to create spill file '%s1'
#define UNABLE_TO_CREATE_SPILL_FILE_RC -2049
// Unable to display popup
#define UNABLE_TO_DISPLAY_POPUP_RC -2052
// Menu handle must be popup
#define MENU_HANDLE_MUST_BE_POPUP_RC -2053
// Menu handle can not be popup
#define MENU_HANDLE_CAN_NOT_BE_POPUP_RC -2054
// Invalid menu handle
#define INVALID_MENU_HANDLE_RC -2055
// Menu handle already attached to window
#define MENU_HANDLE_ALREADY_ATTACHED_TO_WINDOW_RC -2056
// This border style does not support menus
#define THIS_BORDER_STYLE_DOES_NOT_SUPPORT_MENUS_RC -2057
#define NOT_USED7_RC -2058
// Command not allowed when activate window is iconized
#define COMMAND_NOT_ALLOWED_WHEN_AW_IS_ICON_RC -2059
// Command not allowed when no edit windows present
#define COMMAND_NOT_ALLOWED_WHEN_NCW_RC -2060
// slkwait program not found
#define SLKWAIT_PROGRAM_NOT_FOUND_RC -2061
// Changes the window size
#define SIZE_RC -2062
// Changes the window position
#define MOVE_RC -2063
// Closes the window
#define CLOSE_RC -2064
// Reduces the window to an icon
#define MINIMIZE_RC -2065
// Enlarges the window to full size
#define MAXIMIZE_RC -2066
// Switches to the next window
#define NEXTWINDOW_RC -2067
// Restores the window to normal size
#define RESTORE_RC -2068
// Displays the task list menu
#define TASKLIST_RC -2069
// Quits the program
#define CLOSE_APPLICATION_RC -2070
// Move, size, or close the document window
#define WINDOW_MENU_RC -2071
// Move, size, or close the application window
#define APPLICATION_MENU_RC -2072
// This property or method is not allowed on this object
#define PROPERTY_OR_METHOD_NOT_ALLOWED_RC -2073
// Unable to create timer
#define UNABLE_TO_CREATE_TIMER_RC -2074
// Time out waiting for process to initialized
#define TIMEOUT_WATING_FOR_PROCESS_INIT_RC -2075
// Cannot create mdi form object
#define CANT_CREATE_MDI_FORM_OBJECT_RC -2076
// Form object can not be clipped child
#define FORM_OBJECT_CAN_NOT_BE_CLIPPED_CHILD_RC -2077
// Control objects must have parent
#define CONTROL_OBJECTS_MUST_HAVE_PARENT_RC -2078
// Invalid parent window
#define INVALID_PARENT_WINDOW_RC -2079
// Invalid sort data
#define INVALID_SORT_DATA_RC -2080
// xterm program not found
#define XTERM_PROGRAM_NOT_FOUND_RC -2081
// This property or method requires a displayed object
#define OBJECT_MUST_BE_DISPLAYED_RC -2082
// Form or control does not have name
#define FORM_OR_CONTROL_DOES_NOT_HAVE_NAME_RC -2083
// This operation is not supported with this clipboard format
#define CLIPBOARD_OPERATION_NOT_SUPPORTED_RC -2084
// Unable to get clipboard data
#define UNABLE_TO_GET_CLIPBOARD_DATA_RC -2085
// Nothing selected
#define NOTHING_SELECTED_RC -2086
// System call failed
#define SYSTEM_CALL_FAILED_RC -2087
// Invalid object handle
#define INVALID_OBJECT_HANDLE_RC -2088
// Failed to load printer driver
#define FAILED_TO_LOAD_PRINTER_DRIVER_RC -2089
// ExtDevMode function not found
#define EXT_DEVICE_MODE_FUNCTION_NOT_FOUND_RC -2090
// Printer not set up correctly
#define PRINTER_NOT_SET_UP_CORRECTLY_RC -2091
// Unable to start printer
#define UNABLE_TO_START_PRINTER_RC -2092
// Printing failed
#define PRINTER_FAILURE_RC -2093
// The regular expression stack is getting very large due to a complex search string.  You may not have enough memory to complete the search.
// 
// Continue?
#define LONG_STRING_MATCH_RC -2094
// DDE command not processed
#define DDE_NOT_PROCESSED_RC -2095
// DDE server busy
#define DDE_BUSY_RC -2096
// Unable to connect to DDE server
#define DDE_UNABLE_TO_CONNECT_RC -2097
// DDE error
#define DDE_ERROR_RC -2098
// Command not allowed in Read only mode
#define COMMAND_NOT_ALLOWED_IN_READ_ONLY_MODE_RC -2099
// wemu387.386 not installed or invalid
#define WEMU387_NOT_FOUND_OR_INVALID_RC -2100
// Failed to copy/move %s1 to %s2
#define FAILED_TO_BACKUP_FILE_RC -2101
// Failed to copy/move %s1 to %s2.  Access denied.
#define FAILED_TO_BACKUP_FILE_ACCESS_DENIED_RC -2105
// Line
#define LINE_RC -2106
// Col
#define COL_RC -2107
// Ins
#define INS_RC -2108
// Rep
#define REP_RC -2109
// Demo version cannot save files of this extension.  Please contact sales at SlickEdit Inc. at 800 934-3348 or 919 473-0100.
#define DEMO_CANT_SAVE_FILES_RC -2110
// Failed to copy/move %s1 to %s2.  Insufficient disk space.
#define FAILED_TO_BACKUP_FILE_INSUFFICIENT_DISK_SPACE_RC -2111
// Slick-C(R) cannot call DLL function with pointer to void parameter
#define SLICK_C_CANT_CALL_DLL_FUNCTION_WITH_PVOID_RC -2112
// Function not available
#define FUNCTION_NOT_AVAILABLE_RC -2113
// Macros with defmain may not be loaded
#define MACROS_WITH_DEFMAIN_MAY_NOT_BE_LOADED_RC -2114
// 
#define APPNAME_RC -2115
// 
// SlickEdit: An instance of SlickEdit is already being displayed on this X server. The existing instance is being activated.
// 
// If you want to bring up a new copy of SlickEdit, use +new option.
// 
// You can turn off this message by setting VSLICKXNOPLUSNEWMSG=1
// 
#define VSRC_INSTANCE_ALREADY_RUNNING_RC -2121
// Click here to jump to a specific line
#define VSRC_LINE_TOOLTIP_RC -2122
// Click here to jump to a specific column
#define VSRC_COL_TOOLTIP_RC -2123
// Click here to select a language editing mode
#define VSRC_MODE_TOOLTIP_RC -2124
// Click here to toggle read only mode
#define VSRC_READWRITE_TOOLTIP_RC -2125
// Click here to toggle insert/replace mode
#define VSRC_INSREP_TOOLTIP_RC -2126
// Indicates number of lines or columns selected, click to toggle selection
#define VSRC_SELECTION_TOOLTIP_RC -2127
// No Selection
#define NO_SELECTION_RC -2128
// Line
#define SELECTION_1LINE_RC -2129
// Lines
#define SELECTION_LINES_RC -2130
// Col
#define SELECTION_1COLUMN_RC -2131
// Cols
#define SELECTION_COLUMNS_RC -2132
// Block
#define SELECTION_BLOCK_RC -2133
// Click here to toggle macro recording
#define VSRC_RECORD_MACRO_TOOLTIP_RC -2134
// Click here to activate alerts!
#define VSRC_ALERT_TOOLTIP_RC -2135
// The following line(s) are longer than the allowed limit: %s1
#define VSRC_LINES_LONGER_THAN_ALLOWED_LIMIT -2148
// Line truncated to fit within truncate length setting
#define VSRC_LINE_TRUNCATED_TO_FIT_WITHIN_TRUNCATE_LENGTH_RC -2149
// This operation is not allowed after truncation length setting
#define VSRC_THIS_OPERATION_IS_NOT_ALLOWED_AFTER_TRUNCATION_LENGTH -2150
// This operation would create a line longer than the truncation length setting
#define VSRC_THIS_OPERATION_WOULD_CREATE_LINE_TOO_LONG -2151
// The cursor position is past the truncation length setting
#define VSRC_CURSOR_POSITION_PAST_TRUNCATION_LENGTH -2152
// This operation is only allowed when the truncation length is zero
#define VSRC_OPERATION_ONLY_ALLOWED_WHEN_TRUNCATION_LENGTH_IS_ZERO -2153
// The selection is not valid for this operation
#define VSRC_SELECTION_NOT_VALID_FOR_OPERATION -2154
// Record width option is not supported for UNICODE files
#define VSRC_RECORD_WIDTH_OPTION_NOT_SUPPORTED_FOR_UTF8 -2155
// Code page not installed or not valid
#define VSRC_CODE_PAGE_NOT_INSTALLED_OR_NOT_VALID_RC -2156
// Code page to code page translations not supported
#define VSRC_CODE_PAGE_TO_CODE_PAGE_TRANSLATIONS_NOT_SUPPORTED -2157
// This EBCDIC translation is not supported
#define VSRC_THIS_EBCDIC_TRANSLATION_IS_NOT_SUPPORTED -2158
// Command is disabled for this object
#define VSRC_COMMAND_IS_DISABLED_FOR_THIS_OBJECT_OR_STATE -2159
// This command is not implemented in this version.
#define VSRC_COMMAND_NOT_IMPLEMENTED -2160
// Menu %s1 not found
#define VSRC_MENU_NOT_FOUND -2161
// Missing tool window
#define VSRC_TOOL_WINDOW_NOT_FOUND -2162
// Form not found: %s1
#define VSRC_FORM_NOT_FOUND -2163
// License expired
#define VSRC_LICENSE_EXPIRED -2164
// Must be using QT. VSAPIFLAG_USING_QT not specified
#define VSRC_MUST_BE_USING_QT -2165
// Function not supported when using QT. Check for Qt specific function or remove VSAPIFLAG_USING_QT flag
#define VSRC_FUNCTION_NOT_SUPPORTED_WHEN_USING_QT -2166

///////////////////////////////////////////////////////////////////////////////
// REGEX
///////////////////////////////////////////////////////////////////////////////

// Invalid regular expression
#define INVALID_REGULAR_EXPRESSION_RC -2500
#define EOL1_RC -2501
#define EOL2_RC -2502
#define RE_EOF_RC -2503
#define REBREAK_KEY_PRESSED_RC -2504

///////////////////////////////////////////////////////////////////////////////
// VSCR
///////////////////////////////////////////////////////////////////////////////

// Unsupported graphics format
#define VUNSUPPORTED_GRAPHICS_FORMAT_RC -2550
// Invalid bitmap file
#define VINVALID_BITMAP_FILE_RC -2551

///////////////////////////////////////////////////////////////////////////////
// SLICKI
///////////////////////////////////////////////////////////////////////////////

// Incorrect version
#define INCORRECT_VERSION_RC -3000
// No main entry point
#define NO_MAIN_ENTRY_POINT_RC -3001
// Interpreter out of memory
#define INTERPRETER_OUT_OF_MEMORY_RC -3002
// Procedure %s1 not found
#define PROCEDURE_NOT_FOUND_RC -3003
// Module already loaded
#define MODULE_ALREADY_LOADED_RC -3006
// Cannot remove module
#define CANT_REMOVE_MODULE_RC -3007
// Numeric overflow
#define NUMERIC_OVERFLOW_RC -3008
// Invalid number argument
#define INVALID_NUMBER_ARGUMENT_RC -3009
// Recursion too deep
#define RECURSION_TOO_DEEP_RC -3010
// Invalid number of parameters
#define INVALID_NUMBER_OF_PARAMETERS_RC -3011
// Out of string space
#define OUT_OF_STRING_SPACE_RC -3012
// Expression stack overflow
#define EXPRESSION_STACK_OVERFLOW_RC -3013
// Illegal opcode
#define ILLEGAL_OPCODE_RC -3014
// Invalid argument
#define INVALID_ARGUMENT_RC -3015
// Loop stack overflow
#define LOOP_STACK_OVERFLOW_RC -3016
// Divide by zero
#define DIVIDE_BY_ZERO_RC -3017
// Invalid call by reference
#define INVALID_CALL_BY_REFERENCE_RC -3018
// Procedure needs more arguments
#define PROCEDURE_NEEDS_MORE_ARGS_RC -3019
// Break key pressed.  Macro halted
#define BREAK_KEY_PRESSED_RC -3020
// Cannot write state during relink
#define CANT_WRITE_STATE_DURING_REL_RC -3021
// String not found
#define STRING_NOT_FOUND_RC -3022
#define NOT_USED_1_RC -3023
// Command %s1 not found
#define COMMAND_NOT_FOUND_RC -3024
// Function is not supported in DOS
#define FUNCTION_NOT_SUPPORTED_IN_DOS_RC -3027
// Function is not supported in OS/2
#define FUNCTION_NOT_SUPPORTED_IN_OS2_RC -3028
// Invalid name index
#define INVALID_NAME_INDEX_RC -3029
// Invalid option
#define INVALID_OPTION_RC -3030
// Not enough memory to create menu
#define NOT_ENOUGH_MEMORY_TO_CREATE_MENU_RC -3040
// No file active
#define NO_FILE_ACTIVE_RC -3041
// Object %s1 referenced but does not exist
#define OBJECT_REFERENCED_BUT_DOES_NOT_EXIST_RC -3042
// Control %s1 referenced but does not exist
#define CONTROL_REFERENCED_BUT_DOES_NOT_EXIST_RC -3045
// Event table %s1 referenced but does not exist
#define EVENT_TABLE_REFERENCED_BUT_DOES_NOT_EXIST_RC -3048
// VSAPI.DLL not found
#define VSAPI_DLL_NOT_FOUND_RC -3051
// Error loading DLL '%s1'
#define ERROR_LOADING_DLL_RC -3055
// DLL function '%s1' not found
#define DLL_FUNCTION_NOT_FOUND_RC -3058
// DLLEXPORT: Invalid DLL type '%s1'
#define INVALID_DLLTYPE_RC -3061
// %s1: Invalid argument
#define ARGINVALID_ARGUMENT_RC -3064
// Cannot reference deleted element
#define DELETED_ELEMENT_RC -3066
// Warning: A large string of length %s1 bytes about to be created.
// 
// Continue?
#define WARNINGSTRINGLEN_RC -3067
// Invalid array
#define INVALID_ARRAY_RC -3070
// Variable element or variable not initialized
#define ARRAY_OR_HASH_TABLE_ELEMENT_NOT_INITIALIZED_RC -3071
// Invalid HVAR argument
#define INVALID_HVAR_ARGUMENT_RC -3072
// Invalid pointer argument
#define INVALID_POINTER_ARGUMENT_RC -3073
// Module '%s1' contains a call to '%s2' with an uninitialized variable.  Declare a function prototype to find the error at compile time.
#define CALL_WITH_UNINITIALIZED_VARIABLE_RC -3074
// Module '%s1' contains a call to '%s2' with not enough arguments  Declare a function prototype to find the error at compile time.
#define CALL_WITH_NOT_ENOUGH_ARGUMENTS_RC -3079
// Invalid function pointer
#define INVALID_FUNCTION_POINTER_RC -3084
// Warning: A large array of %s1 elements about to be created.
// 
// Continue?
#define WARNINGARRAYSIZE_RC -3085
// Module %s1 references control '%s2' which does not exist on form '%s3'.  If this message is incorrect, declare the control using the _nocheck option (see help on _nocheck).
#define WARNING_POSSIBLE_REFERENCE_TO_CONTROL_WHICH_DOES_NOT_EXIST_RC -3088
// Cannot subscript stack copy of array or hash table
#define CANT_SUBSCRIPT_STACK_COPY_OF_ARRAY_OR_HASH_TABLE_RC -3095
// load_files +c option deprecated.  Use _open_temp_view() or _create_temp_view().
#define VSRC_LOAD_FILES_WITH_PLUSC_OPTION_DEPRECATED -3096
// load_files +v view_id option deprecated.  Use +bi view_id.p_buf_id
#define VSRC_LOAD_FILES_WITH_PLUSV_OPTION_DEPRECATED -3097
// Class '%s1' not found
#define CLASS_NAME_NOT_FOUND_RC -3098
// Class or struct member '%s1' not found
#define CLASS_MEMBER_NOT_FOUND_RC -3099
// Expecting variable with class or struct type
#define EXPECTING_CLASS_INSTANCE_RC -3100
// Slick-C(R) assertion failure
#define SLICKC_ASSERTION_FAILURE_RC -3101
// Attach Slick-C(R) debugger now?
#define SLICKC_ATTACH_DEBUGGER_RC -3102
// Usage: vs [Options] file1 [Options] file2
// 
// + or -new		New instance of the editor.
// -sc config_path	Specifies the configuration directory.
// -sr restore_path	Specifies the directory containing auto-restore
// 		files.
// -st state_ksize	Specifies the maximum amount of swappable
// 		state file data in vslick.sta to be kept in memory,
// 		in kilobytes.
// -sul		Disables byte-range file locking that SlickEdit
// 		normally performs. Use this option when receiving
// 		an 'access denied' error with remote files.
// -x pcode_name	Alternate state file (.sta) or pcode file (.ex).
// -p cmdline	Execute command with arguments given and exit.
// -r cmdline		Execute command with arguments given and
// 		remain resident.
// file1 file2		Files to edit. File names may contain wildcard
// 		characters (* and ?).
// -#command	Execute command on active buffer.
// + or -L[C]		Turn on/off load entire file switch. The optional
// 		C suffix specifies counting the number of lines in
// 		the file.
// + nnn		Load binary file(s) with a record width of nnn.
// +T [ buf_name ]	Start a default operating system format temporary
// 		buffer with name buf_name.
// +TD [ buf_name ]	Start a DOS format temporary buffer with name
// 		buf_name.
// + or -E		Turn on/off expand tabs to spaces when loading
// 		file. Default is off.
#define SLICK_CMD_LINE_USAGE_WIN -3103
// Usage: vs [Options] file1 [Options] file2
// 
//    + or -new         New instance of the editor.
//    -sc config_path   Specifies the configuration directory.
//    -supf kbdfile     Specifies a keyboard file for mapping the keyboard
//                      at the X (modmap) level.
//    -sr restore_path  Specifies the directory containing auto-restore files.
//    -st state_ksize   Specifies the maximum amount of swappable state file
//                      data in vslick.stu to be kept in memory, in kilobytes.
//    -suxft            (Linux only) Disables Xft font support.
//    -sul              Disables the byte-range file locking that SlickEdit
//                      normally performs. Enable this option when receiving
//                      an 'access denied' error with remote files.
//    -x pcode_name     Alternate state file (.stu) or pcode file (.ex).
//    -p cmdline        Execute command with arguments given and exit.
//    -r cmdline        Execute command with arguments given and remain resident.
//    file1 file2       Files to edit. File names may contain wildcard
//                      characters (* and ?).
//    -#command         Execute command on active buffer.
//    + or -L[C]        Turn on/off load entire file switch. The optional C suffix
//                      specifies counting the number of lines in the file.
//    + nnn             Load binary file(s) that follow with a record width nnn.
//    +T [ buf_name ]   Start a default operating system format temporary buffer
//                      with name buf_name.
//    +TU [ buf_name ]  Start a UNIX format temporary buffer with name buf_name.
//    +TM [ buf_name ]  Start a Macintosh format temporary buffer with name buf_name.
//                      Classic Mac line endings are a single carriage return (ASCII 13).
//    + or -E           Turn on/off expand tabs to spaces when loading file. 
//                      Default is off.
// 
#define SLICK_CMD_LINE_USAGE_NIX -3104
// Slick-C stop operator called.
#define SLICK_STOP_OP -3105

///////////////////////////////////////////////////////////////////////////////
// SPELL
///////////////////////////////////////////////////////////////////////////////

// exist
#define SPELL_TEST_RC -3500
// Spell file: %s1 not found
#define SPELL_FILE_NOT_FOUND_RC -3501
// Unable to open main dictionary: %s1
#define SPELL_ERROR_OPENING_MAIN_DICT_FILE_RC -3504
// Unable to open user dictionary: %s1
#define SPELL_ERROR_OPENING_USER_DICT_FILE_RC -3507
// Not enough memory
#define SPELL_NOT_ENOUGH_MEMORY_RC -3510
// Error reading the main dictionary index: %s1
#define SPELL_ERROR_READING_MAIN_INDEX_RC -3511
// Unable to open common word dictionary: %s1
#define SPELL_ERROR_OPENING_COMMON_DICT_RC -3514
// Common word dictionary too large
#define SPELL_COMMON_DICT_TOO_LARGE_RC -3517
// Error reading the common word dictionary: %s1
#define SPELL_ERROR_READING_COMMON_DICT_RC -3518
// User dictionary too large: %s1
#define SPELL_USER_DICT_TOO_LARGE_RC -3521
// Error reading the user dictionary: %s1
#define SPELL_ERROR_READING_USER_DICT_RC -3524
// Unable to update the user dictionary: %s1
#define SPELL_ERROR_UPDATING_USER_DICT_FILE_RC -3527
// Access denied writing the file: %s1
#define SPELL_ACCESS_DENIED_RC -3530
// Out of disk space trying to write: %s1
#define SPELL_OUT_OF_DISK_SPACE_RC -3533
// Error reading the main dictionary
#define SPELL_ERROR_READING_MAIN_DICT_RC -3536
// Word not found
#define SPELL_WORD_NOT_FOUND_RC -3537
// Word may contain a capitalization error
#define SPELL_CAPITALIZATION_RC -3538
// Word too small
#define SPELL_WORD_TOO_SMALL_RC -3539
// Word too large
#define SPELL_WORD_TOO_LARGE_RC -3540
// Word is invalid
#define SPELL_WORD_INVALID_RC -3541
// Word has a replacement
#define SPELL_REPLACE_WORD_RC -3542
// Word cannot be inserted into spell history
#define SPELL_HISTORY_TOO_LARGE_RC -3543
// User dictionary not loaded
#define SPELL_USER_DICT_NOT_LOADED_RC -3544
// No more words to check
#define SPELL_NO_MORE_WORDS_RC -3545
// Repeated word encountered
#define SPELL_REPEATED_WORD_RC -3546

///////////////////////////////////////////////////////////////////////////////
// CLEX
///////////////////////////////////////////////////////////////////////////////

// Not enough memory
#define CLEX_NOT_ENOUGH_MEMORY_RC -3547
// Too many multi-line comments defined
#define CLEX_TOO_MANY_MLCOMMENTS_DEFINED_RC -3548
// Identifier multi-line comments not supported
#define CLEX_IDENTIFIER_MLCOMMENTS_NOT_SUPPORTED_RC -3549
// Too many checkfirst line comments defined
#define CLEX_TOO_MANY_CFLINECOMMENTS_DEFINED_RC -3550
// IDCHARS and CASE-SENSITIVE must be defined first
#define CLEX_IDCHARS_MUST_BE_DEFINED_FIRST_RC -3551
// Invalid style
#define CLEX_INVALID_STYLE_RC -3552
// Invalid MLCOMMENT definition
#define CLEX_INVALID_MLCOMMENT_RC -3553
// Invalid LINECOMMENT definition
#define CLEX_INVALID_LINECOMMENT_RC -3554
// Invalid name
#define CLEX_INVALID_NAME_RC -3555
// File not found
#define CLEX_FILE_NOT_FOUND_RC -3556
// Access denied
#define CLEX_ACCESS_DENIED_RC -3557
// Unable to open file
#define CLEX_UNABLE_TO_OPEN_FILE_RC -3558
// Invalid IDCHARS definition
#define CLEX_INVALID_IDCHARS_RC -3559
// No color coding information for this file 
#define CLEX_NO_INFO_FOR_FILE_RC -3560

///////////////////////////////////////////////////////////////////////////////
// BTREE
///////////////////////////////////////////////////////////////////////////////

// Virtual function
#define VS_TAG_FLAG_VIRTUAL_RC -3860
// Static
#define VS_TAG_FLAG_STATIC_RC -3861
// Public scope
#define VS_TAG_FLAG_PUBLIC_RC -3862
// Package scope
#define VS_TAG_FLAG_PACKAGE_RC -3863
// Protected scope
#define VS_TAG_FLAG_PROTECTED_RC -3864
// Private scope
#define VS_TAG_FLAG_PRIVATE_RC -3865
// Const
#define VS_TAG_FLAG_CONST_RC -3866
// Final
#define VS_TAG_FLAG_FINAL_RC -3867
// Abstract
#define VS_TAG_FLAG_ABSTRACT_RC -3868
// Inline function
#define VS_TAG_FLAG_INLINE_RC -3869
// Overloaded operator
#define VS_TAG_FLAG_OPERATOR_RC -3870
// Class constructor
#define VS_TAG_FLAG_CONSTRUCTOR_RC -3871
// Volatile
#define VS_TAG_FLAG_VOLATILE_RC -3872
// Template or generic
#define VS_TAG_FLAG_TEMPLATE_RC -3873
// Member of class or package
#define VS_TAG_FLAG_INCLASS_RC -3874
// Class destructor
#define VS_TAG_FLAG_DESTRUCTOR_RC -3875
// Synchronized
#define VS_TAG_FLAG_SYNCHRONIZED_RC -3876
// Transient data
#define VS_TAG_FLAG_TRANSIENT_RC -3877
// Native code function
#define VS_TAG_FLAG_NATIVE_RC -3878
// Created by preprocessor macro
#define VS_TAG_FLAG_MACRO_RC -3879
// External function or data
#define VS_TAG_FLAG_EXTERN_RC -3880
// Ambiguous prototype/var declaration
#define VS_TAG_FLAG_MAYBE_VAR_RC -3881
// Unnamed structure
#define VS_TAG_FLAG_ANONYMOUS_RC -3882
// Mutable
#define VS_TAG_FLAG_MUTABLE_RC -3883
// Part of external file
#define VS_TAG_FLAG_EXTERN_MACRO_RC -3884
// 01 level in Cobol linkage section
#define VS_TAG_FLAG_LINKAGE_RC -3885
// Partial class
#define VS_TAG_FLAG_PARTIAL_RC -3886
// Ignore/placeholder
#define VS_TAG_FLAG_IGNORE_RC -3887
// Forward declaration
#define VS_TAG_FLAG_FORWARD_RC -3888
// Opaque enumerated type
#define VS_TAG_FLAG_OPAQUE_RC -3889
// Database index key already exists
#define BT_KEY_ALREADY_EXISTS_RC -3900
// Database record not found
#define BT_RECORD_NOT_FOUND_RC -3901
// Unable to read/write database file
#define BT_UNABLE_TO_RW_FILE_RC -3902
// Database corrupt
#define BT_DATABASE_CORRUPT_RC -3903
// Record length too large
#define BT_RECORD_LENGTH_TOO_LARGE_RC -3904
// Incorrect database version
#define BT_INCORRECT_VERSION_RC -3905
// Incorrect database magic number
#define BT_INCORRECT_MAGIC_RC -3906
// Too many database keys
#define BT_TOO_MANY_KEYS_RC -3907
// Database feature not finished
#define BT_FEATURE_NOT_FINISHED_RC -3908
// Database field is fixed length, expected variable length
#define BT_FIELD_IS_FIXED_LENGTH_RC -3909
// Database field is variable length, expected fixed length
#define BT_FIELD_IS_VARIABLE_LENGTH_RC -3910
// Database block is full
#define BT_BLOCK_FULL_RC -3911
// Unable to delete database item
#define BT_UNABLE_TO_DELETE_RC -3912
// Invalid database block size
#define BT_INVALID_BLOCK_SIZE_RC -3913
// Database record is missing a required field
#define BT_MISSING_REQUIRED_FIELD_RC -3914
// Unable to update database index
#define BT_ERROR_UPDATING_INDEX_RC -3915
// Unable to create database table
#define BT_ERROR_CREATING_TABLE_RC -3916
// Unable to create database index
#define BT_ERROR_CREATING_INDEX_RC -3917
// Unable to open database table
#define BT_ERROR_OPENING_TABLE_RC -3918
// Unable to open database index
#define BT_ERROR_OPENING_INDEX_RC -3919
// Database feature not allowed in this context
#define BT_FEATURE_NOT_ALLOWED_RC -3920
// Database table not found
#define BT_TABLE_NOT_FOUND_RC -3921
// Database index key not found
#define BT_KEY_NOT_FOUND_RC -3922
// Database field not found
#define BT_FIELD_NOT_FOUND_RC -3923
// Database index not found
#define BT_INDEX_NOT_FOUND_RC -3924
// Database internal error
#define BT_INTERNAL_ERROR_RC -3925
// Database field not searchable
#define BT_FIELD_NOT_SEARCHABLE_RC -3926
// Database table field already exists
#define BT_FIELD_ALREADY_EXISTS_RC -3927
// Database table index already exists
#define BT_INDEX_ALREADY_EXISTS_RC -3928
// Database table already exists
#define BT_TABLE_ALREADY_EXISTS_RC -3929
// Database table field must be named
#define BT_FIELD_NAME_REQUIRED_RC -3930
// Database table index must be named
#define BT_INDEX_NAME_REQUIRED_RC -3931
// Database table must be named
#define BT_TABLE_NAME_REQUIRED_RC -3932
// Database must be named
#define BT_DATABASE_NAME_REQUIRED_RC -3933
// Database field is not valid
#define BT_FIELD_INVALID_RC -3934
// Invalid database session handle
#define BT_INVALID_DB_HANDLE_RC -3935
// Invalid database tag type
#define BT_INVALID_TAG_TYPE_RC -3936
// Invalid table handle
#define BT_INVALID_TABLE_HANDLE_RC -3937
// Invalid index handle
#define BT_INVALID_INDEX_HANDLE_RC -3938
// Invalid file seek position
#define BT_INVALID_SEEKPOS_RC -3939
// Database is intended for use on a Unix platform
#define BT_DATABASE_IS_FOR_UNIX_RC -3940
// Database is intended for use on a DOS/OS2/NT platform
#define BT_DATABASE_IS_FOR_DOS_RC -3941
// Database was opened for read only, modifications are not allowed
#define BT_DATABASE_IS_READ_ONLY_RC -3942
// Index handle does not belong to given table
#define BT_INDEX_TABLE_MISMATCH_RC -3943
// Can not open database with given block size
#define BT_INCORRECT_BLOCKSIZE_RC -3944
// Too many fields in database table
#define BT_TOO_MANY_FIELDS_RC -3945
// Too many indexes in database table
#define BT_TOO_MANY_INDEXES_RC -3946
// Too many tables in database
#define BT_TOO_MANY_TABLES_RC -3947
// Database index node is invalid
#define BT_INVALID_NODE_RC -3948
// Database table is invalid
#define BT_INVALID_TABLE_RC -3949
// Database header is invalid
#define BT_INVALID_DATABASE_RC -3950
// Database block is invalid
#define BT_INVALID_BLOCK_RC -3951
// Too many database seek positions in set
#define BT_TOO_MANY_SEEKPOS_RC -3952
// Database seek position not found in set
#define BT_SEEKPOS_NOT_FOUND_RC -3953
// Database seek position already in set
#define BT_SEEKPOS_ALREADY_EXISTS_RC -3954
// Database index node not found
#define BT_BRANCH_NOT_FOUND_RC -3955
// Database cache size too small
#define BT_CACHE_SIZE_TOO_SMALL_RC -3956
// Invalid tag database file type
#define BT_INVALID_FILE_TYPE_RC -3957
// Database session with given file name not found
#define BT_SESSION_NOT_FOUND_RC -3958
// Attempt to open too many database sessions at once
#define BT_TOO_MANY_SESSIONS_RC -3959
// Database session manager does not allow open for read-write
#define BT_READWRITE_NOT_ALLOWED_RC -3960
// Database session manager does not allow creation
#define BT_CREATE_NOT_ALLOWED_RC -3961
// Invalid database session handle
#define BT_INVALID_SESSION_HANDLE_RC -3962
// Incorrect database application type
#define BT_INVALID_DATABASE_TYPE_RC -3963
// No free space in hash node
#define BT_HASH_NODE_FULL_RC -3964
// Could not locate previous index in hash node
#define BT_HASH_INDEX_NOT_FOUND_RC -3965
// Invalid hash table index
#define BT_INVALID_HASH_INDEX_RC -3966
// Invalid hash table size
#define BT_INVALID_HASH_NODE_SIZE_RC -3967
// Too many symbols found in context
#define BT_TOO_MANY_SYMBOLS_RC -3968
// This database table does not support next/previous record
#define BT_TABLE_NO_NEXT_PREV_RC -3969
// Record length too small, four bytes is the minimum
#define BT_RECORD_LENGTH_TOO_SMALL_RC -3970
// Memory hash indexes require the table to have next/prev pointers
#define BT_INDEX_REQUIRES_NEXT_PREV_RC -3971
// Database feature is obsolete
#define BT_FEATURE_IS_OBSOLETE_RC -3972
// Searching: %s1/%s2
#define TAGGING_SEARCHING_FOUND_OF_TOTAL_RC -3973
// Time limit for tagging operation expired
#define TAGGING_TIMEOUT_RC -3974
// Tag file '%s0' is already being rebuilt.
#define TAG_DATABASE_ALREADY_BEING_REBUILT_RC -3975
// Background tagging is not supported for this file.
#define BACKGROUND_TAGGING_NOT_SUPPORTED_RC -3976
// Background tagging does not support embedded code blocks.
#define EMBEDDED_TAGGING_NOT_SUPPORTED_RC -3977
// Removed file '%s0' from tag file because it is no longer required.
#define LEFTOVER_FILE_REMOVED_FROM_DATABASE_RC -3978
// Tagging is not supported for this file.
#define TAGGING_NOT_SUPPORTED_FOR_FILE_RC -3979
// Removed file '%s0' from tag file.
#define FILE_REMOVED_FROM_DATABASE_RC -3980
// Background tagging is complete for tag file '%s0'
#define BACKGROUND_TAGGING_COMPLETE_RC -3981
// Background tagging is searching for files to tag in tag file '%s0'.
#define BACKGROUND_TAGGING_IS_FINDING_FILES_RC -3982
// Database size cannot exceed 2GB
#define BT_DATABASE_FULL_RC -3983
// Database session should not be closed by a background thread.
#define BT_THREADS_CANNOT_CLOSE_FILES_RC -3984
// Can not rebuild a tag file if all the source files are missing.
#define TAGGING_CAN_NOT_REBUILD_TAG_FILE_WITH_ALL_FILES_MISSING_RC -3985
// Background tagging was pre-empted by a foreground tagging job.
#define BACKGROUND_TAGGING_PREEMPTED_RC -3986
// Procedure
#define VSTAG_TYPE_DEFAULT_RC -4000
// Procedure or command
#define VSTAG_TYPE_PROC_RC -4001
// Function prototype
#define VSTAG_TYPE_PROTO_RC -4002
// Preprocessor macro
#define VSTAG_TYPE_DEFINE_RC -4003
// Type alias
#define VSTAG_TYPE_TYPEDEF_RC -4004
// Global variable
#define VSTAG_TYPE_GVAR_RC -4005
// Structure type
#define VSTAG_TYPE_STRUCT_RC -4006
// Enumeration value
#define VSTAG_TYPE_ENUMC_RC -4007
// Enumerated type
#define VSTAG_TYPE_ENUM_RC -4008
// Class type
#define VSTAG_TYPE_CLASS_RC -4009
// Union type
#define VSTAG_TYPE_UNION_RC -4010
// Statement label
#define VSTAG_TYPE_LABEL_RC -4011
// Interface type
#define VSTAG_TYPE_INTERFACE_RC -4012
// Class constructor
#define VSTAG_TYPE_CONSTRUCTOR_RC -4013
// Class destructor
#define VSTAG_TYPE_DESTRUCTOR_RC -4014
// Package, module, or namespace
#define VSTAG_TYPE_PACKAGE_RC -4015
// Member variable
#define VSTAG_TYPE_VAR_RC -4016
// Local variable
#define VSTAG_TYPE_LVAR_RC -4017
// Constant
#define VSTAG_TYPE_CONSTANT_RC -4018
// Function
#define VSTAG_TYPE_FUNCTION_RC -4019
// Class property
#define VSTAG_TYPE_PROPERTY_RC -4020
// Program
#define VSTAG_TYPE_PROGRAM_RC -4021
// Library
#define VSTAG_TYPE_LIBRARY_RC -4022
// Parameter
#define VSTAG_TYPE_PARAMETER_RC -4023
// Package import or using statement
#define VSTAG_TYPE_IMPORT_RC -4024
// Friend relationship
#define VSTAG_TYPE_FRIEND_RC -4025
// Database
#define VSTAG_TYPE_DATABASE_RC -4026
// Database table
#define VSTAG_TYPE_TABLE_RC -4027
// Database column
#define VSTAG_TYPE_COLUMN_RC -4028
// Database index
#define VSTAG_TYPE_INDEX_RC -4029
// Database view
#define VSTAG_TYPE_VIEW_RC -4030
// Database trigger
#define VSTAG_TYPE_TRIGGER_RC -4031
// Form
#define VSTAG_TYPE_FORM_RC -4032
// Menu
#define VSTAG_TYPE_MENU_RC -4033
// Control or widget
#define VSTAG_TYPE_CONTROL_RC -4034
// Event table
#define VSTAG_TYPE_EVENTTAB_RC -4035
// Procedure prototype
#define VSTAG_TYPE_PROCPROTO_RC -4036
// Task
#define VSTAG_TYPE_TASK_RC -4037
// Preprocessor include
#define VSTAG_TYPE_INCLUDE_RC -4038
// File descriptor
#define VSTAG_TYPE_FILE_RC -4039
// Container variable
#define VSTAG_TYPE_GROUP_RC -4040
// Nested function
#define VSTAG_TYPE_SUBFUNC_RC -4041
// Nested procedure or paragraph
#define VSTAG_TYPE_SUBPROC_RC -4042
// Database cursor
#define VSTAG_TYPE_CURSOR_RC -4043
// XML tag
#define VSTAG_TYPE_TAG_RC -4044
// XML tag instance
#define VSTAG_TYPE_TAGUSE_RC -4045
// Statement
#define VSTAG_TYPE_STATEMENT_RC -4046
// Annotation or attribute type
#define VSTAG_TYPE_ANNOTYPE_RC -4047
// Annotation or attribute instance
#define VSTAG_TYPE_ANNOTATION_RC -4048
// Function call
#define VSTAG_TYPE_CALL_RC -4049
// Conditional statement
#define VSTAG_TYPE_IF_RC -4050
// Loop statement
#define VSTAG_TYPE_LOOP_RC -4051
// Break statement
#define VSTAG_TYPE_BREAK_RC -4052
// Continue statement
#define VSTAG_TYPE_CONTINUE_RC -4053
// Return statement
#define VSTAG_TYPE_RETURN_RC -4054
// Goto statement
#define VSTAG_TYPE_GOTO_RC -4055
// Try statement
#define VSTAG_TYPE_TRYCATCH_RC -4056
// Preprocessing statement
#define VSTAG_TYPE_PP_RC -4057
// Block statement
#define VSTAG_TYPE_BLOCK_RC -4058
// Mixin construct
#define VSTAG_TYPE_MIXIN_RC -4059
// Build target
#define VSTAG_TYPE_TARGET_RC -4060
// Context not valid
#define VSCODEHELPRC_CONTEXT_NOT_VALID -4061
// The cursor is not in a function argument list
#define VSCODEHELPRC_NOT_IN_ARGUMENT_LIST -4062
// No help found for this function: %s1
#define VSCODEHELPRC_NO_HELP_FOR_FUNCTION -4063
// No symbols found matching %s1
#define VSCODEHELPRC_NO_SYMBOLS_FOUND -4064
// The expression (%s1) is too complex
#define VSCODEHELPRC_CONTEXT_EXPRESSION_TOO_COMPLEX -4065
// Unable to evaluate type expression (%s1)
#define VSCODEHELPRC_UNABLE_TO_EVALUATE_CONTEXT -4066
// Attempt to use operator '%s1', but variable '%s2' is a pointer
#define VSCODEHELPRC_DOT_FOR_POINTER -4067
// Attempt to use operator '%s1', but variable '%s2' is not a pointer
#define VSCODEHELPRC_DASHGREATER_FOR_NON_POINTER -4068
// Unable to evaluate 'new' expression (%s1)
#define VSCODEHELPRC_INVALID_NEW_EXPRESSION -4069
// Unable to evaluate expression with mismatched parenthesis
#define VSCODEHELPRC_PARENTHESIS_MISMATCH -4070
// Unable to evaluate expression with mismatched brackets
#define VSCODEHELPRC_BRACKETS_MISMATCH -4071
// Attempt to use operator '%s1', but variable '%s2' is a pointer to pointer
#define VSCODEHELPRC_DASHGREATER_FOR_PTR_TO_POINTER -4072
// Attempt to use subscript '[]', but variable '%s1' is not an array type
#define VSCODEHELPRC_SUBSCRIPT_BUT_NOT_ARRAY_TYPE -4073
// Unable to determine type due to overloaded symbol '%s1'
#define VSCODEHELPRC_OVERLOADED_RETURN_TYPE -4074
// Template parameters found, but class '%s1' is not a template
#define VSCODEHELPRC_NOT_A_TEMPLATE_CLASS -4075
// Unable to locate definition of expression type: '%s1'
#define VSCODEHELPRC_RETURN_TYPE_NOT_FOUND -4076
// Unable to evaluate expression with mismatched template arguments
#define VSCODEHELPRC_TEMPLATE_ARGS_MISMATCH -4077
// Symbol %s1 is declared as a simple type '%s2'
#define VSCODEHELPRC_BUILTIN_TYPE -4078
// No labels defined in current function or procedure
#define VSCODEHELPRC_NO_LABELS_DEFINED -4079
// Attempt to use operator '%s1', but variable '%s2' is an array
#define VSCODEHELPRC_DOT_FOR_ARRAY -4080
// Auto list parameters is not supported for this language
#define VSCODEHELPRC_LIST_PARAMS_NOT_SUPPORTED -4081
// Function returns void: '%s1'
#define VSCODEHELPRC_RETURN_TYPE_IS_VOID -4082
// Auto list members timed out
#define VSCODEHELPRC_LIST_MEMBERS_TIMEOUT -4083
// Auto paramter information timed out
#define VSCODEHELPRC_FUNCTION_HELP_TIMEOUT -4084
// Auto list members found maximum number of symbols
#define VSCODEHELPRC_LIST_MEMBERS_LIMITED -4083

///////////////////////////////////////////////////////////////////////////////
// BSC
///////////////////////////////////////////////////////////////////////////////

// Expected .BSC file extension
#define BSC_INCORRECT_EXTENSION_RC -4100
// Error opening browse database
#define BSC_ERROR_OPENING_FILE_RC -4101
// Could not obtain browser database instances
#define BSC_NO_INSTANCES_RC -4102
// BSC databases are not supported on this platform
#define BSC_ONLY_ON_WINDOWS_RC -4103
// Can not open msbsc50.dll, maybe Visual C++ is not installed
#define BSC_CANNOT_OPEN_DLL_RC -4104

///////////////////////////////////////////////////////////////////////////////
// JAVA
///////////////////////////////////////////////////////////////////////////////

// Incomplete header in Java class file
#define JAVA_CLASS_INCOMPLETE_HEADER_RC -4125
// Invalid magic number for Java class file
#define JAVA_CLASS_BAD_MAGIC_NUMBER_RC -4126
// Unsupported Java class file version
#define JAVA_CLASS_UNSUPPORTED_VERSION_RC -4127
// Java class constant pool contains unrecognized type
#define JAVA_CLASS_UNKNOWN_CONSTANT_TYPE_RC -4128
// Java class attribute length mismatch
#define JAVA_CLASS_ATTRIBUTE_LENGTH_MISMATCH_RC -4129
// Could not locate Java source file
#define JAVA_CLASS_SOURCE_NOT_FOUND_RC -4130
// Invalid index into Java class constant pool
#define JAVA_CLASS_INVALID_CONSTANT_INDEX_RC -4131
// Could not find string in Java class constant pool
#define JAVA_CLASS_STRING_NOT_FOUND_RC -4132
// Incomplete header in Java archive file
#define JAVA_JAR_INCOMPLETE_HEADER_RC -4133
// Invalid magic number for Java archive file
#define JAVA_JAR_BAD_MAGIC_NUMBER_RC -4134
// Unsupported Java archive file version
#define JAVA_JAR_UNSUPPORTED_VERSION_RC -4135
// Error uncompressing contents of Java archive file
#define JAVA_JAR_DECOMPRESS_ERROR_RC -4136
// Corrupt header in Java archive file
#define JAVA_JAR_CORRUPT_HEADER_RC -4137

///////////////////////////////////////////////////////////////////////////////
// OBJECT
///////////////////////////////////////////////////////////////////////////////

// Incomplete header in object file
#define OBJECT_FILE_INCOMPLETE_HEADER_RC -4150
// Invalid magic number for object file
#define OBJECT_FILE_BAD_MAGIC_NUMBER_RC -4151
// Unrecognized object file type
#define OBJECT_FILE_UNRECOGNIZED_RC -4152
// Object file has no debug information
#define OBJECT_FILE_NO_DEBUG_RC -4153

///////////////////////////////////////////////////////////////////////////////
// METADATA
///////////////////////////////////////////////////////////////////////////////

// C# library parsing is not supported on Unix
#define METADATA_NOT_SUPPORTED_ON_UNIX_RC -4175
// Could not open metadata DLL instance
#define METADATA_CAN_NOT_CREATE_INSTANCE_RC -4176
// Could not import from metadata DLL
#define METADATA_CAN_NOT_CREATE_IMPORTER_RC -4177

///////////////////////////////////////////////////////////////////////////////
// VSBUILD
///////////////////////////////////////////////////////////////////////////////

// Usage: vsbuild [WorkspaceName] [ProjectName] [-t TargetName] [Options]
// 
//    WorkspaceName     Name of workspace. Not required if there are no
//                      dependencies and ProjectName is specified.
//    ProjectName       Project file that is part of the workspace.
//                      Defaults to the current project.
//    -t <TargetName>   Target name is the name of the target to run.
//    -c <ConfigName>   Config name is the name of the configuration to build.
//    -b <BufferName>   Buffer name is the name of the current buffer in the editor.
//    -d                Do not build, display dependencies.
//    -v or -verbose    Verbose mode.
//    -verbosefiles     Verbose mode + dump contents of temporary list files.
//    -verboseenv       Verbose mode + dump environment variables set.
//    -quiet            Quiet mode.
//    -nodep            Do not process project dependencies.
//    -beep             Beep at the end of a build to signal success or failure.
//    -time             Display time elapsed during build.
//    -log              Output build info to a per-project log file.
//    -wc <Wildcards>   Semi-colon delimited list of wildcards.
//    -execute <CmdLine>
//                      This option must be last.
//                      Executes the target given and if successful, executes the
//                      <CmdLine> given.
//    -execAsTarget <CmdLine>
//                      This option must be last.
//                      Executes the command given as if it were a target.
//    -doNotCreateObjectDir
//                      Do not create object directories.
// Example
//     vsbuild project.vpj -t Build
//          Compile files in the project which are out-of-date.
// 
//     vsbuild project.vpj -t Rebuild
//          Recompiles all files in the project.
// 
//     vsbuild project.vpj -t "Make Jar"
//          Compile Java files in the project which are out-of-date and
//          update the project jar file.
// 
//     vsbuild project.vpj -t "Javadoc All"
//          Update HTML documentation for all Java files in the project.
// 
#define VSBUILDRC_USAGE -4200
// %s1Cannot open file '%s2'
#define VSBUILDRC_CANNOT_OPEN_FILE -4201
// %s1Could not read file '%s2'
#define VSBUILDRC_ERROR_READ_FILE -4202
// %s1Cannot use %M option when using vsbuild
#define VSBUILDRC_CANNOT_USE_M_OPTION -4203
// %s1Cannot use %C option when using vsbuild
#define VSBUILDRC_CANNOT_USE_C_OPTION -4204
// %s1Cannot use %L option when using vsbuild
#define VSBUILDRC_CANNOT_USE_L_OPTION -4205
// %s1Cannot use %NNN option when using vsbuild
#define VSBUILDRC_CANNOT_USE_NNN_OPTION -4206
// %s1Warning: %{filter} option does not currently support files in associated project files
#define VSBUILDRC_CANNOT_USE_FILTER_OPTION -4207
// %s1Workspace file '%s2' not found
#define VSBUILDRC_WORKSPACE_FILE_NOT_FOUND -4208
// %s1Workspace history file '%s2' not found
#define VSBUILDRC_HISTORY_FILE_NOT_FOUND -4209
// %s1Project file '%s2' not found
#define VSBUILDRC_PROJECT_FILE_NOT_FOUND -4210
// %s1No dependencies for %s2
#define VSBUILDRC_NO_DEPENDENCIES -4211
// %s1'%s2' depends on '%s3'
#define VSBUILDRC_DEPENDS_ON -4212
// %s1Command '%s2' not defined in project file '%s3'
#define VSBUILDRC_COMMAND_NOT_DEFINED_IN_PROJECT -4213
// %s1Could not change to directory '%s2'
#define VSBUILDRC_COULD_NOT_CHANGE_DIRECTORY -4214
// %s1Changed to directory '%s2'
#define VSBUILDRC_CHANGED_TO_DIRECTORY -4215
// %s1No build command for project '%s2'
#define VSBUILDRC_NO_BUILD_COMMAND_FOR_PROJECT -4216
// %s1Program '%s2' not found
#define VSBUILDRC_PROGRAM_NOT_FOUND -4217
// %s1All files are up-to-date
#define VSBUILDRC_ALL_FILES_HAVE_BEEN_COMPILED -4218
// %s1Build stopped. %s2 returned %s3
#define VSBUILDRC_STOP_WITH_ERROR -4219
// %s1No current project
#define VSBUILDRC_NO_CURRENT_PROJECT -4220
// %s1jar command for project '%s2' must specify 'f' option
#define VSBUILDRC_JAR_COMMAND_MUST_SPECIFY_F_OPTION -4221
// %s1jar command for project '%s2' must specify 'c' or 'u' option
#define VSBUILDRC_JAR_COMMAND_MUST_SPECIFY_C_OR_U_OPTION -4222
// %s1Unknown option '%s2'
#define VSBUILDRC_UNKNOWN_OPTION -4223
// %s1Unable to open temp list file '%s2'
#define VSBUILDRC_UNABLE_TO_OPEN_TEMP_LIST_FILE -4224
// %s1Out of disk space writing to temp list file '%s2'
#define VSBUILDRC_OUT_OF_DISK_SPACE_WRITING_TO_TEMP_LIST_FILE -4225
// %s1Unable to initialize dependency analyzer.  Check disk space and permissions for the object directory.
#define VSBUILDRC_CANNOT_INIT_DEPENDENCY_DATABASE -4226
// %s1Cannot specify vsbuild as build tool without specifying an operation
#define VSBUILDRC_INFINITE_COMMAND_RECURSION -4227
// %s1*** Errors occurred during this build ***
#define VSBUILDRC_ERRORS_OCCURRED -4228
// %s1Build successful
#define VSBUILDRC_BUILD_SUCCESSFUL -4229
// %s1---------- Build Project: '%s2' - '%s3' ----------
#define VSBUILDRC_BUILDING_PROJECT -4230
// %s1---------- Rebuild Project: '%s2' - '%s3' ----------
#define VSBUILDRC_REBUILDING_PROJECT -4231
// %s1---------- Jar Project: '%s2' - '%s3' ----------
#define VSBUILDRC_JARRING_PROJECT -4232
// %s1---------- Javadoc Project: '%s2' - '%s3' ----------
#define VSBUILDRC_JAVADOCING_PROJECT -4233
// %s1No files in project
#define VSBUILDRC_NO_FILES_IN_PROJECT -4234
// %s1Dependency database not found.  Rebuilding...
#define VSBUILDRC_DEPENDENCY_DATABASE_NOT_FOUND -4235
// %s1Dependency database outdated.  Rebuilding...
#define VSBUILDRC_DEPENDENCY_DATABASE_OUTDATED -4236
// %s1Nothing to link
#define VSBUILDRC_NOTHING_TO_LINK -4237
// %s1Infinite recursion detected while replacing '%s2'
#define VSBUILDRC_INFINITE_LOOP_DETECTED_IN_COMMAND -4238
// %s1No config specified and no active config found in history file.
#define VSBUILDRC_NO_CONFIG_SPECIFIED -4239
// %s1Config '%s2' not found in project file '%s3'
#define VSBUILDRC_CONFIG_NOT_FOUND -4240
// %s1File '%s2' not found
#define VSBUILDRC_FILE_NOT_FOUND -4241
// %s1Could not setup environment
#define VSBUILDRC_ERROR_SETTING_UP_ENVIRONMENT -4242
// %s1---------- Clean Project: '%s2' - '%s3' ----------
#define VSBUILDRC_CLEANING_PROJECT -4243
// %s1Unable to remove file '%s2'
#define VSBUILDRC_CANNOT_REMOVE_FILE -4244
// %s1Compile/Link command change detected.  Some files may be rebuilt.
#define VSBUILDRC_CPP_COMMAND_CHANGE_DETECTED -4245
// %s1Configuration or command change detected.  All files will be rebuilt.
#define VSBUILDRC_JAVA_CONFIG_OR_COMMAND_CHANGE_DETECTED -4246
// %s1File '%s2' is an invalid format and cannot be read.
#define VSBUILDRC_INVALID_FILE_FORMAT -4247
// %s1Target must be specified for dependency that is internal to the project.
#define VSBUILDRC_TARGET_REQUIRED -4248
// %s1Target '%s2' not found in project file '%s3' config '%s4'
#define VSBUILDRC_TARGET_NOT_FOUND -4249
// %s1Cannot read dependency database.
#define VSBUILDRC_CANNOT_READ_DEPENDENCY_DATABASE -4250
// %s1Cannot build with ant because ANT_HOME and/or JAVA_HOME are not set.
#define VSBUILDRC_ANT_HOME_NOT_FOUND -4251
// %s1Linkable object count change detected.  The project will be relinked.
#define VSBUILDRC_CPP_OBJECT_COUNT_CHANGE_DETECTED -4252
// %s1vsbuild command can't change workspace, project, config, or target. Use CallTarget
#define VSBUILDRC_VSBUILD_COMMAND_CANT_CHANGE_WORKSPACE_PROJECT_CONFIG_OR_TARGET -4253
// %s1---------- '%s2' Project: '%s3' - '%s4' ----------
#define VSBUILDRC_TARGET_PROJECT -4254
// %s1Invalid arguments: %s
#define VSBUILDRC_INVALID_ARGUMENT -4255
// %s1No rule found for file '%s2'
#define VSBUILDRC_NO_COMPILE_RULE_FOUND_FOR_FILE_2ARG -4256

///////////////////////////////////////////////////////////////////////////////
// LICENSE
///////////////////////////////////////////////////////////////////////////////

// Run the vsupdatw program as shown below (Start, Run) to transfer serial number and license information.
// 
// Usage:
// 	vsupdatw old-exe-name new-exe-name
// 
// 	old-exe-name	Name of original executable to take license info from.
// 	new-exe-name	Name of new executable to transfer license info to.
#define VSLM_RUN_VSUPDATE_WIN_RC -4300
// Run the vsupdate program as shown below to transfer serial number and license information.
// 
// Usage:
// 	vsupdatw old-exe-name new-exe-name
// 
// 	old-exe-name	Name of original executable to take license info from.
// 	new-exe-name	Name of new executable to transfer license info to.
#define VSLM_RUN_VSUPDATE_OS2_RC -4301
// Run the vsupdate program as shown below to transfer serial number and license information.
// 
// Usage:
// 	vsupdate old-exe-name new-exe-name
// 
// 	old-exe-name	Name of original executable to take license info from.
// 	new-exe-name	Name of new executable to transfer license info to.
#define VSLM_RUN_VSUPDATE_UNIX_RC -4302
// Run the vsupdate program as shown below to transfer serial number and license information.
// 
//    vsupdate  <old-libvsapi-name> <new-libvsapi-name>
// 
#define VSLM_RUN_VSUPDATE_UNIXDLL_RC -4303
// The serial #%s1 is not valid.
// Please contact SlickEdit Support.
#define VSLM_SERIAL_NUMBER_NOT_VALID_RC -4304
// Unable to obtain a FLEXlm license to run %s1.
// FLEXlm reports the following error:
// 
// 
#define VSLM_UNABLE_TO_OBTAIN_FLEXLM_LICENSE_RC -4305
// Error seeking to beginning of license file
#define VSLM_ERROR_SEEKING_TO_BEGINNING_RC -4306
// Error seeking to end of license file
#define VSLM_ERROR_SEEKING_TO_END_RC -4307
// Error writing to file '%s1'.  Check disk space.
#define VSLM_ERROR_WRITING_TO_FILE_RC -4308
// Error reading license file '%s1'
#define VSLM_ERROR_READING_LICENSE_FILE_RC -4309
// User '%s1' not found in '%s2'
#define VSLM_USER_NOT_FOUND_RC -4310
// Timeout opening or creating license file '%s1'.  Make sure your system administrator has given all users read/write access to this file and that this file exists.
#define VSLM_ERROR_OPENING_OR_CREATING_RC -4311
// Timeout opening license file '%s1'. Make sure your system administrator has given all users read access to this file and that this file exists.
#define VSLM_ERROR_OPENING_RC -4312
// The serial #%s1 and license #%s2 are not valid.
// Please contact SlickEdit Support.
#define VSLM_SERIAL_NUMBER_AND_LICENSE_NOT_VALID_RC -4313
// Unable to create license manager directory.  Have your system administrator create the directory '%s1' and give all users access to this directory
#define VSLM_UNABLE_TO_CREATE_LICENSE_MANAGER_DIR_RC -4314
// User '%s1' is not authorized to run SlickEdit. Please consult your system administrator to have your user name added to the license file.
// 
#define VSLM_USER_NOT_AUTHORIZED_RC -4315
// License limit of %s1 users for serial #%s2 in package <%s4> reached.  You may purchase additional licenses or wait until someone exits the editor.
// 
// To check how many users are running the editor, type the following command:
// 
//     type %s3
// 
// The total usage count is FirstLineCount+NoflinesInFile-1.
// 
// An abnormal exit from the editor will cause this count to be incorrect.  After an abnormal exit from the editor, that user should run the vsdelw program (Start, Run).
// 
// Using the vsdelw program to intentionally decrement the count below the actual usage count violates this program's license agreement.
#define VSLM_LICENSE_LIMIT_REACHED_WIN_RC -4316
// License limit of %s1 users for serial #%s2 in package <%s4> reached.  You may purchase additional licenses or wait until someone exits the editor.
// 
// To check how many users are running the editor, type the following command:
// 
//     type %s3
// 
// The total usage count is FirstLineCount+NoflinesInFile-1.
// 
// 
// An abnormal exit from the editor will cause this count to be incorrect.  After an abnormal exit from the editor, that user should run the vsdel program.
// 
// Using the vsdel program to intentionally decrement the count below the actual usage count violates this program's license agreement.
#define VSLM_LICENSE_LIMIT_REACHED_OS2_RC -4317
// License limit of %s1 users for serial #%s2 reached.  You may purchase additional licenses or wait until someone exits the editor.
// 
// To check how many users are running the editor, type the following command:
// 
//     cat %s3
// 
// The total usage count is FirstLineCount+NoflinesInFile-1.
// 
// 
// An abnormal exit from the editor will cause this count to be incorrect.  After an abnormal exit from the editor, that user should run the vsdel program.
// 
// Using the vsdel program to intentionally decrement the count below the actual usage count violates this program's license agreement.
#define VSLM_LICENSE_LIMIT_REACHED_UNIX_RC -4318
// Failed to open trial size file
#define VSTRIAL_FAILED_TO_OPEN_TRIAL_SIZE_FILE_RC -4319
// Error in trial size file
#define VSTRIAL_ERROR_IN_TRIAL_SIZE_FILE_RC -4320
// Failed to open trial executable
#define VSTRIAL_FAILED_TO_OPEN_TRIAL_EXECUTABLE_RC -4321
// Serial number and license information must be patched into the product.  This step is necessary to personalize your copy of the product and to receive prompt technical support.
// 
// You will need your license code that was provided to you.  If you ordered online you may receive the code separately via email.  Call SlickEdit support at 800-934-3348 or 919.473.0100 if you have lost your code.  If you choose not to perform this step at this time you will be prompted with this message each time SlickEdit is invoked.
// 
// Update serial number and license information now?
#define VSTRIAL_PATCH_SERIAL_NUMBER_AND_LICENSE_RC -4322
// Failed to execute %s1.  Could be out of memory.
// 
// Exit SlickEdit and run %s2vssetlnw.exe to patch serial number and license information.  Have your license code ready.
#define VSTRIAL_FAILED_TO_EXECUTE_RC -4323
// Version 12.0
// 
// This program is used to remove a user from the %s1 file.  This is necessary only if a user exits the editor abnormally.
// 
// Usage:
// 
// vsdel <path>/%s1 user [-s section [-s section ...]]
// 
// 	path	Path to license file '%s1'.
// 	user	Name of user to delete from license file.
// 	section	Optional.  Name of a package section to delete user from (e.g. 'STD').
// 		If not given, then user is deleted from all sections.
// 
// Using the vsdel program to intentionally delete a user who is still using SlickEdit violates this program's license agreement.
// 
#define VSDEL_HELP_UNIX_RC -4324
// Version 12.0
// 
// This program is used to remove a user from the %s1 file.  This is necessary only if a user exits the editor abnormally.
// 
// Usage:
// 
//     vsdelw <path>\%s1 [user] [-s section [-s section ...]]
// 
// 	path	Path to license file '%s1'.
// 	user	Name of user to delete from license file.  User name comes from the
// 		VSUSER environment variable or Windows login.  If the user name is
// 		not given, then global license count is decremented.
// 	section	Optional.  Name of a package section to delete user from (e.g. 'STD').
// 		If not given, then user is deleted from all sections.
// 
// Using the vsdelw program to intentionally decrement the usage count below the actual usage count violates this program's license agreement.
// 
#define VSDELW_HELP_WIN_RC -4325
// Demo version has expired
#define VSLM_DEMO_EXPIRED_RC -4326
// 
#define DEMO_EXPIRATION_DATE_RC -4327
// Error in trial
#define VSTRIAL_ERROR_IN_TRIAL_RC -4328
// The package <%s1> is not valid.
// Please contact SlickEdit Support.
#define VSLM_PACKAGE_NOT_VALID_RC -4329
// The serial #%s1 does not match the license for package <%s2> (%s3).
// Please contact SlickEdit Support.
#define VSLM_SERIAL_AND_LICENSE_MISMATCH_RC -4330
// The package is invalid or missing (%s1).
// Please contact SlickEdit Support.
#define VSLM_INVALID_PACKAGE_RC -4331
// Too many packages.
// Please contact SlickEdit Support.
#define VSLM_TOO_MANY_PACKAGES_RC -4332
// The following packages could not be licensed because the user limit has been reached, or the user is not licensed for these packages.  Licensing can also fail when the license file is set to read only and/or a user's name does not appear in the list of licensed users.  Read the "License Manager" section of the manual for more information on the format of the license file.
#define VSLM_PACKAGES_NOT_LICENSED_RC -4333
// User '%s1' not found in '%s2' for the following packages: 
#define VSLM_USER_NOT_FOUND2_RC -4334
// You have not installed a license key for the following packages.  This can happen when you have package sections in your license file that you are not/no longer licensed for.  The system administrator can use the '%s1' utility to add support for additional packages.
#define VSLM_PACKAGES_NOT_LICENSED2_RC -4335
// The package <%s1> is invalid.
// 
#define VSLM_INVALID_PACKAGE2_RC -4336
// The registration macro was not found. Call SlickEdit Support.
#define VSREG_MACRO_NOT_FOUND_RC -4337
// Error opening registration data file
#define VSREG_ERROR_OPENING_DATA_FILE_RC -4338
// Error reading registration data file
#define VSREG_ERROR_READING_DATA_FILE_RC -4339
// Invalid or unsupported registration data version
#define VSREG_INVALID_DATA_VERSION_RC -4340
// Invalid trial. Please contact SlickEdit Support.
#define VSTRIAL_INVALID_TRIAL_RC -4341
// This trial will expire on %s1
#define VSTRIAL_EXPIRING_RC -4342
// The trial registration macro was not found. Call SlickEdit Support.
#define VSTRIAL_MACRO_NOT_FOUND_RC -4343
// This trial has expired. SlickEdit will now exit.
#define VSTRIAL_TRIAL_EXPIRED_RC -4344
// Thank you for trying %s0.
// 
// This trial will expire soon. If you would like to purchase, please contact our sales department.
#define VSTRIAL_EXPIRING2_RC -4345
// This trial has expired. SlickEdit Core will now be disabled.
#define VSTRIAL_ECLIPSE_TRIAL_EXPIRED_RC -4346
// Unable to contact registration server (status = %rc%).
// <p>
// If you are accessing the internet through a proxy, use the "Proxy Settings..." button to configure your proxy settings. Some more sophisticated proxies that require a login are not currently supported. If you are behind one of these types of proxies, then please do one of the following:
// <p>
// Paste the following link into the Address bar of your web browser. You will be emailed back instructions to activate your trial license.
// <p>
// %link%
// <p>
#define VSTRIAL_ERROR_CONTACTING_REGISTRATION_SERVER_RC -4347
// To purchase %s1, please contact SlickEdit Sales at 800 934-3348 or +1 919.473.0100 purchase online at www.slickedit.com.
#define VSRC_DEMO_NAG_MESSAGE -4348
// Unable to obtain license using license file(s):
// %s2
// 
// FLEXlm reports the following error:
// 
// 
#define VSLM_UNABLE_TO_OBTAIN_FLEXLM_LICENSE_FROM_FILE_RC -4349
// Unable to obtain license using license file(s).
#define VSLM_UNABLE_TO_OBTAIN_LICENSE_RC -4350
// Unable to return license to license server:
// %s2
// Error:
// 
#define VSLM_UNABLE_TO_RETURN_LICENSE_RC -4351
// Unable to write borrow license.
// File:
// 
// 
#define VSLM_UNABLE_TO_WRITE_BORROW_LICENSE_RC -4352
// Unable to checkout borrow license.
// Error:
// 
#define VSLM_UNABLE_TO_BORROW_LICENSE_RC -4353
// Return license failed.
// Checkout license from server %s2?
#define VSLM_RETURN_FAILED_CHECKOUT_LICENSE_RC -4354
// Borrows are not allowed with this license.
#define VSLM_BORROW_INCORRECT_LICENSE_RC -4355
// Unable to borrow license from server.
// Error:
// 
#define VSLM_BORROW_FAILURE_RC -4356

///////////////////////////////////////////////////////////////////////////////
// XMLCFG
///////////////////////////////////////////////////////////////////////////////

// Expecting root element name in DOCTYPE
#define VSRC_XMLCFG_EXPECTING_ROOT_ELEMENT_NAME -5400
// Expecting quoted system id
#define VSRC_XMLCFG_EXPECTING_QUOTED_SYSTEM_ID -5401
// String not terminated
#define VSRC_XMLCFG_STRING_NOT_TERMINATED -5402
// 
#define VSRC_XMLCFG_NOT_USED1 -5403
// '%s4' start tag not terminated
#define VSRC_XMLCFG_START_TAG_NOT_TERMINATED -5404
// Comment not terminated
#define VSRC_XMLCFG_COMMENT_NOT_TERMINATED -5405
// Invalid characters in comment
#define VSRC_XMLCFG_INVALID_CHARACTERS_IN_COMMENT -5406
// Expecting an element name
#define VSRC_XMLCFG_EXPECTING_AN_ELEMENT_NAME -5407
// Expecting attribute name
#define VSRC_XMLCFG_EXPECTING_ATTRIBUTE_NAME -5408
// Expecting '=' after attribute name
#define VSRC_XMLCFG_EXPECTING_EQUAL_AFTER_ATTRIBUTE_NAME -5409
// Attribute value must be quoted
#define VSRC_XMLCFG_ATTRIBUTE_VALUE_MUST_BE_QUOTED -5410
// Processing instruction not terminated
#define VSRC_XMLCFG_PROCESSING_INSTRUCTION_NOT_TERMINATED -5411
// The input ended before all tags were terminated.
#define VSRC_XMLCFG_INPUT_ENDED_BEFORE_ALL_TAGS_WERE_TERMINATED -5412
// Expecting quoted public id
#define VSRC_XMLCFG_EXPECTING_QUOTED_PUBLIC_ID -5413
// DOCTYPE Internal subset not terminated
#define VSRC_XMLCFG_DOCTYPE_INTERNAL_SUBSET_NOT_TERMINATED -5414
// Invalid document structure
#define VSRC_XMLCFG_INVALID_DOCUMENT_STRUCTURE -5414
// Expecting SYSTEM or PUBLIC id
#define VSRC_XMLCFG_EXPECTING_SYSTEM_OR_PUBLIC_ID -5416
// Expecting processor name
#define VSRC_XMLCFG_EXPECTING_PROCESSOR_NAME -5417
// File already open
#define VSRC_XMLCFG_FILE_ALREADY_OPEN -5418
// ?xml declaration not terminated
#define VSRC_XMLCFG_XML_DECLARATION_NOT_TERMIANTED -5419
// Expecting comment or CDATA
#define VSRC_XMLCFG_EXPECTING_COMMENT_OR_CDATA -5420
// CDATA not terminated
#define VSRC_XMLCFG_CDATA_NOT_TERMINATED -5421
// Attribute not found
#define VSRC_XMLCFG_ATTRIBUTE_NOT_FOUND -5422
// Name not found
#define VSRC_XMLCFG_NAME_NOT_FOUND -5423
// Cannot add child node to an attribute node
#define VSRC_XMLCFG_CANT_ADD_CHILD_NODE_TO_ATTRIBUTE_NODE -5424
// Attributes must be the first children of element nodes
#define VSRC_XMLCFG_ATTRIBUTES_MUST_BE_THE_FIRST_CHILDREN -5425
// Cannot add sibling to root node
#define VSRC_XMLCFG_CANT_ADD_SIBLING_TO_ROOT_NODE -5426
// Unable to initialize XML system (%s2) : %s1
#define VSRC_XML_SYSTEM_FAILED_TO_INITIALIZE -5427
// Unexpected parsing error: %s1
#define VSRC_XML_UNEXPECTED_PARSING_ERROR1 -5428
// Parsing error (%s2): %s1
#define VSRC_XML_GENERAL_PARSING_ERROR -5429
// Unexpected parsing error.
#define VSRC_XML_UNEXPECTED_PARSING_ERROR -5430
// Internal XML error.  Proc index not found for _mapxml_find_system_file
#define VSRC_XML_INTERNAL_ERROR_PROC_INDEX_NOT_FOUND -5431
// No children copied
#define VSRC_XMLCFG_NO_CHILDREN_COPIED -5432
// Invalid XMLCFG handle
#define VSRC_XMLCFG_INVALID_HANDLE -5433
// Invalid XMLCFG node index
#define VSRC_XMLCFG_INVALID_NODE_INDEX -5434
// Too many end tags
#define VSRC_XMLCFG_TOO_MANY_END_TAGS -5435

///////////////////////////////////////////////////////////////////////////////
// DEBUGGER
///////////////////////////////////////////////////////////////////////////////

// The debugger has not been initialized
#define DEBUG_NOT_INITIALIZED_RC -5500
// Breakpoint not found
#define DEBUG_BREAKPOINT_NOT_FOUND_RC -5501
// This operation is allowed only when the thread is suspended
#define DEBUG_THREAD_NOT_SUSPENDED_RC -5502
// Invalid JDWP ID
#define DEBUG_INVALID_ID_RC -5503
// Index of debugger item is out of range or invalid
#define DEBUG_INVALID_INDEX_RC -5504
// Conditional breakpoints are not yet supported
#define DEBUG_BREAKPOINT_CONDITION_UNSUPPORTED_RC -5505
// Waiting for thread(s) to suspend
#define DEBUG_THREAD_WAITING_FOR_SUSPEND_RC -5506
// Could not find specified thread
#define DEBUG_THREAD_NOT_FOUND_RC -5507
// Could not find specified class
#define DEBUG_CLASS_NOT_FOUND_RC -5508
// Could not find specified function
#define DEBUG_FUNCTION_NOT_FOUND_RC -5509
// Could not find specified variable
#define DEBUG_FIELD_NOT_FOUND_RC -5510
// Can not remove an enabled breakpoint
#define DEBUG_BREAKPOINT_NOT_DISABLED_RC -5511
// Breakpoint already exists at this location
#define DEBUG_BREAKPOINT_ALREADY_EXISTS_RC -5512
// Program finished executing
#define DEBUG_PROGRAM_FINISHED_RC -5513
// Could not set breakpoint on specified line
#define DEBUG_BREAKPOINT_LINE_NOT_FOUND_RC -5514
// Breakpoints are not allowed in this context
#define DEBUG_BREAKPOINT_NOT_ALLOWED_RC -5515
// Can not set watch on specified symbol
#define DEBUG_WATCH_NOT_ALLOWED_RC -5516
// Current function was not compiled with debug
#define DEBUG_NO_DEBUG_INFORMATION_RC -5517
// Exception not found
#define DEBUG_EXCEPTION_NOT_FOUND_RC -5518
// Thread has no stack frames
#define DEBUG_THREAD_NO_FRAMES_RC -5519
// This expression is already being watched
#define DEBUG_WATCH_ALREADY_EXISTS_RC -5520
// There is no current thread
#define DEBUG_NO_CURRENT_THREAD_RC -5521
// There are no class members in this scope
#define DEBUG_NO_MEMBERS_RC -5522
// Could not find specified disassembly instruction
#define DEBUG_INSTRUCTION_NOT_FOUND_RC -5523
// Could not find specified file
#define DEBUG_FILE_NOT_FOUND_RC -5524
// Requested feature is not implemented for this debugger
#define DEBUG_FEATURE_NOT_IMPLEMENTED_RC -5525
// Invalid debugging session ID
#define DEBUG_INVALID_SESSION_ID_RC -5526
// Expecting a watchpoint, not a breakpoint
#define DEBUG_NOT_A_WATCHPOINT_RC -5527
// Unrecognized breakpoint type
#define DEBUG_INVALID_BREAKPOINT_TYPE_RC -5528
// Invalid watchpoint condition
#define DEBUG_INVALID_WATCHPOINT_CONDITION_RC -5529
// One or more breakpoints could not be enabled on startup and will be disabled
#define DEBUG_BREAKPOINTS_NOT_ENABLED_ON_STARTUP_RC -5530
// The requested feature is no longer available.
#define DEBUG_FEATURE_REMOVED_RC -5531
// This operation is allowed only when inspecting a core file
#define DEBUG_CAN_NOT_RESUME_CORE_FILE_RC -5532
// Missing ':' in conditional expression
#define DEBUG_EXPR_EXPECTING_COLON_RC -5550
// Error parsing expression
#define DEBUG_EXPR_GENERAL_ERROR_RC -5551
// Expression contains an invalid operator
#define DEBUG_EXPR_INVALID_OPERATOR_RC -5552
// Expecting closing parenthesis
#define DEBUG_EXPR_EXPECTING_CLOSE_PAREN_RC -5553
// Attempt to divide by zero in expression
#define DEBUG_EXPR_DIVIDE_BY_ZERO_RC -5554
// Expecting ',' or ')' in function call expression
#define DEBUG_EXPR_EXPECTING_COMMA_RC -5555
// Expecting closing bracket
#define DEBUG_EXPR_EXPECTING_CLOSE_BRACKET_RC -5556
// Invalid condition in ?: expression
#define DEBUG_EXPR_INVALID_CONDITION_RC -5557
// Can not cast a void expression
#define DEBUG_EXPR_CANNOT_CAST_VOID_RC -5558
// Can not cast a boolean to another type
#define DEBUG_EXPR_CANNOT_CAST_BOOLEAN_RC -5559
// Can not cast a string to another type
#define DEBUG_EXPR_CANNOT_CAST_STRING_RC -5560
// Can not implicitly cast a class object to another type
#define DEBUG_EXPR_CANNOT_CAST_OBJECT_RC -5561
// A type is incompatible with the specified operator
#define DEBUG_EXPR_INCOMPATIBLE_TYPE_RC -5562
// Can not cast due to a possible loss of precision
#define DEBUG_EXPR_LOSS_OF_PRECISION -5563
// Left hand side of '.' operator is not a package, class or object
#define DEBUG_EXPR_LHS_NOT_CLASS_RC -5564
// Right hand side of '.' operator is not an identifier
#define DEBUG_EXPR_RHS_INVALID_RC -5565
// Can not cast a function to another type
#define DEBUG_EXPR_CANNOT_CAST_FUNCTION_RC -5566
// Can not cast an array to another type
#define DEBUG_EXPR_CANNOT_CAST_ARRAY_RC -5567
// Syntax error in watch expression
#define DEBUG_EXPR_SYNTAX_ERROR_RC -5568
// Can not find function context in this thread
#define DEBUG_EXPR_CANNOT_FIND_CONTEXT_RC -5569
// Symbol not found in this scope
#define DEBUG_EXPR_SYMBOL_NOT_FOUND_RC -5570
// Variable is not an array or string type
#define DEBUG_EXPR_NOT_ARRAY_RC -5572
// Array index is out of range
#define DEBUG_EXPR_INVALID_ARRAY_INDEX_RC -5573
// Identifier is not a function
#define DEBUG_EXPR_NOT_FUNCTION_RC -5574
// Can not call specified function
#define DEBUG_EXPR_CANNOT_CALL_FUNCTION_RC -5575
// An exception was thrown
#define DEBUG_EXPR_EXCEPTION_RC -5576
// Invalid argument
#define DEBUG_EXPR_INVALID_ARGUMENT_RC -5577
// Too many or too few arguments
#define DEBUG_EXPR_WRONG_NUMBER_OF_ARGUMENTS_RC -5578
// Could not find function matching arguments
#define DEBUG_EXPR_ARGUMENT_MISMATCH_RC -5579
// Identifier is not a class type
#define DEBUG_EXPR_NOT_CLASS_RC -5580
// Can not evaluate expression containing 'new'
#define DEBUG_EXPR_CONTAINS_NEW_RC -5581
// Expecting object type with 'instanceof' operator
#define DEBUG_EXPR_EXPECTING_OBJECT_RC -5582
// Too many levels of inheritance
#define DEBUG_EXPR_TOO_MANY_LEVELS_RC -5583
// Can not evaluate expression
#define DEBUG_EXPR_CANNOT_EVALUATE_RC -5584
// Can not use 'this' in a static method
#define DEBUG_EXPR_STATIC_METHOD_RC -5585
// Unsupported size for object ID
#define DEBUG_JDWP_INVALID_SIZE_ARGUMENT_RC -5600
// Attempted to read past end of packet
#define DEBUG_JDWP_PAST_END_OF_PACKET_RC -5601
// Invalid JDWP type tag constant
#define DEBUG_JDWP_INVALID_TAG_CONSTANT_RC -5602
// Unsupported JDWP data type
#define DEBUG_JDWP_UNSUPPORTED_TAG_RC -5603
// Did not receive correct handshake from virtual machine
#define DEBUG_JDWP_INVALID_HANDSHAKE_RC -5604
// The requested action is not supported by the virtual machine
#define DEBUG_JDWP_UNSUPPORTED_BY_VIRTUAL_MACHINE_RC -5605
// Packet header contains invalid packet size
#define DEBUG_JDWP_INVALID_PACKET_SIZE_RC -5606
// Packet contains invalid array size
#define DEBUG_JDWP_INVALID_ARRAY_SIZE_RC -5607
// Can not modify the value of expressions
#define DEBUG_JDWP_ERROR_MODIFYING_VARIABLE_RC -5608
// Watchpoints are not supported by the virtual machine
#define DEBUG_JDWP_WATCHPOINT_NOT_SUPPORTED_RC -5609
// The Java debugger does not support watchpoints on local variables
#define DEBUG_JDWP_LOCAL_WATCHPOINT_NOT_SUPPORTED_RC -5610
// Packet header contains invalid packet size
#define DEBUG_DBGP_INVALID_PACKET_SIZE_RC -5650
// No more data
#define DEBUG_DBGP_NO_MORE_DATA_RC -5651
// Already connected
#define DEBUG_DBGP_ALREADY_CONNECTED_RC -5652
// Something unexpected
#define DEBUG_DBGP_UNEXPECTED_RC -5653
// Not connected
#define DEBUG_DBGP_NOT_CONNECTED_RC -5654
// Version not supported
#define DEBUG_DBGP_VERSION_NOT_SUPPORTED_RC -5655
// Command not supported
#define DEBUG_DBGP_COMMAND_NOT_SUPPORTED_RC -5656
// Received empty reply packet
#define DEBUG_GDB_EMPTY_REPLY_RC -5700
// Timed out waiting for response from GDB
#define DEBUG_GDB_TIMEOUT_RC -5701
// GDB has terminated prematurely
#define DEBUG_GDB_TERMINATED_RC -5702
// The application has exited
#define DEBUG_GDB_APP_EXITED_RC -5703
// Received an invalid reply
#define DEBUG_GDB_INVALID_REPLY_RC -5704
// Received an error message
#define DEBUG_GDB_ERROR_REPLY_RC -5705
// Operations on individual threads are not supported
#define DEBUG_GDB_THREAD_OPERATION_UNSUPPORTED_RC -5706
// GDB returned an error opening the executable
#define DEBUG_GDB_ERROR_OPENING_FILE_RC -5707
// GDB returned an error setting the program arguments
#define DEBUG_GDB_ERROR_SETTING_ARGS_RC -5708
// GDB returned an error attaching to the process ID
#define DEBUG_GDB_ERROR_ATTACHING_RC -5709
// GDB returned an error listing threads
#define DEBUG_GDB_ERROR_LISTING_THREADS_RC -5710
// GDB returned an error selecting a thread
#define DEBUG_GDB_ERROR_SELECTING_THREAD_RC -5711
// GDB returned an error selecting a stack frame
#define DEBUG_GDB_ERROR_SELECTING_FRAME_RC -5712
// GDB returned an error listing stack frames
#define DEBUG_GDB_ERROR_LISTING_STACK_RC -5713
// GDB returned an error listing local variables
#define DEBUG_GDB_ERROR_LISTING_LOCALS_RC -5714
// GDB returned an error listing arguments
#define DEBUG_GDB_ERROR_LISTING_ARGUMENTS_RC -5715
// GDB could not evaluate expression
#define DEBUG_GDB_ERROR_EVALUATING_EXPRESSION_RC -5716
// GDB returned an error modifying this variable
#define DEBUG_GDB_ERROR_MODIFYING_VARIABLE_RC -5717
// GDB could not continue application
#define DEBUG_GDB_ERROR_CONTINUING_RC -5718
// GDB could not start application
#define DEBUG_GDB_ERROR_RUNNING_RC -5719
// GDB could not step application
#define DEBUG_GDB_ERROR_STEPPING_RC -5720
// GDB returned an error when interupting application
#define DEBUG_GDB_ERROR_INTERRUPT_RC -5721
// GDB returned an error setting breakpoint
#define DEBUG_GDB_ERROR_SETTING_BREAKPOINT_RC -5722
// GDB returned an error deleting breakpoint
#define DEBUG_GDB_ERROR_DELETING_BREAKPOINT_RC -5723
// GDB returned an error suspending the application
#define DEBUG_GDB_ERROR_SUSPENDING_RC -5724
// Did not receive correct handshake from vsdebugio
#define DEBUG_GDB_INVALID_HANDSHAKE_RC -5725
// Invalid packet header received by vsdebugio
#define DEBUG_GDB_INVALID_PACKET_RC -5726
// Error detaching debugger from target process
#define DEBUG_GDB_ERROR_DETACHING_RC -5727
// GDB returned an error listing registers
#define DEBUG_GDB_ERROR_LISTING_REGISTERS_RC -5728
// GDB returned an error listing memory contents
#define DEBUG_GDB_ERROR_LISTING_MEMORY_RC -5729
// All psuedo-terminals (ptys) are in use
#define DEBUG_GDB_ALL_PTYS_IN_USE_RC -5730
// Cannot open slave psuedo-terminal (pty)
#define DEBUG_GDB_CANNOT_OPEN_SLAVE_PTY_RC -5731
// GNU debugger (gdb) not found
#define DEBUG_GDB_MISSING_GDB_RC -5732
// GDB returned an error attaching to the remote process
#define DEBUG_GDB_ERROR_ATTACHING_REMOTE_RC -5733
// GDB returned an error attaching to the core file
#define DEBUG_GDB_ERROR_ATTACHING_CORE_RC -5734
// Error starting gdb proxy application
#define DEBUG_GDB_ERROR_STARTING_PROXY_RC -5735
// The gdb proxy application is not running
#define DEBUG_GDB_PROXY_NOT_RUNNING_RC -5736
// Error sending message to gdb proxy application
#define DEBUG_GDB_PROXY_ERROR_SENDING_RC -5737
// Could not find the gdb proxy application window
#define DEBUG_GDB_PROXY_WINDOW_NOT_FOUND_RC -5738
// Could not find the gdb proxy application
#define DEBUG_GDB_PROXY_NOT_FOUND_RC -5739
// GDB returned an error listing disassembly
#define DEBUG_GDB_ERROR_LISTING_DISASSEMBLY_RC -5740
// String value truncated by GDB
#define DEBUG_GDB_TRUNCATED_VALUE_RC -5741
// Received an exit message
#define DEBUG_GDB_EXIT_REPLY_RC -5742
// No process running
#define DEBUG_DOTNET_NO_PROCESS_RC -5800
// An error occured while listing threads
#define DEBUG_DOTNET_ERROR_LISTING_THREADS_RC -5801
// An error occured while stack frames
#define DEBUG_DOTNET_ERROR_LISTING_STACK_RC -5802
// No current managed MSIL frame
#define DEBUG_DOTNET_NO_CURRENT_MANAGED_FRAME_RC -5803
// Cannot get variable names
#define DEBUG_DOTNET_ERROR_GETTING_VARIABLES_RC -5804
// Error getting code for frame
#define DEBUG_DOTNET_ERROR_GETTING_CODE_RC -5805
// Error getting function for frame
#define DEBUG_DOTNET_ERROR_GETTING_FUNCITON_RC -5806
// Error getting line number
#define DEBUG_DOTNET_ERROR_GETTING_LINE_RC -5807
// Could not start app for debugging
#define DEBUG_DOTNET_COULD_NOT_START_DEBUGGEE_RC -5808
// The pdb file is out of date.  This project needs to be rebuilt.
#define DEBUG_DOTNET_PDB_FILE_OUT_OF_DATE_RC -5809
// Variable specified is not an array
#define DEBUG_DOTNET_NOT_AN_ARRAY_RC -5810
// The function has no managed body
#define DEBUG_DOTNET_CORDBG_E_FUNCTION_NOT_IL_RC -5811
// Unrecoverable internal error
#define DEBUG_DOTNET_CORDBG_E_UNRECOVERABLE_ERROR_RC -5812
// The debuggee has terminated
#define DEBUG_DOTNET_CORDBG_E_PROCESS_TERMINATED_RC -5813
// Unable to process while debuggee is running
#define DEBUG_DOTNET_CORDBG_E_PROCESS_NOT_SYNCHRONIZED_RC -5814
// A class has not been loaded yet by the debuggee
#define DEBUG_DOTNET_CORDBG_E_CLASS_NOT_LOADED_RC -5815
// The variable is not available
#define DEBUG_DOTNET_CORDBG_E_IL_VAR_NOT_AVAILABLE_RC -5816
// The reference is invalid
#define DEBUG_DOTNET_CORDBG_E_BAD_REFERENCE_VALUE_RC -5817
// The field is not available.
#define DEBUG_DOTNET_CORDBG_E_FIELD_NOT_AVAILABLE_RC -5818
// The field is not available because it is a constant optimized away by the runtime.
#define DEBUG_DOTNET_CORDBG_E_VARIABLE_IS_ACTUALLY_LITERAL_RC -5819
// The frame type is incorrect
#define DEBUG_DOTNET_CORDBG_E_NON_NATIVE_FRAME_RC -5820
// The exception cannot be continued from
#define DEBUG_DOTNET_CORDBG_E_NONCONTINUABLE_EXCEPTION_RC -5821
// The code is not available at this time
#define DEBUG_DOTNET_CORDBG_E_CODE_NOT_AVAILABLE_RC -5822
// The operation cannot be started at the current IP
#define DEBUG_DOTNET_CORDBG_S_BAD_START_SEQUENCE_POINT_RC -5823
// The destination IP is not valid
#define DEBUG_DOTNET_CORDBG_S_BAD_END_SEQUENCE_POINT_RC -5824
// Insufficient information to perform Set IP
#define DEBUG_DOTNET_CORDBG_S_INSUFFICIENT_INFO_FOR_SET_IP_RC -5825
// Cannot Set IP into a finally clause
#define DEBUG_DOTNET_CORDBG_E_CANT_SET_IP_INTO_FINALLY_RC -5826
// Cannot Set IP out of a finally clause
#define DEBUG_DOTNET_CORDBG_E_CANT_SET_IP_OUT_OF_FINALLY_RC -5827
// Cannot Set IP into a catch clause
#define DEBUG_DOTNET_CORDBG_E_CANT_SET_IP_INTO_CATCH_RC -5828
// Unable to Set IP
#define DEBUG_DOTNET_CORDBG_E_SET_IP_IMPOSSIBLE_RC -5829
// Can't Set IP on a non-leaf frame
#define DEBUG_DOTNET_CORDBG_E_SET_IP_NOT_ALLOWED_ON_NONLEAF_FRAME_RC -5830
// Cannot perform a func eval at the current IP
#define DEBUG_DOTNET_CORDBG_E_FUNC_EVAL_BAD_START_POINT_RC -5831
// The object value is no longer valid
#define DEBUG_DOTNET_CORDBG_E_INVALID_OBJECT_RC -5832
// The func eval is still being processed
#define DEBUG_DOTNET_CORDBG_E_FUNC_EVAL_NOT_COMPLETE_RC -5833
// The func eval has no result
#define DEBUG_DOTNET_CORDBG_S_FUNC_EVAL_HAS_NO_RESULT_RC -5834
// Can't dereference a void pointer
#define DEBUG_DOTNET_CORDBG_S_VALUE_POINTS_TO_VOID_RC -5835
// The API is not usable in-process
#define DEBUG_DOTNET_CORDBG_E_INPROC_NOT_IMPL_RC -5836
// The func eval was aborted
#define DEBUG_DOTNET_CORDBG_S_FUNC_EVAL_ABORTED_RC -5837
// The static variable is not available (not yet initialized)
#define DEBUG_DOTNET_CORDBG_E_STATIC_VAR_NOT_AVAILABLE_RC -5838
// The value class object cannot be copied
#define DEBUG_DOTNET_CORDBG_E_OBJECT_IS_NOT_COPYABLE_VALUE_CLASS_RC -5839
// Cannot Set IP into or out of a filter
#define DEBUG_DOTNET_CORDBG_E_CANT_SETIP_INTO_OR_OUT_OF_FILTER_RC -5840
// Cannot change JIT setting for pre-jitted module
#define DEBUG_DOTNET_CORDBG_E_CANT_CHANGE_JIT_SETTING_FOR_ZAP_MODULE_RC -5841
// The thread's state is invalid
#define DEBUG_DOTNET_CORDBG_E_BAD_THREAD_STATE_RC -5842
// Debugging is not possible due to a runtime configuration issue
#define DEBUG_DOTNET_CORDBG_E_DEBUGGING_NOT_POSSIBLE_RC -5843
// Debugging is not possible because there is a kernel debugger enabled on your system
#define DEBUG_DOTNET_CORDBG_E_KERNEL_DEBUGGER_ENABLED_RC -5844
// Debugging is not possible because there is a kernel debugger present on your system
#define DEBUG_DOTNET_CORDBG_E_KERNEL_DEBUGGER_PRESENT_RC -5845
// The process cannot be debugged because the debugger'sinternal debugging protocol is incompatible with the protocol supportedby the process.
#define DEBUG_DOTNET_CORDBG_E_INCOMPATIBLE_PROTOCOL_RC -5846
// First chance exception generated: 
#define DEBUG_DOTNET_FIRST_CHANCE_EXCEPTION_RC -5847
// Unexpected error occured: 
#define DEBUG_DOTNET_UNEXPECTED_ERROR_RC -5848
// Unhandled exception generated: 
#define DEBUG_DOTNET_UNHANDLED_EXCEPTION_RC -5849
// Process not running.
#define DEBUG_DOTNET_PROCESS_NOT_RUNNING_RC -5850
// Thread no longer exists.
#define DEBUG_DOTNET_THREAD_NO_LONGER_EXISTS_RC -5851
// Could not create stepper.
#define DEBUG_DOTNET_CREATE_STEPPER_FAILED_RC -5852
// A debugger is already attached to this process.
#define DEBUG_DOTNET_DEBUGGER_ALREADY_ATTACHED_RC -5853
// , 
#define DEBUG_CAPTION_SEPARATOR_RC -5900
// Verified
#define DEBUG_CAPTION_VERIFIED_RC -5901
// Prepared
#define DEBUG_CAPTION_PREPARED_RC -5902
// Initialized
#define DEBUG_CAPTION_INITIALIZED_RC -5903
// Error
#define DEBUG_CAPTION_ERROR_RC -5904
// Unknown
#define DEBUG_CAPTION_UNKNOWN_RC -5905
// Monitor
#define DEBUG_CAPTION_MONITOR_RC -5906
// Running
#define DEBUG_CAPTION_RUNNING_RC -5907
// Sleeping
#define DEBUG_CAPTION_SLEEPING_RC -5908
// Waiting
#define DEBUG_CAPTION_WAITING_RC -5909
// Zombie
#define DEBUG_CAPTION_ZOMBIE_RC -5910
// Suspended
#define DEBUG_CAPTION_SUSPENDED_RC -5911
// Alive
#define DEBUG_CAPTION_ALIVE_RC -5912
// [Default]
#define DEBUG_CAPTION_DEFAULT_RC -5913
// item
#define DEBUG_CAPTION_ITEM_RC -5914
// items
#define DEBUG_CAPTION_ITEMS_RC -5915
// null
#define DEBUG_CAPTION_NULL_RC -5916
// true
#define DEBUG_CAPTION_TRUE_RC -5917
// false
#define DEBUG_CAPTION_FALSE_RC -5918
// void
#define DEBUG_CAPTION_VOID_RC -5919
// class
#define DEBUG_CAPTION_CLASS_RC -5920
// Thrown
#define DEBUG_CAPTION_THROWN_RC -5921
// Caught
#define DEBUG_CAPTION_CAUGHT_RC -5922
// Uncaught
#define DEBUG_CAPTION_UNCAUGHT_RC -5923
// Ignore
#define DEBUG_CAPTION_IGNORE_RC -5924
// Current execution line
#define DEBUG_CAPTION_CURR_TOP_OF_STACK_RC -5925
// A line on the execution call stack
#define DEBUG_CAPTION_CURR_FRAME_OF_STACK_RC -5926
// Last current execution line
#define DEBUG_CAPTION_LAST_TOP_OF_STACK_RC -5927
// A line on the last execution call stack
#define DEBUG_CAPTION_LAST_FRAME_OF_STACK_RC -5928
// Enabled breakpoint
#define DEBUG_CAPTION_BREAKPOINT_ENABLED_RC -5929
// Disabled breakpoint
#define DEBUG_CAPTION_BREAKPOINT_DISABLED_RC -5930
// Frozen
#define DEBUG_CAPTION_FROZEN_RC -5931
// undefined
#define DEBUG_CAPTION_UNDEFINED_VALUE_RC -5932
// Enabled watchpoint
#define DEBUG_CAPTION_WATCHPOINT_ENABLED_RC -5933
// Disabled watchpoint
#define DEBUG_CAPTION_WATCHPOINT_DISABLED_RC -5934

///////////////////////////////////////////////////////////////////////////////
// JDWP
///////////////////////////////////////////////////////////////////////////////

// JDWP error: No error has occurred
#define JDWP_ERROR_NONE_RC -6000
// JDWP error: Passed thread is not a valid thread or has exited
#define JDWP_ERROR_INVALID_THREAD_RC -6010
// JDWP error: Invalid thread group
#define JDWP_ERROR_INVALID_THREAD_GROUP_RC -6011
// JDWP error: Invalid priority setting
#define JDWP_ERROR_INVALID_PRIORITY_RC -6012
// JDWP error: Thread not suspended
#define JDWP_ERROR_THREAD_NOT_SUSPENDED_RC -6013
// JDWP error: Thread already suspended
#define JDWP_ERROR_THREAD_SUSPENDED_RC -6014
// JDWP error: Passed object is invalid or has been unloaded and garbage collected
#define JDWP_ERROR_INVALID_OBJECT_RC -6020
// JDWP error: Invalid class ID
#define JDWP_ERROR_INVALID_CLASS_RC -6021
// JDWP error: Class has been loaded but not yet prepared
#define JDWP_ERROR_CLASS_NOT_PREPARED_RC -6022
// JDWP error: Invalid method ID
#define JDWP_ERROR_INVALID_METHODID_RC -6023
// JDWP error: Invalid location
#define JDWP_ERROR_INVALID_LOCATION_RC -6024
// JDWP error: Invalid field ID
#define JDWP_ERROR_INVALID_FIELDID_RC -6025
// JDWP error: Invalid frame ID
#define JDWP_ERROR_INVALID_FRAMEID_RC -6030
// JDWP error: There are no more Java or JNI frames on the call stack
#define JDWP_ERROR_NO_MORE_FRAMES_RC -6031
// JDWP error: Information about the frame is unavailable
#define JDWP_ERROR_OPAQUE_FRAME_RC -6032
// JDWP error: Operation can only be performed on the current frame
#define JDWP_ERROR_NOT_CURRENT_FRAME_RC -6033
// JDWP error: The variable is not an appropriate type for the function used
#define JDWP_ERROR_TYPE_MISMATCH_RC -6034
// JDWP error: Invalid slot
#define JDWP_ERROR_INVALID_SLOT_RC -6035
// JDWP error: Item already set
#define JDWP_ERROR_DUPLICATE_RC -6040
// JDWP error: Requested item not found
#define JDWP_ERROR_NOT_FOUND_RC -6041
// JDWP error: Invalid monitor
#define JDWP_ERROR_INVALID_MONITOR_RC -6050
// JDWP error: This thread doesn't own the monitor
#define JDWP_ERROR_NOT_MONITOR_OWNER_RC -6051
// JDWP error: The call has been interrupted before completion
#define JDWP_ERROR_INTERRUPT_RC -6052
// JDWP error: The virtual machine attempted to read a malformed class file
#define JDWP_ERROR_INVALID_CLASS_FORMAT_RC -6060
// JDWP error: A circularity has been detected while initializing a class
#define JDWP_ERROR_CIRCULAR_CLASS_DEFINITION_RC -6061
// JDWP error: Class failed verification
#define JDWP_ERROR_FAILS_VERIFICATION_RC -6062
// JDWP error: Add method not implemented
#define JDWP_ERROR_ADD_METHOD_NOT_IMPLEMENTED_RC -6063
// JDWP error: Schema change not implemented
#define JDWP_ERROR_SCHEMA_CHANGE_NOT_IMPLEMENTED_RC -6064
// JDWP error: The state of the thread has been modified and is now inconsistent
#define JDWP_ERROR_INVALID_TYPESTATE_RC -6065
// JDWP error: A direct superclass is different for the new class version
#define JDWP_ERROR_HIERARCHY_CHANGE_NOT_IMPLEMENTED_RC -6066
// JDWP error: The new class version does not implement a method declared in the old class version
#define JDWP_ERROR_DELETE_METHOD_NOT_IMPLEMENTED_RC -6067
// JDWP error: A class file has a version number not supported by this VM
#define JDWP_ERROR_UNSUPPORTED_VERSION_RC -6068
// JDWP error: The class name defined in the new class file does not match the original class name
#define JDWP_ERROR_NAMES_DONT_MATCH_RC -6069
// JDWP error: The new class version has different modifiers than the original class
#define JDWP_ERROR_CLASS_MODIFIERS_CHANGE_NOT_IMPLEMENTED_RC -6070
// JDWP error: A method in the new class version has different modifiers than the original method
#define JDWP_ERROR_METHOD_MODIFIERS_CHANGE_NOT_IMPLEMENTED_RC -6071
// JDWP error: Feature not implemented in this virtual machine
#define JDWP_ERROR_NOT_IMPLEMENTED_RC -6099
// JDWP error: Null pointer
#define JDWP_ERROR_NULL_POINTER_RC -6100
// JDWP error: Requested information is not available
#define JDWP_ERROR_ABSENT_INFORMATION_RC -6101
// JDWP error: The specified event type is not recognized
#define JDWP_ERROR_INVALID_EVENT_TYPE_RC -6102
// JDWP error: Illegal argument
#define JDWP_ERROR_ILLEGAL_ARGUMENT_RC -6103
// JDWP error: Out of memory
#define JDWP_ERROR_OUT_OF_MEMORY_RC -6110
// JDWP error: Access denied; Debugging may not be enabled on this virtual machine
#define JDWP_ERROR_ACCESS_DENIED_RC -6111
// JDWP error: The virtual machine is not running
#define JDWP_ERROR_VM_DEAD_RC -6112
// JDWP error: An unexpected internal error has occurred in the virtual machine
#define JDWP_ERROR_INTERNAL_RC -6113
// JDWP error: The thread being used to call this function is not attached to the virtual machine
#define JDWP_ERROR_UNATTACHED_THREAD_RC -6115
// JDWP error: Invalid object type ID or class tag
#define JDWP_ERROR_INVALID_TAG_RC -6500
// JDWP error: Previous method or constructor invocation not complete
#define JDWP_ERROR_ALREADY_INVOKING_RC -6502
// JDWP error: Invalid array index
#define JDWP_ERROR_INVALID_INDEX_RC -6503
// JDWP error: Invalid array length
#define JDWP_ERROR_INVALID_LENGTH_RC -6504
// JDWP error: Invalid string
#define JDWP_ERROR_INVALID_STRING_RC -6506
// JDWP error: Invalid class loader
#define JDWP_ERROR_INVALID_CLASS_LOADER_RC -6507
// JDWP error: Invalid array object
#define JDWP_ERROR_INVALID_ARRAY_RC -6508
// JDWP error: Error loading transport layer
#define JDWP_ERROR_TRANSPORT_LOAD_RC -6509
// JDWP error: Error initializing transport layer
#define JDWP_ERROR_TRANSPORT_INIT_RC -6510
// JDWP error: Operation not allowed for native methods
#define JDWP_ERROR_NATIVE_METHOD_RC -6511
// JDWP error: Invalid item count
#define JDWP_ERROR_INVALID_COUNT_RC -6512
// JDWP error: The specified command set is not recognized
#define JDWP_ERROR_INVALID_COMMAND_SET_RC -6513
// JDWP error: The specified command is not recognized
#define JDWP_ERROR_INVALID_COMMAND_RC -6514

///////////////////////////////////////////////////////////////////////////////
// CVS
///////////////////////////////////////////////////////////////////////////////

// CVS error: You are not logged on
#define CVS_ERROR_NOT_LOGGED_IN -6600
// CVS executable not found
#define CVS_ERROR_EXE_NOT_FOUND -6601
// CVS checkout failed
#define CVS_ERROR_CHECKOUT_FAILED_RC -6602

///////////////////////////////////////////////////////////////////////////////
// SUBVERSION
///////////////////////////////////////////////////////////////////////////////

// %s0 %s1 returned %s2
#define SVN_COMMAND_RETURNED_ERROR_RC -6650
// This command does not support directories
#define SVN_DIRECTORIES_NOT_SUPPORTED_RC -6651
// This file was not checked out from %s0
#define SVN_FILE_NOT_CONTROLLED_RC -6652
// Subversion
#define SVN_APP_NAME_RC -6653
// Could not get log info for %s0
#define SVN_COULD_NOT_GET_LOG_INFO_RC -6654
// Subversion checkout failed
#define SVN_ERROR_CHECKOUT_FAILED_RC -6655
// Can't get Subversion password (perform "svn status" from console)
#define SVN_ERROR_CANT_GET_PASSWORD -6656
// Subversion output exceeds configured maximum output size
#define SVN_OUTPUT_TOO_LARGE -6657
// Subversion returned an error for the path(s): %s0
#define SVN_COMMAND_RETURNED_ERROR_FOR_PATH_RC -6658

///////////////////////////////////////////////////////////////////////////////
// SVC
///////////////////////////////////////////////////////////////////////////////

// Could not get interface for %s0
#define SVC_COULD_NOT_GET_VC_INTERFACE_RC -6670
// Interface for %s0 not available
#define SVC_VC_INTERFACE_NOT_AVAILABLE_RC -6671
// Could not get interface for %s0
#define SVC_COULD_NOT_GET_VC_FILE_INTERFACE_RC -6672
// Interface for %s0 not available
#define SVC_FILE_INTERFACE_NOT_AVAILABLE_RC -6673
// File %s0 not found
#define SVC_FILE_NOT_FOUND_RC -6674
// File %s0 not found
#define SVC_SYSTEM_NOT_SUPPORTED_RC -6675
// Annotations for file %s0 not found
#define SVC_ANNOTATIONS_NOT_AVAILABLE_RC -6676

///////////////////////////////////////////////////////////////////////////////
// UPDATE
///////////////////////////////////////////////////////////////////////////////

// Could not write to file %s0
// 
// Possible Causes:
// 
// *Do not have write permissions for file
// 
// *Out of disk space
#define UPDATE_CANNOT_WRITE_FILE_RC -6800
// Error copying files
#define UPDATE_GENERAL_COPY_ERROR_RC -6801
// Could not backup file %s0
// 
// Continue?
#define UPDATE_BACKUP_ERROR_RC -6802
// Could not create path %s0
#define UPDATE_COULD_NOT_CREATE_PATH_ERROR_RC -6803
// Updating Files - %s0
#define UPDATE_UPDATING_FILES_RC -6804
// Compiling Macro Files - %s0
#define UPDATE_COMPILING_FILES_RC -6805
// File %s1 does not exist in the specified path
#define UPDATE_FILE_DOES_NOT_EXIST_RC -6806
// Could not copy serial information to new %s0.
// Possible Causes:
// 
// 	* The executable path "%s1" is incorrect.
// 
// 	* Someone is running %s2.
// 
// 	* %s3%s4 is a demo executable.
// 
// 	* %s5%s6 is an old version and cannot be updated with this program
#define UPDATE_COULD_NOT_SERIALIZE_RC -6807
// Could not decompress %s0
#define UPDATE_COULD_NOT_DECOMPRESS_VSAPI_RC -6808
// Could not find uninstall list file.  SlickEdit's uninstall may fail to remove some new files in this patch.
// 
// Continue?
#define UPDATE_COULD_NOT_FIND_UNINST_LIST_RC -6809
// %s0 is a trial install, and cannot be updated
// 
// To purchase please contact sales at SlickEdit Inc. at 800 934-3348 or 919 473-0100.
#define UPDATE_CANNOT_UPDATE_TRIAL_RC -6810
// If this is a network installation:
// 
// This update should only be run by the network administrator.
// Other users will automatically be updated.
// 
// Continue?
#define UPDATE_NETWORK_INSTALL_RC -6811
// To run this update, you will need to have 19MB of free space available on the partition where SlickEdit resides.
// 
// You currently have %s0 bytes.
// 
// Please clear some space and try again
#define UPDATE_INSUFFICIENT_DISK_SPACE_RC -6812
// Update failed
#define UPDATE_FAILED_RC -6813
// Update complete
#define UPDATE_COMPLETE_RC -6814
// Path %s0 does not exist or is incorrect
#define UPDATE_PATH_DOES_NOT_EXIST_RC -6815
// There does not appear to be a SlickEdit plugin in the path %s0.
#define UPDATE_BAD_ECLIPSE_PATH -6816
// Could not update the feature.xml file
#define UPDATE_COULD_NOT_UPDATE_ECLIPSE_FEATURE_RC -6817
// Could not update the .eclipseextension file
#define UPDATE_COULD_NOT_UPDATE_ECLIPSE_EXTENSION_RC -6818
// You will need to restart WebSphere Studio or Eclipse now
#define UPDATE_RESTART_ECLIPSE_EXTENSION_RC -6819
// Could not open file %s0
#define UPDATE_CANNOT_OPEN_FILE_RC -6820

///////////////////////////////////////////////////////////////////////////////
// FTP
///////////////////////////////////////////////////////////////////////////////

// Bad or unexpected response
#define VSRC_FTP_BAD_RESPONSE -6851
// Connection lost
#define VSRC_FTP_CONNECTION_DEAD -6852
// Cannot stat file or directory
#define VSRC_FTP_CANNOT_STAT -6853
// Waiting for reply
#define VSRC_FTP_WAITING_FOR_REPLY -6854
// Bad or missing configuration
#define VSRC_FTP_BAD_CONFIG -6855
// Authentication failure
#define VSRC_FTP_CANNOT_AUTHENTICATE -6856
// reserve thru 6899 for FTP
#define VSRC_FTP_END_ERRORS -6899

///////////////////////////////////////////////////////////////////////////////
// DELTASAVE
///////////////////////////////////////////////////////////////////////////////

// Could not create archive file
#define DS_COULD_NOT_CREATE_ARCHIVE_FILE_RC -6900
// Could not create archive file
#define DS_ARCHIVE_FILE_NOT_OPEN_RC -6901
// Source filename not set
#define DS_SOURCE_FILENAME_NOT_SET_RC -6902
// Version %s0 of '%s1' not found
#define DS_VERSION_NOT_FOUND_RC -6903
// Pre-backup callback failed
#define DS_PRE_CALLBACK_FAILED_RC -6904
// Post-backup callback failed
#define DS_POST_CALLBACK_FAILED_RC -6905
// Files matched
#define DS_FILE_MATCHED_RC -6906
// A delta cannot be created because '%s0' is not the current file
#define DS_NOT_CURRENT_BUFFER_RC -6907
// The original encoding for the backup of this file (%s0) can no longer be used.
// 
// The file was opened using active code page
#define DS_COULD_NOT_OPEN_FILE_WITH_CODE_PAGE_RC -6908
// A delta cannot be created because '%s0' is in a directory which is excluded from backup history
#define DS_FILE_EXCLUDED_RC -6909

///////////////////////////////////////////////////////////////////////////////
// VSDIFF
///////////////////////////////////////////////////////////////////////////////

// 
// vsdiff
// 
// Usage:
// 	To compare two files:
// 	vsdiff  [-r1][-r2] <File1> <File2>
// 	If files have the same name, only give path for File2
// 	ex:
// 		vsdiff <path1>/file1.c <path2>
// 	 -r1 option will make file on left read only
// 	 -r2 option will make file on right read only
// 
// 	To compare two directories:
// 	vsdiff [-norecurse] -filespec "<filespec>" [-excludefilespec "<excludefilespec>"]
// 		 directory recursion is on by default. Use -norecurse to diff directories without recursing
// 		-filespec and -excludefilespec can be delimited with spaces or %s0
// 	ex:
// 		vsdiff -filespec "*.c *.h" -excludefilespec "test*" <path1> <path2>
// 
// 
// 	Or:
// 
// 
// 	vsdiff [-norecurse] <Path And Filespec1> <Path2>
// 	ex:
// 		vsdiff <path1>*.c <path2>
// 
// 	To launch DIFFzilla(R) dialog:
// 
// 	vsdiff
// 
// 
// 	A SlickEdit configuration path may be specified with a -sc option 
// 	ex:
// 		vsdiff -sc <configpath> ...
#define VSDIFF_USAGE_RC -7000
// vsdiff: could not find file "%s0"
#define VSDIFF_FILE_NOT_FOUND_RC -7001
// No more differences
#define VSDIFF_NO_MORE_DIFFERENCES_RC -7002
// No more conflicts
#define VSDIFF_NO_MORE_CONFLICTS_RC -7003
// vsdiff
#define VSDIFF_APP_NAME -7004
// No more differences.  Close now?
#define VSDIFF_NO_MORE_DIFFERENCES_CLOSE_RC -7005
// Diff timed out
#define VSDIFF_TIMED_OUT_RC -7006

///////////////////////////////////////////////////////////////////////////////
// VSMERGE
///////////////////////////////////////////////////////////////////////////////

// 
// vsmerge
// 
// Usage:
// 
// vsmerge [options] <basefile> <revision1file> <revision2file> <outputfile>
// 	options are as follows:
// 		-smart:	Attempt to resolve simple conficts
// 		-quiet:	Supress "No conficts detected" message
// 		-showchanges:	Force user to merge in non-conflict changes
// 		-ignorespaces:	Ignore spaces in the files being merged
// Usage:
// 	To launch 3-way merge dialog:
// 
// 	vsmerge
// 
// 
// 	A SlickEdit configuration path may be specified with a -sc option 
// 	ex:
// 		vsmerge -sc <configpath> ...
#define VSMERGE_USAGE_RC -7100
// vsmerge: Could not find file "%s0"
#define VSMERGE_FILE_NOT_FOUND_RC -7101
// vsmerge
#define VSMERGE_APP_NAME -7102
// vsmerge: Invalid option "%s0"
#define VSMERGE_INVALID_OPTION_RC -7103

///////////////////////////////////////////////////////////////////////////////
// VSMFUNDO
///////////////////////////////////////////////////////////////////////////////

// Multi file undo stack empty
#define VSRC_MFUNDO_STACK_EMPTY -7200
// Multi file undo step has already beeen ended
#define VSRC_MFUNDO_STEP_ALREADY_ENDED -7201
// vsMFUndoEndStep() not called to generate redo information
#define VSRC_MFUNDO_END_STEP_NOT_CALLED -7202
// Failed to generate redo information
#define VSRC_FAILED_TO_GENERATE_REDO_INFO -7203
// vsMFUndoBegin() not called
#define VSRC_MFUNDO_BEGIN_NOT_CALLED -7204
// vsMFUndoBeginStep() not called
#define VSRC_MFUNDO_BEGIN_STEP_NOT_CALLED -7205

///////////////////////////////////////////////////////////////////////////////
// VSREFACTOR
///////////////////////////////////////////////////////////////////////////////

// Could not find parser configuration:  '%s0'
#define VSRC_VSREFACTOR_CONFIGURATION_NOT_FOUND_1A -7500
// Refactoring configuration file not open
#define VSRC_VSREFACTOR_CONFIGURATION_FILE_NOT_OPEN -7501
// Invalid refactoring transaction handle
#define VSRC_VSREFACTOR_TRANSACTION_HANDLE_INVALID -7502
// internal error
#define VSRC_VSREFACTOR_INTERNAL_ERROR -7503
// Could not find symbol:  '%s0'
#define VSRC_VSREFACTOR_SYMBOL_NOT_FOUND_1A -7504
// Invalid symbol for this operation:  '%s0'
#define VSRC_VSREFACTOR_INVALID_SYMBOL_1A -7505
// Invalid include path
#define VSRC_VSREFACTOR_INVALID_INCLUDE_PATH -7506
// Invalid #define/#undef
#define VSRC_VSREFACTOR_INVALID_DEFINE -7507
// Invalid configuration file
#define VSRC_VSREFACTOR_INVALID_CONFIGURATION_FILE -7508
// This reference to the refactored method can not resolve an instance
#define VSRC_VSREFACTOR_STATIC_TO_INSTANCE_METHOD_WARNING -7509
// Cannot replace the selected code block with a function call.
#define VSRC_VSREFACTOR_CANNOT_REPLACE_CODE_WITH_CALL -7510
// A declaration within the selected code block calls a class constructor.
#define VSRC_VSREFACTOR_CANNOT_REPLACE_CODE_WITH_CONSTRUCTOR -7511
// The selected code block contains a goto statement.
#define VSRC_VSREFACTOR_CANNOT_REPLACE_CODE_WITH_GOTO -7512
// The selected code block contains a return statement.
#define VSRC_VSREFACTOR_CANNOT_REPLACE_CODE_WITH_RETURN -7513
// The selected code block contains a break statement.
#define VSRC_VSREFACTOR_CANNOT_REPLACE_CODE_WITH_BREAK -7514
// The selected code block contains a continue statement.
#define VSRC_VSREFACTOR_CANNOT_REPLACE_CODE_WITH_CONTINUE -7515
// %s0 errors found parsing.  Please see the Output Toolbar for details.
#define VSRC_VSREFACTOR_PARSING_FAILURE_1A -7516
// Please wait...
#define VSRC_VSREFACTOR_PLEASE_WAIT -7517
// Analyzing...
#define VSRC_VSREFACTOR_ANALYZING -7518
// Processing Templates...
#define VSRC_VSREFACTOR_PROCESSING_TEMPLATES -7519
// Parsing...
#define VSRC_VSREFACTOR_PARSING -7520
// File:  %s0
#define VSRC_VSREFACTOR_FILE_1A -7521
// File %s1/%s2:  %s0
#define VSRC_VSREFACTOR_FILE_3A -7522
// Refactoring...
#define VSRC_VSREFACTOR_REFACTORING -7523
// Finding modified files...
#define VSRC_VSREFACTOR_FINDING_MODIFIED -7524
// Saving...
#define VSRC_VSREFACTOR_SAVING -7525
// Cleaning up...
#define VSRC_VSREFACTOR_CLEANING_UP -7526
// This reference is not a class.
#define VSRC_VSREFACTOR_SYMBOL_IS_NOT_A_CLASS -7527
// The file to move the static definition to does not exist.
#define VSRC_VSREFACTOR_CLASS_DEFINITION_FILE_DOES_NOT_EXIST -7528
// There is already a symbol named '%s0'
#define VSRC_VSREFACTOR_SYMBOL_ALREADY_DEFINED_1A -7529
// The symbol '%s0' is not a function.
#define VSRC_VSREFACTOR_SYMBOL_IS_NOT_A_FUNCTION_1A -7530
// Modified function conflicts with an already existing overloaded function
#define VSRC_VSREFACTOR_FUNCTION_CONFLICT -7531
// New parameter name matches the name of a variable in the function context
#define VSRC_VSREFACTOR_NEW_PARAMETER_CONFLICT -7532
// The symbol is not a member of a class.
#define VSRC_VSREFACTOR_NOT_A_CLASS_MEMBER -7533
// The symbol '%s0' would be hidden by moving it to this super class.
#define VSRC_VSREFACTOR_SYMBOL_WOULD_BE_HIDDEN_1A -7534
// Preprocessing...
#define VSRC_VSREFACTOR_PREPROCESSING -7535
// Unexpected compiler configuration type encountered.
#define VSRC_VSREFACTOR_CONFIGURATION_UNEXPECTED_TYPE -7535
// reserve thru 7999 for VSREFACTOR
#define VSRC_VSREFACTOR_END_ERRORS -7999

///////////////////////////////////////////////////////////////////////////////
// VSPARSER
///////////////////////////////////////////////////////////////////////////////

// %s0(%s1,%s2): error %s3: 
#define VSRC_VSPARSER_ERROR_PREFIX -8000
// syntax error '%s0'
#define VSRC_VSPARSER_SYNTAX_ERROR_1A -8001
// expecting '%s0'
#define VSRC_VSPARSER_EXPECTING_1A -8002
// attempt to recover after last error failed.
#define VSRC_VSPARSER_RECOVER_FAILED -8003
// expecting identifier
#define VSRC_VSPARSER_EXPECTING_IDENTIFIER -8004
// expecting newline
#define VSRC_VSPARSER_EXPECTING_NEWLINE -8005
// unrecognized character
#define VSRC_VSPARSER_UNRECOGNIZED_CHARACTER -8006
// unterminated block comment
#define VSRC_VSPARSER_UNTERMINATED_COMMENT -8007
// unterminated string or character constant
#define VSRC_VSPARSER_UNTERMINATED_STRING -8008
// malformed numeric literal
#define VSRC_VSPARSER_MALFORMED_NUMBER -8009
// unexpected token: '%s0'
#define VSRC_VSPARSER_UNEXPECTED_TOKEN_1A -8010
// expecting number
#define VSRC_VSPARSER_EXPECTING_NUMBER -8011
// expecting argument name
#define VSRC_VSPARSER_EXPECTING_ARGUMENT -8012
// %s0 without matching %s1
#define VSRC_VSPARSER_MISMATCHED_GROUP_2A -8013
// unrecognized identifier: '%s0'
#define VSRC_VSPARSER_UNRECOGNIZED_IDENTIFER_1A -8014
// %s0(%s1,%s2): warning %s3: 
#define VSRC_VSPARSER_WARNING_PREFIX -8015
// reuse of macro formal parameter '%s0'
#define VSRC_VSPARSER_REUSE_OF_MACRO_PARAMETER_1A -8016
// redefinition of macro '%s0'
#define VSRC_VSPARSER_MACRO_REDEFINITION_1A -8017
// see previous definition of '%s0'
#define VSRC_VSPARSER_SEE_PREVIOUS_DEFINITION_1A -8018
// see definition of '%s0'
#define VSRC_VSPARSER_SEE_DEFINITION_1A -8019
// undefined symbol '%s0'
#define VSRC_VSPARSER_SYMBOL_NOT_FOUND_1A -8020
// internal error
#define VSRC_VSPARSER_INTERNAL_ERROR -8021
// cannot add two pointers
#define VSRC_VSPARSER_CANNOT_ADD_TWO_POINTERS -8022
// no '%s0' operator defined which matches the operands
#define VSRC_VSPARSER_NO_SUCH_OPERATOR_1A -8023
// incomplete expression
#define VSRC_VSPARSER_INCOMPLETE_EXPRESSION -8024
// array index must have integral type
#define VSRC_VSPARSER_INVALID_ARRAY_INDEX -8025
// operands to the '%s0' operator must have integral types
#define VSRC_VSPARSER_INTEGRAL_TYPE_EXPECTED_1A -8026
// expecting modifyable lvalue
#define VSRC_VSPARSER_EXPECTING_LVALUE -8027
// cannot assign from '%s0' to '%s1' -- types are incompatible and there is no suitable conversion
#define VSRC_VSPARSER_CANNOT_ASSIGN_TO_2A -8028
// conversion may result in loss of precision
#define VSRC_VSPARSER_LOSS_OF_PRECISION -8029
// types are incompatible or can not be converted unambiguously
#define VSRC_VSPARSER_TYPES_ARE_INCOMPATIBLE -8030
// expecting a pointer type
#define VSRC_VSPARSER_EXPECTING_POINTER_TYPE -8031
// operator '.' used where '->' was expected
#define VSRC_VSPARSER_UNEXPECTED_POINTER_TYPE -8032
// expecting class, struct, or union type
#define VSRC_VSPARSER_EXPECTING_CLASS_TYPE -8033
// constant expression results in division by zero
#define VSRC_VSPARSER_DIVISION_BY_ZERO -8034
// operator '%' can not be applied to floating point operands
#define VSRC_VSPARSER_CANNOT_MODULO_FLOAT -8035
// expecting pointer to member
#define VSRC_VSPARSER_POINTER_TO_MEMBER_EXPECTED -8036
// could not calculate size of expression.
#define VSRC_VSPARSER_COULD_NOT_CALCULATE_SIZE -8037
// expecting integral type
#define VSRC_VSPARSER_EXPECTING_INTEGRAL_TYPE -8038
// expecting constant expression
#define VSRC_VSPARSER_EXPECTING_CONSTANT_EXPRESSION -8039
// initializer not allowed
#define VSRC_VSPARSER_INITIALIZER_NOT_ALLOWED -8040
// symbol '%s0' is already defined
#define VSRC_VSPARSER_SYMBOL_ALREADY_DEFINED_1A -8041
// same type qualifier used more than once
#define VSRC_VSPARSER_REPEATED_QUALIFIER -8042
// cannot convert from '%s0' to '%s1'
#define VSRC_VSPARSER_CANNOT_CONVERT_TYPE_2A -8043
// function must return a value
#define VSRC_VSPARSER_FUNCTION_MUST_RETURN_VALUE -8044
// static member functions do not have 'this' pointer
#define VSRC_VSPARSER_THIS_NOT_ALLOWED -8045
// expecting template name
#define VSRC_VSPARSER_EXPECTING_TEMPLATE -8046
// invalid template argument '%s0'
#define VSRC_VSPARSER_INCOMPATIBLE_TEMPLATE_ARGUMENT_1A -8047
// references cannot be created by new-expressions
#define VSRC_VSPARSER_CANNOT_NEW_REFERENCE_TYPE -8048
// '%s0' is not a namespace identifier
#define VSRC_VSPARSER_EXPECTING_NAMESPACE_1A -8049
// cannot access private member '%s0' from this scope
#define VSRC_VSPARSER_PRIVATE_MEMBER_1A -8050
// cannot access protected member '%s0' from this scope
#define VSRC_VSPARSER_PROTECTED_MEMBER_1A -8051
// pure virtual specifier applies only to virtual functions
#define VSRC_VSPARSER_PURE_BUT_NOT_VIRTUAL -8052
// inline specifier applies only to functions
#define VSRC_VSPARSER_INLINE_BUT_NOT_FUNCTION -8053
// virtual specifier applies only to functions
#define VSRC_VSPARSER_VIRTUAL_BUT_NOT_FUNCTION -8054
// explicit specifier applies only to constructors
#define VSRC_VSPARSER_EXPLICIT_BUT_NOT_CONSTRUCTOR -8055
// virtual specifier not allowed for a constructor
#define VSRC_VSPARSER_VIRTUAL_CONSTRUCTOR -8056
// constructors, destructors, and conversion operators are not allowed to have return types
#define VSRC_VSPARSER_RETURN_TYPE_NOT_ALLOWED -8057
// '%s0' is not static
#define VSRC_VSPARSER_EXPECTING_STATIC_MEMBER_1A -8058
// void function cannot return a value
#define VSRC_VSPARSER_FUNCTION_CANNOT_RETURN_VALUE -8059
// static specifier can not be used with virtual
#define VSRC_VSPARSER_STATIC_AND_VIRTUAL -8060
// initializer list not allowed for '%s0'
#define VSRC_VSPARSER_INITIALIZER_LIST_NOT_ALLOWED_1A -8061
// too many initializer expressions
#define VSRC_VSPARSER_TOO_MANY_INITIALIZERS -8062
// ambiguous call to overloaded function '%s0'
#define VSRC_VSPARSER_AMBIGUOUS_FUNCTION_CALL_1A -8063
// function '%s0' does not take %s1 arguments
#define VSRC_VSPARSER_FUNCTION_WRONG_NUMBER_ARGUMENTS_2A -8064
// too many arguments
#define VSRC_VSPARSER_TOO_MANY_ARGUMENTS -8065
// no default argument
#define VSRC_VSPARSER_NO_DEFAULT_ARGUMENT -8066
// argument lists do not match
#define VSRC_VSPARSER_ARGUMENT_LISTS_DO_NOT_MATCH -8067
// template '%s0' does not take %s1 arguments
#define VSRC_VSPARSER_TEMPLATE_WRONG_NUMBER_ARGUMENTS_2A -8068
// template '%s0' was instantiated before it was specialized
#define VSRC_VSPARSER_TEMPLATE_INSTANTIATED_BEFORE_SPECIALIZATION_1A -8069
// template '%s0' instantiated with a forward declared type
#define VSRC_VSPARSER_TEMPLATE_INSTANTIATED_WITH_FORWARD_DECLARED_TYPE_1A -8070
// unable to determine type of template argument '%s1' in template '%s0'
#define VSRC_VSPARSER_TEMPLATE_UNABLE_TO_DETERMINE_ARGUMENTS_2A -8071
// detected possible recursive or mutually recursive include file(s): '%s0'
#define VSRC_VSPARSER_RECURSIVELY_INCLUDED_HEADER_FILE_1A -8072
// switch statement contains more than one default case
#define VSRC_VSPARSER_SWITCH_HAS_MORE_THAN_ONE_DEFAULT -8073
// incomplete type info
#define VSRC_VSPARSER_INCOMPLETE_TYPE_INFO -8074
// line comment has line continuation
#define VSRC_VSPARSER_LINE_COMMENT_HAS_CONTINUATION -8075
// '%s0' is not a member of '%s1'
#define VSRC_VSPARSER_NOT_A_MEMBER_OF_2A -8076
// switch statement contains no cases or default
#define VSRC_VSPARSER_SWITCH_HAS_NO_CASE_OR_DEFAULT -8077
// internal error: %s0.%s1
#define VSRC_VSPARSER_INTERNAL_ERROR_2A -8078
// preprocessing expanded from here
#define VSRC_VSPARSER_PREPROCESSING_LOCATION -8079
// redefinition of default value for parameter '%s0'
#define VSRC_VSPARSER_DEFAULT_VALUE_REDEFINITION_1A -8080
// try statement requires at least one handler statement
#define VSRC_VSPARSER_TRY_REQUIRES_HANDLER -8081
// pointer arithmetic requires integral type on right
#define VSRC_VSPARSER_POINTER_ARITHMETIC_REQUIRES_INTEGRAL_TYPE -8082
// template parameter '%s1' in template '%s0' is ambiguous
#define VSRC_VSPARSER_TEMPLATE_PARAMETER_AMBIGUOUS_2A -8083
// variable length array dimensions can not be used in this context
#define VSRC_VSPARSER_VARIABLE_LENGTH_ARRAYS_NOT_ALLOWED_HERE -8084
// 'void' cannot be an argument type, except for '(void)'
#define VSRC_VSPARSER_VOID_ILLEGALLY_USED_AS_ARGUMENT_TYPE -8085
// cannot assign from '%s0' to '%s1' -- left hand side specifies const object
#define VSRC_VSPARSER_CANNOT_ASSIGN_TO_CONST_2A -8086
// mutable specifier can not be used with const
#define VSRC_VSPARSER_MUTABLE_AND_CONST -8087
// cannot assign to const object of type '%s0'
#define VSRC_VSPARSER_CANNOT_INCREMENT_CONST_1A -8088
// cannot use const or volatile modifiers on a function outside of a class declaration
#define VSRC_VSPARSER_CANNOT_USE_CONST_OR_VOLATILE_OUTSIDE_OF_CLASS -8089
// reserve thru 8999 for VSPARSER
#define VSRC_VSPARSER_END_ERRORS -8999

///////////////////////////////////////////////////////////////////////////////
// UPCHECK
///////////////////////////////////////////////////////////////////////////////

// 
// Update Check Version %s0
// 
// This program is used to check for and retrieve product updates.
// 
// Usage: %s1 [-help] [-proxy hostname:port] [-noproxy] [-i] [-updatebase base] [-c command]
// where:
// 	-help     	Display this message.
// 	-i            	Interactive mode.
// 	-updatebase 	HTTP base url for fetching updates (do NOT include 'http://').
// 	-proxy   	Use HTTP proxy at hostname on port.
// 	-noproxy 	Windows only. Do not use Internet Explorer proxy/connection settings.
// 	-c           	Execute command then exit. If given, this must be the last argument.
// 
#define VSRC_UPCHECK_HELP -9000
// Unknown command '%s0'
#define VSRC_UPCHECK_UNKNOWN_COMMAND -9001
// Invalid option '%s0'
#define VSRC_UPCHECK_INVALID_ARGUMENT -9002
// Error opening output file: '%s0'
#define VSRC_UPCHECK_ERROR_OPENING_OUTPUT_FILE -9003
// Not enough arguments. %s0
#define VSRC_UPCHECK_NOT_ENOUGH_ARGUMENTS -9004
// Action failed for '%s0': %s1
#define VSRC_UPCHECK_ACTION_FAILED -9005
// Missing status for action '%s0'
#define VSRC_UPCHECK_MISSING_ACTION_STATUS -9006
// Missing 'upcheck' command at location '%s0'
#define VSRC_UPCHECK_NOT_FOUND -9007
// Error starting 'upcheck' command
#define VSRC_UPCHECK_ERROR_STARTING -9008
// Timed out waiting for reply
#define VSRC_UPCHECK_TIMED_OUT -9009
// Invalid response
#define VSRC_UPCHECK_INVALID_RESPONSE -9010
// Version not supported: %s0
#define VSRC_UPCHECK_VERSION_NOT_SUPPORTED -9011
// Error creating upcheck log
#define VSRC_UPCHECK_ERROR_CREATING_LOG -9012
// Error saving manifest file '%s0'
#define VSRC_UPCHECK_ERROR_SAVING_MANIFEST -9013
// Error retrieving updates
#define VSRC_UPCHECK_ERROR_RETRIEVING_UPDATES -9014
// You can check for new updates anytime from the Help>Product Updates menu
#define VSRC_UPCHECK_MANUAL_CHECK_HELP -9015

///////////////////////////////////////////////////////////////////////////////
// VSRTE
///////////////////////////////////////////////////////////////////////////////

// Unable to load JVM library
#define RTE_CANT_LOAD_JVM_LIB -9100
// Unable to find JVM creation function
#define RTE_CANT_FIND_CREATE_VM -9101
// No JVM found for RTE
#define RTE_NO_JVM -9102
// Cannot attach current thread to the JVM
#define RTE_CANT_ATTACH -9103
// Cannot create JVM environment
#define RTE_CANT_CREATE_ENV -9104
// Cannot find RTE compiler
#define RTE_CANT_FIND_COMPILER_CLASS -9105
// Cannot find constructor for RTE compiler class
#define RTE_CANT_FIND_CONSTRUCTOR -9106
// Cannot instantiate RTE compiler class
#define RTE_CANT_INSTANTIATE_CLASS -9107
// Failure creating jstring
#define RTE_CANT_CREATE_JSTRING -9108
// Cannot locate RTE compiler method
#define RTE_CANT_FIND_COMPILE_ID -9109
// Failure retrieving errors from Java
#define RTE_CANT_GET_ERRORS -9110
// Java Live Error
#define RTE_MESSAGE_TYPE -9111
// Invalid number of arguments specified for Javac option
#define RTE_INVALID_ARGS_FOR_OPTION -9112
// reserved through 9200 for RTE
#define RTE_END_ERRORS -9200

///////////////////////////////////////////////////////////////////////////////
// DBGP
///////////////////////////////////////////////////////////////////////////////

// DBGP error: No error has occurred
#define DBGP_ERROR_NONE_RC -9201
// DBGP error: Parse error in command
#define DBGP_ERROR_PARSE_RC -9203
// DBGP error: Duplicate arguments in command
#define DBGP_ERROR_DUPLICATE_ARGS_RC -9204
// DBGP error: Invalid options
#define DBGP_ERROR_INVALID_OPTIONS_RC -9205
// DBGP error: Unimplemented command
#define DBGP_ERROR_UNIMPLEMENTED_RC -9206
// DBGP error: Command not available
#define DBGP_ERROR_COMMAND_NOT_AVAILABLE_RC -9207
// DBGP error: Can not open file
#define DBGP_ERROR_OPENING_FILE_RC -9208
// DBGP error: Stream redirect failed
#define DBGP_ERROR_STREAM_REDIRECT_FAILED_RC -9209
// DBGP error: Breakpoint could not be set
#define DBGP_ERROR_BREAKPOINT_NOT_SET_RC -9210
// DBGP error: Breakpoint type not supported
#define DBGP_ERROR_BREAKPOINT_NOT_SUPPORTED_RC -9211
// DBGP error: Invalid breakpoint
#define DBGP_ERROR_BREAKPOINT_INVALID_RC -9212
// DBGP error: No code on breakpoint line
#define DBGP_ERROR_BREAKPOINT_NO_CODE_RC -9213
// DBGP error: Invalid breakpoint state
#define DBGP_ERROR_BREAKPOINT_INVALID_STATE_RC -9214
// DBGP error: No such breakpoint
#define DBGP_ERROR_BREAKPOINT_NOT_EXIST_RC -9215
// DBGP error: Error evaluating code
#define DBGP_ERROR_EVAL_RC -9216
// DBGP error: Invalid expression
#define DBGP_ERROR_EXPR_RC -9217
// DBGP error: Can not get property
#define DBGP_ERROR_INVALID_PROPERTY_RC -9218
// DBGP error: Stack depth invalid
#define DBGP_ERROR_INVALID_STACK_DEPTH_RC -9219
// DBGP error: Context invalid
#define DBGP_ERROR_INVALID_CONTEXT_RC -9220
// DBGP error: Encoding not supported
#define DBGP_ERROR_ENCODING_NOT_SUPPORTED_RC -9221
// DBGP error: An internal exception in the debugger occurred
#define DBGP_ERROR_INTERNAL_EXCEPTION_RC -9222
// DBGP error: Unknown error
#define DBGP_ERROR_UNKNOWN_RC -9223
// reserved through 9300 for DBGP
#define DBGP_END_ERRORS -9300

///////////////////////////////////////////////////////////////////////////////
// MACRO
///////////////////////////////////////////////////////////////////////////////

// Command Line
#define VSRC_FCF_ELEMENTS_COMMAND_LINE -101100
// Status Line
#define VSRC_FCF_ELEMENTS_STATUS_LINE -101101
// SBCS/DBCS Source Windows
#define VSRC_FCF_ELEMENTS_SBCS_DBCS_SOURCE_WINDOWS -101102
// Hex Source Windows
#define VSRC_FCF_ELEMENTS_HEX_SOURCE_WINDOWS -101103
// Unicode Source Windows
#define VSRC_FCF_ELEMENTS_UNICODE_SOURCE_WINDOWS -101104
// File Manager Windows
#define VSRC_FCF_ELEMENTS_FILE_MANAGER_WINDOWS -101105
// Parameter Info
#define VSRC_FCF_ELEMENTS_PARAMETER_INFO -101106
// Parameter Info Fixed
#define VSRC_FCF_ELEMENTS_PARAMETER_INFO_FIXED -101107
// Selection List
#define VSRC_FCF_ELEMENTS_SELECTION_LIST -101108
// Menu
#define VSRC_FCF_ELEMENTS_MENU -101109
// Dialog
#define VSRC_FCF_ELEMENTS_DIALOG -101110
// MDI Child Icon
#define VSRC_FCF_ELEMENTS_MDI_CHILD_ICON -101111
// MDI Child Title
#define VSRC_FCF_ELEMENTS_MDI_CHILD_TITLE -101112
// Diff Editor Source Windows
#define VSRC_FCF_ELEMENTS_DIFF_EDITOR_WINDOWS -101113
// HTML Proportional
#define VSRC_FCF_ELEMENTS_MINIHTML_PROPORTIONAL -101114
// HTML Fixed
#define VSRC_FCF_ELEMENTS_MINIHTML_FIXED -101115
// Block Comment
#define VSRC_CFG_COMMENT -101120
// Current Line
#define VSRC_CFG_CURRENT_LINE -101121
// Cursor
#define VSRC_CFG_CURSOR -101122
// No Save Line
#define VSRC_CFG_NOSAVE_LINE -101123
// Inserted Line
#define VSRC_CFG_INSERTED_LINE -101124
// Keyword
#define VSRC_CFG_KEYWORD -101125
// Line Number
#define VSRC_CFG_LINE_NUMBER -101126
// Line Prefix Area
#define VSRC_CFG_LINE_PREFIX_AREA -101127
// Message
#define VSRC_CFG_MESSAGE -101128
// Modified Line
#define VSRC_CFG_MODIFIED_LINE -101129
// Number
#define VSRC_CFG_NUMBER -101130
// Preprocessor
#define VSRC_CFG_PREPROCESSOR -101131
// Selected Current Line
#define VSRC_CFG_SELECTED_CURRENT_LINE -101132
// Selection
#define VSRC_CFG_SELECTION -101133
// Status
#define VSRC_CFG_STATUS -101134
// String
#define VSRC_CFG_STRING -101135
// Window Text
#define VSRC_CFG_WINDOW_TEXT -101136
// Punctuation
#define VSRC_CFG_PUNCTUATION -101137
// Library Symbol
#define VSRC_CFG_LIBRARY_SYMBOL -101138
// Operator
#define VSRC_CFG_OPERATOR -101139
// User Defined Keyword
#define VSRC_CFG_USER_DEFINED_SYMBOL -101140
// Function
#define VSRC_CFG_FUNCTION -101141
// Filename
#define VSRC_CFG_FILENAME -101142
// Highlight
#define VSRC_CFG_HIGHLIGHT -101143
// Attribute
#define VSRC_CFG_ATTRIBUTE -101144
// Unknown Tag Name
#define VSRC_CFG_UNKNOWN_XML_ELEMENT -101145
// XHTML Element in XSL
#define VSRC_CFG_XHTML_ELEMENT_IN_XSL -101146
// Active Tool Window Caption
#define VSRC_CFG_ACTIVE_TOOL_WINDOW_CAPTION -101147
// Inactive Tool Window Caption
#define VSRC_CFG_INACTIVE_TOOL_WINDOW_CAPTION -101148
// Line Comment
#define VSRC_CFG_LINE_COMMENT -101149
// Unable to open system color scheme file.
#define VSRC_CFG_UNABLE_TO_OPEN_SYSTEM_COLOR_SCHEME -101150
// The current color scheme has been modified.  Are you sure you want to discard the changes?
#define VSRC_CFG_COLOR_SCHEME_MODIFIED -101151
// There is no active color scheme to rename.
#define VSRC_CFG_NO_ACTIVE_SCHEME_TO_RENAME -101152
// File %s0 not found.
#define VSRC_CFG_FILE_NOT_FOUND -101153
// Error reading %s0.
#define VSRC_CFG_ERROR_READING_FILE -101154
// Cannot find user scheme: %s0.  System schemes cannot be renamed.
#define VSRC_CFG_CANNOT_FIND_USER_SCHEME -101155
// Invalid scheme name.
#define VSRC_CFG_INVALID_SCHEME_NAME -101156
// A scheme with this name already exists.
#define VSRC_CFG_SCHEME_ALREADY_EXISTS -101157
// Unable to save file %s0.
#define VSRC_CFG_UNABLE_TO_SAVE -101158
// There is no active color scheme to remove.
#define VSRC_CFG_NO_ACTIVE_SCHEME_TO_REMOVE -101159
// Unable to remove scheme: %s0.  It does not exist.
#define VSRC_CFG_UNABLE_TO_REMOVE -101160
// System schemes cannot be removed.
#define VSRC_CFG_CANNOT_REMOVE_SYSTEM_SCHEMES -101161
// Are you sure you want to remove this scheme: %s0?
#define VSRC_CFG_REMOVE_SCHEME_CONFIRMATION -101162
// Rename Scheme
#define VSRC_CFG_RENAME_SCHEME -101163
// Rename To
#define VSRC_CFG_RENAME_TO -101164
// RGB values must be between 0 and 255.
#define VSRC_CFG_RGB_VALUES_RANGE_WARNING -101165
// Invalid color.  Unable to update sample.
#define VSRC_CFG_INVALID_COLOR -101166
// Please specify a name for the color scheme.
#define VSRC_CFG_SPECIFY_COLOR_SCHEME_NAME -101167
// Color scheme name is invalid.  Letters, numbers, and spaces are valid.
#define VSRC_CFG_INVALID_COLOR_SCHEME_NAME -101168
// You cannot overwrite the system color scheme, %s0.  Please choose another name.
#define VSRC_CFG_CANNOT_OVERWRITE_SYSTEM_SCHEME -101169
// Overwrite existing scheme, %s0?
#define VSRC_CFG_OVERWRITE_SCHEME_CONFIRMATION -101170
// The current color scheme is not considered compatible with the symbol coloring scheme.
// 
// Are you sure you want to switch schemes?
#define VSRC_CFG_COLOR_SCHEME_INCOMPATIBLE -101171
// Documentation Comment
#define VSRC_CFG_DOCUMENTATION_COMMENT -101172
// Documentation Keyword
#define VSRC_CFG_DOCUMENTATION_KEYWORD -101173
// Documentation Punctuation
#define VSRC_CFG_DOCUMENTATION_PUNCTUATION -101174
// Documentation Attribute
#define VSRC_CFG_DOCUMENTATION_ATTRIBUTE -101175
// Documentation Attribute Value
#define VSRC_CFG_DOCUMENTATION_ATTR_VALUE -101176
// Identifier
#define VSRC_CFG_IDENTIFIER -101177
// Floating Point Number
#define VSRC_CFG_FLOATING_NUMBER -101178
// Hexadecimal Number
#define VSRC_CFG_HEX_NUMBER -101179
// Single Quoted String
#define VSRC_CFG_SINGLE_QUOTED_STRING -101180
// Backquoted String
#define VSRC_CFG_BACKQUOTED_STRING -101181
// Unterminated String
#define VSRC_CFG_UNTERMINATED_STRING -101182
// Inactive Code
#define VSRC_CFG_INACTIVE_CODE -101183
// Inactive Code Keyword
#define VSRC_CFG_INACTIVE_KEYWORD -101184
// Modified Whitespace
#define VSRC_CFG_IMAGINARY_SPACE -101185
// Inactive Code Comment
#define VSRC_CFG_INACTIVE_COMMENT -101186
// Compiler Errors
#define VSRC_CFG_ERROR -101187
// Other
#define VSRC_FF_OTHER -101200
// Keyword
#define VSRC_FF_KEYWORD -101201
// Number
#define VSRC_FF_NUMBER -101202
// String
#define VSRC_FF_STRING -101203
// Comment
#define VSRC_FF_COMMENT -101204
// Preprocessing
#define VSRC_FF_PREPROCESSING -101205
// Line Number
#define VSRC_FF_LINE_NUMBER -101206
// Punctuation
#define VSRC_FF_SYMBOL1 -101207
// Lib Symbol
#define VSRC_FF_SYMBOL2 -101208
// Operator
#define VSRC_FF_SYMBOL3 -101209
// User Defined
#define VSRC_FF_SYMBOL4 -101210
// Function
#define VSRC_FF_FUNCTION -101211
// Attribute
#define VSRC_FF_ATTRIBUTE -101212
// not
#define VSRC_FF_NOT -101220
// Choose Directory
#define VSRC_FF_CHOOSE_DIRECTORY -101221
// Directory:
#define VSRC_FF_CURDIR_IS -101222
// %s0 of %s1 selected
#define VSRC_FF_OF_SELECTED -101223
// Sorry, cannot generate macro code for this operation.
#define VSRC_FF_CANNOT_GENERATE_MACRO -101225
// No files selected.
#define VSRC_FF_NO_FILES_SELECTED -101226
// Could not open workspace file: %s0.
// 
// %s1
#define VSRC_FF_COULD_NOT_OPEN_WORKSPACE_FILE -101227
// Invalid swtich.
#define VSRC_FF_INVALID_SWITCH -101228
// File not found: %s0
#define VSRC_FF_FILE_NOT_FOUND -101229
// No files selected.
// 
// Read only files can't be modified.
#define VSRC_FF_NO_FILES_SELECTED_READ_ONLY -101230
// The following lines were skipped to prevent line truncation:
// 
// 
#define VSRC_FF_FOLLOWING_LINES_SKIPPED -101231
// Invalid font size.
#define VSRC_FC_INVALID_FONT_SIZE -101250
// Currently we only allow the size for the Terminal font to be selected in pixel width X pixel height form.
#define VSRC_FC_TERMINAL_FONT_SIZE -101251
// Invalid font name.
#define VSRC_FC_INVALID_FONT_NAME -101252
// Existing child edit windows are not updated.
#define VSRC_FC_CHILD_WINDOWS_NOT_UPDATED -101253
// You must exit and restart SlickEdit for Dialog font changes to appear.
#define VSRC_FC_MUST_EXIT_AND_RESTART -101254
// Do you wish to change the editor font in all windows?
#define VSRC_FC_CHANGE_FONT_IN_ALL_WINDOWS -101255
// Western
#define VSRC_CHARSET_WESTERN -101275
// Default
#define VSRC_CHARSET_DEFAULT -101276
// Symbol
#define VSRC_CHARSET_SYMBOL -101277
// Shiftjis
#define VSRC_CHARSET_SHIFTJIS -101278
// Hanguel
#define VSRC_CHARSET_HANGEUL -101279
// GB2312
#define VSRC_CHARSET_GB2312 -101280
// Chinesebig5
#define VSRC_CHARSET_CHINESEBIG5 -101281
// OEM/DOS
#define VSRC_CHARSET_OEMDOS -101282
// Johab
#define VSRC_CHARSET_JOHAB -101283
// Hebrew
#define VSRC_CHARSET_HEBREW -101284
// Arabic
#define VSRC_CHARSET_ARABIC -101285
// Greek
#define VSRC_CHARSET_GREEK -101286
// Turkish
#define VSRC_CHARSET_TURKISH -101287
// Thai
#define VSRC_CHARSET_THAI -101288
// Central European
#define VSRC_CHARSET_CENTRALEUROPEAN -101289
// Cyrillic
#define VSRC_CHARSET_CYRILLIC -101290
// Mac
#define VSRC_CHARSET_MAC -101291
// Baltic
#define VSRC_CHARSET_BALTIC -101292
// Vietnamese
#define VSRC_CHARSET_VIETNAMESE -101293
// Once per day
#define VSRC_UPCHECK_INTERVAL_1DAY -101325
// Once per week
#define VSRC_UPCHECK_INTERVAL_1WEEK -101326
// Never
#define VSRC_UPCHECK_INTERVAL_NEVER -101327
// Custom
#define VSRC_UPCHECK_INTERVAL_CUSTOM -101328
// www.slickedit.com
#define VSRC_ABOUT_WEBSITE -101340
// 1 919.473.0100
#define VSRC_ABOUT_SUPPORT_PHONE -101341
// Serial number
#define VSRC_CAPTION_SERIAL_NUMBER -101343
// Licensed packages
#define VSRC_CAPTION_LICENSED_PACKAGES -101344
// Website
#define VSRC_CAPTION_WEBSITE -101345
// Technical Support Phone
#define VSRC_CAPTION_SUPPORT_PHONE -101346
// Technical Support Email
#define VSRC_CAPTION_SUPPORT_EMAIL -101347
// Expiration Date
#define VSRC_CAPTION_EXPIRATION_DATE -101348
// Emulation
#define VSRC_CAPTION_EMULATION -101348
// Installation Directory
#define VSRC_CAPTION_INSTALLATION_DIRECTORY -101349
// Configuration Directory
#define VSRC_CAPTION_CONFIGURATION_DIRECTORY -101350
// Configuration Drive Usage
#define VSRC_CAPTION_CONFIGURATION_DRIVE_USAGE -101351
// Spill File
#define VSRC_CAPTION_SPILL_FILE -101352
// Spill File Directory Drive Usage
#define VSRC_CAPTION_SPILL_FILE_DIRECTORY_DRIVE_USAGE -101353
// Build Date
#define VSRC_CAPTION_BUILD_DATE -101354
// OS
#define VSRC_CAPTION_OPERATING_SYSTEM -101355
// OS Version
#define VSRC_CAPTION_OPERATING_SYSTEM_VERSION -101356
// Version
#define VSRC_CAPTION_VERSION -101357
// Kernel Level
#define VSRC_CAPTION_KERNEL_LEVEL -101358
// Build Version
#define VSRC_CAPTION_BUILD_VERSION -101359
// X Server Vendor
#define VSRC_CAPTION_XSERVER_VENDOR -101360
// Load
#define VSRC_CAPTION_MEMORY_LOAD -101361
// Physical
#define VSRC_CAPTION_PHYSICAL_MEMORY_USAGE -101362
// Page File
#define VSRC_CAPTION_PAGE_FILE_USAGE -101363
// Virtual
#define VSRC_CAPTION_VIRTUAL_MEMORY_USAGE -101364
// Directory
#define VSRC_CAPTION_DIRECTORY -101365
// FLEXlm reported serial number
#define VSRC_CAPTION_FLEXLM_SERIAL_NUMBER -101366
// Special Characters
#define VSRC_CFG_SPECIALCHARS -101367
// Current Line Box
#define VSRC_CFG_CURRENT_LINE_BOX -101368
// Vertical Column Line
#define VSRC_CFG_VERTICAL_COL_LINE -101369
// Margin Column Line(s)
#define VSRC_CFG_MARGINS_COL_LINE -101370
// Truncation Column Line
#define VSRC_CFG_TRUNCATION_COL_LINE -101371
// Line Prefix Divider Line
#define VSRC_CFG_PREFIX_AREA_LINE -101372
// Block Matching
#define VSRC_CFG_BLOCK_MATCHING -101373
// Pushed Bookmark #
#define VSRC_PUSHED_BOOKMARK_NAME -101374
// Incremental Search Current Match
#define VSRC_CFG_INC_SEARCH_CURRENT -101375
// Incremental Search Highlight
#define VSRC_CFG_INC_SEARCH_MATCH -101376
// Hex Mode
#define VSRC_CFG_HEX_MODE_COLOR -101377
// Cursor Up/Down to surround lines of code. Hit Esc when done.
#define VSRC_DYNAMIC_SURROUND_MESSAGE -101378
// Can not move end up any further
#define VSRC_DYNAMIC_SURROUND_NO_MORE_UP -101379
// Can not move end down any further
#define VSRC_DYNAMIC_SURROUND_NO_MORE_DOWN -101380
// Licensed number of users
#define VSRC_CAPTION_NOFUSERS -101381
// Symbol Highlight
#define VSRC_CFG_SYMBOL_HIGHLIGHT -101382
// License expiration
#define VSRC_CAPTION_LICENSE_EXPIRATION -101383
// Licensed to
#define VSRC_CAPTION_LICENSE_TO -101384
// Modified file
#define VSRC_CFG_MODIFIED_FILE_TAB -101385
// License file
#define VSRC_CAPTION_LICENSE_FILE -101386
// Memory
#define VSRC_CAPTION_MEMORY -101387
// Modified variable
#define VSRC_CFG_MODIFIED_ITEM -101388
// Project Type
#define VSRC_CAPTION_CURRENT_PROJECT_TYPE -101389
// Language
#define VSRC_CAPTION_CURRENT_LANGUAGE -101390
// Screen Size
#define VSRC_CAPTION_SCREEN_RESOLUTION -101391
// Shell Info
#define VSRC_CAPTION_SHELL_INFO -101392
// Processor Architecture
#define VSRC_CAPTION_PROCESSOR_ARCH -101393
// License server
#define VSRC_CAPTION_LICENSE_SERVER -101394
// Borrow expiration
#define VSRC_CAPTION_LICENSE_BORROW_EXPIRATION -101395
// Selections
#define VSRC_COLOR_CATEGORY_EDITOR_CURSOR -101400
// General
#define VSRC_COLOR_CATEGORY_EDITOR_TEXT -101401
// Application colors
#define VSRC_COLOR_CATEGORY_MISC -101402
// Modifications
#define VSRC_COLOR_CATEGORY_DIFF -101403
// Highlighting
#define VSRC_COLOR_CATEGORY_HIGHLIGHTS -101404
// HTML and XML
#define VSRC_COLOR_CATEGORY_XML -101405
// Margins
#define VSRC_COLOR_CATEGORY_EDITOR_COLUMNS -101406
// Comments
#define VSRC_COLOR_CATEGORY_COMMENTS -101407
// Strings
#define VSRC_COLOR_CATEGORY_STRINGS -101408
// Numbers
#define VSRC_COLOR_CATEGORY_NUMBERS -101409
// Selection color is used for all selections in the editor windows.  Selections use the foreground color of underlying color coded text if visible against the selected background color.
#define VSRC_CFG_SELECTION_DESCRIPTION -101410
// This is the default color for all text which is not color coded otherwise.  Window text is the master color that other colors are allowed to inherit their background color from.
#define VSRC_CFG_WINDOW_TEXT_DESCRIPTION -101411
// Current Line color is used for the line under the cursor.  If the foreground color of text is visible against the Current Line background color, they are used together.  Otherwise, the Current Line foreground and background colors are used.  Current Line coloring can be enabled on per-language basis in the language “View” options.
#define VSRC_CFG_CURRENT_LINE_DESCRIPTION -101412
// Selected current line color is used for the current line under the cursor within a selection.  This color uses the foreground color of underlying color coded text if visible against the selected background color.
#define VSRC_CFG_SELECTED_CURRENT_LINE_DESCRIPTION -101413
// The message color is used for messages that appear on the SlickEdit message bar at the bottom of the window.  Typically it simply uses the system default color.
#define VSRC_CFG_MESSAGE_DESCRIPTION -101414
// The status color is used for text in the SlickEdit status bar at the bottom of the window.  Typically it simply uses the system default color.
#define VSRC_CFG_STATUS_DESCRIPTION -101415
// Cursor color is used for the character under the cursor when focus is away from the editor window or when in overstrike mode.
#define VSRC_CFG_CURSOR_DESCRIPTION -101416
// Modified line color is used in the left margin of editor windows for modified lines.  This color is only used if modified line coloring is enabled for the current language.  Modified line color is also used to color text in diff.
#define VSRC_CFG_MODIFIED_LINE_DESCRIPTION -101417
// Inserted line color is used in the left margin of editor windows for newly inserted lines.    This color is only used if modified line coloring is enabled for the current language.  Inserted line color is also used in diff to highlight lines which have been inserted.
#define VSRC_CFG_INSERTED_LINE_DESCRIPTION -101418
// Keyword color is used to highlight language specific keywords.
#define VSRC_CFG_KEYWORD_DESCRIPTION -101419
// Line number color is used for coloring line numbers in languages that require line numbers.  It should not be confused with View > Line Numbers, which displays line numbers in the editor margin.
#define VSRC_CFG_LINE_NUMBER_DESCRIPTION -101420
// Number color is used for language specific integer constants.
#define VSRC_CFG_NUMBER_DESCRIPTION -101421
// String color is used for language specific string literals.  It can also be used for here documents in certain languages and quoted attribute values in HTML/XML markup languages.
#define VSRC_CFG_STRING_DESCRIPTION -101422
// Block comment color is used for language specific block comments.
#define VSRC_CFG_COMMENT_DESCRIPTION -101423
// Preprocessor color is used for language specific preprocessor keywords.
#define VSRC_CFG_PREPROCESSOR_DESCRIPTION -101424
// Punctuation color us used for language specific punctuation symbols, such as braces in C/C++.
#define VSRC_CFG_PUNCTUATION_DESCRIPTION -101425
// Library color is used for language intrinsics and very common standard language library functions, such as strcmp() in C.
#define VSRC_CFG_LIBRARY_SYMBOL_DESCRIPTION -101426
// Operator color is used for language specific mathematical and logical operators.
#define VSRC_CFG_OPERATOR_DESCRIPTION -101427
// User defined keyword color is used for additional language specific keywords or symbols the user configures to have color coded.
#define VSRC_CFG_USER_DEFINED_SYMBOL_DESCRIPTION -101428
// No save (imaginary) line color is used for lines that are inserted in an editor window which will not be saved to the file.  No save lines are also used in diff.
#define VSRC_CFG_NOSAVE_LINE_DESCRIPTION -101429
// Function color is used to highlight identifiers which appear to be function names by virtue of being followed by a parenthesis.
#define VSRC_CFG_FUNCTION_DESCRIPTION -101430
// The line prefix area color is used for the right margin of the editor window.  This is the color used for line numbers when using View > Line Numbers.
#define VSRC_CFG_LINE_PREFIX_AREA_DESCRIPTION -101431
// The filename color is used to highlight file names in the Search Results tool window.
#define VSRC_CFG_FILENAME_DESCRIPTION -101432
// The highlight color is used to highlight string matches in the Search Results tool window.
#define VSRC_CFG_HIGHLIGHT_DESCRIPTION -101433
// The attribute color is used to highlight tag attribute names in HTML and XML.
#define VSRC_CFG_ATTRIBUTE_DESCRIPTION -101434
// The unknown XML element color is used to highlight XML tags which are not defined in the current document type definition or schema.
#define VSRC_CFG_UNKNOWN_XML_ELEMENT_DESCRIPTION -101435
// This color is used to highlight an XHTML element in an XSL style sheet.
#define VSRC_CFG_XHTML_ELEMENT_IN_XSL_DESCRIPTION -101436
// Special characters color is used to display special characters, such as spaces, tab characters and line endings when the view options are enabled to display those characters.
#define VSRC_CFG_SPECIALCHARS_DESCRIPTION -101437
// The current line box color is used when you have draw box around current line enabled.
#define VSRC_CFG_CURRENT_LINE_BOX_DESCRIPTION -101438
// The vertical line column color is used for drawing a vertical line at a designated marker column.  This is only drawn when the vertical line column is enabled and the editor font is a fixed width font.
#define VSRC_CFG_VERTICAL_COL_LINE_DESCRIPTION -101439
// The margins column line color is used to display the current soft-wrap margin settings when soft-wrap is enabled.  If you never want to see the margin column lines, set this color to the same as your Window Text background color.
#define VSRC_CFG_MARGINS_COL_LINE_DESCRIPTION -101440
// The truncation column line color is used for drawing the truncation column line when line truncation is enabled for the current language.
#define VSRC_CFG_TRUNCATION_COL_LINE_DESCRIPTION -101441
// The prefix area line color is the color of the vertical line which divides the left editor margin (gutter) from the editor text area.
#define VSRC_CFG_PREFIX_AREA_LINE_DESCRIPTION -101442
// The block matching color is used to highlight matching parentheses, braces, or begin/end keyword pairs for the item under the cursor.
#define VSRC_CFG_BLOCK_MATCHING_DESCRIPTION -101443
// This color is used to highlight the current incremental search match under the cursor.
#define VSRC_CFG_INC_SEARCH_CURRENT_DESCRIPTION -101444
// This color is used to highlight other incremental search matches in the current file.
#define VSRC_CFG_INC_SEARCH_MATCH_DESCRIPTION -101445
// This color is used for hex editing mode.
#define VSRC_CFG_HEX_MODE_COLOR_DESCRIPTION -101446
// This color is used to highlight other references to the symbol under the cursor.  This color is only used if highlight matching symbols is enabled for the current language.
#define VSRC_CFG_SYMBOL_HIGHLIGHT_DESCRIPTION -101447
// This color is used to highlight modified files in the File Tabs tool window and the Files tool window.
#define VSRC_CFG_MODIFIED_FILE_TAB_DESCRIPTION -101448
// Line comment color is used for language specific line comments.
#define VSRC_CFG_LINE_COMMENT_DESCRIPTION -101449
// Documentation comment color is used for language specific documentation comments.
#define VSRC_CFG_DOC_COMMENT_DESCRIPTION -101450
// This color is used for keywords and tags in language specific documentation comments.
#define VSRC_CFG_DOCUMENTATION_KEYWORD_DESCRIPTION -101451
// This color is used for punctuation in language specific documentation comments.
#define VSRC_CFG_DOCUMENTATION_PUNCTUATION_DESCRIPTION -101452
// This color is used for tag attribute names in language specific documentation comments with XML or HTML markup.
#define VSRC_CFG_DOCUMENTATION_ATTRIBUTE_DESCRIPTION -101453
// This color is used for tag attribute values in language specific documentation comments with XML or HTML markup.
#define VSRC_CFG_DOCUMENTATION_ATTR_VALUE_DESCRIPTION -101454
// Floating point number color is used for language specific floating point numeric constants.
#define VSRC_CFG_FLOATING_NUMBER_DESCRIPTION -101455
// Hexadecimal number color is used for language specific integer and floating point numeric constants written in hexadecimal notation.
#define VSRC_CFG_HEX_NUMBER_DESCRIPTION -101456
// Single quoted string color is used for language specific character and string literals.
#define VSRC_CFG_SINGLE_QUOTED_STRING_DESCRIPTION -101457
// Backquoted striing color is used for language specific string literals using backwards single quotes, such as are used in shell scripts.
#define VSRC_CFG_BACKQUOTED_STRING_DESCRIPTION -101458
// Unterminated string color is used at the end of a line that has a string literal which is missing its closing quote.
#define VSRC_CFG_UNTERMINATED_STRING_DESCRIPTION -101459
// Identifier color is used for symbols which match the language specific identifier characters.
#define VSRC_CFG_IDENTIFIER_DESCRIPTION -101460
// This color is used for code which is preprocessed out, such as #if 0 blocks.
#define VSRC_CFG_INACTIVE_CODE_DESCRIPTION -101461
// This color is used for keywords in code which is preprocessed out, such as #if 0 blocks.
#define VSRC_CFG_INACTIVE_KEYWORD_DESCRIPTION -101462
// Imaginary space is used in the difference editor to display whitespace which is inserted in order to balance the whitespace between the current document and the one it is being compared to.
#define VSRC_CFG_IMAGINARY_SPACE_DESCRIPTION -101463
// This color is used for comments in code which is preprocessed out, such as #if 0 blocks.
#define VSRC_CFG_INACTIVE_COMMENT_DESCRIPTION -101464
// This color is used to highlight variables or watches in the debugger windows which changed while stepping through code.
#define VSRC_CFG_MODIFIED_ITEM_DESCRIPTION -101465
// Navigation Hint
#define VSRC_CFG_NAVHINT -101466
// This color is used for navigation hints.  Navigation hints appear in the editor window and indicate the location you will be taken.
#define VSRC_CFG_NAVHINT_DESCRIPTION -101467
// XML/HTML numeric character reference
#define VSRC_CFG_XML_CHARACTER_REF -101468
// This color is used for XML/HTML numeric character references &#nnnn; (decimal) or &#xhhhh; (hexadecimal).
#define VSRC_CFG_XML_CHARACTER_REF_DESCRIPTION -101469
// File list: loading...
#define VSRC_CFG_TAG_FILES_LOADING -101470
// File list: no tag file selected
#define VSRC_CFG_TAG_FILES_NONE -101471
// File list:  %s0 files.  Tag file size: %s1
#define VSRC_CFG_TAG_FILES_COUNT -101472
// This color is used to mark the position of compiler errors on the vertical scrollbar.
#define VSRC_CFG_ERROR_DESCRIPTION -101473
// Locals
#define VSRC_CODEHELP_TITLE_LOCALS -101475
// Members
#define VSRC_CODEHELP_TITLE_MEMBERS -101476
// Imports
#define VSRC_CODEHELP_TITLE_IMPORTS -101477
// Static Imports
#define VSRC_CODEHELP_TITLE_STATICS -101478
// Current Buffer
#define VSRC_CODEHELP_TITLE_BUFFER -101479
// Globals
#define VSRC_CODEHELP_TITLE_GLOBALS -101480
// Packages
#define VSRC_CODEHELP_TITLE_PACKAGES -101481
// Classes
#define VSRC_CODEHELP_TITLE_CLASSES -101482
// Properties
#define VSRC_CODEHELP_TITLE_PROPS -101483
// Builtins
#define VSRC_CODEHELP_TITLE_BUILTINS -101484
// Parameters
#define VSRC_CODEHELP_TITLE_PARAMS -101485
// Controls
#define VSRC_CODEHELP_TITLE_CONTROLS -101486
// Keywords
#define VSRC_CODEHELP_TITLE_KEYWORDS -101487
// Functions
#define VSRC_CODEHELP_TITLE_FUNCTIONS -101488
// Procedures
#define VSRC_CODEHELP_TITLE_PROCEDURES -101489
// Variables
#define VSRC_CODEHELP_TITLE_VARIABLES -101490
// Defines
#define VSRC_CODEHELP_TITLE_DEFINES -101491
// Expressions
#define VSRC_CODEHELP_TITLE_EXPRS -101492
// Search Result Truncated
#define VSRC_CFG_SEARCH_RESULT_TRUNCATED -101493
// This color is used in the Search Results tool window to highlight leading and/or trailing part of search result line is truncated.
#define VSRC_CFG_SEARCH_RESULT_TRUNCATED_DESCRIPTION -101494

///////////////////////////////////////////////////////////////////////////////
// SCC
///////////////////////////////////////////////////////////////////////////////

// VSSCC_ERROR_COULD_NOT_FIND_INSTALLED_PROVIDER_KEY_RC
#define VSSCC_ERROR_COULD_NOT_FIND_INSTALLED_PROVIDER_KEY_RC -102000
// VSSCC_ERROR_COULD_NOT_FIND_SPECIFIC_PROVIDER_KEY_RC
#define VSSCC_ERROR_COULD_NOT_FIND_SPECIFIC_PROVIDER_KEY_RC -102001
// VSSCC_ERROR_COULD_NOT_FIND_SCCSERVERPATH_RC
#define VSSCC_ERROR_COULD_NOT_FIND_SCCSERVERPATH_RC -102002
// VSSCC_ERROR_COULD_NOT_LOAD_LIBRARY_RC
#define VSSCC_ERROR_COULD_NOT_LOAD_LIBRARY_RC -102003
// VSSCC_ERROR_INIT_FAILED_RC
#define VSSCC_ERROR_INIT_FAILED_RC -102004
// VSSCC_ERROR_OPTION_NOT_SUPPORTED_RC
#define VSSCC_ERROR_OPTION_NOT_SUPPORTED_RC -102005
// The SCC provider you have configured is 32-bit and cannot be loaded by the 64-bit version of SlickEdit.  If you wish to use this system, you should use the 32-bit version of SlickEdit.
// 
// Some 64-bit version control systems still have 32-bit SCC provider DLLs.
#define VSSCC_ERROR_MAY_BE_32_BIT_DLL_RC -102008
// %s0 32-bit SCC systems are installed. These cannot be used by the 64-bit version of SlickEdit.  You may wish to try using the 32-bit version of SlickEdit.
// 
// Some 64-bit version control systems still have 32-bit SCC provider DLLs.
#define VSSCC_WARN_ABOUT_32_BIT_SCC_SYSTEMS_RC -102009
// Initialize failed
#define VSSCC_E_INITIALIZEFAILED_RC -102020
// Unknown project
#define VSSCC_E_UNKNOWNPROJECT_RC -102021
// Could not create project
#define VSSCC_E_COULDNOTCREATEPROJECT_RC -102022
// Not checked out
#define VSSCC_E_NOTCHECKEDOUT_RC -102023
// Already checked out
#define VSSCC_E_ALREADYCHECKEDOUT_RC -102024
// File is locked
#define VSSCC_E_FILEISLOCKED_RC -102025
// File checked out exclusive
#define VSSCC_E_FILEOUTEXCLUSIVE_RC -102026
// Access failure
#define VSSCC_E_ACCESSFAILURE_RC -102027
// Checkin conflict
#define VSSCC_E_CHECKINCONFLICT_RC -102028
// File already exists
#define VSSCC_E_FILEALREADYEXISTS_RC -102029
// File not controlled
#define VSSCC_E_FILENOTCONTROLLED_RC -102030
// File is checked out
#define VSSCC_E_FILEISCHECKEDOUT_RC -102031
// No specified version
#define VSSCC_E_NOSPECIFIEDVERSION_RC -102032
// Opereation not supported
#define VSSCC_E_OPNOTSUPPORTED_RC -102033
// The version control system returned a non specific error code
#define VSSCC_E_NONSPECIFICERROR_RC -102034
// Operation not performed
#define VSSCC_E_OPNOTPERFORMED_RC -102035
// Type not supported
#define VSSCC_E_TYPENOTSUPPORTED_RC -102036
// Verify Merge
#define VSSCC_E_VERIFYMERGE_RC -102037
// Fix Merge
#define VSSCC_E_FIXMERGE_RC -102038
// Shell failure
#define VSSCC_E_SHELLFAILURE_RC -102039
// Invalid user
#define VSSCC_E_INVALIDUSER_RC -102040
// Project already open
#define VSSCC_E_PROJECTALREADYOPEN_RC -102041
// Project syntax error
#define VSSCC_E_PROJSYNTAXERR_RC -102042
// Invalid file path
#define VSSCC_E_INVALIDFILEPATH_RC -102043
// Project not open
#define VSSCC_E_PROJNOTOPEN_RC -102044
// Not authorized
#define VSSCC_E_NOTAUTHORIZED_RC -102045
// File syntax error
#define VSSCC_E_FILESYNTAXERR_RC -102046
// File does not exist
#define VSSCC_E_FILENOTEXIST_RC -102047

///////////////////////////////////////////////////////////////////////////////
// OEM
///////////////////////////////////////////////////////////////////////////////


#endif
