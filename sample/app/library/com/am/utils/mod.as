package com.am.utils {

	/**
	 * @author Adrian C. Miranda <adriancmiranda@gmail.com>
	 */
	public function mod(index:Number, min:Number, max:Number):Number {
		min = num(min);
		max = num(max);
		index = num(index);
		var value:Number = index % max;
		return((value < min) ? (value + max) : value);
	}
}
