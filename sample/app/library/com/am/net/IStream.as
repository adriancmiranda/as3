package com.am.net {
	import flash.net.NetConnection;

	/**
	 * @author Adrian C. Miranda <adriancmiranda@gmail.com>
	 */
	public interface IStream extends INetStream {
		function get connection():NetConnection;
		function get bufferPercent():Number;
		function get bytesPercent():Number;
		function get buffer():Number;
		function get bytes():Number;
		function get buffered():Boolean;
		function get loaded():Boolean;
		function get paused():Boolean;
		function stop():void;
	}
}
