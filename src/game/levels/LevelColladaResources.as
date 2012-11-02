package game.levels {
	import alternativa.engine3d.animation.AnimationClip;
	import alternativa.engine3d.core.Object3D;
	import alternativa.engine3d.loaders.ParserCollada;
	import alternativa.engine3d.objects.Mesh;
	import classes.resourceManager.Resource;
	import classes.resourceManager.XMLResource;
	import flash.utils.Dictionary;
	import general.wires.ResourceWire;
	/**
	 * ...
	 * @author Alex
	 */
	public class LevelColladaResources{
		
		private var _resources:Dictionary = new Dictionary();
		private var _needLoad:uint = 0;
		private var _onComplite:Function;
		
		public function LevelColladaResources(resources:Dictionary, onComplite: Function) {

			for (var key:Object in resources){
				_needLoad++;
			}
			
			_onComplite = onComplite;
			_resources = resources;
			
			startLoad(resources);
		}
		
		private function startLoad(resources:Dictionary):void {
			for (var item:String in resources) {
				ResourceWire.instance.load(Level.resourcePath + resources[item], loadItemComplite);  
			}
		}
		
		private function loadItemComplite(resource:Resource):void {
			
			for (var item:String in _resources) {
			  if(resource.filename == ResourceWire.PATH_TO_RESOURCES + Level.resourcePath + _resources[item]) {
				
				var resourceXml:XMLResource = resource as XMLResource;
				var parser:ParserCollada = new ParserCollada();
				parser.parse(resourceXml.XMLData);
				_resources[item] = parser;
				
				trace(parser.objects);
				
				var textureLoader: LevelTextureLoader = new LevelTextureLoader(_resources[item].textureMaterials, isLoadingFinish);
			  }
			}
			
			isLoadingFinish();
		}
		
		private function isLoadingFinish():void {
			_needLoad--;
			
			if(_needLoad == 0) {
				_onComplite();
			}	
		}
		
		public function getObject(source:String,name:String):Object3D {
			return _resources[source].getObjectByName(name);
		}
		
		public function getAnimation(source:String, object:Object): AnimationClip {
			return _resources[source].getAnimationByObject(object);
		}
		
		public function getLayers(source:String, object:Object): AnimationClip {
			return _resources[source].getAnimationByObject(object);
		}
	}
}