-- Copyright 2013 Arman Darini

local json = require("json")

utils = {
	----------------------------------------------------------
	printTable = function(t)
		if nil == t then return end
		for k, v in pairs(t) do
			if "table" == type(v) then
				local s = ""
				for k2, v2 in pairs(v) do
					s = s .. ("table" ~= type(v2) and tostring(v2) or "{..}") .. " "
				end
				print(k, s)
			else
				print(k, v)
			end
		end
	end,

	----------------------------------------------------------
	printMemoryUsed = function()
	   collectgarbage( "collect" )
	   local memUsage = string.format( "MEMORY = %.3f KB", collectgarbage( "count" ) )
	   print( memUsage, "TEXTURE = "..(system.getInfo("textureMemoryUsed") / (1024 * 1024) ) )
	end,

	----------------------------------------------------------
	saveTable = function(t, filename)
		local path = system.pathForFile(filename, system.DocumentsDirectory)
		local file = io.open(path, "w")
		if file then
			local contents = json.encode(t)
			file:write(contents)
			io.close( file )
			return true
		else
			return false
		end
	end,

	----------------------------------------------------------
	loadTable = function(filename)
		local path = system.pathForFile( filename, system.DocumentsDirectory)
		local contents = ""
		local myTable = {}
		local file = io.open( path, "r" )
		if file then
			-- read all contents of file into a string
			local contents = file:read( "*a" )
			myTable = json.decode(contents);
			io.close( file )
			return myTable 
		end
		return nil
	end,
}

return utils
