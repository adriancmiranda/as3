package com.am.form {

	/**
	 * @author Adrian C. Miranda <adriancmiranda@gmail.com>
	 * @see http://rickharrison.github.io/validate.js/validate.js
	 */
	public interface IListBox extends IList {
		function setSelectedIndexes(indexes:Array):void;
		function setMultiple(value:Boolean):void;
		function getMultiple():Boolean;
	}
}
