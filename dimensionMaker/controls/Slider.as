package info.dimensionMaker.controls 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import info.dimensionMaker.geom.DragArea;
	
	
	/** 
	* シークバーにも使える汎用的なスライダー
	*/
	public class Slider extends Sprite
	{
		private var w:int;
		private var h:int;
		private var _thumbColor:uint = 0x999999;
		private var _trackColor:uint = 0x666666;
		
		private var _thumb:Sprite;
		private var _track:Sprite;
		
		private var dragArea:Rectangle;
		private var flgHV:Boolean;
		
		private var min:Number = 0;
		private var max:Number = 1;
		private var interval:Number = 0.1;
		private var graduation:int = int((max - min) / interval);
		
		private var _value:Number = 0;
		
		
		/** 
		* コンストラクタ
		* @param w 幅
		* @param h 高さ
		*/
		public function Slider(w:int, h:int)
		{
			this.w = w;
			this.h = h;
			this._thumbColor = _thumbColor;
			this._trackColor = _trackColor;
			
			init();
		}
		
		
		private function init():void
		{
			_track = new Sprite();
			drawTrack();
			this.addChild(_track);
			
			_thumb = new Sprite();
			_thumb.buttonMode = true;
			drawThumb();
			this.addChild(_thumb);
			
			setFlgHV();
			
			dragArea = DragArea.getRectAngle(_thumb, _track);
			
			_thumb.addEventListener(MouseEvent.MOUSE_DOWN, downThumb);
		}
		
		
		/** 
		* スライダーの各種パラメーターを設定します。
		* @param min 最小値
		* @param max 最大値
		* @param interval 変化量
		* @param _value 初期値
		*/
		public function setParams(min:Number, max:Number, interval:Number, _value:Number):void
		{
			this.min = min;
			this.max = max;
			this.interval = interval;
			this._value = _value;
			
			graduation = int((max - min) / interval);
			
			setThumb();
		}
		
		
		private function drawTrack():void
		{
			_track.graphics.clear();
			_track.graphics.beginFill(_trackColor);
			_track.graphics.drawRect(0, 0, w, h);
			_track.graphics.endFill();
		}
		
		
		private function drawThumb():void
		{
			var side:int = w < h ? w : h;
			
			_thumb.graphics.clear();
			_thumb.graphics.beginFill(_thumbColor);
			_thumb.graphics.drawRect(0, 0, side, side);
			_thumb.graphics.endFill();
		}
		
		
		private function setFlgHV():void 
		{
			if (_track.width > _track.height)
			{
				flgHV = true;
				
			}else 
			{
				flgHV = false;
			}
		}
		
		
		private function setThumb():void 
		{
			var absMin:Number = min < 0 ? -min : min;
			
			if (flgHV) 
			{
				_thumb.x = (absMin + value) / (max - min) * dragArea.width;
				
			}else 
			{
				_thumb.y = (absMin + value) / (max - min) * dragArea.height;
			}
		}
		
		
		private function downThumb(e:MouseEvent):void 
		{
			_thumb.startDrag(false, dragArea);
			
			stage.addEventListener(MouseEvent.MOUSE_UP , upThumb);
			stage.addEventListener(MouseEvent.MOUSE_MOVE , slide);
		}
		
		
		private function slide(e:MouseEvent):void 
		{
			if (flgHV) 
			{
				_value = min + (int(_thumb.x / dragArea.width * graduation) * interval);
				
			}else 
			{
				_value = min + (int(_thumb.y / dragArea.height * graduation) * interval);
			}
			
			dispatchEvent(new Event(Event.CHANGE));
			
			if (_value == max) 
			{
				dispatchEvent(new Event(Event.COMPLETE));
			}
		}
		
		
		private function upThumb(e:MouseEvent):void 
		{
			stage.removeEventListener(MouseEvent.MOUSE_UP , upThumb);
			stage.removeEventListener(MouseEvent.MOUSE_MOVE , slide);
			
			_thumb.stopDrag();
		}
		
		
		/** 
		* スライダーの土台
		*/
		public function get track():Sprite { return _track; }
		
		public function set track(value:Sprite):void 
		{
			this.addChildAt(value, this.getChildIndex(track));
			this.removeChild(_track);
			
			_track = value;
			
			dragArea = DragArea.getRectAngle(_thumb, _track);
			
			setFlgHV();
		}
		
		/** 
		* スライダーのつまみ
		*/
		public function get thumb():Sprite { return _thumb; }
		
		public function set thumb(value:Sprite):void 
		{
			this.addChildAt(value, this.getChildIndex(_thumb));
			this.removeChild(_thumb);
			
			_thumb = value;
			
			dragArea = DragArea.getRectAngle(_thumb, _track);
			
			_thumb.buttonMode = true;
			_thumb.addEventListener(MouseEvent.MOUSE_DOWN, downThumb);
		}
		
		/** 
		* つまみの色
		*/
		public function get thumbColor():uint { return _thumbColor; }
		
		public function set thumbColor(value:uint):void 
		{
			_thumbColor = value;
			
			drawThumb();
		}
		
		/** 
		* 土台の色
		*/
		public function get trackColor():uint { return _trackColor; }
		
		public function set trackColor(value:uint):void 
		{
			_trackColor = value;
			
			drawTrack();
		}
		
		/** 
		* スライダーの値
		*/
		public function get value():Number { return _value; }
		
		public function set value(value:Number):void 
		{
			_value = value;
			
			setThumb();
			slide(null);
		}
		
	}

}