package com.am.form {

	/**
	 * @author Adrian C. Miranda <adriancmiranda@gmail.com>
	 * @see http://rickharrison.github.io/validate.js/validate.js
	 */
	public interface IList extends IField {
		function addItem(label:String, value:*):void;
		function setSelectedIndex(index:int):void;
		function get selected():Boolean;
		function clear():void;
	}
}
