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
	public class MainMenuView extends View {
		
		public static const NAME: String = 'MainMenuView';
 		
		private var _scene:MovieClip;
		
		private var _btnStart:SimpleButton;
		private var _btnPopup:SimpleButton;
		private var _btnAbout:SimpleButton;
		
		public function MainMenuView() {
			dispatchEvent(new ResManagerEvent(ResManagerEvent.LOAD, 'general/menu.swf', loadedHandle));
		}
		
		private function loadedHandle(resource:SWFResource):void {
			_scene = resource.clip;
			addChild(_scene);
			
			_btnStart = _scene['insStartBtn'] as SimpleButton;
			
			_btnStart.addEventListener(MouseEvent.CLICK, function():void {
				
				dispatchEvent(new TweenerStageEvent(
					TweenerStageEvent.SET, 
					SelectLevelView.NAME,
					SlideAnimation.SLIDE_RIGHT,
					SlideAnimation.SLIDE_LEFT
				));
				
			});
			
			_btnPopup = _scene['instPopup'] as SimpleButton;
			_btnPopup.addEventListener(MouseEvent.CLICK, function():void {
				
				dispatchEvent(new TweenerStageEvent(
					TweenerStageEvent.ADD, 
					LoadingView.NAME,
					FadeAnimation.FADE_IN,
					FadeAnimation.FADE_OUT
				));
				
			});
			
			_btnAbout = _scene['intAbout'] as SimpleButton;
			_btnAbout.addEventListener(MouseEvent.CLICK, function():void {
				
				dispatchEvent(new TweenerStageEvent(
					TweenerStageEvent.SET, 
					AboutView.NAME,
					SlideAnimation.SLIDE_UP,
					SlideAnimation.SLIDE_DOWN
				));
				
			});
			
		}
		
	}

}