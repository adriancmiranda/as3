package com.am.core {
	import com.am.events.IDispatcher;
	
	/**
	 * @author Adrian C. Miranda <adriancmiranda@gmail.com>
	 */
	public interface IApplicationCore extends IDispatcher {
		function dispose(flush:Boolean = false):void;
	}
}
