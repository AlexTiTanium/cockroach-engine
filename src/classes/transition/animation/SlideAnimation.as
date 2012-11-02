package classes.transition.animation {
	import caurina.transitions.Tweener;
	import classes.transition.TransitionImage;
	import flash.display.DisplayObject;
	
	/**
	 * @author Division
	 */
	public class SlideAnimation {
		
		/**
		 * Направление движения
		 */
		public static const SLIDE_LEFT  : String = 'SlideAnimation.SLIDE_LEFT';
		public static const SLIDE_RIGHT : String = 'SlideAnimation.SLIDE_RIGHT';
		public static const SLIDE_UP    : String = 'SlideAnimation.SLIDE_UP';
		public static const SLIDE_DOWN  : String = 'SlideAnimation.SLIDE_DOWN';
		
		public static const OUT : String = 'SlideAnimation.OUT';
		public static const IN  : String = 'SlideAnimation.IN';
		
		private var _direction : String = SLIDE_LEFT;
		private var _style : String = OUT;
		private var _ease : String = 'linear';
		
		private var _obj : DisplayObject;
		
		private var _onComplite:Function = function():void{};
		private var _beforeStart:Function = function():void{};
		
		public function SlideAnimation(obj:DisplayObject) {
			_obj = obj;
		}
		
		/**
		 * Здесь задаем анимацию твинами
		 */
		public function start() : void {
			// Стартовая позиция
			var startX : Number = 0;
			var startY : Number = 0;
			// Конечная позиция
			var endX : Number = 0;
			var endY : Number = 0;
			//  Вектор движения
			var vectX : Number = 0;
			var vectY : Number = 0;
			
			var w : Number = _obj.width;
			var h : Number = _obj.height;
			
			switch (_direction) {
				case SLIDE_UP:
					vectY= -1;
				break;
				case SLIDE_DOWN:
					vectY = 1;
				break;
				case SLIDE_LEFT:
					vectX= -1;
				break;
				case SLIDE_RIGHT:
					vectX = 1;
				break;
			}
			
			switch(_style) {
				
				case OUT:
					startX = 0;
					startY = 0;
					
					endX = vectX * GameApplication.SCREEN_WIDTH;
					endY = vectY * GameApplication.SCREEN_HEIGHT;
				break;
				
				case IN:
					startX = vectX * GameApplication.SCREEN_WIDTH;
					startY = vectY * GameApplication.SCREEN_HEIGHT;
					
					endX = 0;
					endY = 0;
				break;
			}
			
			var transImage : TransitionImage  = new TransitionImage(w, h);
			
			transImage.render(_obj);
			
			var link : DisplayObject = GameApplication.instance.stage.addChild(transImage);
		 	
			if(_beforeStart != null){ _beforeStart(); }
			
			link.x = startX;
			link.y = startY;
			
			Tweener.addTween(link, { 
				x: endX,
				y: endY,
				time: 0.5, 
				transition: _ease,
				onComplete:function():void {
					if(_onComplite != null){ _onComplite(); }
					GameApplication.instance.stage.removeChild(link);
				}
			});
			
		}
		
		public function set direction(value:String):void {
			_direction = value;
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