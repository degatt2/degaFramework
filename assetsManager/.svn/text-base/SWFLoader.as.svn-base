package dega.assetsManager{

	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;


	public class SWFLoader extends MovieClip {
		
		public static const SWF_COMPLETE:String = "swfComplete";
		private var loader:Loader;
		

		public function SWFLoader ( _url:String ):void {
			
			loader = new Loader( );
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onCompleteHandler);
			loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, onProgressHandler);
			loader.load( new URLRequest( _url ) );	
			
		}	
		
		private function onCompleteHandler( event:Event ):void {
			
        	loader.x = 0 - loader.width / 2;
        	loader.y = 0 - loader.height / 2;
        	addChild(loader);
        	
        	dispatchEvent ( new Event ( SWFLoader.SWF_COMPLETE) );
        	
        }
        
        private function onProgressHandler( event:ProgressEvent ):void {
			var percent:Number = event.bytesLoaded/event.bytesTotal;
		}
		
	}
}