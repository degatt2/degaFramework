package dega.config.services {
	
	import dega.config.services.core.ServicesCore;
	import dega.xml.LoadXML;
	import dega.xml.LoadXMLBulk;
	
	import flash.events.Event;
	
	public class LanguagesConfiguration extends ServicesCore {
		
		public static var LANGUAGES_DISABLE:String = "LANGUAGES DISABLE";
		private var xmlBulk:LoadXMLBulk;
		private var ids:Vector.<String>;
		public var name:String = "Languages";
		
		public function LanguagesConfiguration( remoteConfiguration:Boolean = false, configuration_url:String = "" ) {
			super( remoteConfiguration, configuration_url, null );
		}
		
		override public function onData ():void {
			
			xmlBulk = new LoadXMLBulk();
			ids = new Vector.<String>();
			var tmp_length:int = super.loader.data.language.length();
			
			for ( var i:int = 0; i < tmp_length; i++ ) {
				xmlBulk.add( super.loader.data.language[i].@url );
				ids[i] = super.loader.data.language[i].@id ;
			}
			xmlBulk.addEventListener(Event.COMPLETE, onBulkLoaded );
			xmlBulk.load();
			
		}
		
		public function getXMLByLanguageId ( id:String ):XML {
			var tmp_index:int = ids.indexOf( id );
			return  xmlBulk.getXMLByIndex( tmp_index );
		}
		
		private function onBulkLoaded ( event:Event = null ):void {
			this.dispatchEvent( new Event ( Event.COMPLETE ));
		}
	}
}