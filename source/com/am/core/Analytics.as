package com.am.core {
	import com.am.utils.$;
	import com.am.utils.num;
	import com.am.utils.bool;
	import com.am.utils.Browser;

	import com.google.analytics.AnalyticsTracker;
	import com.google.analytics.GATracker;

	import flash.display.Stage;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	import flash.utils.Dictionary;

	/**
	 * @author Adrian C. Miranda <adriancmiranda@gmail.com>
	 *
	 * @xml
	 *	<tracks UA="XXXXXXXX-X">
	 *		<pageview id="0000" slug="MyPage"><![CDATA[/MyPage]]></pageview>
	 *		<event id="0000" slug="Clicou_Botao_MyPage"><![CDATA[category,action,opt_label,opt_value,opt_noninteraction]]></event>
	 *	</tracks>
	 *
	 * @json
	 *
	 * -----
	 * @usage
	 * import com.ad.data.Analytics;
	 *
	 * Analytics.init(tracks.xml, stage);
	 * Analytics.push('slug');
	 */
	public final class Analytics {
		private static var _tracks:XML;
		public static var tracker:AnalyticsTracker;
		public static var userAccount:String;
		public static var loader:Loader;

		public static function init(xml:XML, stage:Stage):void {
			_tracks = xml;
			userAccount = String(_tracks.@UA);
			if (userAccount) {
				trace('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~');
				trace('Google Analytics User Account: UA-'+ userAccount);
				tracker = new GATracker(stage, 'UA-'+ userAccount, 'AS3', (bool(_tracks.@debug) || /^ga$/gi.test($('debug'))));
				loader = new Loader();
			}
		}

		public static function push(slug:String, params:Object = null, link:String = ''):void {
			if (!tracker) return;
			var node:XMLList = _tracks.children().(@slug == slug);
			var tag:Object = {
				  'event': printf(node.text(), params).split(',')
				, 'type': node.name()
				, 'value': int(num(node.@id))
				, 'page': printf(node.text(), params)
				, 'url': '/' + slug
			};
			if (tag.page) {
				var request:URLRequest = new URLRequest('http://ia.nspmotion.com//ptag/?pt='+ tag.value +'&value=[number]&cvalues=[key|value,key|value]&r='+ Math.floor(Math.random()*999999));
				loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loadComplete);
				loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, loadError);
				loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, loadProgress);
				loader.load(request);
				if (tag.type == 'pageview') {
					tracker.trackPageview(tag.page);
				} else if (tag.type == 'event' && tag.event.length >= 2) {
					if (tag.event.length == 2) {
						tracker.trackEvent(tag.event[0], tag.event[1]);
					} else if (tag.event.length == 3) {
						tracker.trackEvent(tag.event[0], tag.event[1], tag.event[2]);
					} else if (tag.event.length == 4) {
						tracker.trackEvent(tag.event[0], tag.event[1], tag.event[2], tag.event[3]);
					}
				}
				trace('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~');
				trace('✓', tag.type, tag.page);
				trace('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~');
			}
			if (link) {
				Browser.call('pageTracker._link', link);
			}
		}

		private static function loadProgress(event:ProgressEvent):void {
			// trace('loadProgress', event.target);
		}

		private static function loadComplete(event:Event):void {
			// trace('loadComplete', event.target);
		}

		private static function loadError(event:IOErrorEvent):void {
			// trace('✖ loadError', event.target);
		}
	}
}
