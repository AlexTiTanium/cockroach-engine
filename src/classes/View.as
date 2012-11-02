package classes {
	import com.soma.core.interfaces.ISoma;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	
	/**
	 * ...
	 * @author Alex
	 */
	public class View extends Sprite {
		
		private var _instance:ISoma = GameApplication.instance;
		
		/* INTERFACE flash.events.IEventDispatcher */
		
		override public function dispatchEvent(event:Event):Boolean{
			return instance.dispatchEvent(event);
		}
		/*
		override public function hasEventListener(type:String):Boolean{
			return instance.hasEventListener(type);
		}
		
		override public function willTrigger(type:String):Boolean{
			return instance.willTrigger(type);
		}
		
		override public function removeEventListener(type:String, listener:Function, useCapture:Boolean = false):void{
			instance.removeEventListener(type,listener,useCapture);
		}
		
		override public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void{
			instance.addEventListener(type,listener,useCapture,priority,useWeakReference);
		}
		*/
		private function get instance():ISoma { return _instance; }
				
	}

}