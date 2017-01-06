package states;

import flixel.FlxG;
import flixel.FlxState;
import flixel.group.FlxGroup;
import actors.Player;
import misc.Utils;
import misc.Hud;
import misc.MapHandler;
import flixel.FlxSprite;
import flixel.math.FlxPoint;
import flixel.tile.FlxBaseTilemap.FlxTilemapDiagonalPolicy;
import flixel.ui.FlxButton;
import states.MenuState;
import Reg;

class PlayState extends FlxState
{
	public var actors:FlxGroup;
	public var player:Player;
	public var map:MapHandler;
	public var hud:Hud;
	public var pauseButton:FlxButton;

	private var targetSpr:FlxSprite;

	override public function create():Void
	{
		map = Reg.db.getMaps()[0];
		add(map.backgroundtiles);
		add(map.nogotiles);

		actors = new FlxGroup();
		trace("[*] Adding NPCs to map");
		for (id in map.ent_pos.keys())
		{
			var pos:FlxPoint = map.ent_pos[id];
			var npc = Utils.getNPCFromId(Reg.npcs, id);
			npc.setCellPosition(Std.int(pos.x), Std.int(pos.y));
			add(npc.copy());
		}
		trace("[+] NPCs added");

		player = new Player(map.player_spawn.x, map.player_spawn.y);
		actors.add(player);
		add(player);
		trace("[+] Added player");

		targetSpr = new FlxSprite(player.getPosition().x, player.getPosition().y);
		targetSpr.loadGraphic(AssetPaths.target__png, false, 32, 32);
		add(targetSpr);

		hud = new Hud();
		add(hud);

		pauseButton = new FlxButton(FlxG.width-80, 0, "Pause", onPause);
		add(pauseButton);

		add(Reg.log);

		FlxG.camera.follow(player, LOCKON, 1);
		FlxG.camera.setScrollBoundsRect(0, 0, map.fullWidth, map.fullHeight);
		FlxG.worldBounds.set(0, 0, map.fullWidth, map.fullHeight);

		super.create();
	}

	public function mouseEventHandler(elapsed:Float)
	{
		var condition:Bool;
		var cellPos:FlxPoint = new FlxPoint();
		#if desktop
		condition = FlxG.mouse.justPressed;
		cellPos = Utils.getCellFromPosition(FlxG.mouse.getPosition());
		#end
		#if android
		condition = false;
		for (touch in FlxG.touches.list)
		{
			if (touch.justPressed)
			{
				condition = true;
				cellPos = Utils.getCellFromPosition(FlxPoint.get(touch.x, touch.y));
			}
		}
		#end
		if (condition && !hud.opened)
		{
			trace("cellx: "+cellPos.x+" celly: "+cellPos.y);
			var coords = Utils.getMidpointFromCellCoords(cellPos);
			if (map.nogotiles.getTile(Std.int(cellPos.x), Std.int(cellPos.y)) == 0 && 
				map.backgroundtiles.getTile(Std.int(cellPos.x), Std.int(cellPos.y)) != 0)
			{
				var nodes = map.nogotiles.findPath(player.getMidpoint(), coords, false, false, FlxTilemapDiagonalPolicy.WIDE);
				var npc = Utils.getNPCFromPos(Reg.npcs, cellPos);
				if (npc != null)
				{
					nodes.pop();
					trace("You clicked on : "+npc.name);
					Reg.log.log("["+npc.quickname+"] : "+npc.greeting);
					hud.drawButtons(npc.choices, npc.actions);
				} 
				player.path.start(nodes);
				targetSpr.setPosition(cellPos.x*32, cellPos.y*32);
			}
		}
	}

	public function onPause()
	{
		FlxG.switchState(new MenuState());
	}

	override public function update(elapsed:Float):Void
	{
		mouseEventHandler(elapsed);
		super.update(elapsed);
	}
}
