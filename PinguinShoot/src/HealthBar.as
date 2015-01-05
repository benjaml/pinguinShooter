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
	public class HealthBar extends Entity 
	{
		public var background:Image;
		public var img:Image;
		public function HealthBar(x:Number=0, y:Number=0, graphic:Graphic=null, mask:Mask=null) 
		{
			super(x, y, graphic, mask);

			
		}
		override public function added():void {
			super.added();
			background = new Image(Embed.BACKGROUND);
			addGraphic(background);
			img = Image.createRect(500, 50, 0xff0000, 1);
			img.originX = -22.5;
			img.originY = -12.5;
			addGraphic(img);
		}
		
		override public function update():void {
			super.update();
			img.originX = -22.5/img.scaleX;
			img.originY = -12.5/img.scaleY;
		}
	}

}