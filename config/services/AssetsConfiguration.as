package dega.config.services {
	
	import br.com.stimuli.loading.BulkLoader;
	
	import dega.config.services.core.ServicesCore;
	
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.events.ProgressEvent;
	
	public class AssetsConfiguration extends ServicesCore {
		
		public static var ASSETS_DISABLE:String = "ASSETS DISABLE";
		private var bulkLoader:BulkLoader;
		public var percent:int;
		public var name:String = "Assets";
		
		public function AssetsConfiguration(remoteConfiguration:Boolean=false, configuration_url:String="", target:IEventDispatcher=null) {
			super(remoteConfiguration, configuration_url, target);
		}
		
		override public function onData ():void {
			
			bulkLoader = new BulkLoader ( "config", BulkLoader.DEFAULT_NUM_CONNECTIONS, BulkLoader.LOG_ERRORS );
			bulkLoader.start();
			bulkLoader.addEventListener(BulkLoader.COMPLETE, onAllLoaded);
			bulkLoader.addEventListener(BulkLoader.PROGRESS, onAllProgress);

			var tmp_length:int = super.loader.data.asset.length();
			for ( var i:int = 0; i < tmp_length; i++ ) {
				var s:String = super.loader.data.asset[i].@url;
				bulkLoader.add( s, { id:super.loader.data.asset[i].@id, type:super.loader.data.asset[i].@type, priority:super.loader.data.asset[i].@priority});
			}
		}
		
		private function onAllLoaded ( event:Event = null ):void {
			bulkLoader.removeEventListener(BulkLoader.COMPLETE, onAllLoaded );
			bulkLoader.removeEventListener(BulkLoader.PROGRESS, onAllProgress );
			this.dispatchEvent( new Event ( Event.COMPLETE ));
		}
		
		private function onAllProgress ( event:ProgressEvent = null ):void {
			this.percent = (event.bytesLoaded / event.bytesTotal ) * 100;
			this.dispatchEvent( new ProgressEvent ( ProgressEvent.PROGRESS ));
		}
		
		public static function getContent ( id:String ):* {
			return BulkLoader.getLoader("config").getContent( id );
		}
		
		public function getContent ( id:String ):* {
			return BulkLoader.getLoader("config").getContent( id );
		}
	}
}