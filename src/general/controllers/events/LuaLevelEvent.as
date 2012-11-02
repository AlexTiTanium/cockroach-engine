package general.controllers.events 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Alex
	 */
	public class LuaLevelEvent extends Event{
		
		public static const RUN:String = 'LuaLevelEvent.RUN';
		
		public var script:String;
	
		public function LuaLevelEvent(type:String, script:String, bubbles:Boolean = true, cancelable:Boolean = false) 
		{
			this.script = script;
			super(type, bubbles, cancelable);
		}
		
		override public function clone(): Event {
			return new LuaLevelEvent(type, script, bubbles, cancelable);
		}
	}
}