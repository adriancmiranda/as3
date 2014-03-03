package com.am.utils {
	import __AS3__.vec.Vector;
	import flash.geom.Point;

	/**
	 * @author Adrian C. Miranda <adriancmiranda@gmail.com>
	 */
	public function gridLayout(length:int, columns:int, width:int, height:int, marginX:int = 0, marginY:int = 0, horizontal:Boolean = true):Vector.<Point> {
		var id:int, point:Point, vector:Vector.<Point> = new Vector.<Point>();
		for (id = 0; id < length; id++) {
			point = new Point(
				  horizontal ? Math.round((width + marginX) * (id % columns)) : Math.round((width + marginX) * Math.floor(id / columns))
				, horizontal ? Math.round((height + marginY) * Math.floor(id / columns)) : Math.round((height + marginY) * (id % columns))
			);
			vector.push(point);
		}
		return vector;
	}
}
