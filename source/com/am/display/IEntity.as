package com.am.display {
	
	/**
	 * @author Adrian C. Miranda <adriancmiranda@gmail.com>
	 */
	public interface IEntity extends IDisplayObjectContainer {
		function moveForward():void;
		function moveToFront():void;
		function moveBackward():void;
		function moveToBack():void;
	}
}
