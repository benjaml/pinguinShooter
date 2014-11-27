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
		public static var ref:GameWorld;
		public var player:Player;
		public var ennemy:Ennemy;
		public var wall:Wall;
		public var remaining:int;
		var test:GUI ;
		public var ennemys:Vector.<Ennemy>;
		// pour les tableau, Array ( pas de type, pas de tailles), Vector.<> (typé, pas de taille)
		
		// Vector.<>, Push, ajoute un elem; Pop, retire le dernier elem; Lenght, taille;
		
		public function GameWorld() 
		{
			super();
			freeze = false;
			ennemys = new Vector.<Ennemy>();
			ref = this;
			canSpawn = true;
			remaining = 50;
		}
		// begin ce lance quand le world est choisis comme world courant
		override public function begin():void
		{
				super.begin();
				
				
				
				player = new Player(FP.width/2, FP.height/2);
				add(player);
				 
				wall = new Wall(0, 0);
				add(wall);
				test = new GUI(20,20);
				test.layer = -1000;
				add(test);
				
		}
		
		override public function update():void
		{
			super.update();
			test.setText("remaining : "+remaining);
			if (canSpawn && remaining > 0 && ! freeze)
			{
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
				ennemy = new Ennemy(X, Y);
				ennemy.setTarget(player);
				add(ennemy);
				ennemys.push(ennemy); 
				remaining--;
				canSpawn = false;
				TweenMax.delayedCall(1, setCanSpawn);
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