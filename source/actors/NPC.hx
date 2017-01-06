package actors;

import flixel.FlxSprite;
import flixel.math.FlxPoint;
import misc.Utils;
import misc.Actions;

class NPC extends FlxSprite 
{
    public var id:Int;
    public var name:String = "";
    public var quickname:String = "";
    public var spritePath:String;
    public var cellPosition:FlxPoint;
    public var greeting:String = "";
    public var choices:Array<String>;
    public var actions:Array<Actions>;

    public function new(d_ID:Int, sprPath:String, W:Int=32, H:Int=32)
	{
        choices = new Array<String>();
        actions = new Array<Actions>();
        cellPosition = FlxPoint.get(0, 0);
        var coords = Utils.getPositionFromCellCoords(cellPosition);
        super(coords.x, coords.y);
        loadGraphic("assets/images/"+sprPath);
        spritePath = sprPath;
        id = d_ID;
    }

    public function setCellPosition(X:Int, Y:Int)
    {
        cellPosition = FlxPoint.get(X, Y);
        var pos = Utils.getPositionFromCellCoords(cellPosition);
        setPosition(pos.x, pos.y);
    }

    override public function update(elapsed:Float)
    {
        super.update(elapsed);
    }

    public function copy():NPC
    {
        var npc:NPC = new NPC(id, spritePath, 32, 32);
        npc.name = name;
        npc.quickname = quickname;
        npc.setCellPosition(Std.int(cellPosition.x), Std.int(cellPosition.y));
        npc.greeting = greeting;
        npc.choices = choices;
        npc.actions = actions;
        return npc;
    }
}