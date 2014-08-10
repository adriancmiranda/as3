package com.am.core {
	import flash.utils.ByteArray;
	import flash.utils.Endian;

	/**
	 * @see http://www.adobe.com/content/dam/Adobe/en/devnet/swf/pdf/swf_file_format_spec_v10.pdf
	 */
	public class ApplicationData {
		private const SET_BG_COLOR:uint = 9;
		private const SHOW_FRAME:uint = 1;
		private const END:uint = 0;

		protected var _compressedBytes:ByteArray;
		protected var _stream:ByteArray;

		private var _backgroundColor:uint;
		private var _signature:String;
		private var _frameRate:Number;
		private var _frameCount:uint;
		private var _fileLength:uint;
		private var _version:uint;

		public function ApplicationData(stream:ByteArray) {
			this._stream = stream;
			this.parseHeader();
			this.parseTags();
		}

		protected function parseHeader():void {
			var header:ByteArray = new ByteArray();
			header.endian = Endian.LITTLE_ENDIAN;
			this._stream.readBytes(header, 0, 8);
			this._signature = header.readUTFBytes(3);
			this._version = header.readByte();
			this._fileLength = header.readUnsignedInt();
			this._compressedBytes = new ByteArray();
			this._compressedBytes.endian = Endian.LITTLE_ENDIAN;
			this._stream.readBytes(this._compressedBytes);
			if (this._signature == 'CWS') {
				this._compressedBytes.uncompress();
			}
			var fbyte:uint = this._compressedBytes.readUnsignedByte();
			var rect_bitlength:uint = fbyte >> 3;
			var total_bits:uint = rect_bitlength * 4;
			var next_bytes:uint = Math.ceil(total_bits / 8);
			for (var id:int = 0; id < next_bytes; id++) {
				this._compressedBytes.readUnsignedByte();
			}
			this._frameRate = this._compressedBytes.readUnsignedShort() / 256;
			this._frameCount = this._compressedBytes.readUnsignedShort();
		}

		protected function parseTags():void {
			while (true) {
				var tagCodeLen:Number = this._compressedBytes.readUnsignedShort();
				var tagCode:uint = tagCodeLen >> 6;
				var tagLen:uint = tagCodeLen & 0x3F;
				if (tagLen >= 63) {
					tagLen = this._compressedBytes.readUnsignedInt();
				}
				switch(tagCode) {
					case END: return;
					case SHOW_FRAME: break;
					case SET_BG_COLOR: {
						var r:uint = this._compressedBytes.readUnsignedByte();
						var g:uint = this._compressedBytes.readUnsignedByte();
						var b:uint = this._compressedBytes.readUnsignedByte();
						this._backgroundColor = r << 16 | g << 8 | b;
						break;
					}
					default:{
						this._compressedBytes.readBytes(new ByteArray(), 0, tagLen);
					}
				}
			}
		}

		public function get backgroundColor():uint {
			return this._backgroundColor;
		}

		public function get signature():String {
			return this._signature;
		}

		public function get frameRate():Number {
			return this._frameRate;
		}

		public function get frameCount():uint {
			return this._frameCount;
		}

		public function get fileLength():uint {
			return this._fileLength;
		}

		public function get version():uint {
			return this._version;
		}
	}
}
