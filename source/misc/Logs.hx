package misc;

import flixel.group.FlxGroup;
import flixel.FlxSprite;
import flixel.text.FlxText;
import flixel.math.FlxPoint;

class Logs extends FlxTypedGroup<FlxSprite>
{
    public var logs:Array<String>;
    public var time:Array<Float>;
    public var texts:Array<FlxText>;
    public var sizeLim:Int = 8;
    public var offset:FlxPoint;
    public var lifetime:Array<Float>;

    public function new()
    {
        logs = new Array<String>();
        time = new Array<Float>();
        lifetime = new Array<Float>();
        texts = new Array<FlxText>();
        offset = new FlxPoint(0, 0);
        super();
    }

    public function redraw()
    {
        forEach(function(spr:FlxSprite){
            remove(spr);
        });
        for (k in 0...logs.length)
        {
            var txt = new FlxText(0, (logs.length-k-1)*10, 0, logs[k], 8);
            texts.push(txt);
            add(txt);
        }
        normalize();
    }

    public function log(msg:String, lifet:Float = 5.0)
    {
        if (logs.length < 8)
        {
            logs.push(msg);
            time.push(Date.now().getTime());
            lifetime.push(lifet);
            redraw();
        } else {
            logs.shift();
            time.shift();
            lifetime.shift();
            log(msg, lifet);
            return;
        }
    }

    private function normalize()
    {
        forEach(function(spr:FlxSprite)
		{
			spr.scrollFactor.set(0, 0);
            spr.x += offset.x;
            spr.y += offset.y;
		});
    }

    override public function update(elapsed:Float)
    {
        super.update(elapsed);
        if (time.length != 0)
        {
            var t = Date.now().getTime();
            if (t - time[0] > lifetime[0] * 1000)
            {
                time.shift();
                logs.shift();
                lifetime.shift();
                texts[0].destroy();
                texts.pop();
            }
            redraw();
        }
    }
}