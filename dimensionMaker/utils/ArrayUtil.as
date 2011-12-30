package info.dimensionMaker.utils 
{
	
	
	/** 
	* Array クラスのユーティリティクラスです。
	*/
	public class ArrayUtil
	{
		
		
		/** 
		* item のインデックスを返します。
		* @param items 対象の配列
		* @param item インデックスを調べたいオブジェクト
		* @return int
		*/
		static public function getIndex(items:Array, item:*):int
		{
			var n:int = items.length;
			for (var i: int = 0; i < n; i++) 
			{
				if (items[i] == item)
				{
					return i;
				}
			}
			
			return -1;
		}
		
		
		/** 
		* シャッフルした配列を返します。
		* @param array 対象の配列
		* @return Array
		*/
		static public function shuffle(array:Array):Array 
		{
			// while みたいに、i がゼロになるまで j = Math.random() * i, t = a[--i], a[i] = a[j], a[j] = t を繰り返すやりかた。
			// t の型をアスタリスクにして、何でもシャッフルできるようにしている。
			for (var j:int, t:*, i:int = array.length, a:Array = array.slice(); i; j = Math.random() * i, t = a[--i], a[i] = a[j], a[j] = t);
			return a;
		}
		
		
		/** 
		* 配列からランダムに返します。
		* @param array 対象の配列
		* @return *
		*/
		static public function choice(array:Array):*
		{
			return array[int(Math.random() * array.length)];
		}
		
	}

}