package dega.display.graphics {
	
	import flash.display.Shape;
	
	public class CustomRoundRect extends Shape {
	
		private var _width:Number;
		private var _height:Number;
		private var _radius:Number;
		
		public function CustomRoundRect( width:Number, height:Number, cornerRadius:Number ):void {
		
			this._width = width;
			this._height = height;
			this._radius = cornerRadius;
			
			this.graphics.clear();
			this.graphics.beginFill ( 0x000000 );
			this.graphics.drawRoundRect( 0, 0, _width, _height, _radius, _radius );
			this.graphics.endFill();
		
		}
		
		override public function set width ( new_width:Number ):void {
			_width = new_width;
			this.graphics.clear();
			this.graphics.beginFill ( 0x000000 );
			this.graphics.drawRoundRect( 0, 0, _width, _height, _radius, _radius );
			this.graphics.endFill();
		}
		
		override public function set height ( new_height:Number ):void {
			_height = new_height;
			this.graphics.clear();
			this.graphics.beginFill ( 0x000000 );
			this.graphics.drawRoundRect( 0, 0, _width, _height, _radius, _radius );
			this.graphics.endFill();
		}
		
		public function render ():void {
			this.graphics.clear();
			this.graphics.beginFill ( 0x000000 );
			this.graphics.drawRoundRect( 0, 0, _width, _height, _radius, _radius );
			this.graphics.endFill();
		}
	}
}