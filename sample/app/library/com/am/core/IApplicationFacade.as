package com.am.core {
	import com.am.display.ISection;

	import flash.display.DisplayObjectContainer;
	import flash.display.Stage;

	/**
	 * @author Adrian C. Miranda <adriancmiranda@gmail.com>
	 */
	public interface IApplicationFacade extends IApplicationLoader {
		function classes(...rest:Array):void;
		function run(viewLayerIdOrDisplayObject:* = null):void;
		function get parameters():Object;
		function call(jsFunction:String, ...rest:Array):*;
		function href(url:String, target:String = '_self'):void;
		function popup(url:String, name:String = 'popup', options:String = '""', handler:String = ''):void;
		function getBaseURL():String;
		function getStrict():Boolean;
		function setStrict(strict:Boolean):void;
		function getHistory():Boolean;
		function setHistory(history:Boolean):void;
		function getTracker():String;
		function setTracker(tracker:String):void;
		function getTitle():String;
		function getStatus():String;
		function setStatus(status:String):void;
		function resetStatus():void;
		function getValue():String;
		function getPath():String;
		function getQueryString(path:String = null):String;
		function hasQueryString(path:String = null):Boolean;
		function getParameter(param:String):Object;
		function getParameterNames():Array;
		function get history():Array;
		function setTitle(value:String, delimiter:String = null):void;
		function setLanguage(value:* = null):Language;
		function setView(value:* = null):View;
		function navigateTo(value:*, query:Object = null):void;
		function calculateRoute(value:* = null):Boolean;
		function reload():void;
		function go(delta:int):void;
		function up():void;
		function forward():void;
		function back():void;
		function clearHistory():void;
		function get mistakeView():View;
		function get standardLanguage():Language;
		function get standardView():View;
		function get lastLanguage():Language;
		function get lastView():View;
		function get language():Language;
		function get view():View;
		function get languages():Language;
		function get baseViews():View;
		function get pathNames():Array;
		function get section():ISection;
		function get container():DisplayObjectContainer;
		function get stage():Stage;
	}
}
