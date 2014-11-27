package  
{
	import com.greensock.TweenMax;
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
			
			setHitbox(img.width, img.height,img.width/2, img.height/2);
			type = "player";
			
		}
		
		
		override public function update():void
		{
			super.update();
			if (!katana)
			{
				LookAtMouse();
			}
			//Input.check détecte si la touche est enfoncé, plus pour les déplacement et Input.pressed détecte l'action d'appuyer
			if (Input.check(Key.D))
			{
				if (!collide("wall", x+speed, y))
				{
					x += speed;	
				}
			}
			if (Input.check(Key.Q))
			{
				if (!collide("wall", x-speed, y))
				{
					x -= speed;	
				}
			}
			if (Input.check(Key.Z))
			{
				if (!collide("wall", x, y-speed))
				{
					y -= speed;	
				}
			}
			if (Input.check(Key.S))
			{
				if (!collide("wall", x, y+speed))
				{
					y += speed;	
				}
			}
			var ennemy:Ennemy = collide("ennemy", x, y) as Ennemy;
			if (ennemy != null)
			{
				if (katana)
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
						var bullet:Bullet = new Bullet(x, y);
						GameWorld.ref.add(bullet);
						var dist:Number = Math.sqrt((Input.mouseX - x) * (Input.mouseX - x) + (Input.mouseY - y) * (Input.mouseY - y));
						TweenMax.to(bullet, dist / bullet.speed, { x:x + (Input.mouseX - x) * 10, y:y + (Input.mouseY - y) * 10 } );
						canShoot = false;
						TweenMax.delayedCall(fireRate, setCanShoot);
					}
					else
					{
						var modifx:int;
						var modify:int;
						
						/*if (!((Input.mouseX > x) && (Input.mouseY < y)) || ((Input.mouseX < x) && (Input.mouseY > y )))
						{
							var bullet1:Bullet = new Bullet(x, y);
							GameWorld.ref.add(bullet1);
							var dist:Number = Math.sqrt((Input.mouseX - x) * (Input.mouseX - x) + (Input.mouseY - y) * (Input.mouseY - y));
							TweenMax.to(bullet1, dist / bullet1.speed, { x:x + (Input.mouseX - x) * 10, y:y + (Input.mouseY - y) * 10 } );
							
							var bullet2:Bullet = new Bullet(x, y);
							GameWorld.ref.add(bullet2);
							TweenMax.to(bullet2, dist / bullet2.speed, { x:x + (Input.mouseX - x+(Input.mouseX/800)*100) * 10, y:y + (Input.mouseY - y-(Input.mouseY/600)*100) * 10 } );
							
							var bullet3:Bullet = new Bullet(x, y);
							GameWorld.ref.add(bullet3);
							TweenMax.to(bullet3, dist / bullet3.speed, { x:x + (Input.mouseX - x-(Input.mouseX/800)*100) * 10, y:y + (Input.mouseY - y+(Input.mouseY/600)*100) * 10 } );
						}
						else 
						{*/
							var bullet1:Bullet = new Bullet(x, y);
							GameWorld.ref.add(bullet1);
							var dist:Number = Math.sqrt((Input.mouseX - x) * (Input.mouseX - x) + (Input.mouseY - y) * (Input.mouseY - y));
							TweenMax.to(bullet1, dist / bullet1.speed, { x:x + (Input.mouseX - x) * 10, y:y + (Input.mouseY - y) * 10 } );
							
							var bullet2:Bullet = new Bullet(x, y);
							GameWorld.ref.add(bullet2);
							TweenMax.to(bullet2, dist / bullet2.speed, { x:x + (Input.mouseX- x+(Input.mouseX/800)*100) * 10, y:y + (Input.mouseY - y+(Input.mouseY/600)*100) * 10 } );
							
							var bullet3:Bullet = new Bullet(x, y);
							GameWorld.ref.add(bullet3);
							TweenMax.to(bullet3, dist / bullet3.speed, { x:x + (Input.mouseX - x-(Input.mouseX/800)*100) * 10, y:y + (Input.mouseY - y-(Input.mouseY/600)*100) * 10 } );
						//}
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
				var nb:int = 0;
				for (var i:int = 0; i < GameWorld.ref.ennemys.length; i++)
				{
					if (GameWorld.ref.ennemys[i].pointDeVie > 0)
					{
						TweenMax.delayedCall(0.1*nb, killAllEnnemy,[GameWorld.ref.ennemys[i]]);
						katana = true;
						GameWorld.ref.ennemys[i].speed = 0; 
						GameWorld.ref.freeze = true;
						nb++;
						if (i == GameWorld.ref.ennemys.length - 1)
							TweenMax.delayedCall(0.2+(0.1*nb), resetCanSpawn);
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