package general.views {
	import classes.transition.animation.FadeAnimation;
	import classes.View;
	import com.junkbyte.console.Cc;
	import com.soma.debugger.views.SomaDebuggerScrollbar;
	import fl.controls.TextArea;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import general.controllers.events.LuaLevelEvent;
	import general.controllers.events.StageEvent;
	import general.controllers.events.TweenerStageEvent;
	
	/**
	 * ...
	 * @author Alex
	 */
	public class ScriptBoxView extends View {
		
		private static var COUNT:uint = 0;
		private static var NAME:String = 'ScriptBoxView:';
		
		public var boxName:String;
		
		protected var _background:Sprite;
		protected var _title:String;
		protected var _debuggerTitleBarName:TextField;
		protected var _textfield:TextArea;
		protected var _close:Sprite;
		private var _run:Sprite;
		private var _resizer:Sprite;
		protected var _hit:Sprite;
		
		protected var _isDragging:Boolean;
		protected var _hasBeenDragged:Boolean;
		
		protected var _isResizing:Boolean;
		protected var _resizingPrev:Point;
		
		protected var _widthWindow:Number;
		protected var _heightWindow:Number;
		
		public function ScriptBoxView() {
			COUNT += 1;
			boxName = NAME + COUNT;
			_title = 'New lua script ('+COUNT+')';
			_widthWindow = 300;
			_heightWindow = 200;
			initialize();
		}
		
		protected function initialize():void {
			scrollRect = new Rectangle(0, 0, _widthWindow, _heightWindow);
			_isDragging = false;
			_hasBeenDragged = false;
			createBackground();
			createTitle();
			createButtons();
			createRunButtons();
			createResizerButtons();
			createHitArea();
			createTextField();
			
			x = GameApplication.stage.width - width;
			y = GameApplication.stage.height - scrollRect.height;
			
			addEventListener(MouseEvent.CLICK, sortWindow);
			addEventListener(KeyboardEvent.KEY_DOWN, eventsHandler, true);
			addEventListener(KeyboardEvent.KEY_UP, eventsHandler, true);
			addEventListener(MouseEvent.MOUSE_DOWN, eventsHandler, true);
			_run.addEventListener(MouseEvent.CLICK, runEventsHandler);
		}
		
		protected function runEventsHandler(e:MouseEvent):void {
			dispatchEvent(new LuaLevelEvent(
				LuaLevelEvent.RUN,
				textfield.text
			));
		}

		protected function eventsHandler(e:Event):void {
 		    if(e.target != _hit && e.target != _resizer) {
				e.stopPropagation();
			}
		}

		private function createBackground():void {
			_background = new Sprite();
			_background.graphics.beginFill(0xCCCCCC);
			_background.graphics.drawRect(0, 0, _widthWindow, _heightWindow);
			addChild(_background);
		}

		private function createTitle():void {
			var tfTitle:TextFormat = new TextFormat("_typewriter", 12);
			tfTitle.letterSpacing = -0.5;
			_debuggerTitleBarName = new TextField();
			_debuggerTitleBarName.selectable = false;
			_debuggerTitleBarName.defaultTextFormat = tfTitle;
			_debuggerTitleBarName.autoSize = TextFieldAutoSize.LEFT;
			_debuggerTitleBarName.text = _title;
			_debuggerTitleBarName.x = 1;
			_debuggerTitleBarName.y = -3;
			addChild(_debuggerTitleBarName);
		}

		private function createButtons():void {
			// close
			_close = new Sprite();
			_close.buttonMode = true;
			_close.mouseChildren = false;
			_close.addEventListener(MouseEvent.CLICK, closeHandler);
			var tf:TextFormat = new TextFormat("_typewriter", 12);
			var closeLabel:TextField = new TextField();
			closeLabel.defaultTextFormat = tf;
			closeLabel.autoSize = TextFieldAutoSize.LEFT;
			closeLabel.text = "X";
			_close.addChild(closeLabel);
			_close.x = _widthWindow - _close.width - 1;
			_close.y = -3;
			addChild(_close);
		}
		
		private function createRunButtons():void {
			// run
			_run = new Sprite();
			_run.buttonMode = true;
			_run.mouseChildren = false;
			var tf:TextFormat = new TextFormat("_typewriter", 12);
			var runLabel:TextField = new TextField();
			runLabel.defaultTextFormat = tf;
			runLabel.autoSize = TextFieldAutoSize.LEFT;
			runLabel.text = " Execute ";
			_run.addChild(runLabel);
			_run.x = 3;
			_run.y = _heightWindow - _run.height - 3;
			addChild(_run);
		}
			
		private function createResizerButtons():void{
			// resizer			
			_resizer = new Sprite();
			_resizer.buttonMode = true;
			_resizer.mouseChildren = false;
			
			_resizer.x = _widthWindow - _resizer.height;
			_resizer.y = _heightWindow - _resizer.height;
			_resizer.graphics.beginFill(0xFF0000);
			_resizer.graphics.drawRect(0, 0, 10, 10);
	        _resizer.graphics.moveTo(0, 0);
	        _resizer.graphics.lineTo(-10, 0);
	        _resizer.graphics.lineTo(0, -10);
	        _resizer.graphics.endFill();
			
			_resizer.addEventListener(MouseEvent.MOUSE_DOWN, resizerHandler);
			_resizer.addEventListener(MouseEvent.MOUSE_UP, resizerHandler);
			addChild(_resizer);
		}
		
		private function resizerHandler(e:MouseEvent):void {
			switch (e.type) {
				case MouseEvent.MOUSE_MOVE:
					
					if (!e.buttonDown) {
						GameApplication.stage.removeEventListener(MouseEvent.MOUSE_MOVE, resizerHandler); 
						_isResizing = false; 
						return;
					}
					
				    scrollRect.width += _resizer.mouseX - _resizingPrev.x;
					scrollRect.height += _resizer.mouseY - _resizingPrev.y;
					_resizingPrev = new Point(_resizer.mouseX, _resizer.mouseY);
					e.updateAfterEvent();
				break;
				case MouseEvent.MOUSE_DOWN:
					_resizingPrev = new Point(_resizer.mouseX, _resizer.mouseY);
					GameApplication.stage.addEventListener(MouseEvent.MOUSE_MOVE, resizerHandler);
					sortWindow();
					_isResizing = true;
				break;
				case MouseEvent.MOUSE_UP:
					GameApplication.stage.removeEventListener(MouseEvent.MOUSE_MOVE, resizerHandler);
					if (_isResizing) {
						_isResizing = false;
					}
				break;
			}
			e.stopPropagation();
		}
		
		private function createHitArea():void {
			_hit = new Sprite();
			_hit.graphics.beginFill(0xFF0000, 0);
			_hit.graphics.drawRect(0, 0, _widthWindow-(_widthWindow-_close.x), 15);
			_hit.addEventListener(MouseEvent.MOUSE_DOWN, mouseHandler);
			_hit.addEventListener(MouseEvent.MOUSE_UP, mouseHandler);
			_hit.buttonMode = true;
			_hit.mouseChildren = false;
			addChild(_hit);
		}

		private function createTextField():void {
			_textfield = new TextArea();
			_textfield.x = 4;
			_textfield.y = 15;
			_textfield.width = _widthWindow - 8;
			_textfield.height = _heightWindow - 18 - _run.height;
			addChild(_textfield);
		}

		private function mouseHandler(e:MouseEvent):void {
			switch (e.type) {
				case MouseEvent.MOUSE_MOVE:
					_isDragging = true;
					_hasBeenDragged = true;
				break;
				case MouseEvent.MOUSE_DOWN:
					addEventListener(MouseEvent.MOUSE_MOVE, mouseHandler);
					sortWindow();
					_isDragging = false;
					startDrag();
				break;
				case MouseEvent.MOUSE_UP:
					removeEventListener(MouseEvent.MOUSE_MOVE, mouseHandler);
					if (_isDragging) {
						_isDragging = false;
					}
					else {	
						if(scrollRect.height == _heightWindow) { GameApplication.stage.focus = null; } 
						var heightTarget:Number = (scrollRect.height == _heightWindow) ? 15 : _heightWindow;
						scrollRect = new Rectangle(0, 0, _widthWindow, heightTarget);
					}
					stopDrag();
				break;
			}
			e.stopPropagation();
		}
		
		private function closeHandler(event:MouseEvent):void {
			close();
		}
		
		private function sortWindow(e:MouseEvent = null):void {
			if (parent != null) {
				parent.setChildIndex(this, parent.numChildren-1);
			}
		}
		
		public function dispose():void {
			try {
				_hit.removeEventListener(MouseEvent.MOUSE_DOWN, mouseHandler);
				_hit.removeEventListener(MouseEvent.MOUSE_UP, mouseHandler);
				
				removeEventListener(MouseEvent.CLICK, sortWindow);
				removeEventListener(KeyboardEvent.KEY_DOWN, eventsHandler, true);
				removeEventListener(KeyboardEvent.KEY_UP, eventsHandler, true);
				removeEventListener(MouseEvent.MOUSE_DOWN, eventsHandler, true);
	
				_close.removeEventListener(MouseEvent.CLICK, closeHandler);
				while (numChildren > 0) removeChildAt(0);
				_debuggerTitleBarName = null;
				_background = null;
				_close = null;
				_textfield = null;
			} catch(e:Error) {
				trace("Error in", this, "(dispose method):", e.message);
			}
		}
		
		public function close():void {
			dispatchEvent(new StageEvent(
				StageEvent.REMOVE, 
				boxName
			));
		}
		
		public function get runBtn():Sprite { return _run; }
		
		public function get textfield():TextArea { return _textfield; }
	}
}