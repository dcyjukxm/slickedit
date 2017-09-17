// The Object class is at the root of the ActionScript class hierarchy.
public dynamic class Object {
    // A reference to the class object or constructor function for a given object instance.
    public var constructor:Object;
    // [static] A reference to the prototype object of a class or function object.
    public static var prototype:Object;
    // Creates an Object object and stores a reference to the object's constructor method in the object's constructor property.
    public function Object(){}
    // Indicates whether an object has a specified property defined.
    function hasOwnProperty(name:String):Boolean{}
    // Indicates whether an instance of the Object class is in the prototype chain of the object specified as the parameter.
    function isPrototypeOf(theClass:Object):Boolean{}
    // Indicates whether the specified property exists and is enumerable.
    function propertyIsEnumerable(name:String):Boolean{}
    // Sets the availability of a dynamic property for loop operations.
    function setPropertyIsEnumerable(name:String, isEnum:Boolean = true):void{}
    // Returns the string representation of the specified object.
    function toString():String{}
    // Returns the primitive value of the specified object.
    function valueOf():Object{}
}

// The Array class lets you access and manipulate arrays.
public class Array extends Object {
    // A non-negative integer specifying the number of elements in the array.
    var length:uint;
    // Lets you create an array of the specified number of elements.
    public function Array(numElements:int = 0){}
    // Lets you create an array that contains the specified elements.
    public function Array(... values){}
    // Concatenates the elements specified in the parameters with the elements in an array and creates a new array.
    function concat(... args):Array{}
    // Executes a test function on each item in the array until an item is reached that returns false for the specified function.
    function every(callback:Function, thisObject:* = null):Boolean{}
    // Executes a test function on each item in the array and constructs a new array for all items that return true for the specified function.
    function filter(callback:Function, thisObject:* = null):Array{}
    // Executes a function on each item in the array.
    function forEach(callback:Function, thisObject:* = null):void{}
    // Searches for an item in an array by using strict equality (===) and returns the index position of the item.
    function indexOf(searchElement:*, fromIndex:int = 0):int{}
}

