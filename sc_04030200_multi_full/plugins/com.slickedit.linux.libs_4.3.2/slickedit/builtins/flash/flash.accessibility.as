// The flash.accessibility package contains classes for supporting accessibility in Flash content and applications.
package flash.accessibility
{
    // The Accessibility class manages communication with screen readers.
    public final class Accessibility {
        // [read only] ndicates whether a screen reader is currently active and the player is communicating with it.
        public var active:Boolean;
        // Tells Flash Player to apply any accessibility changes made by using the DisplayObject.accessibilityProperties property.
        public static function updateProperties():void{}
    }

    // The AccessibilityProperties class lets you control the presentation of
    // Flash objects to accessibility aids, such as screen readers.
    public class AccessibilityProperties {
        // Provides a description for this display object in the accessible presentation.
        public var description:String;
        // If true, causes Flash Player to exclude child objects within this display object from the accessible presentation.
        // The default is false.
        public var forceSimple:Boolean;
        // Provides a name for this display object in the accessible presentation.
        // Applies to whole SWF files, containers, buttons, and text.
        public var name:String;
        // If true, disables the Flash Player default auto-labeling system.
        public var noAutoLabeling:Boolean;
        // Indicates a keyboard shortcut associated with this display object.
        public var shortcut:String;
        // If true, excludes this display object from accessible presentation.
        public var silent:Boolean;
        // Creates a new AccessibilityProperties object.
        public function AccessibilityProperties(){}
    }
}
