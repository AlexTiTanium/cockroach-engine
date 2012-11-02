package classes.transition {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	
	/**
	 * @author Division
	 */
	public class TransitionImage extends Bitmap {
		
		private var _bd : BitmapData;
		
		private var _imageWidth : int;
		private var _imageHeight : int;
		
		public function TransitionImage(w : int, h : int) {
			super();
			setParams(w, h, true);			
		}
		
		public function setParams(w : int, h : int, transparent : Boolean) : void {
			if (_bd) {
				_bd.dispose();
			}
			_imageWidth = w;
			_imageHeight = h;
			_bd = null;
			if (w > 0 && h > 0) {
				_bd = new BitmapData(w, h, transparent, 0);
			}
			this.bitmapData = _bd;
		}
		
		public function render(obj : DisplayObject) : void {
			if (!obj) {
				clear();
				return;
			}
			var m : Matrix = obj.transform.matrix;
			_bd.draw(obj, m);
		}
		
		public function clear() : void {
			_bd.fillRect(new Rectangle(0, 0, _imageWidth, _imageHeight), 0x00FFFFFF);
		}
		
		public function get imageWidth():int { return _imageWidth; }
		
		public function get imageHeight():int { return _imageHeight; }
		
	}

}