// The Date class represents date and time information. Local time is determined by the operating system on which Flash Player is running.
public final dynamic class Date extends Object {
    // The day of the month (an integer from 1 to 31) specified by a Date object according to local time.
    public var date:Number;
    // The day of the month (an integer from 1 to 31) of a Date object according to universal time (UTC).
    public var dateUTC:Number;
    // The day of the week (0 for Sunday, 1 for Monday, and so on) specified by this Date according to local time.
    public var day:Number;
    // The day of the week (0 for Sunday, 1 for Monday, and so on) of this Date according to universal time (UTC).
    public var dayUTC:Number;
    // The full year (a four-digit number, such as 2000) of a Date object according to local time. 
    public var fullYear:Number;
    // The four-digit year of a Date object according to universal time (UTC).
    public var fullYearUTC:Number;
    // The hour (an integer from 0 to 23) of the day portion of a Date object according to local time. 
    public var hours:Number;
    // The hour (an integer from 0 to 23) of the day of a Date object according to universal time (UTC).
    public var hoursUTC:Number;
    // The milliseconds (an integer from 0 to 999) portion of a Date object according to local time. 
    public var milliseconds:Number;
    // The milliseconds (an integer from 0 to 999) portion of a Date object according to universal time (UTC).
    public var millisecondsUTC:Number;
    // The minutes (an integer from 0 to 59) portion of a Date object according to local time. 
    public var minutes:Number;
    // The minutes (an integer from 0 to 59) portion of a Date object according to universal time (UTC).
    public var minutesUTC:Number;
    // The month (0 for January, 1 for February, and so on) portion of a Date object according to local time. 
    public var month:Number;
    // The month (0 [January] to 11 [December]) portion of a Date object according to universal time (UTC).
    public var monthUTC:Number;
    // The seconds (an integer from 0 to 59) portion of a Date object according to local time. 
    public var seconds:Number;
    // The seconds (an integer from 0 to 59) portion of a Date object according to universal time (UTC).
    public var secondsUTC:Number;
    // The number of milliseconds since midnight January 1, 1970, universal time, for a Date object. Use this method to represent a specific instant in time
    // when comparing two or more Date objects.
    public var time:Number;
    // The difference, in minutes, between universal time (UTC) and the computer's local time. Specifically, this value is the number of minutes you need to add
    // to the computer's local time to equal UTC. If your computer's time is set later than UTC, the value will be negative.
    public var timezoneOffset:Number;
    // Constructs a new Date object that holds the specified date and time.
    public function Date(yearOrTimevalue:Object, month:Number, date:Number = 1, hour:Number = 0, minute:Number = 0, second:Number = 0, millisecond:Number = 0){}
    // Returns the day of the month (an integer from 1 to 31) specified by a Date object according to local time. 
    function getDate():Number{}
	// Returns the day of the week (0 for Sunday, 1 for Monday, and so on) specified by this Date according to local time. 
    function getDay():Number
	// Returns the full year (a four-digit number, such as 2000) of a Date object according to local time. 
	function getFullYear():Number{}
    // Returns the hour (an integer from 0 to 23) of the day portion of a Date object according to local time. 
    function getHours():Number{}
    // Returns the milliseconds (an integer from 0 to 999) portion of a Date object according to local time. 
    function getMilliseconds():Number{}
    // Returns the minutes (an integer from 0 to 59) portion of a Date object according to local time. 
    function getMinutes():Number{}
    // Returns the month (0 for January, 1 for February, and so on) portion of this Date according to local time. 
    function getMonth():Number{}
    // Returns the seconds (an integer from 0 to 59) portion of a Date object according to local time. 
    function getSeconds():Number{}
    // Returns the number of milliseconds since midnight January 1, 1970, universal time, for a Date object. Use this method to represent a specific instant in time
    // when comparing two or more Date objects.
    function getTime():Number{}
    // Returns the difference, in minutes, between universal time (UTC) and the computer's local time.
    function getTimezoneOffset():Number{}
    // Returns the day of the month (an integer from 1 to 31) of a Date object, according to universal time (UTC).
    function getUTCDate():Number{}
    // Returns the day of the week (0 for Sunday, 1 for Monday, and so on) of this Date according to universal time (UTC).
    function getUTCDay():Number{}
    // Returns the four-digit year of a Date object according to universal time (UTC).
    function getUTCFullYear():Number{}
    // Returns the hour (an integer from 0 to 23) of the day of a Date object according to universal time (UTC).
    function getUTCHours():Number{}
    // Returns the milliseconds (an integer from 0 to 999) portion of a Date object according to universal time (UTC).
    function getUTCMilliseconds():Number{}
    // Returns the minutes (an integer from 0 to 59) portion of a Date object according to universal time (UTC).
    function getUTCMinutes():Number{}
    // Returns the month (0 [January] to 11 [December]) portion of a Date object according to universal time (UTC).
    function getUTCMonth():Number{}
    // Returns the seconds (an integer from 0 to 59) portion of a Date object according to universal time (UTC).
    function getUTCSeconds():Number{}
    // Converts a string representing a date into a number equaling the number of milliseconds elapsed since January 1, 1970, UTC.
    public static function parse(date:String):Number{}
    // Sets the day of the month, according to local time, and returns the new time in milliseconds. 
    function setDate(day:Number):Number{}
    // Sets the year, according to local time, and returns the new time in milliseconds.
    function setFullYear(year:Number, month:Number, day:Number):Number{}
    // Sets the hour, according to local time, and returns the new time in milliseconds
    function setHours(hour:Number, minute:Number, second:Number, millisecond:Number):Number{}
    // Sets the milliseconds, according to local time, and returns the new time in milliseconds.
    function setMilliseconds(millisecond:Number):Number{}
    // Sets the minutes, according to local time, and returns the new time in milliseconds.
    function setMinutes(minute:Number, second:Number, millisecond:Number):Number{}
    // Sets the month and optionally the day of the month, according to local time, and returns the new time in milliseconds.
    function setMonth(month:Number, day:Number):Number{}
    // Sets the seconds, according to local time, and returns the new time in milliseconds
    function setSeconds(second:Number, millisecond:Number):Number{}
    // Sets the date in milliseconds since midnight on January 1, 1970, and returns the new time in milliseconds.
    function setTime(millisecond:Number):Number{}
    // Sets the day of the month, in universal time (UTC), and returns the new time in milliseconds. 
    function setUTCDate(day:Number):Number{}
    // Sets the year, in universal time (UTC), and returns the new time in milliseconds.
    function setUTCFullYear(year:Number, month:Number, day:Number):Number{}
    // Sets the hour, in universal time (UTC), and returns the new time in milliseconds
    function setUTCHours(hour:Number, minute:Number, second:Number, millisecond:Number):Number{}
    // Sets the milliseconds, in universal time (UTC), and returns the new time in milliseconds.
    function setUTCMilliseconds(millisecond:Number):Number{}
    // Sets the minutes, in universal time (UTC), and returns the new time in milliseconds.
    function setUTCMinutes(minute:Number, second:Number, millisecond:Number):Number{}
    // Sets the month and optionally the day of the month, in universal time (UTC), and returns the new time in milliseconds.
    function setUTCMonth(month:Number, day:Number):Number{}
    // Sets the seconds, in universal time (UTC), and returns the new time in milliseconds
    function setUTCSeconds(second:Number, millisecond:Number):Number{}
    // Returns a string representation of the day and date only, and does not include the time or timezone.
    function toDateString():String{}
    // Returns a String representation of the day and date only, and does not include the time or timezone.
    function toLocaleDateString():String{}
    // Returns a String representation of the day, date, time, given in local time.
    function toLocaleString():String{}
    // Returns a String representation of the time only, and does not include the day, date, year, or timezone.
    function toLocaleTimeString():String{}
    // Returns a String representation of the day, date, time, and timezone.
    // The date format for the output is:  Day Mon Date HH:MM:SS TZD YYYY
    function toString():String{}
    // Returns a String representation of the time and timezone only, and does not include the day and date.
    function toTimeString():String{}
    // Returns a String representation of the day, date, and time in universal time (UTC).
    function toUTCString():String{}
    // Returns the number of milliseconds between midnight on January 1, 1970, universal time,
    // and the time specified in the parameters.  This method uses universal time, whereas the Date constructor uses local time.
    public static function UTC(year:Number, month:Number, date:Number = 1, hour:Number = 0, minute:Number = 0, second:Number = 0, millisecond:Number = 0):Number{}
    // Returns the number of milliseconds since midnight January 1, 1970, universal time, for a Date object.
    function valueOf():Number{}
}

