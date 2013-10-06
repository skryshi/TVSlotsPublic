-- Copyright 2013 Arman Darini

display.setStatusBar( display.HiddenStatusBar )
local utils = require("utils")
local math = require("math")

--hold global vars
game = {
	debug = false,
	w = display.contentWidth,
	h = display.contentHeight,
	centerX = display.contentCenterX,
	centerY = display.contentCenterY,
	font = "AveriaLibre-Bold",
	moveSensitivity = 100,
	controlsBlocked = false,
	achievements = { "Not Bad!", "Rockin' It!", "On Steroids!", "Unbelievable!", "Divine!" },
	exp = { 0, 100, 200, 400, 800, 1600, 3200, 6400, 12800 },
	bonusRate = 0.01,	-- in credits/second
	bonusMax = 200,
	level = 1,
	win = 0,
	bet = 1,
	bets = { 10, 20, 30, 50, 100, 200, 300, 500, 1000 },
	levels = {
		{ gridW = 3, gridH = 5, maxLines = 3, unlockLevel = 1,
			theme = "theme_01",
			name = "Flowers",
			description = "Flowers. 21 paylines. Win BIG!",
			stars = { 20, 40, 80 },
			tiles = {
				count = 10,
				names = {
					"strawberries",
					"oranges",
					"lemons",
					"grapes",
					"cherries",
					"plums",
					"diamonds",
					"bars",
					"clovers",
					"sevens",
				},
			},
			reels = {
				{ 5, 3, 1, 2, 8, 5, 6, 3, 6, 4, 1, 7, 7, 2, 1, 6, 2, 7, 3, 4, 4, 10, 2, 3, 1, 3, 5, 2, 1, 4, 2, 6, 3, 1, 1, 2, 2, 3, 7, 9, 5, 1, 5, 1, 4, 8, 6, 4, 2, 9, 1, 8, 4, 5, 3 },
				{ 4, 6, 1, 2, 1, 7, 3, 5, 8, 1, 3, 6, 4, 3, 8, 6, 4, 7, 4, 1, 6, 3, 5, 3, 5, 1, 2, 2, 2, 9, 5, 1, 3, 4, 9, 2, 8, 5, 3, 2, 1, 3, 1, 2, 5, 4, 2, 6, 7, 7, 2, 1, 10, 4, 1 },
				{ 8, 2, 4, 1, 1, 1, 4, 5, 9, 1, 6, 5, 3, 6, 10, 7, 6, 3, 8, 2, 1, 2, 1, 9, 8, 7, 2, 4, 4, 3, 5, 3, 2, 6, 1, 4, 7, 6, 3, 1, 5, 2, 7, 3, 5, 4, 2, 2, 4, 5, 3, 1, 1, 2, 3 },
			},
			lines = {
				{ 1, 1, 1 },
				{ 1, 1, 2 },
				{ 1, 2, 1 },

				{ 2, 1, 2 },
				{ 2, 2, 1 },
				{ 2, 2, 2 },
				{ 2, 2, 3 },
				{ 2, 3, 2 },

				{ 3, 2, 3 },
				{ 3, 3, 2 },
				{ 3, 3, 3 },
				{ 3, 3, 4 },
				{ 3, 4, 3 },

				{ 4, 3, 4 },
				{ 4, 4, 3 },
				{ 4, 4, 4 },
				{ 4, 4, 5 },
				{ 4, 5, 4 },

				{ 5, 4, 5 },
				{ 5, 5, 4 },
				{ 5, 5, 5 },
			},
			payouts = {
			-- { 1 consecutive, 2 consecutive, 3 consecutive }
				{ 0, 1, 10 },
				{ 0, 1, 15 },
				{ 0, 1, 18 },
				{ 0, 2, 20 },
				{ 0, 2, 25 },
				{ 0, 3, 30 },
				{ 0, 3, 35 },
				{ 0, 4, 40 },
				{ 0, 4, 45 },
				{ 0, 5, 50 },
			},
		},
		{ gridW = 3, gridH = 4, tiles = 10, unlockLevel = 1,
			theme = "theme_02",
			name = "Classic",
			description = "Classic. 4 paylines. Win BIG!",
			stars = { 20, 40, 80 },
			tiles = {
				count = 10,
				names = {
					"1flowers",
					"sunflowers",
					"roses",
					"4flowers",
					"5flowers",
					"6flowers",
					"7flowers",
					"8flowers",
					"9flowers",
					"10flowers",
				},
			},
			reels = {
				{ 10, 6, 4, 1, 9, 9, 2, 10, 7, 8, 5, 5, 8, 3, 7, 4, 6, 2, 3, 1 },
				{ 7, 10, 9, 6, 7, 5, 1, 3, 2, 6, 3, 8, 2, 4, 8, 4, 5, 1, 10, 9 },
				{ 4, 9, 4, 9, 8, 7, 10, 1, 5, 3, 1, 8, 6, 2, 10, 6, 3, 7, 2, 5 },
			},
			lines = {
				{ 1, 1, 1 },
				{ 2, 2, 2 },
				{ 3, 3, 3 },
				{ 4, 4, 4 },
			},
			payouts = {
			-- { 1 consecutive, 2 consecutive, 3 consecutive }
				{ 0, 1, 10 },
				{ 0, 1, 15 },
				{ 0, 1, 18 },
				{ 0, 2, 20 },
				{ 0, 2, 25 },
				{ 0, 3, 30 },
				{ 0, 3, 35 },
				{ 0, 4, 40 },
				{ 0, 4, 45 },
				{ 0, 5, 50 },
			},
		},
		--	slot with a larger grid.
		--[[
		{ gridW = 4, gridH = 5, tiles = 10, unlockLevel = 1,
			theme = "theme_02",
			name = "Classic",
			description = "Classic. 5 paylines. Win BIG!",
			stars = { 20, 40, 80 },
			tiles = {
				count = 10,
				names = {
					"1flowers",
					"2flowers",
					"3flowers",
					"4flowers",
					"5flowers",
					"6flowers",
					"7flowers",
					"8flowers",
					"9flowers",
					"10flowers",
				},
			},
			reels = {
				{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 },
				{ 1, 2, 3, 4, 5, 6, 7, 8 },
				{ 1, 2, 3, 4, 5, 6, 7 },
				{ 1, 2, 3, 4, 5, },
			},
			lines = {
				{ 1, 1, 1, 1 },
				{ 2, 2, 2, 1 },
				{ 3, 3, 3, 1 },
				{ 4, 4, 4, 1 },
				{ 5, 5, 5, 1 },
				{ 1, 1, 2, 1 },
			},
			payouts = {
			-- { 1 consecutive, 2 consecutive, 3 consecutive }
				{ 0, 1, 10, 100 },
				{ 0, 2, 20, 200 },
				{ 0, 3, 30, 300 },
				{ 0, 4, 40, 400 },
				{ 0, 5, 50, 500 },
				{ 0, 6, 60, 600 },
				{ 0, 7, 70, 700 },
				{ 0, 8, 80, 800 },
				{ 0, 9, 90, 900 },
				{ 0, 10, 100, 1000 },
			},
		},
		]]
	},
}

