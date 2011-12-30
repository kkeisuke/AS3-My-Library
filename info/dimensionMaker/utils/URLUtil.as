package info.dimensionMaker.utils 
{
	import flash.external.ExternalInterface;
	
	
	/** 
	* JS で loaction を取得したり、URLの文字列を操作するクラスです。
	*/
	public class URLUtil
	{
		
		
		/** 
		* href プロパティを示す定数です。
		*/
		static public const HREF:String = "href"
		
		
		/** 
		* pathname プロパティを示す定数です。
		*/
		static public const PATHNAME:String = "pathname"
		
		
		/** 
		* protocol プロパティを示す定数です。
		*/
		static public const PROTOCOL:String = "protocol"
		
		
		/** 
		* host プロパティを示す定数です。
		*/
		static public const HOST:String = "host"
		
		
		/** 
		* hostname プロパティを示す定数です。
		*/
		static public const HOSTNAME:String = "hostname"
		
		
		/** 
		* port プロパティを示す定数です。
		*/
		static public const PORT:String = "port"
		
		
		/** 
		* search プロパティを示す定数です。
		*/
		static public const SEARCH:String = "search"
		
		
		/** 
		* hash プロパティを示す定数です。
		*/
		static public const HASH:String = "hash"
		
		
		/** 
		* 定数。ドメインをあらわす正規表現です。
		*/
		static public const DOMAIN:RegExp = /^https?:\/\/[^\/]+/;
		
		
		/** 
		* JS の location を取得します。
		* @param property location オブジェクトのプロパティ
		* @return String
		*/
		static public function getLocation(property:String):String 
		{
			try 
			{
				var loaction:String = ExternalInterface.call("function(){return location." + property + ";}");
				
			}catch (e:Error)
			{
				loaction = e.message;
			}
			
			return loaction;
		}
		
		
		/** 
		* http(s):// から始まる url から絶対パスだけを返します。
		* @param url URL 文字列
		* @return String
		*/
		static public function changePathName(url:String):String 
		{
			if (url.search(DOMAIN) != -1)
			{
				return url.replace(DOMAIN, "");
				
			}else 
			{
				return url;
			}
		}
		
		
		/** 
		* http(s):// から始まる url からフォルダまでのパスだけを返します。
		* @param url URL 文字列
		* @return String
		*/
		static public function changeFolderPath(url:String):String 
		{
			if (url.search(DOMAIN) != -1)
			{
				var pathName:String = url.replace(DOMAIN, "");
				
				return pathName.substring(0, pathName.lastIndexOf("/") + 1);
				
			}else 
			{
				return url;
			}
		}
		
		
		/** 
		* http(s):// から始まる url からファイル名だけを返します。
		* @param url URL 文字列
		* @return String
		*/
		static public function changeFileName(url:String):String 
		{
			if (url.search(DOMAIN) != -1)
			{
				return url.substring(url.lastIndexOf("/") + 1);
				
			}else 
			{
				return url;
			}
		}
		
	}

}