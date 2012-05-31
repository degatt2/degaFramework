package dega.display.text {
	
	import dega.utils.RandomCharacter;
	
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	
	public class TLFParagraphContainer extends CustomTLF {
	
		private var isDrawContainer:Boolean = true;
		private var frame:Sprite;
		private var bg:Shape;
		private var animatedLabel:String;
		private var animatedCount:int;
		private var bufferString:String;
		
		private var currentLength:int;
		private var timer:Timer;
		private var active:Boolean;
		private var randomAnimationStyle:Boolean;
		
		private var staticTime:Number;
		private var animateInTime:Number;
		private var animateOutTime:Number;
		
		
		public function TLFParagraphContainer( props:Object ) {
		
			staticTime = props.staticTime? props.staticTime * 1000 : ( Math.random () * 1000 ) + 1000;
			animateInTime = props.animateIn? ( props.animateIn * 1000 ) / props.text.length : Math.random() * 100;
			animateOutTime = props.animateOut? ( props.animateOut * 1000 ) / props.text.length : Math.random() * 100;
			
			super( props );
			this.bufferString = super.label;
			this.label = "";
			super.render();
			
			this.animatedCount = 1;			
			this.animatedLabel = label.substr( 0, animatedCount );
			
			timer = new Timer ( props.delay? props.delay * 1000 : Math.random() * 100 , 1 );
			timer.addEventListener( TimerEvent.TIMER_COMPLETE, animateInText );
			timer.start();
			
			this.addEventListener( Event.COMPLETE, onComplete );
			if ( isDrawContainer ) draw ( super.container.getContentBounds().width, super.container.getContentBounds().height );
			
		}
		
		private function onComplete ( event:Event = null ):void {
			
			timer = new Timer ( staticTime, 1 );
			timer.addEventListener( TimerEvent.TIMER_COMPLETE, onChange );
			timer.start();
		}
		
		private function onChange ( event:TimerEvent = null ):void {			
			selectTheString ();
		}
		
		
		private function set drawContainer ( b:Boolean ):void {
			isDrawContainer = b;
		}
		
		private function draw ( w:Number, h:Number ):void {
			
			if ( !frame ) { 
				frame = new Sprite ();
				frame.buttonMode = true;
				addChild ( frame );
			}
			
			if ( !bg ) {
				bg = new Shape ();
				addChildAt ( bg, 0 );
			}
			
			if ( super.label.length > 0 ) {
				bg.graphics.clear();
				bg.graphics.beginFill( 0xFFFFFF );
				bg.graphics.drawRect( -5, -5, w + 10, h + 10 );
			}
			
			frame.graphics.clear();
			
			if ( w > 0 ) {
				frame.graphics.lineStyle( 1,  0x47CCF5, 1 );
				frame.graphics.drawRect( 0, 0, w, h );
				frame.graphics.beginFill( 0xFFFFFF );
				frame.graphics.drawRect( -3, -3, 6, 6 );
				frame.graphics.drawRect( -3, h - 3, 6, 6 );
				frame.graphics.drawRect( w - 3, h - 3, 6, 6 );
				frame.graphics.drawRect( w - 3, -3, 6, 6 );
				
				frame.graphics.drawRect( (w - 3) * .5, -3, 6, 6 );
				frame.graphics.drawRect( (w - 3) * .5, h - 3, 6, 6 );
				frame.graphics.drawRect( -3, (h  - 3) * .5, 6, 6 );
				frame.graphics.drawRect( w - 3, ( h - 3 ) * .5, 6, 6 );
				frame.visible = false;
			}
		}
		
		
		private function selectTheString ( ):void {
			
			if ( animatedLabel.length > 0 ) {
				var a:Array = animatedLabel.split(" ");
				currentLength = ( a[a.length - 1].length );
				super.selectAll();
				timer = new Timer ( animateOutTime * 100, 1 );
				timer.addEventListener( TimerEvent.TIMER_COMPLETE, cutTheString );
				timer.start();
				render ();				
				
				a = null;
				frame.visible = true;
			} 
				
			else {
				this.visible = false;
				return;
			}
		}
		
		private function cutTheString ( event:TimerEvent = null ):void {
			
			timer.removeEventListener( TimerEvent.TIMER_COMPLETE, cutTheString );
			timer = null;
			
			this.animatedLabel = animatedLabel.substr( 0, 0 );
			super.label = this.animatedLabel;
			frame.visible = false;
			render ();
			onChange ( null );
		}
		
		
		private function animateInText ( event:TimerEvent = null  ):void {
			
			if ( animatedCount <= bufferString.length ) {
				
				this.animatedLabel = bufferString.substr( 0, animatedCount );
				animatedCount ++;
				
				if ( animatedCount <= bufferString.length - 2 && Math.random() > 0.5 ) {
					super.label = this.animatedLabel + RandomCharacter.getRandomCharacter( Math.random () * 26 );
					super.setSelection( label.length - 1, label.length );
				} else {
					super.label = this.animatedLabel;	
					super.setSelection( -1, -1 );
				}
				
				render ();
				
				timer = new Timer ( Math.random() * animateInTime , 1 );
				timer.addEventListener( TimerEvent.TIMER_COMPLETE, animateInText );
				timer.start();
			} 
				
			else {
				onComplete ( null );
			}
		}
		
		
		override public function render() : void {
			super.render();
			if ( isDrawContainer ) draw ( super.container.getContentBounds().width, super.container.getContentBounds().height );
		}
	}
}