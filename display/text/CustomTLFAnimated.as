package dega.display.text {
	
	/**
	 * @author Daniel Gonzalez http://www.degafolio.info || 2009
	 */
	
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	import flash.text.engine.*;
	
	import flashx.textLayout.container.*;
	import flashx.textLayout.edit.*;
	import flashx.textLayout.elements.*;
	import flashx.textLayout.factory.StringTextLineFactory;
	import flashx.textLayout.formats.*;
	import flashx.undo.UndoManager;
	
	import com.greensock.TweenMax;
	import com.greensock.easing.Expo;
	
	
	public class CustomTLFAnimated extends Sprite {
		
		private var configuration:Configuration;
		private var selectionManager:SelectionManager;
		private var selectionFormat:SelectionFormat;
		private var editManager:EditManager;
		private var undoManager:UndoManager;
		private var format:TextLayoutFormat;
		private var textFlow:TextFlow;
		private var paragraph:ParagraphElement;
		private var spantext:SpanElement;
		private var container:ContainerController;
		
		private var label:String;
		public var point:Shape;
		private var _color:uint;
		private var props:Object;
		private var autoRendering:Boolean;
		
		private var linkElement:LinkElement;
		private var linkSpan:SpanElement;
		private var linksStates:Array;
		
		private var linkFormat:TextLayoutFormat; 
		private var factory:StringTextLineFactory;
		private var currentDelay:Number;
		
		public function CustomTLFAnimated( props:Object ):void {	
			
			this.props = props;
			this.label = props.text? props.text : "";
			this.autoRendering = props.autoRender? props.autoRender : false ;													// < -- Si es falso se tiene q disparar la funcion render para visualizar el texto en pantalla
			
			format = new TextLayoutFormat();																					// < -- Formateando el texto
			format.whiteSpaceCollapse = WhiteSpaceCollapse.COLLAPSE;
			format.fontFamily = props.font? props.font : "Arial, Helvetica, _sans";												// < -- Fuente
			format.fontSize = props.fontSize? props.fontSize : 12;
			
			format.columnCount = props.columnCount? props.columnCount : format.columnCount;										// < -- Numero de columnas que tiene el parrafo
			format.columnGap = props.columnGap? props.columnGap : 20;															// < -- Specifies the amount of gutter space, in pixels, to leave between the columns 
			format.columnWidth = props.columnWidth? props.columnWidth : FormatValue.AUTO;										// < -- Column width in pixels 
			
			format.textAlign = props.align? props.align : TextAlign.LEFT;														// < -- Alineacion del parrafo
			format.lineHeight = props.leading? props.leading : 13;																// < -- Espacio entre lineas
			format.renderingMode = props.font && props.renderingMode ? props.renderingMode : RenderingMode.NORMAL;				// < -- Modo Animacion - Legibilidad
			format.fontLookup = props.embedFont? FontLookup.EMBEDDED_CFF : FontLookup.DEVICE;											// < -- Divece Font o Embeded fonts
			format.textAlignLast = props.lastAlign == TextAlign.JUSTIFY && props.align ? props.lastAlign : TextAlign.START; 	// < -- Alineamiento de la ultima linea en el parrafo.
			format.kerning = props.kerning? Kerning.ON : Kerning.AUTO;															// < -- Kerning adjusts the pixels between certain character pairs to improve readability
			format.color = props.color;
			format.ligatureLevel = props.ligatureLevel? LigatureLevel.EXOTIC : LigatureLevel.NONE;								// < -- Controls which of the ligatures that are defined in the font may be used in the text
			format.lineThrough = props.lineThrough? props.lineThrough : false;
			
			format.paddingLeft = props.paddingLeft? props.paddingLeft : 0;														// < -- Padding of the paragraph
			format.paddingRight = props.paddingRight? props.paddingRight : 0;
			format.paddingTop = props.paddingTop? props.paddingTop : 0;
			format.paddingBottom = props.paddingBottom? props.paddingBottom : 0;
			
			format.textDecoration = props.underline? TextDecoration.UNDERLINE : TextDecoration.NONE;							// < -- Use to apply underlining
			format.textIndent = props.textIndent? props.textIndent : 0;															// < -- First line indent, like letters or like the formal way to write a paragraph
			format.textRotation = props.textRotation? props.textRotation : TextRotation.ROTATE_0;								// < -- Individual rotation of the letters
			format.trackingRight = props.tracking? props.trackingRight : 0;
			format.fontStyle = props.fontStyle && !props.fontLookup? FontPosture.ITALIC : FontPosture.NORMAL;					// < -- Style of text
			format.fontStyle = props.fontStyle && !props.fontLookup? FontWeight.BOLD : FontWeight.NORMAL;						// < -- Weight of text
			
			format.digitCase = props.digitCase? props.digitCase : DigitCase.OLD_STYLE;											// < -- The type of digit case used for this text ||  DigitCase.LINING or DigitCase.OLD_STYLE
			format.digitWidth = props.digitWidth? props.digitWidth : DigitWidth.DEFAULT;										// < -- Type of digit width used for this text || DigitWidth.PROPORTIONAL, DigitWidth.TABULAR or DigitWidth.DEFAULT
			
			this.currentDelay = props.delay? props.delay : 0;
			factory = new StringTextLineFactory();																										// < -- La linea de texto
			factory.compositionBounds = new Rectangle (0, 0, props.width? props.width : NaN, props.height? props.height : NaN);				// < -- width and height of the 
			factory.text = this.label;
			factory.spanFormat = format;
			factory.createTextLines( addTextLineToContainer );
			
			this.x = props.x? props.x : 0;
			this.y = props.y? props.y : 0;
			
		}
		
		
		public function set color ( color:uint ):void {
			props.color = color;
			format.color = props.color;
		}
		public function get color ( ):uint {
			return props.color;
		}
		
		
		private function addTextLineToContainer( textline:TextLine ):void {
			var disObj:DisplayObject = textline;
			disObj.alpha = 1;
			currentDelay += .05; 
			addChild ( disObj );
			TweenMax.from ( disObj, props.time? props.time : 0, {delay: currentDelay, alpha:0, ease:Expo.easeOut });
		}
	}
}