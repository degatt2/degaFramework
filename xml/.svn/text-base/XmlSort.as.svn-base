package dega.xml {
	
	public class XmlSort {
		
		public static function sortNumeric( xml:XML ):XML {
	
			// create new array and populate the array with new object
			// this new object container 2 properties
			// 1. the xml node
			// 2. the index reference for the sort function
				
			var a:Array = new Array ();
			for each ( var xmlNode:* in xml.node ) {
			
				var obj:Object = new Object();
				obj.data = xmlNode;
				obj.order = int (xmlNode.priority);
				a.push(obj);
			
			}
			
			// sort the array by some properties, see the adobe as3 documentation for sortOn in the array section
			a.sortOn('order', Array.NUMERIC );

			// conver the xml list to a string			
			var rawString:String = "";
			for ( var i:int = 0; i < a.length; i ++ )
				rawString += a[i].data;
			
			// create the root node in the xml
			var resultString:String = "<node>" + rawString + "</node>";
			
			// create and return the xml
			var sortedXML:XML = new XML ( resultString );
			return  sortedXML;
		
		}
		
		public static function sortReverse( xml:XML ):XML {
	
			// create new array and populate the array with new object
			// this new object container 2 properties
			// 1. the xml node
			// 2. the index reference for the sort function
				
			var a:Array = new Array ();
			for each ( var xmlNode:* in xml.node ) {
			
				var obj:Object = new Object();
				obj.data = xmlNode;
				obj.order = int (xmlNode.priority);
				a.push(obj);
			
			}
			
			// sort the array by some properties, see the adobe as3 documentation for sortOn in the array section
			a.reverse();

			// conver the xml list to a string			
			var rawString:String = "";
			for ( var i:int = 0; i < a.length; i ++ )
				rawString += a[i].data;
			
			// create the root node in the xml
			var resultString:String = "<node>" + rawString + "</node>";
			
			// create and return the xml
			var sortedXML:XML = new XML ( resultString );
			return  sortedXML;
		
		}
		
	}
}