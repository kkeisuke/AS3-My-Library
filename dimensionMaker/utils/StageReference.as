package info.dimensionMaker.utils
{
	import flash.display.Stage;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	
	
	/** 
	* Stage インスタンスをどこからでも参照できるように保持するクラスです。
	*/
	public class StageReference
	{
		
		
		/** 
		* Stage インスタンス
		*/
		static public var stage:Stage;
		
		
		/** 
		* Stage 幅の初期値
		*/
		static public const DEFAULT_STAGE_WIDTH:Number = 640;
		
		
		/** 
		* Stage 高さの初期値
		*/
		static public const DEFAULT_STAGE_HEIGHT:Number = 480;
		
		
		/** 
		* 初期化 ( StageAlign.TOP_LEFT, StageScaleMode.NO_SCALE );
		* @param 
		* @return void
		*/
		static public function init():void 
		{
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
		}
		
		
		/** 
		* Stage の幅
		*/
		static public function get width():Number
		{
			return (stage!=null) ? stage.stageWidth : DEFAULT_STAGE_WIDTH;
		}
		
		
		/** 
		* Stage の高さ
		*/
		static public function get height():Number
		{
			return (stage!=null) ? stage.stageHeight : DEFAULT_STAGE_HEIGHT;
		}
		
	}
	
}