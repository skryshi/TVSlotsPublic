-- Copyright 2013 Arman Darini

local TileClass = require("tile_class")
local math = require("math2")
local utils = require("utils")
local easing2 = require("easing2")

SlotClass = {
	view = nil,
	grid = nil,
	bg = nil,
	viewportW = nil,
	viewportH = nil,
	gridW = nil,
	gridH = nil,
	tileW = nil,
	tileH = nil,
	spacingW = nil,
	spacingH = nil,
	fakeReelH = 5,
	busy = false,
	reels = nil,
	timers = {},
	spinIteration = {},
	spinTotalIterations = {},
	spinDistance = 2, -- in fake reel heights, [2, 20] for linear easing with fast scroll
	spinIterationDelay = 33,
	spinTotalNotches = {},
	spinInitialY = {},
	spinRound = {},
	reelsSpinningCount = 0,
	onSpinComplete = nil,
	showMessage = nil,
	currentNotch = {},
	destinationNotch = {},
	winningLines = {},
	winAmount = 0,
	sheet = nil,
	sheetInfo = nil,
		
	----------------------------------------------------------
	new = function(self, o)
	  o = o or {}   -- create object if user does not provide one
	  setmetatable(o, self)
	  self.__index = self
	  return o
	end,
	
	----------------------------------------------------------
	removeSelf = function(self)
		self.view:removeEventListener("touch", self)
		self.view:removeEventListener("tap", self)
		for k, _ in pairs(self.timers) do
			timer.cancel(self.timers[k])
			self.timers[k] = nil
		end	

		if nil ~= self.view then
			self.view:removeSelf()
			self.view = nil
		end
	end,

	----------------------------------------------------------
	init = function(self, o)
		display.setDefault("lineColor", 100, 100, 100 )
		
		self.view = display.newGroup()

		self.gridW = game.levels[player.currentLevel].gridW
		self.gridH = game.levels[player.currentLevel].gridH
		self.viewportW = o.viewportW
		self.viewportH = o.viewportH
		self.tileW = math.floor(0.8 * self.viewportW / self.gridW)
		self.tileH = math.floor(0.9 * self.viewportH / self.gridH)
		self.spacingW = math.floor(0.2 * self.viewportW / (self.gridW - 1))
		self.spacingH = math.floor(0.1 * self.viewportH / (self.gridH - 1))
		self.sheetInfo = o.sheetInfo
		self.sheet = o.sheet
		for i = 1, game.levels[player.currentLevel].gridW do
			self.currentNotch[i] = 1
			self.spinTotalIterations[i] = 100 + i * 20
--			self.spinTotalIterations[i] = 50 + i * 10
		end
		self.grid = {}
		local loc
		
		--	create background
		self.view.bg = display.newRect(0, 0, self.viewportW, self.viewportH)
		self.view.bg:setFillColor(0, 0, 200)
		self.view.bg.alpha = 0
		self.view:insert(self.view.bg)
		self.view.bg:setReferencePoint(display.TopLeftReferencePoint)
		self.view.bg.x = 0
		self.view.bg.y = 0
		
		self.view:setReferencePoint(display.CenterReferencePoint)

		-- create mask
		self.maskj = graphics.newMask("images/mask_frame_328x328.png")
		self.view:setMask(self.maskj)
		self.view.maskX = self.viewportW / 2
		self.view.maskY = self.viewportH / 2
		
		self.view.reels = display.newGroup()
		self.view:insert(self.view.reels)
		-- create main reels
		for i = 1, self.gridW do
			table.insert(self.view.reels, i, display.newGroup())
			self.view.reels:insert(self.view.reels[i])
			self.view.reels[i].main = display.newGroup()
			self.view.reels[i]:insert(self.view.reels[i].main)
			for j = 1, #game.levels[player.currentLevel].reels[i] do
				table.insert(self.view.reels[i].main, j, TileClass.new({
					category = game.levels[player.currentLevel].reels[i][j],
					color = {255, 255, 255 },
					tileW = self.tileW,
					tileH = self.tileH,
					sheet = self.sheet,
					sheetInfo = self.sheetInfo,
				}))
				self.view.reels[i].main:insert(self.view.reels[i].main[j])
				loc = self:getXYFromGrid(i, j)
				self.view.reels[i].main[j].x = 0
				self.view.reels[i].main[j].y = loc.y
				print(i, j, loc.x, loc.y)
			end
		end

		-- create fake reels #1
		for i = 1, self.gridW do
			self.view.reels[i].fake1 = display.newGroup()
			self.view.reels[i]:insert(self.view.reels[i].fake1)
			for j = 1, self.fakeReelH do
				table.insert(self.view.reels[i].fake1, j, TileClass.new({
					color = {255, 100, 100 },
					tileW = self.tileW,
					tileH = self.tileH,
					sheet = self.sheet,
					sheetInfo = self.sheetInfo,
				}))
				self.view.reels[i].fake1:insert(self.view.reels[i].fake1[j])
				loc = self:getXYFromGrid(i, j)
				self.view.reels[i].fake1[j].x = 0
				self.view.reels[i].fake1[j].y = loc.y
--				print("x, y:", loc.x, loc.y)
			end
			self.view.reels[i].fake1:translate(0, -self.view.reels[i].fake1.height - self.spacingH)
		end

		-- create fake reels #2
		for i = 1, self.gridW do
			self.view.reels[i].fake2 = display.newGroup()
			self.view.reels[i]:insert(self.view.reels[i].fake2)
			for j = 1, self.fakeReelH do
				table.insert(self.view.reels[i].fake2, j, TileClass.new({
					color = {200, 200, 255 },
					tileW = self.tileW,
					tileH = self.tileH,
					sheet = self.sheet,
					sheetInfo = self.sheetInfo,
				}))
				self.view.reels[i].fake2:insert(self.view.reels[i].fake2[j])
				loc = self:getXYFromGrid(i, j)
				self.view.reels[i].fake2[j].x = 0
				self.view.reels[i].fake2[j].y = loc.y
--				print("x, y:", loc.x, loc.y)
			end
			self.view.reels[i].fake2:translate(0, 2*(-self.view.reels[i].fake2.height - self.spacingH))
		end

		--	set reel positions
		self.view.reels:setReferencePoint(display.TopLeftReferencePoint)
		for i = 1, self.gridW do
			self.view.reels[i]:setReferencePoint(display.BottomCenterReferencePoint)
--			self.view.reels[i].x = (i - 1) * (self.tileW + self.spacingW)
			self.view.reels[i].x = self:getXYFromGrid(i, 1).x
			self.view.reels[i].y = self.viewportH
			print("==>", self.view.x, self.view.reels.x, self.view.reels[i].x, self.view.reels[i].main.x, self.view.reels[i].main[1].x)
		end

		-- scroll reels to current notch
		for i = 1, self.gridW do
			print("current notch", self.view.reels[i].y)
			self.view.reels[i]:translate(0, ((#game.levels[player.currentLevel].reels[i] - self.gridH) - (self.currentNotch[i] - 1)) * (self.tileH + self.spacingH))
			print("current notch", self.view.reels[i].y)
		end
		
		-- populate visible grid
		for i = 1, self.gridW do
			self.grid[i] = {}
			for j = 1, self.gridH do
				self.grid[i][j] = self.view.reels[i].main[j + self.currentNotch[i] - 1]
				print(i,j,self.grid[i][j].category)
			end
		end
		
		-- add paylines
		self.view.reels.paylines = display.newGroup()
		self.view.reels:insert(self.view.reels.paylines)

		self.view:addEventListener("tap", self)
		game.controlsBlocked = false
	end,
	
	----------------------------------------------------------
	spin = function(self, o)
		self.onSpinComplete = o.onComplete
		self.showMessage = o.showMessage
		self:hideWinningPaylines()
		self.winningLines = {}
		self.winAmount = 0
		self:setDestinationNotch()
		for i = 1, self.gridW do
			self.spinIteration[i] = self.spinIteration[i] or 0
			if nil == self.timers["reel"..i] then
				self.spinTotalNotches[i] = (self.currentNotch[i] - 1) + (#game.levels[player.currentLevel].reels[i] - self.destinationNotch[i] + 1) + self.fakeReelH * self.spinDistance
--				self.spinTotalNotches = { self.gridH * 6, self.gridH * 7, self.gridH * 8 }
--				self.spinTotalNotches = { 0, 1, 2 }
				print("spinTotalNotches[i]", self.spinTotalNotches[i])
				--	reset fake reels into their proper positions on top of main reel
				self.view.reels[i].fake1.y = self.view.reels[i].main.y - self.view.reels[i].fake1.height - self.spacingH
				self.view.reels[i].fake2.y = self.view.reels[i].main.y - self.view.reels[i].fake1.height - self.view.reels[i].fake2.height - 2 * self.spacingH

				self.spinInitialY[i] = self.view.reels[i].y
				self.spinRound[i] = { fake1 = 1, fake2 = 1, isMainReset = false }
				self.timers["reel"..i] = timer.performWithDelay(self.spinIterationDelay, function() self:spinReel(i) end, 0)
				self.reelsSpinningCount = self.reelsSpinningCount + 1
			end
		end
	end,

	----------------------------------------------------------
	spinReel = function(self, i)
		if self.spinIteration[i] > self.spinTotalIterations[i] then
			timer.cancel(self.timers["reel"..i])
			self.timers["reel"..i] = nil
			self.spinIteration[i] = nil
			self.reelsSpinningCount = self.reelsSpinningCount - 1
			self.currentNotch[i] = self.destinationNotch[i]
			if 0 == self.reelsSpinningCount then
				self:computeWinnings()
				self.onSpinComplete()
			end
			return
		end

--		local y = easing2.easeInOutBack(self.spinIteration[i], self.spinTotalIterations[i], self.spinInitialY[i], self.spinTotalNotches[i]*(self.tileH + self.spacingH))
--		local y = easing.inOutQuad(self.spinIteration[i], self.spinTotalIterations[i], self.spinInitialY[i], self.spinTotalNotches[i]*(self.tileH + self.spacingH))
		local y = easing.linear(self.spinIteration[i], self.spinTotalIterations[i], self.spinInitialY[i], self.spinTotalNotches[i]*(self.tileH + self.spacingH))
		local fake1step = self.view.reels[i].fake1.height + self.spacingH
		local fake2step = self.view.reels[i].fake2.height + self.spacingH
	
		local fx, fy = self.view.reels[i].fake1:localToContent(0, 0)
		local rx, ry = self.view.parent:localToContent(0, 0)	
		if 1 == i then
		end

		self.view.reels[i].y = y

		if not self.spinRound[i].isMainReset and (self.view.reels[i].y - self.spinInitialY[i] > (self.tileH + self.spacingH)*(self.gridH + self.currentNotch[i] - 1)) then
			self.spinRound[i].isMainReset = true
			print("main translate", self.spinIteration[i], self.spinTotalNotches[i], -self.spinTotalNotches[i] * (self.tileH + self.spacingH))
			self.view.reels[i].main:translate(0, -(self.spinTotalNotches[i] + self.destinationNotch[i] - self.currentNotch[i]) * (self.tileH + self.spacingH))
		end
		if self.view.reels[i].y - self.spinInitialY[i] > (2*self.spinRound[i].fake1-1)*fake1step + (self.tileH + self.spacingH)*(self.gridH + self.currentNotch[i] - 1) then
			self.spinRound[i].fake1 = self.spinRound[i].fake1 + 1
			self.view.reels[i].fake1:translate(0, -2 * fake1step)
			-- if on top of main reel, move higher
			if ((self.view.reels[i].main.y <= self.view.reels[i].fake1.y) and (self.view.reels[i].fake1.y <= self.view.reels[i].main.y + self.view.reels[i].main.height)) or ((self.view.reels[i].main.y <= self.view.reels[i].fake1.y + self.view.reels[i].fake1.height) and (self.view.reels[i].fake1.y + self.view.reels[i].fake1.height <= self.view.reels[i].main.y + self.view.reels[i].main.height)) then
				self.spinRound[i].fake1 = self.spinRound[i].fake1 + 1
				self.view.reels[i].fake1:translate(0, 2 * fake1step)
			end
		end
		if self.view.reels[i].y - self.spinInitialY[i] > (2*self.spinRound[i].fake2-1)*fake2step + (self.tileH + self.spacingH)*(self.gridH + self.currentNotch[i] - 1) + fake1step then
			self.spinRound[i].fake2 = self.spinRound[i].fake2 + 1
			self.view.reels[i].fake2:translate(0, -2 * fake2step)
			if ((self.view.reels[i].main.y <= self.view.reels[i].fake2.y) and (self.view.reels[i].fake2.y <= self.view.reels[i].main.y + self.view.reels[i].main.height)) or ((self.view.reels[i].main.y <= self.view.reels[i].fake2.y + self.view.reels[i].fake2.height) and (self.view.reels[i].fake2.y + self.view.reels[i].fake2.height <= self.view.reels[i].main.y + self.view.reels[i].main.height)) then
				self.spinRound[i].fake2 = self.spinRound[i].fake2 + 1
				self.view.reels[i].fake2:translate(0, 2 * fake2step)
			end
		end

		self.spinIteration[i] = self.spinIteration[i] + 1
	end,

	----------------------------------------------------------
	computeWinnings = function(self)
		print("computeWinnings")
		-- populate visible grid
		for i = 1, self.gridW do
			for j = 1, self.gridH do
				self.grid[i][j] = self.view.reels[i].main[j + self.currentNotch[i] - 1]
--				print(i,j,self.grid[i][j].category)
			end
		end
		
		-- check for winnings
		local l = game.levels[player.currentLevel].lines
		for i = 1, #l do
			print("**: "..i)
			utils.printTable(self.grid[i])
			utils.printTable(l[1])
			if self.grid[1][l[i][1]].category == self.grid[2][l[i][2]].category and self.grid[2][l[i][2]].category == self.grid[3][l[i][3]].category then
				table.insert(self.winningLines, { tile = self.grid[1][l[i][1]].category, count = 3, line = l[i], win = game.levels[player.currentLevel].payouts[self.grid[1][l[i][1]].category][3] * game.bets[game.bet] / 10 })
			elseif self.grid[1][l[i][1]].category == self.grid[2][l[i][2]].category then
				table.insert(self.winningLines, { tile = self.grid[1][l[i][1]].category, count = 2, line = l[i], win = game.levels[player.currentLevel].payouts[self.grid[1][l[i][1]].category][2] * game.bets[game.bet] / 10 })
			end
		end
		utils.printTable(self.winningLines)

		-- total winnings
		for i = 1, #self.winningLines do
			self.winAmount = self.winAmount + game.levels[player.currentLevel].payouts[self.winningLines[i].tile][self.winningLines[i].count]
		end
		print(self.winAmount)
	end,

	----------------------------------------------------------
	showWinningPaylines = function(self, payline)
		if 0 == #self.winningLines then
			return
		end
		
		payline = payline or #self.winningLines
		
		-- stop prior payline animation
		for i = 1, self.winningLines[payline].count do
--			print("hiding animation. payline=", payline, "  i=", i)
			self.grid[i][self.winningLines[payline].line[i]]:hideAnimation()
		end
		
		-- hide payline
		self:hidePayline(payline)
		
		payline = (payline % #self.winningLines) + 1
		
		-- start current payline animation
		for i = 1, self.winningLines[payline].count do
			self.grid[i][self.winningLines[payline].line[i]]:showAnimation()
		end
		
		-- draw payline
		self:showPayline(payline)
		
		-- show text
		if nil ~= self.showMessage then
			self.showMessage(self.winningLines[payline].count.." "..game.levels[player.currentLevel].tiles.names[self.winningLines[payline].tile].." win "..self.winningLines[payline].win.." credits")
		end

		if nil ~= self.timers.paylines then
			timer.cancel(self.timers.paylines)
		end
		self.timers.paylines = timer.performWithDelay(1000, function() self:showWinningPaylines(payline) end, 1)
	end,

	----------------------------------------------------------
	hideWinningPaylines = function(self)
		if nil ~= self.timers.paylines then
			timer.cancel(self.timers.paylines)
			self.timers.paylines = nil

			-- stop all payline animations
			for i = 1, self.gridW do
				for j = 1, self.gridH do
					self.grid[i][j]:hideAnimation()
				end
			end
			
			for i = 1, #self.winningLines do
				self:hidePayline(i)
			end
		end
	end,

	----------------------------------------------------------
	showPayline = function(self, payline)
		table.insert(self.view.reels.paylines, payline, display.newGroup())
		self.view.reels.paylines:insert(self.view.reels.paylines[payline])
		local x1, y1, x2, y2
		for i = 1, game.levels[player.currentLevel].gridW - 1 do
			x1 = self:getXYFromGrid(i, self.winningLines[payline].line[i]).x
			y1 = self:getXYFromGrid(i, self.winningLines[payline].line[i]).y
			x2 = self:getXYFromGrid(i+1, self.winningLines[payline].line[i+1]).x
			y2 = self:getXYFromGrid(i+1, self.winningLines[payline].line[i+1]).y
--			print(i, self.winningLines[payline].line[i], x1, y1, x2, y2)
			local line = display.newLine(self.view.reels.paylines[payline], x1, y1, x2, y2)
			line.width = 10
			self.view.reels.paylines:toBack()
		end
	end,

	----------------------------------------------------------
	hidePayline = function(self, payline)
		if nil ~= self.view.reels.paylines[payline] then
			self.view.reels.paylines[payline]:removeSelf()
			self.view.reels.paylines[payline] = nil
		end
	end,

	----------------------------------------------------------
	setDestinationNotch = function(self)
		for i = 1, game.levels[player.currentLevel].gridW do
			self.destinationNotch[i] = math.random(1, #game.levels[player.currentLevel].reels[i] - game.levels[player.currentLevel].gridH + 1)
		end
--		self.destinationNotch = { 1, 1, 1 }
	end,

	----------------------------------------------------------
	tap = function(self, event)
		print("SlotClass:tap. x="..event.x..", y="..event.y)
		return true
	end,

	----------------------------------------------------------
	touch = function(self, event)
		print("SlotClass:touch. x="..event.x..", y="..event.y..", phase="..event.phase)
		if event.phase == "ended" then
			if event.y > event.yStart + 10 then
				Runtime:dispatchEvent({ name = "spin" })
			end
		end
	end,
	
	----------------------------------------------------------
	getXYFromGrid = function(self, i, j)
		--returns center x,y of each grid cell
		return { x = (i - 0.5) * self.tileW + (i - 1) * self.spacingW, y = (j - 0.5) * self.tileH + (j - 1) * self.spacingH }
	end,

	----------------------------------------------------------
	getTileFromGrid = function(self, i, j)
		return self.grid[i][j]
	end,

	----------------------------------------------------------
	getTileFromXY = function(self, x, y)
		return self.grid[math.round(x / self.tileW + 0.5)][math.round(y / self.tileH + 0.5)]
	end,
}

return SlotClass