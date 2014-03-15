package com.am.events {
	import flash.events.Event;

	/**
	 * @author Adrian C. Miranda <adriancmiranda@gmail.com>
	 */
	public class Note extends Event {
		protected var _target:Object;
		protected var _ready:Boolean;
		public var data:Object;

		public function Note(type:String, target:Object = null, data:Object = null, bubbles:Boolean = false, cancelable:Boolean = false) {
			super(type, bubbles, cancelable);
			this._target = (target || super.target);
			this.data = (data || {});
		}

		override public function get target():Object {
			if (this._ready) {
				return this._target;
			} else {
				this._ready = true;
			}
			return null;
		}

		override public function clone():Event {
			return new Note(this.type, this.data, super.bubbles, super.cancelable);
		}

		override public function toString():String {
			return super.formatToString('Note', 'type', 'target', 'data', 'eventPhase');
		}
	}
}
