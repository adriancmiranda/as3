package com.am.form {
	import flash.utils.flash_proxy;
	import flash.utils.Proxy;

	/**
	 * @author Adrian C. Miranda <adriancmiranda@gmail.com>
	 */
	public class Fields extends Proxy {
		private static var _numInstances:int = -1;
		private var _fieldReferences:Object;
		private var _fieldCollection:Array;
		private var _data:XML;

		public function Fields(data:XML = null) {
			_numInstances++;
			data && this.fromXML(data);
		}

		public function fromXML(data:XML):void {
			this._data = data;
			this._fieldCollection = [];
			this._fieldReferences = {};
			var node:XML;
			var field:Field;
			var tabIndex:uint;
			for each (node in this._data['input']) {
				field = new Field(node);
				field.view.setTabIndex(tabIndex++);
				this._fieldCollection.push(field);
				this._fieldReferences[field.id] = field;
			}
		}

		public function getFieldValidation(id:String):FieldError {
			var field:Field = this.getField(id);
			if (field.view.isEmpty && field.required) {
				return new FieldError(field, field.requiredMessage, FieldErrorType.REQUIRED);
			} else if (!field.view.isValid || !field.isValidRules) {
				return new FieldError(field, field.invalidMessage, FieldErrorType.INVALID);
			}
			if (field.matchID != '') {
				if (this.getField(field.matchID).getValue() != field.getValue()) {
					return new FieldError(field, field.mismatchMessage, FieldErrorType.MISMATCH);
				}
			}
			for (var index:uint = 0, result:Boolean; index < field.methods.length; index++) {
				try {
					result = field.methods[index].method();
				} catch (error:Error) {
					trace(this.toString(), 'O método', field.methods[index].name, 'deve retornar um valor booleano.')
					result = false;
				}
				if (!result) {
					return new FieldError(field, field.methods[index].message, field.methods[index].type);
				}
			}
			return null;
		}

		public function showErrors(type:String = ''):void {
			var field:Field;
			var error:FieldError;
			for each (field in this._fieldCollection) {
				error = this.getFieldValidation(field.id);
				if (error != null) {
					if (type == '' || error.type == type) {
						field.view.showError(error.message);
					}
				} else {
					field.view.hideError();
				}
			}
		}

		public function hideErrors():void {
			var field:Field;
			for each (field in this._fieldCollection) {
				field.view.hideError();
			}
		}

		override flash_proxy function getProperty(id:*):* {
			return this.getField(id);
		}

		public function getFieldView(id:String):* {
			if (this.getField(id)) {
				return this.getField(id).view;
			}
			return null;
		}

		public function getField(id:String):Field {
			return this._fieldReferences[id];
		}

		public function isFieldValid(id:String):Boolean {
			return this.getFieldValidation(id) == null;
		}

		public function disableField(id:String):void {
			this.getField(id).disable();
		}

		public function enableField(id:String):void {
			this.getField(id).enable();
		}

		public function disable():void {
			var field:Field;
			for each (field in this._fieldCollection) {
				field.view.disable();
			}
		}

		public function enable():void {
			var field:Field;
			for each (field in this._fieldCollection) {
				field.view.enable();
			}
		}

		public function get fields():Array {
			return [].concat(this._fieldCollection);
		}

		public function get isValid():Boolean {
			return !this.errors.length;
		}

		public function get errors():Array {
			var response:Array = [];
			var field:Field;
			var error:*;
			for each (field in this.fields) {
				error = this.getFieldValidation(field.id);
				if (error != null) {
					response.push(error);
				}
			}
			return response;
		}

		public function get result():Object {
			var field:Field;
			var response:Object = {};
			for each (field in this._fieldCollection) {
				response[field.id] = field.getValue();
			}
			return response;
		}

		public function get className():String {
			return (this._data.@['class'] || this._data['class']);
		}

		public function get action():String {
			return (this._data.@['action'] || this._data['action'] || '');
		}

		public function get method():String {
			return (this._data.@['method'] || this._data['method'] || 'get').toUpperCase();
		}

		public function get id():String {
			return (this._data.@['id'] || this._data['id'] || 'Form_'+_numInstances);
		}

		public function get xml():XML {
			return this._data.copy();
		}

		public function dispose(flush:Boolean = false):void {
			if (flush) {
				this._fieldReferences = null;
				this._fieldCollection = null;
				this._data = null;
			}
		}

		public function toString():String {
			return '[Fields '+ this.id +']';
		}
	}
}
