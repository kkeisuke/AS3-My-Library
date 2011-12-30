package info.dimensionMaker.geom 
{
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	
	/** 
	* ターゲット Rectangle を再帰的に同比率で分割し、その全 Rectangle の配列を返します。
	*/
	public class RectSpliter
	{
		static private var rectDataes:/*Rectangle*/Array;
		static private var allRectDataes:/*Rectangle*/Array;
		static private var count:int;
		static private var w:Number;
		static private var h:Number;
		static private var endP:Point;
		static private var func:Function = splitsRect;
		
		static private var target:Rectangle;
		static private var min:int;
		static private var max:int;
		static private var probability:Number;
		
		
		/** 
		* ターゲット Rectangle を再帰的に同比率で分割し、その全 Rectangle の配列を返します。
		* @param _target 分割される Rectangle
		* @param _min 分割数
		* @param _max 繰り返す回数
		* @param _probability 分割する確立
		* @return Array 
		*/
		static public function split(_target:Rectangle, _min:int = 16, _max:int = 84, _probability:Number = 0.25):/*Rectangle*/Array 
		{
			target = _target;
			min = _min;
			max = _max;
			probability = _probability;
			
			setUp();
			func();
			
			return allRectDataes;
		}
		
		
		static private function setUp():void 
		{
			allRectDataes = [];
			count = 0;
			rectDataes = [target];
			w = target.width / 2;
			h = target.height / 2;
			endP = new Point(rectDataes[0].left, rectDataes[0].bottom);
		}
		
		
		static private function splitsRect():Function 
		{
			var parent:Rectangle = rectDataes[0];
			
			var leftBottom:Point = new Point(parent.left, parent.bottom);
			
			// min 当分まではスキップしない。
			if (count < min || Math.random() >= probability)
			{
				rectDataes.shift();
				rectDataes.push(new Rectangle(parent.x, parent.y, w, h));
				rectDataes.push(new Rectangle(parent.x + w, parent.y, w, h));
				rectDataes.push(new Rectangle(parent.x + w, parent.y + h, w, h));
				rectDataes.push(new Rectangle(parent.x, parent.y + h, w, h));
				
			}else 
			{
				//カウントをスキップ
				count++
				
				// 削除したヤツを入れる
				allRectDataes.push(rectDataes.shift());
			}
			
			// このポイントに来たら、w,h をさらに半分にする。
			if (leftBottom.x == endP.x && leftBottom.y == endP.y) 
			{
				w /= 2;
				h /= 2;
			}
			
			if (count < max) 
			{
				count++
				
				return func();
				
			}else 
			{
				// 最後に配列をまとめる。
				allRectDataes = allRectDataes.concat(rectDataes);
				
				return new Function();
			}
		}
		
	}

}