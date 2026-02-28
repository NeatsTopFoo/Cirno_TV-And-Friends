if CirnoMod.config.addCustomDecks then
	CirnoMod.miscItems.keepsakeRarity = SMODS.Rarity{
		key = 'keepsake_r',
		loc_txt = { name = 'Keepsake' },
		badge_colour = CirnoMod.miscItems.colours.cirKeepsakeClr,
		pools = {}
	}
end

local jokerInfo = {
	isMultipleJokers = true,
	
	dependenciesForAddition = function()
		return CirnoMod.config.addCustomConsumables
	end,
	
	-- Defines the Atlas
	atlasInfo = {
		key = 'cir_decksAndKeepsakes',
		path = "Additional/cir_custDecks.png",
		px = 71,
		py = 95
	}
	
	--[[ TODO:
		- Chocola Figurine
		- Ollie
		- Pudding
		- Artorias
		- Whatever I figure out for Rumi
		- Pot of Greed
		- Red Star
		- Whatever I figure out for Wolsk
		- Whatever I figure out for Demeorin
		- Bingo Sheet
		- True Dragon's Katana
		- Whatever I figure out for Reimmomo
		- Whatever I figure out for Octopimp
		- Lucky Chloe
		- Whatever I figure out for Vileelf
	]]
	jokerConfigs = {
		-- Zayne
		{
			key = 'zayne',
			matureRefLevel = 1,
			loc_txt = { name = 'Zayne',
				text = {
					'Todo',
					'{s:0.8,C:inactive}Doing just fine'
				}
			},
			
			config = {
				extra = {
					extra = 1
				}
			},
			
			pos = { x = 0, y = 1 },
			eternal_compat = false,
			perishable_compat = false
		}
	}
}

for i, jkr in ipairs(jokerInfo.jokerConfigs) do
	jkr.object_type = 'Joker'
	jkr.atlas = 'cir_decksAndKeepsakes'
	jkr.rarity = 'cir_keepsake_r'
	
	jkr.unlocked = false
	jkr.loc_txt.unlock = {
		"{E:1,C:attention}?????"
	}
	
end