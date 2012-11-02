package general.controllers.events 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Alex
	 */
	public class InitializeEvent extends Event{
		
		public static const START:String = 'InitializeEvent.START';
    
		public function InitializeEvent(type:String, bubbles:Boolean = true, cancelable:Boolean = false) 
		{
			super(type, bubbles, cancelable);
		}
		
		override public function clone(): Event {
			return new InitializeEvent(type, bubbles, cancelable);
		}
	}
}