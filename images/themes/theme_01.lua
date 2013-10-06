--
-- created with TexturePacker (http://www.codeandweb.com/texturepacker)
--
-- $TexturePacker:SmartUpdate:bbd9c21d3b937117b4760cd62bcbb6be:1/1$
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
            -- tile_01
            x=364,
            y=2,
            width=63,
            height=64,

        },
        {
            -- tile_02
            x=429,
            y=2,
            width=63,
            height=63,

        },
        {
            -- tile_03
            x=364,
            y=235,
            width=63,
            height=47,

        },
        {
            -- tile_04
            x=429,
            y=184,
            width=63,
            height=52,

        },
        {
            -- tile_05
            x=364,
            y=68,
            width=63,
            height=58,

        },
        {
            -- tile_06
            x=364,
            y=284,
            width=63,
            height=44,

        },
        {
            -- tile_07
            x=429,
            y=130,
            width=63,
            height=52,

        },
        {
            -- tile_08
            x=364,
            y=186,
            width=63,
            height=47,

        },
        {
            -- tile_09
            x=429,
            y=67,
            width=63,
            height=61,

        },
        {
            -- tile_10
            x=429,
            y=238,
            width=63,
            height=45,

        },
        {
            -- tile_free_spin
            x=364,
            y=128,
            width=63,
            height=56,

        },
        {
            -- tile_joker
            x=429,
            y=285,
            width=59,
            height=57,

            sourceX = 3,
            sourceY = 4,
            sourceWidth = 63,
            sourceHeight = 63
        },
    },
    
    sheetContentWidth = 512,
    sheetContentHeight = 1024
}

SheetInfo.frameIndex =
{

    ["bg"] = 1,
    ["tile_01"] = 2,
    ["tile_02"] = 3,
    ["tile_03"] = 4,
    ["tile_04"] = 5,
    ["tile_05"] = 6,
    ["tile_06"] = 7,
    ["tile_07"] = 8,
    ["tile_08"] = 9,
    ["tile_09"] = 10,
    ["tile_10"] = 11,
    ["tile_free_spin"] = 12,
    ["tile_joker"] = 13,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
