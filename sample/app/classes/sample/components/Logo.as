package sample.components {
	import com.am.display.ButtonLite;
	import com.greensock.easing.*;
	import com.greensock.*;

	public final class Logo extends ButtonLite {
		public function Logo() {
			super('facade', false);
			super.scale = 0.18;
		}

		override public function over():void {
            TweenLite.to(this, 0.3, { tint:0xf1f1f1, ease:Expo.easeOut });
        }

        override public function out():void {
            TweenLite.to(this, 0.4, { tint:null });
        }
	}
}
