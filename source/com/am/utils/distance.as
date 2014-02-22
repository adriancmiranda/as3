package com.am.utils {
	import com.am.utils.num;

	/**
	 * @author Adrian C. Miranda <adriancmiranda@gmail.com>
	 */
	public function distance(x1:Number, y1:Number, x2:Number, y2:Number):Number {
		x1 = num(x1);
		y1 = num(y1);
		x2 = num(x2);
		y2 = num(y2);
		var tx:Number = Math.abs(x1 - x2);
		var ty:Number = Math.abs(y1 - y2);
		return Math.pow(Math.pow(tx, 2) + Math.pow(ty, 2), 0.5);
	}
}
