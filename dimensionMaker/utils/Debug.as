package info.dimensionMaker.utils
{
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.ContextMenuEvent;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.ui.ContextMenu;
	import flash.ui.ContextMenuItem;
	
	
	/** 
	* 右クリックから画面上で、Trace 結果を確認するクラスです。ブラウザでのテストに。
	*/
	public class Debug 
	{
		static private var contextTarget:Sprite;
		static private var stage:Stage;
		static private var tf:TextField;
		
		static private var traceArr:/**/Array = [];
		static private var traceString:String;
		
		static private var oldLength:int = 0;
		
		
		/** 
		* 初期設定
		* @param s Stage インスタンス
		* @return void
		*/
		static public function init(s:Stage):void 
		{
			stage = s;
			
			// コンテキストメニュー
			var contextMenu:ContextMenu = new ContextMenu();
			
			// 項目
			var traceItem:ContextMenuItem = new ContextMenuItem("Debug.trace");
			traceItem.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, debugTrace);
			
			contextMenu.customItems.push(traceItem);
			
			// 土台
			contextTarget = new Sprite();
			contextTarget.visible = false;
			contextTarget.contextMenu = contextMenu;
			stage.addChildAt(contextTarget, 0);
			
			// テキストフィールド
			tf = new TextField();
			tf.multiline = true;
			tf.wordWrap = true;
			tf.autoSize = TextFieldAutoSize.LEFT;
			tf.text = "";
			var format:TextFormat = new TextFormat();
			format.font ="_sans";
			format.color = 0xFFFFFF;
			tf.defaultTextFormat = format;
			contextTarget.addChild(tf);
		}
		
		
		static private function draw():void 
		{
			contextTarget.graphics.clear();
			contextTarget.graphics.beginFill(0x0336699);
			contextTarget.graphics.drawRect(0, 0, stage.stageWidth, stage.stageHeight);
			contextTarget.graphics.endFill();
		}
		
		
		/** 
		* 通常の trace と同じ。
		* @param targets 対象
		* @return void
		*/
		static public function trace(...targets):void 
		{
			traceArr = traceArr.concat(targets);
		}
		
		
		// イベント
		static private function debugTrace(e:ContextMenuEvent):void 
		{
			if (!contextTarget.visible) 
			{
				if (traceArr.length > oldLength) 
				{
					traceString = "";
					
					var n:int = traceArr.length
					for (var i:int = 0; i < n; i++) 
					{
						traceString += String(traceArr[i]) + ", ";
					}
					
					traceString = traceString.replace(/,\s$/, "");
					
					oldLength = traceArr.length;
				}
				
				tf.text = traceString;
				contextTarget.visible = true;
				contextTarget.alpha = 0.8;
				stage.addChild(contextTarget);
				
				// イベント
				stage.addEventListener(Event.RESIZE, resize);
				resize(null);
				
			}else 
			{
				contextTarget.visible = false;
				stage.addChildAt(contextTarget, 0);
				
				stage.removeEventListener(Event.RESIZE, resize);
			}
		}
		
		
		// イベント
		static private function resize(e:Event):void 
		{
			draw();
			tf.width = stage.stageWidth;
			tf.height = stage.stageHeight;
		}
		
	}
	
}