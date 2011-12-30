package info.dimensionMaker.controls
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.MouseEvent;
	
	import info.dimensionMaker.events.ScrollBarEvent;
	
	
	/** 
	* デザインを編集可能なスクロールバークラスです。サブクラスを生成して使用します。
	*/
	public class ScrollBar extends Sprite
	{
		private var yOffset:Number;
		private var yMin:Number = 0;
		private var yMax:Number;
		private var targetY:Number;
		
		private var s:Stage;
		private var content:DisplayObject;
		private var masker:DisplayObject;
		
		private var _thumb:Sprite;
		private var _thumbColor:uint = 0x666666;
		private var _thumbWidth:int = 5;
		private var _thumbHeight:int = 5;
		
		private var _track:Sprite;
		private var _trackColor:uint = 0xCCCCCC;
		private var _trackWidth:int = 5;
		private var _trackHeight:int = 15;
		
		
		/** 
		* コンストラクタ
		* @param s Stage インスタンス
		* @param content スクロールの対象
		* @param masker 対象をマスクする DisplayObject
		* @return void
		*/
		public function ScrollBar(s:Stage, content:DisplayObject, masker:DisplayObject):void
		{
			this.s = s;
			this.content = content;
			this.masker = masker;
			
			init();
		}
		
		
		private function init():void
		{
			_track = new Sprite();
			drawTrack();
			
			_thumb = new Sprite();
			drawThumb();
			
			_thumb.buttonMode = true;
			
			setMaxY();
			
			this.addChild(track);
			this.addChild(thumb);
			
			_thumb.addEventListener(MouseEvent.MOUSE_DOWN, thumbDown);
			_track.addEventListener(MouseEvent.CLICK , trackClic);
			s.addEventListener(MouseEvent.MOUSE_UP, thumbUp);
		}
		
		
		/** 
		* スクロールバーの背景を描画します。これをオーバーライドしてデザインを変更します。
		* @return void
		*/
		protected function drawTrack():void
		{
			// 最小値
			_trackWidth = int(Math.max(_trackWidth, 4));
			_trackHeight = int(Math.max(_trackHeight, 14));
			
			_track.graphics.clear();
			_track.graphics.beginFill(_trackColor);
			_track.graphics.drawRect(0, 0, _trackWidth, _trackHeight);
			_track.graphics.endFill();
		}
		
		
		/** 
		* スクロールバーのつまみを描画します。これをオーバーライドしてデザインを変更します。
		* @return void
		*/
		protected function drawThumb():void
		{
			// 最小値
			_thumbWidth = int(Math.max(_thumbWidth, 4));
			_thumbHeight = int(Math.max(_thumbHeight, 4));
			
			_thumb.graphics.clear();
			_thumb.graphics.beginFill(_thumbColor);
			_thumb.graphics.drawRect(0, 0, _thumbWidth, _thumbHeight);
			_thumb.graphics.endFill();
		}
		
		
		private function setMaxY():void
		{
			yMax = _trackHeight - _thumbHeight;
		}
		
		
		private function trackClic(e:MouseEvent):void 
		{
			targetY = e.localY - _thumb.height / 2;
			
			if (targetY <= yMin)
				targetY = yMin;
			if(targetY >= yMax)
				targetY = yMax;
			
			dispatchEvent(new ScrollBarEvent(ScrollBarEvent.VALUE_CHANGED_CLICK, - targetY / yMax * (content.height - masker.height), targetY));
			
			e.updateAfterEvent();
		}
		
		
		private function thumbDown(e:MouseEvent):void
		{
			s.addEventListener(MouseEvent.MOUSE_MOVE, thumbMove);
			yOffset = mouseY - _thumb.y;
		}
		
		
		private function thumbUp(e:MouseEvent):void
		{
			s.removeEventListener(MouseEvent.MOUSE_MOVE, thumbMove);
		}
		
		
		private function thumbMove(e:MouseEvent):void
		{
			_thumb.y = mouseY - yOffset;
			if(_thumb.y <= yMin)
				_thumb.y = yMin;
			if(_thumb.y >= yMax)
				_thumb.y = yMax;
			
			dispatchEvent(new ScrollBarEvent(ScrollBarEvent.VALUE_CHANGED, - _thumb.y / yMax * (content.height - masker.height), 0));
			
			e.updateAfterEvent();
		}
		
		
		/** 
		* 全イベントの削除
		* @return void
		*/
		public function removeEvent():void 
		{
			_thumb.removeEventListener(MouseEvent.MOUSE_DOWN, thumbDown);
			_track.removeEventListener(MouseEvent.CLICK , trackClic);
			s.removeEventListener(MouseEvent.MOUSE_UP, thumbUp);
		}
		
		
		/** 
		* つまみのカラー
		* @default 0x666666
		*/
		public function get thumbColor():uint { return _thumbColor; }
		
		public function set thumbColor(value:uint):void 
		{
			_thumbColor = value;
			
			drawThumb();
		}
		
		/** 
		* つまみの幅
		* @default 5
		*/
		public function get thumbWidth():int { return _thumbWidth; }
		
		public function set thumbWidth(value:int):void 
		{
			_thumbWidth = value;
			
			drawThumb();
		}
		
		/** 
		* つまみの高さ
		* @default 5
		*/
		public function get thumbHeight():int { return _thumbHeight; }
		
		public function set thumbHeight(value:int):void 
		{
			_thumbHeight = value;
			
			drawThumb();
			setMaxY();
		}
		
		/** 
		* 背景のカラー
		* @default 0xCCCCCC
		*/
		public function get trackColor():uint { return _trackColor; }
		
		public function set trackColor(value:uint):void 
		{
			_trackColor = value;
			
			drawTrack();
		}
		
		/** 
		* 背景の幅
		* @default 5
		*/
		public function get trackWidth():int { return _trackWidth; }
		
		public function set trackWidth(value:int):void 
		{
			_trackWidth = value;
			
			drawTrack();
		}
		
		/** 
		* 背景の高さ
		* @default 15
		*/
		public function get trackHeight():int { return _trackHeight; }
		
		public function set trackHeight(value:int):void 
		{
			_trackHeight = value;
			
			drawTrack();
			setMaxY();
		}
		
		/** 
		* つまみのコンテナ。drawThumb メソッドをオーバーライドした場合、このコンテナを使用する。
		*/
		public function get thumb():Sprite { return _thumb; }
		
		public function set thumb(value:Sprite):void 
		{
			_thumb = value;
		}
		
		/** 
		* 背景のコンテナ。drawTrack メソッドをオーバーライドした場合、このコンテナを使用する。
		*/
		public function get track():Sprite { return _track; }
		
		public function set track(value:Sprite):void 
		{
			_track = value;
		}
		
	}
	
}
