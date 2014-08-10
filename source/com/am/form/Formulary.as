package com.am.form {
	import com.am.utils.num;

	import flash.display.Sprite;
	import flash.utils.getDefinitionByName;
	import flash.utils.Proxy;

	/**
	 * @author Adrian C. Miranda <adriancmiranda@gmail.com>
	 * @xml
	 *	<form/>
	 * -----
	 * @usage
	 * import com.ad.form.Formulary;
	 * var _formulary:Formulary = new Formulary(xml);
	 */
	public final class Formulary extends Fields {
		private var _container:Sprite = new Sprite();
		private var _view:*;

		public function Formulary(data:XML = null) {
			super(data);
		}

		override public function fromXML(data:XML):void {
			super.fromXML(data);
			this.x = num(data.@marginLeft);
			this.y = num(data.@marginTop);
			this.addFields();
		}

		private function addFields():Formulary {
			var field:Field;
			for each (field in super.fields) {
				this._container.addChild(field.displayObjectView);
			}
			this.view.addChild(this._container);
			return this;
		}

		public function get view():* {
			if (!this._view) {
				if (super.className) {
					var caste:Class = getDefinitionByName(super.className) as Class;
					this._view = new caste();
				} else {
					this._view = new Sprite();
				}
			}
			return this._view;
		}

		public function set x(value:Number):void {
			this._container.x = value;
		}

		public function get x():Number {
			return this._container.x;
		}

		public function set y(value:Number):void {
			this._container.y = value;
		}

		public function get y():Number {
			return this._container.y;
		}

		override public function dispose(flush:Boolean = false):void {
			super.dispose(flush);
			for each (var field:Field in super.fields) {
				if (field) {
					if (field.displayObjectView && this._container.contains(field.displayObjectView)) {
						this._container.removeChild(field.displayObjectView);
					}
					field.die();
				}
			}
			if (this._container && this._container.parent) {
				this._container.parent.removeChild(this._container);
			}
			if (flush) {
				this._container = null;
				this._view = null;
			}
		}

		override public function toString():String {
			return '[Formulary ' + super.id + ']';
		}
	}
}
