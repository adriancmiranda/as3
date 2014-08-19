package sample.components {
	import com.am.core.*;
	import com.am.display.*;
	import com.am.errors.*;
	import com.am.events.*;
	import com.am.media.*;
	import com.am.net.*;
	import com.am.text.*;
	import com.am.ui.*;
	import com.am.utils.*;

	import com.greensock.plugins.*;
	import com.greensock.loading.*;
	import com.greensock.events.*;
	import com.greensock.easing.*;
	import com.greensock.*;

	import flash.display.*;
	import flash.system.*;
	import flash.events.*;
	import flash.utils.*;
	import flash.media.*;
	import flash.geom.*;
	import flash.text.*;
	import flash.net.*;
	import flash.ui.*;

	[Embed(source='../../../../dist/content/components/preloader.swf', symbol='components.preloader.Preloader')]
	public class Preloader extends BaseMax {
		private var _percentage:uint;
		
		public function Preloader():void {
			super(false, false, null);
		}
		
		override protected function initialize():void {
			super.play();
		}
		
		override protected function finalize():void {
			super.stop();
		}
		
		override public function transitionIn():void {
			super.transitionIn();
			TweenLite.to(this, 0.3, { alpha:1, onComplete:super.transitionInComplete });
		}
		
		override public function transitionOut():void {
			super.transitionOut();
			TweenLite.to(this, 0.3, { alpha:0, onComplete:super.transitionOutComplete });
		}
		
		public function set progress(percentage:uint):void {
			if (percentage >= _percentage && percentage <= 100) {
				_percentage = percentage;
				trace(sprintf('%03d', _percentage) + '%');
			}
		}
	}
}
