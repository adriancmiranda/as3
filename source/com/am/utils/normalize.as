package com.am.utils {
	import com.am.utils.num;

	/**
	 * @author Adrian C. Miranda <adriancmiranda@gmail.com>
	 */
	public function normalize(value:Number, minimum:Number, maximum:Number):Number {
		value = num(value);
		minimum = num(minimum);
		maximum = num(maximum);
		return (value - minimum) / (maximum - minimum);
	}
}
