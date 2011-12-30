package info.dimensionMaker.utils
{
	
	
	/** 
	* Math クラスのユーティリティクラスです。
	*/
	public class MathUtil
	{
		/** 
		* 定数 180 / Math.PI
		*/
		public static const RADTODEG:Number = 180 / Math.PI;		
		
		
		/** 
		* 定数 Math.PI / 180
		*/
		public static const DEGTORAD:Number = Math.PI / 180;
		
		
		/** 
		* 値のラジアンを返します。
		* @param value 値
		* @return Number
		*/
		static public function toRad(value:Number):Number
		{
			return value * DEGTORAD;
		}
		
		
		/** 
		* 値の度数を返します。
		* @param value 値
		* @return Number
		*/
		static public function toDeg(value:Number):Number
		{
			return value * RADTODEG;
		}
		
		
		/** 
		* number1 が number2 の倍数であるか Boolean を返します。
		* @param number1 ターゲット
		* @param number2 割る数
		* @return Boolean
		*/
		static public function multiple(number1:int,number2:int):Boolean 
		{
			if (number1 % number2 == 0)
			{
				return true;
				
			}else 
			{
				return false;
			}
		}
		
	}
	
}