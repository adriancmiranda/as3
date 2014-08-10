package com.am.events {
	import flash.events.IEventDispatcher;

	/**
	 * @author Adrian C. Miranda <adriancmiranda@gmail.com>
	 */
	public interface IDispatcher extends IEventDispatcher {
		function removeAllEventListener():void;
	}
}
