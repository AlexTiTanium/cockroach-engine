package general.controllers.events 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Alex
	 */
	public class StageEvent extends Event{
		
		public static const ADD:String = 'StageEvent.ADD';
		public static const SET:String = 'StageEvent.SET';
		public static const REMOVE:String = 'StageEvent.REMOVE';
		public static const CLEAR:String = 'StageEvent.CLEAR';
		
		public var viewName:String;
    
		public function StageEvent(type:String, viewName:String = '', bubbles:Boolean = true, cancelable:Boolean = false) 
		{
			this.viewName = viewName;
			super(type, bubbles, cancelable);
		}
		
		override public function clone(): Event {
			return new StageEvent(type, viewName,bubbles, cancelable);
		}
	}
}