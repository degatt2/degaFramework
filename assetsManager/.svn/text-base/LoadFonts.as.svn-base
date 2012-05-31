package dega.assetsManager {
	
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	import flash.text.TextFormat;
	

	public class LoadFonts extends EventDispatcher {
		
		public static const FONT_COMPLETE:String = "FontComplete";
		public static const LIST_COMPLETE:String = "ListComplete";
		public static const FONT_PROGRESS:String = "FontProgress";

		public var tf:TextFormat;
		public var percent:Number;
		private var loader:Loader;
		private var fonts:Array;
		private var fonts_url:Array;
		private var currentFont:int = 0;
		
		public function LoadFonts( _urls:Array ) {
			
			fonts_url = _urls;
			fonts = new Array ( fonts_url.length );
			
			for ( var i:int = 0; i < fonts.length; i++ ) {
				fonts[i] = new Loader();
				fonts[i].contentLoaderInfo.addEventListener(Event.COMPLETE, completeHandler);
				fonts[i].contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, onProgressHandler);
			}
		}
		
		public function load ( _currentFont:int = 0 ):void {
			for ( var i:int = 0; i < fonts.length; i++ ) {
				if ( i == _currentFont )
					fonts[i].load( new URLRequest ( fonts_url[i] ) );
			}
		}
		
		private function onProgressHandler ( event:ProgressEvent ):void {
			percent = event.bytesLoaded/event.bytesTotal;
			dispatchEvent ( new Event ( LoadFonts.FONT_PROGRESS ) );
		}
		
		private function completeHandler ( event:Event ):void {
			if (currentFont == fonts.length - 1)
				dispatchEvent ( new Event ( LoadFonts.LIST_COMPLETE ) );
			else				
				dispatchEvent ( new Event ( LoadFonts.FONT_COMPLETE ) );
				currentFont++;
				load( currentFont );
		}
		
		public function get progress ():Number {
			return percent;
		}
	}
}