package dega.steering {
	
	import com.greensock.TweenMax;
	import com.greensock.easing.EaseLookup;
	import com.greensock.easing.Strong;
	
	import dega.assetsManager.LoadImage;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class Vehicle extends Sprite {
		
		public static const WRAP:String = "wrap";
		public static const DIE:String = "die";
		public static const REBIRTH:String = "rebirth";
		public static const BOUNCE:String = "bounce";
		
		protected var _edgeBehavior:String = BOUNCE;
		protected var _mass:Number = Math.random() * 5 + 1;
		protected var _maxSpeed:Number = Math.random() * 2 + .5;
		protected var _position:Vector2D;
		protected var origin_position:Vector2D;
		protected var _velocity:Vector2D;
		
		protected var radius:Number = Math.random() * 1 + .5;
		protected var life_time:Number;
		protected var dies_at_a_time:Number;
		protected var dies_at_a_distance:Number;
		private var shade:LoadImage;
		
		
		public function Vehicle() {
			_position = new Vector2D();
			_velocity = new Vector2D();
			life_time = -1;
			draw();
			this.scaleX = this.scaleY = 0.5; 
			this.alpha = 0;
			TweenMax.to(this,Math.random() + 5, {scaleX:1,scaleY:1, alpha:1, ease: Strong.easeInOut });
			/*
			shade = new LoadImage("assets/shade.jpg");
			shade.blendMode = "screen";
			shade.scaleX = shade.scaleY = Math.random() * 10;
			shade.addEventListener( Event.COMPLETE, onCompleteLoaded );
			addChild( shade );
			*/
		}
		
		public function onCompleteLoaded ( event:Event ):void {
			shade.x = shade.y = -shade.width * .5;
			
		}
		
		public function setInitialPosition ( xValue:Number = 0, yValue:Number = 0 ):void {
			if ( !origin_position ) origin_position = new Vector2D( xValue, yValue );
			this.position.x = origin_position.x;
			this.position.y = origin_position.y;
			this.scaleX = this.scaleY = 0.5; 
			this.alpha = 0;
			TweenMax.to(this,Math.random() + 5, {scaleX:1,scaleY:1, alpha:1, ease: Strong.easeInOut });
		}
		
		protected function draw ():void {
			//graphics.lineStyle(.5, 0xFFFFFF);
			graphics.beginFill(0xffffff);
			//graphics.drawRect(-radius * .5,-radius * .5,radius,radius);
			graphics.drawCircle(0,0,radius );
			/*			
			graphics.clear();
			graphics.lineStyle(0);
			graphics.moveTo(10, 0);
			graphics.lineTo(-10, 5);
			graphics.lineTo(-10, -5);
			graphics.lineTo(10, 0);
			*/
		}
		
		public function update():void {
			_velocity.truncate(_maxSpeed);
			_position = _position.add(_velocity);
			
			if (_edgeBehavior == WRAP ) wrap();
			else if (_edgeBehavior == BOUNCE ) bounce();
			else if (_edgeBehavior == DIE ) dieAtDistance();
			else if (_edgeBehavior == REBIRTH ) rebirth();
			
			x = position.x;
			y = position.y;
			rotation = _velocity.angle * 180 / Math.PI;
			++life_time;
			this.alpha = origin_position.dist(this.position) > dies_at_a_distance / 3? this.map( origin_position.dist(this.position), 0, dies_at_a_distance, 1, 0) : this.alpha;
		}
		
		
		public function rebirth ():void {
			if ( position.x > stage.stageWidth || position.x < 0 || position.y > stage.stageHeight || position.y < 0 ) {
				position.x = Math.random() * stage.stageWidth;
				position.y = Math.random() * stage.stageHeight;
			}
		}
		public function dieAtDistance ():void {
			if ( origin_position.dist(this.position) > diesAtDistance ) {
				setInitialPosition(Math.random() * stage.stageWidth, Math.random() * stage.stageHeight);
				this.scaleX = this.scaleY = 0.5; 
				this.alpha = 0;
				TweenMax.to(this,Math.random() + 5, {scaleX:1,scaleY:1, alpha:1, ease: Strong.easeInOut });
			}
		}
		public function die ():void {
			if ( life_time >= diesAtTime ) {
				position.x = Math.random() * stage.stageWidth;
				position.y = Math.random() * stage.stageHeight;
				life_time = 0;
			}
		}
		public function bounce ():void {
			if ( position.x > stage.stageWidth ) {
				position.x = stage.stageWidth;
				velocity.x = (velocity.x ^ -1) + 1;
				//velocity.x *= -1;
				
			} else if ( position.x < 0) {
				position.x = 0;
				velocity.x = (velocity.x ^ -1) + 1;
				//velocity.x *= -1;
			} 
			
			if (position.y > stage.stageHeight) {
				position.y = stage.stageHeight;
				velocity.y = (velocity.y ^ -1) + 1;
				//velocity.y *= -1;
				
			} else if ( position.y < 0) {
				position.y = 0;
				velocity.y = (velocity.y ^ -1) + 1;
				//velocity.y *= -1;
			}
		}
		public function wrap():void {
			if (position.x > stage.stageWidth ) position.x = 0;
			if (position.x < 0 ) position.x = stage.stageWidth;
			if (position.y > stage.stageHeight ) position.y = 0;
			if (position.y < 0 ) position.y = stage.stageHeight;
		}
		
		
		public function set diesAtDistance(value:Number):void {
			dies_at_a_distance = value;
		}
		public function get diesAtDistance ( ):Number {
			return dies_at_a_distance;
		}
		
		
		public function set diesAtTime(value:Number):void {
			dies_at_a_time = value;
		}
		public function get diesAtTime ( ):Number {
			return dies_at_a_time;
		}
		
		public function set edgeBehavior(value:String):void {
			_edgeBehavior = value;
		}
		public function get edgeBehavior( ):String {
			return _edgeBehavior;
		}
		
		public function set mass ( value:Number ):void {
			_mass = value; 
		}
		public function get mass ():Number {
			return _mass;
		}
		
		public function set maxSpeed(value:Number):void {
			_maxSpeed = value;
		}
		public function get maxSpeed ():Number {
			return _maxSpeed;
		}
		
		public function set position ( value:Vector2D ):void {
			_position = value;
			x = _position.x;
			y = _position.y;
		}
		public function get position():Vector2D {
			return _position;
		}
		
		public function set velocity ( value:Vector2D ):void {
			_velocity = value;
		}
		public function get velocity ():Vector2D {
			return _velocity;
		}
		
		override public function set x(value:Number):void {
			super.x = value;
			_position.x = x;
		}
		
		override public function set y(value:Number):void {
			super.y = value;
			_position.y = y;
		}
		
		public function map( value:Number, istart:Number, istop:Number, ostart:Number, ostop:Number ):Number {
			return ostart + (ostop - ostart) * ((value - istart) / (istop - istart));
		}
		
	}
}