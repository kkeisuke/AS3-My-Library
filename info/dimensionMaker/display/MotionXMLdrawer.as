package info.dimensionMaker.display 
{
	import flash.display.Shape;
	import flash.events.Event;
	import info.dimensionMaker.utils.XMLUtil;
	
	
	/** 
	* <p>Flash IDE から書き出された Motion XML を自身に描く Shape<br>lineStyle 等の指定が別途必要。主にマスク用に使う。</p>
	*/
	public class MotionXMLdrawer extends Shape
	{
		private var xmls:/*XML*/Array;
		private var points:/*Number*/Array;
		
		private var current:int;
		private var total:int;
		
		private var count:int;
		private var currentLen:int;
		
		
		/** 
		* コンストラクタ
		* @param xmls 連続で描きたいだけの Motion XML
		*/
		public function MotionXMLdrawer(...xmls:/*XML*/Array)
		{
			this.xmls = xmls;
			
			init();	
		}
		
		
		private function init():void
		{
			points = [];
			
			var n:int = xmls.length;
			for (var i: int = 0; i < n; i++) 
			{
				addMotionXML(xmls[i]);
			}
			
			current = 0;
			count = 1;
			
			currentLen = points[current].length >> 1;
			
			graphics.moveTo(points[current][0], points[current][1]);
		}
		
		
		/** 
		* 連続で描きたい Motion XML を追加します。
		* @param motionXML Motion XML
		*/
		public function addMotionXML(motionXML:XML):void
		{
			total = points.length;
			
			points[total] = (XMLUtil.PerthXMLMotion(motionXML));
		}
		
		
		/** 
		* Event.EnterFrame のリスナーとして実行します。描き終わると、Event.COMPLETE を送出します。
		*/
		public function draw():void
		{
			var nextX:Number = points[current][2 * count];
			var nextY:Number = points[current][2 * count + 1];
			
			graphics.lineTo(nextX, nextY);
			
			count++;
			
			if (count == currentLen)
			{
				if (current == total) 
				{
					dispatchEvent(new Event(Event.COMPLETE));
					
				}else 
				{
					current++;
					count = 1;
					
					graphics.moveTo(points[current][0], points[current][1]);
				}
				
				currentLen = points[current].length >> 1;
			}
		}
		
	}

}