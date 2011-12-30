package info.dimensionMaker.utils
{
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.geom.Point;
	
	
	/** 
	* 既存にない Graphics を描画するクラスです。Graphics を返します。
	*/
	public class GraphicsUtil
	{
		static private var PI:Number = Math.PI;
		static private var DEGTORAD:Number = Math.PI / 180;
		
		
		/**
		  * ドーナツ形
		  * @param g Graphics ターゲット 
		  * @param sr Number 描画開始半径
		  * @param er Number 描画終了半径
		  * @param sa Number 描画開始角度
		  * @param ea Number 描画終了角度
		  * @return Graphics 生成したドーナツ形
		  */
		public static function donuts(g:Graphics, sr:Number, er:Number, sa:Number, ea:Number):Graphics
		{
			var sap:Point = Point.polar(sr, sa * DEGTORAD);
			var eap:Point = Point.polar(er, ea * DEGTORAD);
			var ap:Point;
			var cp:Point;
			
			g.moveTo(sap.x, sap.y);
			
			for (var i:int = sa; i <= ea; i++)
			{
				ap = Point.polar(sr, i * DEGTORAD);
				cp = Point.polar(sr, (i - 0.5) * DEGTORAD);
				g.curveTo(cp.x, cp.y, ap.x, ap.y);
			}
			
			g.lineTo(eap.x, eap.y);
			
			for (i = ea; i >= sa; i--)
			{
				ap = Point.polar(er, i * DEGTORAD);
				cp = Point.polar(er, (i + 0.5) * DEGTORAD);
				g.curveTo(cp.x, cp.y, ap.x, ap.y);
			}
			
			return g;
		}
		
		
		/** 
		* 多角形
		* @param g Graphics ターゲット 
		* @param r 半径
		* @param vertex 頂点の数。3点以上
		* @return Graphics 生成した多角形
		*/
		public static function polygon(g:Graphics, r:Number, vertex:int = 3):Graphics
		{
			var points:/*Number*/Array = [];
			var rad:Number = PI * 2 / vertex;
			
			for (var i: int = 0; i < vertex; i++) 
			{
				var theta:Number = (i * rad) - PI * 0.5;
				
				points[i << 1] = r * Math.cos(theta);
				points[(i << 1) + 1] = r * Math.sin(theta);
			}
			
			g.moveTo(points[0], points[1]);
			
			var n:int = points.length >> 1;
			for (var j: int = 1; j < n; j++) 
			{
				g.lineTo(points[j << 1], points[(j << 1) + 1]);
			}
			
			g.lineTo(points[0], points[1]);
			
			return g;
		}
		
		
		/** 
		* 星形
		* @param g Graphics ターゲット 
		* @param inR 内側の半径
		* @param outR 外側の半径
		* @param vertex 頂点の数。5点以上
		* @return Graphics 生成した星形
		*/
		public static function star(g:Graphics, inR:Number, outR:Number, vertex:int = 5):Graphics
		{
			var points:/*Number*/Array = [];
			var rad:Number = PI * 2 / vertex;
			
			for (var i: int = 0; i < vertex; i++) 
			{
				var outTheta:Number = (i * rad) - PI * 0.5;
				var inTheta:Number = outTheta + (rad * 0.5);
				
				points[i << 2] = outR * Math.cos(outTheta);
				points[(i << 2) + 1] = outR * Math.sin(outTheta);
				points[(i << 2) + 2] = inR * Math.cos(inTheta);
				points[(i << 2) + 3] = inR * Math.sin(inTheta);
			}
			
			g.moveTo(points[0], points[1]);
			
			var n:int = points.length >> 1;
			for (var j: int = 1; j < n; j++) 
			{
				g.lineTo(points[j << 1], points[(j << 1) + 1]);
			}
			
			g.lineTo(points[0], points[1]);
			
			return g;
		}
		
		
		/** 
		* 雫形
		* @param g Graphics ターゲット 
		* @param r 半径
		* @param fill 塗りを実行する関数
		* @return Graphics 生成した雫形
		*/
		public static function drop(g:Graphics, r:int, fill:Function):Graphics
		{
			for (var i: int = 0; i < r; i++)
			{
				fill();
				g.drawCircle(0, (r >> 2) - i, (r - i) / 3);
			}
			
			return g;
		}
		
		
		/** 
		* 破線
		* @param g Graphics ターゲット 
		* @param pt0 始点
		* @param pt1 終点
		* @param len 長さ
		* @param pattern パターン
		* @return Graphics 生成した破線
		*/
		public static function dashlineTo(g:Graphics, pt0:Point, pt1:Point, len:Number, pattern:Array):Graphics
		{
			var distance:int = int(Point.distance(pt0, pt1));
			var cnt:int = distance / len;
			
			g.moveTo(pt0.x, pt0.y);
			
			var isDraw:Boolean;
			var pt:Point;
			var index:int = 0;
			var num:int = pattern.length - 1;
			for (var i: int = 0; i < cnt; i++) 
			{
				pt = Point.interpolate(pt0, pt1, 1 - i / cnt);
				
				isDraw = Boolean(pattern[index]);
				if (isDraw) 
				{
					g.lineTo(pt.x, pt.y);
					
				}else
				{
					g.moveTo(pt.x, pt.y);
				}
				
				if (index < num)
				{
					index++;
					
				}else
				{
					index = 0;
				}
			}
			
			return g;
		}
	}
	
}