local playerDefaults = {
	soundVolume = 1,
	musicVolume = 1,
	exp = 0,
	credits = 100,
	currentLevel = 1,
	levels = {
		{ attempts = 0, highScore = 0 },
		{ attempts = 0, highScore = 0 },
		{ attempts = 0, highScore = 0 },
		{ attempts = 0, highScore = 0 },
		{ attempts = 0, highScore = 0 },
		{ attempts = 0, highScore = 0 },
		{ attempts = 0, highScore = 0 },
		{ attempts = 0, highScore = 0 },
		{ attempts = 0, highScore = 0 },
	},
	lastBonusCollectionTime = os.time() - 200 / game.bonusRate,
	version = 1,
}
player = utils.loadTable("player")
if nil == player or player.version ~= playerDefaults.version then
	player = playerDefaults
	utils.saveTable("player")
end

utils.printTable(player)

sounds = {
	click = audio.loadSound("sounds/click.mp3"),
}

audio.setVolume(player.soundVolume, { channel = 1 })	--sfx
audio.setVolume(player.musicVolume, { channel = 2 })	--music

--music = audio.loadStream("sounds/theme_song.mp3")
--audio.play(music, { channel = 2, loops=-1, fadein=1000 })

local storyboard = require "storyboard"
storyboard.gotoScene("scene_levels")

