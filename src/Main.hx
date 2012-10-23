package ;

import nme.display.Sprite;
import nme.display.Graphics;
import nme.text.TextField;
import nme.text.TextFormat;
import nme.text.TextFormatAlign;
import nme.events.Event;
import nme.Lib;
import nme.sensors.Accelerometer;
import nme.events.AccelerometerEvent;
import nme.ui.Multitouch;
import nme.ui.MultitouchInputMode;
/**
 * NME/Haxe device environment information
 * @author Brad Erickson
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
