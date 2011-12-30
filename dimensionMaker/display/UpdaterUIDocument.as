package info.dimensionMaker.display 
{
	import air.update.ApplicationUpdaterUI;
	import air.update.events.UpdateEvent;
	import flash.events.ErrorEvent;
	
	
	/**
	 * Adobe が作ったアラートパネル ApplicationUpdaterUI を内蔵した AirDocument クラス。サブクラスを作って使う。
	 */
	public class UpdaterUIDocument extends AirDocument
	{
		private var _updateUI:ApplicationUpdaterUI;
		
		
		/** 
		* コンストラクタ
		*/
		public function UpdaterUIDocument() 
		{
			super();
		}
		
		
		/** 
		* ApplicationUpdaterUI を準備する
		* @param xmlPath バージョン管理される XML への相対パス
		* @param delay アップデートを確認する間隔 1/日 0.041667 = 1時間
		* @return void
		*/
		public function setApplicationUpdaterUI(xmlPath:String, delay:Number = 0.041667):void 
		{
			if (xmlPath != null) 
			{
				_updateUI = new ApplicationUpdaterUI();
				_updateUI.updateURL = xmlPath;
				_updateUI.delay = delay;
				_updateUI.isCheckForUpdateVisible = false;
				_updateUI.isDownloadProgressVisible = true;
				_updateUI.isDownloadUpdateVisible = true;
				_updateUI.isInstallUpdateVisible = true;
				_updateUI.addEventListener(ErrorEvent.ERROR, error);
				_updateUI.addEventListener(UpdateEvent.INITIALIZED, updated);
				_updateUI.initialize();
			}
		}
		
		
		/** 
		* 初期化中または更新処理中にエラーが発生した場合
		* @param e エラーイベント
		* @return void
		*/
		protected function error(e:ErrorEvent):void 
		{
			
		}
		
		
		/** 
		* 初期化が完了した場合
		* @param e アップデートイベント
		* @return void
		*/
		protected function updated(e:UpdateEvent):void
		{
			// 起動時にまずチェックする。
			_updateUI.checkNow();
		}
		
		
		/** 
		* Adobe 標準のアップデータUI
		*/
		public function get updateUI():ApplicationUpdaterUI { return _updateUI; }
		
		public function set updateUI(value:ApplicationUpdaterUI):void 
		{
			_updateUI = value;
		}
		
	}

}