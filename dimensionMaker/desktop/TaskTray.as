package info.dimensionMaker.desktop 
{
	import flash.desktop.DockIcon;
	import flash.desktop.NativeApplication;
	import flash.desktop.SystemTrayIcon;
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.NativeMenu;
	import flash.display.NativeWindow;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.InvokeEvent;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	
	
	/**
	 * タスクトレイ・ドックアイコン設定クラス。サブクラスを作って使う。
	 */
	public class TaskTray extends EventDispatcher
	{
		private var winIcon:String;
		private var macIcon:String;
		private var windows:/*NativeWindow*/Array;
		
		
		/** 
		* コンストラクタ
		* @param winIcon Win 用のアイコン画像のパス。 null の場合アイコンは設定されない。
		* @param macIcon Mac 用のアイコン画像のパス。 null の場合アイコンは設定されない。
		* @param target イベントターゲット
		*/
		public function TaskTray(winIcon:String, macIcon:String, windows:/*NativeWindow*/Array, target:IEventDispatcher = null) 
		{
			super(target);
			
			this.winIcon = winIcon;
			this.macIcon = macIcon;
			this.windows = windows;
			
			init();
		}
		
		
		private function init():void
		{
			var iconLoader:Loader = new Loader();
			
			//システムトレイアイコンをサポートしているか
			if (NativeApplication.supportsSystemTrayIcon)  // Windows の場合
			{
				if (winIcon != null) 
				{
					iconLoader.load(new URLRequest(winIcon));
					iconLoader.contentLoaderInfo.addEventListener(Event.COMPLETE , winIconLoaded);
				}
				
			}else if (NativeApplication.supportsDockIcon)  // Mac の場合
			{
				if (macIcon != null) 
				{
					iconLoader.load(new URLRequest(macIcon));
					iconLoader.contentLoaderInfo.addEventListener(Event.COMPLETE , macIconLoaded);
				}
			}
		}
		
		
		// Windows の場合 画像読み込み完了
		private function winIconLoaded(e:Event):void 
		{
			setIconBitmap(e);
			
			// システムトレイアイコンに関連付ける
			var taskTrayIcon:SystemTrayIcon = NativeApplication.nativeApplication.icon as SystemTrayIcon;
			
			setWinMenu(taskTrayIcon, new NativeMenu());
		}
		
		
		// Mac の場合 画像読み込み完了
		private function macIconLoaded(e:Event):void 
		{
			setIconBitmap(e);
			
			// ドックアイコンに関連付ける
			var dockIcon:DockIcon = NativeApplication.nativeApplication.icon as DockIcon;
			
			setMacMenu(dockIcon, new NativeMenu());
		}
		
		
		// WIN MAC 共通処理
		private function setIconBitmap(e:Event):void 
		{
			var iconBitmap:Bitmap = e.target.content as Bitmap;
			
			// なぜか配列
			NativeApplication.nativeApplication.icon.bitmaps = [iconBitmap.bitmapData];
		}
		
		
		/** 
		* Win の場合にオーバーライドしてメニューの設定をする。
		* @param icon タスクトレイアイコン
		* @param menu アイコンのメニュー
		* @return void
		*/
		protected function setWinMenu(icon:SystemTrayIcon, menu:NativeMenu):void {
			
			if (menu.numItems > 0)
			{
				icon.menu = menu;
			}
			
			icon.addEventListener(MouseEvent.MOUSE_DOWN , orderTo);
			
			// ロード完了を通知
			dispatchEvent(new Event(Event.COMPLETE));
		}
		
		
		/** 
		* Mac の場合にオーバーライドしてメニューの設定をする。
		* @param icon ドックアイコン
		* @param menu アイコンのメニュー
		* @return void
		*/
		protected function setMacMenu(icon:DockIcon, menu:NativeMenu):void {
			
			if (menu.numItems > 0)
			{
				icon.menu = menu;
			}
			
			orderTo(null);
			NativeApplication.nativeApplication.addEventListener(InvokeEvent.INVOKE , orderTo);
			
			// ロード完了を通知
			dispatchEvent(new Event(Event.COMPLETE));
		}
		
		
		private function orderTo(e:Event):void 
		{
			//var windows:/*NativeWindow*/Array = NativeApplication.nativeApplication.openedWindows;
			
			var n:int = windows.length;
			for (var i: int = 0; i < n; i++) 
			{
				if (windows[i].alwaysInFront) 
				{
					windows[i].alwaysInFront = false;
					windows[i].orderToBack();
					
				}else 
				{
					windows[i].alwaysInFront = true;
				}
			}
		}
		
		
		/** 
		* このタスクトレイ・ドックアイコンが管理する NativeWindow を追加する。
		* @param w NativeWindow
		* @return void
		*/
		public function setWindow(w:NativeWindow):void 
		{
			windows[windows.length] = w;
		}
		
		
		/** 
		* このタスクトレイ・ドックアイコンが管理する NativeWindow の配列を得る。
		* @return Array
		*/
		public function getWindows():/*NativeWindow*/Array 
		{
			return windows;
		}
		
	}

}