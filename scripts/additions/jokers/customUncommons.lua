local jokerInfo = {
	isMultipleJokers = true,
	
	-- Defines the Atlas
	atlasInfo = {
		key = 'cir_cUncommons',
		path = "Additional/cir_custUncommons.png",
		px = 71,
		py = 95
	},
	
	jokerConfigs = {
		-- The Solo, x1 mult on high card lol
		{
			key = 'cir_the_solo',
			
			object_type = "Joker",
			
			loc_txt = {
				-- The name the player will see in-game.
				name = 'The Solo',
				-- The description the player will see in-game.
				text = {
					"{X:mult,C:white}X1 {} Mult if played",
					"hand contains",
                    "a {C:attention}High Card {}"
				}
			},
			
			config = { extra = { Xmult = 1 } },
			
			-- Purely aesthetic as blueprint functionality, even though
			-- Steamodded says you need to use loc_vars, blueprint/brainstorm
			-- actually calls calculate(). ...Yeah. It's weird.
			blueprint_compat = true,
			
			-- Figured out what this is - This largely defines some of the 
			-- stuff that shows up in the tooltip. So for example, if you
			-- hover over a card that mentions Stone cards and it tells
			-- you what Stone cards are, that's this. It's not because it
			-- just says 'Stone card' in the description.
			loc_vars = function(self, info_queue, card)
				-- Art credit tooltip
				if CirnoMod.allEnabledOptions['artCredits'] then
					info_queue[#info_queue + 1] = { key = "jA_Unknown_LocalThunkEdit", set = "Other" }
				end
				
				-- Defines #1#.
				return { vars = { card.ability.extra.Xmult } }
				end,
			
			atlas = 'cir_cUncommons',
			pos = { x = 0, y = 0},
			rarity = 2, -- Uncommon rarity
			cost = 6,
			
			calculate = function(self, card, context)
				-- Normal joker calculation.
				if context.joker_main and context.poker_hands['High Card'] then
					return {
						mult_mod = card.ability.extra.Xmult,
						message = localize {
							type = 'variable',
							key = 'a_xmult',
							vars = { card.ability.extra.Xmult }
						}
					}
				end
			end
		}
	}
}

return jokerInfo
