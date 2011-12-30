package info.dimensionMaker.model
{
	import flash.events.ErrorEvent;
	
	
	/** 
	* ローディングに関係するメソッドや定数等をまとめたクラス
	*/
	public class LoadingModelLocator
	{
		
		
		/** 
		* ErrorEvent.ERROR 時のイベントハンドラ new Error(event.text) を throw します。
		* @param event ErrorEvent インスタンス
		*/
		public static function onError(event:ErrorEvent):void
		{
			throw new Error(event.text);
		}
		
	}

}