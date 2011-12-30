package info.dimensionMaker.utils 
{
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	
	/** 
	* 途中で速度の切り替えが出来る Timer クラス。
	*/
	public class AccelTimer extends Timer
	{
		private var accel:Number;
		private var _delay:Number;
		private var _repeatCount:int;
		
		
		/** 
		* コンストラクタ
		* @param accel 出だしのスピード
		* @param _delay 加速後のスピード
		* @param _repeatCount 加速するまでの回数
		*/
		public function AccelTimer(accel:Number, _delay:Number, _repeatCount:int = 0)
		{
			this.accel = accel;
			this._delay = _delay;
			this._repeatCount = _repeatCount;
			
			
			super(accel, _repeatCount);
			this.addEventListener(TimerEvent.TIMER_COMPLETE, plusSpeedUp);
		}
		
		
		private function plusSpeedUp(e:TimerEvent):void 
		{
			this.removeEventListener(TimerEvent.TIMER_COMPLETE, plusSpeedUp);
			this.reset();
			this.repeatCount = 0;
			this.delay = _delay;
			this.start();
		}
		
		
		/** 
		* 最初からスタート
		* @return void
		*/
		public function restart():void 
		{
			this.reset();
			this.delay = accel
			this.repeatCount = _repeatCount;
			this.addEventListener(TimerEvent.TIMER_COMPLETE, plusSpeedUp);
			this.start();
		}
		
	}

}