// A Class object is created for each class definition in a program
public class Class extends Object {
}

// The String class is a data type that represents a string of characters.
public class String extends Object {
    // [read-only] An integer specifying the number of characters in the specified String object.
    public var length:int;
    // Creates a new String object initialized to the specified string.
    public function String(val:String){}
    // Returns the character in the position specified by the index parameter. 
    function charAt(index:Number = 0):String{}
    // Returns the numeric Unicode character code of the character at the specified index.
    function charCodeAt(index:Number = 0):Number{}
    // Appends the supplied arguments to the end of the String object, converting them to strings if necessary, and returns the resulting string.
    function concat(... args):String{}
    // Returns a string comprising the characters represented by the Unicode character codes in the parameters.
    static function fromCharCode(... charCodes):String{}
    // Searches the string and returns the position of the first occurrence of val found at or after startIndex within the calling string.
    function indexOf(val:String, startIndex:Number = 0):int{}
    // Searches the string from right to left and returns the index of the last occurrence of val found before startIndex. 
    function lastIndexOf(val:String, startIndex:Number = 0x7FFFFFFF):int{}
    // Compares the sort order of two or more strings and returns the result of the comparison as an integer. 
    function localeCompare(other:String, ... values):int{}
    // Matches the specifed pattern against the string.  
    function match(pattern:*):Array{}
    // Matches the specifed pattern against the string and returns a new string in which the first match of pattern is replaced with the content specified by repl.
    function replace(pattern:*, repl:Object):String{}
    // Searches for the specifed pattern and returns the index of the first matching substring.
    function search(pattern:*):int{}
    // Returns a string that includes the startIndex character and all characters up to, but not including, the endIndex character.
    function slice(startIndex:Number = 0, endIndex:Number = 0x7fffffff):String{}
    // Splits a String object into an array of substrings by dividing it wherever the specified delimiter parameter occurs.
    function split(delimiter:*, limit:Number = 0x7fffffff):Array{}
    // Returns a substring consisting of the characters that start at the specified startIndex and with a length specified by len. 
    function substr(startIndex:Number = 0, len:Number = 0x7fffffff):String{}
    // Returns a string consisting of the character specified by startIndex and all characters up to endIndex - 1.
    function substring(startIndex:Number = 0, endIndex:Number = 0x7fffffff):String{}
    // Returns a copy of this string, with all uppercase characters converted to lowercase.
    function toLocaleLowerCase():String{}
    // Returns a copy of this string, with all lowercase characters converted to uppercase.
    function toLocaleUpperCase():String{}
    // Returns a copy of this string, with all uppercase characters converted to lowercase.
    function toLowerCase():String{}
    // Returns a copy of this string, with all lowercase characters converted to uppercase.
    function toUpperCase():String{}
    // Returns the primitive value of a String instance.
    function valueOf():String{}
}

// A Boolean object is a data type that can have one of two values, either true or false, used for logical operations.
public final class Boolean extends Object {
    // Creates a Boolean object with the specified value.
    public function Boolean(expression:Object = false){}
    // The string "true" or "false".
    function toString():String{}
    // Returns true if the value of the specified Boolean object is true; false otherwise.
    function valueOf():Boolean{}
}

// The int class lets you work with the data type representing a 32-bit signed integer. 
public final class int extends Object {
    // Constructor; creates a new int object. 
    public function int(num:Object){}
    // Returns a string representation of the number in exponential notation.
    function toExponential(fractionDigits:uint):String{}
    // Returns a string representation of the number in fixed-point notation.
    function toFixed(fractionDigits:uint):String{}
    // Returns a string representation of the number either in exponential notation or in fixed-point notation. 
    function toPrecision(precision:uint):String{}
    // Returns the string representation of an int object.
    function toString(radix:uint):String{}
    // Returns the primitive value of the specified int object.
    function valueOf():int{}
    // The largest representable 32-bit signed integer, which is 2,147,483,647.
    public static const MAX_VALUE:int = 2147483647;
    // The smallest representable 32-bit signed integer, which is -2,147,483,648.
    public static const MIN_VALUE:int = -2147483648;
}

// The uint class lets you work with the data type representing a 32-bit unsigned integer. 
public final class uint extends Object {
    // Constructor; creates a new uint object. 
    public function uint(num:Object){}
    // Returns a string representation of the number in exponential notation.
    function toExponential(fractionDigits:uint):String{}
    // Returns a string representation of the number in fixed-point notation.
    function toFixed(fractionDigits:uint):String{}
    // Returns a string representation of the number either in exponential notation or in fixed-point notation. 
    function toPrecision(precision:uint):String{}
    // Returns the string representation of an uint object.
    function toString(radix:uint):String{}
    // Returns the primitive value of the specified uint object.
    function valueOf():int{}
    // The largest representable 32-bit unsigned integer, which is 4,294,967,295.
    public static const MAX_VALUE:int = 4294967295;
    // The smallest representable 32-bit unsigned integer, which is 0.
    public static const MIN_VALUE:int = 0;
}

