--[[
I decided to make all Legendaries one file for now, as
I don't think that we'll be adding very many. If we do,
we can just do them in parts?]]

--[[
I plan on doing more multiple-in-one with most likely
every Common & Uncommon we come up with, as well as
probably every Rare we come up with, with the likely
exceptions being mature references and how complex
or elaborate certain jokers may be.
For example, I have an idea for a Padoru
Rare that would probably have a big atlas: Essentially,
the idea is it'll have 12 bases, one for each month
then a bit more than 31 floating 'soul' ones, one for
each day, however there'll be some extra more excited
looking ones for December. With the effect that it
givse +mult for half inverse the amount of remaining
days until Xmas, rounded up (so for example, Xmas day
would be 365/2) & x1.5 mult if played hand contains a
three of a kind of kings - That will likely be its own
lua file. But B3313, which is planned to have 13 bases,
funnily enough, will probably be part of the (first?)
Rare atlas(es).]]
local intents = {
	c_wheel = G.localization.descriptions.Tarot.c_wheel_of_fortune.name,
	j_ice_cream = G.localization.descriptions.Joker.j_ice_cream.name
}

if
	CirnoMod.config.jokerRenames
	and CirnoMod.replaceDef
	and CirnoMod.replaceDef.locChanges
	and CirnoMod.replaceDef.locChanges.jkrLoc.nrmJkrs.j_ice_cream
then
	intents.j_ice_cream = CirnoMod.replaceDef.locChanges.jkrLoc.nrmJkrs.j_ice_cream.name
end

if CirnoMod.config.planetTarotSpectralRenames then
	intents.c_wheel = "Wheel of Nope"
end

