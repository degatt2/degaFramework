package dega.config.services {
	
	import dega.config.services.core.ServicesCore;
	import dega.xml.LoadXML;
	
	import flash.events.Event;
	
	public class AnalyticsConfiguration extends ServicesCore {
		
		public static var ANALYTICS_DISABLE:String = "ANALYTICS DISABLE";
		
		public var debugMode:Boolean;
		public var analyticsKey:String;
		public var name:String = "Analytics";
		
		public function AnalyticsConfiguration( remoteConfiguration:Boolean = false, configuration_url:String = "" ){ 
			super( remoteConfiguration, configuration_url, null );
		}
		
		override public function onData ():void {
			debugMode = super.loader.data.googleAnalytics.@debugMode;
			analyticsKey = super.loader.data.googleAnalytics.@key;
			trace ( "ANALYTICS DEBUG MODE >> " + debugMode + " : ANALYTICS KEY >> " + analyticsKey );
			this.dispatchEvent( new Event ( Event.COMPLETE ));
		}
		
	}
}