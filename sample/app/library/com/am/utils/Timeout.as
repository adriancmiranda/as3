package com.am.utils {
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import flash.utils.Dictionary;

	/**
	 * @author Adrian C. Miranda <adriancmiranda@gmail.com>
	 */
	public final class Timeout {
		private static var activeTimeouts:Dictionary = new Dictionary(true);
		private var _timer:Timer;
		private var _groupName:String;
		private var _method:Function;
		private var _params:Array;

		public function Timeout(method:Function, delay:Number, groupName:String = null, ...params:Array) {
			if (!activeTimeouts[groupName]) {
				activeTimeouts[groupName] = [];
			}
			activeTimeouts[groupName].push(this);
			this._method = method;
			this._params = params;
			this._groupName = groupName;
			this._timer = new Timer(delay * 1000, 1);
			this._timer.addEventListener(TimerEvent.TIMER_COMPLETE, this.onTimerComplete);
			this._timer.start();
		}

		public static function cancelGroup(groupName:String = null):void {
			var timeouts:Array = getGroup(groupName);
			var id:int = timeouts.length;
			while (id--) {
				var timeout:Timeout = Timeout(timeouts[id]);
				timeout && timeout.cancel();
			}
		}

		public function cancel():void {
			if (!this._timer) return;
			this._timer.stop();
			this._timer.removeEventListener(TimerEvent.TIMER_COMPLETE, this.onTimerComplete);
			this.destroy();
		}

		private function onTimerComplete(event:TimerEvent):void {
			this._timer.removeEventListener(TimerEvent.TIMER_COMPLETE, this.onTimerComplete);
			if (this._params.length) this._method(this._params);
			else this._method();
			this.destroy();
		}

		private function destroy(groupName:String = null):void {
			var timeouts:Array = getGroup(groupName);
			timeouts.splice(timeouts.indexOf(this), 1);
			this._timer = null;
			this._method = null;
			this._params = null;
		}

		public static function getGroup(groupName:String = null):Array {
			return activeTimeouts[groupName] || [];
		}

		public function get groupName():String {
			return this._groupName;
		}
	}
}
