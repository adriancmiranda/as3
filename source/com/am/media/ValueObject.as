package com.am.media {
	import flash.display.Sprite;

	/**
	 * @author Adrian C. Miranda <adriancmiranda@gmail.com>
	 * TODO: Implement all cue params
	 */
	public class ValueObject {
		private var _id:*;

		public function ValueObject(vars:Object = null) {
			if (vars != null) {
				for (var property:String in vars) {
					this[property] = vars[property];
				}
			}
		}

		public function set id(value:*):void {
			this._id = value;
		}

		public function get id():* {
			return this._id;
		}
	}
}