// A data type representing an IEEE-754 double-precision floating-point number.
public final class Number extends Object {
    // Creates a Number object with the specified value.
    public function Number(num:Object){}
    // Returns a string representation of the number in exponential notation. 
    function toExponential(fractionDigits:uint):String{}
    // Returns a string representation of the number in fixed-point notation.
    function toFixed(fractionDigits:uint):String{}
    // Returns a string representation of the number either in exponential notation or in fixed-point notation.
    function toPrecision(precision:uint):String{}
    // Returns the string representation of the specified Number object 
    function toString(radix:Number = 10):String{}
    // Returns the primitive value type of the specified Number object.
    function valueOf():Number{}
    // The largest representable number (double-precision IEEE-754). This number is approximately 1.79e+308.
    public static const MAX_VALUE:Number;
    // The smallest representable non-negative, non-zero, number (double-precision IEEE-754). This number is approximately 5e-324.
    public static const MIN_VALUE:Number;
    // The IEEE-754 value representing Not a Number (NaN).
    public static const NaN:Number;
    // Specifies the IEEE-754 value representing negative infinity. 
    public static const NEGATIVE_INFINITY:Number;
    // Specifies the IEEE-754 value representing positive infinity.
    public static const POSITIVE_INFINITY:Number;
}

// The XMLList class contains methods for working with one or more XML elements.
// An XMLList object can represent one or more XML objects or elements (including multiple nodes or attributes), so you can call methods on the elements as a group or on the individual elements in the collection.
public final dynamic class XMLList extends Object {
    // Creates a new XMLList object.
    public function XMLList(value:Object){}
    // Calls the attribute() method of each XML object and returns an XMLList object of the results.
    function attribute(attributeName:*):XMLList{}
    // Calls the attributes() method of each XML object and returns an XMLList object of attributes for each XML object.
    function attributes():XMLList{}
    // Calls the child() method of each XML object and returns an XMLList object that contains the results in order.
    function child(propertyName:Object):XMLList{}
    // Calls the children() method of each XML object and returns an XMLList object that contains the results.
    function children():XMLList{}
    // Calls the comments() method of each XML object and returns an XMLList of comments.
    function comments():XMLList{}
    // Checks whether the XMLList object contains an XML object that is equal to the given value parameter.
    function contains(value:XML):Boolean{}
    // Returns a copy of the given XMLList object. The copy is a duplicate of the entire tree of nodes. 
    function copy():XMLList{}
    // Returns all descendants (children, grandchildren, great-grandchildren, and so on) of the XML object that have the given name parameter
    function descendants(name:Object = *):XMLList{}
    // Calls the elements() method of each XML object.
    function elements(name:Object = *):XMLList{}
    // Checks whether the XMLList object contains complex content. An XMLList object is considered to contain complex content if it is not empty
    function hasComplexContent():Boolean{}
    // Checks for the property specified by p.
    function hasOwnProperty(p:String):Boolean{}
    // Checks whether the XMLList object contains simple content.
    function hasSimpleContent():Boolean{}
    // Returns the number of properties in the XMLList object.
    function length():int{}
    // Merges adjacent text nodes and eliminates empty text nodes for each of the following: all text nodes in the XMLList, all the XML objects contained in the XMLList, and the descendants
    // of all the XML objects in the XMLList.
    function normalize():XMLList{}
    // Returns the parent of the XMLList object if all items in the XMLList object have the same parent.
    function parent():Object{}
    // If a name parameter is provided, lists all the children of the XMLList object that contain processing instructions with that name. 
    function processingInstructions(name:String = "*"):XMLList{}
    // Checks whether the property p is in the set of properties that can be iterated in a for..in statement applied to the XMLList object. 
    function propertyIsEnumerable(p:String):Boolean{}
    // Calls the text() method of each XML object and returns an XMLList object that contains the results.
    function text():XMLList{}
    // Returns a string representation of all the XML objects in an XMLList object.
    function toString():String{}
    // Returns a string representation of all the XML objects in an XMLList object. Unlike the toString() method, the toXMLString() method always returns the start tag, attributes, and
    // end tag of the XML object
    function toXMLString():String{}
    // Returns the XMLList object.
    function valueOf():XMLList{}
}

