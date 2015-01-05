package  
{
	import com.greensock.TweenMax;
	import flash.geom.Point;
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.Mask;
	
	/**
	 * ...
	 * @author benjamin LEFEVRE
	 */
	public class BulletIA extends Entity 
	{
		
		public var speed:Number;
		public var TimeCreate:Number;
		public var ShootDuration:Number;
		public var destination:Point;
		public var tag:String;
		
		public function BulletIA(x:Number=0, y:Number=0, graphic:Graphic=null, mask:Mask=null) 
		{
			super(x, y, graphic, mask);
			speed = 500;
			
		}
		override public function added():void
		{
			super.added();
			var img:Image = Image.createRect(10, 5, 0x00FF00);
			img.centerOrigin();
			graphic = img;
			
			img.angle = GameWorld.ref.player.img.angle+90;
			setHitbox(img.height, img.height,img.height/2, img.height/2);
			type = "bullet";
			TweenMax.delayedCall(5,die);
		}
		
		private function die():void 
		{
			GameWorld.ref.remove(this);
		}
		
	}

}