// The flash.desktop package contains classes used for copy-and-paste and drag-and-drop operations, as well as the Icon class, used to define system icons used by a file.
package flash.desktop {
    // The Clipboard class provides a container for transferring data and objects through the clipboard and through drag-and-drop operations (AIR only).
    public class Clipboard extends Object {
        // [read-only] An array of strings containing the names of the data formats available in this Clipboard object
        public var formats:Array;
        // [static] [read-only] The operating system clipboard
        public static var generalClipboard:Clipboard;
        // Creates an empty Clipboar object
        public function Clipboard(){}
        // Deletes all data representations from this Clipboard object.
        public function clear():void{}
        // Deletes the data representation for the specified format.
        public function clearData(format:String):void{}
        // Gets the clipboard data if data in the specified format is present.
        public function getData(format:String, transferMode:String = "originalPreferred"):Object{}
        // Checks whether data in the specified format exists in this Clipboard object.
        public function hasFormat(format:String):Boolean{}
        // Adds a representation of the information to be transferred in the specified data format.
        public function setData(format:String, data:Object, serializable:Boolean = true):Boolean{}
        // Adds a reference to a handler function that produces the data for the specified format on demand.
        public function setDataHandler(format:String, handler:Function, serializable:Boolean = true):Boolean{}
    }
    // Defines constants for the names of the standard data formats used with the Clipboard class. 
    public class ClipboardFormats extends Object {
        public static const BITMAP_FORMAT:String = "air:bitmap";
        public static const FILE_LIST_FORMAT:String = "air:file list";
        public static const HTML_FORMAT:String = "air:html";
        public static const RICH_TEXT_FORMAT:String = "air:rtf";
        public static const TEXT_FORMAT:String = "air:text";
        public static const URL_FORMAT:String = "air:url";    
    }
    // Defines constants for the modes used as values of the transferMode parameter of the Clipboard.getData() method
    public class ClipboardTransferMode extends Object {
        public static const CLONE_ONLY:String = "cloneOnly";
        public static const CLONE_PREFERRED:String = "clonePreferred";
        public static const ORIGINAL_ONLY:String = "originalOnly";
        public static const ORIGINAL_PREFERRED:String = "originalPreferred";
    }
    // The Icon class represents an operating system icon.
    public class Icon extends EventDispatcher {
        // [read-write] The icon image as an array of BitmapData objects of different sizes.
        public var bitmaps:Array;
    }
    
    // InteractiveIcon is the abstract base class for the operating system icons associated with applications.
    public class InteractiveIcon extends Icon {
        // [read-write] The icon image as an array of BitmapData objects of different sizes.
        public var bitmaps:Array;
        // [read-only] The current display height of the icon in pixels
        public var height:int;
        // [read-only] The current display width of the icon in pixels
        public var width:int;
    }

    // The DockIcon class represents the MacOS X¨-style dock icon.
    public class DockIcon extends InteractiveIcon {
        // [read-write] The icon image as an array of BitmapData objects of different sizes.
        public var bitmaps:Array;
        // [read-only] The current display height of the icon in pixels
        public var height:int;
        // [read-only] The current display width of the icon in pixels
        public var width:int;
        // [read-write] The system-supplied menu of this dock icon
        public var menu:NativeMenu;
        // Notifies the user that an event has occurred that may require attention.
        public function bounce(priority:String = "informational"):void{}

    }

    // The SystemTrayIcon class represents the Windows taskbar¨ notification area (system tray)-style icon.
    public class SystemTrayIcon extends InteractiveIcon {
        // [read-write] The icon image as an array of BitmapData objects of different sizes.
        public var bitmaps:Array;
        // [read-only] The current display height of the icon in pixels
        public var height:int;
        // [read-only] The current display width of the icon in pixels
        public var width:int;
        // [read-write] The system-supplied menu of this dock icon
        public var menu:NativeMenu;
        // The tooltip that pops up for the system tray icon.
        public var tooltip : String;
        // The permitted length of the system tray icon tooltip.
        public static const MAX_TIP_LENGTH:Number = 63;
    }

    // The NativeApplication class represents this AIR application.
    public final class NativeApplication extends EventDispatcher {
        // [read-only] The active application window.
        public var activeWindow : NativeWindow;
        // [read-only] The contents of the application descriptor file for this AIR application.
        public var applicationDescriptor : XML;
        // [read-only] The application ID of this application.
        public var applicationID : String;
        // Specifies whether the application should automatically terminate when all windows have been closed.
        public var autoExit : Boolean;
        // [read-only] The application icon.
        public var icon : InteractiveIcon;
        // The number of seconds that must elapse without keyboard or mouse input before a userIdle event is dispatched.
        public var idleThreshold : int;
        // The application menu.
        public var menu : NativeMenu;
        // [static] [read-only] The singleton instance of the NativeApplication object.
        public static var nativeApplication : NativeApplication;
        // [read-only] An array containing all the open native windows of this application.
        public var openedWindows : Array;
        // [read-only] The publisher ID of this application.
        public var publisherID : String;
        // [read-only] The patch level of the runtime hosting this application.
        public var runtimePatchLevel : uint;
        // [read-only] The version number of the runtime hosting this application.
        public var runtimeVersion : String;
        // Specifies whether this application is automatically launched whenever the current user logs in
        public var startAtLogin : Boolean;
        // [static] [read-only] Indicates whether AIR supports application dock icons on the current operating system.
        public static var supportsDockIcon : Boolean;
        // [static] [read-only] Specifies whether the current operating system supports a global application menu bar.
        public static var supportsMenu : Boolean;
        // [static] [read-only] Specifies whether AIR supports system tray icons on the current operating system.
        public static var supportsSystemTrayIcon : Boolean;
        // [read-only] The time, in seconds, since the last mouse or keyboard input.
        public var timeSinceLastUserInput : int;
        // Activates this application
        public function activate(window:NativeWindow = null):void{}
        // Registers an event listener object with an EventDispatcher object so that the listener receives notification of an event.
        override public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void{}
        // Invokes an internal delete command on the focused display object
        public function clear():Boolean{}
        // Invokes an internal copy command on the focused display object.
        public function copy():Boolean{}
        // Invokes an internal cut command on the focused display object.
        public function cut():Boolean{}
        // Dispatches an event into the event flow.
        // The event target is the EventDispatcher object upon which the dispatchEvent() method is called.
        override public function dispatchEvent(event:Event):Boolean{}
        // Terminates this application
        public function exit(errorCode:int = 0):void{}
        // Gets the default application for opening files with the specified extension
        public function getDefaultApplication(extension:String):String{}
        // Specifies whether this application is currently the default application for opening files with the specified extension
        public function isSetAsDefaultApplication(extension:String):Boolean{}
        // Invokes an internal paste command on the focused display object.
        public function paste():Boolean{}
        // Removes this application as the default for opening files with the specified extension.
        public function removeAsDefaultApplication(extension:String):void{}
        // Removes a listener from the EventDispatcher object.
        override public function removeEventListener(type:String, listener:Function, useCapture:Boolean = false):void{}
        // Invokes an internal selectAll command on the focused display object.
        public function selectAll():Boolean{}
        // Sets this application as the default application for opening files with the specified extension.
        public function setAsDefaultApplication(extension:String):void{}
    }

    // Defines string constants for the names of the drag-and-drop actions.
    public class NativeDragActions extends Object {
        public static const COPY:String = "copy";
        public static const LINK:String = "link";
        public static const MOVE:String = "move";
        public static const NONE:String = "none";
    }

    // Specifies which drag-and-drop actions are allowed by the source of a drag operation.
    public class NativeDragOptions extends Object {
        // A drop target is allowed to copy the dragged data.
        public var allowCopy:Boolean = true;
        // A drop target is allowed to create a link to the dragged data.
        public var allowLink:Boolean = true;
        // A drop target is allowed to move the dragged data.
        public var allowMove:Boolean = true;
        // Returns the string representation of the specified object
        public function toString():String{}
    }

    // The NativeDragManager class coordinates drag-and-drop operations.
    public class NativeDragManager extends Object {
        // [static] [read-only] The interactive object passed to the NativeDragManager.doDrag() call that initiated the drag operation.
        public static var dragInitiator : InteractiveObject;
        // [static] The drag action specified by the drop target.
        public static var dropAction : String;
        // [static] [read-only] Reports whether a drag operation is currently in progress.
        public static var isDragging : Boolean;
        // Informs the NativeDragManager object that the specified target interactive object can accept a drop corresponding to the current drag event.
        public static function acceptDragDrop(target:InteractiveObject):void{}
        // Starts a drag-and-drop operation.
        public static function doDrag(dragInitiator:InteractiveObject, clipboard:Clipboard, dragImage:BitmapData = null, offset:Point = null, allowedActions:NativeDragOptions = null):void{}
    }

    // The NotificationType class defines constants for use in the priority parameter of the DockIcon bounce() method and the type parameter of the NativeWindow notifyUser() method.
    public final class NotificationType extends Object {
        // Specifies that a notification alert is critical in nature and the user should attend to it promptly.
        public static const CRITICAL:String = "critical";
        // Specifies that a notification alert is informational in nature and the user can safely ignore it.
        public static const INFORMATIONAL:String = "informational";
    }

    // The Updater class is used to update the currently running application with a different version.
    public final class Updater extends Object {
        // The constructor function for the Updater class
        public function Updater(){}
        // Updates the currently running application with the version of the application contained in the specified AIR file.
        public function update(airFile:File, version:String):void{}
    }
    
}
