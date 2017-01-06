package actors;

import flixel.FlxSprite;
import flixel.util.FlxPath;
import flixel.math.FlxPoint;
import misc.Utils;

class Player extends FlxSprite
{

    public function new(?X:Float=0, ?Y:Float=0, W:Int=32, H:Int=32)
	{
        var coords = Utils.getPositionFromCellCoords(FlxPoint.get(X, Y));
        super(coords.x, coords.y);
        drag.set(400, 400);
        loadGraphic(AssetPaths.player__png);
        setGraphicSize(W, H);
        setSize(W, H);
        updateHitbox();
        path = new FlxPath();
    }

    override public function update(elapsed:Float)
    {
        super.update(elapsed);
        path.speed = 32 * 8;
        if (path.finished)
        {
            path.cancel();
            velocity.set(0, 0);
        }
    }
}
