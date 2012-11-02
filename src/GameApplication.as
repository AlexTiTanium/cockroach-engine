package  
{
	import com.junkbyte.console.Cc;
	import com.soma.core.interfaces.ISoma;
	import com.soma.core.Soma;
	import com.soma.debugger.events.SomaDebuggerEvent;
	import com.soma.debugger.SomaDebugger;
	import com.soma.debugger.vo.SomaDebuggerVO;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import general.controllers.events.InitializeEvent;
	import general.controllers.events.ResManagerEvent;
	import general.views.LoadingView;
	import general.views.ScriptBoxView;
	import general.wires.InitializeWire;
	import general.wires.LevelManagerWire;
	import general.wires.ResourceWire;
	import general.wires.StageWire;
	
	/**
	 * ...
	 * @author Alex
	 */
	public class GameApplication extends Soma implements ISoma {
		
		private var _container:Sprite;
		private static var _debugMode:Boolean;
		
		public static const SCREEN_WIDTH:int = 640;
		public static const SCREEN_HEIGHT: int = 480;
		public static const FRAME_RATE: int = 60;
		
		private static var _instance: GameApplication;
		
		public function GameApplication(container:Sprite, debugMode : Boolean = false) 
		{	
			_debugMode = debugMode;
			_container = container;
			super(_container.stage);
			_instance = this;
			createDebugger();
			
			// start
			addView(LoadingView.NAME, new LoadingView());
			dispatchEvent(new InitializeEvent(InitializeEvent.START));
		}
		
		private function createDebugger():void
		{
			if (_debugMode) {
				//SomaDebugger.WEAK_REFERENCE = false;
				createPlugin(SomaDebugger, new SomaDebuggerVO(this,SomaDebugger.NAME_DEFAULT, getCommands(), true, true));
				dispatchEvent(new SomaDebuggerEvent(SomaDebuggerEvent.HIDE_DEBUGGER));
				
				stage.addEventListener(KeyboardEvent.KEY_DOWN, function(e:KeyboardEvent):void { 
					if (e.keyCode == Keyboard.F1) {
						dispatchEvent(new SomaDebuggerEvent(SomaDebuggerEvent.SHOW_DEBUGGER));
						dispatchEvent(new SomaDebuggerEvent(SomaDebuggerEvent.MOVE_TO_TOP));
					}
				});
				
				Cc.config.style.backgroundAlpha = 0.8;
				Cc.config.style.whiteBase();
				Cc.config.commandLineAllowed = true;
				Cc.config.alwaysOnTop = false;
				Cc.startOnStage(stage, '`');
				Cc.height = 130;
				Cc.commandLine = true;
			
			}
		}
		
		override protected function registerWires(): void {
			
			addWire(InitializeWire.NAME,    new InitializeWire());
			addWire(ResourceWire.NAME,      new ResourceWire());
			addWire(StageWire.NAME,         new StageWire());
			addWire(LevelManagerWire.NAME,  new LevelManagerWire());
		}
		
		override protected function registerCommands(): void {
		
		}
		
		public static function dispatchEvent(e:Event):void {
			stage.dispatchEvent(e);
		}
		
		public static function addView(viewName:String, view:Object):void {
			instance.addView(viewName, view);
		}
		
		public function get container():Sprite { return _container; }
		
		public static function get instance():GameApplication { return _instance; }
		
		public static function get debugMode():Boolean { return _debugMode; }
		
		public static function get stage():Stage { return instance.stage; }

	}

}