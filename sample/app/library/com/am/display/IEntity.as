package com.am.display {
	
	/**
	 * @author Adrian C. Miranda <adriancmiranda@gmail.com>
	 */
	public interface IEntity extends IDisplayObjectContainer {
		function moveBackward():void;
		function moveForward():void;
		function moveToFront():void;
		function moveToBack():void;
	}
}
