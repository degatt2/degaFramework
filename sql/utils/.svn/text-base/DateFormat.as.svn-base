package dega.sql.utils {
	
	public class DateFormat {
		
	
		public static function getDateFormated( sql_dates:Array ):Array {

			var months:Array = ["January", "February", "March", "April", "May", "June", "July", "Agoust", "September", "October", "November", "December" ];
			var finalDates:Array = new Array( sql_dates.length );
			
			for ( var i:int = 0; i < sql_dates.length; i++ ) {
				
				var splitString:Array = sql_dates[i].toString().split("-");
				var current:String = "";
				
				current += splitString[0].toString() + " ";
	
				switch ( splitString[1].toString() ) {
					
					case "01":
						current += months[0].toString() + " ";
						break;
					case "02":
						current += months[1].toString() + " ";
						break;
					case "03":
						current += months[2].toString() + " ";		
						break;
					case "04":
						current += months[3].toString() + " ";
						break;
					case "05":
						current += months[4].toString() + " ";
						break;
					case "06":
						current += months[5].toString() + " ";		
						break;
					case "07":
						current += months[6].toString() + " ";
						break;
					case "08":
						current += months[7].toString() + " ";
						break;
					case "09":
						current += months[8].toString() + " ";
						break;
					case "10":
						current += months[9].toString() + " ";		
						break;
					case "11":
						current += months[10].toString() + " ";		
						break;
					case "12":
						current += months[11].toString() + " ";	
						break;
				}
				
				
				current += splitString[2].toString() + " ";
				finalDates[i] = current;
				
			}
			return finalDates;
			
		}
	}
}



