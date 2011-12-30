package info.dimensionMaker.display
{	
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	import flash.geom.Point;
	
	
	/** 
	* ソースとなる BitmapData を鏡面に反射させた BitmapData を返します。
	*/
	public class ReflectionBitmapData extends BitmapData
	{
		private var sbmd:BitmapData;
		private var tbmdW:int;
		private var tbmdH:int;
		private var rAlpha:uint;
		
		
		/** 
		* 鏡面に反射させた BitmapData を返します。
		* @param sbmd ソースとなる BitmapData
		* @param color 床の色
		* @param rAlpha 床の反射具合
		* @return void
		*/
		public function ReflectionBitmapData(sbmd:BitmapData, color:uint, rAlpha:uint = 32)
		{
			this.sbmd = sbmd;
			this.tbmdW = sbmd.width;
			this.tbmdH = sbmd.height;
			this.rAlpha = rAlpha;
			
			super(tbmdW, tbmdH, true, color);
			
			blend();
		}
		
		
		private function blend():void
		{
			//ブレンド
			for (var i:int = 0; i < tbmdH; i++)
			{
				var multiply:uint = Math.max(0, i / tbmdH * rAlpha);
				this.merge(sbmd, new Rectangle(0, i, tbmdW, 1), new Point(0, tbmdH - i + 1), multiply, multiply, multiply, 256);
			}
		}
		
	}
	
}