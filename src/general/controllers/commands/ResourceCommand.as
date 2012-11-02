package general.controllers.commands {
	import classes.resourceManager.Resource;
	import com.soma.core.controller.Command;
	import com.soma.core.interfaces.ICommand;
  import flash.display.Stage;
  import flash.events.Event;
  import general.controllers.events.InitializeEvent;
  import general.controllers.events.ResManagerEvent;
  import general.controllers.events.ResManagerQueueEvent;
  import general.controllers.events.StageEvent;
  import general.wires.InitializeWire;
  import general.wires.ResourceWire;
  import general.wires.StageWire;
	
	/**
     * ...
     * @author Alex
     */
    public class ResourceCommand extends Command implements ICommand{
        
        public function ResourceCommand() {}
        
        /* INTERFACE com.soma.core.interfaces.ICommand */
        
        public function execute(event:Event):void{
            var wire: ResourceWire = getWire(ResourceWire.NAME) as ResourceWire;
			
            switch (event.type) {
                case ResManagerEvent.LOAD:       wire.load(ResManagerEvent(event).file, ResManagerEvent(event).onComplite);  	  break;
				case ResManagerEvent.UNLOAD:     wire.unload(ResManagerEvent(event).file);                 					      break;
				case ResManagerEvent.FORCE_LOAD: wire.load(ResManagerEvent(event).file, ResManagerEvent(event).onComplite, true); break;
				
				//case ResManagerQueueEvent.LOAD:       wire.loadQueue(ResManagerQueueEvent(event).file, ResManagerQueueEvent(event).onComplite);       break;
				//case ResManagerQueueEvent.UNLOAD:     wire.unloadQueue(ResManagerQueueEvent(event).file);                 					          break;
				//case ResManagerQueueEvent.FORCE_LOAD: wire.loadQueue(ResManagerQueueEvent(event).file, ResManagerQueueEvent(event).onComplite, true); break;
            }
        }
        
    }

}