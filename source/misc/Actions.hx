package misc;

import actors.NPC;

enum ActionType {
    DIALOG;
    QUEST;
    OBJECT;
}

class Actions
{
    public var type:ActionType;
    public var id:Int;
    public var owner:NPC;

    public function new(npc:NPC, action_type:String, action_id:Int)
    {
        switch(action_type)
        {
            case "dialog":
                type = DIALOG;
            case "quest":
                type = QUEST;
            case "object":
                type = OBJECT;
        }
        id = action_id;
        owner = npc;
    }

    public function execute()
    {
        //trace("Execution");
    }
}

class Dialog extends Actions
{
    public var lines:Array<String>;

    public function new(npc:NPC, action_id:Int)
    {
        super(npc, "dialog", action_id);
        lines = Reg.db.getDialogs().get(action_id);
    }

    override public function execute()
    {
        super.execute();
        var time = 0.0;
        for(line in lines)
        {
            //25 lettres par sec
            var t = line.length/10;
            haxe.Timer.delay(function () {
                Reg.log.log("["+owner.quickname+"] : "+line, t+3);
            }, Std.int(time*1000));
            time += t;
        }
    }
}