package dega.config.services.core {
	
	import dega.xml.LoadXML;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	public class ServicesCore extends EventDispatcher {

		public var loader:LoadXML;
		
		public function ServicesCore( remoteConfiguration:Boolean = false, configuration_url:String = "", target:IEventDispatcher = null ) {
			if ( remoteConfiguration ) {
				loader = new LoadXML (configuration_url);
				loader.load();
				loader.addEventListener(Event.COMPLETE, dataLoaded );
			} 
			else trace("remote node is false in the XML, default values not yet assigment".toUpperCase());
			super( target );
		}
		
		private function dataLoaded ( event:Event = null ):void {
			onData ();
		}
		
		public function onData ():void { }
	}
}