package info.dimensionMaker.geom 
{
	import flash.display.DisplayObject;
	import flash.display.Stage;
	import flash.geom.Rectangle;
	
	
	/** 
	* ドラッグ対象の Sprite と範囲の DisplayObject(Stage) のオフセット値を計算した Rectangle を返します。
	*/
	public class DragArea
	{
		
		/** 
		* ドラッグ対象の DisplayObject と範囲の DisplayObject(Stage) のオフセット値を計算した Rectangle を返します。
		* @param target 対象の DisplayObject
		* @param area 範囲となる DisplayObject
		* @return Rectangle
		*/
		static public function getRectAngle(target:DisplayObject, area:DisplayObject):Rectangle 
		{
			var bounds:Rectangle = target.getBounds(area);
			
			var offsetX:Number = target.x - bounds.left;
			var offsetY:Number = target.y - bounds.top;
			
			if (area is Stage) 
			{
				var offsetW:Number = Stage(area).stageWidth - bounds.width;
				var offsetH:Number = Stage(area).stageHeight - bounds.height;
				
			}else
			{
				offsetW = area.width - bounds.width;
				offsetH = area.height - bounds.height;
			}
			
			return new Rectangle(offsetX, offsetY, offsetW, offsetH);
		}
		
	}

}