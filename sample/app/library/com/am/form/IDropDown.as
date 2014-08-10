package com.am.form {

	/**
	 * @author Adrian C. Miranda <adriancmiranda@gmail.com>
	 * @see http://rickharrison.github.io/validate.js/validate.js
	 */
	public interface IDropDown extends IList {
		function setMaxVisible(value:uint):void;
		function getMaxVisible():uint;
		function close():void;
		function open():void;
	}
}
