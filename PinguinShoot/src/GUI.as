package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.Mask;
	
	/**
	 * ...
	 * @author benjamin LEFEVRE
	 */
	public class GUI extends Entity 
	{
		public var text:Text;
		
		public function GUI(x:Number=0, y:Number=0, graphic:Graphic=null, mask:Mask=null) 
		{
			super(x, y, graphic, mask);
			
		}	
		
		override public function added():void
		{
			super.added();
			text = new Text("", x, y);
			graphic = text;
			
		}
		public function setText(value:String)
		{
			text.text = value;
		}
	}

}