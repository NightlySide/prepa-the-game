package;

import flixel.FlxGame;
import openfl.display.Sprite;
import states.MenuState;

class Main extends Sprite
{
	public function new()
	{
		super();
		trace("Launching the game...");
		Reg.init();
		
		addChild(new FlxGame(288, 480, MenuState));
	}
}
