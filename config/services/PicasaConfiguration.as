package dega.config.services {
	
	import dega.config.services.core.ServicesCore;
	
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	
	public class PicasaConfiguration extends ServicesCore {

		public static var PICASA_DISABLE:String = "PICASA DISABLE";
		
		public static var userName:String;
		public static var maxResponses:int;
		public var name:String = "Picasa";

		public function PicasaConfiguration(remoteConfiguration:Boolean=false, configuration_url:String="", target:IEventDispatcher=null) {
			super(remoteConfiguration, configuration_url, target);
		}
		
		override public function onData ():void {
			userName = super.loader.data.picasa.@userName;
			maxResponses = super.loader.data.picasa.@maxResponses;
			trace( userName + " >> " + maxResponses );
			this.dispatchEvent( new Event ( Event.COMPLETE ));
		}
	}
}