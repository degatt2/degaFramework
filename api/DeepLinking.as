package dega.api {
	
	import dega.api.deepLinking.SWFAddress;
	import dega.api.deepLinking.SWFAddressEvent;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import nl.demonsters.debugger.MonsterDebugger;
	
	public class DeepLinking extends EventDispatcher {

		public var current_url:String;
		
		public function DeepLinking() {
			SWFAddress.addEventListener( SWFAddressEvent.CHANGE, swfAdressChange );		
		}
		
		public function swfAdressChange ( event:SWFAddressEvent = null ):void {
			
			if ( event.value != "/" ) SWFAddress.setTitle( "Selected Works of Daniel González - " + event.value.substring(1));
			else SWFAddress.setTitle( "Selected Works of Daniel González" );

			current_url = event.value;
			this.dispatchEvent ( new Event ( Event.CHANGE ));
		}
		
		public function setURL( title:String = "" ):void {						// < -- Coloca el titulo y la direccion url en el navegador
			current_url = title;
			SWFAddress.setValue( current_url );
		}
		
	}
}