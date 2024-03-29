﻿package info.dimensionMaker.events
{
	import flash.events.Event;
	
	
	/** 
	* スクロールバーのカスタムイベントクラス。
	*/
	public class ScrollBarEvent extends Event
	{
		
		
		/** 
		* つまみのドラッグ イベントオブジェクトの type プロパティの値を定義します。
		*/
		public static const VALUE_CHANGED:String = "valueChanged";
		
		
		/** 
		* 背景のクリック イベントオブジェクトの type プロパティの値を定義します。
		*/
		public static const VALUE_CHANGED_CLICK:String = "valueChangedCLICK";
		
		
		/** 
		* ドラッグしたときの、コンテンツの移動量
		*/
		public var scrollY:Number;
		
		
		/** 
		* 背景をクリックしたときのY座標。つまみの目標点
		*/
		public var targetY:Number;
		
		
		/** 
		* コンストラクタ
		*/
		public function ScrollBarEvent(type:String, sy:Number, ty:Number):void
		{
			super(type);
			scrollY = sy;
			targetY = ty
		}
		
	}
	
}
