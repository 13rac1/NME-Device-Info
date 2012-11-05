package ;

import nme.Lib;
import nme.display.Sprite;
import nme.display.Graphics;
import nme.events.Event;
import nme.events.MouseEvent;
import nme.Vector;

import nme.sensors.Accelerometer;
import nme.events.AccelerometerEvent;
import nme.feedback.Haptic;
import nme.ui.Multitouch;
import nme.ui.MultitouchInputMode;
import nme.system.Capabilities;
import nme.system.System;
import nme.filesystem.File;
import nme.text.Font;
#if cpp
import sys.net.Host;
#end

/**
 * NME/Haxe device environment information
 * @author eosrei
 */

/**
 */
class Main extends Sprite {
	private var text:TextManager;
	
	public function new() {
		super();
		#if iphone
			Lib.current.stage.addEventListener(Event.RESIZE, main);
		#else
			addEventListener(Event.ADDED_TO_STAGE, main);
		#end
	}
	
	private function main(e) {
		Lib.trace("Trace test.");
		initText();
		setupEvents();
		//setupButtons();
		addEventListener (Event.ENTER_FRAME, this_onEnterFrame);
	}
	
	private function initText() {
		text = new TextManager();
		addChild(text);

		text.screenDPI.value = Capabilities.screenDPI;
		text.pixelAspectRatio.value = Capabilities.pixelAspectRatio;
		text.language.value = Capabilities.language;
		#if flash11
		text.hasMultiChannelAudio.value = Capabilities.hasMultiChannelAudio;
		#end
		#if flash
		text.cpuArchitecture.value = Capabilities.cpuArchitecture;
		text.hasAudioEncoder.value = Capabilities.hasAudioEncoder;
		text.hasEmbeddedVideo.value = Capabilities.hasEmbeddedVideo;
		text.hasIME.value = Capabilities.hasIME;
		text.hasMP3.value = Capabilities.hasMP3;
		text.hasPrinting.value = Capabilities.hasPrinting;
		text.hasScreenBroadcast.value = Capabilities.hasScreenBroadcast;
		text.hasScreenPlayback.value = Capabilities.hasScreenPlayback;
		text.hasStreamingAudio.value = Capabilities.hasStreamingAudio;
		text.hasStreamingVideo.value = Capabilities.hasStreamingVideo;
		text.hasTLS.value = Capabilities.hasTLS;
		text.hasVideoEncoder.value = Capabilities.hasVideoEncoder;
		text.isDebugger.value = Capabilities.isDebugger;
		text.localFileReadDisable.value = Capabilities.localFileReadDisable;
		text.manufacturer.value = Capabilities.manufacturer;
		text.maxLevelIDC.value = Capabilities.maxLevelIDC;
		text.os.value = Capabilities.os;
		text.playerType.value = Capabilities.playerType;
		text.screenColor.value = Capabilities.screenColor;
		text.version.value = Capabilities.version;
		#end
		
		#if cpp
		text.deviceID.value = System.deviceID;
		#end
		text.totalMemory.value = System.totalMemory;
		
		#if cpp
		text.applicationDirectory.value = File.applicationDirectory;
		text.applicationStorageDirectory.value = File.applicationStorageDirectory;
		text.desktopDirectory.value = File.desktopDirectory;
		text.documentsDirectory.value = File.documentsDirectory;
		text.userDirectory.value = File.userDirectory;
		var file:File = new File();
		text.nativePath.value = file.nativePath;
		text.url.value = file.url;
		#end
		
		#if flash
		var fonts:Array<Font> = Font.enumerateFonts(true);
		var fontList:Array<String> = new Array();
		for (font in fonts) {
			fontList.push(font.fontName);
		}
		text.fonts.value = fontList.join(',');
		#end
		
		text.maxTouchPoints.value = Multitouch.maxTouchPoints;
		var gestureList:Array<String> = new Array();
		var gestures:Vector<String> = Multitouch.supportedGestures;
		if (gestures != null) {
			for (gesture in gestures) {
				gestureList.push(gesture);
			}
		}
		text.supportedGestures.value = gestureList.join(',');
		text.supportsGestureEvents.value = Multitouch.supportsGestureEvents;
		text.supportsTouchEvents.value = Multitouch.supportsTouchEvents;
		
		#if cpp
		text.localhost.value = Host.localhost;
		#end
	}
	

	private function setupEvents():Void {
		if (Accelerometer.isSupported) {
			var accl:Accelerometer = new Accelerometer();
			accl.addEventListener(AccelerometerEvent.UPDATE, this_onAcclUpdate);
		}
		else {
			text.accelX.value = "N/A";
			text.accelY.value = "N/A";
			text.accelZ.value = "N/A";
		}
	}
		
	private function this_onEnterFrame(event:Event):Void {
		text.resolution.value = stage.stageWidth + "X" + stage.stageHeight;
		text.getTimer.value = Lib.getTimer();
	}
	
	private function this_onAcclUpdate(event:AccelerometerEvent):Void {
		text.accelX.value = event.accelerationX;
		text.accelY.value = event.accelerationY;
		text.accelZ.value = event.accelerationZ;
	}
	
	private function setupButtons():Void {
		
		var button:Sprite = new Sprite();
		button.graphics.beginFill(0xffffff);
		button.graphics.drawRoundRect(10, 100, 100, 50, 10, 10);
		button.graphics.endFill();
		button.addEventListener(MouseEvent.CLICK, button1_onclick);
		addChild(button);

		var button2:Sprite = new Sprite();
		button2.graphics.beginFill(0xffffff);
		button2.graphics.drawRoundRect(120, 100, 100, 50, 10, 10);
		button2.graphics.endFill();
		button2.addEventListener(MouseEvent.CLICK, button2_onclick);
		addChild(button2);
	}

	private function button1_onclick(event:MouseEvent):Void {
		#if cpp
		Haptic.vibrate(0, 1000);
		#end
	}

	private function button2_onclick(event:MouseEvent):Void {
		#if cpp
		Haptic.vibrate(10, 1000);
		#end
	}
}
