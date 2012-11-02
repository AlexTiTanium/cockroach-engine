package general.controllers.commands {
	import com.soma.core.controller.Command;
	import com.soma.core.interfaces.ICommand;
  import flash.display.Stage;
  import flash.events.Event;
  import general.controllers.events.InitializeEvent;
  import general.controllers.events.StageEvent;
  import general.controllers.events.TweenerStageEvent;
  import general.wires.InitializeWire;
  import general.wires.StageWire;
  import general.wires.TweenerStageWire;
	
	/**
     * ...
     * @author Alex
     */
    public class TweenerStageCommand extends Command implements ICommand{
        
        public function TweenerStageCommand() {}
        
        /* INTERFACE com.soma.core.interfaces.ICommand */
        
        public function execute(event:Event):void{
            var wire: TweenerStageWire = getWire(TweenerStageWire.NAME) as TweenerStageWire;
			var viewName:String = TweenerStageEvent(event).viewName;
			var tweenerInEffect:String = TweenerStageEvent(event).tweenerInEffect;
			var tweenerOutEffect:String = TweenerStageEvent(event).tweenerOutEffect;
			
            switch (event.type) {
                case TweenerStageEvent.ADD:    wire.addToStage(viewName,tweenerInEffect);       			break;
				case TweenerStageEvent.SET:    wire.setToStage(viewName,tweenerInEffect,tweenerOutEffect);  break;
				case TweenerStageEvent.REMOVE: wire.removeFromStage(viewName,tweenerOutEffect);  							break;
				case TweenerStageEvent.CLEAR:  wire.cleareStage(tweenerOutEffect);              							break;
            }
        }
        
    }

}