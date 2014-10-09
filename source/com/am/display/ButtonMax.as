package com.am.display {
    import com.am.utils.clamp;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import flash.geom.Rectangle;
    import flash.geom.Point;
    import flash.utils.Dictionary;

    [Event(name = 'active', type = 'flash.events.MouseEvent')]
    [Event(name = 'press', type = 'flash.events.MouseEvent')]
    [Event(name = 'over', type = 'flash.events.MouseEvent')]
    [Event(name = 'out', type = 'flash.events.MouseEvent')]

    /**
     * @author Adrian C. Miranda <adriancmiranda@gmail.com>
     */
    dynamic public class ButtonMax extends ViewerMax implements IButton {
        private static var BUTTONS:Dictionary = new Dictionary(true);
        private var _reference:uint;
        private var _data:Object = new Object();
        private var _selected:Boolean;
        private var _event:MouseEvent;
        private var _bounds:Rectangle;
        private var _offset:Point;

        public function ButtonMax(groupName:String = null, hide:Boolean = false) {
            this._offset = new Point(0, 0);
            super.buttonMode = true;
            super.mouseChildren = false;
            super.addEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
            super.addEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);
            if (!BUTTONS[groupName]) {
                BUTTONS[groupName] = [];
            }
            this._reference = BUTTONS[groupName].length;
            BUTTONS[groupName].push(this);
            hide && this.out();
        }

        protected function onAddedToStage(event:Event):void {
            super.removeEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
            super.addEventListener(MouseEvent.MOUSE_UP, this.onButtonMouseUp);
            super.addEventListener(MouseEvent.MOUSE_DOWN, this.onButtonMouseDown);
            super.addEventListener(MouseEvent.MOUSE_OVER, this.onButtonMouseOver);
            super.addEventListener(MouseEvent.MOUSE_OUT, this.onButtonMouseOut);
            this.initialize();
        }

        protected function onRemovedFromStage(event:Event):void {
            super.removeAllEventListener();
            this.drop();
            this.finalize();
        }

        protected function initialize():void {
            // to override
        }

        protected function finalize():void {
            // to override
        }

        public function active():void {
            // to override
            this.over();
        }

        public function dragging():void {
            // to override
        }

        public function dropped():void {
            // to override
        }

        public function press():void {
            // to override
        }

        public function over():void {
            // to override
        }

        public function out():void {
            // to override
        }

        public function get event():MouseEvent {
            return this._event;
        }

        public function get selected():Boolean {
            return this._selected;
        }

        public function set selected(value:Boolean):void {
            this._selected = value;
            this._selected ? this.active() : this.out();
        }

        public function get data():Object {
            return this._data;
        }

        public function get reference():uint {
            return this._reference;
        }

        public function set reference(value:uint):void {
            this._reference = value;
        }

        public function get bounds():Rectangle {
            return this._bounds;
        }

        public function get offset():Point {
            return this._offset;
        }

        protected function onButtonMouseUp(event:MouseEvent):void {
            this._event = event;
            if (!this.selected) this.active();
        }

        protected function onButtonMouseDown(event:MouseEvent):void {
            this._event = event;
            if (!this.selected) this.press();
        }

        protected function onButtonMouseOver(event:MouseEvent):void {
            this._event = event;
            if (!this.selected) this.over();
        }

        protected function onButtonMouseOut(event:MouseEvent):void {
            this._event = event;
            if (!this.selected) this.out();
        }

        protected function onButtonDrag(event:MouseEvent):void {
            this._event = event;
            super.x = event.stageX - this._offset.x;
            super.y = event.stageY - this._offset.y;
            if (this._bounds != null) {
                super.x = clamp(super.x, this._bounds.left, this._bounds.right);
                super.y = clamp(super.y, this._bounds.top, this._bounds.bottom);
            }
            this.dragging();
            event.updateAfterEvent();
        }

        protected function onButtonDrop(event:MouseEvent):void {
            this._event = event;
            this.drop();
            this.dropped();
        }

        public function drag(lockCenter:Boolean = false, bounds:Rectangle = null):void {
            this.drop();
            var point:Point;
            if (!lockCenter) {
                point = super.localToGlobal(new Point(super.mouseX + super.registrationPoint.x, super.mouseY + super.registrationPoint.y));
            } else {
                point = super.localToGlobal(super.registrationPoint);
            }
            this._offset.x = (point.x - x);
            this._offset.y = (point.y - y);
            this._bounds = bounds;
            if (super.stage) {
                super.stage.addEventListener(MouseEvent.MOUSE_MOVE, this.onButtonDrag);
                super.stage.addEventListener(MouseEvent.MOUSE_UP, this.onButtonDrop);
            }
        }

        public function drop():void {
            if (super.stage) {
                super.stage.removeEventListener(MouseEvent.MOUSE_UP, this.onButtonDrop);
                super.stage.removeEventListener(MouseEvent.MOUSE_MOVE, this.onButtonDrag);
            }
        }

        public function getGroupByName(name:String):Array {
            return BUTTONS[name] || [];
        }

        public function selectAll(name:String):void {
            var group:Array = getGroupByName(name);
            for each (var item:IButton in group) {
                item.selected = true;
            }
        }

        public function unselectAll(name:String):void {
            var group:Array = getGroupByName(name);
            for each (var item:IButton in group) {
                item.selected = false;
            }
        }

        public function destak(name:String):void {
            var group:Array = getGroupByName(name);
            for each (var item:IButton in group) {
                if (item != this) {
                    item.selected = false;
                } else {
                    item.selected = true;
                }
            }
        }

        override public function toString():String {
            return '[ButtonMax ' + super.name + ']';
        }
    }
}
