package com.am.display {
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.geom.Rectangle;

	/**
	 * @author Adrian C. Miranda <adriancmiranda@gmail.com>
	 */
	public interface IDisplay extends IMovieClip {
		function move(x:Number, y:Number):void;
		function size(width:Number, height:Number):void;
		function fit(width:Number, height:Number):void;
		function fitX(width:Number):void;
		function fitY(height:Number):void;
		function lock(value:Boolean, all:Boolean = false):void;
		function get locked():Boolean;
		function get originBounds():Rectangle;
		function set scale(value:Number):void;
		function set showRegistrationPoint(value:Boolean):void;
		function moveRegistrationPoint(x:Number, y:Number):void;
		function removeAllChildren(target:DisplayObjectContainer = null):void;
		function die():void;
		function toString():String;
	}
}
