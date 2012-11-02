package game.menu.wires {
	import classes.transition.animation.FadeAnimation;
	import com.soma.core.interfaces.IWire;
	import com.soma.core.wire.Wire;
	import com.soma.debugger.events.SomaDebuggerEvent;
	import game.menu.views.AboutView;
	import game.menu.views.IntroView;
	import game.menu.views.MainMenuView;
	import game.menu.views.SelectLevelView;
	import general.controllers.events.TweenerStageEvent;

	/**
     * ...
     * @author Alex
     */
    public class MenuWire extends Wire implements IWire{
        
        public static const NAME :String = 'MenuWire';

		public function MenuWire(name:String = null) {
            super(name);
			
        }
        
        override protected function initialize(): void {
			
			addView(IntroView.NAME, 		new IntroView());
			addView(MainMenuView.NAME, 		new MainMenuView());
			addView(SelectLevelView.NAME, 	new SelectLevelView());
			addView(AboutView.NAME,         new AboutView());
			
			
        }
        
        override protected function dispose(): void {

        }
	}	
}