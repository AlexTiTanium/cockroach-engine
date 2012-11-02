package game.levels.objects {
	import alternativa.engine3d.animation.AnimationClip;
	import alternativa.engine3d.animation.AnimationController;
	import alternativa.engine3d.core.Debug;
	import alternativa.engine3d.core.Object3D;
	import alternativa.engine3d.objects.Mesh;
	import flash.utils.Dictionary;
	import game.levels.Level;
	import flash.events.Event;
	import jiglib.physics.RigidBody;


	/**
	 * ...
	 * @author Alex
	 */
	public class LevelPhysModel {
		
		private var _object3D: Object3D;
		private var _params: Dictionary;
		private var _rigidBody : RigidBody;
		
		public function LevelPhysModel(object3D: Object3D, params: Dictionary) {
			_object3D = object3D;
			_params = params;
			
			if(!_params.type) { throw new Error('Phys type not found for: ' + _object3D.name); }
			
			switch(_params.type) {
			  case 'cube':
				_rigidBody = Level.physics.createCube(_object3D as Mesh);
				
			  break;
			  case 'sphere':
				_rigidBody = Level.physics.createSphere(_object3D as Mesh);
			  break;
			  default:
				throw new Error('Phys type '+_params.type+' not found for: ' + _object3D.name);
			  break;
			}
			
			_rigidBody.movable = params.movable;
			
		}
		
		public function get rigidBody():RigidBody { return _rigidBody; }
		
	}

}