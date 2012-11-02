package general.controllers.commands {
	import com.soma.core.controller.Command;
	import com.soma.core.interfaces.ICommand;
  import com.soma.core.interfaces.IWire;
  import flash.display.Stage;
  import flash.events.Event;
  import general.controllers.events.InitializeEvent;
  import general.controllers.events.LevelManagerEvent;
  import general.controllers.events.StageEvent;
  import general.wires.InitializeWire;
  import general.wires.LevelManagerWire;
  import general.wires.StageWire;
	
	/**
     * ...
     * @author Alex
     */
    public class LevelManagerCommand extends Command implements ICommand{
        
        public function LevelManagerCommand() {}
        
        /* INTERFACE com.soma.core.interfaces.ICommand */
        
        public function execute(event:Event):void{
            var wire: LevelManagerWire = getWire(LevelManagerWire.NAME) as LevelManagerWire;
			var level:String = LevelManagerEvent(event).level;
			
            switch (event.type) {
                case LevelManagerEvent.LOAD:   wire.load(level);  break;
            }
        }
        
    }

}