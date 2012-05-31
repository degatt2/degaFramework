package dega.sql.core {
	
	
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.NetConnection;
	import flash.net.Responder;
	
	public class SQLCore extends EventDispatcher {
		
		public static const ON_DATA:String = "ON_DATA";
		public static const ON_ERROR:String = "ON_ERROR";
		
		//Error Log
		public static var DEBUG_MODE:String = "DEBUG_ERROR_LOG";
		public static var PRODUCTION_MODE:String = "PRODUCTION_ERROR_LOG";
		private var error_mode:Boolean = false;
		
		private var gate:String;
		public var nc:NetConnection;
		public var responder:Responder;
		public var responds:Object;
		
		private var data:Array;
		private var columns:Array;
		
		public function SQLCore( props:Object = null ) {
			gate = props.gate? props.gate : Constant.SERVER_HTTP;
		}
		
		public function connect ():void {
			nc = new NetConnection();
			nc.connect ( gate );
		}
		
		public function onFault ( responds:Object ) :void {
			if ( !error_mode ) dispatchEvent( new ErrorEvent ( SQLCore.ON_ERROR ));
			else {
				for ( var i:Object in responds ) {
					trace (responds[i]);
					throw new Error( "La conexion a php no fue exitosa, verifica que la ruta al servidor, el usuario, y la clave a la base de datos" );
				}
			}
		}
		
		public function onResult ( responds:Object ):void {
			this.responds = responds;	
			dispatchEvent( new Event( SQLCore.ON_DATA ));
			destroy();
		}
		
		public function get results ():Object {
			return this.responds;
		}
		
		public function getColumnValues ( nameOfTable:String ):Array {
			var columnValues:Array = new Array();
			var length:Number = this.responds.length;
			for ( var j:int = 0; j < length; j++ ) {
				for ( var i:Object in responds[j] ) {
					if ( i == nameOfTable )  columnValues.push( responds[j][i] );
				}
			}
			return columnValues;
		}
		
		public function getColumnNames ():Array {
			var columnNames:Array = new Array();
			var length:Number = this.responds.length;
			for ( var i:Object in responds[0] ) {
				columnNames.push(i);
			}
			return columnNames;
		}
		
		public function get id ():Object {
			var data:Array = new Array();
			for ( var i:int = 0; i < (this.responds as Array).length; i++ ) {
				data.push( this.responds[i].id );
			}
			return data;
		}
		
		public function set error_log ( mode:String ):void {
			error_mode = mode == SQLCore.DEBUG_MODE? true : false;
		}
		public function get error_log ():String {
			var s:String = error_mode ? SQLCore.DEBUG_MODE : SQLCore.PRODUCTION_MODE;
			return s; 
		}
		
		private function destroy ():void {
			responder = null; 	
		}
	}
}