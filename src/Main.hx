package ;

import nme.display.Sprite;
import nme.display.Graphics;
import nme.text.TextField;
import nme.text.TextFormat;
import nme.text.TextFormatAlign;
import nme.events.Event;
import nme.events.MouseEvent;
import nme.Lib;
import nme.sensors.Accelerometer;
import nme.events.AccelerometerEvent;
import nme.feedback.Haptic;
import nme.ui.Multitouch;
import nme.ui.MultitouchInputMode;
import nme.system.Capabilities;
import nme.system.System;
import nme.text.Font; //enumerateFonts


/**
 * NME/Haxe device environment information
 * @author Brad Erickson
 */

/**
 * nme.system.System.deviceID
 * nme.system.System.totalMemory
 * http://www.haxenme.org/api/types/nme/system/Capabilities.html
 * http://www.haxenme.org/api/types/nme/filesystem/File.html
 * nme.Lib.getTimer()
 */
class Main extends Sprite {
	private var txtAccel:TextField;
	private var txtRes:TextField;
	
	public function new() {
		super();
		#if iphone
			Lib.current.stage.addEventListener(Event.RESIZE, init);
		#else
			addEventListener(Event.ADDED_TO_STAGE, init);
		#end
	}

	private function init(e) {
		setupText();
		setupEvents();

		addEventListener (Event.ENTER_FRAME, this_onEnterFrame);
	}
	
	private function setupText():Void {
		var defaultFormat:TextFormat = new TextFormat ("_sans", 15, 0xFFFFFF);
		defaultFormat.align = TextFormatAlign.LEFT;

		var txtTitle:TextField = new TextField();
		txtTitle.y = 0;
		txtTitle.x = 0;
		txtTitle.width = 1024;
		txtTitle.selectable = false;
		var txtTitleFormat:TextFormat = new TextFormat ("_sans", 15, 0xFFFFFF);
		txtTitleFormat.align = TextFormatAlign.CENTER;
		txtTitle.defaultTextFormat = txtTitleFormat;
		txtTitle.text = "NME/Haxe device environment information";
		txtTitle.text = Std.string(System.deviceID);// Std.string(Capabilities.screenDPI);
		
		addChild (txtTitle);
		
		txtAccel = new TextField();
		txtAccel.y = 15;
		txtAccel.x = 0;
		txtAccel.width = 1024;
		txtAccel.defaultTextFormat = defaultFormat;
		addChild (txtAccel);

		txtRes = new TextField();
		txtRes.y = 70;
		txtRes.x = 0;
		txtRes.width = 1024;
		txtRes.defaultTextFormat = defaultFormat;
		addChild (txtRes);
		
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

	private function setupEvents():Void {
		if (Accelerometer.isSupported) {
			var accl:Accelerometer = new Accelerometer();
			accl.addEventListener(AccelerometerEvent.UPDATE, this_onAcclUpdate);
		}
		else {
			txtAccel.text = "Accelerometer is not supported ";
		}
	}
	
	private var fields:Array<Dynamic>;
	
	private function addField:TextField {
		
	}
	
	private function this_onEnterFrame(event:Event):Void {
		txtRes.text = "Resolution: " + stage.stageWidth + "X" + stage.stageHeight;
	}
	
	private function this_onAcclUpdate(event:AccelerometerEvent):Void {
		txtAccel.text
			= "acceleration X: " + event.accelerationX + "\n"
            + "acceleration Y: " + event.accelerationY + "\n"
            + "acceleration Z: " + event.accelerationZ;
	}
}
