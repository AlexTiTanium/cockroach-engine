package game.levels.container {
	import alternativa.engine3d.containers.BSPContainer;
	import alternativa.engine3d.core.Clipping;
	import alternativa.engine3d.core.Object3D;
	import alternativa.engine3d.core.Sorting;
	import alternativa.engine3d.objects.BSP;
	import alternativa.engine3d.objects.Mesh;
	import flash.utils.Dictionary;
	import game.levels.Level;
	
	/**
	 * ...
	 * @author Alex
	 */
	public class LevelBSPContainer extends BSPContainer{
		
		public function LevelBSPContainer(models: Dictionary) {
			super();
			
			var staticGeometry : Vector.<Mesh> = new Vector.<Mesh>();
			var staticObjects : Vector.<Object3D> = new Vector.<Object3D>();
			
			for (var key: String in models.staticGeometry) {
				staticGeometry.push(Level.getModel(models.staticGeometry[key]).object as Mesh);
			}
			
			for (var key2: String in models.staticObjects) {
				staticObjects.push(Level.getModel(models.staticObjects[key2]).object as Object3D);
			}
			
			for (var key3: String in models.dynamicObjects) {
				var dynamicBSPMesh : Mesh = Level.getModel(models.dynamicObjects[key3]).object as Mesh;
				dynamicBSPMesh.sorting = Sorting.DYNAMIC_BSP;
			    dynamicBSPMesh.optimizeForDynamicBSP(dynamicBSPMesh.faces.length/4);
			    addChild(dynamicBSPMesh);
			}
			
			for (var key4: String in models.zSorting) {
				var zsortingMesh : Mesh = Level.getModel(models.zSorting[key4]).object as Mesh;
				zsortingMesh.sorting = Sorting.AVERAGE_Z;
			    addChild(zsortingMesh);
			}
			
			createTree(staticGeometry,null, true, staticObjects);
		}
		
	}

}