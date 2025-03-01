-- I decided to make all Legendaries one file for now, as
-- I don't think that we'll be adding very many. If we do,
-- we can just do them in parts?

-- I plan on doing more multiple-in-one with most likely
-- every Common & Uncommon we come up with, as well as
-- probably every Rare we come up with, with the likely
-- exceptions being how complex or elaborate certain
-- jokers may be.
-- For example, I have an idea for a Padoru
-- Rare that would probably have a big atlas: Essentially,
-- the idea is it'll have 12 bases, one for each month
-- then a bit more than 31 floating 'soul' ones, one for
-- each day, however there'll be some extra more excited
-- looking ones for December. With the effect that it
-- givse +mult for half inverse the amount of remaining
-- days until Xmas, rounded up (so for example, Xmas day
-- would be 365/2) & x1.5 mult if played hand contains a
-- three of a kind of kings - That will likely be its own
-- lua file. But B3313, which is planned to have 13 bases,
-- funnily enough, will probably be part of the (first?)
-- Rare atlas(es).

local jokerInfo = {
	isMultipleJokers = true,
	
	-- Defines the Atlas
	atlasInfo = {
		key = 'cir_cLegendaries',
		path = "Additional/cir_custLegendaries.png",
		px = 71,
		py = 95
	},
	
	-- Since this specifically will be multiple Jokers in one file,
	-- all on one atlas, we will give each
	jokerConfigs = {
		-- Cirno Legendary.
		{
			-- How the Joker will be referred to internally.
			key = 'cirL_cirno',
			
			object_type = "Joker",
			
			loc_txt = {
				-- The name the player will see in-game.
				name = 'Cirno',
				-- The description the player will see in-game.
				text = {
					"This Joker gains",
					"{X:mult,C:white}X0.09 {} Mult for each",
					"scored {C:attention}9 {}",
					"{C:inactive}(Currently {X:mult,C:white}X#1# {C:inactive} Mult)"
				}
			},
			
			config = { extra = { Xmult = 1 } },
			
			-- Purely aesthetic as blueprint functionality, even though
			-- Steamodded says you need to use loc_vars, blueprint/brainstorm
			-- actually calls calculate(). ...Yeah. It's weird.
			blueprint_compat = true,
			
			-- Unknown
			loc_vars = function(self, info_queue, card)
				return { vars = { card.ability.extra.Xmult } }
				end,
			
			atlas = 'cir_cLegendaries',
			pos = { x = 0, y = 0}, -- Defines base card graphic position in the atlas.
			soul_pos = { x = 0, y = 1}, -- Defines where this card's soul overlay is in the given atlas
			rarity = 4, -- Legendary rarity
			cost = 20, -- Sell value, since Legendary Jokers only appear via Soul spectral cards.
			
			-- What actually happens when the joker needs to do something.
			calculate = function(self, card, context)
				-- Normal joker calculation.
				if context.joker_main then
					return {
						mult_mod = card.ability.extra.Xmult,
						message = localize {
							type = 'variable',
							key = 'a_xmult',
							vars = { card.ability.extra.Xmult }
						}
					}
				end
				
				-- Looks for scored 9s and increases the stored mult
				-- on the card accordingly.
				if
					context.individual
					and context.cardarea == G.play
					and context.blueprint_card == nil -- So, blueprint and brainstorm call calculate(). Yeah.
				then
					if context.other_card:get_id() == 9 then
						card.ability.extra.Xmult = card.ability.extra.Xmult + 0.09
						return {
							message = localize {
								type = 'variable',
								key = 'a_xmult',
								vars = { card.ability.extra.Xmult }
							}
						}
					end
				end
			end
		},
		-- Nope Legendary.
		{
			-- How the Joker will be referred to internally.
			key = 'cirL_nope',
			
			object_type = "Joker",
			
			loc_txt = {
				-- The name the player will see in-game.
				name = "NopeTooFast",
				-- The description the player will see in-game.
				text = {
					"This Joker gains",
					"{X:mult,C:white} X#1# {} Mult when failing",
					"a {C:attention}"..G.localization.descriptions.Tarot.c_wheel_of_fortune.name.."{}",
					"{C:inactive}(Currently {X:mult,C:white} X#2# {C:inactive} Mult)",
					"{s:0.8,C:inactive}\"I mean, it is my wheel. Ehe~\""
				}
			},
			
			-- 'Extra' is how much the joker will gain on wheel failure.
			-- 'X_Mult' is the card's stored mult.
			-- I think this should ultimately be fine, since you can't
			-- use a Wheel of Fortune if all Jokers have editions, so
			-- scaling it requires at least one Joker that doesn't have
			-- an edition, plus it has anti-synergy with oops all 6s.
			-- I mean yes, you can dip in to look for more wheels so
			-- long as you have the econ, but you will always hit a
			-- stopping point if everything ends up with editions and
			-- you don't want to potentially jeopardise your build
			-- for the potential promise of a little more xmult.
			config = { extra = { extra = 1, x_mult = 1 } }, 
			
			-- Purely aesthetic as blueprint functionality, even though
			-- Steamodded says you need to use loc_vars, blueprint/brainstorm
			-- actually calls calculate(). ...Yeah. It's weird.
			blueprint_compat = true,
			
			-- Unknown
			loc_vars = function(self, info_queue, center)
				info_queue[#info_queue + 1] = G.P_CENTERS.c_wheel_of_fortune
				return { vars = { center.ability.extra.extra, center.ability.extra.x_mult } }
			end,
			
			atlas = 'cir_cLegendaries',
			pos = { x = 1, y = 0}, -- Defines base card graphic position in the atlas.
			soul_pos = { x = 1, y = 1}, -- Defines where this card's soul overlay is in the given atlas
			rarity = 4, -- Legendary rarity
			cost = 20, -- Sell value, since Legendary Jokers only appear via Soul spectral cards.
			eternal_compat = true,
			perishable_compat = true,
			
			-- Define what the card does
			calculate = function(self, card, context)
				-- This section seems to define the standard joker function? Which would be multiplying the mult by the stored around
				if
					context.cardarea == G.jokers -- If we are iterating through owned jokers
					and	context.joker_main -- If the context is during the main scoring timing of jokers
					and (card.ability.extra.x_mult > 1) -- And the card's mult is more than 1
					and mult ~= nil -- And global mult is not nil
					and not context.before -- Context before is things that happen in the scoring loop, but before anything is scored
					and not context.after -- Context after is things that modify the score after all cards are scored
				then
					return { -- Multiply the current mult by mult accrued on card?
						message = localize({ type = "variable", key = "a_xmult", vars = { card.ability.extra.x_mult } }), -- Message popup
						Xmult_mod = card.ability.extra.x_mult -- Multiplies the current mult by the card's stored mult
					}, true
				end
				-- This section seems to be it detecting the use of a wheel of fortune tarot
				if
					context.consumeable
					and context.blueprint_card == nil -- Don't do this if blueprint
				then -- If we're using a consumeable,
					if
						context.consumeable.ability.name == "The Wheel of Fortune" -- Is the consumeable the wheel of fortune tarot?
						and not context.consumeable.cirNtf_wheel_success -- This variable is defined in the lovely.toml,
																	-- it inserts code to detect wheel usage
					then
						-- Add the extra mult as defined in config extra extra above, to the card's stored mult in config extra x_mult
						card.ability.extra.x_mult = card.ability.extra.x_mult + card.ability.extra.extra
						card_eval_status_text(
							card,
							"extra", -- This appears to be parsing what is happening and updating the card description accordingly
							nil,
							nil,
							nil,
							-- Message popup beneath the joker
							{ message = localize({ type = "variable", key = "a_xmult", vars = { card.ability.extra.x_mult } }) })
						
						-- Animate wink
						G.E_MANAGER:add_event(Event({
							trigger = 'immediate',
							delay = 0.01,
							blocking = false,
							func = function()
								card.config.center.soul_pos.y = 2
								card:set_sprites(card.config.center)
								
								G.E_MANAGER:add_event(Event({
									trigger = 'after',
									delay = 0.3,
									blocking = false,
									func = function()
										card.config.center.soul_pos.y = 1
										card:set_sprites(card.config.center)
										return true
									end}))
								return true
							end}))
						return nil, true
					end
				end
				return nil, false
			end
		}
	}
}

return jokerInfo