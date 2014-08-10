package {
	import sample.components.*;
	import sample.pages.*;
	import sample.utils.*;
	import sample.*;

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

	[SWF(width='720', height='480', frameRate='32', backgroundColor='#222222')]
	public final class boot extends BaseLite {
		public var preloader:Preloader = new Preloader();

		public function boot() {
			super(true, false, null);
		}

		override protected function initialize():void {
			Parameters.fromObject(stage.loaderInfo.parameters);
			$('*', Application.getInstance());
			$('*').auditSize(false);
			$('*').plugins(ScalePlugin, AutoAlphaPlugin, TintPlugin);
			$('*').loaders(XMLLoader, SWFLoader, ImageLoader);
			$('*').classes(Facade, Home, Contact);
			$('*').addEventListener(LoaderEvent.PROGRESS, progress);
			$('*').addEventListener(LoaderEvent.COMPLETE, complete);
			$('*').fromXML('{@fvBaseContent}config/sitemap.xml');
			$('*').onReady = ready;
			$('*').startup(this);
		}

		override protected function finalize():void {
			$('*').dispose(true);
			$('*', null);
		}

		override public function arrange():void {
			preloader && preloader.move(super.CW, super.CH);
			getLayer('modal').move(super.CW, super.CH);
		}

		private function removeLoader():void {
			stopArrange();
			preloader.parent.removeChild(preloader);
			preloader = null;
		}

		private function ready():void {
			$('*').layers('layers');
			getLayer('preloader').addChild(preloader);
			arrange();
			preloader.transitionIn();
		}

		private function progress(event:LoaderEvent):void {
			preloader.progress = Math.round(event.target.progress * 100);
		}

		private function complete(event:LoaderEvent):void {
			Fonts.registerFonts();
			setup();
			preloader.onTransitionOutComplete = run;
			preloader.transitionOut();
		}

		private function setup():void {
			$('*').params('params')
			.tracks('tracks')
			.links('links')
			.texts('texts');
		}

		private function run():void {
			removeLoader();
			getLayer('base').addChild($('*').base);
			$('*').run(getLayer('page'));
			$('*').base.transitionIn();
			arrange();
		}
	}
}
