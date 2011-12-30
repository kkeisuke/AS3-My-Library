package info.dimensionMaker.utils 
{
	
	
	/** 
	* XML に関するユーティリティクラスです。
	*/
	public class XMLUtil 
	{
		
		
		/** 
		* 一定フォーマットの XML を Object の配列にします。
		* @param XML Object の配列に変換したい XML
		* @return Object の配列
		*/
		static public function toObjectArray(data:XML):/*Object*/Array
		{
			var objArray:/*Object*/Array = [];
			
			var items:XMLList = data.children();
			var n:int = items.length();
			for (var i: int = 0; i < n; i++) 
			{
				var obj:Object = { };
				
				var attrs:XMLList = items[i].children();
				var m:int = attrs.length();
				for (var j: int = 0; j < m; j++) 
				{
					obj[String(attrs[j].name())] = attrs[j];
				}
				
				objArray.push(obj);
			}
			
			return objArray;
		}
		
		
		/** 
		* Flash IDE から書き出された Motion XML から座標を取り出し配列にします。
		* @param xml Flash IDE から書き出された Motion XML
		* @return x と y が交互に入っている Array 。
		*/
		static public function PerthXMLMotion(xml:XML):/*Number*/Array 
		{
			var ns:Namespace = new Namespace("fl.motion.*");
			
			var arr:/*Number*/Array = [];
			
			arr[0] = Number(xml.ns::source.ns::Source.@x);
			arr[1] = Number(xml.ns::source.ns::Source.@y);
			
			var keyframeLength:int = int(xml.@duration);
			for (var i: int = 1; i < keyframeLength; i++) 
			{
				arr[2 * i] = Number(xml.ns::Keyframe[i].@x) + arr[0];
				arr[2 * i + 1] = Number(xml.ns::Keyframe[i].@y) + arr[1];
			}
			
			return arr;
		}
		
	}
	
}