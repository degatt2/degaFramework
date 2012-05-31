package dega.api {
	
	import com.google.analytics.AnalyticsTracker;
	import com.google.analytics.GATracker;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	public class GoogleAnalytics extends Sprite {
	
		public var tracker:AnalyticsTracker;
		private var currentURL:String = "";
		
		public function GoogleAnalytics( display:DisplayObject, key:String, visualDebug:Boolean = false ) {
			tracker = new GATracker( display, key, AS3, visualDebug );
		}
		
		public function trackPage ( urlPage:String = "" ):void {
			currentURL = urlPage;
			tracker.trackPageview( "/" + currentURL );
		}
		
		public function getPageFromUrl ( newURL:String = "" ):String {
			var s:String;
			if ( newURL != "" ) {
				s = newURL.split('#')[1];
				s = s.substr(1, s.length - 1);
				var tmp_length:int = s.split("%20").length
				for ( var i:int = 0; i < tmp_length; ++i ) s = s.replace("%20", " ");
			}
			return s;
		}
	}
}