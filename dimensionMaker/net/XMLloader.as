package info.dimensionMaker.net
{
	import flash.events.IOErrorEvent;
	import flash.net.URLRequest;
	import flash.system.System;
	
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;

	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	
	/** 
	* XMLファイルを読み込んで、XMLList を保持します。
	*/
	public class XMLloader extends EventDispatcher
	{
		private var urlLoader:URLLoader;
		private var _data:XML;
		
		
		/** 
		* コンストラクタ
		* @param url URL文字列
		* @param isUnicode ユニコード
		*/
		public function XMLloader(url:String, isUnicode:Boolean = false)
		{
			System.useCodePage = !isUnicode;
			
			urlLoader = new URLLoader();
			urlLoader.dataFormat = URLLoaderDataFormat.TEXT;
			urlLoader.addEventListener(Event.COMPLETE , onXMLloaded);
			urlLoader.addEventListener(IOErrorEvent.IO_ERROR , onXMLerror);
			urlLoader.load(new URLRequest(url));
		}
		
		
		private function onXMLerror(e:IOErrorEvent):void 
		{
			urlLoader.removeEventListener(Event.COMPLETE , onXMLloaded);
			urlLoader.removeEventListener(IOErrorEvent.IO_ERROR , onXMLerror);
			
			try 
			{
				dispatchEvent(new IOErrorEvent(IOErrorEvent.IO_ERROR));
				
			} catch (e:TypeError)
			{
				//trace(e.message);
			}
		}
		
		
		private function onXMLloaded(event:Event):void 
		{
			urlLoader.removeEventListener(Event.COMPLETE , onXMLloaded);
			urlLoader.removeEventListener(IOErrorEvent.IO_ERROR , onXMLerror);
			
			try 
			{
				_data = new XML(urlLoader.data);
				dispatchEvent(new Event(Event.COMPLETE));
				
			} catch (e:TypeError)
			{
				//trace(e.message);
			}
		}
		
		
		/** 
		* 読み込んだ XML
		*/
		public function get data():XML { return _data; }
		
	}
	
}