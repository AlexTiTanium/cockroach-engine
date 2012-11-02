package game.menu.views {
	import classes.resourceManager.SWFResource;
	import classes.transition.animation.FadeAnimation;
	import classes.transition.animation.SlideAnimation;
	import classes.View;
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import general.controllers.events.ResManagerEvent;
	import general.controllers.events.TweenerStageEvent;
	import general.views.LoadingView;
	
	/**
	 * ...
	 * @author Alex
	 */
	public class AboutView extends View {
		
		public static const NAME: String = 'AboutView';
 		
		private var _scene:MovieClip;

		private var _btnBack:SimpleButton;
		
		public function AboutView() {
			dispatchEvent(new ResManagerEvent(ResManagerEvent.LOAD, 'general/about.swf', loadedHandle));
		}
		
		private function loadedHandle(resource:SWFResource):void {
			_scene = resource.clip;
			addChild(_scene);
			
			_btnBack = _scene['instBack'] as SimpleButton;
			
			_btnBack.addEventListener(MouseEvent.CLICK, function():void {
				
				dispatchEvent(new TweenerStageEvent(
					TweenerStageEvent.SET, 
					MainMenuView.NAME,
					SlideAnimation.SLIDE_DOWN,
					SlideAnimation.SLIDE_UP
				));
				
			});
		}
	}
}