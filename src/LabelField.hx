package;
import flash.text.TextField;
import flash.text.TextFormat;

class LabelField extends TextField {
	private var label:String;
	public var value(null, set_value):Dynamic;
	
	public function new(newLabel:String, textFormat:TextFormat) {
		super();
		defaultTextFormat = textFormat;
		label = newLabel;
		text = label + ": ";
		
	}

	public function set_value(newValue:Dynamic):String {
		var string:String = Std.string(newValue);
		text = label + ": " + string;
		return string;
	}
}