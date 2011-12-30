package info.dimensionMaker.managers 
{
	import flash.display.Shape;
	import flash.events.Event;
	import flash.utils.Dictionary;
	
	
	/** 
	* EnterFrame を一箇所に纏めるマネジャークラスです。
	*/
	public class EnterFrameManager
	{
		static private var dispatcher:Shape;
		static private var methodDict:Dictionary = new Dictionary();
		
		
		/** 
		* 初期化
		*/
		static public function init():void 
		{
			if (dispatcher == null) 
			{
				dispatcher = new Shape();
			}
		}
		
		
		/** 
		* メソッドの追加
		* @param func 実行するメソッド
		*/
		static public function addMethod(func:Function):void 
		{
			if (methodDict[func] == null) 
			{
				methodDict[func] = func;
			}
		}
		
		
		/** 
		* メソッドの削除
		* @param func 実行するメソッド
		*/
		static public function removeMethod(func:Function):void 
		{
			delete methodDict[func];
		}
		
		
		/** 
		* 全メソッドの削除
		*/
		static public function removeAllMethod():void 
		{
			methodDict = new Dictionary();
		}
		
		
		/** 
		* EnterFrame の開始
		*/
		static public function start():void 
		{
			if (!dispatcher.hasEventListener(Event.ENTER_FRAME)) 
			{
				dispatcher.addEventListener(Event.ENTER_FRAME, _enterEventHandler);
			}
		}
		
		
		/** 
		* EnterFrame の停止
		*/
		static public function stop():void 
		{
			dispatcher.removeEventListener(Event.ENTER_FRAME, _enterEventHandler);
		}
		
		
		static private function _enterEventHandler(e:Event):void 
		{
			for each(var method:Function in methodDict)
			{
				method.call();
			}
		}
		
	}

}