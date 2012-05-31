package dega.display.text {

	/**
	 * @author Daniel Gonzalez http://www.degafolio.info || 2009
	 */
	
	import com.greensock.TweenMax;
	import com.greensock.easing.Strong;
	
	import flash.display.BlendMode;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.geom.Orientation3D;
	import flash.geom.Rectangle;
	import flash.text.TextLineMetrics;
	import flash.text.engine.*;
	import flash.ui.Keyboard;
	
	import flashx.textLayout.compose.TextFlowLine;
	import flashx.textLayout.container.*;
	import flashx.textLayout.conversion.TextConverter;
	import flashx.textLayout.edit.*;
	import flashx.textLayout.elements.*;
	import flashx.textLayout.events.FlowOperationEvent;
	import flashx.textLayout.factory.StringTextLineFactory;
	import flashx.textLayout.formats.*;
	import flashx.undo.UndoManager;
	
	import nl.demonsters.debugger.MonsterDebugger;
	
	public class CustomTLF extends Sprite {
	
		internal var configuration:Configuration;
		internal var selectionManager:SelectionManager;
		internal var selectionFormat:SelectionFormat;
		internal var editManager:EditManager;
		internal var format:TextLayoutFormat;
		internal var textFlow:TextFlow;
		internal var paragraph:ParagraphElement;
		internal var spantext:SpanElement;
		internal var container:ContainerController;
		
		internal var label:String;
		public var point:Shape;
		private var _color:uint;
		internal var props:Object;
		private var autoRendering:Boolean;
		
		private var linkElement:LinkElement;
		private var linkSpan:SpanElement;
		private var linksStates:Array;
		
		private var linkFormat:TextLayoutFormat; 
		private var linkOverFormat:TextLayoutFormat;
		private var linkVisitedFormat:TextLayoutFormat;
		private var factory:StringTextLineFactory;
		private var currentDelay:Number;
		
		internal var startIndexSelection:int;
		internal var endIndexSelection:int;
		private var editionMode:Boolean;
		private var selectFormat:SelectionFormat;
		private var isDrawFrame:Boolean;
		
		private var _selectedTextColor:uint = 0xffffff;
		private var _selectedTextAlpha:Number = 1.0;
		private var _selectedTextBlendMode:String = "difference";
		private var _pointerColor:uint = 0xffffff;
		private var _pointerAlpha:Number = 1.0;
		private var _pointerBlendMode:String = "difference";
		private var _pointerBlinkRate:Number = 500;
		private var maxFlowLength:Number = 10;
		private var limit:Number = 10;
		
		private var realString:String;
		private var outputPassword:String;
		
		public function CustomTLF( props:Object ):void {	
			
			this.props = props;
			this.label = props.text? props.text : props.htmlText;
			
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
			format.direction = props.direction? props.direction : Direction.LTR;
			format.backgroundColor = 0xFF0000;
			
			try {format.ligatureLevel = props.ligatureLevel? LigatureLevel.EXOTIC : LigatureLevel.NONE;								// < -- Controls which of the ligatures that are defined in the font may be used in the text
			} catch (errObject:Error) {format.ligatureLevel = LigatureLevel.NONE;}
			
			format.lineThrough = props.lineThrough? props.lineThrough : false;
			format.paddingLeft = props.paddingLeft? props.paddingLeft : 0;														// < -- Padding of the paragraph
			format.paddingRight = props.paddingRight? props.paddingRight : 0;
			format.paddingTop = props.paddingTop? props.paddingTop : 0;
			format.paddingBottom = props.paddingBottom? props.paddingBottom : 0;
			format.textDecoration = props.underline? TextDecoration.UNDERLINE : TextDecoration.NONE;							// < -- Use to apply underlining
			format.textIndent = props.textIndent? props.textIndent : 0;															// < -- First line indent, like letters or like the formal way to write a paragraph
			format.textRotation = props.textRotation? props.textRotation : TextRotation.ROTATE_0;								// < -- Individual rotation of the letters
			format.trackingRight = props.tracking? props.tracking : 0;
			format.fontStyle = props.fontStyle && !props.fontLookup? FontPosture.ITALIC : FontPosture.NORMAL;					// < -- Style of text
			format.fontStyle = props.fontStyle && !props.fontLookup? FontWeight.BOLD : FontWeight.NORMAL;						// < -- Weight of text
			
			format.digitCase = props.digitCase? props.digitCase : DigitCase.OLD_STYLE;											// < -- The type of digit case used for this text ||  DigitCase.LINING or DigitCase.OLD_STYLE
			format.digitWidth = props.digitWidth? props.digitWidth : DigitWidth.DEFAULT;										// < -- Type of digit width used for this text || DigitWidth.PROPORTIONAL, DigitWidth.TABULAR or DigitWidth.DEFAULT
			format.direction = Direction.RTL;
			
			_selectedTextColor = props.selectTextColor ? props.selectTextColor : 0xffffff;										// < -- Color del texto selecionado
			_selectedTextAlpha = props.selectedTextAlpha ? props.selectedTextAlpha : 1.0;										// < -- Alpha del texto seleccionado
			_selectedTextBlendMode = props.selectedTextBlendMode ? props.selectedTextBlendMode : BlendMode.DIFFERENCE;			// < -- BlenMode del texto seleccionado
			_pointerColor = props.pointerColor ? props.pointerColor : 0xffffff;													// < -- Color del puntero de texto
			_pointerAlpha = props.pointerAlpha ? props.pointerAlpha : 1.0;														// < -- alpha del puntero de texto
			_pointerBlendMode = props.pointerBlendMode ? props.pointerBlendMode : BlendMode.DIFFERENCE;							// < -- BlendMode del puntero de texto
			_pointerBlinkRate = props.pointerBlinkRate ? props.pointerBlinkRate : 500;											// < -- Tiempo de parpadeo del puntero en milisegundos

			startIndexSelection = -1;
			endIndexSelection = -1;
			
			// - - - - 
			
			
			container = new ContainerController( this, props.width? props.width : NaN, props.height? props.height : NaN );												// < -- Initial size of the container
			configuration = new Configuration ( true );
			configuration.textFlowInitialFormat = format;

			textFlow = TextConverter.importToFlow( this.label, props.text? TextConverter.PLAIN_TEXT_FORMAT : TextConverter.TEXT_FIELD_HTML_FORMAT, configuration );
			if ( props.maxChar ) textFlow.addEventListener( FlowOperationEvent.FLOW_OPERATION_COMPLETE, maxCharacters, false, 0, true );

			if ( props.select ) {
				selectionManager = new SelectionManager ();
				textFlow.interactionManager = selectionManager;
				textFlow.interactionManager.selectRange( startIndexSelection, endIndexSelection );
				textFlow.interactionManager.focusedSelectionFormat = new SelectionFormat ( _selectedTextColor, _selectedTextAlpha, _selectedTextBlendMode, _pointerColor, _pointerAlpha, _pointerBlendMode, _pointerBlinkRate );
				textFlow.interactionManager.refreshSelection();
				textFlow.interactionManager.setFocus();
			}
			if ( props.edit ) {
				editManager = new EditManager (  new UndoManager () );
				textFlow.interactionManager = editManager;
				textFlow.interactionManager.selectRange( startIndexSelection, endIndexSelection );
				textFlow.interactionManager.focusedSelectionFormat = new SelectionFormat ( _selectedTextColor, _selectedTextAlpha, _selectedTextBlendMode, _pointerColor, _pointerAlpha, _pointerBlendMode, _pointerBlinkRate );
				textFlow.interactionManager.refreshSelection();
				textFlow.interactionManager.setFocus();
			}
			
			
			if ( props.linkFormat ) {
				
				linkFormat = new TextLayoutFormat();
				linkFormat.whiteSpaceCollapse = WhiteSpaceCollapse.COLLAPSE;
				linkFormat.fontFamily = props.linkFormat.font? props.linkFormat.font :props.font;												// < -- Fuente
				linkFormat.fontSize = props.fontSize? props.fontSize : props.fontSize;
				linkFormat.textAlign = props.align? props.align : TextAlign.LEFT;														// < -- Alineacion del parrafo
				linkFormat.lineHeight = props.leading? props.leading : 13;																// < -- Espacio entre lineas
				linkFormat.renderingMode = props.font && props.renderingMode ? props.renderingMode : RenderingMode.NORMAL;				// < -- Modo Animacion - Legibilidad
				linkFormat.fontLookup = props.embedFont? FontLookup.EMBEDDED_CFF : FontLookup.DEVICE;											// < -- Divece Font o Embeded fonts
				linkFormat.kerning = props.kerning? Kerning.ON : Kerning.AUTO;															// < -- Kerning adjusts the pixels between certain character pairs to improve readability
				linkFormat.color = props.linkFormat.color? props.linkFormat.color : 0xFF0000;
				linkFormat.lineThrough = props.lineThrough? props.lineThrough : false;
				linkFormat.textDecoration = props.underline? TextDecoration.UNDERLINE : TextDecoration.NONE;							// < -- Use to apply underlining
				
			}
			
			if ( props.linkOverFormat ) {
				linkOverFormat = new TextLayoutFormat();
				linkOverFormat.whiteSpaceCollapse = WhiteSpaceCollapse.COLLAPSE;
				linkOverFormat.fontFamily = props.linkOverFormat.font? props.linkOverFormat.font :props.font;												// < -- Fuente
				linkOverFormat.fontSize = props.linkOverFormat.fontSize? props.linkOverFormat.fontSize : props.fontSize;
				linkOverFormat.textAlign = props.align? props.align : TextAlign.LEFT;														// < -- Alineacion del parrafo
				linkOverFormat.lineHeight = props.leading? props.leading : 13;																// < -- Espacio entre lineas
				linkOverFormat.renderingMode = props.linkOverFormat.font && props.renderingMode ? props.renderingMode : RenderingMode.NORMAL;				// < -- Modo Animacion - Legibilidad
				linkOverFormat.fontLookup = props.embedFont? FontLookup.EMBEDDED_CFF : FontLookup.DEVICE;											// < -- Divece Font o Embeded fonts
				linkOverFormat.kerning = props.kerning? Kerning.ON : Kerning.AUTO;															// < -- Kerning adjusts the pixels between certain character pairs to improve readability
				linkOverFormat.color = props.linkOverFormat.color? props.linkOverFormat.color : 0xFF0000;
				linkOverFormat.lineThrough = props.linkOverFormat.lineThrough? props.linkOverFormat.lineThrough : false;
				linkOverFormat.textDecoration = props.linkOverFormat.underline? TextDecoration.UNDERLINE : TextDecoration.NONE;							// < -- Use to apply underlining
				linkOverFormat.trackingRight = props.linkOverFormat.tracking? props.linkOverFormat.trackingRight : props.tracking ? props.tracking : 0 ;
				
			}
			
			if ( props.linkVisitedFormat ) {
				
				linkOverFormat = new TextLayoutFormat();
				linkOverFormat.whiteSpaceCollapse = WhiteSpaceCollapse.COLLAPSE;
				linkOverFormat.fontFamily = props.linkVisitedFormat.font? props.linkVisitedFormat.font :props.font;												// < -- Fuente
				linkOverFormat.fontSize = props.linkVisitedFormat.fontSize? props.linkVisitedFormat.fontSize : props.fontSize;
				linkOverFormat.textAlign = props.align? props.align : TextAlign.LEFT;														// < -- Alineacion del parrafo
				linkOverFormat.lineHeight = props.leading? props.leading : 13;																// < -- Espacio entre lineas
				linkOverFormat.renderingMode = props.font && props.renderingMode ? props.renderingMode : RenderingMode.NORMAL;				// < -- Modo Animacion - Legibilidad
				linkOverFormat.fontLookup = props.embedFont? FontLookup.EMBEDDED_CFF : FontLookup.DEVICE;											// < -- Divece Font o Embeded fonts
				linkOverFormat.kerning = props.kerning? Kerning.ON : Kerning.AUTO;															// < -- Kerning adjusts the pixels between certain character pairs to improve readability
				linkOverFormat.color = props.linkVisitedFormat.color? props.linkVisitedFormat.color : 0xFF0000;
				linkOverFormat.lineThrough = props.linkVisitedFormat.lineThrough? props.linkVisitedFormat.lineThrough : false;
				linkOverFormat.textDecoration = props.linkVisitedFormat.underline? TextDecoration.UNDERLINE : TextDecoration.NONE;							// < -- Use to apply underlining
				linkOverFormat.trackingRight = props.linkVisitedFormat.tracking? props.linkVisitedFormat.trackingRight : props.tracking ? props.tracking : 0 ;
			
			}
			
			
			textFlow.addChild( paragraph );
			textFlow.flowComposer.addController( container );
			textFlow.flowComposer.updateAllControllers();
			
			this.x = props.x? props.x : 0;
			this.y = props.y? props.y : 0;
			this.alpha = props.alpha? props.alpha : 1.0;
			
			
		}
		
		
		// Basic properties of the text
		
		public function set text ( new_text:String ):void {
			this.label = new_text;
			if ( autoRendering ) render ();
		}
		public function get text ( ):String {
			return textFlow.getText();
		}
		
		public function set htmlText ( htmltext:String ):void {
			this.props.htmlText = htmltext;
			this.label = htmltext;
			if ( autoRendering ) render ();
		}
		public function get htmlText ( ):String {
			return textFlow.getText();
		}
		
		public function set font ( fontFamily:String ):void {
			format.fontFamily = fontFamily;
			if ( autoRendering ) render ();
		}
		public function get font ( ):String {
			return format.fontFamily;
		}
		
		public function set fontSize ( fontSize:int ):void {
			format.fontSize = fontSize;
		}
		public function get fontSize ( ):int {
			return format.fontSize;
		}
		public function set color ( color:uint ):void {
			props.color = color;
			format.color = props.color;
			if ( autoRendering ) render ();
		}
		public function get color ( ):uint {
			return props.color;
		}
		public function set leading ( _leading:Number ):void {
			format.lineHeight = _leading;
		}
		public function get leading ():Number {
			return format.lineHeight;
		}
		public function set textAlign ( alignOfText:String ):void {
			format.textAlign = alignOfText;
			if ( autoRendering ) render ();
		}
		public function get textAlign ():String {
			return format.textAlign;
		}
		public function set tracking ( tracking:Number ):void {
			format.trackingRight = tracking;
			if ( autoRendering ) render ();
		}
		public function get tracking ( ):Number {
			return format.trackingRight;
		}
		public function set underline ( underline:Boolean ):void {
			props.underline = underline;
			format.textDecoration = underline ? TextDecoration.UNDERLINE : TextDecoration.NONE;
			if ( autoRendering ) render ();
		}
		public function get underline ():Boolean {
			return props.underline;
		}
		
		public function set lineThrough ( underline:Boolean ):void {
			props.lineThrough = lineThrough;
			format.lineThrough = lineThrough;
			if ( autoRendering ) render ();
		}
		public function get lineThrough ():Boolean {
			return props.lineThrough;
		}
		
		
		
		// Columns Properties
		
		public function set columnCount ( new_columnCount:int ):void {
			format.columnCount = new_columnCount;
			if ( autoRendering ) render ();
		}
		public function get columnCount ():int {
			return format.columnCount;
		}
		
		public function set columnGap ( spaceBetweenColumns:Number ):void {
			format.columnGap = spaceBetweenColumns;
			if ( autoRendering ) render ();
		}
		public function get columnGap ():Number {
			return format.columnGap;
		}
		
		public function set columnWidth ( widthOfTheColumns:Number ):void {
			format.columnWidth = widthOfTheColumns;
			if ( autoRendering ) render ();
		}
		public function get columnWidth ():Number {
			return format.columnWidth;
		}
		
		
		// paragraph properties of the lext
		
		public function set kerning ( kerning:Boolean ):void {
			format.kerning = kerning? Kerning.ON : Kerning.OFF;
			if ( autoRendering ) render ();
		}
		public function get kerning ():Boolean {
			return props.kerning;
		}

		public function set justify ( justify:Boolean ):void {
			format.textAlignLast = justify? TextAlign.JUSTIFY : TextAlign.START;
			if ( autoRendering ) render ();
		}
		public function get justify ():Boolean {
			return props.justify;
		}
		
		public function set paddingLeft ( paddingLeft:Number ):void {
			props.paddingLeft = paddingLeft;
			format.paddingLeft = paddingLeft;
			if ( autoRendering ) render ();
		}
		public function get paddingLeft ():Number {
			return props.paddingLeft;
		}
		
		public function set paddingRight ( paddingRight:Number ):void {
			props.paddingRight = paddingRight;
			format.paddingLeft = paddingRight;
			if ( autoRendering ) render ();
		}
		public function get paddingRight ():Number {
			return props.paddingRight;
		}
		
		public function set paddingTop ( paddingTop:Number ):void {
			props.paddingTop = paddingTop;
			format.paddingTop = paddingTop;
			if ( autoRendering ) render ();
		}
		public function get paddingTop ():Number {
			return props.paddingTop;
		}
		
		public function set paddingBottom ( paddingLeft:Number ):void {
			props.paddingBottom = paddingBottom;
			format.paddingBottom = paddingBottom;
			if ( autoRendering ) render ();
		}
		public function get paddingBottom ():Number {
			return props.paddingBottom;
		}
		public function set textIndent ( textIndent:Number ):void {
			props.textIndent = textIndent;
			format.textIndent = textIndent;
			if ( autoRendering ) render ();
		}
		public function get textIndent ():Number {
			return props.textIndent;
		}
		public function set renderingMode ( renderingMode:String ):void {
			props.renderingMode = renderingMode;
			format.renderingMode = renderingMode;
			if ( autoRendering ) render ();
		}
		public function get renderingMode ():String {
			return props.renderingMode;
		}
		
		public function set textRotation ( textRotation:String ):void {
			props.textRotation = textRotation;
			format.textRotation = textRotation;
			if ( autoRendering ) render ();
		}
		public function get textRotation ():String {
			return props.textRotation;
		}
		
		public function setSelection ( startIndex:int , endIndex:int ):void {
			startIndexSelection = startIndex;
			endIndexSelection = endIndex;
		}
		
		public function selectAll ():void {
			startIndexSelection = 0;
			endIndexSelection = label.length - 1;
		}
		
		public function resetSelection ():void {
			startIndexSelection = -1;
			endIndexSelection = -1;
		}
		
		
		
		// Pointer
		public function set pointerBlinkRate ( milliseconds:Number ):void {
			_pointerBlinkRate = milliseconds;
		}
		public function set pointerBlendMode ( blendMode:String ):void {
			_pointerBlendMode = blendMode;
		}
		public function set pointerColor ( color:uint ):void {
			_pointerColor = color;
		}
		public function set pointerAlpha ( alpha:Number ):void {
			_pointerAlpha = alpha;
		}
		
		// Text Selected
		public function set selectedTextColor ( color:uint ):void {
			_selectedTextColor = color;
		}
		public function set selectedTextBlendMode ( blendMode:String ):void {
			_selectedTextBlendMode = blendMode;
		}
		public function set selectedTextAlpha ( alpha:Number ):void {
			_selectedTextAlpha = alpha;
		}
		
		override public function set height ( new_height:Number ):void {
			props.height = new_height;
			if ( autoRendering ) render ();
		}
		
		override public function set width ( new_width:Number ):void {
			props.width = new_width;
			if ( autoRendering ) render ();
		}
		
		public function set autoRender ( isAutoRender:Boolean ):void {
			autoRendering = isAutoRender;
			if ( autoRendering ) render ();
		}
		public function get autoRender ( ):Boolean {
			return autoRendering;
		}
		
		public function get length ():int {
			return this.textFlow.textLength;
		}
		
		
		public function highlightParagraph( paragraphIndex:int, color:int):void {
			
			var p:ParagraphElement = textFlow.getChildAt(paragraphIndex) as ParagraphElement;
			var pos:int = p.getAbsoluteStart();
			var endPos:int = pos + p.textLength;
			this.graphics.clear();

			while (pos < endPos) {
				var line:TextFlowLine = p.getTextFlow().flowComposer.findLineAtPosition(pos);
				var bbox:Rectangle = line.getTextLine().getBounds(this);
				this.graphics.beginFill( color );
				this.graphics.drawRect( bbox.x, bbox.y, bbox.width, bbox.height );
				pos += line.textLength;
			}
		}
		
		
		// controls for animate the parragraph lines
		public function paragraphAnimation( paragraphIndex:int ):void {
			var p:ParagraphElement = textFlow.getChildAt(paragraphIndex) as ParagraphElement;
			var pos:int = p.getAbsoluteStart();
			var endPos:int = pos + p.textLength;
			
			while (pos < endPos) {
				var line:TextFlowLine = p.getTextFlow().flowComposer.findLineAtPosition(pos);
				var s:TextLine = line.getTextLine();
				s.alpha = 0;
				var g:Number = Math.random() * 1.5 + .5;
				TweenMax.to( s, Math.random() * 5, { alpha:1, scaleX:g, scaleY:g });
				pos += line.textLength;
			}
		}
		
		
		private function maxCharacters ( event:FlowOperationEvent = null ):void {
			if ( textFlow.textLength > props.maxChar ) {
				textFlow.interactionManager.selectRange( props.maxChar, textFlow.textLength );
				( textFlow.interactionManager as IEditManager).deleteText();
			}
		}
		
		private function displayAsPassword ( event:FlowOperationEvent ):void {
			
			// * * * * * esta funcion no esta completa!

			//			trace ( event.operation.textFlow.getText( ));
			realString = textFlow.getText();
			var tmp_length:int = realString.length;
			
			outputPassword = "";
			for ( var i:int = 0; i < tmp_length; i++ ) outputPassword += "*";
			trace (outputPassword);
			
		}
		
		public function render ():void {
			
			container.setCompositionSize( props.width? props.width : NaN, props.height? props.height : NaN );
			configuration.textFlowInitialFormat = format;

			textFlow = TextConverter.importToFlow( this.label, props.text? TextConverter.PLAIN_TEXT_FORMAT : TextConverter.TEXT_FIELD_HTML_FORMAT, configuration );
			
			if ( props.maxChar ) textFlow.addEventListener( FlowOperationEvent.FLOW_OPERATION_COMPLETE, maxCharacters, false, 0, true );
			textFlow.addEventListener( FlowOperationEvent.FLOW_OPERATION_END, displayAsPassword, false, 0, true );
			
			if ( props.select ) {
				textFlow.interactionManager = selectionManager;
			}
			if ( props.edit ) {
				textFlow.interactionManager = editManager;
			}
			
			if ( props.select || props.edit ) {
				textFlow.interactionManager.selectRange( startIndexSelection, endIndexSelection );
				textFlow.interactionManager.focusedSelectionFormat = new SelectionFormat ( _selectedTextColor, _selectedTextAlpha, _selectedTextBlendMode, _pointerColor, _pointerAlpha, _pointerBlendMode, _pointerBlinkRate );
				textFlow.interactionManager.refreshSelection();
				textFlow.interactionManager.setFocus();
			}
			
			if ( linkFormat ) textFlow.linkNormalFormat = linkFormat;
			if ( linkOverFormat ) textFlow.linkHoverFormat = linkOverFormat;
			if ( linkVisitedFormat ) textFlow.linkActiveFormat = linkVisitedFormat;
			
			textFlow.flowComposer.addController( container );
			textFlow.flowComposer.updateAllControllers();
			paragraphAnimation( 0 );
			
		} 
		
		public function destroy ():void {
			
			configuration = null;
			selectionManager = null;
			selectionFormat = null;
			editManager = null;
			format = null;
			textFlow = null;
			paragraph = null;
			spantext = null;
			container = null;
			point = null;
			props = null;
			linkElement = null;
			linkSpan = null;
			linksStates = null;
			linkFormat = null; 
			factory = null;
			selectFormat = null
		}
	}
}