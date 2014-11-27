package  
{
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
		
		
		public function Ennemy(x:Number=0, y:Number=0, graphic:Graphic=null, mask:Mask=null) 
		{
			super(x, y, graphic, mask);
			
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
			if (target.x > x)
			{
				if (!collide("ennemy", x+speed, y))
				{
					x += speed;	
				}
			}
			if (target.x < x)
			{
				if (!collide("ennemy", x-speed, y))
				{
					x -= speed;	
				}
			}
			if (target.y < y)
			{
				if (!collide("ennemy", x, y-speed))
				{
					y -= speed;	
				}
			}
			if (target.y > y)
			{
				if (!collide("ennemy", x, y+speed))
				{
					y += speed;	
				}
			}
			if (collide("bullet", x, y))
				{
					var bul:Bullet = collide("bullet", x, y) as Bullet
					pointDeVie--;
					GameWorld.ref.recycle(bul);
					if (pointDeVie == 0) {
						GameWorld.ref.recycle(this);
					}
				}
			
			
		}
		
	}

}