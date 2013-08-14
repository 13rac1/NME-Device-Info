package ;
import flash.text.TextField;
import flash.text.TextFormat;
import flash.display.Sprite;

/**
 * ...
 * @author eosrei
 */

class TextManager extends Sprite {
	public var title:TextField;
	public var accelX:LabelField;
	public var accelY:LabelField;
	public var accelZ:LabelField;
	public var resolution:LabelField;
	public var getTimer:LabelField;
	
	public var cpuArchitecture:LabelField;
	public var hasAudioEncoder:LabelField;
	public var hasEmbeddedVideo:LabelField;
	public var hasIME:LabelField;
	public var hasMP3:LabelField;
	public var hasMultiChannelAudio:LabelField;
	public var hasPrinting:LabelField;
	public var hasScreenBroadcast:LabelField;
	public var hasScreenPlayback:LabelField;
	public var hasStreamingAudio:LabelField;
	public var hasStreamingVideo:LabelField;
	public var hasTLS:LabelField;
	public var hasVideoEncoder:LabelField;
	public var isDebugger:LabelField;
	public var language:LabelField;
	public var localFileReadDisable:LabelField;
	public var manufacturer:LabelField;
	public var maxLevelIDC:LabelField;
	public var os:LabelField;
	public var pixelAspectRatio:LabelField;
	public var playerType:LabelField;
	public var screenColor:LabelField;
	public var screenDPI:LabelField;
	public var version:LabelField;
	
	public var deviceID:LabelField;
	public var totalMemory:LabelField;
	
	public var applicationDirectory:LabelField;
	public var applicationStorageDirectory:LabelField;
	public var desktopDirectory:LabelField;
	public var documentsDirectory:LabelField;
	public var userDirectory:LabelField;

	public var fonts:LabelField;

	public var maxTouchPoints:LabelField;
	public var supportedGestures:LabelField;
	public var supportsGestureEvents:LabelField;
	public var supportsTouchEvents:LabelField;
	
	public var localhost:LabelField;
	
	private var textFormat:TextFormat;
	private var totalHeight:Float;
	public function new() {
		super();
		textFormat = new TextFormat ("_sans", 15, 0xFFFFFF);
		totalHeight = 0;
		
		title = create('');
		title.text = 'NME/Haxe device environment information';
		
		accelX = create('Acceleration X');
		accelY = create('Acceleration Y');
		accelZ = create('Acceleration Z');
		
		//nme.Lib
		getTimer = create('getTimer');

		//nme.system.Capabilities
		resolution = create('Screen Resolution');
		screenDPI = create('screenDPI');
		pixelAspectRatio = create('pixelAspectRatio');
		language = create('language');
		#if flash11
		hasMultiChannelAudio = create('hasMultiChannelAudio');
		#end
		#if flash
		cpuArchitecture = create('CPU Architecture');
		hasAudioEncoder = create('hasAudioEncoder');
		hasEmbeddedVideo = create('hasEmbeddedVideo');
		hasIME = create('hasIME');
		hasMP3 = create('hasMP3');
		hasPrinting = create('hasPrinting');
		hasScreenBroadcast = create('hasScreenBroadcast');
		hasScreenPlayback = create('hasScreenPlayback');
		hasStreamingAudio = create('hasStreamingAudio');
		hasStreamingVideo = create('hasStreamingVideo');
		hasTLS = create('hasTLS');
		hasVideoEncoder = create('hasVideoEncoder');
		isDebugger = create('isDebugger');
		localFileReadDisable = create('localFileReadDisable');
		manufacturer = create('Manufacturer');
		maxLevelIDC = create('maxLevelIDC');
		os = create('OS');
		playerType = create('playerType');
		screenColor = create('screenColor');
		version = create('version');
		#end
		
		//nme.system.System
		#if cpp
		deviceID = create('deviceID');
		#end
		totalMemory = create('totalMemory');
		
		//nme.filesystem.File
		#if cpp
		applicationDirectory = create('applicationDirectory');
		applicationStorageDirectory = create('applicationStorageDirectory');
		desktopDirectory = create('desktopDirectory');
		documentsDirectory = create('documentsDirectory');
		userDirectory = create('userDirectory');
		#end
		//@todo:nme.filesystem.StorageVolume
		
		//nme.text.Font
		#if flash
		fonts = create('Fonts');
		#end
		
		//nme.ui.Multitouch
		maxTouchPoints = create('maxTouchPoints');
		supportedGestures = create('supportedGestures');
		supportsGestureEvents = create('supportsGestureEvents');
		supportsTouchEvents = create('supportsTouchEvents');
		
		//sys.net.Host
		#if cpp
		localhost = create('localhost');
		#end

	}
	
	private function create(text:String):LabelField {
		var field:LabelField = new LabelField(text, textFormat);
		
		field.selectable = false;
		field.width = 1024;
		field.height = 25;
		field.y = totalHeight;
		field.x = 0;
		totalHeight += field.height - 5;
		
		this.addChild(field);
		return field;
	}
}