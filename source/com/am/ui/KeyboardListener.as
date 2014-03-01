package com.am.ui {
	import com.am.events.KeyboardNote;
	import com.am.events.Dispatcher;
	import com.am.utils.ArrayUtil;

	import flash.display.Stage;
	import flash.events.KeyboardEvent;
	import flash.events.Event;
	import flash.utils.Dictionary;

	[Event(name = 'KeyboardNote.KEY_COMBO_TYPED', type = 'com.am.events.KeyboardNote')]
	[Event(name = 'KeyboardNote.KEY_COMBO_DOWN', type = 'com.am.events.KeyboardNote')]
	[Event(name = 'KeyboardNote.KEY_COMBO_UP', type = 'com.am.events.KeyboardNote')]
	[Event(name = 'KeyboardNote.KEY_DOWN', type = 'com.am.events.KeyboardNote')]
	[Event(name = 'KeyboardNote.KEY_UP', type = 'com.am.events.KeyboardNote')]

	/**
	 * @author Adrian C. Miranda <adriancmiranda@gmail.com>
	 */
	public class KeyboardListener extends Dispatcher {
		public static var shortcutTarget:KeyboardListener = new KeyboardListener();
		protected var stage:Stage;
		protected var combos:Vector.<Keys>;
		protected var combosDown:Vector.<Keys>;
		protected var keysTyped:Array;
		protected var keysDown:Dictionary;
		protected var longestCombo:uint;

		public function KeyboardListener() {
			this.combos = new Vector.<Keys>();
			this.combosDown = new Vector.<Keys>();
			this.keysTyped = new Array();
			this.keysDown = new Dictionary(true);
			this.longestCombo = 0;
		}

		public function initialize(stage:Stage):void {
			this.stage = stage;
			this.stage.addEventListener(Event.DEACTIVATE, this.onDeactivate);
			this.stage.addEventListener(KeyboardEvent.KEY_DOWN, this.onKeyDown);
			this.stage.addEventListener(KeyboardEvent.KEY_UP, this.onKeyUp);
		}

		public function finalize():void {
			if (this.stage) {
				super.removeAllEventListener();
				this.stage.removeEventListener(Event.DEACTIVATE, this.onDeactivate);
				this.stage.removeEventListener(KeyboardEvent.KEY_DOWN, this.onKeyDown);
				this.stage.removeEventListener(KeyboardEvent.KEY_UP, this.onKeyUp);
				this.removeAllCombos();
			}
		}

		public function addCombo(keyCombo:Keys):void {
			if (this.combos.indexOf(keyCombo) != -1) {
				trace(this.toString(), keyCombo.toString(), 'combo already exists.');
				return;
			}
			this.longestCombo = Math.max(this.longestCombo, keyCombo.keyCodes.length);
			this.combos.push(keyCombo);
		}

		public function removeCombo(keyCombo:Keys):void {
			var index:int = this.combos.indexOf(keyCombo);
			if (index == -1) {
				trace(this.toString(), keyCombo.toString(), 'combo doesn\'t exist.');
				return;
			}
			this.combos.splice(index, 1);
			if (keyCombo.keyCodes.length == this.longestCombo) {
				var size:uint = 0;
				var total:uint = this.combos.length;
				while (total--) {
					size = Math.max(size, this.combos[total].keyCodes.length);
				}
				this.longestCombo = size;
			}
		}

		public function removeAllCombos():void {
			var id:int = this.combos.length;
			while (id--) {
				this.removeCombo(this.combos[id]);
			}
		}

		private function onKeyDown(event:KeyboardEvent):void {
			var alreadyDown:Boolean = this.keysDown[event.keyCode];
			this.keysDown[event.keyCode] = true;
			this.keysTyped.push(event.keyCode);
			if (this.keysTyped.length > this.longestCombo) {
				this.keysTyped.splice(0, 1);
			}
			var id:uint = this.combos.length;
			while (id--) {
				this.checkTypedKeys(this.combos[id]);
				if (!alreadyDown) {
					this.checkDownKeys(this.combos[id]);
				}
			}
			var keyDown:KeyboardNote = new KeyboardNote(KeyboardNote.KEY_DOWN);
			keyDown.keyCode = event.keyCode;
			super.dispatchEvent(keyDown);
		}

		private function onKeyUp(event:KeyboardEvent):void {
			var id:uint = this.combosDown.length;
			while (id--) {
				if (this.combosDown[id].keyCodes.indexOf(event.keyCode) != -1) {
					var keyComboHold:KeyboardNote = new KeyboardNote(KeyboardNote.KEY_COMBO_UP);
					keyComboHold.keyCombo = this.combosDown[id];
					this.combosDown.splice(id, 1);
					super.dispatchEvent(keyComboHold);
				}
			}
			delete this.keysDown[event.keyCode];
			var keyUp:KeyboardNote = new KeyboardNote(KeyboardNote.KEY_UP);
			keyUp.keyCode = event.keyCode;
			super.dispatchEvent(keyUp);
		}

		private function onDeactivate(event:Event):void {
			var id:uint = this.combosDown.length;
			while (id--) {
				var keyComboHold:KeyboardNote = new KeyboardNote(KeyboardNote.KEY_COMBO_UP);
				keyComboHold.keyCombo = this.combosDown[id];
				super.dispatchEvent(keyComboHold);
			}
			this.combosDown = new Vector.<Keys>();
			this.keysDown = new Dictionary(true);
		}

		private function checkDownKeys(keyCombo:Keys):void {
			var uniqueCombo:Array = ArrayUtil.removeDuplicates(keyCombo.keyCodes);
			var id:uint = uniqueCombo.length;
			while (id--) if (!this.keysDown[uniqueCombo[id]]) return;
			var keyComboDown:KeyboardNote = new KeyboardNote(KeyboardNote.KEY_COMBO_DOWN);
			keyComboDown.keyCombo = keyCombo;
			this.combosDown.push(keyCombo);
			super.dispatchEvent(keyComboDown);
		}

		private function checkTypedKeys(keyCombo:Keys):void {
			if (ArrayUtil.strictlyEquals(keyCombo.keyCodes, this.keysTyped.slice(-keyCombo.keyCodes.length))) {
				var keyComboSeq:KeyboardNote = new KeyboardNote(KeyboardNote.KEY_COMBO_TYPED);
				keyComboSeq.keyCombo = keyCombo;
				super.dispatchEvent(keyComboSeq);
			}
		}

		override public function toString():String {
			return '[KeyboardListener]';
		}
	}
}
