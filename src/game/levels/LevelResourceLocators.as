package game.levels {
	import flash.utils.getDefinitionByName;
	import resources.Level1_Resources;
	/**
	 * ...
	 * @author Alex
	 */
	public class LevelResourceLocators{
		
		private var _libraryClasses: Array = [Level1_Resources]; 
		
		public function LevelResourceLocators(locators:Array) {
			for(var i:String in locators) {
				new (getDefinitionByName("resources."+locators[i]) as Class);
			}
		}
		
	}

}