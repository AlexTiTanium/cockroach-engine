package resources {
	import classes.resourceManager.ResourceBundle;
	
	public class Level1_Resources extends ResourceBundle {
		
		[Embed(source="../../resources/levels/level1/collada/scene.DAE", mimeType='application/octet-stream')]
		public var scene:Class;
		
	}

}