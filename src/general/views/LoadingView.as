package general.views {
	import classes.resourceManager.SWFResource;
	import classes.transition.animation.FadeAnimation;
	import classes.View;
	import com.soma.debugger.events.SomaDebuggerEvent;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import general.controllers.events.ResManagerEvent;
	import general.controllers.events.TweenerStageEvent;
	
	/**
	 * ...
	 * @author Alex
	 */
	public class LoadingView extends View {
		
		public static const NAME: String = 'LoadingView';
 		
		private var _scene:MovieClip;

		public function LoadingView() {
			dispatchEvent(new ResManagerEvent(ResManagerEvent.LOAD, 'general/loading.swf', loadedHandle));
		}
		
		private function loadedHandle(resource:SWFResource):void {
			_scene = resource.clip;
			addChild(_scene);
			
			_scene.addEventListener(MouseEvent.CLICK, function():void { 
				
				dispatchEvent(new TweenerStageEvent(
					TweenerStageEvent.REMOVE, 
					LoadingView.NAME,
					FadeAnimation.FADE_IN,
					FadeAnimation.FADE_OUT
				));
				
			});
			
		}
		
	}

}