// The XML class contains methods and properties for working with XML objects.
public final dynamic class XML extends Object {
    // [Property] Determines whether XML comments are ignored when XML objects parse the source XML data.
    public var ignoreComments:Boolean;
    // [Property] Determines whether XML processing instructions are ignored when XML objects parse the source XML data. 
    public var ignoreProcessingInstructions:Boolean;
    // [Property] Determines whether white space characters at the beginning and end of text nodes are ignored during parsing.
    public var ignoreWhitespace:Boolean;
    // [Property] Determines the amount of indentation applied by the toString() and toXMLString() methods when the XML.prettyPrinting property is set to true.
    public var prettyIndent:Boolean;
    // [Property] Determines whether the toString() and toXMLString() methods normalize white space characters between some tags.
    public var prettyPrinting:Boolean;
    // Constructor
    public function XML(value:Object){}
    // Adds a namespace to the set of in-scope namespaces for the XML object.
    function addNamespace(ns:Object):XML{}
    // Appends the given child to the end of the XML object's properties. 
    function appendChild(child:Object):XML{}
    // Returns the XML value of the attribute that has the name matching the attributeName parameter.
    function attribute(attributeName:*):XMLList{}
    // Returns a list of attribute values for the given XML object. 
    function attributes():XMLList{}
    // Lists the children of an XML object.
    function child(propertyName:Object):XMLList{}
    // Identifies the zero-indexed position of this XML object within the context of its parent.
    function childIndex():int{}
    // Lists the children of the XML object in the sequence in which they appear.
    function children():XMLList{}
    // Lists the properties of the XML object that contain XML comments.
    function comments():XMLList{}
    // Compares the XML object against the given value parameter.
    function contains(value:XML):Boolean{}
    // Returns a copy of the given XML object.
    function copy():XML{}
    // Returns an object with the following properties set to the default values
    static function defaultSettings():Object{}
    // Returns all descendants (children, grandchildren, great-grandchildren, and so on) of the XML object that have the given name parameter. 
    function descendants(name:Object = *):XMLList{}
    // Lists the elements of an XML object. An element consists of a start and an end tag; for example <first></first>.
    function elements(name:Object = *):XMLList{}
    // Checks to see whether the XML object contains complex content. An XML object contains complex content if it has child elements.
    function hasComplexContent():Boolean{}
    // Checks to see whether the object has the property specified by the p parameter.
    function hasOwnProperty(p:String):Boolean{}
    // Checks to see whether the XML object contains simple content. An XML object contains simple content if it represents a text node, an attribute node, or an XML element that
    // has no child elements.
    function hasSimpleContent():Boolean{}
    // Lists the namespaces for the XML object, based on the object's parent.
    function inScopeNamespaces():Array{}
    // Inserts the given child2 parameter after the child1 parameter in this XML object and returns the resulting object. 
    function insertChildAfter(child1:Object, child2:Object):*{}
    // Inserts the given child2 parameter before the child1 parameter in this XML object and returns the resulting object.
    function insertChildBefore(child1:Object, child2:Object):*{}
    // For XML objects, this method always returns the integer 1. The length() method of the XMLList class returns a value of 1 for an XMLList object that contains only one value.
    function length():int{}
    // Gives the local name portion of the qualified name of the XML object.
    function localName():Object{}
    // Gives the qualified name for the XML object.
    function name():Object{}   
    // Lists namespace declarations associated with the XML object in the context of its parent.
    function namespaceDeclarations():Array{}
    // Specifies the type of node: text, comment, processing-instruction, attribute, or element.
    function nodeKind():String{}
    // For the XML object and all descendant XML objects, merges adjacent text nodes and eliminates empty text nodes.
    function normalize():XML{}
    // Returns the parent of the XML object. If the XML object has no parent, the method returns undefined.
    function parent():*{}
    // Inserts a copy of the provided child object into the XML element before any existing XML properties for that element.
    function prependChild(value:Object):XML{}
    // If a name parameter is provided, lists all the children of the XML object that contain processing instructions with that name. With no parameters, the method lists
    // all the children of the XML object that contain any processing instructions.
    function processingInstructions(name:String = "*"):XMLList{}
    // Checks whether the property p is in the set of properties that can be iterated in a for..in statement applied to the XML object.
    function propertyIsEnumerable(p:String):Boolean{}
    // Removes the given namespace for this object and all descendants.
    function removeNamespace(ns:Namespace):XML{}
    // Replaces the properties specified by the propertyName parameter with the given value parameter.
    function replace(propertyName:Object, value:XML):XML{}
    // Replaces the child properties of the XML object with the specified set of XML properties, provided in the value parameter.
    function setChildren(value:Object):XML{}
    // Changes the local name of the XML object to the given name parameter.
    function setLocalName(name:String):void{}
    // Sets the name of the XML object to the given qualified name or attribute name.
    function setName(name:String):void{}
    // Sets the namespace associated with the XML object.
    function setNamespace(ns:Namespace):void{}
    // Sets values for the following XML properties: ignoreComments, ignoreProcessingInstructions, ignoreWhitespace, prettyIndent, and prettyPrinting. 
    public static function setSettings(... rest):void{}
    // Retrieves the following properties: ignoreComments, ignoreProcessingInstructions, ignoreWhitespace, prettyIndent, and prettyPrinting.
    public static function settings():Object{}
    // Returns an XMLList object of all XML properties of the XML object that represent XML text nodes.
    function text():XMLList{}
    // Returns a string representation of the XML object.
    function toString():String{}
    // Returns a string representation of the XML object. Unlike the toString() method, the toXMLString() method always returns the start tag, attributes,
    // and end tag of the XML object
    function toXMLString():String{}
    // Returns the XML object.
    function valueOf():XML{}

    // If no parameter is provided, gives the namespace associated with the qualified name of this XML object. If a prefix parameter is specified,
    // the method returns the namespace that matches the prefix parameter and that is in scope for the XML object.
    /* Note: Keyword not being correctly processed as an identifier
     function namespace(prefix:String = null):*{}
    */
}

