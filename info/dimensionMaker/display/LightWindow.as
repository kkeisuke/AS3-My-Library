package info.dimensionMaker.display 
{
	import flash.desktop.NativeApplication;
	import flash.display.DisplayObject;
	import flash.display.NativeWindow;
	import flash.display.NativeWindowInitOptions;
	import flash.display.NativeWindowSystemChrome;
	import flash.display.NativeWindowType;
	import flash.display.Stage;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.ui.Mouse;
	import flash.ui.MouseCursor;
	
	
	/**
	 * タスクバー無しの透明な NativeWindow
	 */
	public class LightWindow extends NativeWindow
	{
		private var name:String;
		private var windowState:String;
		private var s:Stage;
		private var isKeepBound:Boolean;
		private var isFront:Boolean;
		private var prefsXML:XML;
		
		
		/** 
		* コンストラクタ
		* @param name ウインドウの名前
		* @param s ステージ
		* @param isKeepBound アプリケーションが終了した時にウィンドウの位置を覚えておくかどうか。
		* @param isFront 起動時に最前面に置かれるかどうか。
		* @param initOptions オプション
		*/
		public function LightWindow(name:String, s:Stage, isKeepBound:Boolean = true, isFront:Boolean = true, initOptions:NativeWindowInitOptions = null) 
		{
			this.name = name;
			this.windowState = name + "WindowState";
			this.s = s;
			this.isFront = isFront;
			this.isKeepBound = isKeepBound;
			
			if (initOptions == null) 
			{
				initOptions = new NativeWindowInitOptions();
			}
			
			// ウインドウの側とステージを透明にするか
			// NativeWindowType.lightweight のとき、NativeWindowSystemChrome.NONE にする。
			initOptions.systemChrome = NativeWindowSystemChrome.NONE;
			// UTILITY , lightweight にするとタスクバーが出なくなる。
			initOptions.type = NativeWindowType.LIGHTWEIGHT;
			// 基本的には透過
			initOptions.transparent = true;
			
			super(initOptions);
			
			init();
		}
		
		
		private function init():void
		{
			visible = true;
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.stageWidth = s.stageWidth;
			stage.stageHeight = s.stageHeight;
			alwaysInFront = isFront;
			
			if (!isFront) 
			{
				orderToBack();
			}
			
			if (isKeepBound) 
			{
				readBoundFile();
				NativeApplication.nativeApplication.addEventListener(Event.EXITING, writeBoundFile);
			}
		}
		
		
		private function readBoundFile():void
		{
			prefsXML = AirDocument.readPrefsXML();
			
			if (prefsXML != null)
			{
				var state:XMLList = prefsXML[windowState];
				if (state != null) 
				{
					this.bounds = new Rectangle(state.@x, state.@y, state.@width, state.@height);
				}
			}
		}
		
		
		private function writeBoundFile(e:Event):void 
		{
			if (prefsXML != null)
			{
				prefsXML[windowState].@x = this.x;
				prefsXML[windowState].@y = this.y;
				prefsXML[windowState].@width = this.width;
				prefsXML[windowState].@height = this.height;
				
				AirDocument.writePrefsXML(prefsXML);
			}
		}
		
		
		/** 
		* DisplayObject をウインドウに置く。ドラッグも設定。
		* @param content コンテンツ
		* @return void
		*/
		public function setContent(content:DisplayObject):void
		{
			stage.addChild(content);
			
			stage.addEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
		}
		
		
		// コンテンツのドラッグでウインドウをドラッグ
		private function mouseDown(e:MouseEvent):void 
		{
			stage.addEventListener(MouseEvent.MOUSE_UP, mouseUp);
			
			Mouse.cursor = MouseCursor.HAND;
			
			// MouseEvent.MOUSE_UP を受け取らなくても勝手に終わる。
			// ウインドウの移動
			startMove();
		}
		
		
		private function mouseUp(e:MouseEvent):void 
		{
			stage.removeEventListener(MouseEvent.MOUSE_UP, mouseUp);
			
			Mouse.cursor = MouseCursor.AUTO;
		}
		
	}

}