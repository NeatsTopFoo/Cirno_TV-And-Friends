--------------------------------------------------
----- Playing Card Texture Replacement Code ------
--------------------------------------------------
----- As Malverk doesn't support replacing   -----
----- playing card textures (to my knowledge -----
----- & as far as I can determine in looking -----
----- through the code base), we need to use -----
----- Steamodded functionality (or whichever -----
----- other system) to replace the actual    -----
----- playing card textures themselves.		 -----
--------------------------------------------------

-- Unsure why this doesn't work. This should work. But it isn't.

-- Which suits to replace
local suits = { 'hearts', 'clubs', 'diamonds', 'spades' }

-- Which ranks to replaces
local ranks = { "Jack", "Queen", "King" }

-- Establishes the graphic to use and sets it up so it can be read
SMODS.Atlas{
	key = 'cir_CardAtlas',
	px = 71,
	py = 95,
	path = 'cir_Cards.png',
	prefix_comfig = {key = false} -- Something about a Steamodded bug
}

-- Iterates through each given suit and sets up the necessary changes in the customise deck screen
for _, suit in ipairs(suits) do
	SMODS.DeckSkin{
		key = suit.."_skin",
		suit = suit:gsub("^$1", string.upper),
		ranks = ranks,
		lc_atlas = 'cir_CardAtlas',
		hc_atlas = 'cir_CardAtlas',
		loc_txt = {
			['en-us'] = 'Cirno_TV & Friends'
		},
		posStyle = 'deck'
	}
end