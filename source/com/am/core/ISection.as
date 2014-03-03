package com.am.core {
	import com.am.display.IBase;

	/**
	 * @author Adrian C. Miranda <adriancmiranda@gmail.com>
	 */
	public interface ISection extends IBase {
		function set apiKey(key:String):void;
		function navigateTo(value:*):void;
		function localize():void;
	}
}