// The Vector class lets you access and manipulate a vectorâ an array whose elements all have the same data type.
public dynamic class Vector extends Object {
    // Indicates whether the length property of the Vector can be changed.
    public var fixed:Boolean;    
    // The range of valid indices available in the Vector.
    public var length:uint;
    // Creates a Vector with the specified base type.
    public function Vector(length:uint = 0, fixed:Boolean = false){}
    // Concatenates the elements specified in the parameters with the elements in the Vector and creates a new Vector.
    function concat(... args):Vector.<T>{}
    // Executes a test function on each item in the Vector until an item is reached that returns false for the specified function.
    function every(callback:Function, thisObject:Object = null):Boolean{}
    // Executes a test function on each item in the Vector and returns a new Vector containing all items that return true for the specified function. 
    function filter(callback:Function, thisObject:Object = null):Vector.<T>{}
    // Executes a function on each item in the Vector.
    function forEach(callback:Function, thisObject:Object = null):void{}
    // Searches for an item in the Vector and returns the index position of the item.
    function indexOf(searchElement:T, fromIndex:int = 0):int{}
    // Converts the elements in the Vector to strings, inserts the specified separator between the elements, concatenates them, and returns the resulting string.
    function join(sep:String = ","):String{}
    // Searches for an item in the Vector, working backward from the specified index position, and returns the index position of the matching item. 
    function lastIndexOf(searchElement:T, fromIndex:int = 0x7fffffff):int{}
    // Executes a function on each item in the Vector, and returns a new Vector of items corresponding to the results of calling the function on each item in this Vector. 
    function map(callback:Function, thisObject:Object = null):Vector.<T>{}
    // Removes the last element from the Vector and returns that element. 
    function pop():T{}
    // Adds one or more elements to the end of the Vector and returns the new length of the Vector.
    function push(... args):uint{}
    // Reverses the order of the elements in the Vector. This method alters the Vector on which it is called.
    function reverse():Vector.<T>{}
    // Removes the first element from the Vector and returns that element.
    function shift():T{}
    // Returns a new Vector that consists of a range of elements from the original Vector, without modifying the original Vector.
    function slice(startIndex:int = 0, endIndex:int = 16777215):Vector.<T>{}
    // Executes a test function on each item in the Vector until an item is reached that returns true.
    function some(callback:Function, thisObject:Object = null):Boolean{}
    // Sorts the elements in the Vector. This method sorts according to the function provided as the compareFunction parameter.
    function sort(compareFunction:Function):Vector.<T>{}
    // Adds elements to and removes elements from the Vector. This method modifies the Vector without making a copy.
    function splice(startIndex:int, deleteCount:uint, ... items):Vector.<T>{}
    // Returns a string that represents the elements in the specified Vector.
    public function toLocaleString():String{}
    // Returns a string that represents the elements in the Vector
    public function toString():String{}
    // ActionScript 3.0
    // Adds one or more elements to the beginning of the Vector and returns the new length of the Vector. 
    function unshift(... args):uint{}
}

// The Error class contains information about an error that occurred in a script.
public dynamic class Error extends Object {
    // Contains the reference number associated with the specific error message.
    public var errorID:int;
    // Contains the message associated with the Error object.
    public var message:String;
    // Contains the name of the Error object. By default, the value of this property is "Error".
    public var name:String;
    // Creates a new Error object. If message is specified, its value is assigned to the object's Error.message property.
    public function Error(message:String = "", id:int = 0){}
    // Returns the call stack for an error as a string at the time of the error's construction
    public function getStackTrace():String{}
    // Returns the string "Error" by default or the value contained in the Error.message property, if defined.
    override public function toString():String{}
}

// The EvalError class represents an error that occurs when user code calls the eval() function or attempts to use the new operator with the Function object.
public dynamic class EvalError extends Error {
    // Creates a new EvalError object.
    public function EvalError(message:String = ""){}
}

// The DefinitionError class represents an error that occurs when user code attempts to
// define an identifier that is already defined.
public dynamic class DefinitionError extends Error {
    // Creates a new DefinitionError object.
    public function DefinitionError(message:String = ""){}
}

// A RangeError exception is thrown when a numeric value is outside the acceptable range. 
public dynamic class RangeError extends Error {
    // Creates a new RangeError object.
    public function RangeError(message:String = ""){}
}

// A ReferenceError exception is thrown when a reference to an
// undefined property is attempted on a sealed (nondynamic) object.
public dynamic class ReferenceError extends Error {
    // Creates a new ReferenceError object.
    public function ReferenceError(message:String = ""){}
}

// A SecurityError exception is thrown when some type of security violation takes place.
public dynamic class SecurityError extends Error {
    // Creates a new SecurityError object.
    public function SecurityError(message:String = ""){}
}

// A SyntaxError exception is thrown when a parsing error occurs 
public dynamic class SyntaxError extends Error {
    // Creates a new SyntaxError object.
    public function SyntaxError(message:String = ""){}
}

