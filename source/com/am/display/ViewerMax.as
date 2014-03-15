package com.am.display {
	import com.am.events.Note;

	[Event(name = 'Note.TRANSITION_IN', type = 'com.am.events.Note')]
	[Event(name = 'Note.TRANSITION_OUT', type = 'com.am.events.Note')]
	[Event(name = 'Note.TRANSITION_IN_COMPLETE', type = 'com.am.events.Note')]
	[Event(name = 'Note.TRANSITION_OUT_COMPLETE', type = 'com.am.events.Note')]

	/**
	 * @author Adrian C. Miranda <adriancmiranda@gmail.com>
	 */
	public class ViewerMax extends Cluricaun implements IViewer {
		public var onTransitionIn:Function;
		public var onTransitionInParams:Array;
		public var onTransitionOut:Function;
		public var onTransitionOutParams:Array;
		public var onTransitionInComplete:Function;
		public var onTransitionInCompleteParams:Array;
		public var onTransitionOutComplete:Function;
		public var onTransitionOutCompleteParams:Array;

		public function ViewerMax() {
			super();
		}

		public function transitionIn():void {
			if (this.onTransitionIn != null) {
				this.onTransitionIn.apply(super, this.onTransitionInParams);
			}
			super.dispatchEvent(new Note(Note.TRANSITION_IN));
		}

		public function transitionOut():void {
			if (this.onTransitionOut != null) {
				this.onTransitionOut.apply(super, this.onTransitionOutParams);
			}
			super.dispatchEvent(new Note(Note.TRANSITION_OUT));
		}

		public function transitionInComplete():void {
			if (this.onTransitionInComplete != null) {
				this.onTransitionInComplete.apply(super, this.onTransitionInCompleteParams);
			}
			super.dispatchEvent(new Note(Note.TRANSITION_IN_COMPLETE));
		}

		public function transitionOutComplete():void {
			if (this.onTransitionOutComplete != null) {
				this.onTransitionOutComplete.apply(super, this.onTransitionOutCompleteParams);
			}
			super.dispatchEvent(new Note(Note.TRANSITION_OUT_COMPLETE));
		}

		override public function toString():String {
			return '[ViewerMax ' + super.name + ']';
		}
	}
}
