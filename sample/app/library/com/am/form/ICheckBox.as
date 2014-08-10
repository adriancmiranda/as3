package com.am.form {

	/**
	 * @author Adrian C. Miranda <adriancmiranda@gmail.com>
	 * @see http://rickharrison.github.io/validate.js/validate.js
	 */
	public interface ICheckBox extends IField {
		function set selected(value:Boolean):void;
		function get selected():Boolean;
	}
}
