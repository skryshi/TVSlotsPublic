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

local class = {}

sheetUIInfo = require("images.UI.sheet")
sheetUI = graphics.newImageSheet("images/UI/sheet.png", sheetUIInfo:getSheet())

class.new = function(o)
	local UIClass = {}
	UIClass.layer = nil

	----------------------------------------------------------
	function UIClass:init(o)
		print("UIClass:init")
		o = o or {}
		self.layer = o.layer
		return self
	end

	----------------------------------------------------------
	function UIClass:getLayer()
		return self.layer
	end
	
	----------------------------------------------------------
	function UIClass:showLevelBar()
		self.layer.levelBar = view.progressBar({
			sheet = sheetUI,
			sheetInfo = sheetUIInfo,
			emptyFrame = sheetUIInfo:getFrameIndex("bar_level_empty"),
			fullFrame = sheetUIInfo:getFrameIndex("bar_level_full"),
			maskX = 30,
		})
		print("showLevelBar", self.layer.levelBar)
		utils.printTable(self.layer.levelBar)
		self.layer.levelBar.x = self.layer.levelBar.width / 2 + 10
		self.layer.levelBar.y = 40
		self.layer:insert(self.layer.levelBar)

		self.layer.levelCaption = display.newText(self.layer, "LEVEL", 0, 0, game.font, 20)
		self.layer.levelCaption:setTextColor(0)
		self.layer.levelCaption:setReferencePoint(display.CenterReferencePoint)
		self.layer.levelCaption.x = self.layer.levelBar.width / 2 + 14
		self.layer.levelCaption.y = 10

		self.layer.levelAmount = display.newText(self.layer, "0", 0, 0, game.font, 18)
		self.layer.levelAmount:setTextColor(0)
		self.layer.levelAmount.y = 38
		self:updateLevelBar()
	end

	----------------------------------------------------------
	function UIClass:updateLevelBar()
		self.layer.levelBar:scaleBar(helpers.percentLevelComplete())
	--	self.layer.levelBar:scaleBar(0.5)

		self.layer.levelAmount.text = helpers.getPlayerLevel()
		self.layer.levelAmount:setReferencePoint(display.CenterReferencePoint)
		self.layer.levelAmount.x = 27
	end

	----------------------------------------------------------
	function UIClass:showCreditsBar()
		local frame = sheetUIInfo:getFrameIndex("bar_credits")
		self.layer.creditsBar = display.newImageRect(self.layer, sheetUI, frame, sheetUIInfo:getSheet().frames[frame].width, sheetUIInfo:getSheet().frames[frame].height)
		self.layer.creditsBar.x = game.w - self.layer.creditsBar.width / 2 - 16
		self.layer.creditsBar.y = 44

		self.layer.creditsCaption = display.newText(self.layer, "CREDITS", 0, 0, game.font, 20)
		self.layer.creditsCaption:setTextColor(0)
		self.layer.creditsCaption:setReferencePoint(display.CenterReferencePoint)
		self.layer.creditsCaption.x = game.w - self.layer.creditsBar.width / 2 - 18
		self.layer.creditsCaption.y = 10

		self.layer.creditsAmount = display.newText(self.layer, "0", 0, 0, game.font, 18)
		self.layer.creditsAmount:setTextColor(0)
		self.layer.creditsAmount.y = 40
		self:updateCreditsBar()

		self.layer.addCreditsButton = widget.newButton
		{
			sheet = sheetUI,
			defaultFrame = sheetUIInfo:getFrameIndex("button_add"),
			overFrame = sheetUIInfo:getFrameIndex("button_add_pressed"),
			left = self.layer.creditsBar.x + self.layer.creditsBar.width / 2 - 5,
			top = self.layer.creditsBar.y - self.layer.creditsBar.height / 2 + 3,
			onRelease = function()
				if true == game.controlsBlocked then return end
				audio.play(sounds.click, { channel = 1, onComplete = function()
	--				storyboard.gotoScene("scene_levels", "slideLeft", 400)
				end })
				return true
			end	
		}
		self.layer:insert(self.layer.addCreditsButton)
	end

	----------------------------------------------------------
	function UIClass:updateCreditsBar()
		self.layer.creditsAmount.text = "$"..player.credits
		self.layer.creditsAmount:setReferencePoint(display.CenterReferencePoint)
		self.layer.creditsAmount.x = game.w - self.layer.creditsBar.width / 2 - 16
	end

	----------------------------------------------------------
	function UIClass:showWinBar()
		local frame = sheetUIInfo:getFrameIndex("bar_win")
		self.layer.winBar = display.newImageRect(self.layer, sheetUI, frame, sheetUIInfo:getSheet().frames[frame].width, sheetUIInfo:getSheet().frames[frame].height)
		self.layer.winBar.x = game.w - self.layer.winBar.width / 2 - 110
		self.layer.winBar.y = 43

		self.layer.winCaption = display.newText(self.layer, "WIN", 0, 0, game.font, 20)
		self.layer.winCaption:setTextColor(0)
		self.layer.winCaption:setReferencePoint(display.CenterReferencePoint)
		self.layer.winCaption.x = game.w - self.layer.winBar.width / 2 - 110
		self.layer.winCaption.y = 10

		self.layer.winAmount = display.newText(self.layer, "", 0, 0, game.font, 18)
		self.layer.winAmount:setTextColor(0)
		self.layer.winAmount.y = 40
		self:updateWinBar()
	end

	----------------------------------------------------------
	function UIClass:updateWinBar()
		self.layer.winAmount.text = "$"..game.win
		self.layer.winAmount:setReferencePoint(display.CenterReferencePoint)
		self.layer.winAmount.x = game.w - self.layer.winBar.width / 2 - 105
	end

	----------------------------------------------------------
	function UIClass:showMessageBox()
		self.layer.messageBox = display.newText(self.layer, "", 0, 0, game.font, 16)
		self.layer.messageBox:setTextColor(0)
		self.layer.messageBox.y = game.centerY + 160
		self:updateMessageBox("Welcome!")
	end

	----------------------------------------------------------
	function UIClass:updateMessageBox(text)
		self.layer.messageBox.text = text
		self.layer.messageBox:setReferencePoint(display.CenterReferencePoint)
		self.layer.messageBox.x = game.centerX + 10
	end

	----------------------------------------------------------
	function UIClass:showMenuButton()
		self.layer.menuButton = widget.newButton
		{
			sheet = sheetUI,
			defaultFrame = sheetUIInfo:getFrameIndex("button_menu"),
			overFrame = sheetUIInfo:getFrameIndex("button_menu_pressed"),
			left = 10,
			top = game.h - 60,
	--		width = 90,
	--		height = 70,
			label = "MENU",
			labelXOffset = -4,
			labelYOffset = -2,
			emboss = false,
			font = game.font,
			fontSize = 20,
			onRelease = function()
				if true == game.controlsBlocked then return end
				audio.play(sounds.click, { channel = 1, onComplete = function()
					storyboard.gotoScene("scene_levels", "slideLeft", 400)
				end })
				return true
			end	
		}
		self.layer:insert(self.layer.menuButton)
	end

	----------------------------------------------------------
	function UIClass:showSpinButton()
		self.layer.spinButton = widget.newButton
		{
			sheet = sheetUI,
			defaultFrame = sheetUIInfo:getFrameIndex("button_spin"),
			overFrame = sheetUIInfo:getFrameIndex("button_spin_pressed"),
			left = game.centerX - sheetUIInfo:getSheet().frames[sheetUIInfo:getFrameIndex("button_spin")].width / 2,
			top = game.h - 70,
	--		width = 90,
	--		height = 70,
			label = "SPIN",
			labelXOffset = -6,
			labelYOffset = -2,
			emboss = false,
			font = game.font,
			fontSize = 20,
			onRelease = function() Runtime:dispatchEvent({ name = "spin" }) end
		}
		self.layer:insert(self.layer.spinButton)
	end

	----------------------------------------------------------
	function UIClass:showBetButton()
		self.layer.betButton = widget.newButton
		{
			sheet = sheetUI,
			defaultFrame = sheetUIInfo:getFrameIndex("button_bet"),
			overFrame = sheetUIInfo:getFrameIndex("button_bet_pressed"),
			left = game.w - 90,
			top = game.h - 65,
	--		width = 110,
	--		height = 70,
			label = "BET",
			labelXOffset = -2,
			labelYOffset = -12,
			emboss = false,
			font = game.font,
			fontSize = 20,
			onRelease = function()
				if true == game.controlsBlocked then return end
				helpers.cycleGameBet()
				self:updateBetButton()
				audio.play(sounds.click, { channel = 1, onComplete = function()
				end })
				return true
			end	
		}
		self.layer:insert(self.layer.betButton)
	
		self.layer.betAmount = display.newText(self.layer, "", 0, 0, game.font, 16)
		self.layer.betAmount:setTextColor(0)
		self.layer.betAmount.y = self.layer.betButton.y + 11
		self:updateBetButton()
	end

	----------------------------------------------------------
	function UIClass:updateBetButton()
		self.layer.betAmount.text = "$"..game.bets[game.bet]
		self.layer.betAmount:setReferencePoint(display.CenterReferencePoint)
		self.layer.betAmount.x = self.layer.betButton.x - 2
	end

	----------------------------------------------------------
	function UIClass:showBonusButton()
		self.layer.bonusButton = widget.newButton
		{
			sheet = sheetUI,
			defaultFrame = sheetUIInfo:getFrameIndex("button_bet"),
			overFrame = sheetUIInfo:getFrameIndex("button_bet_pressed"),
			left = game.w - 90,
			top = game.h - 65,
	--		width = 110,
	--		height = 70,
			label = "BONUS",
			labelXOffset = -2,
			labelYOffset = -12,
			emboss = false,
			font = game.font,
			fontSize = 20,
			onRelease = function()
				if true == game.controlsBlocked then return end
				local bonus = math.min(game.bonusMax, os.difftime(os.time(), player.lastBonusCollectionTime) * game.bonusRate)
				player.credits = player.credits + math.floor(bonus)
				player.lastBonusCollectionTime = os.time() - (bonus - math.floor(bonus)) / game.bonusRate
				self:updateBonusButton()
				self:updateCreditsBar()
				audio.play(sounds.click, { channel = 1, onComplete = function()
				end })
				return true
			end	
		}
		self.layer:insert(self.layer.bonusButton)
	
		self.layer.bonusAmount = display.newText(self.layer, "", 0, 0, game.font, 16)
		self.layer.bonusAmount:setTextColor(0)
		self.layer.bonusAmount.y = self.layer.bonusButton.y + 11
		self:updateBonusButton()
	end

	----------------------------------------------------------
	function UIClass:updateBonusButton()
		local amount = math.min(game.bonusMax, os.difftime(os.time(), player.lastBonusCollectionTime) * game.bonusRate)
		self.layer.bonusAmount.text = "$"..amount
		self.layer.bonusAmount:setReferencePoint(display.CenterReferencePoint)
		self.layer.bonusAmount.x = self.layer.bonusButton.x - 2
	end

	----------------------------------------------------------
	UIClass:init(o)

	return UIClass
end

return class