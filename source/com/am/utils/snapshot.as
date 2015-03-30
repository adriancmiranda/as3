package com.am.utils {
  import flash.display.PixelSnapping;
  import flash.display.BitmapData;
  import flash.display.Bitmap;
  import flash.geom.Rectangle;
  import flash.geom.Matrix;
	import flash.geom.Point;

	/**
	 * @author Adrian C. Miranda <adriancmiranda@gmail.com>
	 */
	public function snapshot(object:DisplayObject, bounds:Rectangle, scale:Point):Bitmap {
		var area:Rectangle = new Rectangle(0, 0, bounds.width * scale.x, bounds.height * scale.y);
    var bitmapData:BitmapData = new BitmapData(bounds.width, bounds.height);
    var bitmap:Bitmap = new Bitmap(bitmapData, PixelSnapping.ALWAYS, true);
    var matrix:Matrix = new Matrix();
    matrix.translate(-bounds.x, -bounds.y);
    matrix.scale(scale.x, scale.y);
    bitmapData.draw(object, matrix, null, null, area, true);
    return bitmap;
	}
}
