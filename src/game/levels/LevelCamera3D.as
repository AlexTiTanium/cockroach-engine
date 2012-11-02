package game.levels {
	import alternativa.engine3d.controllers.SimpleObjectController;
	import alternativa.engine3d.core.Camera3D;
	import alternativa.engine3d.core.Debug;
	import alternativa.engine3d.core.Object3D;
	import alternativa.engine3d.core.View;
	import caurina.transitions.Tweener;
	import com.junkbyte.console.Cc;
	import flash.events.Event;
	import flash.utils.Dictionary;
	
	/**
	 * ...
	 * @author Alex
	 */
	public class LevelCamera3D extends Camera3D {
		
		private var controller: SimpleObjectController;
		
		public function LevelCamera3D(camera:Dictionary) {

			this.view = new View(GameApplication.SCREEN_WIDTH, GameApplication.SCREEN_HEIGHT);
			for (var i:String in camera.param) {
				this[i] = camera.param[i];
			}
			
			controller = new SimpleObjectController(GameApplication.instance.stage, this, 200);
			controller.lookAtXYZ(-62.51, 115.418, 91.62);
			controller.mouseSensitivity = 0.1;
		
			if(debug){
				addToDebug(Debug.EDGES, Object3D);
			}
			
			GameApplication.instance.stage.addEventListener(Event.ENTER_FRAME, update);
		}
		
		protected function update(e:Event):void {
			this.render();
			controller.update();
		}
		
		public function move():void {
			Cc.log('Moved');
			Tweener.addTween(this, {x: 10, time: 10});
		}
		
	}

}