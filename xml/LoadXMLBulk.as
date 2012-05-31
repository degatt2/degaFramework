package dega.xml {
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	public class LoadXMLBulk extends EventDispatcher {
		
		private var xmls:Vector.<LoadXML>;
		private var index:int = -1;
		private var length:int = 0;
		
		public function LoadXMLBulk( length:int = 0, target:IEventDispatcher=null) {
			super(target);
			xmls = new Vector.<LoadXML>( length );
		}
		
		public function add ( url:String ):void {
			index = 0;
			length++;
			xmls.push( new LoadXML(url) );
		}
		
		public function load ():void {
			if ( index > -1 ) {
				xmls[index].addEventListener(Event.COMPLETE, onComplete );
				xmls[index].load();
			}
		}
		
		private function onComplete ( event:Event = null ):void {
			var tmp_length:int = xmls.length - 1; 
			if ( index < tmp_length ) {
				++index;
				load();
			} else {
				this.dispatchEvent( new Event ( Event.COMPLETE ));
				return;
			}
		}
		
		public function getXMLByIndex ( _index:int ):XML {
			return xmls[ _index ].data;
		}
	}
}