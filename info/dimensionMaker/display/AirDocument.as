package info.dimensionMaker.display 
{
	import flash.display.Screen;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.geom.Rectangle;
	import flash.system.Capabilities;
	
	
	/**
	 * Air 用の Document クラス
	 */
	public class AirDocument extends Sprite
	{
		private static var prefs:File;
		
		
		/** 
		* コンストラクタ
		*/
		public function AirDocument() 
		{
			this.addEventListener(Event.ADDED_TO_STAGE, _init);
		}
		
		
		private function _init(e:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, _init);
			
			setPrefs();
			init();
		}
		
		
		private function setPrefs():void
		{
			if (prefs == null) 
			{
				//アプリ格納ディレクトリ
				prefs = File.applicationStorageDirectory;
				prefs = prefs.resolvePath("prefs.xml");
				
				var prefsXML:XML = readPrefsXML();
				
				// XMLが無かった場合、読み込みエラーの時
				if (prefsXML == null) 
				{
					writePrefsXML(<preferences/>);
				}
			}
		}
		
		
		/** 
		* 通常処理
		* @return void
		*/
		protected function init():void
		{
			
		}
		
		
		/** 
		* 設定XMLを返します。
		* @return XML
		*/
		public static function readPrefsXML():XML
		{
			var prefsXML:XML = null;
			
			if (prefs.exists) 
			{
				var stream:FileStream = new FileStream();
				try
				{
					stream.open(prefs, FileMode.READ);
					prefsXML = XML(stream.readUTFBytes(stream.bytesAvailable));
					
				}catch (e:Error)
				{
					
				}
				finally
				{
					stream.close();
				}
			}
			
			return prefsXML;
		}
		
		
		/** 
		* 設定XMLを書き込み
		* @param prefsXML XML
		* @return void
		*/
		public static function writePrefsXML(prefsXML:XML):void
		{
			if (prefs != null)
			{
				var str:String = '<?xml version="1.0" encoding="utf-8"?>\n';
				str += prefsXML.toXMLString();
				str = str.replace(/\n/g, File.lineEnding);
				
				var stream:FileStream = new FileStream();
				try
				{
					stream.open(prefs, FileMode.WRITE);
					stream.writeUTFBytes(str);
				}
				catch (e:Error)
				{
					
				}
				finally
				{
					stream.close();
				}
			}
		}
		
		
		/** 
		* 主画面のウィンドウが表示可能な領域を返します。
		* @return Rectangle
		*/
		public static function getMainScreenRect():Rectangle 
		{
			return Screen.mainScreen.visibleBounds;
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