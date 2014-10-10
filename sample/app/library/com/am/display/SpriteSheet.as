package com.am.display {
	import com.am.events.Dispatcher;
	import com.am.utils.Timeout;
	import com.am.utils.gridLayout;
	import com.am.utils.clamp;
	import com.am.utils.num;
	import com.am.utils.mod;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	import flash.geom.Point;
	import flash.utils.Timer;
	import flash.events.Event;
	import flash.events.TimerEvent;

	public class SpriteSheet extends Image {
		private var _timeline:Vector.<Point>;
		private var _spritesheet:Bitmap;
		private var _fps:Number;
		private var _duration:Number;
		private var _lastFrame:uint;
		private var _targetNextFrame:uint;
		private var _targetFrame:uint;
		private var _factor:uint;
		private var _currentFrame:uint;
		private var _totalFrames:uint;
		private var _tileBounds:Rectangle;
		private var _tileOffset:Point;
		private var _timer:Timer;
		private var _fromToDelay:Timeout;
		private var _playDelay:Timeout;
		private var _vars:Object;
		private var _vertical:Boolean;
		private var _reverse:Boolean;
		private var _running:Boolean;
		private var _looping:Boolean;
		private var _yoyo:Boolean;

		public function SpriteSheet(spritesheet:Bitmap, tileWidth:uint = 16, tileHeight:uint = 16, vertical:Boolean = false, columns:uint = 1, rows:uint = 1, totalFrames:uint = 1, fps:Number = 24) {
			super(new BitmapData(tileWidth, tileHeight, true, 0), 'never', true);
			this._tileBounds = new Rectangle(0, 0, tileWidth, tileHeight);
			this._tileOffset = new Point(0, 0);
			this._spritesheet = spritesheet;
			this._currentFrame = 1;
			this._totalFrames = totalFrames > 1 ? totalFrames : columns * rows;
			this._fps = fps;
			this._duration = this._totalFrames / this._fps;
			this._vertical = vertical;
			this._factor = 1;
			this._vars = {};
			this._timeline = gridLayout(this._totalFrames, this._vertical ? rows : columns, this._tileBounds.width, this._tileBounds.height, 0, 0, !this._vertical);
			this._timer = new Timer(this._fps, 0);
			this._timer.addEventListener(TimerEvent.TIMER, this.onUpdateFrames, false, 0, true);
		}

        override protected function onAddedToStage(event:Event):void {
        	super.onAddedToStage(event);
        	this.drawFrame(1);
        }

        override protected function onRemovedFromStage(event:Event):void {
            super.onRemovedFromStage(event);
			this._timer.removeEventListener(TimerEvent.TIMER, this.onUpdateFrames, false);
			this._timer.stop();
			this._timer.reset();
            this._timer = null;
            this._timeline = null;
        }

		public function fromTo(from:*, to:*, vars:Object = null):void {
			vars = vars is Object ? vars : {};
			this._fromToDelay && this._fromToDelay.cancel();
			this._fromToDelay = new Timeout(startAnimationFromTo, num(vars.delay), toString() + '_fromToDelay', [from, to, vars]);
		}

		public function play(frame:* = null, vars:Object = null):void {
			this.pause();
			if (frame is uint) {
				this._vars = vars is Object ? vars : {};
				this._targetFrame = clamp(frame, 1, this._totalFrames);
				this._reverse = this._currentFrame > this._targetFrame;
				this._factor = this._reverse ? -1 : 1;
			} else {
				this._targetFrame = 0;
			}
			if (this._vars.onInit is Function) {
				this._vars.onInit.apply(this, this._vars.onInitParams);
			}
			this.addDelay(num(this._vars.delay));
		}

		public function pause():void {
			this.removeDelay();
			this._timer.stop();
			this._timer.reset();
		}

		public function stop():void {
			this.removeDelay();
			this.drawFrame(0);
			this.pause();
		}

		public function playToBeginAndStop(vars:Object = null):void {
			this.play(0, vars);
		}

		public function playToEndAndStop(vars:Object = null):void {
			this.play(this._totalFrames, vars);
		}

		public function gotoRandomFrame():void {
			this.gotoAndStop(~~(Math.random() * this._totalFrames) + 1);
		}

		public function gotoAndPlay(frame:*):void {
			this.removeDelay();
			this.drawFrame(frame);
			this.play();
		}

		public function gotoAndStop(frame:*):void {
			this.removeDelay();
			this.drawFrame(frame);
			this.pause();
		}

		public function togglePause():void {
			this._running ? this.pause() : this.play();
		}

		public function nextFrame():void {
			this.jumpFrames(0 + 1);
		}

		public function prevFrame():void {
			this.jumpFrames(0 - 1);
		}

		public function jumpFrames(amount:int):void {
			this.gotoAndStop(this._currentFrame + amount);
		}

		public function drawFrame(frame:uint):void {
			this._lastFrame = this._currentFrame;
			this._currentFrame = mod(frame, 1, this._totalFrames);
			this._tileBounds.x = this._timeline[this._currentFrame - 1].x;
			this._tileBounds.y = this._timeline[this._currentFrame - 1].y;
			super.bitmapData.copyPixels(this._spritesheet.bitmapData, this._tileBounds, this._tileOffset);
		}

		private function addDelay(delay:Number):void {
			this.removeDelay();
			this._playDelay = new Timeout(startAnimation, delay, toString() + '_playDelay');
		}

		private function removeDelay():void {
			this._playDelay && this._playDelay.cancel();
			this._running = false;
		}

		private function startAnimation():void {
			this._timer.start();
			if (this._vars.onStart is Function) {
				this._vars.onStart.apply(this, this._vars.onStartParams);
			}
			this._running = true;
		}

		private function startAnimationFromTo(from:*, to:*, vars:Object):void {
			delete vars.delay;
			this.gotoAndStop(from);
			this.play(to, vars);
		}

		public function cancelLooping():void {
			this._running = false;
			this._looping = false;
			this._yoyo = false;
		}

		public function loopBetween(from:*, to:*, yoyo:Boolean = false, vars:Object = null):void {
			from = clamp(from, 1, this._totalFrames);
			to = clamp(to, 0, this._totalFrames);
			this.gotoAndStop(from);
			this._running = true;
			this._looping = true;
			this._yoyo = yoyo;
			this._targetNextFrame = from;
			if (to === 0) {
				to = this._totalFrames;
			}
			this.play(to, vars);
		}

		private function onUpdateFrames(event:TimerEvent):void {
			if (this._vars.onUpdate is Function) {
				this._vars.onUpdate.apply(this, this._vars.onUpdateParams);
			}
			if (this._currentFrame < this._targetFrame) {
				this.drawFrame(this._currentFrame + this._factor);
			} else if (this._currentFrame > this._targetFrame) {
				this.drawFrame(this._currentFrame + this._factor);
			} else if (this._currentFrame === this._targetFrame) {
				if (this._looping) {
					if (this._yoyo) {
						this.loopBetween(this._currentFrame, this._targetNextFrame, this._yoyo, this._vars);
					} else {
						this.loopBetween(this._targetNextFrame, this._currentFrame, this._yoyo, this._vars);
					}
				} else {
					this.pause();
					if (this._vars.onComplete is Function) {
						this._vars.onComplete.apply(this, this._vars.onCompleteParams);
					}
				}
			}
		}

		public function get timeline():Vector.<Point> {
			return this._timeline;
		}

		public function get tileBounds():Rectangle {
			return this._tileBounds;
		}

		public function get tileOffset():Point {
			return this._tileOffset;
		}

		public function get vertical():Boolean {
			return this._vertical;
		}

		public function get reverse():Boolean {
			return this._reverse;
		}

		public function get running():Boolean {
			return this._running;
		}

		public function get looping():Boolean {
			return this._looping;
		}

		public function get yoyo():Boolean {
			return this._yoyo;
		}

		public function get duration():Number {
			return this._duration;
		}

		public function get fps():Number {
			return this._fps;
		}

		public function get factor():uint {
			return this._factor;
		}

		public function get lastFrame():uint {
			return this._lastFrame;
		}

		public function get currentFrame():uint {
			return this._currentFrame;
		}

		public function get targetNextFrame():uint {
			return this._targetNextFrame;
		}

		public function get targetFrame():uint {
			return this._targetFrame;
		}

		public function get totalFrames():uint {
			return this._totalFrames;
		}

		public function get spritesheet():Bitmap {
			return this._spritesheet;
		}

		public function get vars():Object {
			return this._vars;
		}

		override public function toString():String {
			return '[SpriteSheet ' + super.name + ']';
		}
	}
}
