// ActionScript file
package widgets.TOCGroup.toc.tocClasses
{	
	import flash.events.EventDispatcher;

	[Bindable]
	[RemoteClass(alias="widgets.TOCGroup.toc.tocClasses.LegendDataItem")]
	
	public class LegendDataItem extends EventDispatcher
	{
		public var lname:String;
		public var id:int;
		public var minscale:Number;
		public var maxscale:Number;
		public var label:String;
		public var legendGroup:Array =[];
	}
}