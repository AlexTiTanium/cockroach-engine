package general.wires 
{
  import caurina.transitions.Tweener;
  import classes.resourceManager.YAMLResource;
  import com.junkbyte.console.Cc;
  import com.soma.core.interfaces.IWire;
  import com.soma.core.wire.Wire;
  import flash.events.KeyboardEvent;
  import flash.events.MouseEvent;
  import flash.utils.Dictionary;
  import game.levels.console.LuaScript;
  import game.levels.Level;
  import game.levels.Level3DScene;
  import game.levels.LevelCamera3D;
  import game.levels.LevelColladaResources;
  import game.levels.LevelContainer3D;
  import game.levels.LevelResourceLocators;
  import general.controllers.commands.LevelManagerCommand;
  import general.controllers.commands.LuaLevelCommand;
  import general.controllers.events.LevelManagerEvent;
  import general.controllers.events.LuaLevelEvent;
  import general.controllers.events.ResManagerEvent;
  import general.controllers.events.StageEvent;
  import general.views.ScriptBoxView;
  import jiglib.plugin.alternativa3d.Alternativa3dPhysics;
  import luaAlchemy.LuaAlchemy;
	
	/**
	 * ...
	 * @author Alex
	 */
	public class LevelManagerWire extends Wire implements IWire
	{
		public static const NAME:String = 'LevelManagerWire';
		private var _yaml: Dictionary;

		public function LevelManagerWire(name:String = null) {
			super(name);
		}
		
		override protected function initialize(): void {
			addCommand(LevelManagerEvent.LOAD,  LevelManagerCommand);
			addCommand(LuaLevelEvent.RUN, 		LuaLevelCommand);
		}
		
		override protected function dispose(): void {
			
		}
		
		public function load(level:String):void {
			Level.resourcePath = 'levels/' + level + '/';
			dispatchEvent(new ResManagerEvent(ResManagerEvent.LOAD,Level.resourcePath+'level.yaml',loadedHandle));
		}
		
		public function runLuaScript(script:String):void{
			Level.lua.runStringScript(script);
		}
		
		private function loadedHandle(resource:YAMLResource):void {
			var yaml:Dictionary = resource.YAMLData as Dictionary;
			_yaml = yaml.Level;
			
			new LevelResourceLocators(_yaml.locators);
			
			prepareColladaResources();
		}
		
		private function prepareColladaResources():void{
			Level.colladaResources = new LevelColladaResources(_yaml.collada, build);
		}
		
		private function build():void {
			
			Level.scene  = new Level3DScene();
			Level.camera = new LevelCamera3D(_yaml.camera);
			Level.scene.addCamera(Level.camera);
			Level.physics = new Alternativa3dPhysics(2, _yaml.camera.physDubug);
			Level.lua = new LuaScript(new LuaAlchemy());
			
			Level.lua.interpritator.setGlobal('scene',   Level.scene);
			Level.lua.interpritator.setGlobal('camera',  Level.camera);
			Level.lua.interpritator.setGlobal('physics', Level.physics);
			Level.lua.interpritator.setGlobal('console', Cc);
			Level.lua.interpritator.setGlobal('tweener', Tweener);		
			
			for (var key: String in _yaml.models) {
				Level.addModel(_yaml.models[key].model);
			}
			
			for (var key2: String in _yaml.containers) {
				new LevelContainer3D(key2, _yaml.containers[key2]);
			}
			
			Cc.store('level', Level);
			
			addToStage();
		}
		
		private function addToStage():void {
			if(hasView(Level3DScene.NAME)) { removeView(Level3DScene.NAME); }
			addView(Level3DScene.NAME, Level.scene);
			
			dispatchEvent(new StageEvent(StageEvent.SET, Level3DScene.NAME));
		}
	}
}