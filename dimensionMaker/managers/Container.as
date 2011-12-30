package info.dimensionMaker.managers 
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	/** 
	* Sprite を拡張させた汎用的なコンテナクラス<br />
	* 役に立つかは分かりません。
	*/
	public class Container extends Sprite
	{
		private var _children:/*DisplayObject*/Array
		
		
		/** 
		* コンストラクタ
		*/
		public function Container() 
		{
			init();
		}
		
		
		private function init():void
		{
			_children = [];
		}
		
		
		/** 
		* addChild 時に、children を更新
		* @param child 子DisplayObject
		*/
		override public function addChild(child:DisplayObject):DisplayObject 
		{
			// 配列に追加
			_children[_children.length] = child;
			
			return super.addChild(child);
		}
		
		
		/** 
		* addChildAt 時に、children を更新
		* @param child 子DisplayObject
		* @param index インデックス位置
		*/
		override public function addChildAt(child:DisplayObject, index:int):DisplayObject 
		{
			// 配列の任意のインデックス位置に追加
			_children.splice(index, 0, child);
			
			return super.addChildAt(child, index);
		}
		
		
		/** 
		* 任意のインデックス位置から、連続して DisplayObject を追加する。
		* @param index インデックス位置
		* @param child 子DisplayObject
		*/
		public function addChildren(index:int = 0, ...child:/*DisplayObject*/Array):void
		{
			var n:int = child.length;
			for (var i: int = 0; i < n; i++) 
			{
				addChildAt(child[i], index);
				
				index++;
			}
		}
		
		
		/** 
		* removeChild 時に、children を更新
		* @param child 子DisplayObject
		*/
		override public function removeChild(child:DisplayObject):DisplayObject 
		{
			// 配列から削除
			_children.splice(getChildIndex(child), 1);
			
			return super.removeChild(child);
		}
		
		
		/** 
		* removeChildAt 時に、children を更新
		* @param index インデックス位置
		*/
		override public function removeChildAt(index:int):DisplayObject 
		{
			// 配列から削除
			_children.splice(index, 1);
			
			return super.removeChildAt(index);
		}
		
		
		/** 
		* 任意のインデックス間の子DisplayObjectを削除
		* @param start インデックス位置
		* @param end インデックス位置
		*/
		public function removeChildren(start:int = 0, end:int = int.MAX_VALUE):void
		{
			// 全部消す
			if (start == 0 && end == int.MAX_VALUE)
			{
				var n:int = numChildren;
				for (var i: int = 0; i < n; i++) 
				{
					removeChildAt(0);
				}
				
			// start から上を全部消す
			}else if(start != 0 && end == int.MAX_VALUE)
			{
				var m:int = numChildren;
				for (var j: int = start; j < m; j++) 
				{
					removeChildAt(start);
				}
				
			// start から end まで消す
			}else 
			{
				var l:int = end + 1;
				for (var k: int = start; k < l; k++) 
				{
					removeChildAt(start);
				}
			}
		}
		
		
		/** 
		* setChildIndex 時に、children を更新
		* @param child 子DisplayObject
		* @param index インデックス位置
		*/
		override public function setChildIndex(child:DisplayObject, index:int):void 
		{
			// 一旦削除
			_children.splice(getChildIndex(child), 1);
			
			// 再挿入
			_children.splice(index, 0, child);
			
			super.setChildIndex(child, index);
		}
		
		
		/** 
		* swapChildren 時に、children を更新
		* @param child1 子DisplayObject
		* @param child2 子DisplayObject
		*/
		override public function swapChildren(child1:DisplayObject, child2:DisplayObject):void 
		{
			// 入れ替え
			_children[getChildIndex(child2)] = child1;
			_children[getChildIndex(child1)] = child2;
			
			super.swapChildren(child1, child2);
		}
		
		
		/** 
		* swapChildrenAt 時に、children を更新
		* @param index1 インデックス位置
		* @param index2 インデックス位置
		*/
		override public function swapChildrenAt(index1:int, index2:int):void 
		{
			// 入れ替え
			_children[index2] = getChildAt(index1);
			_children[index1] = getChildAt(index2);
			
			super.swapChildrenAt(index1, index2);
		}
		
		
		/** 
		* Container インスタンスが保持している子DisplayObject の配列。(インデックス位置順)
		*/
		public function get children():/*DisplayObject*/Array { return _children; }
	}

}