package com.am.core {
	import flash.display.DisplayObjectContainer;

	/**
	 * @author Adrian C. Miranda <adriancmiranda@gmail.com>
	 */
	public interface IApplication extends IApplicationFacade {
		function layers(data:*, target:DisplayObjectContainer = null):IApplication;
		function params(data:*, useOwnPrintf:Boolean = false):IApplication;
		function tracks(data:*, useOwnPrintf:Boolean = false):IApplication;
		function texts(data:*, useOwnPrintf:Boolean = false):IApplication;
		function links(data:*, useOwnPrintf:Boolean = false):IApplication;
		function get info():ApplicationData;
	}
}
