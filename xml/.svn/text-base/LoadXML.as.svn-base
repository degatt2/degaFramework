package dega.xml {
	import flash.events.*;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	public class LoadXML extends EventDispatcher{
		
		
		private var loader:URLLoader;
		private var loaderProgress:Number; 
		private var xml:XML;
		public var url_request:URLRequest;
		
		public function LoadXML( url:String ) {
		
			loader = new URLLoader( );
			loader.addEventListener(Event.COMPLETE, completeHandler);
			loader.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
			loader.addEventListener(ProgressEvent.PROGRESS, progressHandler);
			url_request = new URLRequest(url);
			
		}
		
		public function load ():void {
			loader.load( url_request );
		}
		
		private function completeHandler(event:Event):void {
			xml = new XML();
			xml.ignoreWhitespace = true;
			xml = XML( loader.data );
			dispatchEvent ( new Event ( Event.COMPLETE ) );	
		}
		
		
		public function get data ():XML {
			return xml;
		}

		public function get progress ():Number {
			return loaderProgress;
		}

		private function progressHandler(event:ProgressEvent):void { 
			loaderProgress = event.bytesLoaded / event.bytesTotal;
			dispatchEvent( new Event( ProgressEvent.PROGRESS ));	
		}
		
		private function ioErrorHandler(event:IOErrorEvent):void {	
			trace("el xml no se pudo cargar!! >> " + url_request.url + "  >> " + event);
		}

	}
}