package info.dimensionMaker.managers 
{
	import flash.display.DisplayObject;
	
	
	/** 
	* DisplayObject のレイアウト座標を管理します。
	*/
	public class LayoutManager
	{
		/** 
		* 定数です。左上を開始位置とします。
		*/
		static public const TL:String = "tl";
		
		/** 
		* 定数です。右上を開始位置とします。
		*/
		static public const TR:String = "tr";
		
		/** 
		* 定数です。左下を開始位置とします。
		*/
		static public const BL:String = "bl";
		
		/** 
		* 定数です。右下を開始位置とします。
		*/
		static public const BR:String = "br";
		
		/** 
		* 定数です。開始位置から上方向を示します。
		*/
		static public const TO_TOP:String = "to_top";
		
		/** 
		* 定数です。開始位置から下方向を示します。
		*/
		static public const TO_BOTTOM:String = "to_bottom";
		
		/** 
		* 定数です。開始位置から左方向を示します。
		*/
		static public const TO_LEFT:String = "to_left";
		
		/** 
		* 定数です。開始位置から右方向を示します。
		*/
		static public const TO_RIGHT:String = "to_right";
		
		
		private var grid:Boolean;
		private var center:Boolean;
		// 縦横
		private var cr:int;
		// 始点
		private var startPosition:String;
		// 方向
		private var to:String;
		private var _children:/*DisplayObject*/Array = [];
		private var _positions:/*Object*/Array = [];
		private var _leftMargin:Number = 0;
		private var _rightMargin:Number = 0;
		private var _topMargin:Number = 0;
		private var _bottomMargin:Number = 0;
		
		
		/** 
		* コンストラクタ
		* @param cr 縦横の数
		* @param startPosition 開始位置
		* @param to 方向
		* @param center DisplayObject の基準を中心に置くかどうか
		* @param grid グリッド配置するかどうか
		* @return void
		*/
		public function LayoutManager(cr:int = 4, startPosition:String = LayoutManager.TL, to:String = LayoutManager.TO_RIGHT, center:Boolean = false, grid:Boolean = true)
		{
			this.cr = cr;
			this.startPosition = startPosition;
			this.to = to;
			this.grid = grid;
			this.center = center;
		}
		
		
		/** 
		* DisplayObject を追加します
		* @param child:DisplayObject
		* @return void
		*/
		public function add(child:DisplayObject):void 
		{
			_children.push(child);
			
			var positon:Object = { };
			
			positon.width = child.width;
			positon.height = child.height;
			
			_positions.push(positon);
		}
		
		
		/** 
		* 与えられた DisplayObject を元に位置を(再)計算します
		* @return void
		*/
		public function render():void
		{
			switch (startPosition + to)
			{
				case LayoutManager.TL + LayoutManager.TO_RIGHT:
					
					setPosition(1, 1, "x", "y", "width", "height", rightMargin, topMargin);
					break;
					
				case LayoutManager.TL + LayoutManager.TO_BOTTOM:
					
					setPosition(1, 1, "y", "x", "height", "width", topMargin, rightMargin);
					break;
					
				case LayoutManager.TR + LayoutManager.TO_LEFT:
					
					setPosition( -1, 1, "x", "y", "width", "height",  leftMargin, topMargin);
					break;
					
				case LayoutManager.TR + LayoutManager.TO_BOTTOM:
					
					setPosition( 1, - 1, "y", "x", "height", "width", topMargin, leftMargin);
					break;
					
				case LayoutManager.BL + LayoutManager.TO_RIGHT:
					
					setPosition(1, -1, "x", "y", "width", "height", rightMargin, topMargin);
					break;
					
				case LayoutManager.BL + LayoutManager.TO_TOP:
					
					setPosition( -1, 1, "y", "x", "height", "width", topMargin, rightMargin);
					break;
					
				case LayoutManager.BR + LayoutManager.TO_LEFT:
					
					setPosition(-1, -1, "x", "y", "width", "height", leftMargin, topMargin);
					break;
					
				case LayoutManager.BR + LayoutManager.TO_TOP:
					
					setPosition( -1, -1, "y", "x", "height", "width", topMargin, leftMargin);
					break;
					
				default :
					break;
			}
		}
		
		
		private function setPosition(sign1:int, sign2:int, p1:String, p2:String, p3:String, p4:String, margin1:Number, margin2:Number):void
		{
			var n:int = _children.length;
			for (var i: int = 0; i < n; i++) 
			{
				if (i % cr != 0)
				{
					if (!grid) 
					{
						if (center) 
						{
							// センター中心
							_positions[i][p1] = _positions[i - 1][p1] + (sign1 * ((_positions[i - 1][p3] + _positions[i][p3]) * 0.5 + margin1));
							
						}else 
						{
							// 詰めたレイアウト
							_positions[i][p1] = _positions[i - 1][p1] + (sign1 * (_positions[i - 1][p3] + margin1));
						}
						
					// 等間隔
					}else if (int(i / cr) == 0)
					{
						if (center) 
						{
							// センター中心
							_positions[i][p1] = _positions[i - 1][p1] + (sign1 * ((returnMax(i - 1, p3) + returnMax(i, p3)) * 0.5 + margin1));
							
						}else 
						{
							_positions[i][p1] = _positions[i - 1][p1] + (sign1 * (returnMax(i - 1, p3) + margin1));
						}
						
					}else 
					{
						//_positions[i][p1] = _positions[i - cr][p1] + (sign1 * margin1);
						_positions[i][p1] = _positions[i - cr][p1];
					}
					
					//_positions[i][p2] = _positions[i - 1][p2] + ( sign2 * margin2);
					_positions[i][p2] = _positions[i - 1][p2];
					
				}else 
				{
					_positions[i][p1] = 0;
					
					if (i == 0) 
					{
						_positions[i][p2] = 0;
						
					}else
					{
						
						
						if (center) 
						{
							// センター中心
							_positions[i][p2] = _positions[i - 1][p2] + (sign2 * ((returnMax2(i - cr, i - 1, p4) + returnMax2(i, i + cr - 1, p4)) * 0.5 + margin2));
							
						}else 
						{
							_positions[i][p2] = _positions[i - 1][p2] + (sign2 * (returnMax2(i - cr, i - 1, p4) + margin2));
						}
						
					}
				}
				
				_positions[i]["id1"] = "id1" + int(i / cr);
				_positions[i]["id2"] = "id2" + int(i % cr);
			}
		}
		
		
		private function returnMax(start:int, property:String):Number
		{
			var max:Number = _positions[start][property];
			
			var n:int = int(_children.length / cr);
			for (var i: int = 0; i < n; i ++)
			{
				if (_positions[start + (i * cr)] != undefined) 
				{
					max = Math.max(max, _positions[start + (i * cr)][property]);
				}
			}
			
			return max;
		}
		
		
		private function returnMax2(start:int, end:int, property:String):Number
		{
			var max:Number = _positions[start][property];
			
			for (var i: int = start; i < end; i++)
			{
				if (_positions[i + 1] != undefined) 
				{
					max = Math.max(max, _positions[i + 1][property]);
				}
			}
			
			return max;
		}
		
		
		/** 
		* 計算対象の DisplayObject が入った配列
		*/
		public function get children():/*DisplayObject*/Array { return _children; }
		
		
		/** 
		* DisplayObject の位置情報が入った Object の配列
		*/
		public function get positions():/*Object*/Array { return _positions; }
		
		
		/** 
		* 左マージン
		*/
		public function get leftMargin():Number { return _leftMargin; }
		
		public function set leftMargin(value:Number):void 
		{
			_leftMargin = value;
		}
		
		
		/** 
		* 右マージン
		*/
		public function get rightMargin():Number { return _rightMargin; }
		
		public function set rightMargin(value:Number):void 
		{
			_rightMargin = value;
		}
		
		
		/** 
		* 上マージン
		*/
		public function get topMargin():Number { return _topMargin; }
		
		public function set topMargin(value:Number):void 
		{
			_topMargin = value;
		}
		
		
		/** 
		* 下マージン
		*/
		public function get bottomMargin():Number { return _bottomMargin; }
		
		public function set bottomMargin(value:Number):void 
		{
			_bottomMargin = value;
		}
		
	}

}