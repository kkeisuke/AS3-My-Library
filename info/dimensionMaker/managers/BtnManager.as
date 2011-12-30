package info.dimensionMaker.managers 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	
	/** 
	* 登録した Sprite の mouseEnabled, buttonMode を制御します
	*/
	public class BtnManager extends EventDispatcher
	{
		private var name:String;
		private var btns:/*Sprite*/Array;
		private var btnGroup:/*Sprite*/Array;
		private var _current:Sprite;
		
		static private var managers:Object = { };
		
		
		/** 
		* コンストラクタ
		* @param name マネージャーの名前
		* @param btns 管理したい Sprite グループ
		*/
		public function BtnManager(name:String, ...btns:/*Sprite*/Array)
		{
			this.name = name;
			this.btns = btns;
			
			init();
		}
		
		
		private function init():void
		{
			var n:int = btns.length;
			for (var i: int = 0; i < n; i++) 
			{
				setGroup(btns[i]);
			}
			
			BtnManager.managers[name] = this;
		}
		
		
		/** 
		* マネージャーに Sprite を登録します。
		* @param btn 管理したい Sprite
		*/
		public function setGroup(btn:Sprite):void 
		{
			btnGroup[btnGroup.length] = btn;
		}
		
		
		/** 
		* current Sprite だけ変更
		* @param enable mouseEnabled,buttonMode 値
		*/
		public function currentEnable(enable:Boolean):void
		{
			_current.mouseEnabled = enable;
			_current.buttonMode = enable;
			
			dispatchEvent(new Event(Event.CHANGE));
		}
		
		
		/** 
		* other Sprite だけ変更
		* @param enable mouseEnabled,buttonMode 値
		*/
		public function otherEnable(enable:Boolean):void 
		{
			var n:int = btnGroup.length;
			for (var i: int = 0; i < n; i++) 
			{
				if (btnGroup[i] != _current) 
				{
					btnGroup[i].mouseEnabled = enable;
					btnGroup[i].buttonMode = enable;
				}
			}
			
			dispatchEvent(new Event(Event.CHANGE));
		}
		
		
		/** 
		* current,other 別々に変更
		* @param currentEnable current の mouseEnabled,buttonMode 値
		*/
		public function allEnable(currentEnable:Boolean):void
		{
			_current.mouseEnabled = currentEnable;
			_current.buttonMode = currentEnable;
			
			var n:int = btnGroup.length;
			for (var i: int = 0; i < n; i++) 
			{
				if (btnGroup[i] != _current) 
				{
					btnGroup[i].mouseEnabled = !currentEnable;
					btnGroup[i].buttonMode = !currentEnable;
				}
			}
			
			dispatchEvent(new Event(Event.CHANGE));
		}
		
		
		/** 
		* current,other 同じ値に変更し、current を破棄
		* @param enable mouseEnabled,buttonMode 値
		*/
		public function allSameEnable(enable:Boolean):void 
		{
			var n:int = btnGroup.length;
			for (var i: int = 0; i < n; i++) 
			{
				btnGroup[i].mouseEnabled = enable;
				btnGroup[i].buttonMode = enable;
			}
			
			_current = null;
			
			dispatchEvent(new Event(Event.CHANGE));
		}
		
		
		/** 
		* 名前から BtnManager インスタンスを取得します。
		* @param name BtnManager インスタンスの名前
		*/
		static public function getBtnManager(name:String):BtnManager 
		{
			return BtnManager.managers[name];
		}
		
		
		/** 
		* current に指定した Sprite
		*/
		public function get current():Sprite { return _current; }
		
		public function set current(value:Sprite):void 
		{
			_current = value;
		}
		
	}

}