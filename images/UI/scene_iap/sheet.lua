--
-- created with TexturePacker (http://www.codeandweb.com/texturepacker)
--
-- $TexturePacker:SmartUpdate:36204c2ed1d37e3464d68071837e4542:1/1$
--
-- local sheetInfo = require("mysheet")
-- local myImageSheet = graphics.newImageSheet( "mysheet.png", sheetInfo:getSheet() )
-- local sprite = display.newSprite( myImageSheet , {frames={sheetInfo:getFrameIndex("sprite")}} )
--

local SheetInfo = {}

SheetInfo.sheet =
{
    frames = {
    
        {
            -- bg
            x=2,
            y=2,
            width=360,
            height=570,

        },
        {
            -- button_buy
            x=2,
            y=639,
            width=307,
            height=65,

            sourceX = 1,
            sourceY = 0,
            sourceWidth = 309,
            sourceHeight = 65
        },
        {
            -- button_buy_pressed
            x=2,
            y=574,
            width=320,
            height=63,

            sourceX = 0,
            sourceY = 2,
            sourceWidth = 320,
            sourceHeight = 65
        },
    },
    
    sheetContentWidth = 512,
    sheetContentHeight = 1024
}

SheetInfo.frameIndex =
{

    ["bg"] = 1,
    ["button_buy"] = 2,
    ["button_buy_pressed"] = 3,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
