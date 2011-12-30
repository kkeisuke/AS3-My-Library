package info.dimensionMaker.display 
{
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.Timer;
	
	/** 
	* lightBox で使われているようなローディング用のイメージ。
	*/
	public class LoadingSprite01 extends Sprite
	{
		private var color:uint;
		private var size:int;
		private var speed:Number;
		
		private var n:int = 12;
		private var nn:int = n - 1;
		private var rad:Number = 2 * Math.PI / n;
		private var deg:Number = 360 / n;
		
		private var radius:Number;
		private var barX:Number;
		private var barY:Number;
		private var barW:Number;
		private var barH:int;
		private var barE:Number;
		
		private var shapeArr:/*Shape*/Array = [];
		private var point:Point;
		
		private var timer:Timer;
		
		
		/** 
		* コンストラクタ
		* @param color バーの色
		* @param size バーのサイズ(長さ) 幅はこの4分の1
		* @param speed 回転スピード(小さいと早い)
		*/
		public function LoadingSprite01(color:uint, size:int = 5, speed:Number = 40)
		{
			this.color = color;
			this.size = size;
			this.speed = speed;
			
			init();
		}
		
		
		private function init():void
		{
			radius = size * 1.3;
			barX = -(size / 4) / 2;
			barY = -(size / 1.5) / 2;
			barW = size / 4;
			barH = size;
			barE = size / 3;
			
			sets();
		}
		
		
		private function rote(e:TimerEvent):void 
		{
			if(this.rotation >= 360)
			{
				this.rotation = 0
			}
			
			this.rotation += deg;
			e.updateAfterEvent();
		}
		
		
		/** 
		* 回転の開始
		* @return void
		*/
		public function start():void 
		{
			if (timer == null)
			{
				timer = new Timer(speed, 0);
			}
			timer.addEventListener(TimerEvent.TIMER, rote);
			timer.start();
		}
		
		
		/** 
		* 回転の停止
		* @return void
		*/
		public function stop():void 
		{
			if (timer) 
			{
				timer.stop();
				timer.removeEventListener(TimerEvent.TIMER, rote);
			}
		}
		
		
		/** 
		* バーの設置
		* @return void
		*/
		public function sets():void 
		{
			if (shapeArr.length == 0)
			{
				for (var i: int = 0; i < n; i++) 
				{
					var shape:Shape = new Shape();
					shape.graphics.beginFill(color, i / nn + 0.2);
					shape.graphics.drawRoundRect(barX,barY,barW,barH,barE);
					shape.graphics.endFill();
					
					point = Point.polar(radius, rad * i);
					shape.x = point.x;
					shape.y = point.y;
					shape.rotation = (deg * i) + 90;
					
					shapeArr[i] = shape;
					
					this.addChild(shapeArr[i]);
					
					shape = null;
				}
			}
		}
		
		
		/** 
		* すべてのオブジェクトの破棄
		* @return void
		*/
		public function resets():void 
		{
			timer = null;
			var n:int = shapeArr.length;
			for (var i: int = 0; i < n; i++) 
			{
				this.removeChild(shapeArr[i]);
			}
			shapeArr.length = 0;
		}
		
	}

}