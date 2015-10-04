package com.am.utils {

	/**
	 * @author Adrian C. Miranda <adriancmiranda@gmail.com>
	 */
	public function bool(value:* = null):Boolean {
		if ((value is String || value is XMLList) && (isNaN(Number(value)) || !isFinite(Number(value))) {
			return /^(true|yes|y|sim|s|on|ja)$/ig.test(value);
		}
		return !!value;
	}
}
