package com.am.utils {
	import com.am.core.Texts;

	/**
	 * @author Adrian C. Miranda <adriancmiranda@gmail.com>
	 */
	public function i18n(id:String = null):* {
		if (id == null) return Texts.shortcutTarget;
		return Texts.shortcutTarget[id];
	}
}
