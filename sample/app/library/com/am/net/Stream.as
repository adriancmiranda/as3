package com.am.net {
	import com.am.utils.num;
	import com.am.utils.clamp;
	import com.am.utils.normalize;

	import flash.net.NetConnection;
	import flash.net.NetStream;
	import flash.utils.Timer;

	/**
	 * @author Adrian C. Miranda <adriancmiranda@gmail.com>
	 * @tip To use video steps just player 10.1 or older and
	 * export video with key frame distance: 1
	 */
	public class Stream extends NetStream implements IStream {
		public static var checkPolicyFile:Boolean = true;
		private var _types:Vector.<String> = new Vector.<String>();
		private var _listeners:Vector.<Function> = new Vector.<Function>();
		private var _connection:NetConnection;
		private var _isPaused:Boolean;
		private var _metaData:Object;
		private var _timer:Timer;

		public function Stream(connection:NetConnection = null, timer:Timer = null, peerID:String = 'connectToFMS') {
			super(this.getOwnConnection(connection), peerID);
			super.checkPolicyFile = Stream.checkPolicyFile;
			super.client = new Object();
			super.client.onCuePoint = this.onCuePoint;
			super.client.onMetaData = this.onMetaData;
			super.client.onXMPData = this.onXMPData;
			this._timer = timer;
		}

		protected function getOwnConnection(connection:NetConnection):NetConnection {
			if (connection) return connection;
			this._connection = new NetConnection();
			this._connection.connect(null);
			return this._connection;
		}

		override public function publish(name:String = null, type:String = null):void {
			this._isPaused = false;
			super.checkPolicyFile = Stream.checkPolicyFile;
			if (this._timer && !this._timer.running) {
				this._timer.start();
			}
			super.publish(name, type);
		}

		override public function play(...rest):void {
			this._isPaused = false;
			super.checkPolicyFile = Stream.checkPolicyFile;
			if (this._timer && !this._timer.running) {
				this._timer.start();
			}
			super.play.apply(this, rest);
		}

		override public function pause():void {
			if (!this._isPaused) {
				this._isPaused = true;
				if (this._timer && this._timer.running) {
					this._timer.stop();
				}
				super.pause();
			}
		}

		override public function resume():void {
			if (this._isPaused) {
				this._isPaused = false;
				super.checkPolicyFile = Stream.checkPolicyFile;
				super.resume();
				if (this._timer && !this._timer.running) {
					this._timer.start();
				}
			}
		}

		override public function togglePause():void {
			this._isPaused ? this.resume() : this.pause();
		}

		override public function close():void {
			this.stop();
			if (!this.loaded) {
				super.close();
			}
		}

		override public function seek(second:Number):void {
			super.seek(num(second));
		}

		public function stop():void {
			if (this._timer && this._timer.running) {
				this._timer.stop();
			}
			this.pause();
			this.seek(0);
		}

		public function get connection():NetConnection {
			return this._connection;
		}

		override public function get bufferTime():Number {
		    return num(super.bufferTime);
		}

		override public function get bufferLength():Number {
		    return num(super.bufferLength);
		}

		override public function get time():Number {
			return num(super.time);
		}

		override public function get bytesLoaded():uint {
			return uint(num(super.bytesLoaded));
		}

		override public function get bytesTotal():uint {
			return uint(num(super.bytesTotal));
		}

		private function onCuePoint(info:Object):void {
			trace('cuepoint: time=' + info.time + ' name=' + info.name + ' type=' + info.type);
		}

		private function onMetaData(info:Object):void {
			this._metaData = info;
		}

		private function onXMPData(info:Object):void {
			var XMPXML:XML = new XML(info.data);
			trace(XMPXML);
		}

		public function get bufferPercent():Number {
		    return clamp(num((this.bufferTime / this.bufferLength) * 100), 0, 100);
		}

		public function get bytesPercent():Number {
		    return clamp(num((this.bytesLoaded / this.bytesTotal) * 100), 0, 100);
		}

		public function get buffer():Number {
		    return num(clamp(normalize(this.bufferTime, 0, this.bufferLength), 0, 1));
		}

		public function get bytes():Number {
			return num(clamp(normalize(this.bytesLoaded, 0, this.bytesTotal), 0, 1));
		}

		public function get buffered():Boolean {
			return this.buffer == 1;
		}

		public function get loaded():Boolean {
			return this.bytes == 1;
		}

		public function get paused():Boolean {
			return this._isPaused;
		}

		public function get metaData():Object {
			return this._metaData;
		}

		public function get duration():Number {
			return Math.round(this.length);
		}

		public function get length():Number {
			return num(this.metaData);
		}

		override public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = true):void {
			var id:int = this._types.length;
			while (id--) {
				if (this._types[id] === type && this._listeners[id] === listener) {
					return;
				}
			}
			this._types.push(type);
			this._listeners.push(listener);
			super.addEventListener(type, listener, useCapture, priority, useWeakReference);
		}

		override public function removeEventListener(type:String, listener:Function, useCapture:Boolean = false):void {
			var id:int = this._types.length;
			while (id--) {
				if (this._types[id] === type && this._listeners[id] === listener) {
					this._types.splice(id, 1);
					this._listeners.splice(id, 1);
					super.removeEventListener(type, listener, useCapture);
				}
			}
		}

		public function removeAllEventListener():void {
			var id:int = this._types.length;
			while (id--) {
				super.removeEventListener(this._types[id], this._listeners[id]);
				this._types.splice(id, 1);
				this._listeners.splice(id, 1);
			}
		}

		override public function dispose():void {
			if (this._timer) {
				if (this._timer.running) {
					this._timer.stop();
				}
				this._timer = null;
			}
			this.close();
			this._isPaused = true;
			super.dispose();
		}

		override public function toString():String {
			return '[Stream]';
		}
	}
}
