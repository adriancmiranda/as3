package com.am.form {

	/**
	 * @author Adrian C. Miranda <adriancmiranda@gmail.com>
	 * @see http://rickharrison.github.io/validate.js/validate.js
	 */
	public interface IInput extends IField {
		function setPassword(value:Boolean):void;
		function setRestrict(value:String):void;
		function setMaxChars(value:uint):void;
		function setMask(value:String):void;
	}
}
