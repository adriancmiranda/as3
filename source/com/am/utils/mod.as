package com.am.utils {

	/**
	 * @author Adrian C. Miranda <adriancmiranda@gmail.com>
	 */
	public function mod(n:Number, a:Number, b:Number):Number {
		n = num(n);
		a = num(a);
		b = num(b);
		var rem:Number;
		if (a < 0 || b < 0) {
			var places = (b - a);
			rem = (n - a) % (places + 1);
			rem = rem < 0 ? (rem + (places + 1)) : rem;
			return rem - (places - b);
		}
		if (n === a - 1) return b;
		if (n === b + 1) return a;
		if (n === b) return n;
		rem = n % b;
		return rem < a ? (rem + b) : rem;
	}
}
