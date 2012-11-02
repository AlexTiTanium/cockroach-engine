package general.controllers.commands {
	import com.soma.core.controller.Command;
	import com.soma.core.interfaces.ICommand;
  import flash.display.Stage;
  import flash.events.Event;
  import general.controllers.events.InitializeEvent;
  import general.controllers.events.StageEvent;
  import general.wires.InitializeWire;
  import general.wires.StageWire;
	
	/**
     * ...
     * @author Alex
     */
    public class StageCommand extends Command implements ICommand{
        
        public function StageCommand() {}
        
        /* INTERFACE com.soma.core.interfaces.ICommand */
        
        public function execute(event:Event):void{
            var wire: StageWire = getWire(StageWire.NAME) as StageWire;
			var viewName:String = StageEvent(event).viewName;
			
            switch (event.type) {
                case StageEvent.ADD:    wire.addToStage(viewName);       break;
				case StageEvent.SET:    wire.setToStage(viewName);       break;
				case StageEvent.REMOVE: wire.removeFromStage(viewName);  break;
				case StageEvent.CLEAR:  wire.cleareStage();              break;
				
            }
        }
        
    }

}