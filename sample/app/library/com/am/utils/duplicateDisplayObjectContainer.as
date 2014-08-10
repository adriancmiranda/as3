package com.am.utils {
	import flash.display.DisplayObjectContainer;
	import flash.utils.getQualifiedClassName;
	import flash.utils.getDefinitionByName;

	/**
	 * @author Adrian C. Miranda <adriancmiranda@gmail.com>
	 */
	public function duplicateDisplayObjectContainer(target:DisplayObjectContainer, ...rest:Array):* {
		var Caste:Class = Class(getDefinitionByName(getQualifiedClassName(target)));
		var instance:* = new Caste(rest.slice());
		instance.transform = target.transform;
		instance.filters = target.filters;
		instance.cacheAsBitmap = target.cacheAsBitmap;
		instance.opaqueBackground = target.opaqueBackground;
		target.parent && target.parent.addChild(instance);
		return instance;
	}
}
