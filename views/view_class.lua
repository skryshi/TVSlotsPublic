-- Copyright 2013 Arman Darini

progressBarClass = require("views.progress_bar_class")

ViewClass = {
	----------------------------------------------------------
	progressBar = function(o)
		return progressBarClass.new(o)
	end
}

return ViewClass
