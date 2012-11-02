package general.controllers.commands {
	import com.soma.core.controller.Command;
	import com.soma.core.interfaces.ICommand;
  import flash.events.Event;
  import general.controllers.events.InitializeEvent;
  import general.wires.InitializeWire;
	
	/**
     * ...
     * @author Alex
     */
    public class InitializeCommand extends Command implements ICommand{
        
        public function InitializeCommand() {}
        
        /* INTERFACE com.soma.core.interfaces.ICommand */
        
        public function execute(event:Event):void{
            var wire: InitializeWire = getWire(InitializeWire.NAME) as InitializeWire;
            switch (event.type) {
                case InitializeEvent.START:  wire.start();  break;
            }
        }
        
    }

}