package dega.steering {
	
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.filters.GlowFilter;
	import flash.geom.Point;
	
	import nl.demonsters.debugger.MonsterDebugger;
	
	public class SteeredVehicle extends Vehicle {
		
		private var max:Number = 1;
		private var _steeringForce:Vector2D;
		
		private var _arrivalThreshold:Number = 150;
		
		private var _wanderDistance:Number = .1;
		private var _wanderRadius:Number = 1;
		private var _wanderAngle:Number = 5;
		private var _wanderRange:Number = 1;
		private var _wanderRangeHalf:Number = _wanderRange * .5;
		
		private var _avoidDistance:Number = 300;
		private var _avoidBuffer:Number = 20;
		
		private var _pathCalculated:Boolean = false;
		private var _pathIndex:int = 0;
		private var _pathThreshold:Number = 20;
		
		private var _inSightDist:Number = 50;
		private var _tooCloseDist:Number = 50;
		
		private var i:int;
		
		// functions variables
		
		private var desiredVelocity:Vector2D;
		private var force:Vector2D;
		private var dist:Number;
		private var lookAheadTime:Number;
		private var predictedTarget:Vector2D;
		private var center:Vector2D;
		private var offset:Vector2D;
		private var heading:Vector2D;
		private var difference:Vector2D;
		private var dotProd:Number;
		private var feeler:Vector2D;
		private var projection:Vector2D;
		private var tmp_radius:Number;
		private var tmp_length:int;
		private var wayPoint:Vector2D;
		private var nearestPoint:Number = 1000;
		private var distances:Vector.<Number>;
		private var j:int;
		private var averageVelocity:Vector2D;
		private var averagePosition:Vector2D;
		private var inSightCount:int;
		private var isGlowing:Boolean;
		
		public function SteeredVehicle() {
			_steeringForce = new Vector2D();
			super();
		}
		
		public function set maxForce(value:Number ):void {
			max = value;
		}
		
		public function get maxForce():Number {
			return max;
		}
		
		public function seek(target:Vector2D):void {
			desiredVelocity = target.subtract(_position);
			desiredVelocity.normalize();
			desiredVelocity = desiredVelocity.multiply(_maxSpeed);
			force = desiredVelocity.subtract(_velocity);
			_steeringForce = _steeringForce.add(force); //
		}
		public function flee(target:Vector2D):void {
			desiredVelocity = target.subtract(_position);
			desiredVelocity.normalize();
			desiredVelocity = desiredVelocity.multiply(_maxSpeed);
			force = desiredVelocity.subtract(_velocity);
			_steeringForce = _steeringForce.subtract(force); //
		}
		public function arrive(target:Vector2D):void {
			desiredVelocity = target.subtract( _position );
			desiredVelocity.normalize();
			dist = _position.dist( target );
			if ( dist > _arrivalThreshold ) desiredVelocity.multiply( _maxSpeed ); // 
			else desiredVelocity = desiredVelocity.multiply( _maxSpeed * dist / _arrivalThreshold ); //
			force = desiredVelocity.subtract( _velocity );
			_steeringForce = _steeringForce.add( force );
		}
		public function persue ( target:Vehicle ):void {
			lookAheadTime = position.dist ( target.position ) / _maxSpeed; // se puede cambiar este valor ( _maxValue ) para afectar la persecucion 
			predictedTarget = target.position.add ( target.velocity.multiply ( lookAheadTime ));
			seek( predictedTarget );
		}
		public function evade ( target:Vehicle ):void {
			lookAheadTime = position.dist ( target.position ) / _maxSpeed; 
			predictedTarget = target.position.add ( target.velocity.multiply ( lookAheadTime ));
			flee( predictedTarget );
		}
		public function wander():void {
			center = velocity.clone().normalize().multiply( _wanderDistance );
			offset = new Vector2D(0);
			offset.length = _wanderRadius;
			offset.angle = _wanderAngle;
			_wanderAngle += ( Math.random() * _wanderRange ) - _wanderRangeHalf;
			force = center.add(offset);
			_steeringForce = _steeringForce.add(force);
		}
		public function avoid( objects:Vector.<Sprite> ):void {
			tmp_length = objects.length;
			for( i = 0; i < objects.length; ++i ) {
				heading = _velocity.clone().normalize();
				difference = new Vector2D(objects[i].x, objects[i].y).subtract( _position );
				dotProd = difference.dotProd(heading);
				
				if( dotProd > 0 ) {
					
					feeler = heading.multiply( _avoidDistance );
					projection = heading.multiply( dotProd );
					dist = projection.subtract( difference ).length;
					
					tmp_radius = (objects[i].width + objects[i].height) * 0.5;
					
					if( dist < tmp_radius + _avoidBuffer && projection.length < feeler.length) {
						
						force = heading.multiply( _maxSpeed );
						force.angle += difference.sign( _velocity ) * Math.PI / 2;
						force = force.multiply(1.0 - projection.length / feeler.length);
						_steeringForce = _steeringForce.add ( force );
						_velocity = _velocity.multiply(projection.length / feeler.length);
					}
				}
			}
		}
		public function followPath( path:Vector.<Vector2D>, loop:Boolean = false, nearest:Boolean = false ):void {
			tmp_length = path.length;
			_pathIndex = !_pathCalculated && nearest? foundNearestPoint( path ) : _pathIndex;  
			wayPoint = path[_pathIndex];
			if( wayPoint == null ) return;
			if( _position.dist(wayPoint) < _pathThreshold ) {
				if (_pathIndex >= tmp_length - 1) _pathIndex = loop? 0 : _pathIndex;
				else ++_pathIndex;
			}
			if( _pathIndex >= tmp_length - 1 && !loop ) arrive( wayPoint );
			else seek( wayPoint );
		}
		
		public function foundNearestPoint ( path:Vector.<Vector2D> ):int {
			tmp_length = path.length;
			nearestPoint = 1000;
			distances = new Vector.<Number>( tmp_length );
			
			for ( j = 0; j < tmp_length; ++j ) {
				distances[j] = _position.dist( path[j] );
				nearestPoint = distances[j] < nearestPoint? distances[j] : nearestPoint;
			}
			_pathCalculated = true;
			return distances.indexOf( nearestPoint ); 
		}
		public function flock(vehicles:Vector.<SteeredVehicle>):void {
			averageVelocity = _velocity.clone();
			averagePosition = new Vector2D();
			inSightCount = 0;
			tmp_length = vehicles.length;
			for( i = 0; i < tmp_length; ++i ){
				if( vehicles[i] != this && inSight( vehicles[i] )) {
					averageVelocity = averageVelocity.add( vehicles[i].velocity );
					averagePosition = averagePosition.add( vehicles[i].position );
					if (tooClose(vehicles[i])) flee( vehicles[i].position );
					++inSightCount;
				}
			}
			if( inSightCount > 0 ) {
				averageVelocity = averageVelocity.divide(inSightCount);
				averagePosition = averagePosition.divide(inSightCount);
				seek( averagePosition );
				_steeringForce.add(averageVelocity.subtract( _velocity ));
			}
		}
		public function inSight(vehicle:Vehicle):Boolean {
			if( _position.dist(vehicle.position ) > _inSightDist ) return false;
			heading = _velocity.clone().normalize();
			difference = vehicle.position.subtract(_position);
			dotProd = difference.dotProd(heading);
			return dotProd < 0? false: true;
		}
		public function tooClose(vehicle:Vehicle):Boolean {
			return _position.dist(vehicle.position) < _tooCloseDist;
		}
		
		public function set arriveThreshold(value:Number):void {
			_arrivalThreshold = value;
		}
		public function get arriveThreshold():Number {
			return _arrivalThreshold;
		}
		public function set wanderDistance(value:Number):void {
			_wanderDistance = value;
		}
		public function get wanderDistance():Number {
			return _wanderDistance;
		}
		public function set wanderRadius(value:Number):void {
			_wanderRadius = value;
		}
		public function get wanderRadius():Number {
			return _wanderRadius;
		}
		public function set wanderRange(value:Number):void {
			_wanderRange = value;
			_wanderRangeHalf = _wanderRange * 0.5; 
		}
		public function get wanderRange():Number {
			return _wanderRange;
		}
		public function set pathIndex(value:int):void{
			_pathIndex = value;
		}
		public function get pathIndex():int{
			return _pathIndex;
		}
		public function set pathThreshold(value:Number):void{
			_pathThreshold = value;
		}
		public function get pathThreshold():Number{
			return _pathThreshold;
		}
		public function set inSightDist(value:Number):void{
			_inSightDist = value;
		}
		public function get inSightDist():Number{
			return _inSightDist;
		}
		
		public function set tooCloseDist(value:Number):void{
			_tooCloseDist = value;
		}
		public function get tooCloseDist():Number{
			return _tooCloseDist;
		}
		public function setGlare ():void {
			if ( !isGlowing ) {
				isGlowing = true;		
				this.filters = [ new GlowFilter(0xffffff,.5,6,6,2,1) ];
			}
		}
		public function removeGlare ():void {
			if ( isGlowing ) {
				isGlowing = false;		
				this.filters = null;
			}
		}
		
		override public function update ():void {
			_steeringForce.truncate( max );
			_steeringForce = _steeringForce.divide( _mass);
			_velocity = _velocity.add(_steeringForce);
			_steeringForce = new Vector2D();
			super.update();
		}
	}
}