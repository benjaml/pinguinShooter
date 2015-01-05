package
{
	import com.greensock.TweenMax;
	import flash.geom.Point;
	import net.flashpunk.FP;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.Mask;
	
	/**
	 * ...
	 * @author ...
	 */
	public class Boss extends Ennemy
	{
		public var PV:int;
		public var barreDeVie:HealthBar;
		public var nbTir:int;
		public var img:Image;
		public var canShoot:Boolean;
		
		public function Boss(x:Number = 0, y:Number = 0, graphic:Graphic = null, mask:Mask = null)
		{
			super(x, y, graphic, mask);
			PV = 250;
			nbTir = 0;
		}
		
		override public function added():void
		{
			super.added();
			img = Image.createRect(300, 300, 0x00FF00);
			
			graphic = img;
			
			setHitbox(img.width, img.height);
			type = "ennemy";
			TweenMax.to(this, 1, {x: x + 200, y: y});
			GameWorld.ref.boss = this;
			barreDeVie = new HealthBar(150, 50);
			GameWorld.ref.add(barreDeVie);
			canShoot = false;
			TweenMax.delayedCall(1.5, resetCanShoot);
		
		}
		
		override public function update():void
		{
			
			var bullet:Bullet = collide("bullet", x, y) as Bullet;
			
			if (bullet)
			{
				trace("aie");
				PV = PV - 1;
				FP.console.log(PV);
				GameWorld.ref.remove(bullet);
			}
			
			if (PV < 0)
			{
				GameWorld.ref.remove(barreDeVie);
				GameWorld.ref.remove(this);
			}
			if (barreDeVie)
			{
				barreDeVie.img.scaleX = (PV * 2) / 500;
			}
			if (canShoot)
				tirer();
		
		}
		
		public function tirer():void
		{
			// ajouter une distrance de 160
			
			canShoot = false;
			/********************************************************/
			nbTir++;
			if (nbTir >= 0 && nbTir < 10)
			{
				for (var i:int = 0; i < 20; i++)
				{
					var radians:Number = ((i * 10) - 90) * Math.PI / 180;
					var distance:Number = 1000; // this assumed to have a minimum of 1.0, adjust as needed.
					// 1000 is the distance to surely end the bullet outside the stage
					var dx:Number = distance * Math.cos(radians);
					var dy:Number = -1 * distance * Math.sin(radians);
					var bullet1:BulletIA = new BulletIA(x + img.width / 2 + (160 * Math.cos(radians)), y + img.height / 2 + (-1 * 180 * Math.sin(radians)));
					bullet1.destination = new Point(x + dx, y + dy);
					bullet1.ShootDuration = distance / bullet1.speed;
					GameWorld.ref.add(bullet1);
					TweenMax.to(bullet1, 5, {x: x + dx, y: y + dy});
				}
			}
			if (nbTir >= 10 && nbTir < 20)
			{
				for (var i:int = 0; i < 20; i++)
				{
					var radians:Number = ((i * 10) - 90 + nbTir) * Math.PI / 180;
					var distance:Number = 1000; // this assumed to have a minimum of 1.0, adjust as needed.
					// 1000 is the distance to surely end the bullet outside the stage
					var dx:Number = distance * Math.cos(radians);
					var dy:Number = -1 * distance * Math.sin(radians);
					var bullet1:BulletIA = new BulletIA(x + img.width / 2 + (160 * Math.cos(radians)), y + img.height / 2 + (-1 * 160 * Math.sin(radians)));
					bullet1.destination = new Point(x + dx, y + dy);
					bullet1.ShootDuration = distance / bullet1.speed;
					GameWorld.ref.add(bullet1);
					TweenMax.to(bullet1, 5, {x: x + dx, y: y + dy});
				}
			}
			if (nbTir >= 20 && nbTir < 30)
			{
				for (var i:int = 0; i < 20; i++)
				{
					var radians:Number = ((i * 10) - 90) * Math.PI / 180;
					var distance:Number = 1000; // this assumed to have a minimum of 1.0, adjust as needed.
					// 1000 is the distance to surely end the bullet outside the stage
					var dx:Number = distance * Math.cos(radians);
					var dy:Number = -1 * distance * Math.sin(radians);
					var bullet1:BulletIA = new BulletIA(x + img.width / 2 + (160 * Math.cos(radians)), y + img.height / 2 + (-1 * 160 * Math.sin(radians)));
					bullet1.destination = new Point(x + dx, y + dy);
					bullet1.ShootDuration = distance / bullet1.speed;
					GameWorld.ref.add(bullet1);
					TweenMax.to(bullet1, 5, {x: x + dx, y: y + dy});
				}
			}
			if (nbTir >= 30 && nbTir < 40)
			{
				for (var i:int = 0; i < 20; i++)
				{
					var radians:Number = ((i * 10) - 90 - nbTir) * Math.PI / 180;
					var distance:Number = 1000; // this assumed to have a minimum of 1.0, adjust as needed.
					// 1000 is the distance to surely end the bullet outside the stage
					var dx:Number = distance * Math.cos(radians);
					var dy:Number = -1 * distance * Math.sin(radians);
					var bullet1:BulletIA = new BulletIA(x + img.width / 2 + (160 * Math.cos(radians)), y + img.height / 2 + (-1 * 160 * Math.sin(radians)));
					bullet1.destination = new Point(x + dx, y + dy);
					bullet1.ShootDuration = distance / bullet1.speed;
					GameWorld.ref.add(bullet1);
					TweenMax.to(bullet1, 5, {x: x + dx, y: y + dy});
				}
			}
			if (nbTir == 39)
				nbTir = 0;
			
			TweenMax.delayedCall(0.2, resetCanShoot);
		}
		
		public function resetCanShoot():void
		{
			canShoot = true;
		}
	
	}

}