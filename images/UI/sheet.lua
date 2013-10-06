--
-- created with TexturePacker (http://www.codeandweb.com/texturepacker)
--
-- $TexturePacker:SmartUpdate:199f2bac2ed21333028f10a688645476:1/1$
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
            -- bar_credits
            x=85,
            y=247,
            width=81,
            height=33,

            sourceX = 1,
            sourceY = 4,
            sourceWidth = 97,
            sourceHeight = 51
        },
        {
            -- bar_level_empty
            x=85,
            y=46,
            width=113,
            height=42,

            sourceX = 6,
            sourceY = 1,
            sourceWidth = 133,
            sourceHeight = 48
        },
        {
            -- bar_level_full
            x=85,
            y=2,
            width=113,
            height=42,

            sourceX = 4,
            sourceY = 12,
            sourceWidth = 133,
            sourceHeight = 72
        },
        {
            -- bar_luck_empty
            x=34,
            y=2,
            width=30,
            height=392,

            sourceX = 0,
            sourceY = 0,
            sourceWidth = 36,
            sourceHeight = 396
        },
        {
            -- bar_luck_full
            x=2,
            y=2,
            width=30,
            height=392,

            sourceX = 0,
            sourceY = 0,
            sourceWidth = 36,
            sourceHeight = 396
        },
        {
            -- bar_win
            x=2,
            y=471,
            width=81,
            height=34,

            sourceX = 0,
            sourceY = 4,
            sourceWidth = 89,
            sourceHeight = 50
        },
        {
            -- button_add
            x=227,
            y=2,
            width=21,
            height=22,

            sourceX = 0,
            sourceY = 0,
            sourceWidth = 27,
            sourceHeight = 24
        },
        {
            -- button_add_pressed
            x=200,
            y=2,
            width=25,
            height=25,

        },
        {
            -- button_bet
            x=85,
            y=191,
            width=87,
            height=54,

            sourceX = 0,
            sourceY = 0,
            sourceWidth = 95,
            sourceHeight = 56
        },
        {
            -- button_bet_pressed
            x=85,
            y=90,
            width=103,
            height=57,

            sourceX = 0,
            sourceY = 0,
            sourceWidth = 109,
            sourceHeight = 65
        },
        {
            -- button_menu
            x=177,
            y=152,
            width=75,
            height=34,

            sourceX = 0,
            sourceY = 0,
            sourceWidth = 85,
            sourceHeight = 38
        },
        {
            -- button_menu_pressed
            x=85,
            y=149,
            width=90,
            height=40,

            sourceX = 0,
            sourceY = 0,
            sourceWidth = 100,
            sourceHeight = 50
        },
        {
            -- button_spin
            x=190,
            y=90,
            width=61,
            height=60,

            sourceX = 0,
            sourceY = 0,
            sourceWidth = 75,
            sourceHeight = 64
        },
        {
            -- button_spin_autospin
            x=177,
            y=188,
            width=69,
            height=68,

            sourceX = 0,
            sourceY = 0,
            sourceWidth = 79,
            sourceHeight = 72
        },
        {
            -- button_spin_pressed
            x=2,
            y=396,
            width=72,
            height=73,

            sourceX = 0,
            sourceY = 0,
            sourceWidth = 78,
            sourceHeight = 81
        },
    },
    
    sheetContentWidth = 256,
    sheetContentHeight = 512
}

SheetInfo.frameIndex =
{

    ["bar_credits"] = 1,
    ["bar_level_empty"] = 2,
    ["bar_level_full"] = 3,
    ["bar_luck_empty"] = 4,
    ["bar_luck_full"] = 5,
    ["bar_win"] = 6,
    ["button_add"] = 7,
    ["button_add_pressed"] = 8,
    ["button_bet"] = 9,
    ["button_bet_pressed"] = 10,
    ["button_menu"] = 11,
    ["button_menu_pressed"] = 12,
    ["button_spin"] = 13,
    ["button_spin_autospin"] = 14,
    ["button_spin_pressed"] = 15,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
