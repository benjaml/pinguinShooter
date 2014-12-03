package  
{
	import com.greensock.TweenMax;
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.Mask;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	
	/**
	 * ...
	 * @author benjamin LEFEVRE
	 */
	public class Ennemy extends Entity 
	{
		public var speed:Number;
		public var target:Player;
		public var pointDeVie:int;
		public var knockdown:Boolean;
		
		
		public function Ennemy(x:Number=0, y:Number=0, graphic:Graphic=null, mask:Mask=null) 
		{
			super(x, y, graphic, mask);
			this.knockdown = false;
			speed = 2;
			pointDeVie = 2;
		}
		
		override public function added():void
		{
			super.added();
			var img:Image = Image.createRect(30, 40, 0x00FF00);
			
			graphic = img;
			
			setHitbox(img.width, img.height);
			type = "ennemy";
		}
		
		public function setTarget(cible:Player):void
		{
			target = cible;
		}
		
		
		override public function update():void
		{
			super.update();
			if(!this.knockdown){
				if (target.x > x)
				{
					if (!collide("ennemy", x+speed, y))
					{
						TweenMax.killTweensOf(this);
						x += speed;	
					}
				}
				if (target.x < x)
				{
					if (!collide("ennemy", x-speed, y))
					{
						TweenMax.killTweensOf(this);
						x -= speed;	
					}
				}
				if (target.y < y)
				{
					if (!collide("ennemy", x, y-speed))
					{
						TweenMax.killTweensOf(this);
						y -= speed;	
					}
				}
				if (target.y > y)
				{
					if (!collide("ennemy", x, y+speed))
					{
						TweenMax.killTweensOf(this);
						y += speed;	
					}
				}
			}
			if (collide("bullet", x, y))
			{
				this.knockdown = true;
				var bul:Bullet = collide("bullet", x, y) as Bullet
				pointDeVie--;
				GameWorld.ref.recycle(bul);
				if (pointDeVie == 0) {
					GameWorld.ref.recycle(this);
				}
				var dx:Number = bul.destination.x - x;
				var dy:Number = bul.destination.y - y;
				//Math.sqrt((dx-x) * (dx-x) + (dy-y) * (dy-y))
				if (GameWorld.ref.player.shotgun){
					TweenMax.killTweensOf(this);
					dx = dx/10;
					dy = dy/10;
					trace("" + dx + "    " + dy);
					TweenMax.to(this, Math.sqrt((dx) * (dx) + (dy) * (dy)) / bul.speed, { x:x + dx , y:y +dy  } );
					TweenMax.delayedCall((Math.sqrt((dx) * (dx) + (dy) * (dy)) / bul.speed), resetKnockBack );
				}
				else{
					dx = dx/100;
					dy = dy / 100;
					trace("" + dx + "    " + dy);
					TweenMax.killTweensOf(this);
					TweenMax.to(this, Math.sqrt((dx) * (dx) + (dy) * (dy)) / bul.speed, { x:x + dx , y:y +dy  } );				}
					TweenMax.delayedCall((Math.sqrt((dx) * (dx) + (dy) * (dy)) / bul.speed),resetKnockBack );
			}
			
			
		}
		
		private function resetKnockBack():void 
		{
			this.knockdown = false;
		}
		
		
	}

}