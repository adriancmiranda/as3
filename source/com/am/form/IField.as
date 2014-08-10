package com.am.form {

	/**
	 * @author Adrian C. Miranda <adriancmiranda@gmail.com>
	 * @see http://rickharrison.github.io/validate.js/validate.js
	 */
	public interface IField {
		// estilo
		function set width(value:Number):void;
		function get width():Number;
		function set height(value:Number):void;
		function get height():Number;

		// valores
		function setValue(value:*):void;
		function clearValue():void;
		function getValue():*;

		// acessibilidade
		function setTabIndex(value:int):void;
		function getTabIndex():int;
		function focus():void;
		function blur():void;
		function enable():void;
		function disable():void;

		// validação
		function get isEmpty():Boolean;
		function get isValid():Boolean;

		// erros
		function showError(message:String):void;
		function hideError():void;

		// dispose
		function die():void;
	}
}
