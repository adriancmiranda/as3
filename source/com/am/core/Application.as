package com.am.core {
	import com.am.nsapplication;

	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;

	/**
	 * @author Adrian C. Miranda <adriancmiranda@gmail.com>
	 */
	use namespace nsapplication;
	public final class Application extends ApplicationFacade implements IApplication {
		private var _data:ApplicationData;

		public function Application(key:String = null) {
			super(key);
		}

		public static function getInstance(key:String = null):IApplication {
			if (!hasInstance(key)) instances[key] = new Application(key);
			return instances[key] as Application;
		}

		override public function startup(binding:DisplayObject = null):void {
			super.startup(binding);
			this._data = new ApplicationData(super.stage.loaderInfo.bytes);
			this.params(super.stage.loaderInfo.parameters);
		}

		public function layers(data:*, target:DisplayObjectContainer = null):IApplication {
			Layers.fromXML(super.getAsset(data) || data, target || DisplayObjectContainer(super.binding), null);
			return this;
		}

		public function params(data:*, useOwnPrintf:Boolean = false):IApplication {
			Parameters.parse(super.getAsset(data) || data, useOwnPrintf, null);
			return this;
		}

		public function tracks(data:*, useOwnPrintf:Boolean = false):IApplication {
			Analytics.init(super.getAsset(data) || data, super.stage);
			return this;
		}

		public function texts(data:*, useOwnPrintf:Boolean = false):IApplication {
			Texts.parse(super.getAsset(data) || data, useOwnPrintf, null);
			return this;
		}

		public function links(data:*, useOwnPrintf:Boolean = false):IApplication {
			Links.parse(super.getAsset(data) || data, useOwnPrintf, null);
			return this;
		}

		public function get info():ApplicationData {
			return this._data;
		}
	}
}
