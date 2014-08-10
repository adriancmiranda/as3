package com.am.form {
	import com.am.utils.num;
	import com.am.utils.bool;
	import com.am.utils.Validation;

	import flash.display.DisplayObject;
	import flash.utils.getDefinitionByName;

	/**
	 * @author Adrian C. Miranda <adriancmiranda@gmail.com>
	 */
	public class Field {
		private var _methodCollection:Array;
		private var _view:IField;
		private var _node:XML;

		public function Field(node:XML = null, view:IField = null) {
			this.treatNode(node);
			this.treatView(view);
		}

		private function treatNode(node:XML):void {
			this._methodCollection = [];
			this._node = node;
		}

		private function treatView(view:IField):void {
			if (this._node) {
				this._view = view ? view : this.makeView();
				this.applyCommonProperties();
				this.applyPropertiesByType();
			}
		}

		private function makeView():IField {
			switch (this.type) {
				case FieldType.RADIOGROUP: break;
				default: {
					this._view = new this.caste() as IField;
				}
			}
			return this._view;
		}

		private function applyCommonProperties():void {
			var properties:Array = ['x', 'y', 'alpha', 'rotation', 'width', 'height'];
			for each(var property:String in properties) {
				var value:* = this.parseProperty(property);
				if (value != null) {
					this.view[property] = value;
				}
			}
		}

		private function applyPropertiesByType():void {
			var field:*;
			switch (this.type) {
				case FieldType.RADIOGROUP: {
					break;
				}
				case FieldType.CHECKBOX: {
					field = this.view as ICheckBox;
					if (this.parseProperty('value')) {
						field.setValue(this.parseProperty('value'));
					}
					field.selected = bool(this.parseProperty('checked'));
					break;
				}
				case FieldType.DROPDOWN: {
					field = this.view as IDropDown;
					if (this.parseProperty('maxRows')) {
						field.setMaxVisible(uint(num(this.parseProperty('maxRows'))));
					}
					field = this.view as IList;
					this.populateListField(field);
					break;
				}
				case FieldType.LISTBOX: {
					field = this.view as IListBox;
					field.setMultiple(bool(this.parseProperty('multiple')));
					this.populateListField(this.view as IList);
					if (this.parseProperty('selectedIndexes')) {
						field.setSelectedIndexes(String(this.parseProperty('selectedIndexes')).split(','));
					}
					break;
				}
				case FieldType.CPF:
				case FieldType.TEXT:
				case FieldType.DATE:
				case FieldType.EMAIL:
				case FieldType.NUMBER:
				case FieldType.PASSWORD:
				case FieldType.TEXTAREA: {
					field = this.view as IInput;
					if (this.parseProperty('maxChars')) {
						field.setMaxChars(uint(num(this.parseProperty('maxChars'))));
					}
					if (this.type == FieldType.CPF) {
						field.setRestrict('0-9.');
					} else if (this.type == FieldType.DATE) {
						field.setRestrict('0-/9');
					} else if (this.type == FieldType.EMAIL) {
						field.setRestrict('a-zA-Z0-9._@\\-');
					} else if (this.type == FieldType.NUMBER) {
						field.setRestrict('0-9');
					} else if (this.parseProperty('restrict')) {
						field.setRestrict(this.parseProperty('restrict'));
					}
					if (this.type == FieldType.PASSWORD) {
						field.setPassword(true);
					} else if (this.parseProperty('password')) {
						field.setPassword(bool(this.parseProperty('password')));
					}
					if (this.parseProperty('mask')) {
						field.setMask(this.parseProperty('mask'));
					}
					if (this.parseProperty('value')) {
						view.setValue(this.parseProperty('value'));
					}
					break;
				}
			}
		}

		//
		//
		// View - Utils
		//
		//

		private function populateListField(field:IList):void {
			for each(var item:XML in this.xml.items.item) {
				field.addItem(item.@label, item.@value || item.value);
			}
			if (this.parseProperty('selectedIndex')) {
				field.setSelectedIndex(int(num(this.parseProperty('selectedIndex'))));
			}
		}

		private function parseProperty(name:String):* {
			var attr:String = this.xml.attribute(name);
			var node:String = this.xml[name];
			if (name != 'restrict') {
				attr = String(attr).replace(/((^\s)|(\s$))/gi, '');
				node = String(node).replace(/((^\s)|(\s$))/gi, '');
			}
			if (attr != '') return attr;
			else if (node != '') return node;
			return null;
		}

		//
		//
		// View - Hooks
		//
		//

		public function focus():void {
			this.view.focus();
		}

		public function blur():void {
			this.view.blur();
		}

		public function enable():void {
			this.view.enable();
		}

		public function disable():void {
			this.view.disable();
		}

		public function clearValue():void {
			this.view.clearValue();
		}

		public function getValue():* {
			return this.view.getValue();
		}

		//
		//
		// XML - Basic properties
		//
		//

		public function get id():String {
			return this.xml.@id || this.xml.id;
		}

		public function get type():String {
			return this.xml.@type || this.xml.type;
		}

		public function get required():Boolean {
			return bool(this.xml.@required || this.xml.required);
		}

		//
		//
		// XML - Validation properties
		//
		//

		public function get rules():RegExp {
			var value:String = String(this.xml.@rules || this.xml.rules);
			var flags:String = String(this.xml.@rulesFlags || this.xml.rulesFlags);
			if (value != '') {
				return new RegExp(value, flags);
			}
			return null;
		}

		public function get isValidRules():Boolean {
			var value:String = String(this.view.getValue());
			switch (this.type) {
				case FieldType.EMAIL:{
					return Validation.isEmail(value);
				}
				case FieldType.DATE:{
					return Validation.isBoundariesDate(value);
				}
				case FieldType.CPF: {
					return Validation.isCPF(value);
				}
			}
			if (rules == null) {
				return true;
			}
			return rules.test(value);
		}

		public function get matchID():String {
			return String(this.xml.@match || this.xml.match).replace(/((^\s)|(\s$))/gi, '');
		}

		//
		//
		// XML - Errors messages
		//
		//

		public function set requiredMessage(value:String):void {
			this.xml.@requiredMessage = value;
		}

		public function get requiredMessage():String {
			return this.xml.@requiredMessage || this.xml.requiredMessage;
		}

		public function set invalidMessage(value:String):void {
			this.xml.@invalidMessage = value;
		}

		public function get invalidMessage():String {
			return this.xml.@invalidMessage || this.xml.invalidMessage;
		}

		public function set mismatchMessage(value:String):void {
			this.xml.@mismatchMessage = value;
		}

		public function get mismatchMessage():String {
			return this.xml.@mismatchMessage || this.xml.mismatchMessage;
		}

		//
		//
		// XML - View castes
		//
		//

		public function get className():String {
			return (this.xml.@['class'] || this.xml['class']);
		}

		public function get caste():Class {
			return getDefinitionByName(className) as Class;
		}

		//
		//
		// DisplayObject proxies
		//
		//

		public function set alpha(value:Number):void {
			this.displayObjectView.alpha = value;
		}

		public function get alpha():Number {
			return this.displayObjectView.alpha;
		}

		public function set x(value:Number):void {
			this.displayObjectView.x = value;
		}

		public function get x():Number {
			return this.displayObjectView.x;
		}

		public function set y(value:Number):void {
			this.displayObjectView.y = value;
		}

		public function get y():Number {
			return this.displayObjectView.y;
		}

		//
		//
		// Raw properties
		//
		//

		public function get displayObjectView():DisplayObject {
			return this.view as DisplayObject;
		}

		public function get view():IField {
			return this._view;
		}

		public function get xml():XML {
			return this._node.copy();
		}

		//
		//
		// Clear
		//
		//

		public function die():void {
			this._view.die();
			this._view = null;
			this._node = null;
		}

		//
		//
		// Extras
		//
		//

		public function addMethod(name:String, method:Function, message:String, type:String = null):void {
			this._methodCollection.push({ name:name, method:method, message:message, type:type || FieldErrorType.INVALID });
		}

		public function removeMethod(name:String):void {
			var id:int = this._methodCollection.length;
			while (id--) {
				if (name === this._methodCollection[id].name) {
					this._methodCollection.splice(id, 1);
				}
			}
		}

		public function removeMethods():void {
			var id:int = this._methodCollection.length;
			while (id--) {
				this._methodCollection.splice(id, 1);
			}
			this._methodCollection = [];
		}

		public function get methods():Array {
			return this._methodCollection;
		}
	}
}
