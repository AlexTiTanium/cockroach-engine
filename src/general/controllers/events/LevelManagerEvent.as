package general.controllers.events 
{
	import com.soma.core.interfaces.IWire;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Alex
	 */
	public class LevelManagerEvent extends Event{
		
		public static const LOAD:String = 'LevelManagerEvent.LOAD';
		
		public var level:String;

		public function LevelManagerEvent(type:String, level:String, bubbles:Boolean = true, cancelable:Boolean = false) 
		{
			this.level = level;
			super(type, bubbles, cancelable);
		}
		
		override public function clone(): Event {
			return new LevelManagerEvent(type, level, bubbles, cancelable);
		}
	}
}