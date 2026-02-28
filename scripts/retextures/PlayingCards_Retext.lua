--[[----------------------------------
Playing Card Texture Replacement Code
--------------------------------------
As Malverk doesn't support replacing
playing card textures, we need to use
Steamodded functionality to replace
the actual playing card textures
themselves.
-------------------------------------]]

-- Which ranks to replace
local cardSuitRanks = {
	skin_1 = {
		atlasKey = 'cir_Card1Atlas',
		path = 'Additional/cir_Cards_1.png',
		Hearts = CirnoMod.miscItems.allFaceCards,
		Clubs = CirnoMod.miscItems.allFaceCards,
		Diamonds = CirnoMod.miscItems.allFaceCards,
		Spades = CirnoMod.miscItems.allFaceCards
	}
}

-- Which ranks to display in the 'customize deck' screen, in the same order
local cardRanksDisplay = { 'Ace', 'King', 'Queen', 'Jack' }

for dKey, dSkin in pairs(cardSuitRanks) do
	-- Establishes the graphic to use and sets it up so it can be read
	SMODS.Atlas{
		key = dSkin.atlasKey,
		px = 71,
		py = 95,
		path = dSkin.path,
		prefix_config = {key = false} -- Something about a Steamodded bug
	}
	
	for _, Csuit in ipairs(CirnoMod.miscItems.cardSuits) do
		if dSkin[Csuit] then
			local thisSkinKey = Csuit.."_"..dKey
			
			SMODS.DeckSkin{
				key = thisSkinKey, -- See palette key.
				suit = Csuit,
				loc_txt = {
					['default'] = 'Cirno_TV & Friends' -- The text that appears on the skin cycle.
				},
				palettes = {
					{
						--[[
						Idk why we need two keys for this, but they need to	be
						distinct, I think - Which is why the first one is longer.]]
						key = Csuit..'skin_hc',
						ranks = dSkin[Csuit], -- The ranks that get replaced by this.
						display_ranks = cardRanksDisplay, -- The ranks shown in the 'customise deck' screen.
						atlas = dSkin.atlasKey,
						posStyle = 'deck',
						loc_txt = {
							--[[
							This appears at the bottom where the customise
							deck screen, where it normally says low or high
							contrast colour.]]
							['default'] = 'Cirno_TV & Friends '..Csuit
						},
						--[[
						Forces the other cards that don't get replaced to be
						their high contrast variants.]]
						hc_default = true
					}
				}
			}
		
			-- Adds the name of each deck skin as it will be internally referred to for art credit detection
			CirnoMod.miscItems.deckSkinNames[Csuit] = "cir_"..thisSkinKey
			CirnoMod.miscItems.deckSkinWhich[CirnoMod.miscItems.deckSkinNames[Csuit]] = dKey
		end
	end
end