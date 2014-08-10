package com.am.core {
	import com.am.utils.num;
	import com.am.utils.bool;
	import com.am.utils.Binding;
	import com.am.errors.AMError;

	import flash.display.DisplayObject;

	/**
	 * @author Adrian C. Miranda <adriancmiranda@gmail.com>
	 > TODO: Implement loadermax!
	 */
	public final class File {
		internal namespace nsarmored = 'adriancmiranda.github.io/com/am/core/file.nsarmored';
		private var _binding:DisplayObject;
		private var _parent:View;
		private var _ownContext:Boolean;
		private var _runInBackground:Boolean;
		private var _preload:Boolean;
		private var _noCache:Boolean;
		private var _bytes:uint;
		private var _type:String;
		private var _url:String;
		private var _id:String;
		private var _xml:XML;

		// LoaderMax properties - defaults does not yet implemented
		private var _centerRegistration:Boolean;
		private var _bufferMode:Boolean;
		private var _autoPlay:Boolean;
		private var _scaleMode:String;
		private var _alpha:Number;
		private var _width:Number;
		private var _height:Number;
		private var _crop:Boolean;
		private var _autoDetachNetStream:Boolean;
		private var _allowMalformedURL:Boolean;
		private var _estimatedDuration:Number;
		private var _autoAdjustBuffer:Boolean;
		private var _checkPolicyFile:Boolean;
		private var _initThreshold:uint;
		private var _alternateURL:String;
		private var _autoDispose:Boolean;
		private var _bufferTime:Number;
		private var _deblocking:int;
		private var _smoothing:Boolean;
		private var _blendMode:String;
		private var _rotationX:Number;
		private var _rotationY:Number;
		private var _rotationZ:Number;
		private var _rotation:Number;
		private var _bgColor:uint;
		private var _bgAlpha:Number;
		private var _visible:Number;
		private var _hAlign:String;
		private var _vAlign:String;
		private var _scaleX:Number;
		private var _scaleY:Number;
		private var _volume:Number;
		private var _repeat:int;
		private var _x:Number;
		private var _y:Number;
		private var _z:Number;
		// --

		public function File(xml:XML, binding:DisplayObject = null) {
			this.validateFileNode(xml);
			this._xml = xml;
			this._binding = binding;
			this._id = xml.@id.toString();
			this._url = this.bind(xml.@url.toString());
			this._ownContext = bool(xml.@ownContext);
			this._type = xml.@type.toString() || this._url.substring(this._url.lastIndexOf('.') + 1, this._url.length);
			this._bytes = uint(num(xml.@bytes)) || 20000;
			this._preload = xml.@preload != undefined ? bool(xml.@preload) : true;
			this._noCache = xml.@noCache != undefined ? bool(xml.@noCache) : true;

			// LoaderMax properties - defaults does not yet implemented
			this._centerRegistration = bool(xml.@centerRegistration);
			this._bufferMode = bool(xml.@bufferMode);
			this._autoPlay = bool(xml.@autoPlay);
			this._scaleMode = xml.@scaleMode != undefined ? xml.@scaleMode.toString() : 'none';
			this._alpha = xml.@alpha != undefined ? Math.max(0, num(xml.@alpha)) : 1;
			this._width = xml.@width != undefined ? Math.max(0, num(xml.@width)) : NaN;
			this._height = xml.@height != undefined ? Math.max(0, num(xml.@height)) : NaN;
			this._crop = bool(xml.@crop);
			this._autoDetachNetStream = bool(xml.@autoDetachNetStream);
			this._allowMalformedURL = bool(xml.@allowMalformedURL);
			this._estimatedDuration = xml.@estimatedDuration != undefined ? Math.max(0, num(xml.@estimatedDuration)) : NaN;
			this._autoAdjustBuffer = bool(xml.@autoAdjustBuffer);
			this._checkPolicyFile = bool(xml.@checkPolicyFile);
			this._initThreshold = xml.@initThreshold != undefined ? uint(num(xml.@initThreshold)) : 102400;
			this._alternateURL = xml.@alternateURL.toString() || null;
			this._autoDispose = bool(xml.@autoDispose);
			this._bufferTime = num(xml.@bufferTime || 5);
			this._deblocking = int(num(xml.@deblocking));
			this._smoothing = bool(xml.@smoothing);
			this._blendMode = xml.@blendMode.toString();
			this._rotationX = xml.@rotationX != undefined ? num(xml.@rotationX) : NaN;
			this._rotationY = xml.@rotationY != undefined ? num(xml.@rotationY) : NaN;
			this._rotationZ = xml.@rotationZ != undefined ? num(xml.@rotationZ) : NaN;
			this._rotation = xml.@rotation != undefined ? num(xml.@rotation) : NaN;
			this._bgColor = uint(num(xml.@bgColor));
			this._bgAlpha = num(xml.@bgAlpha);
			this._visible = num(xml.@visible);
			this._hAlign = xml.@hAlign.toString();
			this._vAlign = xml.@vAlign.toString();
			this._scaleX = xml.@scaleX != undefined ? num(xml.@scaleX) : 1;
			this._scaleY = xml.@scaleY != undefined ? num(xml.@scaleY) : 1;
			this._volume = xml.@volume != undefined ? Math.max(0, num(xml.@volume)) : 1;
			this._repeat = int(num(xml.@repeat));
			this._x = xml.@x != undefined ? num(xml.@x) : NaN;
			this._y = xml.@y != undefined ? num(xml.@y) : NaN;
			this._z = xml.@z != undefined ? num(xml.@z) : NaN;
			// --

			if (xml.attribute('run-in-background') != undefined) {
				this._preload = false;
				this._runInBackground = bool(xml.attribute('run-in-background'));
			}
		}

		private function validateFileNode(node:XML):void {
			var error:String = '*Invalid Views XML* File ';
			if (node == null) {
				throw new AMError(error + 'node missing required');
			}
			else if (node.@id == undefined) {
				throw new AMError(error + 'node missing required attribute \'id\'');
			}
			else if (!/^([a-zA-Z0-9-_])+$/g.test(node.@id)) {
				throw new AMError(error + node.@id + ' \'id\' attribute contains invalid characters');
			}
			else if (node.@url == undefined) {
				throw new AMError(error + 'node missing required attribute \'url\'');
			}
			else if (!Binding.isValid(node.@url)) {
				throw new AMError(error + node.@id + ' \'url\' attribute contains invalid binding expression \'' + node.@url + '\'');
			}
			else {
				for each (var id:String in node.parent().file.@id) {
					if (node.parent().file.(@id == id).length() > 1) {
						throw new AMError(error + id + ' node duplicate');
					}
				}
			}
		}

		private function bind(raw:String):String {
			if (this._binding) {
				raw = Binding.bind(raw, this._binding);
			}
			return raw;
		}

		// LoaderMax properties - no yet implemented
		public function get centerRegistration():Boolean {
			return this._centerRegistration;
		}

		public function get bufferMode():Boolean {
			return this._bufferMode;
		}

		public function get scaleMode():String {
			return this._scaleMode;
		}

		public function get autoPlay():Boolean {
			return this._autoPlay;
		}

		public function get autoDetachNetStream():Boolean {
			return this._autoDetachNetStream;
		}

		public function get allowMalformedURL():Boolean {
			return this._allowMalformedURL;
		}

		public function get estimatedDuration():Number {
			return this._estimatedDuration;
		}

		public function get autoAdjustBuffer():Boolean {
			return this._autoAdjustBuffer;
		}

		public function get checkPolicyFile():Boolean {
			return this._checkPolicyFile;
		}

		public function get initThreshold():uint {
			return this._initThreshold;
		}

		public function get alternateURL():String {
			return this._alternateURL;
		}

		public function get autoDispose():Boolean {
			return this._autoDispose;
		}

		public function get bufferTime():Number {
			return this._bufferTime;
		}

		public function get deblocking():int {
			return this._deblocking;
		}

		public function get smoothing():Boolean {
			return this._smoothing;
		}

		public function get blendMode():String {
			return this._blendMode;
		}

		public function get rotationX():Number {
			return this._rotationX;
		}

		public function get rotationY():Number {
			return this._rotationY;
		}

		public function get rotationZ():Number {
			return this._rotationZ;
		}

		public function get rotation():Number {
			return this._rotation;
		}

		public function get bgColor():uint {
			return this._bgColor;
		}

		public function get bgAlpha():Number {
			return this._bgAlpha;
		}

		public function get visible():Number {
			return this._visible;
		}

		public function get hAlign():String {
			return this._hAlign;
		}

		public function get vAlign():String {
			return this._vAlign;
		}

		public function get scaleX():Number {
			return this._scaleX;
		}

		public function get scaleY():Number {
			return this._scaleY;
		}

		public function get volume():Number {
			return this._volume;
		}

		public function get repeat():int {
			return this._repeat;
		}

		public function get x():Number {
			return this._x;
		}

		public function get y():Number {
			return this._y;
		}

		public function get z():Number {
			return this._z;
		}

		public function get alpha():Number {
			return this._alpha;
		}

		public function get width():Number {
			return this._width;
		}

		public function get height():Number {
			return this._height;
		}

		public function get crop():Boolean {
			return this._crop;
		}
		// --

		public function get binding():DisplayObject {
			return this._binding;
		}

		nsarmored function set parent(value:View):void {
			this._parent = value;
		}

		public function get parent():View {
			return this._parent;
		}

		public function get preload():Boolean {
			return this._preload;
		}

		public function get noCache():Boolean {
			return this._noCache;
		}

		public function get ownContext():Boolean {
			return this._ownContext;
		}

		public function get runInBackground():Boolean {
			return this._runInBackground;
		}

		public function get bytes():uint {
			return this._bytes;
		}

		public function get type():String {
			return this._type;
		}

		public function get url():String {
			return this._url;
		}

		public function get id():String {
			return this._id;
		}

		public function get xml():XML {
			return this._xml;
		}

		public function dispose(flush:Boolean = false):void {
			this._binding = null;
			this._parent = null;
			this._xml = null;
			this._id = null;
		}

		public function toString():String {
			return '[File ' + this._id + ']';
		}
	}
}
