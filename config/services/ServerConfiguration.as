package dega.config.services {
	
	import dega.config.services.core.ServicesCore;
	import flash.events.Event;
	import dega.xml.LoadXML;
	
	public class ServerConfiguration extends ServicesCore {
		
		public static var SERVER_DISABLE:String = "SERVER DISABLE";
		
		public var zendServer:String; 
		public var jpegServer:String; 
		public var name:String = "Server";
		
		public function ServerConfiguration( remoteConfiguration:Boolean = false, configuration_url:String = "" ) { 
			super( remoteConfiguration, configuration_url, null );
		}
		
		override public function onData ():void {
			zendServer = super.loader.data.zend.@url;
			jpegServer = super.loader.data.jpeg.@url;
			trace ( "ZEND SERVER >> " + zendServer + " : JPEG SERVER >> " + jpegServer );
			this.dispatchEvent( new Event ( Event.COMPLETE ));
		}
		
	}
}