package info.dimensionMaker.geom 
{
	import flash.display.BitmapData;
	import flash.display.Stage;
	import flash.geom.ColorTransform;
	import flash.geom.Rectangle;
	
	
	/** 
	* パーティクルの性質を保持する
	*/
	public class Particle
	{
		// rote と scale がない。
		private var _ax:Number = 0;
		private var _ay:Number = 0;
		private var _vx:Number = 0;
		private var _vy:Number = 0;
		private var _friction:Number = 1;
		private var _x:Number = 0;
		private var _y:Number = 0;
		
		private var _vAlpha:Number = 0;
		private var _alpha:Number = 1;
		private var colorTransFrom:ColorTransform;
		
		private var _life:int = 40;
		private var _isLife:Boolean = true;
		
		private var _bmd:BitmapData;
		private var rect:Rectangle;
		
		private static var sw:int;
		private static var sh:int;
		
		public static var cliped:Boolean;
		
		
		/** 
		* コンストラクタ。Emitter から生成される。
		* @param _bmd 実際に描画する BitmapData
		*/
		public function Particle(_bmd:BitmapData)
		{
			this._bmd = _bmd.clone();
			
			sets();
		}
		
		
		/** 
		* 初期化。パーティクルがステージ内にあるかを調べるために Stage が必要。
		* ParticleField が呼び出す。
		* @param s ステージ
		*/
		public static function init(s:Stage):void 
		{
			sw = s.stageWidth;
			sh = s.stageHeight;
		}
		
		
		private function sets():void
		{
			colorTransFrom = new ColorTransform();
			rect = _bmd.rect;
		}
		
		
		/** 
		* パーティクルの状態を更新。Emitter が更新する。
		* @return Boolean パーティクルが生存しているか
		*/
		public function update():Boolean 
		{
			if (_isLife) 
			{
				// ステージの範囲とalpha
				if ((_x < 0 || _x > sw) || (_y < 0 || _y > sh) || _alpha <= 0)
				{
					remove();
					return _isLife;
				}
				
				_life--;
				
				if (_life <= 0)
				{
					remove();
					return _isLife;
				}
				
				_x += _vx;
				_y += _vy;
				_vx += _ax;
				_vy += _ay;
				_vx *= _friction;
				_vy *= _friction;
				
				// 配置座標を整数化 → 1.25倍
				if (cliped) 
				{
					_x = _x >> 0;
					_y = _y >> 0;
				}
				
				// alpha を BitmapData に適用
				if (_vAlpha != 0) 
				{
					_alpha += _vAlpha;
					colorTransFrom.alphaMultiplier = _alpha;
					
					// これが重い!!
					_bmd.colorTransform(rect, colorTransFrom);
				}
			}
			
			return _isLife;
		}
		
		
		private function remove():void 
		{
			_life = 0;
			_isLife = !_isLife;
			
			// 念のため
			_bmd.dispose();
			_bmd = null;
		}
		
		
		/** 
		* X軸方向への加速度
		*/
		public function get ax():Number { return _ax; }
		
		public function set ax(value:Number):void 
		{
			_ax = value;
		}
		
		/** 
		* Y軸方向への加速度
		*/
		public function get ay():Number { return _ay; }
		
		public function set ay(value:Number):void 
		{
			_ay = value;
		}
		
		/** 
		* X軸方向への速度
		*/
		public function get vx():Number { return _vx; }
		
		public function set vx(value:Number):void 
		{
			_vx = value;
		}
		
		/** 
		* Y軸方向への速度
		*/
		public function get vy():Number { return _vy; }
		
		public function set vy(value:Number):void 
		{
			_vy = value;
		}
		
		/** 
		* X軸上の座標
		*/
		public function get x():Number { return _x; }
		
		public function set x(value:Number):void 
		{
			_x = value >> 0;
		}
		
		/** 
		* Y軸上の座標
		*/
		public function get y():Number { return _y; }
		
		public function set y(value:Number):void 
		{
			_y = value >> 0;
		}
		
		/** 
		* 透過度の変化値
		*/
		public function get vAlpha():Number { return _vAlpha; }
		
		public function set vAlpha(value:Number):void 
		{
			_vAlpha = value;
		}
		
		/** 
		* 透過度
		*/
		public function get alpha():Number { return _alpha; }
		
		public function set alpha(value:Number):void 
		{
			_alpha = value;
			
			if (_alpha < 1) 
			{
				colorTransFrom.alphaMultiplier = _alpha;
				_bmd.colorTransform(_bmd.rect, colorTransFrom);
			}
		}
		
		/** 
		* 抵抗
		*/
		public function get friction():Number { return _friction; }
		
		public function set friction(value:Number):void 
		{
			_friction = value;
		}
		
		/** 
		* 生存値
		*/
		public function get life():int { return _life; }
		
		public function set life(value:int):void 
		{
			_life = value;
		}
		
		/** 
		* 生存しているかどうか
		*/
		public function get isLife():Boolean { return _isLife; }
		
		/** 
		* 実際に描画する BitmapData
		*/
		public function get bmd():BitmapData { return _bmd; }
		
	}

}