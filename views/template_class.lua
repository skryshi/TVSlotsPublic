-- Copyright 2013 Arman Darini

utils = require("utils")

local class = {}

class.new = function(o)
	local TemplateClass = display.newGroup()

	----------------------------------------------------------
	function TemplateClass:init(o)
		return self
	end

	----------------------------------------------------------
	function TemplateClass:toStr()
	end

	----------------------------------------------------------
	TemplateClass:init(o)

	return TemplateClass
end

return class