--[[----------------------------------
Playing Card Texture Replacement Code
--------------------------------------
As Malverk doesn't support replacing
playing card textures (to my knowledge
& as far as I can determine in looking
through the code base), we need to use
Steamodded functionality (or whichever
other system) to replace the actual
playing card textures themselves.
-------------------------------------]]

--[[
Which suits to replace.
Must start with a capital letter.]]
local cardSuits = { 'Hearts', 'Clubs', 'Diamonds', 'Spades' }

-- Which ranks to replace
local cardSuitRanks = {
	skin_1 = {
		Hearts = copy_table(CirnoMod.miscItems.allFaceCards),
		Clubs = copy_table(CirnoMod.miscItems.allFaceCards),
		Diamonds = copy_table(CirnoMod.miscItems.allFaceCards),
		Spades = copy_table(CirnoMod.miscItems.allFaceCards)
	}
}

-- Which ranks to display in the 'customize deck' screen
local cardRanksDisplay = { 'Jack', 'Queen', 'King' }

-- Establishes the graphic to use and sets it up so it can be read
SMODS.Atlas{
	key = 'cir_CardAtlas',
	px = 71,
	py = 95,
	path = 'Additional/cir_Cards_1.png',
	prefix_config = {key = false} -- Something about a Steamodded bug
}

--[[
Iterates through each given suit and sets up the
necessary changes in the customise deck screen]]
for _, Csuit in ipairs(cardSuits) do
    SMODS.DeckSkin{
        key = "noAndFriends_"..Csuit.."_skin_hc", -- See palette key.
        suit = Csuit,
        loc_txt = {
            ['en-us'] = 'Cirno_TV & Friends' -- The text that appears on the skin cycle.
        },
		palettes = {
			{
				--[[
				Idk why we need two keys for this, but they need to	be
				distinct, I think - Which is why the first one is longer.]]
				key = Csuit..'skin_hc',
				ranks = cardSuitRanks.skin_1[Csuit], -- The ranks that get replaced by this.
				display_ranks = cardRanksDisplay, -- The ranks shown in the 'customise deck' screen.
				atlas = 'cir_CardAtlas',
				posStyle = 'deck',
				-- colour = G.C.SO_2[suit],
				loc_txt = {
					--[[
					This appears at the bottom where the customise
					deck screen, where it normally says low or high
					contrast colour.]]
					['en-us'] = 'Cirno_TV & Friends '..Csuit
				},
				--[[
				Forces the other cards that don't get replaced to be
				their high contrast variants.]]
				hc_default = true
			}
		}
    }

	-- Adds the name of each deck skin as it will be internally referred to for art credit detection
	CirnoMod.miscItems.deckSkinNames[Csuit] = "cir_noAndFriends_"..Csuit.."_skin_hc"
	CirnoMod.miscItems.deckSkinWhich[CirnoMod.miscItems.deckSkinNames[Csuit]] = "cirSkin_1"
end