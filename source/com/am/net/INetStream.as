package com.am.net {
	import com.am.events.IDispatcher;
	import flash.media.SoundTransform;
	import flash.net.NetStream;

	/**
	 * @author Adrian C. Miranda <adriancmiranda@gmail.com>
	 */
	public interface INetStream extends IDispatcher {
		function get bufferLength():Number;
		function get bufferTime():Number;
		function set bufferTime(value:Number):void;
		function get bytesLoaded():uint;
		function get bytesTotal():uint;
		function get client():Object;
		function set client(value:Object):void;
		function get currentFPS():Number;
		function close():void;
		function pause():void;
		function resume():void;
		function play(start:Number = -2, length:Number = -1):void;
		function seek(offset:Number):void;
		function get soundTransform():SoundTransform;
		function set soundTransform(value:SoundTransform):void;
		function get time():Number;
		function get metaData():Object;
		function get duration():Number;
	}
}
