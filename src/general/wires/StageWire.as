package general.wires 
{
  import com.soma.core.interfaces.IWire;
  import com.soma.core.wire.Wire;
  import flash.display.DisplayObject;
  import flash.display.Sprite;
  import flash.display.Stage;
  import flash.display.StageAlign;
  import flash.display.StageScaleMode;
  import flash.utils.Dictionary;
  import general.controllers.commands.StageCommand;
  import general.controllers.events.StageEvent;
  import resources.GeneralResources;
	
	/**
	 * ...
	 * @author Alex
	 */
	public class StageWire extends Wire implements IWire
	{
		public static const NAME :String = 'StageWire';
		
		private var _onStage: Dictionary = new Dictionary;
		private var _backSprite: Sprite = new Sprite();
		
		public function StageWire(name:String = null) {
			super(name);
		}
		
		override protected function initialize(): void {
			addCommand(StageEvent.ADD,     StageCommand);
			addCommand(StageEvent.CLEAR,   StageCommand);
			addCommand(StageEvent.REMOVE,  StageCommand);
			addCommand(StageEvent.SET,     StageCommand);
			
			addWire(TweenerStageWire.NAME, new TweenerStageWire());
			
			stage.addChild(_backSprite);
		}
		
		override protected function dispose(): void {
			
		}
		
		public function addToStage(viewName: String):void {
			if (viewName == '') {  throw new Error('You must set name of view');  }
			if (!hasView(viewName)){ throw new Error('View with name '+viewName+' was not refisered');  }
			
			_onStage[viewName] = getView(viewName);
			backSprite.addChild(getView(viewName) as Sprite);
		}
		
		public function setToStage(viewName: String):void {
			cleareStage();
			addToStage(viewName);
		}
		
		public function removeFromStage(viewName: String):void {
			if (viewName == '') {  throw new Error('You must set name of view');  }
			if (_onStage[viewName] && stage.contains(_onStage[viewName])) {
				backSprite.removeChild(_onStage[viewName]);
			}
		}
		
		public function cleareStage():void {
		 	for (var name:String in _onStage) {
				removeFromStage(name);
			}
		}
		
		public function get backSprite():Sprite { return _backSprite; }

	}

}