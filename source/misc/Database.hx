package misc;

import actors.NPC;
import flixel.group.FlxGroup.FlxTypedGroup;
import misc.MapHandler;
import tjson.TJSON;
import openfl.Assets;
import flixel.math.FlxPoint;
import misc.Actions;

class Database 
{
    public var npc_data:Dynamic;
    public var map_data:Dynamic;
    public var dial_data:Dynamic;

    public function new()
    {
        trace("[*] Intializing JSON parsing");
        npc_data = TJSON.parse(Assets.getText("json/npc.json"));
        map_data = TJSON.parse(Assets.getText("json/maps.json"));
        dial_data = TJSON.parse(Assets.getText("json/dialogs.json"));
        trace("[+] Parsing done ");
    }

    public function getNPCs():FlxTypedGroup<NPC>
    {
        var npcs = new FlxTypedGroup<NPC>();
        var lines:Array<Dynamic> = npc_data.data; 
        trace("[+] Found "+lines.length+" npcs in database");
        for (row in lines)
        {
            //trace(row);
            var npc = new NPC(Std.parseInt(row.id), row.sprite, 32, 32);
            npc.name = row.name;
            npc.quickname = row.quickname;
            npc.greeting = row.greeting;
            var choices:Array<Dynamic> = row.choices;
            trace("[+] Found "+choices.length+" choices in npc");
            for (choice in choices)
            {
                npc.choices.push(choice.text);
                switch(choice.type)
                {
                    case "dialog":
                        npc.actions.push(new Dialog(npc, choice.id));
                    default:
                        npc.actions.push(new Actions(npc, choice.type, choice.id));
                }
            }
            npcs.add(npc);
        }
        return npcs;
    }

    public function getMaps():Array<MapHandler>
    {
        var maps = new Array<MapHandler>();
        var data:Array<Dynamic> = map_data.data;
        trace("[+] Found "+data.length+" maps in database");
        for (row in data)
        {
            var map = new MapHandler(row.id, Assets.getPath("maps/"+row.path));
            var entities:Array<Dynamic> = row.entities;
            map.player_spawn = FlxPoint.get(row.player_spawn.x, row.player_spawn.y);
            for (entity in entities)
            {
                map.ent_pos.set(entity.id, FlxPoint.get(entity.position.x, entity.position.y));
            }
            maps.push(map);
        }
        return maps;
    }

    public function getDialogs():Map<Int, Array<String>>
    {
        var dial = new Map<Int, Array<String>>();
        var data:Array<Dynamic> = dial_data.data;
        trace("[+] Found "+data.length+" dialogs in database");
        for (row in data)
        {
            var dialog = new Array<String>();
            var lines:Array<Dynamic> = row.lines;
            for (line in lines)
            {
                dialog.push(line);
            }
            dial.set(row.id, dialog);
        }
        return dial;
    }
}