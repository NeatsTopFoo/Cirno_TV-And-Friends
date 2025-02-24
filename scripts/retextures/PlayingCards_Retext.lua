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

-- Which suits to replace
local cardSuits = { 'hearts', 'clubs', 'diamonds', 'spades' }

-- Which ranks to replaces
local cardRanks = { 'Jack', 'Queen', 'King' }

-- Establishes the graphic to use and sets it up so it can be read
SMODS.Atlas{
	key = 'cir_CardAtlas',
	px = 71,
	py = 95,
	path = 'Vanilla_Replacements/cir_Cards.png',
	prefix_comfig = {key = false} -- Something about a Steamodded bug
}

-- Iterates through each given suit and sets up the necessary changes in the customise deck screen
for _, suit in ipairs(cardSuits) do
    SMODS.DeckSkin{
        key = suit.."_skin",
        suit = suit:gsub("^%l", string.upper),
        ranks = cardRanks,
        lc_atlas = 'cir_CardAtlas',
        hc_atlas = 'cir_CardAtlas',
        loc_txt = {
            ['en-us'] = 'Cirno_TV & Friends'
        },
        posStyle = 'deck'
    }
end