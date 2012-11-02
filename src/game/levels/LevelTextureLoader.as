package game.levels {
	import alternativa.engine3d.core.MipMapping;
	import alternativa.engine3d.loaders.MaterialLoader;
	import alternativa.engine3d.materials.TextureMaterial;
	import classes.resourceManager.ImageResource;
	import classes.resourceManager.Resource;
	import flash.utils.Dictionary;
	import general.wires.ResourceWire;
	/**
	 * ...
	 * @author Alex
	 */
	public class LevelTextureLoader{
		
		private var _textures:Vector.<TextureMaterial>;
		private var _needLoad:uint = 0;
		private var _onComplite:Function;
		
		public function LevelTextureLoader(textures:Vector.<TextureMaterial>, onComplite:Function) {
			trace(textures);
			trace(textures);
			
			for (var key:Object in textures){
				_needLoad++;
			}
			
			_textures = textures;
			_onComplite = onComplite
			
			startLoad(textures);
		}
		
		private function startLoad(textures:Vector.<TextureMaterial>):void {
			for (var key:String in textures) {
				var fileUrl:String = textures[key].diffuseMapURL;
				ResourceWire.instance.load(Level.resourcePath + fileUrl.replace('./', ''), loadItemComplite);  
			}
		}
		
		private function loadItemComplite(texture:ImageResource):void {
			
			for (var key:String in _textures) {
			  if(texture.filename == ResourceWire.PATH_TO_RESOURCES + Level.resourcePath +  _textures[key].diffuseMapURL.replace('./', '')) {
				_textures[key].texture = texture.bitmapData;
				_textures[key].mipMapping = MipMapping.OBJECT_DISTANCE;
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
	}

}