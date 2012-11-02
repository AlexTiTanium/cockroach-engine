package game.levels.objects {
	import alternativa.engine3d.animation.AnimationClip;
	import alternativa.engine3d.animation.AnimationController;
	import alternativa.engine3d.animation.AnimationNode;
	import alternativa.engine3d.animation.AnimationSwitcher;
	import flash.display.Stage;
	import flash.events.Event;
	/**
	 * ...
	 * @author D
	 */
	public class Model3DAnimation{
		
		private var _animationClip: AnimationClip;
		private var _animationController : AnimationController = new AnimationController();
		private var _animationSwitcher : AnimationSwitcher = new AnimationSwitcher();
		private var _currentAnimation : AnimationClip = null;
		
		public function Model3DAnimation(animationClip: AnimationClip) {
			_animationClip = animationClip;
			_animationController.root = _animationSwitcher;
		}
		
		public function play():void {
			
			if (_currentAnimation != null) { this.start(); return; }
			
			_currentAnimation = _animationClip.clone();
			_animationSwitcher.addAnimation(_currentAnimation);
			
			this.start();
		}
		
		public function playPart(start:uint, end:uint):void {
			
			if (_currentAnimation != null) { this.start(); return; }
			
			_currentAnimation = _animationClip.slice(start/stage.frameRate, end/stage.frameRate);
			_animationSwitcher.addAnimation(_currentAnimation);
			
			this.start();
		}
		
		public function pause():void {
			
			stage.removeEventListener(Event.ENTER_FRAME, update);
			if (_currentAnimation) {
				_animationController.freeze();
			}
		}
		
		public function stop():void {
			
			stage.removeEventListener(Event.ENTER_FRAME, update);
			if (_currentAnimation) { _animationSwitcher.removeAnimation(_currentAnimation); }
			_currentAnimation = null;
		}
		
		private function start():void {
			stage.removeEventListener(Event.ENTER_FRAME, update);
			stage.addEventListener(Event.ENTER_FRAME, update);
		}
		
		private function update(e:Event):void {
			_animationController.update();
		}
		
		private function get stage():Stage {
			return GameApplication.instance.stage;
		}
	}

}