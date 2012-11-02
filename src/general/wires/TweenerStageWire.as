package general.wires 
{
  import caurina.transitions.Tweener;
  import classes.transition.animation.FadeAnimation;
  import classes.transition.animation.SlideAnimation;
  import classes.transition.TransitionImage;
  import com.soma.core.interfaces.IWire;
  import com.soma.core.wire.Wire;
  import flash.display.DisplayObject;
  import flash.display.Sprite;
  import flash.display.Stage;
  import flash.display.StageAlign;
  import flash.display.StageScaleMode;
  import flash.utils.Dictionary;
  import general.controllers.commands.StageCommand;
  import general.controllers.commands.TweenerStageCommand;
  import general.controllers.events.StageEvent;
  import general.controllers.events.TweenerStageEvent;
  import resources.GeneralResources;
	
	/**
	 * ...
	 * @author Alex
	 */
	public class TweenerStageWire extends Wire implements IWire
	{
		public static const NAME :String = 'TweenerStageWire';
		public static var previusEffect:String;  
		
		public function TweenerStageWire(name:String = null) {
			super(name);
		}
		
		override protected function initialize(): void {
			addCommand(TweenerStageEvent.ADD,     TweenerStageCommand);
			addCommand(TweenerStageEvent.CLEAR,   TweenerStageCommand);
			addCommand(TweenerStageEvent.REMOVE,  TweenerStageCommand);
			addCommand(TweenerStageEvent.SET,     TweenerStageCommand);
		}
		
		override protected function dispose(): void {
			
		}
		
		public function addToStage(viewName: String, tweenerInEffect:String):void {
			
			if (tweenerInEffect == null) {
				dispatchEvent(new StageEvent(StageEvent.ADD, viewName));  
				return;
			}	
			
			var sprite: Sprite = getView(viewName) as Sprite;
			
			setTween(tweenerInEffect, sprite, SlideAnimation.IN, function():void {
				dispatchEvent(new StageEvent(StageEvent.ADD, viewName));  
			}, null);
		}
		
		public function setToStage(viewName: String, tweenerInEffect:String, tweenerOutEffect:String):void {
			cleareStage(tweenerOutEffect);
			addToStage(viewName, tweenerInEffect);

		}
		
		public function removeFromStage(viewName: String, tweenerOutEffect:String):void {
			
			if (tweenerOutEffect == null) {
				dispatchEvent(new StageEvent(StageEvent.REMOVE, viewName));
				return;
			}
			
			var sprite: Sprite = getView(viewName) as Sprite;			
			setTween(tweenerOutEffect, sprite, SlideAnimation.OUT, null, function():void {
				dispatchEvent(new StageEvent(StageEvent.REMOVE, viewName));
			});
		}
		
		public function cleareStage(tweenerOutEffect:String):void {
			
			if (tweenerOutEffect == null) {
				dispatchEvent(new StageEvent(StageEvent.CLEAR));
				return;
			}
			
			setTween(tweenerOutEffect, stage, SlideAnimation.OUT, null, function():void {
				dispatchEvent(new StageEvent(StageEvent.CLEAR));
			});
		}
	
		private function setTween(effect:String, displayObject:DisplayObject, animationStyle:String, onComplite: Function, beforeStart: Function ): void {
			
			switch(effect) {
				case SlideAnimation.SLIDE_LEFT: 
				case SlideAnimation.SLIDE_RIGHT: 
				case SlideAnimation.SLIDE_UP:
				case SlideAnimation.SLIDE_DOWN: 
					var animation: SlideAnimation = new SlideAnimation(displayObject);
					animation.style = animationStyle;
					animation.beforeStart = beforeStart;
					animation.onComplite = onComplite;
					animation.direction = effect;
					animation.ease = 'easeInOutQuint';	
					animation.start();
				break;
				case FadeAnimation.FADE_IN:
				case FadeAnimation.FADE_OUT:
					var fadeAnimation : FadeAnimation = new FadeAnimation(displayObject);
					fadeAnimation.style = effect
					fadeAnimation.beforeStart = beforeStart;
					fadeAnimation.onComplite = onComplite;
					fadeAnimation.ease = 'easeInOutQuint';
					fadeAnimation.start();
				break;
				
			}
			
			previusEffect = effect;
		
		}
		
	}

}