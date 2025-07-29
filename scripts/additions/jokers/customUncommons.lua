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
						
			matureRefLevel = 1,
			
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
			
			--[[
			Purely aesthetic as blueprint functionality, even though
			Steamodded says you need to use loc_vars, blueprint/brainstorm
			actually calls calculate(). ...Yeah. It's weird.]]
			blueprint_compat = true,
			
			--[[
			Figured out what this is - This largely defines some of the 
			stuff that shows up in the tooltip. So for example, if you
			hover over a card that mentions Stone cards and it tells
			you what Stone cards are, that's this. It's not because it
			just says 'Stone card' in the description.]]
			loc_vars = function(self, info_queue, card)
				-- Art credit tooltip
				if CirnoMod.config['artCredits'] and not card.fake_card then
					info_queue[#info_queue + 1] = { key = "jA_Unknown_LocalThunkEdit", set = "Other" }
				end
				
				-- Defines #1#.
				return { vars = { card.ability.extra.Xmult } }
			end,
			
			pos = { x = 0, y = 0},
			cost = 6,
			
			joker_display_def = function(JokerDisplay)
				---@type JDJokerDefinition
				return {
					text = {
						{ border_nodes = {
							{ text = 'X' },
							{ ref_table = 'card.ability.extra', ref_value = 'Xmult' }
						} }
					}
				}
			end,
			
			calculate = function(self, card, context)
				-- Normal joker calculation.
				if context.joker_main and next(context.poker_hands['High Card']) then
					return {
						x_mult_mod = card.ability.extra.Xmult,
						message = localize {
							type = 'variable',
							key = 'a_xmult',
							vars = { to_big(card.ability.extra.Xmult) }
						},
						colour = G.C.MULT,
						sound = 'multhit2'
					}
				end
			end
		}
	}
}

--[[ Define things that are constant with every Joker in
this file once in a loop, rather than repeatedly per
table element ]]
for i, jkr in ipairs(jokerInfo.jokerConfigs) do
	jkr.object_type = 'Joker'
	jkr.atlas = 'cir_cUncommons'
	jkr.ladOrder = 'uncmn'
	jkr.rarity = 2
end

return jokerInfo
