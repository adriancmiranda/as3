package com.am.interfaces {
	import com.am.data.Language;
	import com.am.data.Header;
	import com.am.data.View;
	import com.am.data.File;

	import flash.display.DisplayObject;

	/**
	 * @author Adrian C. Miranda <adriancmiranda@gmail.com>
	 */
	public interface IApplicationRequest extends IApplicationCore {
		function fromXML(urlOrXML:*, data:Object = null, method:String = 'GET', timeout:int = 80):void;
		function startup(binding:DisplayObject = null):void
		function set onParsed(closure:Function):void;
		function set onParsedParams(value:Array):void;
		function set onFault(closure:Function):void;
		function set onFaultParams(value:Array):void;
		function get base():ISection;
		function getLanguage(id:* = ''):Language;
		function getView(id:* = ''):View;
		function getFile(id:* = 0):File;
		function get views():View;
		function get binding():DisplayObject;
		function get header():Header;
		function get xml():XML;
		function bind(raw:String):String;
	}
}
