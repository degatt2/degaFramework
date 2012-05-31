package dega.api {
	
	import degafolio.config.Config;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.system.Security;
	
	import nl.demonsters.debugger.MonsterDebugger;
	
	import sk.prasa.webapis.picasa.PicasaResponder;
	import sk.prasa.webapis.picasa.PicasaService;
	import sk.prasa.webapis.picasa.events.PicasaDataEvent;
	import sk.prasa.webapis.picasa.objects.feed.AlbumEntry;
	import sk.prasa.webapis.picasa.objects.feed.PhotoEntry;
	
	public class PicasaPhotos extends EventDispatcher {
		
		public static const THUMB_SIZE_32:String = "32";
		public static const THUMB_SIZE_48:String = "48";
		public static const THUMB_SIZE_64:String = "64";
		public static const THUMB_SIZE_72:String = "72";
		public static const THUMB_SIZE_104:String = "104";
		public static const THUMB_SIZE_144:String = "144";
		public static const THUMB_SIZE_150:String = "150";
		public static const THUMB_SIZE_160:String = "160";
		
		public static const IMAGE_SIZE_94:String = "94";
		public static const IMAGE_SIZE_110:String = "110";
		public static const IMAGE_SIZE_128:String = "128";
		public static const IMAGE_SIZE_200:String = "200";
		public static const IMAGE_SIZE_220:String = "220";
		public static const IMAGE_SIZE_288:String = "288";
		public static const IMAGE_SIZE_320:String = "320";
		public static const IMAGE_SIZE_400:String = "400";
		public static const IMAGE_SIZE_512:String = "512";
		public static const IMAGE_SIZE_576:String = "576";
		public static const IMAGE_SIZE_640:String = "640";
		public static const IMAGE_SIZE_720:String = "720";
		public static const IMAGE_SIZE_800:String = "800";
		public static const IMAGE_SIZE_912:String = "912";
		public static const IMAGE_SIZE_1024:String = "1024";
		public static const IMAGE_SIZE_1152:String = "1152";
		public static const IMAGE_SIZE_1280:String = "1280";
		public static const IMAGE_SIZE_1440:String = "1440";
		public static const IMAGE_SIZE_1600:String = "1600";
		
		public static const ON_ALBUM_LIST:String = "onAlbumList";
		
		//As an example, to retrieve a 72 pixel image that is cropped, you would specify 72c, while to retrieve the uncropped image, you would specify 72u for the thumbsize or imgmax query parameter values.
		private static const CROPPED:String = "c";
		private static const UNCROPPED:String = "u";
		private var isCropped:Boolean;
		
		private var user_id:String;
		private var service:PicasaService;
		private var imgMax:String;
		private var thumbnailSize:String;
		private var maxResults:int;
		
		public var albums:Vector.<AlbumEntry>;
		public var photos:Vector.<PhotoEntry>;
		private var debugger:MonsterDebugger;
		
		
		public function PicasaPhotos( props:Object ) {
			
			this.user_id = props.user ? props.user : Config.PICASA_USER ;
			this.isCropped = props.isCropped? props.isCropped : false;
			this.imgMax = props.imageSize? props.imageSize : PicasaPhotos.IMAGE_SIZE_640;
			this.thumbnailSize = props.thumbnail_size? props.thumbnail_size : PicasaPhotos.THUMB_SIZE_72;
			this.maxResults = props.maxResults ? props.maxResults : 100 ;
			Security.loadPolicyFile("http://photos.googleapis.com/data/crossdomain.xml");

			init();
		
		}
		
		private function init():void {
			service = new PicasaService();
			service.imgmax = this.imgMax;
			service.thumbsize = isCropped ? this.thumbnailSize + PicasaPhotos.CROPPED :  this.thumbnailSize + PicasaPhotos.UNCROPPED ;
			service.max_results = this.maxResults;
			
			getAlbumList ();
		}
		
		public function getAlbumById ( id:int ):AlbumEntry {
			return albums[id];
		}
		
		public function getPhotoById ( id:int ):PhotoEntry {
			return photos[id];
		}
		
		public function getAlbumList ():void {
			var responder : PicasaResponder = service.albums.list( user_id );
			responder.addEventListener( PicasaDataEvent.DATA, onAlbumList );
			responder.addEventListener( IOErrorEvent.IO_ERROR, onErrorHandler );
		}
		
		public function getAlbumPhotos ( album_id:String = ""):void {
			var responder : PicasaResponder = service.photos.list( user_id , album_id );
			responder.addEventListener( PicasaDataEvent.DATA, onPhotoList );
			responder.addEventListener( IOErrorEvent.IO_ERROR, onErrorHandler );
		}
		
		
		private function onAlbumList( picsData:PicasaDataEvent = null ):void {
		
			var length:int = picsData.data.entries.length;
			albums = new Vector.<AlbumEntry>( length );
			
			for ( var i:int = 0; i < length; i++ ) {
				albums[i] = picsData.data.entries[i];
				MonsterDebugger.trace( this, albums[i].title + "  " + albums[i].id );
			}
			
			this.dispatchEvent( new Event ( PicasaPhotos.ON_ALBUM_LIST ));
		 }
		
		private function onPhotoList( picsData:PicasaDataEvent = null ):void {

			var length:int = picsData.data.entries.length;
			photos = new Vector.<PhotoEntry>( length );
			
			for ( var i:int = 0; i < length; i++ ) {
				photos[i] = picsData.data.entries[i];
			}
			
			this.dispatchEvent( new Event ( Event.COMPLETE ));
			
			//list of photo in the album with ID 5352121571686942849. to get the ID of an album
			//you need to call the list of the albums, and trace picsData.data.entries[nr-album].gphoto.id
			/*
			trace(' picsData entries:' + picsData.data.entries);
			trace('numero de albums:' + picsData.data.entries.length );
			trace('****')
			//the id of the PhotoEntry
			trace(' picsData.data.entries[0].id :' + picsData.data.entries[0].id)
			trace('****')
			//All the info about a picture
			trace(' media  :' + picsData.data.entries[0].media )
			//url max size. you decide the size in service.imgmax
			trace(' media.content.url :' + picsData.data.entries[0].media.content.url )
			//url thumbnails.you decide the size in service.thumbnails
			trace(' thumbnails:' + picsData.data.entries[0].media.thumbnails[0].url )
			//in gphoto you can get some info before loading the pic. for example the height
			trace(' gphoto.height:' + picsData.data.entries[0].gphoto.height)*/
			
		 }
		
		private function onErrorHandler ( event:IOErrorEvent = null ):void {
			trace ("an error has occurred");
		}
		
	}
}