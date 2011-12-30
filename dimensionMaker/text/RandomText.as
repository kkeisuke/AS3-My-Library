package info.dimensionMaker.text 
{
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import info.dimensionMaker.text.BaseTextField;
	
	/** 
	* ランダムにテキストが出てくるアニメーションが埋め込まれたテキストフィールドです。
	*/
	public class RandomText extends BaseTextField
	{
		private var _randSource:String = "_ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz1234567890";
		private var sourceLength:int = _randSource.length - 1;
		private var _mainString:String;
		private var mainlength:int;
		
		private var randomSpeed:int;
		private var replaceSpeed:int;
		
		private var replaceCount:int;
		private var replaceTimer:Timer;
		
		private var randomCount:int;
		private var randomTimer:Timer;
		
		
		/**
		* コンストラクタ
		* @param randomSpeed ランダムにテキストが出てくる間隔
		* @param replaceSpeed 目的のテキストが出てくる間隔
		*/
		public function RandomText(randomSpeed:int = 10, replaceSpeed:int = 10)
		{
			this.randomSpeed = randomSpeed;
			this.replaceSpeed = replaceSpeed;
			
			setTimer();
		}
		
		
		private function setTimer():void
		{
			randomTimer = new Timer(randomSpeed);
			
			replaceTimer = new Timer(replaceSpeed);
		}
		
		
		/** 
		* アニメーションのスタート。Event.COMPLETE で終が取れます。
		*/
		public function start():void 
		{
			randomTimer.addEventListener(TimerEvent.TIMER , onRandomTimer);
			
			if (replaceTimer.running)
			{
				replaceTimer.stop();
				replaceTimer.removeEventListener(TimerEvent.TIMER , onReplaceTimer);
			}
			
			randomCount = 0;
			
			randomTimer.start();
		}
		
		
		private function stop():void 
		{
			replaceTimer.addEventListener(TimerEvent.TIMER , onReplaceTimer);
			
			if (randomTimer.running) 
			{
				randomTimer.stop();
				randomTimer.removeEventListener(TimerEvent.TIMER , onRandomTimer);
			}
			
			replaceCount = 0;
			
			replaceTimer.start();
		}
		
		
		private function onRandomTimer(e:TimerEvent):void 
		{
			text = "";
			
			appendRandomText(randomCount);
			
			if (randomCount < mainlength) 
			{
				randomCount++
				
			}else
			{
				stop();
			}
		}
		
		
		private function onReplaceTimer(e:TimerEvent):void 
		{
			text = "";
			
			for (var i: int = 0; i < replaceCount; i++) 
			{
				appendText(_mainString.charAt(i));
			}
			
			appendRandomText(mainlength - replaceCount);
			
			if (replaceCount == mainlength) 
			{
				replaceTimer.stop();
				replaceTimer.removeEventListener(TimerEvent.TIMER , onReplaceTimer);
				
				dispatchEvent(new Event(Event.COMPLETE));
			}
			
			replaceCount++;
		}
		
		
		private function appendRandomText(n:int):void 
		{
			if (n > 0)
			{
				while (n--) 
				{
					appendText(_randSource.charAt(int(Math.random() * sourceLength)));
				}
			}
		}
		
		
		/** 
		* ランダムに表示されるテキスト。_ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz1234567890
		*/
		public function get randSource():String { return _randSource; }
		
		public function set randSource(value:String):void 
		{
			_randSource = value;
			
			sourceLength = _randSource.length - 1;
		}
		
		
		/** 
		* 最終的に表示させるテキスト。textプロパティに手動で代入。
		*/
		public function get mainString():String { return _mainString; }
		
		public function set mainString(value:String):void 
		{
			_mainString = value;
			
			mainlength = _mainString.length;
		}
		
	}

}