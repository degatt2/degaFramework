package dega.display.graphics {
	
	import circulo.config.Config;
	import circulo.math.MathHelper;
	
	import flash.display.Sprite;
	import flash.geom.Point;
	
	public class Arco extends Sprite {
		
		private var _thickness:Number;
		private var _startTheta:Number;
		private var _theta:Number;
		private var _radius:Number;
		private var _outerRadius:Number;
		private var space:Number;
		private var color:uint;
		private var point:Point;
		private var resolution:int;
		
		public function Arco( startTheta:Number, endTheta:Number, radius:Number, _thickness:Number, x:int = 0, y:int = 0, fillColor:uint = 0xFF0000, resolution:int = 8 ) {
			
			this.resolution = resolution;
			this.space = Config.SPACE_BETWEEN;
			this._radius = radius;
			this._thickness = _thickness;
			this._outerRadius = _radius + _thickness;
			this._startTheta = startTheta * Math.PI / 180;
			this._theta = endTheta * Math.PI / 180;
			
			this.point = new Point( x, y );
			this.color = fillColor;
			
		}
		
		public function set radius( newRadius:Number ) : void {
			this._radius = newRadius;
		}
		public function get radius() : Number {
			return this._radius;
		}
		
		public function set outerRadius( newRadius:Number ):void {
			_outerRadius = newRadius;
		}
		public function get outerRadius() : Number {
			return _outerRadius;
		}
		
		public function set theta( newTheta:Number) : void {
			this._theta = newTheta * Math.PI / 180;
		}
		public function get theta() : Number {
			return _theta * 180 / Math.PI;
		}
		
		
		public function get thickness() : Number {
			return this._thickness;
		}
		public function set thickness( newThickness:Number ) : void {
			this._thickness = newThickness;
		}
		
		
		public function set colorFill ( newColor:uint ):void {
			this.color = newColor;
		}
		public function get colorFill (  ):uint {
			return this.color;
		}
		public function set spaceBetween ( new_space:Number ):void {
			this.space = new_space;
		}
		public function get spaceBetween ():Number {
			return this.space;
		}
		
		
		public function render ( ):void {
			this.graphics.clear();
			this.graphics.beginFill( color );
			MathHelper.dibujaArco( this, _startTheta + space, _theta - space, _radius, _outerRadius, point.x, point.y, resolution );
			this.graphics.endFill();	
		}
		
	}
}