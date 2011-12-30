package info.dimensionMaker.managers
{
	import flash.display.DisplayObject;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.utils.Dictionary;
	
	
	/** 
	* Event.RESIZE のリスナーをまとめたり、DisplayObject のリキッドレイアウトを実現します。扱えるプロパティは、"width","height","left","right","top","bottom" 。
	* メソッドも指定できます。
	*/
	public class StageResizeManager
	{
		
		
		/** 
		* 調整できる width プロパティ
		*/
		static public const WIDTH:String = "width";
		
		/** 
		* 調整できる height プロパティ
		*/
		static public const HEIGHT:String = "height";
		
		/** 
		* 調整できる x プロパティ ステージ左端が基準
		*/
		static public const LEFT:String = "left";
		
		/** 
		* 調整できる x プロパティ ステージ右端が基準
		*/
		static public const RIGHT:String = "right";
		
		/** 
		* 調整できる y プロパティ ステージ上部が基準
		*/
		static public const TOP:String = "top";
		
		/** 
		* 調整できる y プロパティ ステージ下部が基準
		*/
		static public const BOTTOM:String = "bottom";
		
		
		static private var stage:Stage;
		
		// DisplayObject や メソッド を管理する
		static private var methodDict:Dictionary = new Dictionary();
		static private var displayObjectDict:Dictionary = new Dictionary();
		static private var propertyDict:Dictionary = new Dictionary();
		
		static private const X:String = "x";
		static private const Y:String = "y";
		
		static private var stageValue:Number;
		static private var propertyString:String;
		
		
		/** 
		* 初期設定。null を入れると、イベントを解除
		* @param s Stage インスタンス
		* @return void
		*/
		static public function init(s:Stage):void 
		{
			if (s) 
			{
				stage = s;
				stage.addEventListener(Event.RESIZE , _resize);
				
			}else 
			{
				stage.removeEventListener(Event.RESIZE , _resize);
			}
		}
		
		
		/** 
		* リサイズ時に実行してほしいメソッドを追加
		* @param func リサイズ時に実行されるメソッド
		* @param rightNow 設定直後に実行するかどうか？
		* @return void
		*/
		static public function addMethod(func:Function, rightNow:Boolean = false):void
		{
			if (rightNow) 
			{
				func();
			}
			
			methodDict[func] = func;
		}
		
		
		/** 
		* リサイズ時に位置を調節してほしい DisplayObject を追加
		* @param displayObject 対象の DisplayObject
		* @param property 再調整してほしいプロパティ
		* @return void
		*/
		static public function addDispLayObject(displayObject:DisplayObject, property:Object):void
		{
			displayObjectDict[displayObject] = displayObject;
			propertyDict[displayObject] = property;
			
			for (var name:String in property) 
			{
				switch (name) 
				{
					case WIDTH:
						
						propertyString = WIDTH;
						stageValue = stage.stageWidth;
						break;
						
					case HEIGHT:
						
						propertyString = HEIGHT;
						stageValue = stage.stageHeight;
						break;
						
					case LEFT:
						
						propertyString = X;
						stageValue = 0;
						break;
						
					case RIGHT:
						
						propertyString = X;
						stageValue = stage.stageWidth;
						break;
						
					case TOP:
						
						propertyString = Y;
						stageValue = 0;
						break;
						
					case BOTTOM:
						
						propertyString = Y;
						stageValue = stage.stageHeight;
						break;
						
					default :
						break;
				}
				
				if (typeof property[name] == "function") 
				{
					displayObject[propertyString] = property[name].call();
					
				}else if (typeof property[name] == "string") 
				{
					displayObject[propertyString] = stageValue * Number(property[name]);
					
				}else 
				{
					displayObject[propertyString] = stageValue + property[name];
				}
			}
		}
		
		
		/** 
		* メソッドの削除
		* @param func メソッド
		* @return void
		*/
		static public function removeMethod(func:Function):void 
		{
			delete methodDict[func];
		}
		
		
		/** 
		* 全メソッドの削除
		* @return void
		*/
		static public function removeAllMethod():void 
		{
			methodDict = new Dictionary();
		}
		
		
		/** 
		* DisplayObject の削除
		* @param displayObject 対象の DisplayObject
		* @return void
		*/
		static public function removeDispLayObject(displayObject:DisplayObject):void 
		{
			delete displayObjectDict[displayObject];
		}
		
		
		/** 
		* 全ディスプレイオブジェクトの削除
		* @return void
		*/
		static public function removeAllDispLayObject():void 
		{
			displayObjectDict = new Dictionary();
		}
		
		
		// リサイズ
		static private function _resize(e:Event):void 
		{
			for each(var displayObject:DisplayObject in displayObjectDict)
			{
				addDispLayObject(displayObject, propertyDict[displayObject]);
			}
			
			for each(var method:Function in methodDict)
			{
				method.call();
			}
		}
		
	}

}