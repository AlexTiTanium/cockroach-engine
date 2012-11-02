package game.menu.views {
	import adobe.utils.CustomActions;
	import classes.resourceManager.SWFResource;
	import classes.transition.animation.FadeAnimation;
	import classes.transition.animation.SlideAnimation;
	import classes.View;
	import com.soma.debugger.events.SomaDebuggerEvent;
	import com.soma.debugger.SomaDebugger;
	import flash.display.MovieClip;
	import flash.events.Event;
	import general.controllers.events.ResManagerEvent;
	import general.controllers.events.TweenerStageEvent;
	
	/**
	 * ...
	 * @author Alex
	 */
	public class IntroView extends View {
		
		public static const NAME: String = "IntroView";
		
		private var _scene : MovieClip;
		private var _clip : MovieClip; 
		
		public function IntroView() {
			dispatchEvent(new ResManagerEvent(ResManagerEvent.LOAD,'general/intro.swf',loadedHandle));
		}
		
		private function loadedHandle(resource:SWFResource):void {
			_scene = resource.clip;
			addChild(_scene);
			
			_clip = _scene['instAlternativa'] as MovieClip;
			
			dispatchEvent(new TweenerStageEvent(
				TweenerStageEvent.SET, 
				IntroView.NAME,
				FadeAnimation.FADE_IN,
				FadeAnimation.FADE_OUT
			));
			
			_clip.addEventListener(Event.ENTER_FRAME, stopMovie);
		} 
		
		private function stopMovie(e:Event):void {
			if(_clip.currentFrame != _clip.totalFrames) { return; }
			_clip.stop();
			_clip.removeEventListener(Event.ENTER_FRAME, stopMovie);
			/*
			dispatchEvent(new TweenerStageEvent(
				TweenerStageEvent.SET, 
				MainMenuView.NAME,
				SlideAnimation.SLIDE_RIGHT,
				SlideAnimation.SLIDE_LEFT
			));*/
			
			dispatchEvent(new TweenerStageEvent(
				TweenerStageEvent.SET, 
				SelectLevelView.NAME,
				SlideAnimation.SLIDE_RIGHT,
				SlideAnimation.SLIDE_LEFT
			));
		}

	}

}