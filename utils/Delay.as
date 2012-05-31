package dega.utils {
	import flash.events.TimerEvent;
	import flash.utils.Timer;

	public class Delay {
	
	
		public function Delay( ) { }
		
		public static function delayAndFunction ( functionToFire:Function, obj:Object = null, seconds:Number = 1 ):void {
			
			var timer:Timer = new Timer ( 1000 * seconds , 1 );
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, function fire ( event:TimerEvent = null ):void {  if ( obj != null ) functionToFire( obj.param ); else functionToFire( );  } ); 
			timer.start ();
			
		}
	}
}