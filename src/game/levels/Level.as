package game.levels {
	import alternativa.engine3d.containers.ConflictContainer;
	import alternativa.engine3d.core.Object3D;
	import alternativa.engine3d.core.Object3DContainer;
	import classes.View;
	import flash.utils.Dictionary;
	import game.levels.console.LuaScript;
	import game.levels.container.LevelBSPContainer;
	import game.levels.LevelContainer3D;
	import game.levels.objects.LevelModel3D;
	import jiglib.plugin.alternativa3d.Alternativa3dPhysics;
	
	/**
	 * ...
	 * @author Alex
	 */
	public class Level {
		
		public static var scene: Level3DScene;
		public static var camera: LevelCamera3D;
		public static var resourcePath: String;
		public static var colladaResources: LevelColladaResources;
		public static var models: Dictionary = new Dictionary();
		public static var physics: Alternativa3dPhysics;
		public static var lua: LuaScript;
		public static var _aditionalObjectsForBSP : Array = new Array();

		public static function addModel(model:Dictionary):void{
			models[model.name] = new LevelModel3D(model);
		}
		
		public static function getModel(name:String):LevelModel3D {
			if(!models[name]) { throw new Error('Not found 3dModel: ' + name); }
			return models[name];
		}
		
		public static function addContainer(object3DContainer:Object3DContainer):void{
			scene.addToContainer(object3DContainer);
		}
		
		static public function setBSPContainer(bspContainer:LevelBSPContainer):void{
			scene.BspContainer = bspContainer;
			for (var key: String in _aditionalObjectsForBSP) {
				scene.BspContainer.addChild(_aditionalObjectsForBSP[key]);
			}
			addContainer(scene.BspContainer);
		}
		
		static public function addToBSPContainer(object:Object3D):void{
			_aditionalObjectsForBSP.push(object);
		}
		
	}

}