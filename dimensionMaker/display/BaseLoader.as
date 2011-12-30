package info.dimensionMaker.display 
{
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.display.Loader;
	import flash.net.URLRequest;
	
	/** 
	* Loader クラスの load メソッドのわずらわしい context の設定を行います。
	*/
	public class BaseLoader extends Loader
	{
		
		
		/** 
		* コンストラクタ
		*/
		public function BaseLoader() 
		{
			
		}
		
		
		/** 
		* currentDomain を true にすると、context に new LoaderContext(false, ApplicationDomain.currentDomain)
		* を設定します。
		* @param url URL 文字列
		* @param currentDomain "new LoaderContext(false, ApplicationDomain.currentDomain)" を設定するかどうか
		* @return void
		*/
		public function simpleLoad(url:String, currentDomain:Boolean = false):void 
		{
			if (currentDomain) 
			{
				this.load(new URLRequest(url), new LoaderContext(false, ApplicationDomain.currentDomain));
				
			}else 
			{
				this.load(new URLRequest(url), null);
			}
			
		}
		
	}
	
}