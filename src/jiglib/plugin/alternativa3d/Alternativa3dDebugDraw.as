package jiglib.plugin.alternativa3d {
	import alternativa.engine3d.core.MouseEvent3D;
	import alternativa.engine3d.core.Object3D;
	import alternativa.engine3d.core.Sorting;
	import alternativa.engine3d.materials.FillMaterial;
	import alternativa.engine3d.objects.Mesh;
	import alternativa.engine3d.primitives.Box;
	import alternativa.engine3d.primitives.Sphere;
	import flash.events.Event;
	import flash.geom.Vector3D;
	import flash.utils.Dictionary;
	import game.levels.Level;
	import jiglib.geometry.JBox;
	import jiglib.geometry.JSphere;
	import jiglib.physics.RigidBody;
	/**
	 * ...
	 * @author D
	 */
	public class Alternativa3dDebugDraw{
		
		private var _debugRigidBodys: Dictionary = new Dictionary();
		private var _debugObjects: Dictionary = new Dictionary();
		private var _debugDraw: Dictionary = new Dictionary();
		
		public function Alternativa3dDebugDraw() {
			
		}
		
		public function addToDebug(name:String, rigidBody: RigidBody, object3d : Object3D ):void {
			_debugRigidBodys[name] = rigidBody;
			_debugObjects[name] = object3d;
			_debugDraw[name] = draw(name);
		}
		
		public function update():void{
			for (var name: String in _debugDraw) {
				draw(name);
			}
		}
		
		private function draw(name:String):Mesh {
			
			var rigidBody: RigidBody = _debugRigidBodys[name] as RigidBody;
			var object3d: Object3D   = _debugObjects[name] as Object3D;
			var material : FillMaterial = new FillMaterial(0xCCCCCC, 0.6);
			
			var mesh : Mesh;
			
			switch(rigidBody.type) {
				case 'BOX':
				    
				    var jbox : JBox = rigidBody as JBox;
					
					if (!_debugDraw[name]) {
						
						mesh = new Box(jbox.sideLengths.x, jbox.sideLengths.y, jbox.sideLengths.z);
						mesh.setMaterialToAllFaces(material);
						object3d.addEventListener(MouseEvent3D.CLICK, addForce);
						mesh.sorting = Sorting.NONE;
					}else {
						mesh = _debugDraw[name];
					}
					
					jbox.updateRotationValues();
					mesh.rotationX = rigidBody.rotationX * Math.PI / 180;
					mesh.rotationY = rigidBody.rotationY * Math.PI / 180;
					mesh.rotationZ = rigidBody.rotationZ * Math.PI / 180;
					
				break;
				case 'SPHERE':
					
					var jsphere : JSphere = rigidBody as JSphere;
					
					if (!_debugDraw[name]) {
						
						mesh = new Sphere(jsphere.radius);
						mesh.setMaterialToAllFaces(material);
						object3d.addEventListener(MouseEvent3D.CLICK, addForce);
						mesh.sorting = Sorting.NONE;
					}else {
						mesh = _debugDraw[name];
					}
			
					
				break;
				
			}
			
			mesh.x = rigidBody.x;
			mesh.y = rigidBody.y;
			mesh.z = rigidBody.z;
			
			Level.addToBSPContainer(mesh);
			
			return mesh;
		}
		
		private function addForce(e:Event):void {
			var mesh: Mesh = e.target as Mesh;
			
			var rigidBody: RigidBody = _debugRigidBodys[mesh.name] as RigidBody;
			
			if(rigidBody){
				rigidBody.addBodyForce(new Vector3D(0, 10, 500), new Vector3D(0, 0, 500));
			}
		}
	}

}