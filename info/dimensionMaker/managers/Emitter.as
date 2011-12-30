package info.dimensionMaker.managers 
{
	import flash.display.BitmapData;
	import flash.display.IBitmapDrawable;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import info.dimensionMaker.geom.Particle;
	import info.dimensionMaker.display.ParticleField;
	
	
	/** 
	* パーティクル、素材とその土台を管理するクラス
	*/
	public class Emitter extends EventDispatcher
	{
		// BitmapData に draw できるもの
		private var material:IBitmapDrawable;
		
		private var bmd:BitmapData;
		
		private var scalable:Boolean;
		private var center:Boolean;
		private var num:int = 5;
		private var bmds:/*BitmapData*/Array = [];
		
		private var particles:/*Particle*/Array = [];
		private var field:ParticleField;
		
		private var point:Point;
		private var canvas:BitmapData;
		private var rect:Rectangle;
		private var bgColor:uint;
		
		
		/** 
		* コンストラクタ
		* @param field パーティクルを表示する土台
		* @param material パーティクルの素材
		* @param scalable パーティクルのスケールを有効化するか
		* @param center material 基準点が中心かどうか
		*/
		public function Emitter(field:ParticleField, material:IBitmapDrawable, scalable:Boolean = true, center:Boolean = true)
		{
			this.field = field;
			this.material = material;
			this.scalable = scalable;
			this.center = center;
			
			init();
		}
		
		
		private function init():void
		{
			// あらかじめ、スケールが 0.2～1 までの大きさのコピーを作っておく。
			// Particle に scale が無いので、これで代替。
			// 傾きを今後どうするか。
			if (scalable)
			{
				for (var i: int = 0; i < num; i++) 
				{
					var w:Number = material["width"] / num * (i + 1);
					var h:Number = material["height"] / num * (i + 1);
					
					bmds[i] = new BitmapData(w, h, true, 0x00000000);
					
					var mtx:Matrix = new Matrix();
					mtx.scale(1 / num * (i + 1), 1 / num * (i + 1));
					
					if (center) 
					{
						mtx.translate(w * 0.5, h * 0.5);
					}
					
					bmds[i].draw(material, mtx);
				}
				
			}else 
			{
				w = material["width"];
				h = material["height"];
				
				bmd = new BitmapData(w, h, true, 0x00000000);
				mtx = new Matrix();
				
				if (center) 
				{
					mtx.translate(w * 0.5, h * 0.5);
				}
				
				bmd.draw(material, mtx);
			}
			
			// update で使うものをあらかじめ定義してみる。
			this.point = new Point();
			this.canvas = field.canvas;
			this.rect = canvas.rect;
			this.bgColor = field.bgColor;
		}
		
		
		/** 
		* パーティクルを作成する
		* @return Particle パーティクル
		*/
		public function generate(cliped:Boolean = true):Particle 
		{
			if (cliped) 
			{
				Particle.cliped = cliped;
			}
			
			// スケールが有効ならば配列から。そうでなければ、単体で。
			if (scalable) 
			{
				// >> 0 は、int() キャストと同じ。
				// >> 0 の前を()で囲むと、ちょっと早くなった気がする。気のせいかな。
				var particle:Particle = new Particle(bmds[(Math.random() * num) >> 0]);
				
			}else 
			{
				particle = new Particle(bmd);
			}
			
			particles.push(particle);
			
			return particle;
		}
		
		
		/** 
		* Emitter を更新して、描画する
		*/
		public function update():void 
		{
			var i:int = particles.length;
			
			if (i <= 0)
			{
				// パーティクルがなくなった時
				dispatchEvent(new Event(Event.COMPLETE));
			}
			
			canvas.lock();
			
			// fillRect 以外にあるか？
			canvas.fillRect(rect, bgColor);
			
			while (i--) 
			{
				// ローカル変数で持ったほうがデータ型が指定できて早い？
				var particle:Particle = particles[i];
				var pbmd:BitmapData = particle.bmd;
				
				// 1個のパーティクルの更新と、生存しているか。
				var life:Boolean = particle.update();
				
				if (life) 
				{
					// 描画
					point.x = particle.x;
					point.y = particle.y;
					field.canvas.copyPixels(pbmd, pbmd.rect, point, null, null, true);
					
				}else 
				{
					// 削除
					particles.splice( i, 1 );
				}
			}
			
			canvas.unlock();
		}
		
	}

}