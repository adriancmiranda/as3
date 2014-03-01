package com.am.interfaces {
	import com.am.core.Application;
	
	import flash.display.DisplayObjectContainer;

	/**
	 * @author Adrian C. Miranda <adriancmiranda@gmail.com>
	 */
	public interface IApplication extends IApplicationFacade {
		function layers(data:*, target:DisplayObjectContainer = null):Application;
		function params(data:*, useOwnPrintf:Boolean = false):Application;
		function tracks(data:*, useOwnPrintf:Boolean = false):Application;
		function texts(data:*, useOwnPrintf:Boolean = false):Application;
		function links(data:*, useOwnPrintf:Boolean = false):Application;
	}
}
