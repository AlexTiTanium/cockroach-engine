package classes.transition.animation {
	import caurina.transitions.Tweener;
	import classes.transition.TransitionImage;
	import flash.display.DisplayObject;
	
	/**
	 * @author Division
	 */
	public class FadeAnimation {
		
		public static const FADE_OUT : String = 'FadeAnimation.OUT';
		public static const FADE_IN  : String = 'FadeAnimation.IN';
		
		private var _style : String = FADE_OUT;
		private var _ease : String = 'linear';
		
		private var _obj : DisplayObject;
		
		private var _onComplite:Function = function():void{};
		private var _beforeStart:Function = function():void{};
		
		public function FadeAnimation(obj:DisplayObject) {
			if(!obj) { throw Error('Object for fade animation is false or null');  }
			_obj = obj;
		}
		
		/**
		 * Здесь задаем анимацию твинами
		 */
		public function start() : void {
			// Стартовая позиция
			var startAlpha : Number = 0;
			var endAlpha : Number = 0;
			
			var w : Number = _obj.width;
			var h : Number = _obj.height;
			
		
			switch(_style) {
				
				case FADE_OUT:
					startAlpha = 1;
					endAlpha = 0;

				break;
				
				case FADE_IN:
					startAlpha = 0;
					endAlpha = 1;
				break;
			}
			
			var transImage : TransitionImage  = new TransitionImage(w, h);
			
			transImage.render(_obj);
			
			var link : DisplayObject = GameApplication.instance.stage.addChild(transImage);
		 	
			if(_beforeStart != null){ _beforeStart(); }
			link.alpha = startAlpha;
			
			Tweener.addTween(link, { 
				alpha: endAlpha,
				time: 0.7, 
				transition: _ease,
				onComplete:function():void {
					if(_onComplite != null){ _onComplite(); }
					GameApplication.instance.stage.removeChild(link);
				}
			});
			
		}
		
		public function set style(value:String):void {
			_style = value;
		}
		
		public function set ease(value:String):void {
			_ease = value;
		}
		
		public function set onComplite(value:Function):void {
			_onComplite = value;
		}
		
		public function set beforeStart(value:Function):void {
			_beforeStart = value;
		}

	}

}