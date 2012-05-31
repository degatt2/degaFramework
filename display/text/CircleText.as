package dega.display.text {
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.text.engine.*;
	import dega.assetsManager.FontEmbedding;

	public class CircleText extends Sprite {
		
		private var elementFormat:ElementFormat;
		private var fontDescripcion:FontDescription;
		
		private var thetaWidth:Number;
		private var radiusLong:Number;
		private var center:Point;
		
		private var text:String;
		private var _color:uint;
		
		private var _radius:Number;
		private var centerPoint:Point;
		private var _startThetha:Number;
		private var _fontSize:Number;
		private var _fontHeight:Number;
	
		public function CircleText( ) { }
		
		public function setup ( label:String, radius:Number, startTheta:Number, fontSize:Number, color:uint ):void {
			
			this._fontHeight = 18;
			this._radius = radius;
			this._startThetha = startTheta;
			this._fontSize = fontSize;
			this._color = color;
			this.centerPoint = new Point ( 0, 0 ); 
			this.text = label;
			
			// quitar este evento
			init();
			render();			
		}
		
		private function init():void {
			
			fontDescripcion = new FontDescription( );
			fontDescripcion.fontName = FontEmbedding.BOLD;
			fontDescripcion.fontWeight = FontWeight.NORMAL;
			fontDescripcion.fontPosture = FontPosture.NORMAL;
			fontDescripcion.fontLookup = FontLookup.EMBEDDED_CFF;
			fontDescripcion.renderingMode = RenderingMode.NORMAL;
		}
		
		
		public function render ( ):void {
			
			elementFormat = new ElementFormat( fontDescripcion );
		    elementFormat.fontSize = this._fontSize;
		    elementFormat.color = this._color;
		    elementFormat.breakOpportunity = BreakOpportunity.ALL; //- means every textLine is just a character long

			clearTextFields();

			var te:TextElement = new TextElement ( text, elementFormat );
		    
		    var tb:TextBlock = new TextBlock();				 		 // textBlock
		    tb.applyNonLinearFontScaling = true;
		    tb.content = te;										 //-- this is end of setup for textblock!
		    
		    var firstLine:TextLine = tb.createTextLine ( null );	 // This is the part where we create circular text
		    var circumference:Number = firstLine.textWidth;
		    _fontHeight = firstLine.textHeight;
		    var angleSpanned:Number = _startThetha + 180/Math.PI*( circumference/_radius );
		    
		    firstLine.rotation = angleSpanned + 90;
		    firstLine.x = centerPoint.x + radius * Math.cos( angleSpanned * Math.PI/180 ) ;
		    firstLine.y = centerPoint.y + radius * Math.sin( angleSpanned * Math.PI/180 )  ;
			addChild(firstLine);
		
		    var nextLine:TextLine = tb.createTextLine( firstLine, 30 );
		   
		    while( nextLine != null ){
		    	
				circumference += ((firstLine.textWidth > _fontSize/10)? firstLine.textWidth : _fontSize/3 );
				angleSpanned = _startThetha + 180/Math.PI* ( circumference/_radius ) ;
				
				nextLine.rotation = angleSpanned + 90;
				thetaWidth = angleSpanned;
				nextLine.x = centerPoint.x + radius*Math.cos( angleSpanned * Math.PI/180 );
				nextLine.y = centerPoint.y + radius*Math.sin( angleSpanned * Math.PI/180 );
				
				addChild( nextLine );
				firstLine = nextLine;
				nextLine = tb.createTextLine( firstLine );
			}
		}
		
		
		
		public function set radius ( newRadius:Number ):void {
			_radius = newRadius;
		}
		public function get radius ():Number {
			return _radius;
		}

		
        
        public function set fontSize ( newSize:Number ):void {
        	this._fontSize = newSize;
        }
        public function get fontSize ():Number {
			return this._fontSize;
		}
		
		public function get thetaUsage ():Number {
			return thetaWidth;
		}
		public function get fontHeight (  ):Number {
			if ( _fontHeight) return  this._fontHeight;	
			else return _fontHeight = 18;
		}
	
		private function clearTextFields() : void {
            while (numChildren > 0) removeChildAt(0);
        } 
		
	}
}