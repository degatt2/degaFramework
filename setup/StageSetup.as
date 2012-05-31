package dega.setup {
	
	import flash.display.Stage;
	import flash.display.StageAlign;
	import flash.display.StageQuality;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	
	public class StageSetup {
	
		private var stage:Stage;
		
		public function StageSetup( stage:Stage ) { 
			this.stage = stage;
			this.init();
		}
		
		public function init ():void {
			this.stage.scaleMode = StageScaleMode.NO_SCALE;
			this.stage.align = StageAlign.TOP_LEFT
			this.stage.quality = StageQuality.HIGH;
			this.stage.frameRate = 30;
			this.stage.addEventListener(Event.ACTIVATE, onActive );
			this.stage.addEventListener(Event.DEACTIVATE, onDeactive );
		}
		
		private function onActive ( event:Event = null ):void {
			this.stage.frameRate = 30;
		}
		
		private function onDeactive ( event:Event = null ):void {
			this.stage.frameRate = 4;	
		}
	}
}