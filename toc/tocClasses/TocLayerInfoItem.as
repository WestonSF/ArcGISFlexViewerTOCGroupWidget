////////////////////////////////////////////////////////////////////////////////
//
// Copyright (c) 2010 ESRI
//
// All rights reserved under the copyright laws of the United States.
// You may freely redistribute and use this software, with or
// without modification, provided you include the original copyright
// and use restrictions.  See use restrictions in the file:
// <install location>/License.txt
//
////////////////////////////////////////////////////////////////////////////////
package widgets.TOCGroup.toc.tocClasses
{
	import com.esri.ags.layers.supportClasses.LayerInfo;
	
	import spark.components.Group;
	import spark.components.HGroup;
	import spark.components.Label;
	import spark.components.VGroup;
	
	/**
	 * A TOC item representing a member layer of an ArcGIS or ArcIMS map service.
	 * This includes group layers that contain other member layers.
	 */
	public class TocLayerInfoItem extends TocItem
	{
	    public function TocLayerInfoItem(parentItem:TocItem, layerInfo:LayerInfo, isVisible:Boolean, isInScaleRange:Boolean)
	    {
	        super(parentItem);
	
	        _layerInfo = layerInfo;
	        label = layerInfo.name;
			
			setVisible(isVisible, false);
			setIsInScaleRange(isInScaleRange, false);
	    }
		
		private function getTocMapItem(tocItem:TocItem):TocMapLayerItem
		{
			const tocMapItem:TocMapLayerItem = tocItem as TocMapLayerItem;
			if (tocMapItem){
				return tocMapItem;
			}
			if (tocItem.parent){
				return getTocMapItem(tocItem.parent);
			}
			return null;
		}
	
	    //--------------------------------------------------------------------------
	    //  Property:  layerInfo
	    //--------------------------------------------------------------------------
	
	    private var _layerInfo:LayerInfo;
	
	    /**
	     * The map layer info that backs this TOC item.
	     */
	    public function get layerInfo():LayerInfo
	    {
	        return _layerInfo;
	    }
	
	    //--------------------------------------------------------------------------
	    //
	    //  Methods
	    //
	    //--------------------------------------------------------------------------
		
		public function getImageResult():*
		{
			const tocMapItem:TocMapLayerItem = getTocMapItem(parent);
			const legendInfo:LegendDataItem = tocMapItem.getLegendDataByLayerID(_layerInfo.layerId);
			if (legendInfo){
				if (legendInfo.legendGroup.length == 1){
					const legendClass:LegendDataClassItem = legendInfo.legendGroup[0];
					if(legendClass.image){
						return legendClass.image;
					}else if (legendClass.symbolitems.length == 1){
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
			const legendInfo:LegendDataItem = tocMapItem.getLegendDataByLayerID(_layerInfo.layerId);
			if (legendInfo){
				if (legendInfo.legendGroup.length > 0){
					for (var lc:int = 0; lc < legendInfo.legendGroup.length; lc++){
						const legendClass:LegendDataClassItem = legendInfo.legendGroup[lc];
						if (legendClass.symbolitems.length > 1){
							for each (var lsi:LegendSymbolItem in legendClass.symbolitems){
								const uicGroup:Group = new Group();
								uicGroup.width = 30;
								uicGroup.height = 22;
								const hGroup2:HGroup = new HGroup();
								hGroup2.gap = 2;
								hGroup2.verticalAlign = "middle";
								
								const lbl2:Label = new Label();
								lbl2.setStyle("fontWeight", "normal");
								
								lbl2.text = lsi.label;
								if(lsi.image){
									hGroup2.addElement(lsi.image);
								}else{
									uicGroup.addElement(lsi.uic);
									hGroup2.addElement(uicGroup);
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
							if(legendClass.image){
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
}
