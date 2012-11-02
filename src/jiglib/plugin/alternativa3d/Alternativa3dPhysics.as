package jiglib.plugin.alternativa3d 
{
	import alternativa.engine3d.core.Debug;
	import alternativa.engine3d.core.Object3DContainer;
	import alternativa.engine3d.objects.Mesh;
	import alternativa.engine3d.primitives.Box;
	import flash.events.Event;
	import flash.geom.Vector3D;
	import game.levels.Level;
	import jiglib.geometry.JBox;
	import jiglib.geometry.JCapsule;
	import jiglib.geometry.JPlane;
	import jiglib.geometry.JSphere;
	import jiglib.physics.RigidBody;
	import jiglib.plugin.AbstractPhysics;

	public class Alternativa3dPhysics extends AbstractPhysics {
		
		private var _debug: Alternativa3dDebugDraw;
		private var _debugDraw: Boolean;
		
		private const ADDITIONAL_BODY_SIZE : Number = 0.5;
		
		public function Alternativa3dPhysics(speed:Number = 1, debugDraw: Boolean = false) {
			super(speed);
			_debugDraw = debugDraw;
			
			if (_debugDraw) {
				_debug = new Alternativa3dDebugDraw(); 
			}
			
			engine.setGravity(new Vector3D(0, 0, -20));
			GameApplication.stage.addEventListener(Event.ENTER_FRAME, _update);
		}
		
		public function getMesh(body:RigidBody):Mesh{
			if (body.skin != null)
			{
				return Alternativa3dMesh(body.skin).mesh;
			}
			else
			{
				return null;
			}
		}
		
		public function createSphere(mesh: Mesh):RigidBody {
			
			var width: int = Math.abs(mesh.boundMaxX-mesh.boundMinX)+ADDITIONAL_BODY_SIZE;
			
			var jsphere:JSphere = new JSphere(new Alternativa3dMesh(mesh), width/2);
			
			jsphere.moveTo(new Vector3D(mesh.x,  mesh.y, mesh.z));

			addBody(jsphere);
			
			if(_debugDraw){
				_debug.addToDebug(mesh.name, jsphere, mesh);
			}
			
			return jsphere;
		}
		
		public function createCube(mesh: Mesh):RigidBody {
			
			var width: int = Math.abs(mesh.boundMaxX-mesh.boundMinX)+ADDITIONAL_BODY_SIZE;
			var lenght: int = Math.abs(mesh.boundMaxZ-mesh.boundMinZ)+ADDITIONAL_BODY_SIZE;
			var height: int = Math.abs(mesh.boundMaxY-mesh.boundMinY)+ADDITIONAL_BODY_SIZE;
			
			var jbox:JBox = new JBox(new Alternativa3dMesh(mesh), width, lenght, height);
			jbox.moveTo(new Vector3D(mesh.x,  mesh.y, mesh.z));
			
			jbox.rotationX = mesh.rotationX * 180 / Math.PI;
			jbox.rotationY = mesh.rotationY * 180 / Math.PI;
			jbox.rotationZ = mesh.rotationZ * 180 / Math.PI;
			
			jbox.updateRotationValues();
		    jbox.updateObject3D();
			
			addBody(jbox);
			
			if(_debugDraw){
				_debug.addToDebug(mesh.name, jbox, mesh);
			}
			
			return jbox;
		}
		
		private function _update(e:Event):void {
			step();
			if (_debugDraw) { _debug.update(); }
		}
		
	}
}