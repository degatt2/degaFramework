package dega.config {
	
	import adobe.utils.XMLUI;
	
	import dega.config.services.AnalyticsConfiguration;
	import dega.config.services.AssetsConfiguration;
	import dega.config.services.LanguagesConfiguration;
	import dega.config.services.PicasaConfiguration;
	import dega.config.services.ServerConfiguration;
	import dega.config.services.VimeoConfiguration;
	import dega.xml.LoadXML;
	import dega.xml.LoadXMLBulk;
	import dega.xml.XMLUtil;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.ProgressEvent;
	
	import nl.demonsters.debugger.MonsterDebugger;
	
	public class Config extends EventDispatcher {
	
		public static var server:ServerConfiguration;
		public static var analytics:AnalyticsConfiguration;
		public static var languages:LanguagesConfiguration;
		public static var vimeo:VimeoConfiguration;
		public static var picasa:PicasaConfiguration;
		public static var assets:AssetsConfiguration;
		
		private var configFile:String = "assets/xml/config.xml";
		private var loader:LoadXML;
		private var loadBulk:LoadXMLBulk;
		private var xml:XML;
		private var count:int = 0;
		private var loadedCount:int = 0;
		
		public function Config( target:IEventDispatcher = null ) {
			super( target );
			loader = new LoadXML(configFile);
			loader.addEventListener(Event.COMPLETE, onCompleteData );
			loader.load();
		}
		
		private function onCompleteData ( event:Event = null ):void {
			
			xml = loader.data;
			
			if ( XMLUtil.hasNode( xml, "analytics")) {
				if ( xml.analytics.@remote == "true"){
					count++;
					analytics = new AnalyticsConfiguration( xml.analytics.@remote == 'true'? true : false, xml.analytics.@url ); 
					analytics.addEventListener(Event.COMPLETE, onCompleteConfiguration );
				} else trace ( AnalyticsConfiguration.ANALYTICS_DISABLE );
			}
			
			if ( XMLUtil.hasNode(xml, "server")) {
				if ( xml.server.@init == "true"){
					count++;
					server = new ServerConfiguration( xml.server.@remote == 'true'? true : false, xml.server.@url ); 
					server.addEventListener(Event.COMPLETE, onCompleteConfiguration );
				} else trace ( ServerConfiguration.SERVER_DISABLE );
			}
			
			if ( XMLUtil.hasNode(xml, "languages")) {
				if ( xml.languages.@init == "true"){
					count++;
					languages = new LanguagesConfiguration( xml.languages.@remote == 'true'? true : false, xml.languages.@url ); 
					languages.addEventListener(Event.COMPLETE, onCompleteConfiguration );
				} else trace ( LanguagesConfiguration.LANGUAGES_DISABLE );
			}
			
			if ( XMLUtil.hasNode(xml, "vimeo")) {
				if ( xml.vimeo.@init == "true"){
					count++;
					vimeo = new VimeoConfiguration( xml.vimeo.@remote == 'true'? true : false, xml.vimeo.@url ); 
					vimeo.addEventListener(Event.COMPLETE, onCompleteConfiguration );
				} else trace ( VimeoConfiguration.VIMEO_DISABLE );
			}
			
			if ( XMLUtil.hasNode(xml, "picasa")) {
				if ( xml.picasa.@init == "true"){
					count++;
					picasa = new PicasaConfiguration( xml.picasa.@remote == 'true'? true : false, xml.picasa.@url ); 
					picasa.addEventListener(Event.COMPLETE, onCompleteConfiguration );
				} else trace ( PicasaConfiguration.PICASA_DISABLE );
			}
			
			if ( XMLUtil.hasNode(xml, "assets")) {
				if ( xml.assets.@init == "true"){
					count++;
					assets = new AssetsConfiguration( xml.assets.@remote == 'true'? true : false, xml.assets.@url ); 
					assets.addEventListener(Event.COMPLETE, onCompleteConfiguration );
					assets.addEventListener(ProgressEvent.PROGRESS, onProgressData );
				} else trace ( AssetsConfiguration.ASSETS_DISABLE );
			}
			
		}
		
		private function onProgressData ( event:ProgressEvent = null ):void {
			trace("progress event fire:: " + event.target.name );
		}
		
		private function onCompleteConfiguration ( event:Event = null ):void {
			loadedCount++;
			trace("configuration complete:: "  + event.target.name );
			if ( count == loadedCount ) this.dispatchEvent( new Event ( Event.COMPLETE ));
		}
		
	}
}