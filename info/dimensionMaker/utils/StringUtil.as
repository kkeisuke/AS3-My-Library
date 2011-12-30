package info.dimensionMaker.utils 
{
	
	
	/** 
	* String クラスのユーティリティクラスです。
	*/
	public class StringUtil
	{
		
		
		/** 
		* 引数の String が int なら int にキャストして、String ならそのまま返します。
		* @param string 対象文字列
		* @return *
		*/
		static public function getCastedValue(string:String):*
		{
			if (string == "") 
			{
				return string;
				
			}else if(string == "0") 
			{
				return int(string);
				
			}else if(int(string) == 0)
			{
				return string;
				
			}else 
			{
				return int(string);
			}
		}
		
		
		/** 
		* 引数の String の中の改行の回数を返します。
		* @param string 対象
		* @return int
		*/
		static public function getNumLines(string:String):int
		{
			var count:uint = 0;
			var check_str:String;
			
			var n:int = string.length;
			for (var i: int = 0; i < n; i++) 
			{
				check_str = string.substr(i, 1);
				
				if (check_str == "\n") 
				{
					count++
				}
			}
			
			return count
		}
		
		
		/** 
		* replace メソッドの正規表現に変数を使えるようにします。
		* @param target 対象となる文字
		* @param before 置き換える前
		* @param after 置き換えた後
		* @param g 全置換するか？
		* @param i 大文字と小文字を区別するか？
		* @return String
		*/
		static public function replace(target:String, before:String, after:String, g:Boolean = true, i:Boolean = false):String
		{
			var option:String;
			
			g ? option = "g" : option = "";
			i ? option += "i" : option ;
			
			var re:RegExp = new RegExp(before, option);
			
			return target.replace(re, after);
		}
		
	}

}