package info.dimensionMaker.display 
{
	import flash.filesystem.File;

	
	/** 
	* Loader クラスの load メソッドのわずらわしい context の設定を行います。
	*/
	public class BaseLoaderAir extends BaseLoader
	{
		
		
		/** 
		* コンストラクタ
		*/
		public function BaseLoaderAir() 
		{
			
		}
		
		
		/** 
		* 開発環境と本番環境のパスの違いを吸収する simpleLoad (相対パスで記述)
		* @param url URL 文字列
		* @param currentDomain "new LoaderContext(false, ApplicationDomain.currentDomain)" を設定するかどうか
		* @return void
		*/
		override public function simpleLoad(url:String, currentDomain:Boolean = false):void 
		{
			var file:File = File.applicationDirectory.resolvePath(url); //コンテンツへのパス
			
			super.simpleLoad(file.url, currentDomain);
		}
		
	}

}