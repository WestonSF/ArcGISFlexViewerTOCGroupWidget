////////////////////////////////////////////////////////////////////////////////
//
// Copyright (c) 2011 Esri
//
// All rights reserved under the copyright laws of the United States.
// You may freely redistribute and use this software, with or
// without modification, provided you include the original copyright
// and use restrictions.  See use restrictions in the file:
// <install location>/License.txt
//
////////////////////////////////////////////////////////////////////////////////
package widgets.TOC.toc.tocClasses
{
	import com.esri.ags.layers.KMLLayer;
	import com.esri.ags.layers.supportClasses.KMLFolder;
	
	import spark.components.Group;
	import spark.components.HGroup;
	import spark.components.Label;
	import spark.components.VGroup;
	
	/**
	 * A TOC item representing folder of a KML Layer.
	 */
	public class TocKmlFolderItem extends TocItem
	{
	    public function TocKmlFolderItem(parentItem:TocItem, folder:KMLFolder, layer:KMLLayer)
	    {
	        super(parentItem);
			
	        _folder = folder;
	        _layer = layer;
	        label = folder.name;
	
	        setVisible(folder.visible, false);
	    }
	
	    //--------------------------------------------------------------------------
	    //  Property:  folder
	    //--------------------------------------------------------------------------
	
	    private var _folder:KMLFolder;
	
	    /**
	     * The KML Folder that represents this TOC item.
	     */
	    public function get folder():KMLFolder
	    {
	        return _folder;
	    }
	
	    //--------------------------------------------------------------------------
	    //  Property:  layer
	    //--------------------------------------------------------------------------
	
	    private var _layer:KMLLayer;
	
	    /**
	     * The KML layer associated with this TOC item.
	     */
	    public function get layer():KMLLayer
	    {
	        return _layer;
	    }
		
		private function getTocMapItem(tocItem:TocItem):TocMapLayerItem
		{
			const tocMapItem:TocMapLayerItem = tocItem as TocMapLayerItem;
			if (tocMapItem)
			{
				return tocMapItem;
			}
			if (tocItem.parent)
			{
				return getTocMapItem(tocItem.parent);
			}
			return null;
		}
	
	    //--------------------------------------------------------------------------
	    //
	    //  Methods
	    //
	    //--------------------------------------------------------------------------
	
	    /**
	     * @private
	     */
	    override internal function setVisible(value:Boolean, layerRefresh:Boolean = true):void
	    {
	        // Set the visible state of this item, but defer the folder refresh on the layer
	        super.setVisible(value, false);
	
	        if (layerRefresh)
	        {
	            if (layer.visible)
	            {
	                layer.setFolderVisibility(folder, value); // refresh the folder in the layer
	            }
	            else
	            {
	                layer.setFolderVisibility(folder, false);
	            }
	        }
	    }
		
		public function getImageResult():*
		{
			const tocMapItem:TocMapLayerItem = getTocMapItem(parent);
			const legendInfo:LegendDataItem = tocMapItem.getLegendDataByLayerName(_layer.id);
			if (legendInfo)
			{
				if (legendInfo.legendGroup.length == 1)
				{
					const legendClass:LegendDataClassItem = legendInfo.legendGroup[0];
					if(legendClass.image){
						return legendClass.image;
					}
					else if (legendClass.symbolitems.length == 1)
					{
						var lsi:LegendSymbolItem = legendClass.symbolitems[0];
						return lsi.uic;
					}
				}
			}
			return null;
		}
		
		public function addLegendClasses(vGroup:VGroup):void
		{
			const tocMapItem:TocMapLayerItem = getTocMapItem(parent);
			const legendInfo:LegendDataItem = tocMapItem.getLegendDataByLayerName(_layer.id);
			if (legendInfo){
				if (legendInfo.legendGroup.length > 0){
					for (var lc:int = 0; lc < legendInfo.legendGroup.length; lc++){
						const legendClass:LegendDataClassItem = legendInfo.legendGroup[lc];
						if (legendClass.symbolitems.length > 1){
							for each (var lsi:LegendSymbolItem in legendClass.symbolitems){
								const uicGroup:Group = new Group();
								uicGroup.width = 30;
								uicGroup.height = 18;
								const hGroup2:HGroup = new HGroup();
								hGroup2.gap = 2;
								hGroup2.verticalAlign = "middle";
								
								const lbl2:Label = new Label();
								lbl2.setStyle("fontWeight", "normal");
								
								lbl2.text = lsi.label;
								if(lsi.image){
									uicGroup.addElement(lsi.uic);
									hGroup2.addElement(uicGroup);
								}else{
									hGroup2.addElement(lsi.uic);
								}
								hGroup2.addElement(lbl2);
								vGroup.addElement(hGroup2);
							}
						}else if (legendInfo.legendGroup.length > 1){
							const hGroup:HGroup = new HGroup();
							hGroup.gap = 2;
							hGroup.verticalAlign = "middle";
							
							const lbl:Label = new Label();
							lbl.setStyle("fontWeight", "normal");
							
							lbl.text = legendClass.label;
							hGroup.addElement(legendClass.image);
							
							hGroup.addElement(lbl);
							vGroup.addElement(hGroup);
						}
					}
				}
			}
		}
	}
}
