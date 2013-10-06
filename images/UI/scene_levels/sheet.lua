--
-- created with TexturePacker (http://www.codeandweb.com/texturepacker)
--
-- $TexturePacker:SmartUpdate:6f85215887ecafd2e600b2e6e0d9a29c:1/1$
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
            -- icon_theme_level_01
            x=364,
            y=2,
            width=125,
            height=139,

            sourceX = 0,
            sourceY = 2,
            sourceWidth = 151,
            sourceHeight = 143
        },
        {
            -- icon_theme_level_02
            x=2,
            y=574,
            width=148,
            height=137,

        },
        {
            -- lock
            x=480,
            y=143,
            width=30,
            height=38,

        },
        {
            -- text_box
            x=364,
            y=143,
            width=114,
            height=95,

        },
    },
    
    sheetContentWidth = 512,
    sheetContentHeight = 1024
}

SheetInfo.frameIndex =
{

    ["bg"] = 1,
    ["icon_theme_level_01"] = 2,
    ["icon_theme_level_02"] = 3,
    ["lock"] = 4,
    ["text_box"] = 5,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
