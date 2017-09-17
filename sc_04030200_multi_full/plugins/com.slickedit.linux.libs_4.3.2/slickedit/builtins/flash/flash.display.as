// The flash.display package contains the core classes that the Flash Player uses to build visual displays.
package flash.display {
    // The ActionScriptVersion class is an enumeration of constant values that indicate the language version of a loaded SWF file
    public final class ActionScriptVersion {
        public static const ACTIONSCRIPT2:uint = 2;
        public static const ACTIONSCRIPT3:uint = 3;
    }
    // The DisplayObject class is the base class for all objects that can be placed on the display list.
    public class DisplayObject extends EventDispatcher{
        // The current accessibility options for this display object.
        public var accessibilityProperties:AccessibilityProperties;
        // Indicates the alpha transparency value of the object specified
        public var alpha:Number;
        // A value from the BlendMode class that specifies which blend mode to use
        public var blendMode:String;
        // Sets a shader that is used for blending the foreground and background.
        public var blendShader:Shader;
        // If set to true, Flash Player or Adobe AIR caches an internal bitmap representation of the display object
        public var cacheAsBitmap:Boolean;
        // An indexed array that contains each filter object currently associated with the display object
        public var filters:Array;
        // Indicates the height of the display object, in pixels.
        public var height:Number;
        // [read only] Returns a LoaderInfo object containing information about loading the
        // file to which this display object belongs
        public var loaderInfo:LoaderInfo;
        // The calling display object is masked by the specified mask object.
        public var mask:DisplayObject;
        // Indicates the x coordinate of the mouse position, in pixels.
        public var mouseX:Number;
        // [read only] Indicates the y coordinate of the mouse position, in pixels.
        public var mouseY:Number;
        // [read only] Indicates the instance name of the DisplayObject.
        public var name:String;
        // Specifies whether the display object is opaque with a certain background color
        public var opaqueBackground:Object;
        // [read only] Indicates the DisplayObjectContainer object that contains this display object.
        public var parent:DisplayObjectContainer;
        // [read only] For a display object in a loaded SWF file, the root property is the top-most display object in the
        // portion of the display list's tree structure represented by that SWF file.
        public var root:DisplayObject;
        // Indicates the rotation of the DisplayObject instance, in degrees, from its original orientation
        public var rotation:Number;
        // Indicates the x-axis rotation of the DisplayObject instance, in degrees,
        // from its original orientation relative to the 3D parent container.
        public var rotationX:Number;
        // Indicates the y-axis rotation of the DisplayObject instance, in degrees,
        // from its original orientation relative to the 3D parent container.
        public var rotationY:Number;
        // Indicates the z-axis rotation of the DisplayObject instance, in degrees,
        // from its original orientation relative to the 3D parent container.
        public var rotationZ:Number;
        // The current scaling grid that is in effect.
        public var scale9Grid:Rectangle;
        // Indicates the horizontal scale (percentage) of the object as applied from the registration point. 
        public var scaleX:Number;
        // Indicates the vertical scale (percentage) of the object as applied from the registration point. 
        public var scaleY:Number;
        // Indicates the depth scale (percentage) of the object as applied from the registration point. 
        public var scaleZ:Number;
        // The scroll rectangle bounds of the display object
        public var scrollRect:Rectangle;
        // The Stage of the display object. 
        public var stage:Stage;
        // An object with properties pertaining to a display object's matrix, color transform, and pixel bounds. 
        public var transform:Transform;
        // Whether or not the display object is visible
        public var visible:Boolean;
        // Indicates the width of the display object, in pixels.
        public var width:Number;
        // Indicates the x coordinate of the DisplayObject instance relative
        // to the local coordinates of the parent DisplayObjectContainer.
        public var x:Number;
        // Indicates the y coordinate of the DisplayObject instance relative
        // to the local coordinates of the parent DisplayObjectContainer.
        public var y:Number;
        // Indicates the z coordinate along the z-axis of the DisplayObject instance relative to the 3D parent container.
        public var z:Number;
        // Returns a rectangle that defines the area of the display object relative to the coordinate system of the targetCoordinateSpace object.
        public function getBounds(targetCoordinateSpace:DisplayObject):Rectangle{}
        // Returns a rectangle that defines the boundary of the display object, based on the coordinate system
        // defined by the targetCoordinateSpace parameter, excluding any strokes on shapes.
        public function getRect(targetCoordinateSpace:DisplayObject):Rectangle{}
        // Converts the point object from the Stage (global) coordinates to the display object's (local) coordinates.
        public function globalToLocal(point:Point):Point{}
        // Converts a two-dimensional point from the Stage (global) coordinates to a three-dimensional
        // display object's (local) coordinates.
        public function globalToLocal3D(point:Point):Vector3D{}
        // Evaluates the display object to see if it overlaps or intersects with the obj display object.
        public function hitTestObject(obj:DisplayObject):Boolean{}
        // Evaluates the display object to see if it overlaps or intersects with the
        // point specified by the x and y parameters.
        public function hitTestPoint(x:Number, y:Number, shapeFlag:Boolean = false):Boolean{}
        // Converts a three-dimensional point of the three-dimensional display object's (local)
        // coordinates to a two-dimensional point in the Stage (global) coordinates.
        public function local3DToGlobal(point3d:Vector3D):Point{}
        // Converts the point object from the display object's (local) coordinates to the Stage (global) coordinates.
        public function localToGlobal(point:Point):Point{}

    }
    // AVM1Movie is a simple class that represents AVM1 movie clips, which use ActionScript 1.0 or 2.0
    public class AVM1Movie extends DisplayObject {
        
    }
    // The BitmapData class lets you work with the data (pixels) of a Bitmap object 
    public class BitmapData extends Object {
        // [read only] The height of the bitmap image in pixels
        public var height:int;
        // [read only] The rectangle that defines the size and location of the bitmap image.
        public var rect:Rectangle;
        // [read only] Defines whether the bitmap image supports per-pixel transparency.
        public var transparent:Boolean;
        // [read only] The width of the bitmap image in pixels
        public var width:int;
        // Creates a BitmapData object with a specified width and height.
        public function BitmapData(width:int, height:int, transparent:Boolean = true, fillColor:uint = 0xFFFFFFFF){}
        // Takes a source image and a filter object and generates the filtered image.
        public function applyFilter(sourceBitmapData:BitmapData, sourceRect:Rectangle, destPoint:Point, filter:BitmapFilter):void{}
        // Returns a new BitmapData object that is a clone of the original instance with an exact copy of the contained bitmap.
        public function clone():BitmapData{}
        // Adjusts the color values in a specified area of a bitmap image by using a ColorTransform object.
        public function colorTransform(rect:Rectangle, colorTransform:ColorTransform):void{}
        // Compares two BitmapData objects
        public function compare(otherBitmapData:BitmapData):Object{}
        // Transfers data from one channel of another BitmapData object or the current
        // BitmapData object into a channel of the current BitmapData object.
        public function copyChannel(sourceBitmapData:BitmapData, sourceRect:Rectangle, destPoint:Point, sourceChannel:uint, destChannel:uint):void{}
        // Provides a fast routine to perform pixel manipulation between images with no stretching, rotation, or color effects
        public function copyPixels(sourceBitmapData:BitmapData, sourceRect:Rectangle, destPoint:Point, alphaBitmapData:BitmapData = null, alphaPoint:Point = null, mergeAlpha:Boolean = false):void{}
        // Frees memory that is used to store the BitmapData object
        public function dispose():void{}
        // Draws the source display object onto the bitmap image, using the Flash Player or AIR vector renderer.
        public function draw(source:IBitmapDrawable, matrix:Matrix = null, colorTransform:ColorTransform = null, blendMode:String = null, clipRect:Rectangle = null, smoothing:Boolean = false):void{}
        // Fills a rectangular area of pixels with a specified ARGB color
        public function fillRect(rect:Rectangle, color:uint):void{}
        // erforms a flood fill operation on an image starting at an (x, y) coordinate and filling with a certain color.
        public function floodFill(x:int, y:int, color:uint):void{}
        // Determines the destination rectangle that the applyFilter() method call affects,
        // given a BitmapData object, a source rectangle, and a filter object.
        public function generateFilterRect(sourceRect:Rectangle, filter:BitmapFilter):Rectangle{}
        // Determines a rectangular region that either fully encloses all pixels of a specified color
        // within the bitmap image (if the findColor parameter is set to true) or fully encloses all
        // pixels that do not include the specified color (if the findColor parameter is set to false).
        public function getColorBoundsRect(mask:uint, color:uint, findColor:Boolean = true):Rectangle{}
        // Returns an integer that represents an RGB pixel value from a BitmapData object at a specific point (x, y).
        public function getPixel(x:int, y:int):uint{}
        // Returns an ARGB color value that contains alpha channel data and RGB data. 
        public function getPixel32(x:int, y:int):uint{}
        // Generates a byte array from a rectangular region of pixel data
        public function getPixels(rect:Rectangle):ByteArray{}
        // Generates a vector array from a rectangular region of pixel data.
        public function getVector(rect:Rectangle):Vector.<uint>{}
        // Computes a 256 value binary number histogram of a BitmapData object.
        public function histogram(hRect:Rectangle = null):Vector.<Vector>{}
        // Performs pixel-level hit detection between one bitmap image and a point, rectangle, or other bitmap image. 
        public function hitTest(firstPoint:Point, firstAlphaThreshold:uint, secondObject:Object, secondBitmapDataPoint:Point = null, secondAlphaThreshold:uint = 1):Boolean{}
        // Locks an image so that any objects that reference the BitmapData object, such as Bitmap objects,
        // are not updated when this BitmapData object changes
        public function lock():void{}
        // Performs per-channel blending from a source image to a destination image
        public function merge(sourceBitmapData:BitmapData, sourceRect:Rectangle, destPoint:Point, redMultiplier:uint, greenMultiplier:uint, blueMultiplier:uint, alphaMultiplier:uint):void{}
        // Fills an image with pixels representing random noise
        public function noise(randomSeed:int, low:uint = 0, high:uint = 255, channelOptions:uint = 7, grayScale:Boolean = false):void{}
        // Remaps the color channel values in an image that has up to four arrays of color palette data, one for each channel.
        public function paletteMap(sourceBitmapData:BitmapData, sourceRect:Rectangle, destPoint:Point, redArray:Array = null, greenArray:Array = null, blueArray:Array = null, alphaArray:Array = null):void{}
        // Generates a Perlin noise image
        public function perlinNoise(baseX:Number, baseY:Number, numOctaves:uint, randomSeed:int, stitch:Boolean, fractalNoise:Boolean, channelOptions:uint = 7, grayScale:Boolean = false, offsets:Array = null):void{}
        // Performs a pixel dissolve either from a source image to a destination image or by using the same image
        public function pixelDissolve(sourceBitmapData:BitmapData, sourceRect:Rectangle, destPoint:Point, randomSeed:int = 0, numPixels:int = 0, fillColor:uint = 0):int{}
        // Scrolls an image by a certain (x, y) pixel amount.
        // Edge regions outside the scrolling area are left unchanged.
        public function scroll(x:int, y:int):void{}
        // Sets a single pixel of a BitmapData object.
        public function setPixel(x:int, y:int, color:uint):void{}
        // Sets the color and alpha transparency values of a single pixel of a BitmapData object
        public function setPixel32(x:int, y:int, color:uint):void{}
        // Converts a byte array into a rectangular region of pixel data. 
        public function setPixels(rect:Rectangle, inputByteArray:ByteArray):void{}
        // 
        public function setVector(rect:Rectangle, inputVector:Vector.<uint>):void{}
        // Tests pixel values in an image against a specified threshold and sets pixels that pass the test to new color values
        public function threshold(sourceBitmapData:BitmapData, sourceRect:Rectangle, destPoint:Point, operation:String, threshold:uint, color:uint = 0, mask:uint = 0xFFFFFFFF, copySource:Boolean = false):uint{}
        // Unlocks an image so that any objects that reference the BitmapData object,
        // such as Bitmap objects, are updated when this BitmapData object changes.
        public function unlock(changeRect:Rectangle = null):void{}
    }
    // The Bitmap class represents display objects that represent bitmap images. 
    public class Bitmap extends DisplayObject {
        // The BitmapData object being referenced.
        public var bitmapData:BitmapData;
        // Controls whether or not the Bitmap object is snapped to the nearest pixel.
        public var pixelSnapping:String;
        // Controls whether or not the bitmap is smoothed when scaled
        public var smoothing:Boolean;
        // Initializes a Bitmap object to refer to the specified BitmapData object.
        public function Bitmap(bitmapData:BitmapData = null, pixelSnapping:String = "auto", smoothing:Boolean = false){}
    }
    // The BitmapDataChannel class is an enumeration of constant values that indicate
    // which channel to use: red, blue, green, or alpha transparency.
    public final class BitmapDataChannel {
        public static const ALPHA:uint = 8;
        public static const BLUE:uint = 4;
        public static const GREEN:uint = 2;
        public static const RED:uint = 1;
    }
    // A class that provides constant values for visual blend mode effects
    public final class BlendMode {
        public static const ADD:String = "add";
        public static const ALPHA:String = "alpha";
        public static const DARKEN:String = "darken";
        public static const DIFFERENCE:String = "difference";
        public static const ERASE:String = "erase";
        public static const HARDLIGHT:String = "hardlight";
        public static const INVERT:String = "invert";
        public static const LAYER:String = "layer";
        public static const LIGHTEN:String = "lighten";
        public static const MULTIPLY:String = "multiply";
        public static const NORMAL:String = "normal";
        public static const OVERLAY:String = "overlay";
        public static const SCREEN:String = "screen";
        public static const SHADER:String = "shader";
    }
    // The CapsStyle class is an enumeration of constant values that
    // specify the caps style to use in drawing lines.
    public final class CapsStyle {
        public static const NONE:String = "none";
        public static const ROUND:String = "round";
        public static const SQUARE:String = "square";
    }
    // The ColorCorrection class provides values for the
    // flash.display.Stage.colorCorrection property
    public final class ColorCorrection {
        // Uses the host's default color correction. For the web player the host is usually a browser,
        // and Flash Player tries to use the same color correction as the web page hosting the SWF file.
        public static const DEFAULT:String = "default";
        // Turns off color correction regardless of the player host environment.
        // This setting provides faster performance.
        public static const OFF:String = "off";
        // Turns on color correction regardless of the player host environment, if available.
        public static const ON:String = "on";
    }
    // The ColorCorrectionSupport class provides values for the flash.display.Stage.colorCorrectionSupport property.
    public final class ColorCorrectionSupport {
        // Color correction is supported, but off by default.
        public static const DEFAULT_OFF:String = "defaultOff";
        // Color correction is supported, and on by default.
        public static const DEFAULT_ON:String = "defaultOn";
        // Color correction is not supported by the host environment.
        public static const UNSUPPORTED:String = "unsupported";
    }
    // The DisplayObjectContainer class is the base class for all objects
    // that can serve as display object containers on the display list
    public class DisplayObjectContainer extends InteractiveObject {
        // Determines whether or not the children of the object are mouse enabled
        public var mouseChildren:Boolean;
        // [read-only] Returns the number of children of this object.        
 	 	public var numChildren : int;
        // Determines whether the children of the object are tab enabled.
 	 	public var tabChildren : Boolean;
        // [read-only] Returns a TextSnapshot object for this DisplayObjectContainer instance.
 	 	public var textSnapshot : TextSnapshot;
        // Calling the new DisplayObjectContainer() constructor throws an ArgumentError exception.
        public function DisplayObjectContainer(){}
        // Adds a child DisplayObject instance to this DisplayObjectContainer instance.
        public function addChild(child:DisplayObject):DisplayObject{}
        // Adds a child DisplayObject instance to this DisplayObjectContainer instance.
        public function addChildAt(child:DisplayObject, index:int):DisplayObject{}
        // Indicates whether the security restrictions would cause any display objects to be omitted from the list returned by calling the DisplayObjectContainer.getObjectsUnderPoint() method with the specified point point.
        public function areInaccessibleObjectsUnderPoint(point:Point):Boolean{}
        // Determines whether the specified display object is a child of the DisplayObjectContainer instance or the instance itself.
        public function contains(child:DisplayObject):Boolean{}
        // Returns the child display object instance that exists at the specified index.
        public function getChildAt(index:int):DisplayObject{}
        // Returns the child display object that exists with the specified name.
        public function getChildByName(name:String):DisplayObject{}
        // Returns the index position of a child DisplayObject instance.
        public function getChildIndex(child:DisplayObject):int{}
        // Returns an array of objects that lie under the specified point and are children (or grandchildren, and so on) of this DisplayObjectContainer instance.
        public function getObjectsUnderPoint(point:Point):Array{}
        // Removes the specified child DisplayObject instance from the child list of the DisplayObjectContainer instance.
        public function removeChild(child:DisplayObject):DisplayObject{}
        // Removes a child DisplayObject from the specified index position in the child list of the DisplayObjectContainer.
        public function removeChildAt(index:int):DisplayObject{}
        // Changes the position of an existing child in the display object container.
        public function setChildIndex(child:DisplayObject, index:int):void{}
        // Swaps the z-order (front-to-back order) of the two specified child objects.
        public function swapChildren(child1:DisplayObject, child2:DisplayObject):void{}
        // Swaps the z-order (front-to-back order) of the child objects at the two specified index positions in the child list.
        public function swapChildrenAt(index1:int, index2:int):void{}
    }
    // The FocusDirection class enumerates values to be used for the direction parameter  of the
    // assignFocus() method of a Stage object and for the direction property of a FocusEvent object.
    public final class FocusDirection{
        // Indicates that focus should be given to the object at the end of the reading order.
        public static const BOTTOM:String = "bottom";
        // Indicates that focus object within the interactive object should not change.
        public static const NONE:String = "none";
        // Indicates that focus should be given to the object at the beginning of the reading order.
        public static const TOP:String = "top";
    }
    // The FrameLabel object contains properties that specify
    // a frame number and the corresponding label name
    public final class FrameLabel extends Object{
        // The frame number containing the label
        public var frame:int;
        // The name of the label
        public var name:String;
    }
    public final class GradientType {
        // Value used to specify a linear gradient fill.
        public static const LINEAR:String = "linear";
        // Value used to specify a radial gradient fill.
        public static const RADIAL:String = "radial";
    }
}
