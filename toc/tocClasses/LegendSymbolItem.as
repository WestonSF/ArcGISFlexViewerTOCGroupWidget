// ActionScript file
package widgets.TOC.toc.tocClasses
{	
	import flash.events.EventDispatcher;
	import mx.core.UIComponent;
	import spark.components.Image;

	[Bindable]
	[RemoteClass(alias="widgets.TOC.toc.tocClasses.LegendSymbolItem")]
	
	public class LegendSymbolItem extends EventDispatcher
	{
		public var label:String;
		public var image:Image;
		public var uic:UIComponent
	}
}