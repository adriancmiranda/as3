package com.am.utils {
	import flash.geom.Point;

	public function retrieveAngle(pointA:Point, pointB:Point, rotation:Number = 0):Number {
		var dx:Number = pointA.x - pointB.x;
		var dy:Number = pointA.y - pointB.y;
		var angle:Number = Math.atan2(dx, dy);
		angle /= (Math.PI / 180);
		angle = mod(angle + rotation, 0, 360);
		return angle;
	}
}
