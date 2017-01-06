package misc;

import flixel.FlxSprite;
import flixel.math.FlxPoint;
import flixel.FlxG;
import flixel.text.FlxText;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.ui.FlxButton;
import misc.Actions;

class Hud extends FlxTypedGroup<FlxSprite>
{
    public var buttons:Array<FlxButton>;
    public var offsetX:Int = 20;
    public var offsetY:Int = 280;
    public var opened:Bool = false;

    public function new()
    {
        super();
        buttons = new Array<FlxButton>();
    }

    public function drawButtons(texts:Array<String>, actions:Array<Actions>)
    {
        opened = true;
        for (k in 0...texts.length)
        {
            var btn = new FlxButton(0, k*40, "", actions[k].execute);
            btn.setGraphicSize(FlxG.width-40, 35);
            btn.updateHitbox();
            btn.label = new FlxText(0, 4, btn.width, texts[k]);
            btn.label.setFormat(null, 8, 0x333333, "center");
            btn.label.offset.set(0, -15/2);
            add(btn);
            buttons.push(btn);
        }
        var closebtn = new FlxButton(0, texts.length*40, "Fermer", close);
        closebtn.setPosition(FlxG.width-closebtn.width-40, closebtn.y);
        add(closebtn);
        buttons.push(closebtn);
        normalize();
    }

    public function close()
    {
        if (opened)
        {
            trace("Closing HUD");
            opened = false;
            forEach(function(spr:FlxSprite) {
                remove(spr);
            });
            buttons = new Array<FlxButton>();
            trace("HUD Closed");
        }
    }

    private function normalize()
    {
        forEach(function(spr:FlxSprite)
		{
			spr.scrollFactor.set(0, 0);
            spr.x += offsetX;
            spr.y += offsetY;
		});
    }
}
