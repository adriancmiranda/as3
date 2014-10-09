package com.am.events {
	import flash.events.Event;

	/**
	 * @author Adrian C. Miranda <adriancmiranda@gmail.com>
	 */
	public class Note extends Event {
		//|
		//| Transition
		//|
		public static const BEFORE_PRELOAD:String = 'Note.BEFORE_PRELOAD';
		public static const AFTER_PRELOAD:String = 'Note.AFTER_PRELOAD';
		public static const BEFORE_TRANSITION_IN:String = 'Note.BEFORE_TRANSITION_IN';
		public static const TRANSITION_IN:String = 'Note.TRANSITION_IN';
		public static const AFTER_TRANSITION_IN:String = 'Note.AFTER_TRANSITION_IN';
		public static const TRANSITION_IN_COMPLETE:String = 'Note.TRANSITION_IN_COMPLETE';
		public static const BEFORE_TRANSITION_OUT:String = 'Note.BEFORE_TRANSITION_OUT';
		public static const TRANSITION_OUT:String = 'Note.TRANSITION_OUT';
		public static const AFTER_TRANSITION_OUT:String = 'Note.AFTER_TRANSITION_OUT';
		public static const TRANSITION_OUT_COMPLETE:String = 'Note.TRANSITION_OUT_COMPLETE';
		public static const START:String = 'Note.START';
		public static const PROGRESS:String = 'Note.PROGRESS';
		public static const STOP:String = 'Note.STOP';
		public static const TOGGLE_CLOSE:String = 'Note.TOGGLE_CLOSE';
		public static const CHANGE:String = 'Note.CHANGE';
		public static const CLOSE:String = 'Note.CLOSE';
		public static const OPEN:String = 'Note.OPEN';

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
