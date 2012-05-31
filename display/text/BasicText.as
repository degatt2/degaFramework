package dega.display.text {
	
	import com.greensock.TweenMax;
	import com.greensock.easing.Expo;
	
	import dega.assetsManager.FontEmbedding;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	import flash.text.engine.*;
	
	import flashx.textLayout.factory.StringTextLineFactory;
	import flashx.textLayout.formats.TextLayoutFormat;
	

	public class BasicText extends Sprite {
	
		private var factory:StringTextLineFactory;
		private var format:TextLayoutFormat;
		private var label:String;
		private var currentDelay:Number;
		private var bgColor:uint;
	
		public function BasicText( labelText:String, color:uint, bgcolor:uint ) {
			this.bgColor = bgcolor;
			this.currentDelay = 0;
			this.label = labelText;
//			if ( this.label.length > Config.TEXT_LINES_LONG ) this.label = this.label.substr( 0, Config.TEXT_LINES_LONG ) + "...";
			
			factory = new StringTextLineFactory();									// < -- La linea de texto
			factory.compositionBounds = new Rectangle(0, 0, 475, NaN);				// < -- width and height of the 
			factory.text = label;
			 
			format = new TextLayoutFormat();										// < -- Formateando el texto
			format.fontFamily = FontEmbedding.MEDIUM;
			format.fontSize = 16;
			format.color = color;
			format.kerning = Kerning.ON;	
			format.lineHeight = 22;	
			format.renderingMode = RenderingMode.CFF;
			format.fontLookup = FontLookup.EMBEDDED_CFF;
			 
			factory.spanFormat = format;
			factory.createTextLines( addTextLineToContainer );
			 
		}
		
		public function set textColor ( color:uint ):void {
			TweenMax.to ( this, .3, { tint:color });
		}
		
		public function get textHeight ():Number {
			var ref:DisplayObject = this.getChildAt(0) as DisplayObject;
			return ref.height;
		} 
		
		public function get textWidth ():Number {
			return (this.getChildAt(0) as DisplayObject).width;
		} 
		
		private function addTextLineToContainer( textline:TextLine ):void {
			var disObj:DisplayObject = textline;
			disObj.alpha = 1;
			currentDelay += .02;
			if ( disObj.width > 3 ) {
				this.graphics.beginFill( bgColor );
				this.graphics.drawRect( disObj.x, disObj.y - 15, disObj.width + 30, disObj.height + 5);
				this.graphics.endFill();
			}
			addChild ( disObj );
			
			TweenMax.from ( disObj, .3, {delay: Math.random() * .3, alpha:0, ease:Expo.easeOut });
		}
	}
}