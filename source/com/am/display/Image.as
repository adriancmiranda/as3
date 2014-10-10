package com.am.display {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Matrix;
	import flash.events.Event;

	/**
	 * @author Adrian C. Miranda <adriancmiranda@gmail.com>
	 */
	dynamic public class Image extends Bitmap implements IBitmap {
		private var _translateX:Number = 0;
		private var _translateY:Number = 0;
		private var _scaleX:Number = 1;
		private var _scaleY:Number = 1;
		private var _rotate:Number = 0;

		public function Image(bitmapData:BitmapData = null, pixelSnapping:String = 'auto', smoothing:Boolean = false) {
			super(bitmapData, pixelSnapping, smoothing);
			super.addEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage, false, 0, true);
		}

		protected function onAddedToStage(event:Event):void {
			super.removeEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage, false);
            super.addEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedFromStage, false, 0, true);
		}

		protected function onRemovedFromStage(event:Event):void {
			super.removeEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedFromStage, false);
			super.bitmapData.dispose();
		}

		public function removeAllEventListener():void {
			// never implement
		}

		public function set rotate(value:Number):void {
			this._rotate = value;
			var rotateMatrix:Matrix = new Matrix();
			rotateMatrix.rotate(this._rotate);
			super.bitmapData.draw(this, rotateMatrix);
		}

		public function get rotate():Number {
			return this._rotate;
		}

		public function set translate(value:Number):void {
			this.sx(value);
			this.sy(value);
		}

		public function set tx(value:Number):void {
			this._translateX = value;
			var translateMatrix:Matrix = new Matrix();
			translateMatrix.translate(this._translateX, this._translateY);
			super.bitmapData.draw(this, translateMatrix);
		}

		public function get tx():Number {
			return this._translateX;
		}

		public function set ty(value:Number):void {
			this._translateY = value;
			var translateMatrix:Matrix = new Matrix();
			translateMatrix.translate(this._translateX, this._translateY);
			super.bitmapData.draw(this, translateMatrix);
		}

		public function get ty():Number {
			return this._translateY;
		}

		public function set scale(value:Number):void {
			this.sx(value);
			this.sy(value);
		}

		public function set sx(value:Number):void {
			this._scaleX = value;
			var scaleMatrix:Matrix = new Matrix();
			scaleMatrix.scale(this._scaleX, this._scaleY);
			super.bitmapData.draw(this, scaleMatrix);
		}

		public function get sx():Number {
			return this._scaleX;
		}

		public function set sy(value:Number):void {
			this._scaleY = value;
			var scaleMatrix:Matrix = new Matrix();
			scaleMatrix.scale(this._scaleX, this._scaleY);
			super.bitmapData.draw(this, scaleMatrix);
		}

		public function get sy():Number {
			return this._scaleY;
		}

		override public function toString():String {
			return '[Image ' + super.name + ']';
		}
	}
}
