package game.menu.views {
	import classes.resourceManager.SWFResource;
	import classes.transition.animation.FadeAnimation;
	import classes.transition.animation.SlideAnimation;
	import classes.View;
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import general.controllers.events.LevelManagerEvent;
	import general.controllers.events.ResManagerEvent;
	import general.controllers.events.TweenerStageEvent;
	
	/**
	 * ...
	 * @author Alex
	 */
	public class SelectLevelView extends View {
		
		public static const NAME: String = 'SelectLevelView';
 		
		private var _scene:MovieClip;
		private var _btnToMenu:SimpleButton;
		
		private var _level_1: SimpleButton;
		
		public function SelectLevelView() {
			dispatchEvent(new ResManagerEvent(ResManagerEvent.LOAD, 'general/selectLevel.swf', loadedHandle));
		}
		
		private function loadedHandle(resource:SWFResource):void {
			_scene = resource.clip;
			addChild(_scene);
			
			_btnToMenu = _scene['instBackToMenu'] as SimpleButton;
			_level_1 = _scene['instLevel1'] as SimpleButton;
			
			_btnToMenu.addEventListener(MouseEvent.CLICK, function():void {
				dispatchEvent(new TweenerStageEvent(
					TweenerStageEvent.SET, 
					MainMenuView.NAME,
					SlideAnimation.SLIDE_LEFT,
					SlideAnimation.SLIDE_RIGHT
				));
			});
			
			_level_1.addEventListener(MouseEvent.CLICK, loadLevel);
		}
		
		private function loadLevel(e:MouseEvent):void {
			
			switch(e.target) {
				case _level_1:
					var level:String =  'level1';
				break;
			}
			
			dispatchEvent(new LevelManagerEvent(LevelManagerEvent.LOAD, level));
		}
		
	}

}