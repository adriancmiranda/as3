package com.am.core {
	import com.am.utils.bool;
	import com.am.errors.AMError;
	import com.am.nsapplication;

	import com.greensock.events.LoaderEvent;
	import com.greensock.plugins.TweenPlugin;
	import com.greensock.loading.LoaderStatus;
	import com.greensock.loading.core.LoaderCore;
	import com.greensock.loading.core.LoaderItem;
	import com.greensock.loading.LoaderMax;
	import com.greensock.loading.MP3Loader;

	import __AS3__.vec.Vector;
	import flash.events.Event;
	import flash.display.DisplayObject;
	import flash.media.SoundLoaderContext;
	import flash.system.LoaderContext;

	/**
	 * @author Adrian C. Miranda <adriancmiranda@gmail.com>
	 > TODO:
	 > loadermax defaults
	 > backgroundConnections (to save the user band in case of a lot queues)
	 > autoPlay (e.g. VideoLoader, SWFLoader, MP3Loader)
	 */
	use namespace nsapplication;
	public class ApplicationLoader extends ApplicationRequest implements IApplicationLoader {
		private var _soundLoaderContext:SoundLoaderContext;
		private var _loaderContext:LoaderContext;
		private var _loader:LoaderMax;
		private var _bgLoaderList:Array;
		private var _lazyLoaders:Array;
		private var _loaderList:Array;
		private var _load:Boolean;

		public function ApplicationLoader(key:String = null) {
			super(key);
		}

		public static function getInstance(key:String = null):ApplicationLoader {
			if (!hasInstance(key)) instances[key] = new ApplicationLoader(key);
			return instances[key] as ApplicationLoader;
		}

		override protected function initialize():void {
			this._loaderList = new Array();
			this._lazyLoaders = new Array();
			this._bgLoaderList = new Array();
			this._loaderContext = new LoaderContext();
			this._soundLoaderContext = new SoundLoaderContext();
			LoaderMax.defaultContext = this._loaderContext;
		}

		override public function startup(binding:DisplayObject = null):void {
			super.startup(binding);
			this._load = true;
		}

		override protected function onRequestResult():void {
			super.onRequestResult();
			if (super.header.hasFiles) {
				this.loadHeader(super.header);
			} else if (super.header.views.root.hasFiles) {
				if (super.vars.onReady) {
					super.vars.onReady.apply(null, super.vars.onReadyParams);
				}
				if (super.header.prioritize) {
					this.prioritizeLoader(super.header.prioritize);
				}
				this.prepareViewLoader(super.header.views.root);
				for each (var view:View in super.header.views.list) {
					if (view.preload) {
						if (view.hasFiles) {
							this.appendFiles(view.files);
						}
					}
				}
				if (super.vars.onBeforeLoader) {
					super.vars.onBeforeLoader.apply(null, super.vars.onBeforeLoaderParams);
				}
				if (this._load) {
					this.load();
				}
			} else {
				if (super.vars.onReady) {
					super.vars.onReady.apply(null, super.vars.onReadyParams);
				}
				onComplete(new LoaderEvent(LoaderEvent.COMPLETE, this));
			}
		}

		//////////////////////////////////////////////////////////////////////////////////////////////////////////
		//
		//
		// HEADER
		//
		//
		//////////////////////////////////////////////////////////////////////////////////////////////////////////

		protected function loadHeader(header:Header):void {
			if (this._loader) {
				this.stop(true);
			}
			this._loader = new LoaderMax( { name:'header', maxConnections:header.connections } );
			this._loader.addEventListener(LoaderEvent.COMPLETE, this.onHeaderComplete);
			this.appendFiles(header.files);
			this._loader.load();
		}

		protected function onHeaderComplete(event:LoaderEvent):void {
			this._loader.removeEventListener(LoaderEvent.COMPLETE, this.onHeaderComplete);
			var load:Boolean = this._load;
			if (super.vars.onReady) {
				super.vars.onReady.apply(null, super.vars.onReadyParams);
			}
			if (super.header.views.root.hasFiles) {
				this.prepareViewLoader(super.header.views.root);
				if (load) {
					this.load();
				}
			}
		}

		//////////////////////////////////////////////////////////////////////////////////////////////////////////
		//
		//
		// VIEWS
		//
		//
		//////////////////////////////////////////////////////////////////////////////////////////////////////////

		protected function prepareViewLoader(view:View):void {
			if (this._loader) {
				this.stop();
				this._loader = null;
			}
			this._loader = new LoaderMax( { maxConnections:super.header.connections } );
			this._loader.name = view.uniqueId;
			this.appendFiles(view.files);
			this.loaderListeners('add');
		}

		//////////////////////////////////////////////////////////////////////////////////////////////////////////
		//
		//
		// BACKGROUND
		//
		//
		//////////////////////////////////////////////////////////////////////////////////////////////////////////

		protected function prepareBGLoader():void {
			if (this._loader) {
				this.stop();
				this._loader = null;
			}
			this._loader = new LoaderMax({ name:'bgloader', maxConnections:super.header.connections, onChildComplete:onViewChildComplete });
			for each (var loader:LoaderCore in this._bgLoaderList) {
				this._loader.append(loader);
			}
			if (super.header.views.root.prioritize) {
				this.prioritizeLoader(super.header.views.root.prioritize);
			}
			this._loader.load();
		}

		//////////////////////////////////////////////////////////////////////////////////////////////////////////
		//
		//
		// UTILS
		//
		//
		//////////////////////////////////////////////////////////////////////////////////////////////////////////

		public function appendFiles(files:Vector.<File>):void {
			for each (var file:File in files) {
				this.appendFile(file);
			}
		}

		public function appendFile(file:*):void {
			if (this._loader) {
				var core:LoaderCore;
				if (file is File) {
					trace(' - File \''+ file.id +'\' ({'+ file.url +'})'+ (!file.preload ? (file.runInBackground ? ' running in background' : ' stopped') : ' downloading'));
					core = this.parseFile(file.url, {
						  name: file.id
						, ownContext: ((file.parent && file.parent.ownContext) || file.ownContext)
						, noCache: file.noCache
						, centerRegistration: file.centerRegistration
						, bufferMode: file.bufferMode
						, autoPlay: file.autoPlay
						, scaleMode: file.scaleMode
						, alpha: file.alpha
						, width: file.width
						, height: file.height
						, crop: file.crop
						, autoDetachNetStream: file.autoDetachNetStream
						, allowMalformedURL: file.allowMalformedURL
						, estimatedDuration: file.estimatedDuration
						, autoAdjustBuffer: file.autoAdjustBuffer
						, checkPolicyFile: file.checkPolicyFile
						, initThreshold: file.initThreshold
						, alternateURL: file.alternateURL
						, autoDispose: file.autoDispose
						, bufferTime: file.bufferTime
						, deblocking: file.deblocking
						, smoothing: file.smoothing
						, blendMode: file.blendMode
						, rotationX: file.rotationX
						, rotationY: file.rotationY
						, rotationZ: file.rotationZ
						, rotation: file.rotation
						, bgColor: file.bgColor
						, bgAlpha: file.bgAlpha
						// LoaderMax properties - no yet implemented
						//, visible: file.visible//Number
						, hAlign: file.hAlign
						, vAlign: file.vAlign
						, scaleX: file.scaleX
						, scaleY: file.scaleY
						, volume: file.volume
						, repeat: file.repeat
						, x: file.x
						, y: file.y
						, z: file.z
						, autoLoad: false
					});
					core.vars.integrateProgress = file.preload;
					core.vars.estimatedBytes = file.bytes;
				} else if (file is LoaderItem) {
					file.url = super.bind(file.url);
					file.vars.name = file.vars.name || file.url;
					core = file;
				}
				if (core && file) {
					if (file.runInBackground) {
						this._bgLoaderList.push(core);
					} else if (file.preload) {
						this._loader.append(core);
						this._loaderList.push(core);
					} else {
						this._lazyLoaders.push(core);
					}
				}
			} else {
				throw new AMError('*Invalid View Loader* ApplicationLoader call \'prepareViewLoader\' before departure');
			}
		}

		public function parseFile(url:String, params:Object = null):LoaderCore {
			var core:LoaderCore = LoaderMax.parse(url, params);
			if (!bool(params.ownContext)) {
				core.vars.context = core is MP3Loader ? this._soundLoaderContext : this._loaderContext;
			} else {
				trace('\t- using own context');
				core.vars.context = new LoaderContext();
			}
			return core;
		}

		public function debugPriorities():void {
			if (this._loader) {
				var id:int = -1;
				while (++id < this._loader.loaders.length) {
					trace(this._loader.getChildIndex(this._loader.loaders[id]) + 1, this._loader.loaders[id]);
				}
				trace('-');
			}
		}

		//////////////////////////////////////////////////////////////////////////////////////////////////////////
		//
		//
		// GETTERS
		//
		//
		//////////////////////////////////////////////////////////////////////////////////////////////////////////

		public function getBackgroundLoaders():Array {
			return this._bgLoaderList.concat();
		}

		public function getAppLoaders():Array {
			return this.getBackgroundLoaders().concat(this.getPreloaderList()).concat(this.getLazyLoaders());
		}

		public function getLazyLoaders():Array {
			return (this._lazyLoaders || []).concat();
		}

		public function getPreloaderList():Array {
			return this._loaderList.concat();
		}

		//////////////////////////////////////////////////////////////////////////////////////////////////////////
		//
		//
		// HANDLERS
		//
		//
		//////////////////////////////////////////////////////////////////////////////////////////////////////////

		private function loaderListeners(action:String):void {
			if (this._loader && !this._loader.hasEventListener(LoaderEvent.COMPLETE)) {
				this._loader[action+'EventListener'](LoaderEvent.COMPLETE, this.onComplete);
				this._loader[action+'EventListener'](LoaderEvent.CHILD_COMPLETE, this.onViewChildComplete);
				this._loader[action+'EventListener'](LoaderEvent.CHILD_PROGRESS, this.notifierHandler);
				this._loader[action+'EventListener'](LoaderEvent.CHILD_CANCEL, this.notifierHandler);
				this._loader[action+'EventListener'](LoaderEvent.CHILD_FAIL, this.notifierHandler);
				this._loader[action+'EventListener'](LoaderEvent.CHILD_OPEN, this.notifierHandler);
				this._loader[action+'EventListener'](LoaderEvent.PROGRESS, this.notifierHandler);
				this._loader[action+'EventListener'](LoaderEvent.CANCEL, this.notifierHandler);
				this._loader[action+'EventListener'](LoaderEvent.UNLOAD, this.notifierHandler);
				this._loader[action+'EventListener'](LoaderEvent.ERROR, this.notifierHandler);
				this._loader[action+'EventListener'](LoaderEvent.FAIL, this.notifierHandler);
				this._loader[action+'EventListener'](LoaderEvent.OPEN, this.notifierHandler);
				this._loader[action+'EventListener'](LoaderEvent.INIT, this.notifierHandler);
			}
		}

		protected function notifierHandler(event:LoaderEvent):void {
			super.dispatchEvent(event.clone());
		}

		protected function onViewChildComplete(event:LoaderEvent):void {
			var priority:uint = this._loader.getChildIndex(event.target as LoaderCore) + 1;
			super.dispatchEvent(event.clone());
		}

		protected function onComplete(event:LoaderEvent):void {
			trace('-');
			prepareBGLoader();
			super.dispatchEvent(event.clone());
		}

		//////////////////////////////////////////////////////////////////////////////////////////////////////////
		//
		//
		// PROXIES
		//
		//
		//////////////////////////////////////////////////////////////////////////////////////////////////////////

		public function registerFileType(extensions:String, loaderClass:Class):void {
			LoaderMax.registerFileType(extensions, loaderClass);
		}

		public function prioritizeLoader(nameOrURL:String, loadNow:Boolean=true):void {
			LoaderMax.prioritize(nameOrURL, loadNow);
		}

		public function auditSize(value:Boolean):void {
			LoaderMax.defaultAuditSize = value;
		}

		public function loaders(...rest:Array):void {
			LoaderMax.activate(rest.slice());
		}

		public function plugins(...rest:Array):void {
			TweenPlugin.activate(rest.slice());
		}

		public function load():void {
			this._load = true;
			if (this._loader) {
				this._loader.load();
			}
		}

		public function resume():void {
			this._load = true;
			if (this._loader) {
				this._loader.resume();
			}
		}

		public function pause():void {
			this._load = false;
			if (this._loader) {
				this._loader.pause();
			}
		}

		public function disposeContent(flushContent:Boolean=false):void {
			this._load = false;
			if (this._loader) {
				this._loader.dispose(flushContent);
			}
		}

		public function stop(flush:Boolean = false):void {
			this._load = false;
			if (this._loader) {
				this.pause();
				this.loaderListeners('remove');
				if (flush) {
					this.unload();
					this._loader = null;
				}
			}
		}

		public function unload():void {
			this._load = false;
			if (this._loader) {
				this._loader.unload();
			}
		}

		public function getReadyLoaders(includeNested:Boolean=false):Array {
			return this.getChildrenByStatus(LoaderStatus.READY, includeNested);
		}

		public function getLoadingLoaders(includeNested:Boolean=false):Array {
			return this.getChildrenByStatus(LoaderStatus.LOADING, includeNested);
		}

		public function getPausedLoaders(includeNested:Boolean=false):Array {
			return this.getChildrenByStatus(LoaderStatus.PAUSED, includeNested);
		}

		public function getCompletedLoaders(includeNested:Boolean=false):Array {
			return this.getChildrenByStatus(LoaderStatus.COMPLETED, includeNested);
		}

		public function getFailedLoaders(includeNested:Boolean=false):Array {
			return this.getChildrenByStatus(LoaderStatus.FAILED, includeNested);
		}

		public function getDisposedLoaders(includeNested:Boolean=false):Array {
			return this.getChildrenByStatus(LoaderStatus.DISPOSED, includeNested);
		}

		public function getLoaders():Array {
			if (this._loader) {
				return this._loader.loaders;
			}
			return [];
		}

		public function getChildrenByStatus(status:int, includeNested:Boolean=false):Array {
			if (this._loader) {
				return this._loader.getChildrenByStatus(LoaderStatus.COMPLETED, includeNested);
			}
			return [];
		}

		public function getLoader(nameOrURL:String):* {
			return LoaderMax.getLoader(nameOrURL);
		}

		public function getAsset(nameOrURL:String):* {
			return LoaderMax.getContent(nameOrURL);
		}

		public function get contentLoaders():* {
			if (this._loader) {
				return this._loader.content;
			}
			return [];
		}

		public function get loader():LoaderMax {
			return this._loader;
		}

		//////////////////////////////////////////////////////////////////////////////////////////////////////////
		//
		//
		// CLOSURES
		//
		//
		//////////////////////////////////////////////////////////////////////////////////////////////////////////

		public function set onBeforeLoader(closure:Function):void {
			super.vars.onBeforeLoader = closure;
		}

		public function set onReady(closure:Function):void {
			super.vars.onReady = closure;
		}

		public function set onReadyParams(value:Array):void {
			super.vars.onReadyParams = value;
		}

		//////////////////////////////////////////////////////////////////////////////////////////////////////////
		//
		//
		// COMMON
		//
		//
		//////////////////////////////////////////////////////////////////////////////////////////////////////////

		override public function dispose(flush:Boolean = false):void {
			this.stop(flush);
			if (flush) {
				this._soundLoaderContext = null;
				this._loaderContext = null;
			}
			super.dispose(flush);
		}

		override public function toString():String {
			return '[ApplicationLoader ' + super.apiKey + ']';
		}
	}
}
