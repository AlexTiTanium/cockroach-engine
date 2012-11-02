package general.controllers.events 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Alex
	 */
	public class ResManagerEvent extends Event{
		
		public static const LOAD:String = 'ResManagerEvent.LOAD';
		public static const UNLOAD:String = 'ResManagerEvent.UNLOAD';
		public static const FORCE_LOAD:String = 'ResManagerEvent.FORCE_LOAD';
		public static const PRELOAD:String = 'ResManagerEvent.PRELOAD';
		
		public var file:String;
		public var onComplite:Function;
    
		public function ResManagerEvent(type:String, file:String, onComplite:Function, bubbles:Boolean = true, cancelable:Boolean = false) {
			this.file = file;
			this.onComplite = onComplite;
			super(type, bubbles, cancelable);
		}
		
		override public function clone(): Event {
			return new ResManagerEvent(type, file, onComplite, bubbles, cancelable);
		}
	}
}