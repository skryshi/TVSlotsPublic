--
-- created with TexturePacker (http://www.codeandweb.com/texturepacker)
--
-- $TexturePacker:SmartUpdate:37f644305e9d2ca179ad3e2a7dc3b8b8:1/1$
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
            y=65,
            width=61,
            height=55,

            sourceX = 0,
            sourceY = 3,
            sourceWidth = 63,
            sourceHeight = 63
        },
        {
            -- tile_02
            x=364,
            y=2,
            width=63,
            height=61,

            sourceX = 0,
            sourceY = 0,
            sourceWidth = 63,
            sourceHeight = 63
        },
        {
            -- tile_03
            x=364,
            y=226,
            width=59,
            height=55,

            sourceX = 0,
            sourceY = 3,
            sourceWidth = 63,
            sourceHeight = 63
        },
        {
            -- tile_04
            x=429,
            y=2,
            width=61,
            height=61,

            sourceX = 1,
            sourceY = 0,
            sourceWidth = 63,
            sourceHeight = 63
        },
        {
            -- tile_05
            x=364,
            y=283,
            width=43,
            height=61,

            sourceX = 11,
            sourceY = 0,
            sourceWidth = 63,
            sourceHeight = 63
        },
        {
            -- tile_06
            x=425,
            y=200,
            width=59,
            height=55,

            sourceX = 4,
            sourceY = 6,
            sourceWidth = 63,
            sourceHeight = 63
        },
        {
            -- tile_07
            x=364,
            y=122,
            width=61,
            height=43,

            sourceX = 1,
            sourceY = 9,
            sourceWidth = 63,
            sourceHeight = 63
        },
        {
            -- tile_08
            x=427,
            y=65,
            width=61,
            height=53,

            sourceX = 2,
            sourceY = 4,
            sourceWidth = 63,
            sourceHeight = 63
        },
        {
            -- tile_09
            x=425,
            y=257,
            width=57,
            height=61,

            sourceX = 1,
            sourceY = 0,
            sourceWidth = 63,
            sourceHeight = 63
        },
        {
            -- tile_10
            x=427,
            y=120,
            width=61,
            height=43,

            sourceX = 0,
            sourceY = 9,
            sourceWidth = 63,
            sourceHeight = 63
        },
        {
            -- tile_free_spin
            x=427,
            y=165,
            width=61,
            height=33,

            sourceX = 0,
            sourceY = 16,
            sourceWidth = 63,
            sourceHeight = 63
        },
        {
            -- tile_joker
            x=364,
            y=167,
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
