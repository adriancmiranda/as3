package com.am.display {
	import flash.display.BitmapData;
	import flash.display.Bitmap;

	/**
	 * @author Adrian C. Miranda <adriancmiranda@gmail.com>
	 */
	public interface IBitmap extends IDisplayObject {
		function get bitmapData():BitmapData;
		function set bitmapData(value:BitmapData):void;
		function get pixelSnapping():String;
		function set pixelSnapping(value:String):void;
		function get smoothing():Boolean;
		function set smoothing(value:Boolean):void;
	}
}
