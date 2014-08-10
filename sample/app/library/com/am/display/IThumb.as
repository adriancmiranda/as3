package com.am.display {
	import flash.utils.ByteArray;

	/**
	 * @author Adrian C. Miranda <adriancmiranda@gmail.com>
	 */
	public interface IThumb extends IButton {
		function load(urlOrRequest:*):void;
		function loadBytes(bytes:ByteArray):void;
		function get isLoaded():Boolean;
		function get content():*;
		function get percent():Number;
		function get url():String;
	}
}
