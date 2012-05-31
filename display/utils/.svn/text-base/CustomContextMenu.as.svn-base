package dega.display.utils {
	
	import flash.events.ContextMenuEvent;
	import flash.ui.ContextMenu;
	import flash.ui.ContextMenuItem;
	
	public class CustomContextMenu {
	
		private var contextMenu:ContextMenu;
		
		public function CustomContextMenu( ):void {
		
			contextMenu = new ContextMenu();
			contextMenu.hideBuiltInItems();
			
		}
		
		public function add ( caption:String, params:Object ):void {
			
			var item:ContextMenuItem = new ContextMenuItem( caption );
			item.enabled = params.enabled? params.enabled : true;
			item.separatorBefore = params.separatorBefore? params.separatorBefore : false ;
			if ( params.event ) item.addEventListener( ContextMenuEvent.MENU_ITEM_SELECT, function ( event:ContextMenuEvent = null ):void { params.event(); } );
			contextMenu.customItems.push( item );
			
		}
		
		public function get getContextMenu ():ContextMenu {
			return contextMenu;
		} 
		
		
	}
}