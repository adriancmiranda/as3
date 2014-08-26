package com.am.display {
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.core.LoaderCore;

	import com.am.utils.num;

	import flash.events.ProgressEvent;
	import flash.events.IOErrorEvent;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.display.Loader;
	import flash.display.DisplayObject;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.system.SecurityDomain;
	import flash.system.Security;
	import flash.errors.IllegalOperationError;
	import flash.utils.ByteArray;

	/**
	 * @author Adrian C. Miranda <adriancmiranda@gmail.com>
	 */
	public class ThumbnailLite extends ButtonLite implements IThumb {
		private var _lastContent:*;
		private var _content:*;
		private var _percentage:Number;
		private var _loaded:Boolean;
		private var _url:String;
		
		public function ThumbnailLite(urlOrRequest:* = null, groupName:String = null, hide:Boolean = false, allow:Boolean = false) {
			if (allow) {
				Security.allowDomain('*');
				Security.allowInsecureDomain('*');
			}
			this.load(urlOrRequest);
			super(groupName, hide);
		}

		override protected function onAddedToStage(event:Event):void {
			super.onAddedToStage(event);
		}

		override protected function onRemovedFromStage(event:Event):void {
			super.onRemovedFromStage(event);
			this.removeLastContent(true);
			this.removeContent(true);
		}

		public function removeLastContent(flush:Boolean = false):void {
			if (this._lastContent) {
				if (this._lastContent.parent) {
					this._lastContent.parent.removeChild(this._lastContent);
				}
				if (flush) {
					this._lastContent = null;
				}
			}
		}

		public function removeContent(flush:Boolean = false):void {
			if (this._content) {
				if (this._content.parent) {
					this._content.parent.removeChild(this._content);
				}
				if (flush) {
					this._content = null;
				}
			}
		}
		
		public function load(urlOrRequest:*):void {
			if (urlOrRequest is LoaderCore) {
				this._loaded = false;
				this._percentage = 0;
				urlOrRequest.addEventListener(LoaderEvent.ERROR, this.onThumbIOError);
				urlOrRequest.addEventListener(LoaderEvent.PROGRESS, this.onThumbLoading);
				urlOrRequest.addEventListener(LoaderEvent.COMPLETE, this.onThumbLoaded);
				urlOrRequest.load();
			} else if (urlOrRequest is URLRequest || urlOrRequest is String) {
				this._loaded = false;
				this._url = urlOrRequest is URLRequest ? urlOrRequest.url : urlOrRequest;
				this._percentage = 0;
				var loader:Loader = new Loader();
				loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, this.onThumbIOError);
				loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, this.onThumbLoading);
				loader.contentLoaderInfo.addEventListener(Event.COMPLETE, this.onThumbLoaded);
				loader.load(new URLRequest(this._url), new LoaderContext(false, ApplicationDomain.currentDomain));
			} else if (urlOrRequest is DisplayObject) {
				this._loaded = false;
				this._url = null;
				this._percentage = 0;
				this._lastContent = this._content;
				this._content = urlOrRequest;
				this.onThumbLoaded(null);
			}
		}
		
		public function loadBytes(bytes:ByteArray):void {
			this._loaded = false;
			this._percentage = 0;
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, this.onThumbLoading);
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, this.onThumbIOError);
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, this.onThumbLoaded);
			loader.loadBytes(bytes, new LoaderContext(false, ApplicationDomain.currentDomain));
		}

		private function onThumbLoading(event:*):void {
			if (event is LoaderEvent) {
				this._percentage = Math.round(event.target.progress * 100);
			} else if (event is ProgressEvent) {
				this._percentage = percentage(event.bytesLoaded, event.bytesTotal);
			}
			this.progress();
		}
		
		private function onThumbLoaded(event:*):void {
			if (event is Event || event is LoaderEvent) {
				this._lastContent = this._content;
				this._content = event.target.content;
			}
			if (this.onLoad != null) {
				this.onLoad.apply(super, this.onLoadParams);
			}
			this._loaded = true;
			this.loaded();
		}
		
		private function onThumbIOError(event:*):void {
			this.ioError();
		}
		
		public function get url():String {
			return this._url;
		}

		public function get lastContent():* {
			return this._lastContent;
		}
		
		public function get content():* {
			return this._content;
		}

		public function get percent():Number {
			return this._percentage;
		}

		public function get isLoaded():Boolean {
			return this._loaded;
		}

		protected function progress():void {
			// to override
		}
		
		protected function loaded():void {
			// to override
		}
		
		protected function ioError():void {
			// to override
		}
		
		override public function toString():String {
			return '[ThumbnailLite ' + super.name + ']';
		}
	}
}
