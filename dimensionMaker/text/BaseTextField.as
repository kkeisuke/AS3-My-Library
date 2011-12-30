package info.dimensionMaker.text 
{
	import flash.display.BlendMode;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	
	/** 
	* TextField クラスを直感的に使えるようにしたクラス。
	*/
	public class BaseTextField extends TextField
	{
		// TextFormat
		private var _format:TextFormat;
		private var _font:String;
		private var _size:Number;
		private var _color:uint;
		private var _bold:Boolean;
		private var _align:String;
		private var _leading:Number;
		private var _letterSpacing:Number;
		
		
		public function BaseTextField()
		{
			
		}
		
		
		/** 
		* フォーマットの初期化
		* @param font フォント
		* @param size フォントサイズ
		* @param color カラー
		* @param bold ボールドにするか
		* @param align 整列
		* @param leading 行間
		* @param letterSpacing 文字間
		* @return void
		*/
		public function initFormat(font:String = "_sans", size:Number = 12, color:uint = 0x000000, bold:Boolean = false, align:String = "left", leading:Number = 0, letterSpacing:Number = 0):void
		{
			this._font = font;
			this._size = size;
			this._color = color;
			this._bold = bold;
			this._align = align;
			this._leading = leading;
			this._letterSpacing = letterSpacing;
			
			_format = new TextFormat();
			_format.font = this._font;
			_format.size = this._size;
			_format.color = this._color;
			_format.bold = this._bold;
			_format.align = this._align;
			_format.leading = this._leading;
			_format.letterSpacing = this._letterSpacing;
			
			updateFormat();
		}
		
		
		/** 
		* フォーマットの更新
		* @return void
		*/
		public function updateFormat():void 
		{
			if (this.text == "") 
			{
				this.defaultTextFormat = _format;
				
			}else 
			{
				this.setTextFormat(_format);
			}
		}
		
		
		/** 
		* テキストフィールドの初期化
		* @param embedFonts フォントを埋め込むか
		* @param mouseEnabled マウスを有効化するか
		* @param selectable 選択できるか
		* @param wordWrap 折り返すか
		* @param multiline 複数行するか
		* @param autoSize 整列
		* @param blendMode ブレンドモード
		* @param type タイプ
		* @return void
		*/
		public function init(embedFonts:Boolean = false, mouseEnabled:Boolean = false, selectable:Boolean = false, wordWrap:Boolean = false, multiline:Boolean = true, autoSize:String = "left", blendMode:String = "normal", type:String = "dynamic"):void
		{
			this.autoSize = autoSize;
			this.blendMode = blendMode;
			this.embedFonts = embedFonts;
			this.multiline = multiline;
			this.mouseEnabled = mouseEnabled;
			this.selectable = selectable;
			this.type = type;
			this.wordWrap = wordWrap;
		}
		
		
		/** 
		* TextFormat インスタンス
		*/
		public function get format():TextFormat { return _format; }
		
		public function set format(value:TextFormat):void 
		{
			_format = value;
		}
		
		
		/** 
		* TextFormat.font 直接編集が可能
		*/
		public function get font():String { return _font; }
		
		public function set font(value:String):void 
		{
			_font = value;
			
			_format.font = _font;
		}
		
		
		/** 
		* TextFormat.size 直接編集が可能
		*/
		public function get size():Number { return _size; }
		
		public function set size(value:Number):void 
		{
			_size = value;
			
			_format.size = _size;
		}
		
		
		/** 
		* TextFormat.color 直接編集が可能
		*/
		public function get color():uint { return _color; }
		
		public function set color(value:uint):void 
		{
			_color = value;
			
			_format.color = _color;
		}
		
		
		/** 
		* TextFormat.bold 直接編集が可能
		*/
		public function get bold():Boolean { return _bold; }
		
		public function set bold(value:Boolean):void 
		{
			_bold = value;
			
			_format.bold = _bold;
		}
		
		
		/** 
		* TextFormat.align 直接編集が可能
		*/
		public function get align():String { return _align; }
		
		public function set align(value:String):void 
		{
			_align = value;
			
			_format.align = _align;
		}
		
		
		/** 
		* TextFormat.leading 直接編集が可能
		*/
		public function get leading():Number { return _leading; }
		
		public function set leading(value:Number):void 
		{
			_leading = value;
			
			_format.leading = _leading;
		}
		
		
		/** 
		* TextFormat.letterSpacing 直接編集が可能
		*/
		public function get letterSpacing():Number { return _letterSpacing; }
		
		public function set letterSpacing(value:Number):void 
		{
			_letterSpacing = value;
			
			_format.letterSpacing = _letterSpacing;
		}
		
	}
	
}