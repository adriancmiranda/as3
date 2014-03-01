package com.am.display {

	/**
	 * @author Adrian C. Miranda <adriancmiranda@gmail.com>
	 */
	public interface IMovieClip extends ISprite {
		/**
		 * @am
		 */
		function playTo(frame:Object, vars:Object = null):void;
		function playToBeginAndStop(vars:Object = null):void;
		function playToEndAndStop(vars:Object = null):void;
		function loopBetween(from:Object = 1, to:Object = 0, yoyo:Boolean = false, vars:Object = null):void;
		function cancelLooping():void;
		function getFrameByLabel(frame:String):int;
		function frameIsValid(frame:Object):Boolean;
		function parseFrame(frame:Object):int;
		function set onCompleteFrame(closure:Function):void;
		function get duration():Number;
		function get position():Number;

		/**
		 * @native
		 */
		[Inspectable(environment='none')]
		function addFrameScript(...args:*):void;
		function get currentFrame():int;

		[Version('10')]
		function get currentFrameLabel():String;
		function get currentLabel():String;
		function get currentLabels():Array;
		function get currentScene():Scene;
		function get enabled():Boolean;
		function set enabled(value:Boolean):void;
		function get framesLoaded():int;
		function gotoAndPlay(frame:Object, scene:String = null):void;
		function gotoAndStop(frame:Object, scene:String = null):void;
		function nextFrame():void;
		function nextScene():void;
		function play():void;
		function prevFrame():void;
		function prevScene():void;
		function get scenes():Array;
		function stop():void;
		function get totalFrames():int;
		function get trackAsMenu():Boolean;
		function set trackAsMenu(value:Boolean):void;
	}
}
