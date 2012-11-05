package;
import nme.text.TextField;
import nme.text.TextFormat;

class LabelField extends TextField {
	private var label:String;
	public var value(null, setValue):Dynamic;
	
	public function new(newLabel:String, textFormat:TextFormat) {
		super();
		defaultTextFormat = textFormat;
		label = newLabel;
		text = label + ": ";
		
	}

	public function setValue(newValue:Dynamic):String {
		var string:String = Std.string(newValue);
		text = label + ": " + string;
		return string;
	}
}