package resources {
	import classes.resourceManager.ResourceBundle;
	
	public class GeneralResources extends ResourceBundle{
		
		[Embed(source="../../resources/general/intro.swf", mimeType='application/octet-stream')]
		public var introMovie:Class;
		
		[Embed(source="../../resources/general/menu.swf", mimeType='application/octet-stream')]
		public var menuScene:Class;
		
		[Embed(source="../../resources/general/loading.swf", mimeType='application/octet-stream')]
		public var loadingScene:Class;
		
		[Embed(source="../../resources/general/selectLevel.swf", mimeType='application/octet-stream')]
		public var selectLevelScene:Class;
		
		[Embed(source="../../resources/general/about.swf", mimeType='application/octet-stream')]
		public var aboutScene:Class;
		
		[Embed(source="../../resources/levels/level1/level.yaml", mimeType='application/octet-stream')]
		public var level1:Class;
		
	}

}