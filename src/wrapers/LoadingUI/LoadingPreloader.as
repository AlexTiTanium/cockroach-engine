package wrapers.LoadingUI {
	import caurina.transitions.Tweener;
	import fl.controls.ProgressBar;
	import fl.controls.ProgressBarDirection;
	import fl.controls.ProgressBarMode;
	import flash.display.MovieClip;
	import flash.events.ProgressEvent;

	import flash.display.Sprite;
	import flash.text.AntiAliasType;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;		

	/**
	 * <b>Author:</b> Romuald Quantin - <a href="http://www.soundstep.com/" target="_blank">www.soundstep.com</a><br />
	 * <b>Class version:</b> 1.0<br />
	 * <b>Actionscript version:</b> 3.0<br />
	 * <b>Copyright:</b> 
	 * <br />
	 * <b>Date:</b> 20 Feb 2009<br />
	 * <b>Usage:</b>
	 * @example
	 * <listing version="3.0"></listing>
	 */
	
	public class LoadingPreloader extends Sprite {

		//------------------------------------
		// private, protected properties
		//------------------------------------
		
		//------------------------------------
		// public properties
		//------------------------------------
		
		private var _preloader:MovieClip;
		private var _process:ProgressBar;
		private var _progressMaximum:Number = 100;
		private var _progressMinimum:Number = 0;
		
		//------------------------------------
		// constructor
		//------------------------------------
		
		public function LoadingPreloader() {
			_preloader = new PreloaderMovie();
			_process = _preloader['instProgressBar'] as ProgressBar;
			_process.maximum = _progressMaximum;
			addChild(_preloader);
		}
		
		public function queueProgress(e:ProgressEvent):void {
			var percentQueue: uint = (100 * e.bytesLoaded) / e.bytesTotal;
			_process.setProgress(percentQueue , _progressMaximum);
		}
		
		public function queueComplete():void {

		}
		
		public function error():void {
			trace('Loading error... sory ');
		}
		
	}
	
}
