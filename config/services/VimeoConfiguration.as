package dega.config.services {
	
	import dega.config.services.core.ServicesCore;
	
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	
	public class VimeoConfiguration extends ServicesCore {
		
		public static var VIMEO_DISABLE:String = "VIMEO DISABLE";
		
		public var authorization_key:String;
		public var videoWidth:int;
		public var videoHeigth:int;
		public var name:String = "Vimeo";
		
		public function VimeoConfiguration(remoteConfiguration:Boolean=false, configuration_url:String="", target:IEventDispatcher=null) {
			super(remoteConfiguration, configuration_url, target);
		}
		
		override public function onData ():void {
			authorization_key = super.loader.data.vimeo.@key;
			videoWidth = super.loader.data.vimeo.@width;
			videoHeigth = super.loader.data.vimeo.@height;
			trace( authorization_key + " >> " + videoWidth + " >> " + videoHeigth );
			this.dispatchEvent( new Event ( Event.COMPLETE ));
		}
	}
}