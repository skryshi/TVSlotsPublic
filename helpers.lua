-- Copyright 2013 Arman Darini

helpers = {
	----------------------------------------------------------
	convertExpToLevel = function(exp)
		for i = 1, #game.exp do
			if exp < game.exp[i] then return i - 1 end
		end
	end,
	
	----------------------------------------------------------
	getPlayerLevel = function()
		return helpers.convertExpToLevel(player.exp)
	end,

	----------------------------------------------------------
	expSinceLevel = function()
		return player.exp - game.exp[helpers.getPlayerLevel()]
	end,

	----------------------------------------------------------
	percentLevelComplete = function()
		return helpers.expSinceLevel() / (game.exp[helpers.getPlayerLevel() + 1] - game.exp[helpers.getPlayerLevel()])
	end,
	
	----------------------------------------------------------
	cycleGameBet = function()
		game.bet = game.bet + 1
		if game.bet > #game.bets then
			game.bet = 1
		end
		return game.bets[game.bet]
	end,

	----------------------------------------------------------
	computeStars = function(score, level)
		i = 1
		while i < #game.levels[level].stars and score >= game.levels[level].stars[i] do
			i = i + 1
		end
		return i
	end,
	
	----------------------------------------------------------
	isLevelUnlocked = function(level)
		if 1 == level or player.levels[level].highScore > game.levels[level].stars[1] or player.levels[level - 1].highScore > game.levels[level - 1].stars[1] then
			return true
		else
			return false
		end
	end,
}

return helpers