package info.dimensionMaker.media 
{
	import flash.events.Event;
	import flash.events.NetStatusEvent;
	import flash.media.SoundTransform;
	import flash.media.Video;
	import flash.net.NetConnection;
	import flash.net.NetStream;
	
	
	/** 
	* Video クラスを直感的に使えるようにしたクラス。サブクラスを生成して使用します。
	*/
	public class BaseVideo extends Video
	{
		private var _netStream:NetStream;
		private var _connection:NetConnection;
		private var bufferTime:int;
		private var command:String;
		
		// sound
		private var soundTransform:SoundTransform;
		private var _leftToLeft:Number;
		private var _leftToRight:Number;
		private var _pan:Number;
		private var _rightToLeft:Number;
		private var _rightToRight:Number;
		private var _volume:Number;
		
		
		/** 
		* コンストラクタ
		* @param bufferTime NetStream の bufferTime
		* @param command NetConnection の connect メソッドの command
		* @param Video の smoothing
		*/
		public function BaseVideo(bufferTime:int = 5, command:String = null, smoothing:Boolean = false)
		{
			this.bufferTime = bufferTime;
			this.command = command;
			
			initConnect();
		}
		
		
		private function initConnect():void
		{
			// NetConnection
			_connection = new NetConnection();
			_connection.addEventListener(NetStatusEvent.NET_STATUS, connected);
			_connection.connect(command);
		}
		
		
		private function connected(e:NetStatusEvent):void 
		{
			// 接続完了
			if (e.info.code == "NetConnection.Connect.Success") 
			{
				initStream();
			}else 
			{
				//trace(e.info.code);
			}
		}
		
		
		private function initStream():void
		{
			// NetStream
			_netStream = new NetStream(_connection);
			
			var obj:Object = new Object();
			obj.onCuePoint = onCuePointHander;
			obj.onImageData = onImageDataHander;
			obj.onMetaData = onMetaDataHander;
			obj.onPlayStatus = onPlayStatusHander;
			obj.onTextData = onTextDataHander;
			
			_netStream.client = obj;
			_netStream.bufferTime = bufferTime;
			
			// Sound
			soundTransform = new SoundTransform();
			_leftToLeft = _netStream.soundTransform.leftToLeft;
			_leftToRight = _netStream.soundTransform.leftToRight;
			_pan = _netStream.soundTransform.pan;
			_rightToLeft = _netStream.soundTransform.rightToLeft;
			_rightToRight = _netStream.soundTransform.rightToRight;
			_volume = _netStream.soundTransform.volume;
			
			// Video
			this.attachNetStream(_netStream);
			this.smoothing = smoothing;
		}
		
		
		/** 
		* NetStream.client オブジェクトが呼び出す関数 onCuePoint()
		*/
		protected function onCuePointHander(param:Object):void
		{
			
		}
		
		
		/** 
		* NetStream.client オブジェクトが呼び出す関数 onImageData()
		*/
		protected function onImageDataHander(param:Object):void
		{
			
		}
		
		
		/** 
		* NetStream.client オブジェクトが呼び出す関数 onMetaData()
		*/
		protected function onMetaDataHander(param:Object):void
		{
			
		}
		
		
		/** 
		* NetStream.client オブジェクトが呼び出す関数 onPlayStatus()
		*/
		protected function onPlayStatusHander(param:Object):void
		{
			
		}
		
		
		/** 
		* NetStream.client オブジェクトが呼び出す関数 onTextData()
		*/
		protected function onTextDataHander(param:Object):void
		{
			
		}
		
		
		/** 
		* アンロード
		* @param event 外部から呼び出す場合は、null
		* @return void
		*/
		public function onUnload(event:Event=null):void
		{
			this._connection.close();
			this._netStream.close();
		}
		
		
		/** 
		* NetStream インスタンス
		*/
		public function get netStream():NetStream { return _netStream; }
		
		public function set netStream(value:NetStream):void 
		{
			_netStream = value;
		}
		
		
		/** 
		* NetConnection インスタンス
		*/
		public function get connection():NetConnection { return _connection; }
		
		public function set connection(value:NetConnection):void 
		{
			_connection = value;
		}
		
		
		/** 
		* SoundTransform.leftToLeft 直接編集が可能
		*/
		public function get leftToLeft():Number { return _leftToLeft; }
		
		public function set leftToLeft(value:Number):void 
		{
			_leftToLeft = value;
			
			soundTransform.leftToLeft = _leftToLeft;
			
			_netStream.soundTransform = soundTransform;
		}
		
		
		/** 
		* SoundTransform.leftToRight 直接編集が可能
		*/
		public function get leftToRight():Number { return _leftToRight; }
		
		public function set leftToRight(value:Number):void 
		{
			_leftToRight = value;
			
			soundTransform.leftToRight = _leftToRight;
			
			_netStream.soundTransform = soundTransform;
		}
		
		
		/** 
		* SoundTransform.pan 直接編集が可能
		*/
		public function get pan():Number { return _pan; }
		
		public function set pan(value:Number):void 
		{
			_pan = value;
			
			soundTransform.pan = _pan;
			
			_netStream.soundTransform = soundTransform;
		}
		
		
		/** 
		* SoundTransform.rightToLeft 直接編集が可能
		*/
		public function get rightToLeft():Number { return _rightToLeft; }
		
		public function set rightToLeft(value:Number):void 
		{
			_rightToLeft = value;
			
			soundTransform.rightToLeft = _rightToLeft;
			
			_netStream.soundTransform = soundTransform;
		}
		
		
		/** 
		* SoundTransform.rightToRight 直接編集が可能
		*/
		public function get rightToRight():Number { return _rightToRight; }
		
		public function set rightToRight(value:Number):void 
		{
			_rightToRight = value;
			
			soundTransform.rightToRight = _rightToRight;
			
			_netStream.soundTransform = soundTransform;
		}
		
		
		/** 
		* SoundTransform.volume 直接編集が可能
		*/
		public function get volume():Number { return _volume; }
		
		public function set volume(value:Number):void 
		{
			_volume = value;
			
			soundTransform.volume = _volume;
			
			_netStream.soundTransform = soundTransform;
		}
		
	}
	
}