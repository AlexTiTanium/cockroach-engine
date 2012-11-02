package game.levels {
	import alternativa.engine3d.core.Camera3D;
	import alternativa.engine3d.core.Debug;
	import alternativa.engine3d.core.Object3D;
	import alternativa.engine3d.core.Object3DContainer;
	import alternativa.engine3d.containers.*;
	import alternativa.engine3d.materials.FillMaterial;
	import alternativa.engine3d.primitives.Box;
	import classes.View;
	import flash.utils.getDefinitionByName;
	import game.levels.container.LevelBSPContainer;
	
	/**
	 * ...
	 * @author Alex
	 */
	public class Level3DScene extends View {
		
		public static const NAME: String = 'Level3DScene'; 
		
		private var _baseContainer: Object3DContainer;
		private var _BSPContainer: LevelBSPContainer;

		public function Level3DScene() {
			_baseContainer = new Object3DContainer();
		}
		
		public function addToContainer(addObject3D: Object3D):void {
			_baseContainer.addChild(addObject3D);
		}
		
		public function addCamera(camera:Camera3D):void {
			addToContainer(camera);
			addChild(camera.view);
			if(GameApplication.debugMode) {
				addChild(camera.diagram);
			}
		}
		
		public function get baseContainer():Object3DContainer { return _baseContainer; }
		
		public function get BspContainer():LevelBSPContainer { return _BSPContainer; }
		public function set BspContainer(value:LevelBSPContainer):void {_BSPContainer = value; }
		
	}

}