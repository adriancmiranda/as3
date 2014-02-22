package com.am.utils {
	import com.am.utils.num;

	/**
	 * @author Adrian C. Miranda <adriancmiranda@gmail.com>
	 */
	public function clamp(value:Number, min:Number, max:Number):Number {
		min = num(min);
		max = num(max);
		value = num(value);
		return((value > max) ? max : (value < min ? min : value));
	}
}
