package general.controllers.commands {
	import com.soma.core.controller.Command;
	import com.soma.core.interfaces.ICommand;
  import flash.events.Event;
  import general.controllers.events.LuaLevelEvent;
  import general.wires.LevelManagerWire;

	
	/**
     * ...
     * @author Alex
     */
    public class LuaLevelCommand extends Command implements ICommand{
        
        public function LuaLevelCommand() {}
        
        /* INTERFACE com.soma.core.interfaces.ICommand */
        
        public function execute(event:Event):void{
            var wire: LevelManagerWire = getWire(LevelManagerWire.NAME) as LevelManagerWire;
			var script:String = LuaLevelEvent(event).script;

            switch (event.type) {
                case LuaLevelEvent.RUN:    
					wire.runLuaScript(script);       			
				break;
            }
        }
        
    }

}