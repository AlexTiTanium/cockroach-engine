package general.controllers.events 
{
	import classes.transition.animation.SlideAnimation;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Alex
	 */
	public class TweenerStageEvent extends Event{
		
		public static const ADD:String 		= 'TweenerStageEvent.ADD';
		public static const SET:String 		= 'TweenerStageEvent.SET';
		public static const REMOVE:String 	= 'TweenerStageEvent.REMOVE';
		public static const CLEAR:String 	= 'TweenerStageEvent.CLEAR';
		
		public var viewName:String;
		public var tweenerInEffect:String;
		public var tweenerOutEffect:String;
		
		public function TweenerStageEvent(type:String, viewName:String, tweenerInEffect: String = null, tweenerOutEffect: String = null, bubbles:Boolean = true, cancelable:Boolean = false) 
		{
			this.viewName = viewName;
			this.tweenerInEffect = tweenerInEffect;
			this.tweenerOutEffect = tweenerOutEffect;
			super(type, bubbles, cancelable);
		}
		
		override public function clone(): Event {
			return new TweenerStageEvent(type, viewName, tweenerInEffect, tweenerOutEffect,bubbles, cancelable);
		}
	}
}