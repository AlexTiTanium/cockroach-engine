package game.levels {
	import alternativa.engine3d.containers.BSPContainer;
	import alternativa.engine3d.containers.ConflictContainer;
	import alternativa.engine3d.containers.DistanceSortContainer;
	import alternativa.engine3d.containers.KDContainer;
	import alternativa.engine3d.containers.LODContainer;
	import alternativa.engine3d.core.Object3DContainer;
	import flash.utils.Dictionary;
	import flash.utils.getDefinitionByName;
	import game.levels.container.LevelBSPContainer;
	import game.levels.objects.LevelModel3D;
	
	/**
	 * ...
	 * @author Alex
	 */
	public class LevelContainer3D {
		
		public function LevelContainer3D(typeOfContainer:String, models:Dictionary) {
			
			switch(typeOfContainer) {
				case 'BSPContainer':
					Level.setBSPContainer(new LevelBSPContainer(models));
				break;
			}
			
		}
		
	}

}