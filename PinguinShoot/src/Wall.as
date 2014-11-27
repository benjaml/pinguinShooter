package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	
	/**
	 * ...
	 * @author benjamin LEFEVRE
	 */
	public class Wall extends Entity 
	{
		
		var RightWall:Entity;
		var LeftWall:Entity;
		var TopWall:Entity;
		var BotWall:Entity;
		
		public function Wall(x:Number=0, y:Number=0, graphic:Graphic=null, mask:Mask=null) 
		{
			super(x, y, graphic, mask);
			
		}
		override public function added():void
		{
			super.added();
			RightWall = new Entity(FP.width, 0);
			RightWall.setHitbox(100, FP.height);
			RightWall.type = "wall";
			GameWorld.ref.add(RightWall);
			LeftWall = new Entity(-100, 0);
			LeftWall.setHitbox(100, FP.height);
			LeftWall.type = "wall";
			GameWorld.ref.add(LeftWall);
			TopWall = new Entity(0, -100);
			TopWall.setHitbox(FP.width, 100);
			TopWall.type = "wall";
			GameWorld.ref.add(TopWall);
			BotWall = new Entity(0, FP.height);
			BotWall.setHitbox(FP.width, 100);
			BotWall.type = "wall";
			GameWorld.ref.add(BotWall);
		}
		
	}

}