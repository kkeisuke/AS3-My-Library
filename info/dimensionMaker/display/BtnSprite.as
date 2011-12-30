package info.dimensionMaker.display
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	
	/** 
	* ボタン機能を持ったコンテナクラス。サブクラスを生成して使用します。
	*/
	public class BtnSprite extends Sprite
	{
		
		
		/** 
		* コンストラクタ
		*/
		public function BtnSprite() 
		{
			init();
		}
		
		
		private function init():void
		{
			// マウスイベントの target をこのオブジェクトにするために、子のマウスを向こうにする。
			mouseChildren = false;
			
			this.addEventListener(Event.ADDED_TO_STAGE , _added);
			addMouseEvent();
		}
		
		
		private function _added(e:Event):void 
		{
			this.removeEventListener(Event.ADDED_TO_STAGE , _added);
			this.addEventListener(Event.REMOVED_FROM_STAGE , _removed);
			
			added();
		}
		
		
		/** 
		* Event.ADDED_TO_STAGE で実行されるメソッド
		*/
		protected function added():void
		{
			
		}
		
		
		private function _removed(e:Event):void 
		{
			this.removeEventListener(Event.REMOVED_FROM_STAGE , _removed);
			this.addEventListener(Event.ADDED_TO_STAGE , _added);
			
			removed();
		}
		
		
		/** 
		* Event.REMOVED_FROM_STAGE で実行されるメソッド
		*/
		protected function removed():void
		{
			
		}
		
		
		/** 
		* 全イベントリスナーの削除と、addedメソッドの無効化。インスタンスを破棄するときに使用する。
		* @param 
		* @return void
		*/
		public function deleteInstance():void 
		{
			this.removeEventListener(Event.ADDED_TO_STAGE , added);
			removeMouseEvent();
		}
		
		
		/** 
		* 全イベントリスナーの追加
		* @param 
		* @return void
		*/
		public function addMouseEvent():void 
		{
			this.buttonMode = true;
			this.addEventListener(MouseEvent.ROLL_OVER , rollOver);
			this.addEventListener(MouseEvent.MOUSE_OVER , mouseOver);
			this.addEventListener(MouseEvent.ROLL_OUT , rollOut);
			this.addEventListener(MouseEvent.MOUSE_OUT , mouseOut);
			this.addEventListener(MouseEvent.CLICK, click);
		}
		
		
		/** 
		* 全イベントリスナーの削除
		* @param 
		* @return void
		*/
		public function removeMouseEvent():void 
		{
			this.buttonMode = false;
			this.removeEventListener(MouseEvent.ROLL_OVER , rollOver);
			this.removeEventListener(MouseEvent.MOUSE_OVER , mouseOver);
			this.removeEventListener(MouseEvent.ROLL_OUT , rollOut);
			this.removeEventListener(MouseEvent.MOUSE_OUT , mouseOut);
			this.removeEventListener(MouseEvent.CLICK , click);
		}
		
		
		/** 
		* MouseEvent.ROLL_OVER で実行されるメソッド
		*/
		protected function rollOver(e:MouseEvent):void 
		{
			
		}
		
		
		/** 
		* MouseEvent.ROLL_OUT で実行されるメソッド
		*/
		protected function rollOut(e:MouseEvent):void 
		{
			
		}
		
		
		/** 
		* MouseEvent.MOUSE_OVER で実行されるメソッド
		*/
		protected function mouseOver(e:MouseEvent):void 
		{
			
		}
		
		
		/** 
		* MouseEvent.MOUSE_OUT で実行されるメソッド
		*/
		protected function mouseOut(e:MouseEvent):void 
		{
			
		}
		
		
		/** 
		* MouseEvent.CLICK で実行されるメソッド
		*/
		protected function click(e:MouseEvent):void
		{
			
		}
		
	}
	
}