package dega.steering {
	
	import flash.display.Graphics;
	import flash.geom.Vector3D;
	
	public class Vector2D {
		
		public var _x:Number;
		public var _y:Number;
		
		public function Vector2D( x:Number = 0, y:Number = 0) {
			_x = x;
			_y = y;
		}
		
		public function draw(graphics:Graphics, color:uint = 0):void {
			graphics.lineStyle(0,color);
			graphics.moveTo( 0,0);
			graphics.lineTo(_x,_y);
		}
		
		public function clone():Vector2D {
			return new Vector2D(_x, _y );
		}
		
		public function zero():Vector2D {
			_x = y = 0;
			return this;
		}
		
		public function isZero():Boolean {
			return _x == 0 && _y == 0;
		}

		public function set length ( value:Number ):void {
			var a:Number = angle;
			_x = Math.cos(a) * value;
			_y = Math.sin(a) * value;
		}
		
		public function get length ():Number {
			return Math.sqrt( lengthSquared );
		}
		
		public function get lengthSquared ():Number {
			return _x * _x + _y * _y;
		}
		
		public function set angle ( value:Number ):void {
			var len:Number = length;
			_x = Math.cos(value) * len;
			_y = Math.sin(value) * len;
		} 
		public function get angle ():Number {
			return Math.atan2(_y,_x);
		}
		
		public function normalize():Vector2D {
			var len:Number = length;
			if (len == 0) {
				_x = 1;
				return this;
			}
			_x /= len;
			_y /= len;
			return this;
		}
		
		public function truncate ( max:Number):Vector2D {
			length = Math.min(max, length);
			return this;
		}
		
		public function isNormalized ():Boolean {
			return length == 1.0;
		}
		
		public function dotProd(v2:Vector2D):Number {
			return _x * v2.x + _y * v2.y;	
		}
		
		public function angleBetween( v1:Vector2D, v2:Vector2D):Number {
			if (!v1.isNormalized()) v1 = v1.clone().normalize();
			if (!v2.isNormalized()) v2 = v2.clone().normalize();
			return Math.cos(v1.dotProd(v2));
		}
		
		public function sign (v2:Vector2D):int {
			return perp.dotProd(v2) < 0? -1 : 1;
		}
		
		public function get perp():Vector2D {
			return new Vector2D(-y, x );
		}
		
		public function dist (v2:Vector2D):Number {
			return Math.sqrt ( distSquared(v2));
		}
		
		public function distSquared (v2:Vector2D):Number {
			var dx:Number = v2.x - x;
			var dy:Number = v2.y - y;
			return dx * dx + dy * dy;
		}
		
		public function add (v2:Vector2D):Vector2D {
			return new Vector2D(_x + v2.x, _y + v2.y );
		}
		
		public function subtract(v2:Vector2D):Vector2D {
			return new Vector2D(_x - v2.x, _y - v2.y);
		}
		
		public function multiply(value:Number):Vector2D {
			return new Vector2D(_x * value, _y * value);
		}
		
		public function divide (value:Number):Vector2D {
			return new Vector2D(_x / value, _y / value );
		}
		
		public function equals (v2:Vector2D):Boolean {
			return _x == v2.x && _y == v2.y;
		}
		
		public function set x (value:Number):void {
			_x = value;
		}
		
		public function get x ():Number {
			return _x;
		}
		
		public function set y (value:Number):void {
			_y = value;
		}
		
		public function get y ():Number {
			return _y;
		}
		
		public function toString():String {
			return "[Vector2D (x:"+_x + " , y:" + _y + ")]";
		}
	}
}