package  
{
	import com.greensock.TweenMax;
	import flash.geom.Point;
	import flash.system.System;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.Mask;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	
	/**
	 * ...
	 * @author benjamin LEFEVRE
	 */
	public class Player extends Entity 
	{
		public var speed:Number;
		public var fireRate:Number;
		var img:Image;
		var canShoot:Boolean;
		public var katana:Boolean;
		public var katanaMode:Boolean;
		public var shotgun:Boolean;
	
		
		public function Player(x:Number=0, y:Number=0, graphic:Graphic=null, mask:Mask=null) 
		{
			super(x, y, graphic, mask);
			canShoot = true;
			speed = 5;
			fireRate = 0.1;
			katana = false;
			shotgun = false;
		}
		
		override public function added():void
		{
			super.added();
			img= new Image(Embed.PLAYER);
			img.centerOrigin();
			graphic = img;
			
			setHitbox(img.width, img.height,img.width/2, img.width/2);
			type = "player";
			
		}
		
		
		override public function update():void
		{
			super.update();
			if (!katanaMode)
			{
				LookAtMouse();
			}
			//Input.check détecte si la touche est enfoncé, plus pour les déplacement et Input.pressed détecte l'action d'appuyer
			if (Input.check(Key.D))
			{
				if (x < 800-speed)
				{
					x += speed;	
				}
			}
			if (Input.check(Key.Q))
			{
				if (x > speed)
				{
					x -= speed;	
				}
			}
			if (Input.check(Key.Z))
			{
				if (y > speed)
				{
					y -= speed;	
				}
			}
			if (Input.check(Key.S))
			{
				if (y < 600-speed)
				{
					y += speed;	
				}
			}
			var bulletia:BulletIA = collide("bullet", x, y) as BulletIA;
			if (bulletia) {
				GameWorld.ref.remove(bulletia);
				GameWorld.ref.remove(this);
				GameWorld.ref.remove(GameWorld.ref.boss);
				TweenMax.killDelayedCallsTo(GameWorld.ref.boss);
				FP.world = new MainMenuWorld();
	
			}
			var ennemy:Ennemy = collide("ennemy", x, y) as Ennemy;
			if (ennemy != null)
			{
				if (katanaMode)
				{
					/*ennemy.pointDeVie = 0;
					GameWorld.ref.remove(ennemy);*/
					
				}
				else
				{// on peut utiliser recycle au lieu de remove pour ne pas tuer la mémoire
					GameWorld.ref.remove(this);
					FP.world = new MainMenuWorld();
				}
			}
			if (Input.mouseDown)
			{
				
				if (canShoot)
				{
					if (!shotgun)
					{
						var rando:Number = Math.random() * 20;
						var radians:Number=(img.angle+80+rando)*Math.PI/180;
						var distance:Number=3000; // this assumed to have a minimum of 1.0, adjust as needed.
						// 1000 is the distance to surely end the bullet outside the stage
						var dx:Number=distance*Math.cos(radians);
						var dy:Number=-1*distance*Math.sin(radians);

						var bullet:Bullet = new Bullet(x, y);
						bullet.destination = new Point(x + dx,y+dy);
						bullet.ShootDuration = distance / bullet.speed;
						GameWorld.ref.add(bullet);
						TweenMax.to(bullet, distance / bullet.speed, { x:x + dx , y:y + dy  } );
						canShoot = false;
						TweenMax.delayedCall(fireRate, setCanShoot);
					}
					else
					{
						/*       Bullet 1      */
						var bullet1:Bullet = new Bullet(x, y);
						var radians:Number=(img.angle+90)*Math.PI/180;
						var distance:Number=2000; // this assumed to have a minimum of 1.0, adjust as needed.
						// 1000 is the distance to surely end the bullet outside the stage
						var dx:Number=distance*Math.cos(radians);
						var dy:Number = -1 * distance * Math.sin(radians);
						bullet1.destination = new Point(x + dx,y+dy);
						bullet1.ShootDuration = distance / bullet1.speed;
						GameWorld.ref.add(bullet1);
						TweenMax.to(bullet1, distance / bullet1.speed, { x:x + dx, y:y + dy} );
						
						/*       Bullet 2      */
						radians = (img.angle+100) * Math.PI / 180;
						dx=distance*Math.cos(radians);
						dy=-1*distance*Math.sin(radians);
						var bullet2:Bullet = new Bullet(x, y);
						bullet2.destination = new Point(x + dx,y+dy);
						GameWorld.ref.add(bullet2);
						TweenMax.to(bullet2, distance / bullet2.speed, { x:x + dx, y:y + dy} );
						
						/*       Bullet 4      */
						radians = (img.angle+85) * Math.PI / 180;
						dx=distance*Math.cos(radians);
						dy=-1*distance*Math.sin(radians);
						var bullet4:Bullet = new Bullet(x, y);
						bullet4.destination = new Point(x + dx,y+dy);
						GameWorld.ref.add(bullet4);
						TweenMax.to(bullet4, distance / bullet4.speed, { x:x + dx, y:y + dy} );
					
						/*       Bullet 5      */
						radians = (img.angle+95) * Math.PI / 180;
						dx=distance*Math.cos(radians);
						dy=-1*distance*Math.sin(radians);
						var bullet5:Bullet = new Bullet(x, y);
						bullet5.destination = new Point(x + dx,y+dy);
						GameWorld.ref.add(bullet5);
						TweenMax.to(bullet5, distance / bullet5.speed, { x:x + dx, y:y + dy } );
						
						/*       Bullet 3      */
						radians = (img.angle+80) * Math.PI / 180;
						dx=distance*Math.cos(radians);
						dy=-1*distance*Math.sin(radians);
						var bullet3:Bullet = new Bullet(x, y);
						bullet3.destination = new Point(x + dx,y+dy);
						GameWorld.ref.add(bullet3);
						TweenMax.to(bullet3, distance / bullet3.speed, { x:x + dx, y:y + dy} );
						canShoot = false;
						TweenMax.delayedCall(0.5, setCanShoot);
					}
				}
			}
			if (Input.pressed(Key.P))
			{
				FP.console.enable();
				for (var i:int = 0; i < GameWorld.ref.ennemys.length; i++)
				{
					
						GameWorld.ref.ennemys[i].speed = 0; 
						GameWorld.ref.freeze = true;
						
				}
			}
			
			if (Input.pressed(Key.SPACE))
			{	
				if (katana)
				{
					var nb:int = 0;
					katanaMode = true;
					for (var i:int = 0; i < GameWorld.ref.ennemys.length; i++)
					{
						if (GameWorld.ref.ennemys[i].pointDeVie > 0)
						{
							TweenMax.delayedCall(0.1*nb, killAllEnnemy,[GameWorld.ref.ennemys[i]]);
							
							GameWorld.ref.ennemys[i].speed = 0; 
							GameWorld.ref.freeze = true;
							nb++;
							if (i == GameWorld.ref.ennemys.length - 1)
								TweenMax.delayedCall(0.2+(0.1*nb), resetCanSpawn);
						}
					}
				}
			}
			if (Input.pressed(Key.TAB))
			{
				if (shotgun)
					shotgun = false;
				else
					shotgun = true;
			}
			
		}
		
		public function killAllEnnemy(ennemy:Entity):void 
		{

			img.angle = FP.angle(x, y, ennemy.x, ennemy.y) - 90;
			TweenMax.to(this, 0.1, { x:x + (ennemy.x - x), y:y + (ennemy.y - y) } );	
		
		}
		
		public function resetCanSpawn():void 
		{
			GameWorld.ref.freeze = false;
			katanaMode = false;
			katana = false;
			for (var i:int = 0; i < GameWorld.ref.ennemys.length; i++)
			{
				GameWorld.ref.ennemys[i].speed = 2; 
				if (GameWorld.ref.ennemys[i].pointDeVie > 0) {
					GameWorld.ref.ennemys[i].pointDeVie = 0;
					GameWorld.ref.remove(GameWorld.ref.ennemys[i]);
				}
			}
		}
		
		private function setCanShoot():void 
		{
			canShoot = true;
		}
		
		public function LookAtMouse():void 
		{			
			img.angle = FP.angle(x, y, Input.mouseX, Input.mouseY) - 90;	
		}
		
	}

}