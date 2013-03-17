// ActionScript file
package widgets.TOCGroup.toc.tocClasses
{	
	import flash.events.EventDispatcher;
	import mx.controls.Image;

	[Bindable]
	[RemoteClass(alias="widgets.TOCGroup.toc.tocClasses.LegendDataClassItem")]
	
	public class LegendDataClassItem extends EventDispatcher
	{
		public var symbolitems:Array = [];
		public var image:Image;
		public var label:String;
	}
}