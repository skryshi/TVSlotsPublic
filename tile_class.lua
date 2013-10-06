-- Copyright 2013 Arman Darini

utils = require("utils")

local class = {}

class.new = function(o)
	local TileClass = display.newGroup()
	TileClass.category = nil
	TileClass.tileW = nil
	TileClass.tileH = nil
	TileClass.sheet = nil
	TileClass.sheetInfo = nil
	TileClass.frame = nil
--	TileClass.timers = {}
	TileClass.transitions = { }

	----------------------------------------------------------
	function TileClass:init(o)
--		print("TileClass:init")
		o = o or {}
		self.category = o.category or math.random(1, game.levels[player.currentLevel].tiles.count)
		self.color = o.color or { 255, 255, 255 }
		self.tileW = o.tileW
		self.tileH = o.tileH
		self.sheet = o.sheet
		self.sheetInfo = o.sheetInfo
--		self:useRect()
		self:useImage()
--		self:addEventListener("tap", self)

		return self
	end

	----------------------------------------------------------
	function TileClass:tap()
		print("TileClass:tap", self:toStr())
		return true
	end

	----------------------------------------------------------
	function TileClass:useImage()
		self.frame = self.sheetInfo:getFrameIndex("tile_"..(self.category < 10 and "0"..self.category or self.category))
--		self.image = display.newImageRect(self, self.sheet, self.frame, self.sheetInfo:getSheet().frames[self.frame].width, self.sheetInfo:getSheet().frames[self.frame].height)
		self.image = display.newImageRect(self, self.sheet, self.frame, self.tileW, self.tileH)
		self.image:setReferencePoint(display.CenterReferencePoint)

--[[
		self.caption = display.newText(self, self.category, 0, 0, game.font, 30)
		self.caption:setTextColor(0)
		self.caption:setReferencePoint(display.CenterReferencePoint)
		self.caption.x = 0
		self.caption.y = 0
]]
		self:setReferencePoint(display.CenterReferencePoint)
	end

	----------------------------------------------------------
	function TileClass:useCircle()
		self.circle = display.newCircle(self, 0, 0, math.min(self.tileW, self.tileH) / 2)
		self.circle:setFillColor(self.color[1], self.color[2], self.color[3])
		self.caption = display.newText(self, self.category, 0, 0, game.font, 30)
		self.caption:setTextColor(0)
		self.caption:setReferencePoint(display.CenterReferencePoint)
		self.caption.x = 0
		self.caption.y = 0
	end

	----------------------------------------------------------
	function TileClass:useRect()
		self.rect = display.newRect(self, 0, 0, self.tileW, self.tileH)
		self.rect:setFillColor(self.color[1], self.color[2], self.color[3])
		self.caption = display.newText(self, self.category, 0, 0, game.font, 30)
		self.caption:setTextColor(0)
		self.caption:setReferencePoint(display.CenterReferencePoint)
		self.caption.x = self.tileW / 2
		self.caption.y = self.tileH / 2
		self:setReferencePoint(display.CenterReferencePoint)
	end
	
	----------------------------------------------------------
	function TileClass:grow()
		self.transitions.animate = transition.to(self, { time = 500, alpha = 0.7, yScale = 2, xScale = 2, onComplete = function() self:shrink() end })
	end
	
	----------------------------------------------------------
	function TileClass:shrink()
		self.transitions.animate = transition.to(self, { time = 500, alpha = 1, yScale = 1, xScale = 1, onComplete = function() self:grow() end  })
	end

	----------------------------------------------------------
	function TileClass:showAnimation()
--		print("TileClass:showAnimation")
		self:setReferencePoint(display.CenterReferencePoint)
		self:toFront()
		if nil == self.transitions.animate then
			self:grow()
		end
	end

	----------------------------------------------------------
	function TileClass:hideAnimation()
--		print("TileClass:hideAnimation")
--		print(self.transitions.animate)
		if nil ~= self.transitions.animate then
			transition.cancel(self.transitions.animate)
			self.transitions.animate = nil
			self.yScale = 1
			self.xScale = 1
			self.alpha = 1
		end
	end

	----------------------------------------------------------
	function TileClass:toStr()
		return "[tileW="..self.tileW..", tileH="..self.tileH..", category="..self.category..", x="..self.x..", y="..self.y..", frame="..self.frame"]"
	end

	----------------------------------------------------------
	TileClass:init(o)

	return TileClass
end

return class