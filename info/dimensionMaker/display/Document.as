package info.dimensionMaker.display
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.system.Capabilities;
	
	
	/** 
	* ステージ取得を待つ。ドキュメントクラスの基礎クラス。サブクラスを生成して使用します。
	* SWFObject 使用時に、IE6 が Stage を取得出来ない問題を解決します。
	*/
	public class Document extends Sprite
	{
		
		
		/** 
		* コンストラクタ
		*/
		public function Document() 
		{
			_init();
		}
		
		
		private function _init():void
		{
			this.addEventListener(Event.ENTER_FRAME , checkStage);
		}
		
		
		// for SWFObject and IE6
		private function checkStage(e:Event):void 
		{
			if (stage) 
			{
				this.removeEventListener(Event.ENTER_FRAME , checkStage);
				init();
			}
		}
		
		
		/** 
		* ステージ取得後に実行します。
		* @return void
		*/
		protected function init():void
		{
			
		}
		
		
		/** 
		* コンテンツが実行されているシステムの言語コードを返します。
		* チェコ語 cs, デンマーク語 da, オランダ語 nl, 英語 en, フィンランド語 fi, フランス語 fr,
		* ドイツ語 de, ハンガリー語 hu, イタリア語 it, 日本語 ja, 韓国語 ko, ノルウェー語 no, その他/不明 xu,
		* ポーランド語 pl, ポルトガル語 pt, ロシア語 ru, 簡体字中国語 zh-CN, スペイン語 es, スウェーデン語 sv,
		* 繁体字中国語 zh-TW, トルコ語 tr
		* @return String
		*/
		public static function getLanguage():String 
		{
			return Capabilities.language
		}
		
	}
	
}