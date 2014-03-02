package com.am.display {
	import com.am.display.Leprechaun;
	import flash.display.BitmapData;
	import flash.events.Event;

	/**
	 * @author Adrian C. Miranda <adriancmiranda@gmail.com>
	 */
	public class Square extends Leprechaun {
		private var _fill:*;
		private var _width:Number;
		private var _height:Number;
		private var _alpha:Number;
		private var _topLeftRadius:Number;
		private var _topRightRadius:Number;
		private var _bottomLeftRadius:Number;
		private var _bottomRightRadius:Number;

		public function Square(fill:* = 0x0, width:Number = 1, height:Number = 1, alpha:Number = 1, topLeftRadius:Number = 0, topRightRadius:Number = 0, bottomLeftRadius:Number = 0, bottomRightRadius:Number = 0) {
			super.addEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedFromStage, false, 0, true);
			this._fill = fill;
			this._width = width;
			this._height = height;
			this._alpha = alpha;
			this._topLeftRadius = topLeftRadius;
			this._topRightRadius = topRightRadius;
			this._bottomLeftRadius = bottomLeftRadius;
			this._bottomRightRadius = bottomRightRadius;
			this.draw();
		}

		private function onRemovedFromStage(event:Event):void {
			super.removeEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedFromStage, false);
			super.graphics.clear();
			this._bottomRightRadius = NaN;
			this._bottomLeftRadius = NaN;
			this._topRightRadius = NaN;
			this._topLeftRadius = NaN;
			this._alpha = NaN;
			this._height = NaN;
			this._width = NaN;
			this._fill = null;
		}

		private function draw():void {
			super.graphics.clear();
			if (this._fill is BitmapData) {
				super.graphics.beginBitmapFill(this._fill, null, true);
			} else if (this._fill is uint) {
				super.graphics.beginFill(this._fill, this._alpha);
			}
			super.graphics.drawRoundRectComplex(0, 0, this._width, this._height, this._topLeftRadius, this._topRightRadius, this._bottomLeftRadius, this._bottomRightRadius);
			super.graphics.endFill();
		}

		public function set fill(value:*):void {
			this._fill = value;
			this.draw();
		}

		override public function size(width:Number, height:Number):void {
			this._width = width;
			this._height = height;
			this.draw();
		}

		override public function set height(value:Number):void {
			this._height = value;
			this.draw();
		}

		override public function set width(value:Number):void {
			this._width = value;
			this.draw();
		}

		public function set topLeftRadius(value:Number):void {
			this._topLeftRadius = value;
			this.draw();
		}

		public function set topRightRadius(value:Number):void {
			this._topRightRadius = value;
			this.draw();
		}

		public function set bottomLeftRadius(value:Number):void {
			this._bottomLeftRadius = value;
			this.draw();
		}

		public function set bottomRightRadius(value:Number):void {
			this._bottomRightRadius = value;
			this.draw();
		}

		override public function toString():String {
			return '[Square ' + super.name + ']';
		}
	}
}
