package dega.assetsManager {
	
	//class by roland!!!
	
	import dega.assetsManager.FontEmbedding;
	
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	import flash.text.engine.*;
	
	import flashx.textLayout.factory.StringTextLineFactory;
	import flashx.textLayout.formats.TextLayoutFormat;

	public class FontLabel extends Sprite {
		
		private var factory:StringTextLineFactory;
		private var format:TextLayoutFormat;
		private var label:String;
		
		public function FontLabel(label:String, color:uint, fontSize:Number = 12, width: Number = 100) {
			this.label = label;
			mouseEnabled = false;
			
			factory = new StringTextLineFactory();		// la linea de texto
			factory.compositionBounds = new Rectangle(0, 0, NaN, NaN);
			factory.text = label;
			 
			format = new TextLayoutFormat();			// formateando el texto
			format.fontFamily = FontEmbedding.BOLD;
			format.fontSize = fontSize;
			format.color = color;
			format.renderingMode = RenderingMode.CFF;
			format.fontLookup = FontLookup.EMBEDDED_CFF;
			 
			factory.spanFormat = format;
			factory.createTextLines(addTextLineToContainer);
		}
		
		private function addTextLineToContainer(textline:TextLine):void {
			addChild(textline);
		}
	}
}