// A TypeError exception is thrown when the actual type of an operand is different from the expected type. 
public dynamic class TypeError extends Error {
    // Creates a new TypeError object.
    public function TypeError(message:String = ""){}
}

// A URIError exception is thrown when one of the global URI handling functions
// is used in a way that is incompatible with its definition. 
public dynamic class URIError extends Error {
    // Creates a new URIError object.
    public function URIError(message:String = ""){}
}

// A VerifyError class represents an error that occurs when a malformed or corrupted SWF file is encountered. 
public dynamic class VerifyError extends Error {
    // Creates a new VerifyError object.
    public function VerifyError(message:String = ""){}
}

// The ArgumentError class represents an error that occurs when the arguments supplied
// in a function do not match the arguments defined for that function.
public dynamic class ArgumentError extends Error {
    // Creates a new ArgumentError object.
    public function ArgumentError(message:String = ""){}
}

// A function is the basic unit of code that can be invoked in ActionScript.
// Both user-defined and built-in functions in ActionScript are represented by Function objects,
// which are instances of the Function class.
public dynamic class Function extends Object {
    // Specifies the value of thisObject to be used within any function that ActionScript calls.
    function apply(thisArg:*, argArray:*):*{}
    // Invokes the function represented by a Function object.
    function call(thisArg:*, ... args):*{}
}

// An arguments object is used to store and access a function's arguments.
public class arguments extends Object {
    // A reference to the currently executing function
    public var callee:Function;
    // The number of arguments passed to the function.
    public var length:Number;
}

// The RegExp class lets you work with regular expressions
public dynamic class RegExp extends Object {
    // [read only] Specifies whether the dot character (.) in a regular expression pattern matches new-line characters
    public var dotall:Boolean;
    // [read only] Specifies whether to use extended mode for the regular expression.
    public var extended:Boolean;
    // [read only] Specifies whether to use global matching for the regular expression
    public var global:Boolean;
    // [read only] Specifies whether the regular expression ignores case sensitivity
    public var ignoreCase:Boolean;
    // Specifies the index position in the string at which to start the next search
    public var lastIndex:Number;
    // [read only] Specifies whether the m (multiline) flag is set. 
    public var multiline:Boolean;
    // [read only] Specifies the pattern portion of the regular expression.
    public var source:String;
    // Lets you construct a regular expression from two strings.
    // One string defines the pattern of the regular expression,
    // and the other defines the flags used in the regular expression.
    public function RegExp(re:String, flags:String){}
    // Performs a search for the regular expression on the given string str.
    function exec(str:String):Object{}
    // Tests for the match of the regular expression in the given string str.
    function test(str:String):Boolean{}
}

// The Math class contains methods and constants that represent common mathematical functions and values.
public final class Math extends Object {
    // Computes and returns an absolute value for the number specified by the parameter val.
    public static function abs(val:Number):Number{}
    // Computes and returns the arc cosine of the number specified in the parameter val, in radians.
    public static function acos(val:Number):Number{}
    // Computes and returns the arc sine for the number specified in the parameter val, in radians.
    public static function asin(val:Number):Number{}
    // Computes and returns the value, in radians, of the angle whose tangent is specified in the parameter val.
    // The return value is between negative pi divided by 2 and positive pi divided by 2.
    public static function atan(val:Number):Number{}
    // Computes and returns the angle of the point y/x in radians,
    // when measured counterclockwise from a circle's x axis
    public static function atan2(y:Number, x:Number):Number{}
    // Returns the ceiling of the specified number or expression
    public static function ceil(val:Number):Number{}
    // Computes and returns the cosine of the specified angle in radians.
    public static function cos(angleRadians:Number):Number{}
    // Returns the value of the base of the natural logarithm (e),
    // to the power of the exponent specified in the parameter val.
    public static function exp(val:Number):Number{}
    // Returns the floor of the number or expression specified in the parameter val.
    public static function floor(val:Number):Number{}
    // Returns the natural logarithm of the parameter val.
    public static function log(val:Number):Number{}
    // Evaluates val1 and val2 (or more values) and returns the largest value.
    public static function max(val1:Number, val2:Number, ... rest):Number{}
    // Evaluates val1 and val2 (or more values) and returns the smallest value.
    public static function min(val1:Number, val2:Number, ... rest):Number{}
    // Computes and returns val1 to the power of val2.
    public static function pow(val1:Number, val2:Number):Number{}
    // Returns a pseudo-random number n, where 0 <= n < 1.
    public static function random():Number{}
    // Rounds the value of the parameter val up or down to the nearest integer and returns the value.
    public static function round(val:Number):Number{}
    // Computes and returns the sine of the specified angle in radians. 
    public static function sin(angleRadians:Number):Number{}
    // Computes and returns the square root of the specified number.
    public static function sqrt(val:Number):Number{}
    // Computes and returns the tangent of the specified angle.
    public static function tan(angleRadians:Number):Number{}
    // A mathematical constant for the base of natural logarithms, expressed as e.
    // The approximate value of e is 2.71828182845905.
    public static const E:Number = 2.71828182845905;
    // A mathematical constant for the natural logarithm of 10, expressed as log10,
    // with an approximate value of 2.302585092994046.
    public static const LN10:Number = 2.302585092994046;
    // A mathematical constant for the natural logarithm of 2, expressed as log2,
    // with an approximate value of 0.6931471805599453.
    public static const LN2:Number = 0.6931471805599453;
    // A mathematical constant for the base-10 logarithm of the constant e (Math.E),
    // expressed as loge, with an approximate value of 0.4342944819032518.
    public static const LOG10E:Number = 0.4342944819032518;
    // A mathematical constant for the base-2 logarithm of the constant e,
    // expressed as log2e, with an approximate value of 1.442695040888963387.
    public static const LOG2E:Number = 1.442695040888963387;
    // A mathematical constant for the ratio of the circumference of a circle to its diameter,
    // expressed as pi, with a value of 3.141592653589793.
    public static const PI:Number = 3.141592653589793;
    // A mathematical constant for the square root of one-half,
    // with an approximate value of 0.7071067811865476.
    public static const SQRT1_2:Number = 0.7071067811865476;
    // A mathematical constant for the square root of 2,
    // with an approximate value of 1.4142135623730951.
    public static const SQRT2:Number = 1.4142135623730951;
}

