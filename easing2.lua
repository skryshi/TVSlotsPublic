-- These easing functions were derived from Robert Penner's work: http://www.robertpenner.com/easing/ and inspired by easing file by Stuart Carnie

local easing = {}

function easing.easeInOutBack(t, tMax, start, delta)
        return start + (delta * _easeInOutBack2(t/tMax))
end
 
-- local easing functions
pow = math.pow
sin = math.sin
pi = math.pi

_easeInOutBack = function(ratio)
--	local s = 1.70158 * 1.525
	local s = 1.70158 * 0.3
	t = ratio * 2.0
	if (t < 1) then
		return 0.5*(t*t*((s+1)*t - s))
	else
		t = t - 2
		return 0.5*(t*t*((s+1)*t + s) + 2)
	end
end

return easing