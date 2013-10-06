--
-- created with TexturePacker (http://www.codeandweb.com/texturepacker)
--
-- $TexturePacker:SmartUpdate:9f48fb5447d505637fcedf922ed55382:1/1$
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
            -- bg_320x480
            x=364,
            y=2,
            width=320,
            height=480,

        },
        {
            -- bg_360x570
            x=2,
            y=2,
            width=360,
            height=570,

        },
        {
            -- progress_bar_empty_130x30
            x=818,
            y=2,
            width=130,
            height=30,

        },
        {
            -- progress_bar_full_130x30
            x=686,
            y=2,
            width=130,
            height=30,

        },
        {
            -- text_bar_60_30
            x=950,
            y=2,
            width=60,
            height=30,

        },
        {
            -- text_bar_90_30
            x=686,
            y=34,
            width=90,
            height=30,

        },
    },
    
    sheetContentWidth = 1024,
    sheetContentHeight = 1024
}

SheetInfo.frameIndex =
{

    ["bg_320x480"] = 1,
    ["bg_360x570"] = 2,
    ["progress_bar_empty_130x30"] = 3,
    ["progress_bar_full_130x30"] = 4,
    ["text_bar_60_30"] = 5,
    ["text_bar_90_30"] = 6,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
