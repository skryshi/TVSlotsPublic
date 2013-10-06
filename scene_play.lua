-- Copyright 2013 Arman Darini

local math = require ("math2")
local helpers = require("helpers")
local utils = require("utils")
local widget = require("widget")
local storyboard = require("storyboard")
local scene = storyboard.newScene()
storyboard.purgeOnSceneChange = true
local view = require("views.view_class")
local progressBarClass = require("views.progress_bar_class")

local layers

local UIClass = require("ui_class")
local UI

local sheetThemeInfo
local sheetTheme

local SlotClass = require("slot_class")
local slot

local timers = {}

----------------------------------------------------------
local function scoreListener(event)
	print("scoreListener", event.amount)
	game.score = game.score + event.amount
	layers.hud.scoreAmount.text = game.score
	layers.hud.scoreAmount:setReferencePoint(display.CenterReferencePoint)
	layers.hud.scoreAmount.x = game.w - 60

	updateLevelBar()
end

----------------------------------------------------------
local function achievementPopupListener(event)
	local txt
	if event.amount >= 180 then
		txt = game.achievements[5]
	elseif event.amount >= 90 then
		txt = game.achievements[4]
	elseif event.amount >= 60 then
		txt = game.achievements[3]
	elseif event.amount >= 30 then
		txt = game.achievements[2]
	elseif event.amount >= 20 then
		txt = game.achievements[1]
	else
		return
	end
	print("achievementPopupListener", event.amount, txt)

	layers.overlay.achievement = display.newGroup()
	layers.overlay:insert(layers.overlay.achievement)
	
	layers.overlay.achievement.wallpaper = display.newRoundedRect(layers.overlay.achievement, 0, 0, 200, 60, 12)
	layers.overlay.achievement.wallpaper.strokeWidth = 3
	layers.overlay.achievement.wallpaper:setFillColor(243, 95, 179)
	layers.overlay.achievement.wallpaper:setStrokeColor(254, 191, 199)
	layers.overlay.achievement.wallpaper.x = game.centerX
	layers.overlay.achievement.wallpaper.y = game.centerY

	layers.overlay.achievement.header = display.newText(layers.overlay.achievement, txt, 0, 0, game.font, 32)
	layers.overlay.achievement.header.x = layers.overlay.achievement.wallpaper.x
	layers.overlay.achievement.header.y = layers.overlay.achievement.wallpaper.y

	transition.to(layers.overlay.achievement, { alpha = 0, time = 1000, delay = 500, onComplete = 
		function()
			if layers.overlay.achievement ~= nil then layers.overlay.achievement:removeSelf()
				layers.overlay.achievement = nil
			end
		end
	})
end


----------------------------------------------------------
local function spin()
	if true == game.controlsBlocked then return end
	game.controlsBlocked = true
	player.credits = player.credits - game.bets[game.bet]
	UI:updateCreditsBar()
	game.win = 0
	UI:updateWinBar()
	player.exp = player.exp + game.bets[game.bet]
	UI:updateLevelBar()
	player.levels[player.currentLevel].highScore = player.levels[player.currentLevel].highScore + game.bets[game.bet]
	player.levels[player.currentLevel].attempts = player.levels[player.currentLevel].attempts + 1
	UI:updateMessageBox("Playing all "..#game.levels[player.currentLevel].lines.." lines")
	slot:spin({ showMessage = function(text) UI:updateMessageBox(text) end, onComplete = function()
		slot:showWinningPaylines()
		game.win = slot.winAmount * game.bets[game.bet] / 10
		UI:updateWinBar()
		player.credits = player.credits + game.win
		UI:updateCreditsBar()
		if game.win > 0 then
			UI:updateMessageBox("You win "..game.win.." credits")
		else
			UI:updateMessageBox("")
		end
		-- display achievement
		-- if level up show level up page
		game.controlsBlocked = false
	end })
	audio.play(sounds.click, { channel = 1, onComplete = function() end })
	return true
end

----------------------------------------------------------
local function showSlot()
	slot:init({ viewportW = 240, viewportH = 320, sheet = sheetTheme, sheetInfo = sheetThemeInfo })

	layers.content:insert(slot.view)
	--	slot reference point is positioned such that x,y move the center point of the visible slot area. do not move slot reference point
	slot.view.x = game.centerX + 10
	slot.view.y = game.centerY - 24
	
end

----------------------------------------------------------
function scene:createScene(event)
	layers = display.newGroup()
	layers.bg = display.newGroup()
	layers.content = display.newGroup()
	layers.hud = display.newGroup()
	layers.overlay = display.newGroup()
	layers:insert(layers.bg)
	layers:insert(layers.content)
	layers:insert(layers.hud)
	layers:insert(layers.overlay)
	self.view:insert(layers)

	--	setup theme imagesheet
	local slotIdStr = (player.currentLevel < 10 and "0"..player.currentLevel or player.currentLevel)
	sheetThemeInfo = require("images.themes.theme_"..slotIdStr)
	sheetTheme = graphics.newImageSheet("images/themes/theme_"..slotIdStr..".png", sheetThemeInfo:getSheet())

	local frame = sheetThemeInfo:getFrameIndex("bg")
	layers.bg.wallpaper = display.newImageRect(layers.bg, sheetTheme, frame, sheetThemeInfo:getSheet().frames[frame].width, sheetThemeInfo:getSheet().frames[frame].height)
	layers.bg.wallpaper:setReferencePoint(display.CenterReferencePoint)
	layers.bg.wallpaper.x = game.centerX
	layers.bg.wallpaper.y = game.centerY
	
	UI = UIClass.new({ layer = display.newGroup() })
	layers.hud:insert(UI:getLayer())
	UI:showLevelBar()
	UI:showCreditsBar()
	UI:showWinBar()
	UI:showMenuButton()
	UI:showSpinButton()
	UI:showBetButton()
	UI:showMessageBox()
	
	slot = SlotClass:new()
	showSlot()
	
	Runtime:addEventListener("spin", spin)
	Runtime:addEventListener("spin_end", achievementPopupListener)
	slot.view:addEventListener("touch", slot)
end
 

----------------------------------------------------------
function scene:willEnterScene(event)
	storyboard.purgeScene("scene_levels")

	UI:updateLevelBar()
	UI:updateCreditsBar()
	UI:updateWinBar()
end

----------------------------------------------------------
function scene:exitScene(event)
--	print("scene_play:scene:exitScene")
	Runtime:removeEventListener("score", scoreListener)
--	Runtime:removeEventListener("score", achievementPopupListener)

	slot:removeSelf()

	for k, _ in pairs(timers) do
		timer.cancel(timers[k])
		timers[k] = nil
	end	
end


----------------------------------------------------------
scene:addEventListener("createScene", scene)
scene:addEventListener("willEnterScene", scene)
scene:addEventListener("exitScene", scene)

if game.debug then
	timer.performWithDelay(1000, utils.printMemoryUsed, 0)
end

return scene