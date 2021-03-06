package com.am.display {
	import com.am.display.IBase;

	/**
	 * @author Adrian C. Miranda <adriancmiranda@gmail.com>
	 > To Implement
	 * function get children():Object;
	 * function get route():String;
	 * function get branch():String;
	 * function get external():Boolean;
	 * function get copy():Object;
	 *
	 * function set assetPath(value:String):void;
	 * function get assetPath():String;
	 *
	 * function set assets(value:Object):void;
	 * function get assets():Object;
	 * function get assetArray():Array;
	 *
	 * function get menu():Boolean;
	 * function set menu(value:Boolean):void;
	 *
	 * function get flow():String;
	 * function set flow(value:String):void;
	 *
	 * function get defaultChild():String;
	 * function set defaultChild(value:String):void;
	 *
	 * function set window(value:String):void;
	 * function get window():String;
	 *
	 * function setParent(page:IPageAsset):void;
	 * function getParent():IPageAsset;
	 *
	 * function gotoStep(value:String):void;
	 */
	public interface ISection extends IBase {
		function set apiKey(key:String):void;
		function navigateTo(value:*):void;
		function localize():void;
	}
}
