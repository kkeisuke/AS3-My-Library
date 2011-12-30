package info.dimensionMaker.managers 
{
	import flash.display.DisplayObject;
	import flash.events.DataEvent;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	
	/**
	 * PC の時計を元にした時刻管理クラス。View を渡せばアナログ時計にしてくれる。要 EnterFrameManager。
	 */
	public class ClockManager extends EventDispatcher
	{
		static public const SECOND:String = "second";
		static public const MINUTE:String = "minute";
		static public const HOUR:String = "hour"
		
		private var sView:DisplayObject;
		private var mView:DisplayObject;
		private var hView:DisplayObject;
		
		private var preSecond:int;
		private var preMinute:int;
		private var preHour:int;
		
		private var date:Date;
		private var _gmt:int;
		
		private var _isMillisecond:Boolean;
		
		
		/** 
		* コンストラクタ
		* @param sView 秒針
		* @param mView 分針
		* @param hView 時針
		* @param target IEventDispatcher
		*/
		public function ClockManager(sView:DisplayObject = null, mView:DisplayObject = null, hView:DisplayObject = null, target:IEventDispatcher = null) 
		{
			this.sView = sView;
			this.mView = mView;
			this.hView = hView;
			
			super(target);
			
			init();
		}
		
		
		private function init():void
		{
			date = new Date();
			_gmt = - (date.getTimezoneOffset() / 60);
			_isMillisecond = false;
			
			EnterFrameManager.init();
		}
		
		
		private function enterFrameHandler():void
		{
			// 秒・分・時の取得
			date = new Date();
			var second:int = date.getUTCSeconds();
			var minute:int = date.getUTCMinutes();
			var hour:int;
			if (gmt>=0) 
			{
				hour = ((date.getUTCHours() + gmt) % 24) % 12;
			}
			else 
			{
				hour = ((24 + (date.getUTCHours() + gmt)) % 24) % 12;
			}
			
			// (ミリ)秒
			if (_isMillisecond) 
			{
				var millisecond:int = date.getUTCMilliseconds();
				sView.rotation = (second + (millisecond * 0.001)) * 6;
			}
			
			// 秒・分の切り替えと秒の更新
			if (second != preSecond) 
			{
				if (!_isMillisecond) 
				{
					sView.rotation = second * 6;
				}
				
				mView.rotation = (minute + (second / 60)) * 6;
				dispatchEvent(new DataEvent(ClockManager.SECOND, false, false, String(second)));
			}
			preSecond = second;
			
			// 時間の切り替えと分の更新
			if (minute != preMinute) 
			{
				hView.rotation = (hour + (minute / 60)) * 30;
				dispatchEvent(new DataEvent(ClockManager.MINUTE, false, false, String(minute)));
			}
			preMinute = minute;
			
			// 時間の更新
			if (hour != preHour) 
			{
				dispatchEvent(new DataEvent(ClockManager.HOUR, false, false, String(hour)));
			}
			preHour = hour
		}
		
		
		/** 
		* 時計のスタート
		* @return void
		*/
		public function start():void 
		{
			EnterFrameManager.addMethod(enterFrameHandler);
			EnterFrameManager.start();
		}
		
		
		/** 
		* 時計のストップ
		* @param stopEnterFrame EnterFrame も止めるかどうか
		* @return void
		*/
		public function stop(stopEnterFrame:Boolean):void 
		{
			EnterFrameManager.removeMethod(enterFrameHandler);
			
			if (stopEnterFrame) 
			{
				EnterFrameManager.stop();
			}
		}
		
		
		/** 
		* GMTを取得、設定可能。通常は PC による。
		*/
		public function get gmt():int { return _gmt; }
		
		public function set gmt(value:int):void 
		{
			_gmt = value;
		}
		
		
		/** 
		* 秒針の動きにミリ秒を反映させるかどうか。
		*/
		public function get isMillisecond():Boolean { return _isMillisecond; }
		
		public function set isMillisecond(value:Boolean):void 
		{
			_isMillisecond = value;
		}
		
	}

}