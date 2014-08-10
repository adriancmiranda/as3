package com.am.utils {
	import com.am.core.Links;

	/**
	 * @author Adrian C. Miranda <adriancmiranda@gmail.com>
	 */
	public function _(id:String = null):* {
		if (id == null) return Links.shortcutTarget;
		return Links.shortcutTarget[id];
	}
}
