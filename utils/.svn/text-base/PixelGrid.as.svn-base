package dega.utils {
	
	import dega.assetsManager.LoadImage;
	
	import flash.display.*;
	
	public class PixelGrid {
		
		public static const RGB:String = "rgb";
		public static const GRAYSCALE:String = "grayscale";
		public var bmd:BitmapData;
		
		public function PixelGrid( mode:String = PixelGrid.GRAYSCALE ) {
			
			var k:int = 0;
			var j:int = 0;

			bmd = new BitmapData( 4, 4, true, 0x00000000);
			bmd.lock();
			
			if ( mode == PixelGrid.RGB ) { 
			
				for ( j = 0; j < 4; j += 2 ) {
					for ( k = 0; k < 4; k += 2 ) {
						bmd.setPixel32( k, j, 0x77FF0000 );
						bmd.setPixel32( k, j + 1, 0x77000000 );
						bmd.setPixel32( k + 1, j + 1, 0x7700FF00 );
						bmd.setPixel32( k + 1, j, 0x330000FF );
					}
				}
			
			} else {
			
				for (  j = 0; j < 4; j += 2 ) {
					for (  k = 0; k < 4; k += 2 ) {
						bmd.setPixel32( k, j, 0xFF000000 );
						bmd.setPixel32( k + 1, j + 1, 0xFF000000 );
					}
				}
			
			}
			bmd.unlock();
		}
		
		public function get bitmapData ():BitmapData {
			return bmd;
		}
		
	}
}