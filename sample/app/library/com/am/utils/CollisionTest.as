package com.am.utils {
	import flash.display.DisplayObjectContainer;
	import flash.display.DisplayObject;
	import flash.display.BitmapData;
	import flash.display.BlendMode;
	import flash.geom.ColorTransform;
	import flash.geom.Rectangle;
	import flash.geom.Matrix;

	/**
	 * @author Adrian C. Miranda <adriancmiranda@gmail.com>
	 */
	public class CollisionTest {
		protected var root:DisplayObjectContainer;
		protected var colorTransformA:ColorTransform;
		protected var colorTransformB:ColorTransform;

		public function CollisionTest(root:DisplayObjectContainer = null, alphaTolerance:Number = 255) {
			this.setAlphaTolerance(alphaTolerance);
			this.setRoot(root);
		}

		public function setAlphaTolerance(alphaOffset:Number = 255):void {
			this.colorTransformA = new ColorTransform(1,0,0,1, 255,0,0,alphaOffset);
			this.colorTransformB = new ColorTransform(0,1,0,1, 0,255,0,alphaOffset);
		}

		public function setRoot(root:DisplayObjectContainer):void {
			this.root = root;
		}

		/**
		 * WARNING: Does not work off-axis (0, 0), use object1.hitTestObject(object2); instead.
		 */
		public function test(targetA:DisplayObject, targetB:DisplayObject):Boolean {
			if (targetA.parent && targetB.parent) {
				var boundsA:Rectangle = targetA.getBounds(this.root || targetA);
				var boundsB:Rectangle = targetB.getBounds(this.root || targetB);
				var verticalFree:Boolean = (boundsA.right < boundsB.left || boundsB.right < boundsA.left);
				var horizontalFree:Boolean = (boundsA.bottom < boundsB.top || boundsB.bottom < boundsA.top);
				if (verticalFree || horizontalFree) {
					return false;
				}
				var bounds:Rectangle = boundsA.intersection(boundsB);
				if (bounds.width && bounds.height) {
					try {
						var matrixA:Matrix = targetA.transform.matrix.clone();
						var matrixB:Matrix = targetB.transform.matrix.clone();
						matrixA.translate(-bounds.left, -bounds.top);
						matrixB.translate(-bounds.left, -bounds.top);
						var bmpData:BitmapData = new BitmapData(bounds.width, bounds.height, true, 0);
						bmpData.draw(targetA, matrixA, colorTransformA);
						bmpData.draw(targetB, matrixB, colorTransformB, BlendMode.ADD);
						var colorBounds:Rectangle = bmpData.getColorBoundsRect(0xffffffff, 0xffffff00, true);
						if (colorBounds && colorBounds.width) {
							return true;
						}
					} catch (error:Error) {
						// Just in case Invalid BitmapData
					}
				}
			}
			return false;
		}
	}
}
