package  
{
	import flash.text.Font;
	import net.flashpunk.FP;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import net.flashpunk.World;
	
	/**
	 * ...
	 * @author benjamin LEFEVRE
	 */
	public class MainMenuWorld extends World 
	{
		public var test:GUI ;
		public var titre:GUI ;
		public function MainMenuWorld() 
		{
			super();
			test = new GUI(200, 150);
			test.layer = -1000;
			add(test);
			titre = new GUI(200, 125);
			titre.layer = -1000;
			add(titre);
		}
		
		override public function update():void
		{
			super.update();
			titre.text.size = 30;
			titre.text.centerOrigin();
			titre.setText("PINGUIN SHOOT");
			test.text.centerOrigin();
			test.setText("Press ENTER to continue");
			if (Input.pressed(Key.ENTER))
			{
				//if (GameWorld.ref.boss) {
					//GameWorld.ref.remove(GameWorld.ref.boss);
				//}
				FP.world = new GameWorld();
			}
		
		}
		
	}

}