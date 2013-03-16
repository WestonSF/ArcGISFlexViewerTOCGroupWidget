package widgets.TOC.toc.tocClasses
{
	import flash.events.EventDispatcher;
	
	public class MenuItem extends EventDispatcher
	{
		public var icon:Object;
		public var label:String;
		[Bindable] public var isGroup:Boolean;
		public var id:String;
	}
}