package misc;

import flixel.math.FlxPoint;
import flixel.group.FlxGroup;
import actors.NPC;

class Utils 
{
    public static function getCellFromPosition(position:FlxPoint, cellWidth:Int = 32)
    {
        var newX = Std.int(position.x/cellWidth);
        var newY = Std.int(position.y/cellWidth);
        return new FlxPoint(newX, newY);
    }

    public static function getMidpointFromCellCoords(position:FlxPoint, cellWidth:Int = 32)
    {
        var newX = Std.int(position.x * cellWidth + cellWidth / 2);
        var newY = Std.int(position.y * cellWidth + cellWidth / 2);
        return new FlxPoint(newX, newY);
    }

    public static function getPositionFromCellCoords(position:FlxPoint, cellWidth:Int = 32)
    {
        var newX = position.x * cellWidth;
        var newY = position.y * cellWidth;
        return new FlxPoint(newX, newY);
    }

    public static function getNPCFromId(npcs:FlxTypedGroup<NPC>, id:Int):NPC
    {
        for (npc in npcs)
            if (npc.id == id)
                return npc;
        return null;
    }

    public static function getNPCFromPos(npcs:FlxTypedGroup<NPC>, position:FlxPoint):NPC
    {
        for (npc in npcs)
            if (npc.cellPosition.equals(position))
                return npc;
        return null;
    }

    public static function getMapFromId(id:Int):MapHandler
    {
        for (map in Reg.maps)
            if (map.id == id)
                return map;
        return null;
    }
}