local jokerInfo = {
	isMultipleJokers = true,
	
	-- Defines the Atlas
	atlasInfo = {
		key = 'cir_cLegendaries',
		path = "Additional/cir_custLegendaries.png",
		px = 71,
		py = 95
	},
	
	--[[
	Since this specifically will be multiple Jokers in one file,
	all on one atlas, we will give each
	
	Wow, did I not finish writing this? I don't remember my original
	train of thought. This sentence stays unfinished.]]
	jokerConfigs = {
		-- Cirno Legendary.
		{
			-- How the Joker will be referred to internally.
			key = 'cirno_l',
			
			object_type = "Joker",
			
			matureRefLevel = 1,
			
			loc_txt = {
				-- The name the player will see in-game.
				name = 'Cirno',
				-- The description the player will see in-game.
				text = {
					"This {C:joker}Joker{} gains {X:mult,C:white}X0.09 {} Mult",
					"for each scored {C:attention}9{}",
					"{s:0.8,C:red}If {s:0.8,C:attention}"..intents.j_ice_cream.."{s:0.8,C:red} is present, it",
					"{s:0.8,C:red}expires immediately when triggered.",
					"{C:inactive}(Currently {X:mult,C:white}X#1# {C:inactive} Mult)",
					"{s:0.8,C:inactive}\"I don't mean to brag Chat,",
					"{s:0.8,C:inactive}but I'm stupid.\""
				},
				unlock = {
					"Find this {C:joker}Joker",
					"from the {C:spectral}Soul{} card"
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
			stuff that shows up in the tooltip (and more. So for example,
			if you hover over a card that mentions Stone cards and it tells
			you what Stone cards are, that's this. It's not because it
			just says 'Stone card' in the description.]]
			loc_vars = function(self, info_queue, card)
				-- Ice Cream :)
				info_queue[#info_queue + 1] = G.P_CENTERS.j_ice_cream
				
				-- Art credit tooltip
				if
					CirnoMod.config.artCredits
					and not CirnoMod.config.malverkReplacements -- Ice Cream  already has a duplicate credit in its queue
				then
					info_queue[#info_queue + 1] = { key = "jA_DaemonTsun", set = "Other" }
				end
				
				-- Defines #1#
				return { vars = { card.ability.extra.Xmult } }
				end,
			unlocked = false,
			
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
						x_mult = card.ability.extra.Xmult,
						message = localize {
							type = 'variable',
							key = 'a_xmult',
							vars = { card.ability.extra.Xmult }
						},
						colour = CirnoMod.miscItems.colours.cirCyan,
						card = card
					}
				end
				
				if
					context.individual
					and context.cardarea == G.play
				then
					if context.other_card:get_id() == 9 then
						card.ability.extra.Xmult = card.ability.extra.Xmult + 0.09
						
						return {
							message = localize {
								type = 'variable',
								key = 'a_xmult',
								vars = { card.ability.extra.Xmult }
							},
							colour = CirnoMod.miscItems.colours.cirCyan,
							card = card
						}
					end
				end
				
				-- Looks for scored 9s and increases the stored mult
				-- on the card accordingly.
				if
					context.blueprint_card == nil -- So, blueprint and brainstorm call calculate(). Yeah.
					and context.post_trigger
					and not context.retrigger_joker
					and context.other_context.joker_main
					and context.other_card
					and context.other_card.config.center.key == 'j_ice_cream'
				then						
					G.E_MANAGER:add_event(Event({
						trigger = 'immediate',
						blocking = false,
						blockable = true,
						func = function()
							SMODS.calculate_effect({
								message = "Dropped!",
								colour = G.C.RED,
								sound = 'cir_j_matchaDrop',
								pitch = 1.0
							}, context.other_card)
							
							G.E_MANAGER:add_event(Event({
								trigger = 'after',
								delay = 0.5,
								blocking = false,
								func = function()
									context.other_card:start_dissolve({
											G.C.GREEN,
											CirnoMod.miscItems.colours.cirLucy,
											G.C.GREEN,
											CirnoMod.miscItems.colours.cirLucy,
											G.C.GREEN
										}, true)
									return true
								end}))
							
							return true
						end}))
				end
			end
		},
		-- Nope Legendary.
		{
			-- How the Joker will be referred to internally.
			key = 'nope_l',
			
			object_type = "Joker",
			
			matureRefLevel = 1,
			
			loc_txt = {
				-- The name the player will see in-game.
				name = "NopeTooFast",
				-- The description the player will see in-game.
				text = {
					"This {C:joker}Joker{} gains",
					"{X:mult,C:white} X#1# {} Mult when failing",
					"a {C:attention}"..intents.c_wheel.."{}",
					"{C:inactive}(Currently {X:mult,C:white} X#2# {C:inactive} Mult)",
					"{s:0.8,C:inactive}\"I mean, it is my wheel. Ehe~\""
				},
				unlock = {
					"Find this {C:joker}Joker",
					"from the {C:spectral}Soul{} card"
				}
			},
			
			--[[
			'Extra' is how much the joker will gain on wheel failure.
			'X_Mult' is the card's stored mult.
			I think this should ultimately be fine, since you can't
			use a Wheel of Fortune if all Jokers have editions, so
			scaling it requires at least one Joker that doesn't have
			an edition, plus it has anti-synergy with oops all 6s.
			I mean yes, you can dip in to look for more wheels so
			long as you have the econ, but you will always hit a
			stopping point if everything ends up with editions and
			you don't want to potentially jeopardise your build
			for the potential promise of a little more xmult.]]
			config = { extra = { extra = 1, x_mult = 1 } }, 
			
			--[[
			Purely aesthetic as blueprint functionality, even though
			Steamodded says you need to use loc_vars, blueprint/brainstorm
			actually calls calculate(). ...Yeah. It's weird.]]
			blueprint_compat = true,
			
			--[[
			Figured out what this is - This largely defines some of the 
			stuff that shows up in the tooltip (and more. So for example,
			if you hover over a card that mentions Stone cards and it tells
			you what Stone cards are, that's this. It's not because it
			just says 'Stone card' in the description.]]
			loc_vars = function(self, info_queue, center)
				-- Adds a description of Wheel of Fortune to tooltip by appending
				-- to info_queue
				info_queue[#info_queue + 1] = G.P_CENTERS.c_wheel_of_fortune
				
				-- Art credit tooltip
				if CirnoMod.config['artCredits'] then
					info_queue[#info_queue + 1] = { key = "jA_DaemonTsun_BigNTFEDit", set = "Other" }
				end
				
				-- Here is how #1# and #2# are defined.
				return { vars = { center.ability.extra.extra, center.ability.extra.x_mult } }
			end,
			unlocked = false,
			
			atlas = 'cir_cLegendaries',
			pos = { x = 1, y = 0}, -- Defines base card graphic position in the atlas.
			soul_pos = { x = 1, y = 1}, -- Defines where this card's soul overlay is in the given atlas
			rarity = 4, -- Legendary rarity
			cost = 20, -- Sell value, since Legendary Jokers only appear via Soul spectral cards.
			eternal_compat = true,
			perishable_compat = true,
			
			change_soul_pos = function(card, newSoulPos)
				card.config.center.soul_pos = newSoulPos
				card:set_sprites(card.config.center)
			end,
			
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
						x_mult = card.ability.extra.x_mult, -- Multiplies the current mult by the card's stored mult
						card = card
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
						--[[card_eval_status_text(
							card,
							"extra", -- This appears to be parsing what is happening and updating the card description accordingly
							nil,
							nil,
							nil,
							-- Message popup beneath the joker
							{
								message = localize({ type = "variable", key = "a_xmult", vars = { card.ability.extra.x_mult } })
							}
						)]]
						
						-- Animate wink
						G.E_MANAGER:add_event(Event({
							trigger = 'immediate',
							delay = 0.01,
							blocking = false,
							func = function()
								card.change_soul_pos(card, { x = 1, y = 2 })
								
								G.E_MANAGER:add_event(Event({
									trigger = 'after',
									delay = 0.3,
									blocking = false,
									func = function()
										card.change_soul_pos(card, { x = 1, y = 1 })
										return true
									end}))
								return true
							end}))
						return {
							message = localize({ type = "variable", key = "a_xmult", vars = { card.ability.extra.x_mult } }),
							colour = G.C.PURPLE,
							card = card
						}, true
					end
				end
			end
		},
		-- Naro Legendary.
		{
			-- How the Joker will be referred to internally.
			key = 'naro_l',
			
			object_type = "Joker",
			
			matureRefLevel = 1,
			
			loc_txt = {
				-- The name the player will see in-game.
				name = "Naro",
				-- The description the player will see in-game.
				text = {
					"This {C:joker}Joker{} gains {X:mult,C:white} X#1# ",
					"Mult for every {C:cirNep}"..G.localization.descriptions.Planet.c_neptune.name,
					"used this run",
					"{C:inactive}(Currently {X:mult,C:white} X#2# {C:inactive} Mult)",
					"{s:0.8,C:inactive}He is the missile.",
					"{s:0.8,C:inactive}He knows where he is."
				},
				unlock = {
					"Find this {C:joker}Joker",
					"from the {C:spectral}Soul{} card"
				}
			},
			
			config = { extra = { extra = 1 } },
			
			blueprint_compat = true,
			loc_vars = function(self, info_queue, center)
				-- Adds a description of Neptune to tooltip by appending
				-- to info_queue
				info_queue[#info_queue + 1] = G.P_CENTERS.c_neptune
				
				-- Art credit tooltip
				if CirnoMod.config['artCredits'] then
					info_queue[#info_queue + 1] = { key = "jA_DaemonTsun_BigNTFEdit", set = "Other" }
				end
				
				-- Here is how #1# and #2# are defined.
				if G.GAME.consumeable_usage then
					if G.GAME.consumeable_usage['c_neptune'] then
						return { vars = { center.ability.extra.extra, (G.GAME.consumeable_usage['c_neptune'].count * center.ability.extra.extra) + 1 or 1 } }
					else
						return { vars = { center.ability.extra.extra, 1 } }
					end
				else
					return { vars = { center.ability.extra.extra, 1 } }
				end
			end,
			unlocked = false,
			
			atlas = 'cir_cLegendaries',
			pos = { x = 0, y = 2}, -- Defines base card graphic position in the atlas.
			soul_pos = { x = 0, y = 3}, -- Defines where this card's soul overlay is in the given atlas
			rarity = 4, -- Legendary rarity
			cost = 20, -- Sell value, since Legendary Jokers only appear via Soul spectral cards.
			eternal_compat = true,
			perishable_compat = true,
			
			calculate = function(self, card, context)
				-- This section seems to define the standard joker function? Which would be multiplying the mult by the stored around
				if
					context.cardarea == G.jokers -- If we are iterating through owned jokers
					and	context.joker_main -- If the context is during the main scoring timing of jokers
					and G.GAME.consumeable_usage -- And global consumeable usage exists
					and G.GAME.consumeable_usage['c_neptune'] -- And at least one neptune has been used.
					and mult ~= nil -- And global mult is not nil
					and not context.before -- Context before is things that happen in the scoring loop, but before anything is scored
					and not context.after -- Context after is things that modify the score after all cards are scored
				then
					return { -- Multiply the current mult by mult accrued on card?
						message = localize(
						{
							type = "variable",
							key = "a_xmult",
							vars = {
									(G.GAME.consumeable_usage_total and (G.GAME.consumeable_usage['c_neptune'].count * card.ability.extra.extra) + 1 or 1)
								}
						}), -- Message popup
						x_mult = (G.GAME.consumeable_usage_total and (G.GAME.consumeable_usage['c_neptune'].count * card.ability.extra.extra) + 1 or 1) -- Multiplies the current mult by the desired amount
					}, true
				elseif
					context.blueprint_card == nil
					and context.consumeable
					and G.GAME.consumeable_usage
					and not context.retrigger_joker -- Is this not a retrigger?
					and not context.post_trigger -- Is this not a retrigger?
				then
					if
						context.consumeable.ability.name == "Neptune"
					then
						return { -- Multiply the current mult by mult accrued on card?
							message = localize(
							{
								type = "variable",
								key = "a_xmult",
								vars = {
										(G.GAME.consumeable_usage_total and (G.GAME.consumeable_usage['c_neptune'].count * card.ability.extra.extra) + 1 or 1)
									}
							}),
							colour = CirnoMod.miscItems.colours.cirNep
						}, true
					end
				end
			end
		},
		-- Arumia Legendary
		{
			-- How the Joker will be referred to internally.
			key = 'arumia_l',
			
			object_type = "Joker",
			
			matureRefLevel = 1,
			
			loc_txt = {
				-- The name the player will see in-game.
				name = "ArumiaTheSleepy",
				-- The description the player will see in-game.
				text = {},
				unlock = {
					"Find this {C:joker}Joker",
					"from the {C:spectral}Soul{} card"
				}
			},
			
			config = {
				extra = {
					extra = 0.9,
					xChips = 1,
					xMult = 1,
					active = 'Chips',
					discardDecrementCounter = 9,
					chipsMultOpposite = { Chips = 'Mult', Mult = 'Chips' },
					chipsMultColour = { Chips = G.C.CHIPS, Mult = G.C.MULT },
					chipsMultSoulSpritePos = { Normal = { x = 2, y = 1 }, Chips = { x = 2, y = 2 }, Mult = { x = 2, y = 3 } },
					desiredSpriteState = 'Normal',
					handWasPlayed = false
				}
			},
			
			--[[ ...This is the madness that is a main_end creation.
			In loc_vars(), if you return UI code in the var 'main_end',
			it will append to the Joker's description (IIRC, there's
			also 'main_start' for prepending).
			
			To make a Joker description that dynamically changes
			in-game based on certain conditions - For pure, basic text
			alterations like what I do over in Joker_Renames with The
			Family where I set it up to randomly flip that part of text,
			I just cheat and use a variable in the description, which
			gets controlled with a function.
			
			But to specifically do other stuff like dynamically
			changing stuff like {X:[colour]} or changing out
			non-highlighted text for highlighted text and vice-versa,
			etc, this is basically the only method.
			
			It is pain. But as a side bonus, can overcome the weird
			limitation of spaces not working with {X:[colour]} in
			normal loc text vars.
			
			This is NOT the most efficient main_end code or otherwise
			best way to do this, but I like to think that it's done
			pretty well.]]
			create_main_end = function(center)
				local nodes_ = {
					Ln1 = {},
					Ln2 = {},
					Ln3 = {},
					Ln4 = {},
					Ln5 = {},
					Ln6 = {},
					Ln7 = {},
					Ln8 = {},
					Ln9 = {},
					Ln10 = {}
				}
				--[[LUA IS FUCKING STUPIDDDDDDDDD
				THE ORDER YOU ESTABLISH A TABLE
				DOESN'T MATTER, SINCE THE PAIRS()
				FUNCTION WILL ACCESS ITS INDICES
				IN A WEIRD, ARBITRARY & SEEMINGLY
				RANDOM ORDER AND YOU CAN'T JUST
				SORT THE TABLE BY KEY WITHOUT
				STARTING WITH A ANOTHER LOOP
				FIRST TO ITERATE THROUGH THE
				TABLE, SO I HAVE TO DO THIS SO IT
				CAN ITERATE	THROUGH	THE NODES IN
				THE ORDER I ACTUALLY INTEND THE
				FINAL UI TO BE! HOLY FUCK THIS IS
				DUMB, THUNK WHY DID YOU MAKE THE 
				GAME IN THIS GARBAGE LANGUAGE
				AND NOT A SUPERIOR ONE THAT HAS
				SOLVED THIS TOTAL NON-ISSUE AND
				MORE, LIKE C#?!
				ABSOLUTELY INCREDIBLE.]]
				local nodeKeys = {
					'Ln1',
					'Ln2',
					'Ln3',
					'Ln4',
					'Ln5',
					'Ln6',
					'Ln7',
					'Ln8',
					'Ln9',
					'Ln10'
				}
				
				CirnoMod.miscItems.addUITextNode(nodes_.Ln1, 'Switches between ', G.C.UI.TEXT_DARK, 1)
				
				CirnoMod.miscItems.addUITextNode(
					CirnoMod.miscItems.addUIColumnOrRowNode(
						nodes_.Ln1,
						'm',
						'C',
						G.C.CHIPS,
						0,
						0.025).nodes,
					'X Chips',
					G.C.UI.TEXT_LIGHT,
					1)
				
				CirnoMod.miscItems.addUITextNode(nodes_.Ln1, ' & ', G.C.UI.TEXT_DARK, 1)
				
				CirnoMod.miscItems.addUITextNode(
					CirnoMod.miscItems.addUIColumnOrRowNode(
						nodes_.Ln1,
						'm',
						'C',
						G.C.MULT,
						0,
						0.025).nodes,
					'X Mult',
					G.C.UI.TEXT_LIGHT,
					1)
				
				CirnoMod.miscItems.addUITextNode(nodes_.Ln2, 'after each ', G.C.UI.TEXT_DARK, 1)
				CirnoMod.miscItems.addUITextNode(nodes_.Ln2, 'hand', G.C.BLUE, 1)
				CirnoMod.miscItems.addUITextNode(nodes_.Ln2, ' played', G.C.UI.TEXT_DARK, 1)
				
				
				CirnoMod.miscItems.addUITextNode(nodes_.Ln3, '(Selected: ', G.C.UI.TEXT_INACTIVE, 1)
				
				CirnoMod.miscItems.addUITextNode(
					CirnoMod.miscItems.addUIColumnOrRowNode(
						nodes_.Ln3,
						'm',
						'C',
						center.ability.extra.chipsMultColour[center.ability.extra.active],
						0,
						0.025).nodes,
					'X '..center.ability.extra.active,
					G.C.UI.TEXT_LIGHT,
					1)
				
				CirnoMod.miscItems.addUITextNode(nodes_.Ln3, ')', G.C.UI.TEXT_INACTIVE, 1)
				
				
				CirnoMod.miscItems.addUITextNode(nodes_.Ln4, 'After ', G.C.UI.TEXT_DARK, 1)
				CirnoMod.miscItems.addUITextNode(nodes_.Ln4, '2-9', G.C.GREEN, 1)
				CirnoMod.miscItems.addUITextNode(nodes_.Ln4, ' cards ', G.C.UI.TEXT_DARK, 1)
				CirnoMod.miscItems.addUITextNode(nodes_.Ln4, 'discarded', G.C.RED, 1)
				
				CirnoMod.miscItems.addUITextNode(nodes_.Ln5, '(', G.C.UI.TEXT_DARK, 1)
				CirnoMod.miscItems.addUITextNode(nodes_.Ln5, center.ability.extra.discardDecrementCounter, G.C.FILTER, 1)
				CirnoMod.miscItems.addUITextNode(nodes_.Ln5, ' remaining), increases value', G.C.UI.TEXT_DARK, 1)
				
				CirnoMod.miscItems.addUITextNode(nodes_.Ln6, 'not selected', G.C.FILTER, 1)
				CirnoMod.miscItems.addUITextNode(nodes_.Ln6, ' by ', G.C.UI.TEXT_DARK, 1)
				CirnoMod.miscItems.addUITextNode(nodes_.Ln6, 'X'..center.ability.extra.extra, G.C.FILTER, 1)
				CirnoMod.miscItems.addUITextNode(nodes_.Ln6, ', then ', G.C.UI.TEXT_DARK, 1)
				CirnoMod.miscItems.addUITextNode(nodes_.Ln6, 'rerolls', G.C.GREEN, 1)
				
				CirnoMod.miscItems.addUITextNode(nodes_.Ln7, 'requirement', G.C.UI.TEXT_DARK, 1)
				
				CirnoMod.miscItems.addUITextNode(nodes_.Ln8, '(Currently ', G.C.UI.TEXT_INACTIVE, 1)
				
				CirnoMod.miscItems.addUITextNode(
					CirnoMod.miscItems.addUIColumnOrRowNode(
						nodes_.Ln8,
						'm',
						'C',
						G.C.CHIPS,
						0,
						0.025).nodes,
					'X'..center.ability.extra.xChips,
					G.C.UI.TEXT_LIGHT,
					1)
				
				CirnoMod.miscItems.addUITextNode(nodes_.Ln8, ' Chips, ', G.C.UI.TEXT_INACTIVE, 1)
				
				CirnoMod.miscItems.addUITextNode(
					CirnoMod.miscItems.addUIColumnOrRowNode(
						nodes_.Ln8,
						'm',
						'C',
						G.C.MULT,
						0,
						0.025).nodes,
					'X'..center.ability.extra.xMult,
					G.C.UI.TEXT_LIGHT,
					1)
				
				CirnoMod.miscItems.addUITextNode(nodes_.Ln8, ' Mult)', G.C.UI.TEXT_INACTIVE, 1)
				
				CirnoMod.miscItems.addUITextNode(nodes_.Ln9, "...So, you fall asleep from reading this yet?", G.C.UI.TEXT_INACTIVE, 0.8)
				
				CirnoMod.miscItems.addUISpriteNode(nodes_.Ln10, Sprite(
					0, 0, -- Sprite X & Y
					1, 1, -- Sprite W & H
					CirnoMod.miscItems.funnyAtlases.rumiSleep, -- Sprite Atlas
					{ x = 0, y = 0 } -- Position in the Atlas
				)
			)
				
				return {{
					n = G.UIT.C,
					config = {
						align = 'bm',
						padding = 0.02
					},
					nodes = CirnoMod.miscItems.restructureNodesTableIntoRowsOrColumns(nodes_, nodeKeys, 'R', { align = 'cm' })
				}}
			end,
			
			blueprint_compat = true,
			loc_vars = function(self, info_queue, center)
				-- Art credit tooltip
				if CirnoMod.config['artCredits'] then
					info_queue[#info_queue + 1] = { key = "jA_DaemonTsun_BigNTFEdit", set = "Other" }
				end
				
				return { vars = {
						center.ability.extra.extra,
						center.ability.extra.xChips,
						center.ability.extra.xMult
					},
					main_end = self.create_main_end(center)
				}
			end,
			unlocked = false,
			
			atlas = 'cir_cLegendaries',
			pos = { x = 2, y = 0}, -- Defines base card graphic position in the atlas.
			soul_pos = { x = 2, y = 1}, -- Defines where this card's soul overlay is in the given atlas
			rarity = 4, -- Legendary rarity
			cost = 20, -- Sell value, since Legendary Jokers only appear via Soul spectral cards.
			eternal_compat = true,
			perishable_compat = true,
			
			--[[ Causes crashes. No-one knows why.
			!! DO NOT UNCOMMENT if the set_sprites() call below is with
			a : and not a .
			That just causes stack overflow
			set_sprites = function(self, card, front)
				-- If the soul pos is not what we want, set it to what we want it to be.
				if
					card.ability -- Required to prevent issues in Collections
					and card.children
					and card.pos
					and card.soul_pos
				then
					if -- If the soul_pos is not what I want it to be. I make it what I wnt it to be.
						card.soul_pos ~= card.ability.extra.chipsMultSoulSpritePos[card.ability.extra.desiredSpriteState]
					then
						card.soul_pos = card.ability.extra.chipsMultSoulSpritePos[card.ability.extra.desiredSpriteState]
					end
					
					print(tprint(card.children))
					
					-- Set the sprites.
					--	card.children.center:set_sprite_pos(card.pos)
					--	card.children.floating_sprite:set_sprite_pos(card.soul_pos)
				end
			end,]]
			
			updateState = function(jkr)
				if
					jkr.ability
					and jkr.children
				then					
					if
						G.GAME.current_round
						and G.GAME.current_round.hands_played
						and G.GAME.current_round.hands_played > 0
					then
						local whatStateShouldBe = false
						
						if
							CirnoMod.miscItems.isState(G.STATE, G.STATES.SHOP)
							or CirnoMod.miscItems.isState(G.STATE, G.STATES.ROUND_EVAL)
							or CirnoMod.miscItems.isState(G.STATE, 999)
							or CirnoMod.miscItems.isState(G.STATE, G.STATES.BLIND_SELECT)
							or CirnoMod.miscItems.isState(G.STATE, G.STATES.TAROT_PACK)
							or CirnoMod.miscItems.isState(G.STATE, G.STATES.SPECTRAL_PACK)
							or CirnoMod.miscItems.isState(G.STATE, G.STATES.STANDARD_PACK)
							or CirnoMod.miscItems.isState(G.STATE, G.STATES.BUFFOON_PACK)
							or CirnoMod.miscItems.isState(G.STATE, G.STATES.PLANET_PACK)
						then
							whatStateShouldBe = 'Normal'
						else
							if G.GAME.current_round.hands_played % 2 == 0 then
								whatStateShouldBe = 'Chips'
							else
								whatStateShouldBe = 'Mult'
							end
						end
						
						if
							whatStateShouldBe
							and jkr.ability.extra.active ~= whatStateShouldBe
						then
							if whatStateShouldBe == 'Normal' then
								jkr.ability.extra.active = 'Chips'
								jkr.config.center.change_multiplier(self, jkr, false, true)
							else
								jkr.config.center.change_multiplier(self, jkr, whatStateShouldBe, true)
							end
						end
					end
					
					if -- If the soul_pos is not what I want it to be. I make it what I wnt it to be.
						jkr.config.center.soul_pos ~= jkr.ability.extra.chipsMultSoulSpritePos[jkr.ability.extra.desiredSpriteState]
					then
						jkr.config.center.soul_pos = jkr.ability.extra.chipsMultSoulSpritePos[jkr.ability.extra.desiredSpriteState]
					end
					
					-- Set the sprites.
					jkr.children.center:set_sprite_pos(jkr.config.center.pos)
					jkr.children.floating_sprite:set_sprite_pos(jkr.config.center.soul_pos)
				end
			end,
			
			--[[ Handles flipping between XChips & XMult.
			when called, chipsMult will generally either be
			'Chips', 'Mult' or false.]]
			change_multiplier = function(self, card, chipsMult, silent)
				local toChangeTo = {
					msg = false, -- Default value is false, for later check
					msgColour = G.C.FILTER
				}
				
				--[[ We only parse this section if chipsMult is
				either 'Chips' or 'Mult'. Calling this function
				with chipsMult set to anything else will (ideally)
				revert it to the normal, neutral appearance.]]
				if
					chipsMult
					and card.ability.extra.chipsMultColour[chipsMult] -- Basically just determines if chipsMult is either 'Chips' or 'Mult'
				then
					if not silent then
						toChangeTo.msg = chipsMult
						toChangeTo.msgColour = card.ability.extra.chipsMultColour[chipsMult]
					end
					card.ability.extra.desiredSpriteState = chipsMult -- We want the sprite appearance to be either the 'Chips' or 'Mult' state.
					card.ability.extra.active = chipsMult -- Update the state (Since this function is changing the state.)
				else
					card.ability.extra.desiredSpriteState = 'Normal' -- Normal sprite appearance if neither chips nor mult
				end
				
				--[[ Sets the new soul_pos co-ords to what we want them to 
				be, based on the joker's internal desired state as determined above]]
				toChangeTo.newSoulPos = card.ability.extra.chipsMultSoulSpritePos[card.ability.extra.desiredSpriteState]
				
				-- This way, the SMODS.calculate_effect() is only called if messaqge in the table is set.
				if toChangeTo.msg then
					SMODS.calculate_effect( {
						message = toChangeTo.msg,
						colour = toChangeTo.msgColour
					}, card)
				end
				
				card.config.center.soul_pos = toChangeTo.newSoulPos
				card.children.floating_sprite:set_sprite_pos(card.config.center.soul_pos)
			end,
			
			calculate = function(self, card, context)
				local noMoreConditions = false
				
				if
					context.added_card
					and context.added_card.card == card
				then
					-- print("Sprite Fix Test")
					
					self.change_multiplier(self, card, false, true)
					
					noMoreConditions = true
				end
				
				if noMoreConditions == false then
					if
						context.setting_blind -- Are we starting a blind?
						and context.blueprint_card == nil -- Is this not being called from blueprint?
						and not context.retrigger_joker -- Is this not a retrigger?
						and not context.post_trigger -- Ensure this is not from another joker triggering
					then
						-- print("Blind Start Test")
						-- Sets card multiplier to X Chips and alters appearance accordingly.
						self.change_multiplier(self, card, 'Chips', false)
						
						noMoreConditions = true
					elseif
						context.discard
						and context.blueprint_card == nil
					then
						-- print("Discard Test")
						-- Decrease decrement counter for every discarded card
						card.ability.extra.discardDecrementCounter = card.ability.extra.discardDecrementCounter - 1
						
						if card.ability.extra.discardDecrementCounter <= 0 then
							-- If the counter is 0, we reroll a new value from 2 to 9 as our new counter
							local initialCounterAmount = pseudorandom('arumiaDiscards', 2, 9)
							card.ability.extra.discardDecrementCounter = initialCounterAmount
							-- print("Decrement Counter: "..card.ability.extra.discardDecrementCounter) -- For testing
							
							-- print('X '..card.ability.extra.chipsMultOpposite[card.ability.extra.active]..", "..card.ability.extra['x'..card.ability.extra.chipsMultOpposite[card.ability.extra.active]]..' -> '..card.ability.extra['x'..card.ability.extra.chipsMultOpposite[card.ability.extra.active]] + card.ability.extra.extra)
							
							-- Whichever multiplier is INACTIVE (for chips, mult and mult, chips), we increase that by our extra value.
							card.ability.extra['x'..card.ability.extra.chipsMultOpposite[card.ability.extra.active]] = card.ability.extra['x'..card.ability.extra.chipsMultOpposite[card.ability.extra.active]] + card.ability.extra.extra
							
							card.ability.extra.extra = initialCounterAmount / 10
							
							-- And we state that it has gone up.
							SMODS.calculate_effect( {
									message = 'X'..card.ability.extra['x'..card.ability.extra.chipsMultOpposite[card.ability.extra.active]],
									colour = card.ability.extra.chipsMultColour[card.ability.extra.chipsMultOpposite[card.ability.extra.active]]
								}, card)
							
							return {
								message = "Reroll!",
								colour = G.C.GREEN
							}, true
						else
							-- Otherwise, we say the new current decrement counter.
							return {
								message = tostring(card.ability.extra.discardDecrementCounter),
								colour = card.ability.extra.chipsMultColour[card.ability.extra.chipsMultOpposite[card.ability.extra.active]]
							}, true
						end
					end
				end
				
				if noMoreConditions == false then
					if
						context.cardarea == G.jokers
					then
						local RT = false
						local shouldReturnMessage = false
											
						if
							context.end_of_round
							and context.blueprint_card == nil
						then
							-- print("Round End Test")
							
							if card.ability.extra.handWasPlayed then
								card.ability.extra.handWasPlayed = false
							end
							
							self.change_multiplier(self, card, false)
						elseif
							context.joker_main
							and not context.post_trigger
						then
							-- print("Normal Scoring Timing Test")
							RT = {}
							
							if
								card.ability.extra.handWasPlayed == false
								and not context.retrigger_joker
							then
								card.ability.extra.handWasPlayed = true
							end
							
							local localiseKey = ''
							
							if card.ability.extra.active == 'Chips' then
								RT.x_chips = card.ability.extra.xChips
								--localiseKey = 'a_xchips'
								shouldReturnMessage = RT.x_chips > 1
							elseif card.ability.extra.active == 'Mult' then
								RT.x_mult = card.ability.extra.xMult
								--localiseKey = 'a_xmult'
								shouldReturnMessage = RT.x_mult > 1
							end
							
							if shouldReturnMessage then
								
								--[[RT.message = localize(
								{
									type = "variable",
									key = localiseKey,
									vars = { card.ability.extra['x'..card.ability.extra.active] }
								})]]
								
								RT.colour = card.ability.extra.chipsMultColour[card.ability.extra.active]
							end							
						end
						
						if
							card.ability.extra.handWasPlayed
							and context.hand_drawn
							and not context.retrigger_joker
							and not context.post_trigger
						then
							-- print("Before Next Hand Test")
							
							G.E_MANAGER:add_event(Event({
								trigger = 'after',
								delay = 0.5,
								blockable = true,
								blocking = false,
								func = function()
										self.change_multiplier(self, card, card.ability.extra.chipsMultOpposite[card.ability.extra.active], false)
									return true
								end}))
							
							card.ability.extra.handWasPlayed = false
						end
						
						if RT then
							return RT, true
						end
					end
				end
			end
		},
		-- Houdini Legendary
		{
			-- How the Joker will be referred to internally.
			key = 'houdini_l',
			
			object_type = "Joker",
			
			matureRefLevel = 1,
			
			loc_txt = {
				-- The name the player will see in-game.
				name = "Houdini111",
				-- The description the player will see in-game.
				text = {
					"Every played {C:attention}card",
					"{C:attention}permanently{} gains {C:mult}+1{} Mult per",
					"{C:attention}enhancement{} and/or {C:dark_edition}edition{}",
					"when scored",
					"{s:0.8,C:inactive}\"Like a sight of what's to be,",
					"{s:0.8,C:inactive}but harsher and lacking a most",
					"{s:0.8,C:inactive}central piece. Don't let that",
					"{s:0.8,C:inactive}stop you, ascend and have",
					"{s:0.8,C:inactive}some fun becoming #1#1.\""
				},
				unlock = {
					"Find this {C:joker}Joker",
					"from the {C:spectral}Soul{} card"
				}
			},
			
			config = {
				extra = {
					extra = 1
				}
			},
			
			blueprint_compat = true,
			loc_vars = function(self, info_queue, center)
				-- Art credit tooltip
				if CirnoMod.config['artCredits'] then
					info_queue[#info_queue + 1] = { key = "jA_DaemonTsun_BigNTFEdit", set = "Other" }
				end
				
				return { vars = { "#", center.ability.extra.extra } }
			end,
			unlocked = false,
			
			atlas = 'cir_cLegendaries',
			pos = { x = 1, y = 3}, -- Defines base card graphic position in the atlas.
			soul_pos = { x = 0, y = 4}, -- Defines where this card's soul overlay is in the given atlas
			rarity = 4, -- Legendary rarity
			cost = 20, -- Sell value, since Legendary Jokers only appear via Soul spectral cards.
			eternal_compat = true,
			perishable_compat = true,
			
			calculate = function(self, card, context)
				if
					context.individual
					and context.cardarea == G.play
					and context.other_card
					and not context.other_card.debuff
				then
					local permMultToAdd = 0
										
					if next(SMODS.get_enhancements(context.other_card)) then
						permMultToAdd = 1
					end
					
					if context.other_card.seal then
						permMultToAdd = permMultToAdd + 1
					end
					
					if context.other_card.edition then
						permMultToAdd = permMultToAdd + 1
					end
					
					if permMultToAdd > 0 then
						context.other_card.ability.perma_mult = context.other_card.ability.perma_mult or 0
						context.other_card.ability.perma_mult = context.other_card.ability.perma_mult + permMultToAdd
						
						return {
							extra = {
								message = localize('k_upgrade_ex'),
								colour = G.C.RED
							},
							card = card
						}
					end
				end
			end
		}
	}
}

return jokerInfo