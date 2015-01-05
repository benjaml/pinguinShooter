package  
{
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.Mask;
	
	/**
	 * ...
	 * @author ...
	 */
	public class Speedy extends Ennemy 
	{
		
		public function Speedy(x:Number=0, y:Number=0, graphic:Graphic=null, mask:Mask=null) 
		{
			super(x, y, graphic, mask);
			speed = 5;
			pointDeVie = 1;
		}
		override public function added():void
		{
			super.added();
			var img:Image = Image.createRect(30, 40, 0x00FFF0);
			
			graphic = img;
			
			setHitbox(img.width, img.height);
			type = "ennemy";
		}
		
	}

}