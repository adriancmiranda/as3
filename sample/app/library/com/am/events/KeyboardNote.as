package com.am.events {
	import com.am.ui.Keys;

	import flash.events.KeyboardEvent;
	import flash.events.Event;

	/**
	 * @author Adrian C. Miranda <adriancmiranda@gmail.com>
	 */
	public final class KeyboardNote extends KeyboardEvent {
		public static const KEY_COMBO_TYPED:String = 'KeyboardNote.KEY_COMBO_TYPED';
		public static const KEY_COMBO_DOWN:String = 'KeyboardNote.KEY_COMBO_DOWN';
		public static const KEY_COMBO_UP:String = 'KeyboardNote.KEY_COMBO_UP';
		public static const KEY_DOWN:String = 'KeyboardNote.KEY_DOWN';
		public static const KEY_UP:String = 'KeyboardNote.KEY_UP';
		private var _keyCombo:Keys;

		public function KeyboardNote(type:String, bubbles:Boolean = false, cancelable:Boolean = false) {
			super(type, bubbles, cancelable);
		}

		public function get keyCombo():Keys {
			return this._keyCombo;
		}

		public function set keyCombo(keyCombo:Keys):void {
			this._keyCombo = keyCombo;
		}

		override public function clone():Event {
			var event:KeyboardNote = new KeyboardNote(super.type, super.bubbles, super.cancelable);
			event.keyCombo = this.keyCombo;
			return event;
		}

		override public function toString():String {
			return super.formatToString('KeyboardNote', 'type', 'bubbles', 'cancelable', 'keyCombo', 'eventPhase');
		}
	}
}
