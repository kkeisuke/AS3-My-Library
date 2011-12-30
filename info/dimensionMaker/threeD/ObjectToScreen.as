package info.dimensionMaker.threeD
{
	
	/** 
	* 簡易 3D から 2D 座標計算クラス
	*/
	public class ObjectToScreen
	{
		private var _scale:Number;
		private var _screenX:Number;
		private var _screenY:Number;
		private var _z:Number;
		
		
		/** 
		* コンストラクタ。focus はオブジェクトの個数以上の値にする。
		* @param x X座標
		* @param y Y座標
		* @param z Z座標
		* @param focus 焦点
		* @param centerX 消失点のX座標
		* @param centerY 消失点のY座標
		*/
		public function ObjectToScreen(x:Number, y:Number, z:Number, focus:Number, centerX:Number, centerY:Number)
		{			
			this._z = z;
			
			_scale = focus / (focus + this._z);
			_scale = _scale > 0 ? _scale : - _scale;
			
			_screenX = x * _scale + centerX;
			_screenY = y * _scale + centerY;
		}
		
		
		/** 
		* 2D上の拡大率
		*/
		public function get scale():Number { return _scale; }
		
		public function set scale(value:Number):void
		{
			_scale = value;
		}
		
		
		/** 
		* 2D上のY座標
		*/
		public function get screenY():Number { return _screenY; }
		
		public function set screenY(value:Number):void
		{
			_screenY = value;
		}
		
		
		/** 
		* 2D上のX座標
		*/
		public function get screenX():Number {	return _screenX; }
		
		public function set screenX(value:Number):void
		{
			_screenX = value;
		}
		
		
		/** 
		* Z座標
		*/
		public function get z():Number { return _z; }
		
		public function set z(value:Number):void 
		{
			_z = value;
		}
		
	}
	
}