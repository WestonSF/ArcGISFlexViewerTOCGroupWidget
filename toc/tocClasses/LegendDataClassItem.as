// ActionScript file
package widgets.TOC.toc.tocClasses
{	
	import flash.events.EventDispatcher;
	import spark.components.Image;

	[Bindable]
	[RemoteClass(alias="widgets.TOC.toc.tocClasses.LegendDataClassItem")]
	
	public class LegendDataClassItem extends EventDispatcher
	{
		public var symbolitems:Array = [];
		public var image:Image;
		public var label:String;
	}
}