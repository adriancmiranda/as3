package com.am.utils {
	import flash.geom.Point;

	/**
	 * @author Adrian C. Miranda <adriancmiranda@gmail.com>
	 */
	public function arcLayout(length:int, radius:int):Array {
		var id:int, point:Point, piece:Number, radians:Number, array:Array = [], angle:Number = 360 / length;
		for (id = 0; id < length; id++) {
		  // N/A yet.
			//piece = (angle * id);
			//radians = (Math.PI * 2 / 360) * piece;
			//point = new Point(Math.round(Math.cos(radians) * radius), Math.round(Math.sin(radians) * radius));
			//array.push({ x: point.x, y: point.y, rotation: retrieveAngle(new Point(), point) });
		}
		return array;
	}
}
