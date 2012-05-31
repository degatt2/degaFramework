package dega.sql {
	
	import dega.sql.core.Constant;
	import dega.sql.core.SQLCore;
	import dega.sql.utils.DateFormat;
	
	import degafolio.config.Config;
	
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.NetConnection;
	import flash.net.Responder;
	
	public class SQL extends SQLCore {
	
		
		public function SQL( props:Object = null ) {
			super( props );
		}
		
		override public function connect ():void {
			super.connect();
		}
		
		// Services - - - >
		
		public function getProjectsNames ():void {
			super.responder = new Responder( onResult, onFault );
			super.nc.call ("SQLConnection.query", super.responder, !Config.PRIVATE_PROJECTS? "SELECT * FROM projects ORDER by date DESC" : "SELECT * FROM projects WHERE private = 0 ORDER by date DESC" );
		}
		
		public function getProjectsData ( project_id:String ):void {
			super.responder = new Responder( onResult, onFault );
			super.nc.call ("SQLConnection.query", super.responder, "SELECT * FROM content WHERE project_id = " + project_id + " ORDER BY type");
		}
		
		public function getDateFormat ():Array {
			return DateFormat.getDateFormated( super.getColumnValues("date") ); 
		}
		
		public function mail ( user_name:String, user_email:String, body:String ):void {
			super.responder = new Responder( onResult, onFault );
			super.nc.call("SQLConnection.mail", super.responder, "message from " + user_email, body );
		}
		
		public function mailResponse ( email:String, user_name:String ):void {
			super.responder = new Responder( onResult, onFault );
			super.nc.call("SQLConnection.mail_response", super.responder, email, user_name );
		}
		
	}
}