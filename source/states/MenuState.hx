package states;

import flixel.FlxG;
import flixel.math.FlxPoint;
import flixel.FlxState;
import flixel.ui.FlxButton;
import flixel.text.FlxText;
import flixel.util.FlxSave;
import flixel.FlxSprite;
import openfl.system.System;
import states.PlayState;

class MenuState extends FlxState
{
	private var offset:FlxPoint;
	public var gameSave:FlxSave;

	override public function create():Void
	{
		gameSave = new FlxSave();
		gameSave.bind("globalSave");
		offset = new FlxPoint(40, FlxG.height/2);

		var logo = new FlxSprite(50, 100, AssetPaths.logo__png);
		add(logo);

		var newPlayBtn = new FlxButton(offset.x, offset.y, "", newGame);
		newPlayBtn.setGraphicSize(FlxG.width-80, 35);
		newPlayBtn.updateHitbox();
		newPlayBtn.label = new FlxText(0, 4, newPlayBtn.width, "Nouvelle Partie");
        newPlayBtn.label.setFormat(null, 8, 0x333333, "center");
		newPlayBtn.label.offset.set(0, -15/2);
		add(newPlayBtn);
		
		var loadBtn = new FlxButton(offset.x, offset.y+40, "", loadGame);
		loadBtn.setGraphicSize(FlxG.width-80, 35);
		loadBtn.updateHitbox();
		loadBtn.label = new FlxText(0, 4, loadBtn.width, "Continuer");
        loadBtn.label.setFormat(null, 8, 0x333333, "center");
		loadBtn.label.offset.set(0, -15/2);
		add(loadBtn);

		var optBtn = new FlxButton(offset.x, offset.y+2*40, "");
		optBtn.setGraphicSize(Std.int((FlxG.width-85)/2), 35);
		optBtn.updateHitbox();
		optBtn.label = new FlxText(0, 4, optBtn.width, "Options");
        optBtn.label.setFormat(null, 8, 0x333333, "center");
		optBtn.label.offset.set(0, -15/2);
		add(optBtn);

		var quitBtn = new FlxButton(offset.x+(FlxG.width-75)/2, offset.y+2*40, "", quit);
		quitBtn.setGraphicSize(Std.int((FlxG.width-85)/2), 35);
		quitBtn.updateHitbox();
		quitBtn.label = new FlxText(0, 4, quitBtn.width, "Quitter");
        quitBtn.label.setFormat(null, 8, 0x333333, "center");
		quitBtn.label.offset.set(0, -15/2);
		add(quitBtn);

		super.create();
	}

	public function newGame()
	{
		FlxG.switchState(new PlayState());
	}

	public function loadGame()
	{

	}

	public function quit()
	{
		System.exit(0);
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}
}
