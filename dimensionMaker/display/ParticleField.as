package info.dimensionMaker.display 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import info.dimensionMaker.geom.Particle;
	
	
	/** 
	* パーティクルを描画する土台
	*/
	public class ParticleField extends Sprite
	{
		private var _canvas:BitmapData;
		
		private var w:int;
		private var h:int;
		private var _bgColor:uint;
		
		
		/** 
		* コンストラクタ
		* @param w 幅
		* @param h 高さ
		* @param _bgColor 背景色
		*/
		public function ParticleField(w:int, h:int, _bgColor:uint)
		{
			this.w = w;
			this.h = h;
			this._bgColor = bgColor;
			
			init();
			
			this.addEventListener(Event.ADDED_TO_STAGE , setStage);
		}
		
		
		private function setStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, setStage);
			
			// パーティクルクラスの初期化
			Particle.init(stage);
		}
		
		
		private function init():void
		{
			canvas = new BitmapData(w, h, true, _bgColor);
			var canvasBitMap:Bitmap = new Bitmap(canvas);
			canvasBitMap.smoothing = true;
			this.addChild(canvasBitMap);
		}
		
		
		/** 
		* パーティクルを描画している BitmapData
		*/
		public function get canvas():BitmapData { return _canvas; }
		
		public function set canvas(value:BitmapData):void 
		{
			_canvas = value;
		}
		
		/** 
		* 背景色
		*/
		public function get bgColor():uint { return _bgColor; }
		
	}

}