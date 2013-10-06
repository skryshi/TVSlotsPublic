-- Copyright 2013 Arman Darini

utils = require("utils")

local class = {}

class.new = function(o)
	local ProgressBarClass = display.newGroup()

	----------------------------------------------------------
	function ProgressBarClass:init(o)
		self.empty = display.newImageRect(self, o.sheet, o.emptyFrame, o.sheetInfo:getSheet().frames[o.emptyFrame].width, o.sheetInfo:getSheet().frames[o.emptyFrame].height)
		self.empty:setReferencePoint(display.TopLeftReferencePoint)
		
		self.full = display.newImageRect(self, o.sheet, o.fullFrame, o.sheetInfo:getSheet().frames[o.fullFrame].width, o.sheetInfo:getSheet().frames[o.fullFrame].height)
		self.full:setReferencePoint(display.TopLeftReferencePoint)
	
		self.applyMaskAtX = o.maskX
		self.mask = graphics.newMask("images/mask_frame_328x328.png")
		self.full:setMask(self.mask)
		self.full.maskX = self.applyMaskAtX - (self.full.width/2)
		self.full.maskScaleX = 0.01	--should be =0, but there is a bug in corona

		self:setReferencePoint(display.CenterReferencePoint)
		print("ProgressBarClass:init", type(self), self.numChildren)

		return self
	end

	----------------------------------------------------------
	function ProgressBarClass:scaleBar(fraction)
		self.full.maskScaleX = ((self.full.width - self.applyMaskAtX) / (328/2)) * math.min(1, math.max(0.01, fraction))
		return self
	end

	----------------------------------------------------------
	function ProgressBarClass:toStr()
	end

	----------------------------------------------------------
	ProgressBarClass:init(o)

	return ProgressBarClass
end

return class