// The Namespace class contains methods and properties for defining and working with namespaces. 
public final class Namespace extends Object {
    // The prefix of the namespace.
    public var prefix:String;
    // The Uniform Resource Identifier (URI) of the namespace.
    public var uri:String;
    // Creates a Namespace object. The values assigned to the uri and prefix properties of the
    // new Namespace object depend on the type of value passed for the uriValue parameter
    public function Namespace(uriValue:*){}
    // Creates a Namespace object according to the values of the prefixValue and uriValue parameters.
    // This constructor requires both parameters.
    public function Namespace(prefixValue:*, uriValue:*){}
    // Equivalent to the Namespace.uri property.
    function toString():String{}
    // Returns the URI value of the specified object.
    function valueOf():String{}
}

// QName objects represent qualified names of XML elements and attributes.
public final class QName extends Object {
    // The local name of the QName object.
    public var localName:String;
    // The Uniform Resource Identifier (URI) of the object.
    public var uri:String;
    // Creates a QName object with a URI object from a Namespace object and a localName from a QName object.
    public function QName(uri:Namespace, localName:QName){}
    // Creates a QName object that is a copy of another QName object.
    public function QName(qname:QName){}
    // Returns a string composed of the URI, and the local name for the QName object, separated by "::".
    function toString():String{}
    // Returns the QName object.
    function valueOf():QName{}
}

// A special value representing positive Infinity.
public const Infinity:Number;
// A special member of the Number data type that represents a value that is "not a number" (NaN).
public const NaN:Number;
// A special value that applies to untyped variables that have not been initialized
// or dynamic object properties that are not initialized.
public const undefined:*;
// Creates a new array.
public function Array(... args):Array{}
// Converts the expression parameter to a Boolean value and returns the value
public function Boolean(expression:Object):Boolean{}
// Decodes an encoded URI into a string. 
public function decodeURI(uri:String):String{}
// Decodes an encoded URI component into a string.
public function decodeURIComponent(uri:String):String{}
// Encodes a string into a valid URI (Uniform Resource Identifier). 
public function encodeURI(uri:String):String{}
// Encodes a string into a valid URI component
public function encodeURIComponent(uri:String):String{}
// Converts the parameter to a string and encodes it in a URL-encoded format,
// where most nonalphanumeric characters are replaced with % hexadecimal sequences.
public function escape(str:String):String{}
// Converts a given numeric value to an integer value.
public function int(value:Number):int{}
// Returns true if the value is a finite number, or false if the value is Infinity or -Infinity.
public function isFinite(num:Number):Boolean{}
// Returns true if the value is NaN(not a number). 
public function isNaN(num:Number):Boolean{}
// Determines whether the specified string is a valid name for an XML element or attribute
public function isXMLName(str:String):Boolean{}
// Converts a given value to a Number value
public function Number(expression:Object):Number{}
// Every value in ActionScript 3.0 is an object, which means that calling Object()
// on a value returns that value.
public function Object(value:Object):Object{}
// Converts a string to a floating-point number.
public function parseFloat(str:String):Number{}
// Converts a string to an integer.
public function parseInt(str:String, radix:uint = 0):Number{}
// Returns a string representation of the specified parameter.
public function String(expression:Object):String{}
// Displays expressions, or writes to log files, while debugging.
public function trace(... arguments):void{}
// Converts a given numeric value to an unsigned integer value.
public function uint(value:Number):uint{}
// Evaluates the parameter str as a string, decodes the string from URL-encoded format
// (converting all hexadecimal sequences to ASCII characters), and returns the string.
public function unescape(str:String):String{}
// Creates a new Vector instance whose elements are instances of the specified data type.
public function Vector(sourceArray:Object):Vector.<T>{}
// Converts an object to an XML object
public function XML(expression:Object):XML{}
// Converts an object to an XMLList object
public function XMLList(expression:Object):XMLList{}

