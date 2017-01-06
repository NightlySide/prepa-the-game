package ;

import flixel.group.FlxGroup;
import actors.NPC;
import misc.Database;
import misc.MapHandler;
import misc.Logs;

class Reg 
{
    public static var maps:Array<MapHandler>;
    public static var dialogs:Map<Int, Array<String>>;
    public static var npcs:FlxTypedGroup<NPC>;
    public static var db:Database;
    public static var log:Logs;

    public static function init()
    {
        log = new Logs();
        db   = new Database();
        npcs = db.getNPCs();
		maps = db.getMaps();
        dialogs = db.getDialogs();
    }
}