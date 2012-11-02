package game.levels.objects {
	import alternativa.engine3d.animation.AnimationClip;
	import alternativa.engine3d.animation.AnimationController;
	import alternativa.engine3d.core.Debug;
	import alternativa.engine3d.core.Object3D;
	import alternativa.engine3d.core.Vertex;
	import alternativa.engine3d.objects.Mesh;
	import flash.utils.Dictionary;
	import game.levels.Level;
	import flash.events.Event;


	/**
	 * ...
	 * @author Alex
	 */
	public class LevelModel3D {
		
		private var _object: Object3D;
		private var _name: String;
		private var _animation: Model3DAnimation = null;
		private var _phys: LevelPhysModel;
		
		public function LevelModel3D(model: Dictionary) {
			
			_name = model.name;
			
			_object = Level.colladaResources.getObject(model.source, _name);
			
			if (!_object) { throw new Error('Model not found: '+ _name + ' in source: ' + model.source); }
			
			if (_object is Mesh) {
				(_object as Mesh).weldVertices();
				(_object as Mesh).weldFaces();

			}
		
			if(model.phys) {
				_phys = new LevelPhysModel(_object, model.phys);
			}
			
			var animationClip : AnimationClip = Level.colladaResources.getAnimation(model.source, _object);
			if (animationClip) {
				_animation = new Model3DAnimation(animationClip);	
			}
			
			if(Level.camera.debug){
				Level.camera.addToDebug(Debug.EDGES, _object);
			}
		}
		
		public function get object():Object3D { return _object; }
		public function get name():String { return _name; }
		public function get animation():Model3DAnimation { return _animation; }
		
	}

}