-- Copyright 2013 Arman Darini

local storyboard = require("storyboard")
local scene = storyboard.newScene()
storyboard.purgeOnSceneChange = true
local helpers = require("helpers")
local layers

local sheetLevelInfo = require("images.UI.scene_levels.sheet")
local sheetLevel = graphics.newImageSheet("images/UI/scene_levels/sheet.png", sheetLevelInfo:getSheet())

local sheetThemeInfo
local sheetTheme

local UIClass = require("ui_class")
local UI

local timers = {}

----------------------------------------------------------
local function showLevels()
	layers.content.levels = display.newGroup()
	layers.content:insert(layers.content.levels)
	for level = 1, #game.levels do
		table.insert(layers.content.levels, level, display.newGroup())
		
		local slotIdStr = (level < 10 and "0"..level or level)
		local frame = sheetLevelInfo:getFrameIndex("icon_theme_level_"..slotIdStr)
		layers.content.levels[level].icon = display.newImageRect(layers.content.levels[level], sheetLevel, frame, sheetLevelInfo:getSheet().frames[frame].width, sheetLevelInfo:getSheet().frames[frame].height)
		layers.content.levels[level].icon:setReferencePoint(display.CenterReferencePoint)

		if helpers.isLevelUnlocked(level) then
			layers.content.levels[level].level = level
			layers.content.levels[level]:addEventListener("tap", gotoLevel)
		else
			local frame = sheetLevelInfo:getFrameIndex("lock")
			layers.content.levels[level].lock = display.newImageRect(layers.content.levels[level], sheetLevel, frame, sheetLevelInfo:getSheet().frames[frame].width, sheetLevelInfo:getSheet().frames[frame].height)
			layers.content.levels[level].lock:setReferencePoint(display.CenterReferencePoint)
			layers.content.levels[level].lock:translate(0, 10)
			layers.content.levels[level].icon.alpha = 0.5
		end

		local frame = sheetLevelInfo:getFrameIndex("text_box")
		layers.content.levels[level].captionBg = display.newImageRect(layers.content.levels[level], sheetLevel, frame, sheetLevelInfo:getSheet().frames[frame].width, sheetLevelInfo:getSheet().frames[frame].height)
		layers.content.levels[level].captionBg:setReferencePoint(display.CenterReferencePoint)
		layers.content.levels[level].captionBg:translate(0, layers.content.levels[level].icon.height - 25)
		
		layers.content.levels[level].caption = display.newText(layers.content.levels[level], game.levels[level].description, 0, 0, 110, 0, game.font, 20)
		layers.content.levels[level].caption:setTextColor(0)
		layers.content.levels[level].caption:setReferencePoint(display.CenterReferencePoint)
		layers.content.levels[level].caption.x = layers.content.levels[level].captionBg.x + 5
		layers.content.levels[level].caption.y = layers.content.levels[level].captionBg.y
		
		layers.content.levels:insert(layers.content.levels[level])
		
		layers.content.levels[level]:translate((level - 1) * (layers.content.levels[level].width + 10),  -(level % 2 - 1) * 100)
		layers.content.levels[level].level = level
	end
	
	layers.content.levels:setReferencePoint(display.CenterReferencePoint)
	layers.content.levels.x = game.centerX
	layers.content.levels.y = game.centerY + 20
end

----------------------------------------------------------
gotoLevel = function(self, event)
	print("going to level ", self.target.level)
	audio.play(sounds.click, { channel = 1 } )
	player.currentLevel = self.target.level
	storyboard.gotoScene("scene_play", "slideLeft", 400)		
	return true
end

----------------------------------------------------------
function scene:createScene(event)
	layers = display.newGroup()
	layers.bg = display.newGroup()
	layers.content = display.newGroup()
	layers.hud = display.newGroup()
	layers:insert(layers.bg)
	layers:insert(layers.content)
	layers:insert(layers.hud)
	self.view:insert(layers)

	-- background
	local frame = sheetLevelInfo:getFrameIndex("bg")
	layers.bg.wallpaper = display.newImageRect(layers.bg, sheetLevel, frame, sheetLevelInfo:getSheet().frames[frame].width, sheetLevelInfo:getSheet().frames[frame].height)
	layers.bg.wallpaper:setReferencePoint(display.CenterReferencePoint)
	layers.bg.wallpaper.x = game.centerX
	layers.bg.wallpaper.y = game.centerY
	
	-- header
	layers.hud.header = display.newText(layers.hud, "SLOTS TV", 0, 0, game.font, 35)
	layers.hud.header:setTextColor(0)
	layers.hud.header:setReferencePoint(display.CenterReferencePoint)
	layers.hud.header.x = game.centerX
	layers.hud.header.y = 80

	UI = UIClass.new({ layer = display.newGroup() })
	layers.hud:insert(UI:getLayer())
	UI:showLevelBar()
	UI:showCreditsBar()
	UI:showBonusButton()
	
	timers.bonus = timer.performWithDelay(1000, function()
		UI:updateBonusButton()
	end, 0)
	
	showLevels()
end
 
----------------------------------------------------------
function scene:willEnterScene( event )
	storyboard.purgeScene("scene_play")

	UI:updateLevelBar()
	UI:updateCreditsBar()
	UI:updateBonusButton()
end
 
----------------------------------------------------------
function scene:exitScene(event)
	for k, _ in pairs(timers) do
		timer.cancel(timers[k])
		timers[k] = nil
	end	
end

scene:addEventListener("createScene", scene)
scene:addEventListener("willEnterScene", scene)
scene:addEventListener("exitScene", scene)
 
return scene