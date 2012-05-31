package dega.assetsManager {

	import com.zavoo.svg.SvgPaths;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.display.Sprite;
	import flash.events.Event;
	
	
	public class LoadVectors extends Sprite {
		
		private var paths:SvgPaths;
		private var loader:URLLoader;
		
		public function LoadVectors( url_request:String) {
			initLoader( url_request );
		}
		
		
		public function initLoader ( _url:String ):void {
			
			loader = new URLLoader();
			loader.addEventListener (Event.COMPLETE, onLoadComplete);
			loader.load (new URLRequest(_url));
			
		}
		
		public function onLoadComplete ( event:Event ):void {
			
//			var loader:URLLoader = URLLoader(event.target).data;
			paths = new SvgPaths(loader.data);
			paths.drawToGraphics (this.graphics, 1, 10, 10);
			
		}
	}
}