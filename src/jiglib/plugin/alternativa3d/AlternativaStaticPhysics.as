package jiglib.plugin.alternativa3d {
	import alternativa.engine3d.objects.Mesh;
	import flash.utils.Dictionary;
	/**
	 * ...
	 * @author Alex
	 */
	public class AlternativaStaticPhysics {
		
		private const NAME_LAYER : String = 'physic';
		private var objects: Dictionary = new Dictionary();
		
		public function AlternativaStaticPhysics(colladaLayers:Dictionary) {
			for (var mesh:Mesh  in colladaLayers) {
				if(colladaLayers[mesh] != NAME_LAYER) { continue; }
				
				var name: String = colladaLayers[mesh];
				var type:String = name.substr(0, 3);
				
				switch(type) {
					case 'Pla':
						trace('Plane');
					break;
				}
					
				
			}
		}
		
	}

}