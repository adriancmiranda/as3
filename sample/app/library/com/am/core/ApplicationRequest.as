package com.am.core {
	import com.am.display.ISection;
	import com.am.net.Request;
	import com.am.utils.Binding;
	import com.am.errors.AMError;
	import com.am.nsapplication;

	import flash.display.DisplayObject;

	/**
	 * @author Adrian C. Miranda <adriancmiranda@gmail.com>
	 * @xml:
	 *	<header history="yes" strict="yes" connections="2" flow="normal" title="Some title">
	 *		<file id="layers" url="{@baseContent}content/settings/layers.xml" kb="4"/>
	 *		<base id="base" class="project.Base" standard="main" mistake="main">
	 *			<file id="base" url="{@baseContent}content/views/base.swf" kb="108"/>
	 *			<view id="main" class="project.areas.Main"></view>
	 *		</base>
	 *	</header>
	 *
	 * -----
	 * @usage:
	 * import com.am.core.ApplicationRequest;
	 * var app:ApplicationRequest = new ApplicationRequest('projectNameOrNothing');
	 * app.fromXML('{@fvBaseContent}content/settings/sitemap.xml');
	 * app.onParsed = onSitemapParsed;
	 * app.startup(this);
	 */
	use namespace nsapplication;
	public class ApplicationRequest extends ApplicationCore implements IApplicationRequest {
		private var _binding:DisplayObject;
		private var _request:Request;
		private var _header:Header;
		private var _base:ISection;
		private var _xml:XML;

		public function ApplicationRequest(key:String = null) {
			super(key);
		}

		public static function getInstance(key:String = null):ApplicationRequest {
			if (!hasInstance(key)) instances[key] = new ApplicationRequest(key);
			return instances[key] as ApplicationRequest;
		}

		public function fromXML(urlOrXML:*, data:Object = null, method:String = 'GET', timeout:int = 80):void {
			if (urlOrXML is String) {
				this._request = new Request(urlOrXML, data, method, timeout);
				this._request.onResult = this.onRequestResult;
				this._request.onFault = this.onRequestFault;
				delete super.vars.source;
			}
			else if (urlOrXML is XML) {
				super.vars.source = urlOrXML;
				if (this._request) {
					this._request.close(true);
					this._request = null;
				}
			}
			else {
				var error:String = '*Invalid Views XML* ApplicationRequest ';
				throw new AMError(error + 'fromXML method should receive a data type String or XML');
			}
		}

		public function startup(binding:DisplayObject = null):void {
			this._binding = binding;
			// > TODO: Make this thing right.
			// @usage: '{@bind}string'['bind']();
			String.prototype.bind = function():String {
				return Binding.bind(String(this), this._binding);
			};
			if (this._request) {
				this._request.send(this.bind(this._request.url));
			}
			else if (super.vars.source) {
				this.onRequestResult();
			}
		}

		protected function onRequestResult():void {
			this._xml = this._request ? this._request.xml : super.vars.source;
			this._header = new Header(this._xml, this._binding);
			if (super.vars.onParsed) {
				super.vars.onParsed.apply(null, super.vars.onParsedParams);
			}
		}

		protected function onRequestFault():void {
			if (super.vars.onFault) {
				super.vars.onFault.apply(null, super.vars.onFaultParams);
			} else {
				trace('ERROR: ' + this._request.url + ' failed to load.');
			}
		}

		public function set onParsed(closure:Function):void {
			super.vars.onParsed = closure;
		}

		public function set onParsedParams(value:Array):void {
			super.vars.onParsedParams = value;
		}

		public function set onFault(closure:Function):void {
			super.vars.onFault = closure;
		}

		public function set onFaultParams(value:Array):void {
			super.vars.onFaultParams = value;
		}

		protected function get parsed():Boolean {
			return this._request ? this._request.rawData != null : false;
		}

		public function get base():ISection {
			if (this.header && !_base) {
				_base = new this.header.views.root.caste();
				_base.name = this.header.views.root.className;
				_base.apiKey = super.apiKey;
			}
			return _base;
		}

		public function getLanguage(id:* = ''):Language {
			return this.header ? this.header.languages.getLanguage(id) : null;
		}

		public function getView(id:* = ''):View {
			return this.header ? this.header.views.getView(id) : null;
		}

		public function getFile(id:* = 0):File {
			return this.header ? this.header.views.getFile(id) : null;
		}

		public function get views():View {
			return this.header ? this.header.views : null;
		}

		public function get binding():DisplayObject {
			return this._binding;
		}

		public function get header():Header {
			return this._header;
		}

		public function get xml():XML {
			return this._xml;
		}

		public function bind(raw:String):String {
			if (this._binding) {
				raw = Binding.bind(raw, this._binding);
			}
			return raw;
		}

		override public function dispose(flush:Boolean = false):void {
			this._base = null;
			if (this._request) {
				this._request.close(true);
				this._request = null;
			}
			if (this._header) {
				this._header.dispose();
				this._header = null;
			}
			if (flush) {
				this._binding = null;
				this._xml = null;
			}
			super.dispose(flush);
		}

		override public function toString():String {
			return '[ApplicationRequest ' + super.apiKey + ']';
		}
	}
}
