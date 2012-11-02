package general.wires 
{
  import com.soma.core.interfaces.IWire;
  import com.soma.core.wire.Wire;
  import com.soma.debugger.events.SomaDebuggerEvent;
  import flash.display.StageAlign;
  import flash.display.StageScaleMode;
  import game.menu.wires.MenuWire;
  import general.controllers.commands.InitializeCommand;
  import general.controllers.commands.ResourceCommand;
  import general.controllers.events.InitializeEvent;
  import general.controllers.events.ResManagerEvent;
	
	/**
	 * ...
	 * @author Alex
	 */
	public class InitializeWire extends Wire implements IWire
	{
		public static const NAME :String = 'InitializeWire';
		
		public function InitializeWire(name:String = null) {
			super(name);
		}
		
		override protected function initialize(): void {
			stage.frameRate = GameApplication.FRAME_RATE;
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			addCommand(InitializeEvent.START, InitializeCommand);
		}
		
		override protected function dispose(): void {
			
		}
		
		public function start():void {
			addWire(MenuWire.NAME,   new MenuWire());	
		}
		
	}

}