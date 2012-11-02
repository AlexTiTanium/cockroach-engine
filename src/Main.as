package 
{
	import com.soma.core.interfaces.ISoma;
	import flash.display.Sprite;
	import flash.events.Event;

	/**
	 * ...
	 * @author Alex
	 */
	[Frame(factoryClass = "Preloader")]
	[SWF(backgroundColor="404060")]
	public class Main extends Sprite 
	{
		private var _app:ISoma;

		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}

		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			_app = new GameApplication(this, true);

		}

	}

}