package game.levels.console {
	import caurina.transitions.Tweener;
	import classes.transition.animation.FadeAnimation;
	import com.junkbyte.console.Cc;
	import flash.events.MouseEvent;
	import flash.utils.Dictionary;
	import game.levels.Level;
	import general.controllers.events.StageEvent;
	import general.controllers.events.TweenerStageEvent;
	import general.views.LoadingView;
	import general.views.ScriptBoxView;
	import luaAlchemy.LuaAlchemy;

	public class LuaScript {
		
		private var _interpritator:LuaAlchemy;
		
		public function LuaScript(interpritator:LuaAlchemy) {
			_interpritator = interpritator;
			
			//Cc.addSlashCommand('luaRunScript', luaRunScript);
			Cc.addSlashCommand('luaNewScript', luaNewScript);
			
		}
		
		public function luaNewScript():void {
			Cc.log('Creating new lua script');
			
			var box:ScriptBoxView = new ScriptBoxView();
			
			GameApplication.addView(box.boxName, box);
			
			GameApplication.dispatchEvent(new StageEvent(
				StageEvent.ADD, 
				box.boxName
			));

		}	
		
		public function runStringScript(string: String):void {
			Cc.log('Run string script');
			var result : Array = _interpritator.doString(string);
			if(result[0]) {
				Cc.log('Lua scrip was executed successful');
			}else {
				Cc.log('Runtime lua script error: ' + result[1]); 
			}
		}
		
		public function get interpritator():LuaAlchemy { return _interpritator; }
	}
}