package com.am.net {
	import flash.utils.Dictionary;

	/**
	 * @author Adrian C. Miranda <adriancmiranda@gmail.com>
	 */
	public final class StreamStatus {
		private static var $map:Dictionary = new Dictionary(true);

		public static const WARNING:String = 'warning';
		public static const STATUS:String = 'status';
		public static const ERROR:String = 'error';

		public static const CONNECT_SUCCESS:StreamStatus = new StreamStatus('NetConnection.Connect.Success', STATUS);
		public static const CONNECT_CLOSED:StreamStatus = new StreamStatus('NetConnection.Connect.Closed', STATUS);
		public static const CALL_BAD_VERSION:StreamStatus = new StreamStatus('NetConnection.Call.BadVersion', ERROR);
		public static const CALL_FAILED:StreamStatus = new StreamStatus('NetConnection.Call.Failed', ERROR);
		public static const CALL_PROHIBITED:StreamStatus = new StreamStatus('NetConnection.Call.Prohibited', ERROR);
		public static const CONNECT_FAILED:StreamStatus = new StreamStatus('NetConnection.Connect.Failed', ERROR);
		public static const CONNECT_REJECTED:StreamStatus = new StreamStatus('NetConnection.Connect.Rejected', ERROR);
		public static const CONNECT_APP_SHUTDOWN:StreamStatus = new StreamStatus('NetConnection.Connect.AppShutdown', ERROR);
		public static const CONNECT_INVALID_APP:StreamStatus = new StreamStatus('NetConnection.Connect.InvalidApp', ERROR);
		public static const BUFFER_EMPTY:StreamStatus = new StreamStatus('NetStream.Buffer.Empty', STATUS);
		public static const BUFFER_FULL:StreamStatus = new StreamStatus('NetStream.Buffer.Full', STATUS);
		public static const BUFFER_FLUSH:StreamStatus = new StreamStatus('NetStream.Buffer.Flush', STATUS);
		public static const PLAY_START:StreamStatus = new StreamStatus('NetStream.Play.Start', STATUS);
		public static const PLAY_RESET:StreamStatus = new StreamStatus('NetStream.Play.Reset', STATUS);
		public static const PLAY_STOP:StreamStatus = new StreamStatus('NetStream.Play.Stop', STATUS);
		public static const PLAY_PUBLISH_NOTIFY:StreamStatus = new StreamStatus('NetStream.Play.PublishNotify', STATUS);
		public static const PLAY_UNPUBLISH_NOTIFY:StreamStatus = new StreamStatus('NetStream.Play.UnpublishNotify', STATUS);
		public static const PLAY_SWITCH:StreamStatus = new StreamStatus('NetStream.Play.Switch', STATUS);
		public static const PLAY_COMPLETE:StreamStatus = new StreamStatus('NetStream.Play.Complete', STATUS);
		public static const RECORD_START:StreamStatus = new StreamStatus('NetStream.Record.Start', STATUS);
		public static const RECORD_STOP:StreamStatus = new StreamStatus('NetStream.Record.Stop', STATUS);
		public static const PUBLISH_START:StreamStatus = new StreamStatus('NetStream.Publish.Start', STATUS);
		public static const PUBLISH_IDLE:StreamStatus = new StreamStatus('NetStream.Publish.Idle', STATUS);
		public static const UNPUBLISH_SUCCESS:StreamStatus = new StreamStatus('NetStream.Unpublish.Success', STATUS);
		public static const UNPAUSE_NOTIFY:StreamStatus = new StreamStatus('NetStream.Unpause.Notify', STATUS);
		public static const PAUSE_NOTIFY:StreamStatus = new StreamStatus('NetStream.Pause.Notify', STATUS);
		public static const SEEK_NOTIFY:StreamStatus = new StreamStatus('NetStream.Seek.Notify', STATUS);
		public static const PLAY_STREAM_NOT_FOUND:StreamStatus = new StreamStatus('NetStream.Play.StreamNotFound', ERROR);
		public static const PLAY_FAILED:StreamStatus = new StreamStatus('NetStream.Play.Failed', ERROR);
		public static const RECORD_NO_ACCESS:StreamStatus = new StreamStatus('NetStream.Record.NoAccess', ERROR);
		public static const RECORD_FAILED:StreamStatus = new StreamStatus('NetStream.Record.Failed', ERROR);
		public static const PUBLISH_BAD_NAME:StreamStatus = new StreamStatus('NetStream.Publish.BadName', ERROR);
		public static const SEEK_FAILED:StreamStatus = new StreamStatus('NetStream.Seek.Failed', ERROR);
		public static const SEEK_INVALID_TIME:StreamStatus = new StreamStatus('NetStream.Seek.InvalidTime', ERROR);
		public static const FLUSH_SUCCESS:StreamStatus = new StreamStatus('SharedObject.Flush.Success', STATUS);
		public static const FLUSH_FAILED:StreamStatus = new StreamStatus('SharedObject.Flush.Failed', ERROR);
		public static const BAD_PERSISTENCE:StreamStatus = new StreamStatus('SharedObject.BadPersistence', ERROR);
		public static const URI_MISMATCH:StreamStatus = new StreamStatus('SharedObject.UriMismatch', ERROR);
		public static const PLAY_INSUFFICIENT_BW:StreamStatus = new StreamStatus('NetStream.Play.InsufficientBW', WARNING);

		public var level:String;
		public var code:String;

		public function StreamStatus(code:String, level:String) {
			this.code = code;
			this.level = level;
			$map[this.code] = this;
		}

		public static function get(code:String):StreamStatus {
			return contains(code) ? $map[code] : null;
		}

		public static function contains(code:String):Boolean {
			return $map[code] ? true : false;
		}

		public function toString():String {
			return this.code;
		}
	}
}
