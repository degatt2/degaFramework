package dega.display.graphics {
	import flash.display.Graphics;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.display.GradientType;
	
	/**
	 * @author nicoptere
	 */
	public class GradientTriangle
	{
		
		private var _p0:Point;
		private var _p1:Point;
		private var _p2:Point;
		
		private var _baseColor:uint = 0x7F7F7F;
		private var points:Array;
		private var colors:Array;
		
		/**
		 * 
		 * @param	a
		 * @param	b
		 * @param	c
		 * @param	c0
		 * @param	c1
		 * @param	c2
		 */
		public function GradientTriangle( a:Point = null, b:Point = null, c:Point = null, c0:uint = 0xFF0000, c1:uint = 0xFFFF00, c2:uint = 0x0000FF) 
		{
			
			if ( a != null && b != null && c != null )
			{
				points = [ a.clone(), b.clone(), c.clone() ];
			}
			else 
			{
				points = [ new Point( 0, 0 ), new Point( 50, 0), new Point( 0, 50 ) ];
			}
			
			colors = [ c0, c1, c2 ]
		}
		
		/**
		 * @param	graphics
		 */
		private var m:Matrix = new Matrix();
		public function render( graphics:Graphics ):void
		{
			if ( points == null || points.length < 2 ) return;
			
			var dx:Number, dy:Number, a:Number, dist:Number;
			var p:Point, ip:Point;
			
			_p0 = points[ 0 ];
			_p1 = points[ 1 ];
			_p2 = points[ 2 ];
			
			with ( graphics )
			{
				beginFill( _baseColor );
				moveTo( _p0.x, _p0.y );
				lineTo( _p1.x, _p1.y );
				lineTo( _p2.x, _p2.y );
				lineTo( _p0.x, _p0.y );
				endFill();
			}
			
			var i:int;
			for ( i = 0; i < 3; i ++ )
			{
				
				p = points[ i ];
				
				ip = project( p, points[ ( i + 1 ) % 3 ], points[ ( i + 2 ) % 3 ] );
				
				dx = ip.x - p.x; 
				dy = ip.y - p.y; 
				
				dist = Math.sqrt( dx * dx + dy * dy );
				a = Math.atan2( dy, dx );
				
				m = getGradientBox( dist, dist, a, ( p.x + dx / 2 ), ( p.y + dy /2 ) )
				with ( graphics )
				{
					
					beginGradientFill( GradientType.LINEAR, [ colors[ i ],  colors[ i ] ], [ 1,0 ], [ 0, 255 ], m );
					moveTo( _p0.x, _p0.y );
					lineTo( _p1.x, _p1.y );
					lineTo( _p2.x, _p2.y );
					lineTo( _p0.x, _p0.y );
					endFill();
				}
			}
		}
		
		/**
		 * snippet stolen from Quasimondo:
		 * http://www.quasimondo.com/archives/000689.php
		 * @param	width
		 * @param	height
		 * @param	rotation
		 * @param	tx
		 * @param	ty
		 * @return
		 */
		private function getGradientBox( width:Number, height:Number, rotation:Number, tx:Number, ty:Number ):Matrix
		{
			
			var m:Matrix = new Matrix();
			m.createGradientBox( 100, 100 );
			m.translate( -50, -50 );
			m.scale( width / 100, height / 100 );
			m.rotate( rotation );
			m.translate( tx, ty );
			return m;
			
		}
		
		/**
		 * orthogonal projection of a point on a line 
		 * http://board.flashkit.com/board/showthread.php?t=738599
		 * @param	p point to project on the line
		 * @param	p0 first point of the line
		 * @param	p1 second point of the line
		 * @return
		 */
		private function project( p:Point, p0:Point, p1:Point ):Point
		{
			
			var norm:Point = new Point( p1.x - p0.x, p1.y - p0.y);
			var mag:Number = Math.sqrt(norm.x * norm.x + norm.y * norm.y);
			norm.x /= mag;
			norm.y /= mag;
			var pointVector:Point = new Point(p.x - p0.x, p.y - p0.y);
			var dotProduct:Number = pointVector.x * norm.x + pointVector.y * norm.y;
			return new Point(norm.x * dotProduct + p0.x, norm.y * dotProduct + p0.y);
			
		}
		
		public function set point0( point:Point ):void { 	points[ 0 ] = point.clone();	}
		public function set point1( point:Point ):void { 	points[ 1 ] = point.clone();	}
		public function set point2( point:Point ):void { 	points[ 2 ] = point.clone();	}
		
		public function get point0():Point{ 	return points[ 0 ];	}
		public function get point1():Point{ 	return points[ 1 ];	}
		public function get point2():Point{ 	return points[ 2 ];	}
		
		
		public function set baseColor(value:uint):void{ 	_baseColor = value;		}
		public function set color0(value:uint):void{ 	colors[ 0 ] = value;		}
		public function set color1(value:uint):void{ 	colors[ 1 ] = value;		}
		public function set color2(value:uint):void { 	colors[ 2 ] = value;		}
		
		public function get baseColor():uint{ 	return _baseColor;		}
		public function get color0():uint { 	return colors[ 0 ];		}
		public function get color1():uint { 	return colors[ 1 ];		}
		public function get color2():uint { 	return colors[ 2 ];		}
		
	}
}