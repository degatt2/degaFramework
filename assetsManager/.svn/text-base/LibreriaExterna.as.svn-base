package dega.assetsManager {
	
	import flash.display.Loader;
	import flash.events.*;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	
	public class LibreriaExterna extends EventDispatcher {
		
		
		public static const LIBRARY_COMPLETE:String = "LibreryComplete";
		public static const LIBRARY_PROGRESS:String = "LibreryProgress";
		
		private static var _instancia : LibreriaExterna;
		private static var appDomain : ApplicationDomain;
		private var loader:Loader;
		public var loaderProgress:Number;
	
	
		public function LibreriaExterna (p:Privada) : void {}
		
		
		public static function instancia () : LibreriaExterna {
			if ( _instancia == null ) _instancia = new LibreriaExterna ( new Privada );
			return _instancia;
		}
	
		
		public function load ( url:String ) : void {	
			loader = new Loader();
			configureListeners(loader.contentLoaderInfo);
			loader.load( new URLRequest ( url ));

		}
		
		public function get progress ():Number {
			return loaderProgress;
		}
		
		
		
		
		
		private function configureListeners(dispatcher:IEventDispatcher):void {
			dispatcher.addEventListener(Event.COMPLETE, completeHandler);
			dispatcher.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
			dispatcher.addEventListener(ProgressEvent.PROGRESS, progressHandler);
		}

		private function completeHandler(event:Event):void {
			appDomain = loader.contentLoaderInfo.applicationDomain;
			dispatchEvent ( new Event (LibreriaExterna.LIBRARY_COMPLETE));	
		}

		private function ioErrorHandler(event:IOErrorEvent):void {	}

		private function progressHandler(event:ProgressEvent):void { 
			loaderProgress = event.bytesLoaded / event.bytesTotal;
			dispatchEvent( new Event(LibreriaExterna.LIBRARY_PROGRESS));	
		}
		
		
		
		
		
		
		
		public static function item (id:String) : * {
			var c : Class = Class(appDomain.getDefinition(id));
			var o : * = new c;
			return o;
		}
	}
}

class Privada {
	public function Privada () {}
}
