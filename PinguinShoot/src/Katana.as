package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.Mask;
	
	/**
	 * ...
	 * @author ...
	 */
	public class Katana extends Entity 
	{
		var img:Image;
		public function Katana(x:Number=0, y:Number=0, graphic:Graphic=null, mask:Mask=null) 
		{
			super(x, y, graphic, mask);
			
		}
		override public function added():void
		{
			super.added();
			img= new Image(Embed.KATANA);
			img.centerOrigin();
			graphic = img;
			
			setHitbox(img.width, img.height,img.width/2, img.height/2);
			type = "katana";
			
		}
		override public function update():void
		{
			var player:Player = collide("player",x,y) as Player;
			if (player)
			{
				player.katana = true;
				GameWorld.ref.remove(this);
			}	
			
		}
		
	}

}