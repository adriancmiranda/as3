package com.am.core {
	import com.greensock.loading.core.LoaderCore;
	import com.greensock.loading.LoaderMax;

	import __AS3__.vec.Vector;

	/**
	 * @author Adrian C. Miranda <adriancmiranda@gmail.com>
	 */
	public interface IApplicationLoader extends IApplicationRequest {
		function appendFiles(files:Vector.<File>):void;
		function appendFile(file:*):void;
		function parseFile(url:String, params:Object = null):LoaderCore;
		function debugPriorities():void;
		function getBackgroundLoaders():Array;
		function getAppLoaders():Array;
		function getLazyLoaders():Array;
		function getPreloaderList():Array;
		function registerFileType(extensions:String, loaderClass:Class):void;
		function prioritizeLoader(nameOrURL:String, loadNow:Boolean=true):void;
		function auditSize(value:Boolean):void;
		function loaders(...rest:Array):void;
		function plugins(...rest:Array):void;
		function load():void;
		function resume():void;
		function pause():void;
		function disposeContent(flushContent:Boolean=false):void;
		function stop(flush:Boolean = false):void;
		function unload():void;
		function getReadyLoaders(includeNested:Boolean=false):Array;
		function getLoadingLoaders(includeNested:Boolean=false):Array;
		function getPausedLoaders(includeNested:Boolean=false):Array;
		function getCompletedLoaders(includeNested:Boolean=false):Array;
		function getFailedLoaders(includeNested:Boolean=false):Array;
		function getDisposedLoaders(includeNested:Boolean=false):Array;
		function getLoaders():Array;
		function getChildrenByStatus(status:int, includeNested:Boolean=false):Array;
		function getLoader(nameOrURL:String):*;
		function getAsset(nameOrURL:String):*;
		function get contentLoaders():*;
		function get loader():LoaderMax;
		function set onBeforeLoader(closure:Function):void;
		function set onReady(closure:Function):void;
		function set onReadyParams(value:Array):void;
	}
}
