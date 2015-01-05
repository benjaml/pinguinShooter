package  
{
	import com.greensock.easing.Bounce;
	import com.greensock.easing.Expo;
	import com.greensock.easing.Linear;
	import com.greensock.TweenMax;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import net.flashpunk.World;
	
	/**
	 * ...
	 * @author benjamin LEFEVRE
	 */
	public class GameWorld extends World 
	{	
		public var freeze:Boolean;
		public var canSpawn:Boolean;
		public var canSpawnSpeedy:Boolean;
		public static var ref:GameWorld;
		public var player:Player;
		public var boss:Boss;
		public var ennemy:Ennemy;
		public var remaining:int;
		public var healthBar:HealthBar;
		var test:GUI ;
		public var ennemys:Vector.<Ennemy>;
		public var spawnSpeedy:Boolean;
		// pour les tableau, Array ( pas de type, pas de tailles), Vector.<> (typé, pas de taille)
		
		// Vector.<>, Push, ajoute un elem; Pop, retire le dernier elem; Lenght, taille;
		
		public function GameWorld() 
		{
			super();
			freeze = false;
			ennemys = new Vector.<Ennemy>();
			ref = this;
			canSpawn = true;
			canSpawnSpeedy = false;
			remaining = 1;
		}
		// begin ce lance quand le world est choisis comme world courant
		override public function begin():void
		{
			super.begin();
			
			player = new Player(FP.width/2, FP.height/2);
			add(player);
			
			test = new GUI(20,20);
			test.layer = -1000;
			add(test);
			TweenMax.delayedCall(15, spawnKatana);
			
		}
		
		public function spawnKatana():void 
		{
			if (remaining > 1) {
				add(new Katana(Math.random() * 750, Math.random() * 550));
				TweenMax.delayedCall(15, spawnKatana);
			}
			
			
		}
		
		override public function update():void
		{
			
			super.update();
			if (boss) {
				FP.console.log("il y a un boss");
				if (boss.PV <= 0) {
					remove(boss);
				}
			}
			if (remaining < 99)	
				canSpawnSpeedy = true;
				
			test.setText("remaining : "+remaining);
			if (canSpawn && remaining > 0 && ! freeze)
			{
				if (remaining == 1)
				{
					ennemy = new Boss(-300, FP.height/2-150);
					ennemy.setTarget(player);
					add(ennemy);
					remaining--;	
					
				}
				else
				{
					spawnSpeedy = false;
					if (canSpawnSpeedy)
						if (Math.random() > 0.5)
							spawnSpeedy = true;
				
					var random:Number = Math.random();
					if (random < 0.25)
					{
						var X:int = -(Math.random() * 50);
						var Y:int = (Math.random() * 600);
					}
					else if( random < 0.5 &&  random >= 0.25 )
					{
						var X:int = 800 + (Math.random() * 50);
						var Y:int = (Math.random() * 600);

					}
					else if ( random < 0.75 &&  random >= 0.5)
					{
						var X:int = (Math.random() * 800);
						var Y:int = -(Math.random() * 50);
					}
					else
					{
						var X:int = (Math.random() * 800);
						var Y:int = 600+(Math.random() * 50);

					}
					
					if (!spawnSpeedy)
					{
						ennemy = new Ennemy(X, Y);
						ennemy.setTarget(player);
						add(ennemy);
					}
					else {
						ennemy = new Speedy(X, Y);
						ennemy.setTarget(player);
						add(ennemy);
					}
					ennemys.push(ennemy); 
					remaining--;
					canSpawn = false;
					TweenMax.delayedCall(1, setCanSpawn);
				}
				
			}

			
		}
		private function setCanSpawn():void 
		{
			canSpawn = true;
		}
		private function redescendrePlayer():void 
		{
			if (player.y < 300)
			{
				TweenMax.to(player, 0.2, {y:300,ease:Bounce.easeOut});
		
			}
			else
			{
				TweenMax.to(player, 0.2, {y:300,ease:Bounce.easeIn});
			}
		}
		
	}

}