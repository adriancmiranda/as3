package com.am.form {

	/**
	 * @author Adrian C. Miranda <adriancmiranda@gmail.com>
	 */
	public class FieldError {
		private var _message:String;
		private var _field:Field;
		private var _type:String;

		public function FieldError(field:Field, message:String, type:String) {
			this._message = message;
			this._field = field;
			this._type = type;
		}

		public function get message():String {
			return this._message;
		}

		public function get field():Field {
			return this._field;
		}

		public function get type():String {
			return this._type;
		}
	}
}
