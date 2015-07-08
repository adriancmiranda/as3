package com.am.utils {
	import flash.geom.Point;

	/**
	 * @author Adrian C. Miranda <adriancmiranda@gmail.com>
	 */
	public function ellipseLayout(length:int, smallestRadius:int, biggestRadius:int):Array {
		var angle:int, lastPoint:Point = new Point(-1, -1), point:Point, array:Array = [];
		for (angle = 0; angle < length; angle++) {
			point = new Point(parseInt(biggestRadius * Math.cos(angle * 2 * (Math.PI / length)) + 0.5), parseInt(smallestRadius * Math.sin(angle * 2 * (Math.PI / length)) + 0.5));
			if (lastPoint.x !== point.x || lastPoint.y !== point.y) {
				lastPoint = point;
				array.push({ x: point.x, y: point.y, rotation: retrieveAngle(new Point(), point) });
			}
		}
		return array;
	}
}
