package com.am.interfaces {
	import com.am.data.Language;
	import com.am.data.View;

	import flash.display.DisplayObjectContainer;
	import flash.display.Stage;

	/**
	 * @author Adrian C. Miranda <adriancmiranda@gmail.com>
	 */
	public interface IApplicationFacade extends IApplicationLoader {
		function classes(...rest:Array):void;
		function run(viewLayerIdOrDisplayObject:* = null):void;
		function get section():ISection;
		function get container():DisplayObjectContainer;
		function get stage():Stage;
	}
}
