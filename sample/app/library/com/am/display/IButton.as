package com.am.display {
	import flash.geom.Rectangle;
	import flash.geom.Point;

	/**
	 * @author Adrian C. Miranda <adriancmiranda@gmail.com>
	 */
	public interface IButton extends IViewer {
		function get data():Object;
		function get selected():Boolean;
		function set selected(value:Boolean):void;
		function get reference():uint;
		function set reference(value:uint):void;
		function get bounds():Rectangle;
		function get offset():Point;
		function drag(lockCenter:Boolean = false, rectangle:Rectangle = null):void;
		function drop():void;
		function getGroupByName(name:String):Array;
		function destak(group:String):void;
		function selectAll(group:String):void;
		function unselectAll(group:String):void;
		function active():void;
		function press():void;
		function over():void;
		function out():void;
	}
}
