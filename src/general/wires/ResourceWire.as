package general.wires 
{
  import classes.resourceManager.ImageResource;
  import classes.resourceManager.MP3Resource;
  import classes.resourceManager.Resource;
  import classes.resourceManager.ResourceManager;
  import classes.resourceManager.SWFResource;
  import classes.resourceManager.XMLResource;
  import classes.resourceManager.YAMLResource;
  import classes.transition.animation.FadeAnimation;
  import classes.utilites.Util;
  import com.soma.core.interfaces.IWire;
  import com.soma.core.wire.Wire;
  import flash.display.StageAlign;
  import flash.display.StageScaleMode;
  import general.controllers.commands.ResourceCommand;
  import general.controllers.events.ResManagerEvent;
  import general.controllers.events.StageEvent;
  import general.controllers.events.TweenerStageEvent;
  import general.views.LoadingView;
  import resources.GeneralResources;
	
	/**
	 * ...
	 * @author Alex
	 */
	public class ResourceWire extends Wire implements IWire
	{
		public static const NAME :String = 'ResourceWire';

		static public const PATH_TO_RESOURCES : String = '../../resources/';
		static private var _RESOURCE_MANAGER: ResourceManager = new ResourceManager();
		static private var _RESOURCE_WIRE: ResourceWire;
		
		public function ResourceWire(name:String = null) {
			super(name);
			_RESOURCE_WIRE = this;
		}
		
		override protected function initialize(): void {
			
			addCommand(ResManagerEvent.LOAD, 		ResourceCommand);
			addCommand(ResManagerEvent.UNLOAD, 		ResourceCommand);
			addCommand(ResManagerEvent.FORCE_LOAD, 	ResourceCommand);
			
			new GeneralResources();
		}
		
		override protected function dispose(): void {
			
		}
		
		public function load(file:String, onComplite:Function, forceLoad:Boolean = false):void {
			RM.load(PATH_TO_RESOURCES+file, getType(file), onComplite, onFailedHandle, forceLoad);
		}
		
		public function unload(file:String):void {
			if (!RM.isLoaded(file, getType(file))) { return; }
			RM.unload(PATH_TO_RESOURCES+file, getType(file));
		}
		
		private function onFailedHandle(resource:*):void{
			trace("Couldn't load the resurce!");
		}
		
		private function getType(fileName:String):Class {
			
			var ext:String = Util.getFileExtension(fileName);
			
			switch(ext) {
				case 'png':
				case 'jpg':
				case 'gif':
				case 'bmp':
					return ImageResource;
				break;
				case 'DAE':
				case 'dae':
				case 'xml': 
					return XMLResource; 
				break;
				case 'swf':  return SWFResource;  break;
				case 'yaml': return YAMLResource; break;
				case 'mp3':  return MP3Resource;  break;
			}
			
			throw new Error('Ext '+ext+' not registered');
		} 
		
		static public function get RM():ResourceManager { return _RESOURCE_MANAGER; }
		static public function get instance():ResourceWire { return _RESOURCE_WIRE; }

	}

}