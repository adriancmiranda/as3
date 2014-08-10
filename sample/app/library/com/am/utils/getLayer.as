package com.am.utils {
	import com.am.core.Layers;
	import com.am.display.Layer;

	/**
	 * @author Adrian C. Miranda <adriancmiranda@gmail.com>
	 */
	public function getLayer(id:String = null):* {
		if (id == null) return Layers.shortcutTarget;
		return Layers.shortcutTarget[id];
	}
}
