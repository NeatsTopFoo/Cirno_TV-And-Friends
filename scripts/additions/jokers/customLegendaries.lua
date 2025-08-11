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
lua file.]]

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
			
			matureRefLevel = 1,
			cir_Friend = CirnoMod.miscItems.cirFriends.cir,
			
			loc_txt = {
				-- The name the player will see in-game.
				name = 'Cirno',
				-- The description the player will see in-game.
				text = {
					"This {C:joker}Joker{} gains {X:chips,C:white}X#1#{} Chips",
					"for each scored {C:attention}9{}",
					"{s:0.8,C:red}If {s:0.8,C:attention}#2#{s:0.8,C:red} is present, it",
					"{s:0.8,C:red}expires after the first trigger.",
					"{C:inactive}(Currently {X:chips,C:white}X#3# {C:inactive} Chips)",
					"{s:0.8,C:inactive}\"I don't mean to brag Chat,",
					"{s:0.8,C:inactive}but I'm stupid.\""
				}
			},
			
			config = { extra = { xchips = 1, growth = 0.09 } },
			
			--[[
			Purely aesthetic as blueprint functionality, even though
			Steamodded says you need to use loc_vars, blueprint/brainstorm
			actually calls calculate(). ...Yeah. It's weird.]]
			blueprint_compat = true,
			
			create_main_end = function()
				local mainEndRV = {
					n = G.UIT.C,
					config = {
						align = 'bm',
						padding = 0.02
					},
					nodes = {}
				}
				
				CirnoMod.miscItems.addUISpriteNode(mainEndRV.nodes, Sprite(
						0, 0, -- Sprite X & Y
						0.8, 0.8, -- Sprite W & H
						CirnoMod.miscItems.funnyAtlases.emotes, -- Sprite Atlas
						{ x = 3, y = 1 } -- Position in the Atlas
					)
				)
				
				return { mainEndRV }
			end,
			
			--[[
			Figured out what this is - This largely defines some of the 
			stuff that shows up in the tooltip (and more. So for example,
			if you hover over a card that mentions Stone cards and it tells
			you what Stone cards are, that's this. It's not because it
			just says 'Stone card' in the description.]]
			loc_vars = function(self, info_queue, card)				
				-- Ice Cream :)
				info_queue[#info_queue + 1] = CirnoMod.miscItems.obscureJokerTooltipIfNotEncountered('j_ice_cream')
				
				-- Art credit tooltip
				if
					CirnoMod.config.artCredits
					and (not CirnoMod.config.malverkReplacements
					or not CirnoMod.miscItems.hasEncounteredJoker('j_ice_cream')) -- Ice Cream  already has a duplicate credit in its queue
				then
					info_queue[#info_queue + 1] = { key = "jA_DaemonTsun", set = 'Other' }
				end
				
				-- Defines #1#, #2# & #3#
				return { vars = {
					to_big(card.ability.extra.growth), 
					CirnoMod.miscItems.obscureJokerNameIfNotEncountered('j_ice_cream'), 
					to_big(card.ability.extra.xchips)
					},
					main_end = self.create_main_end() }
				end,
			
			pos = { x = 0, y = 0}, -- Defines base card graphic position in the atlas.
			soul_pos = { x = 0, y = 1}, -- Defines where this card's soul overlay is in the given atlas
			cost = 20, -- Sell value, since Legendary Jokers only appear via Soul spectral cards.
			
			dropIceCream = function(iceCream)
				G.E_MANAGER:add_event(Event({
					trigger = 'immediate',
					blocking = false,
					blockable = true,
					func = function()
						iceCream:start_dissolve({
							G.C.GREEN,
							CirnoMod.miscItems.colours.cirLucy,
							G.C.GREEN,
							CirnoMod.miscItems.colours.cirLucy,
							G.C.GREEN
						}, true)
						return true
					end}))
			end,
			
			-- What actually happens when the joker needs to do something.
			calculate = function(self, card, context)				
				-- Normal joker calculation.
				if context.joker_main then
					return {
						x_chips = to_big(card.ability.extra.xchips),
						colour = CirnoMod.miscItems.colours.cirCyan,
						card = card
					}
				end
				
				-- Looks for scored 9s and increases the stored mult
				-- on the card accordingly.				
				if
					context.individual
					and context.cardarea == G.play
					and not context.post_trigger
				then
					if
						context.other_card:can_calculate()
						and context.other_card.base.value == "9"
					then
						card.ability.extra.xchips = to_big(card.ability.extra.xchips) + to_big(card.ability.extra.growth)
						
						return {
							extra = { 
								message = localize {
									type = 'variable',
									key = 'a_xchips',
									vars = { to_big(card.ability.extra.xchips) }
								},
								colour = CirnoMod.miscItems.colours.cirCyan,
								message_card = card
							}
						}
					end
				end
				
				if
					not context.blueprint -- So, blueprint and brainstorm call calculate(). Yeah.
					and context.post_trigger
					and not context.retrigger_joker
					and context.other_context.joker_main
					and context.other_card
					and context.other_card.config.center.key == 'j_ice_cream'
				then
					return {
						message_card = context.other_card,
						message = "Dropped!",
						colour = G.C.RED,
						sound = 'cir_j_matchaDrop',
						pitch = 1.0,
						func = self.dropIceCream(context.other_card)
					}
				end
			end
		},
		-- Naro Legendary.
		{
			-- How the Joker will be referred to internally.
			key = 'naro_l',
			
			matureRefLevel = 1,
			cir_Friend = CirnoMod.miscItems.cirFriends.nrp,
			
			loc_txt = {
				-- The name the player will see in-game.
				name = "Naro",
				-- The description the player will see in-game.
				text = {
					"This {C:joker}Joker{} gains {X:mult,C:white} X#1# ",
					"Mult for every {C:cirNep}#2#",
					"used this run",
					"{C:inactive}(Currently {X:mult,C:white} X#3# {C:inactive} Mult)",
					"{s:0.8,C:inactive}He is the missile.",
					"{s:0.8,C:inactive}He knows where he is."
				}
			},
			
			config = { extra = {
				extra = 1,
				soulX = 1
			} },
			
			blueprint_compat = true,
			loc_vars = function(self, info_queue, card)
				local RT = { vars = {
					to_big(card.ability.extra.extra),
					G.localization.descriptions.Planet.c_neptune.name,
					1
				} }
				
				-- Adds a description of Neptune to tooltip by appending
				-- to info_queue
				info_queue[#info_queue + 1] = { key = 'c_neptune', set = 'Planet', config = { hand_type = 'Straight Flush' } }
				
				-- Art credit tooltip
				if CirnoMod.config['artCredits'] and not card.fake_card then
					info_queue[#info_queue + 1] = { key = "jA_DaemonTsun_BigNTFEdit", set = "Other" }
				end
				
				if
					G.GAME
					and G.GAME.consumeable_usage
					and G.GAME.consumeable_usage['c_neptune']
					and G.GAME.consumeable_usage['c_neptune'].count
				then
					RT.vars[3] = (to_big(G.GAME.consumeable_usage['c_neptune'].count) * to_big(card.ability.extra.extra)) + to_big(1)
				end
				
				return RT
			end,
			
			pos = { x = 0, y = 2}, -- Defines base card graphic position in the atlas.
			soul_pos = { x = 1, y = 3}, -- Defines where this card's soul overlay is in the given atlas
			cost = 20, -- Sell value, since Legendary Jokers only appear via Soul spectral cards.
			eternal_compat = true,
			perishable_compat = true,
			
			updateState = function(jkr)
				if
					jkr.ability
					and jkr.children
				then
					if -- If the soul_pos is not what I want it to be. I make it what I wnt it to be.
						jkr.config.center.soul_pos.x ~= jkr.ability.extra.soulX
					then
						jkr.config.center.soul_pos.x = jkr.ability.extra.soulX
					end
				end
				
				-- Set the sprites.
				jkr.children.center:set_sprite_pos(jkr.config.center.pos)
				jkr.children.floating_sprite:set_sprite_pos(jkr.config.center.soul_pos)
			end,
			
			change_soul_pos = function(card, newSoulPos)
				card.config.center.soul_pos = newSoulPos
				card:set_sprites(card.config.center)
			end,
			
			set_badges = function(self, card, badges)
				if CirnoMod.miscItems.isUnlockedAndDisc(card) then
					CirnoMod.miscItems.addBadgesToJokerByKey(badges, 'j_cir_naro_l')
				end
			end,
			
			calculate = function(self, card, context)				
				if
					context.cardarea == G.jokers -- If we are iterating through owned jokers
					and	context.joker_main -- If the context is during the main scoring timing of jokers
					and G.GAME.consumeable_usage -- And global consumeable usage exists
					and G.GAME.consumeable_usage.c_neptune -- And at least one neptune has been used.
					and mult ~= nil -- And global mult is not nil
					and not context.before -- Context before is things that happen in the scoring loop, but before anything is scored
					and not context.after -- Context after is things that modify the score after all cards are scored
				then
					return { -- Multiply the current mult by mult accrued on card?
						x_mult = (G.GAME.consumeable_usage_total and (to_big(G.GAME.consumeable_usage.c_neptune.count) * to_big(card.ability.extra.extra)) + to_big(1) or 1) -- Multiplies the current mult by the desired amount
					}, true
				elseif
					not context.blueprint
					and context.consumeable
					and G.GAME.consumeable_usage
					and not context.retrigger_joker -- Is this not a retrigger?
				then
					if
						context.consumeable.ability.name == "Neptune"
					then
						return { -- Multiply the current mult by mult accrued on card?
							extra = {
								message = localize(
								{
									type = "variable",
									key = "a_xmult",
									vars = {
											(G.GAME.consumeable_usage_total and (to_big(G.GAME.consumeable_usage.c_neptune.count) * to_big(card.ability.extra.extra)) + to_big(1) or 1)
										}
								}),
								colour = CirnoMod.miscItems.colours.cirNep,
								message_card = card
							}
						}, true
					end
				elseif
					context.end_of_round
					and context.main_eval
					and not context.blueprint
					and not context.game_over
				then
					local newX = pseudorandom('naroSpriteChange', 0, 1)
					
					if card.ability.extra.soulX ~= newX then
						card.ability.extra.soulX = newX
						
						card:juice_up()
						self.change_soul_pos(card, { x = card.ability.extra.soulX, y = 3 })
					end
				end
			end
		},
		-- Arumia Legendary
		{
			-- How the Joker will be referred to internally.
			key = 'arumia_l',
			
			matureRefLevel = 1,
			cir_Friend = CirnoMod.miscItems.cirFriends.rmi,
			
			loc_txt = {
				-- The name the player will see in-game.
				name = "ArumiaTheSleepy",
				-- The description the player will see in-game.
				text = { {
						'{C:attention}Swaps{} between {X:chips,C:white}XChips{} & {X:mult,C:white}XMult',
						'after each {C:blue}hand{} played',
						'{C:inactive}(Currently: {B:1,C:white}X#1#{C:inactive})'
					}, {
						'After {C:green}2-9{} cards {C:red}discarded{}',
						'{C:inactive}({C:attention}#2#{C:inactive} remaining)',
						'unchosen {C:mult}mu{C:chips}lt{C:mult}ip{C:chips}li{C:mult}er{} gains {C:attention}X#3#{},',
						'then {C:green}choose{} a new discard requirement',
						'{C:inactive}(Currently {X:chips,C:white}X#4#{C:inactive} Chips, {X:mult,C:white}X#5#{C:inactive} Mult)'
					},
					{ '{s:0.8,C:inactive}...So, you fall asleep reading this yet?' }
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
			
			set_badges = function(self, card, badges)
				if CirnoMod.miscItems.isUnlockedAndDisc(card) then
					CirnoMod.miscItems.addBadgesToJokerByKey(badges, 'j_cir_arumia_l')
				end
			end,
			
			--[[ Stay out of Balatro UI code if you value your sanity.
			Fun fact about sanity: Did you know it's possible to keep
			losing your sanity with increasing depth? It isn't just one
			and then it stops. I'm on like 15 layers of lost sanity.]]
			generate_ui = function(self, info_queue, card, desc_nodes, specific_vars, full_UI_table)
				SMODS.Center.generate_ui(self, info_queue, card, desc_nodes, specific_vars, full_UI_table)
				
				full_UI_table.multi_box[2][2] = {}
				
				CirnoMod.miscItems.addUISpriteNode(full_UI_table.multi_box[2][2], AnimatedSprite(
						0, 0, -- Sprite X & Y
						0.8, 0.8, -- Sprite W & H
						CirnoMod.miscItems.funnyAtlases.rumiSleep, -- Sprite Atlas
						{ x = 0, y = 0 } -- Position in the Atlas
					)
				)
			end,
			
			blueprint_compat = true,
			loc_vars = function(self, info_queue, card)
				-- Art credit tooltip
				if CirnoMod.config['artCredits'] and not card.fake_card then
					info_queue[#info_queue + 1] = { key = "jA_DaemonTsun_BigNTFEdit", set = "Other" }
				end
				
				return { vars = {
					to_big(card.ability.extra.active),
					to_big(card.ability.extra.discardDecrementCounter),
					to_big(card.ability.extra.extra),
					to_big(card.ability.extra.xChips),
					to_big(card.ability.extra.xMult),
					colours = { card.ability.extra.chipsMultColour[card.ability.extra.active] }
				} }
			end,
			
			pos = { x = 2, y = 0}, -- Defines base card graphic position in the atlas.
			soul_pos = { x = 2, y = 1}, -- Defines where this card's soul overlay is in the given atlas
			cost = 20, -- Sell value, since Legendary Jokers only appear via Soul spectral cards.
			eternal_compat = true,
			perishable_compat = true,
			
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
						colour = toChangeTo.msgColour,
						card = card
					}, card)
				end
				
				card.config.center.soul_pos = toChangeTo.newSoulPos
				card.children.floating_sprite:set_sprite_pos(card.config.center.soul_pos)
			end,
			
			calculate = function(self, card, context)
				local noMoreConditions = false
				
				if
					context.setting_blind -- Are we starting a blind?
					and not context.blueprint -- Is this not being called from blueprint?
					and not context.retrigger_joker -- Is this not a retrigger?
					and not context.post_trigger -- Ensure this is not from another joker triggering
				then
					-- print("Blind Start Test")
					-- Sets card multiplier to X Chips and alters appearance accordingly.
					self.change_multiplier(self, card, 'Chips', false)
					
					noMoreConditions = true
				elseif
					context.discard
					and not context.blueprint
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
						card.ability.extra['x'..card.ability.extra.chipsMultOpposite[card.ability.extra.active]] = to_big(card.ability.extra['x'..card.ability.extra.chipsMultOpposite[card.ability.extra.active]]) + to_big(card.ability.extra.extra)
						
						card.ability.extra.extra = initialCounterAmount / 10
						
						-- And we state that it has gone up.
						return {
							extra = {
								message = "Change!",
								colour = G.C.GREEN,
								card = card
							},
							message = 'X'..to_big(card.ability.extra['x'..card.ability.extra.chipsMultOpposite[card.ability.extra.active]]),
							colour = card.ability.extra.chipsMultColour[card.ability.extra.chipsMultOpposite[card.ability.extra.active]],
							card = card
						}, true
					else
						-- Otherwise, we say the new current decrement counter.
						return {
							message = tostring(card.ability.extra.discardDecrementCounter),
							colour = card.ability.extra.chipsMultColour[card.ability.extra.chipsMultOpposite[card.ability.extra.active]],
							card = card
						}, true
					end
				end
				
				if
					noMoreConditions == false
					and context.cardarea == G.jokers
				then
					local RT = false
					local shouldReturnMessage = false
										
					if
						context.end_of_round
						and not context.blueprint
						and not context.game_over
					then
						-- print("Round End Test")
						
						if card.ability.extra.handWasPlayed then
							card.ability.extra.handWasPlayed = false
						end
						
						self.change_multiplier(self, card, false)
					elseif context.joker_main then
						-- print("Normal Scoring Timing Test")
						RT = { card = card }
						
						if
							card.ability.extra.handWasPlayed == false
							and not context.retrigger_joker
						then
							card.ability.extra.handWasPlayed = true
						end
						
						local localiseKey = ''
						
						if card.ability.extra.active == 'Chips' then
							RT.x_chips = to_big(card.ability.extra.xChips)
							shouldReturnMessage = RT.x_chips > to_big(1)
						elseif card.ability.extra.active == 'Mult' then
							RT.x_mult = to_big(card.ability.extra.xMult)
							shouldReturnMessage = RT.x_mult > to_big(1)
						end
						
						if shouldReturnMessage then
							RT.colour = card.ability.extra.chipsMultColour[card.ability.extra.active]
						end
					end
					
					if
						card.ability.extra.handWasPlayed
						and context.hand_drawn
						and not context.retrigger_joker
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
		},
		-- Houdini Legendary
		{
			-- How the Joker will be referred to internally.
			key = 'houdini_l',
			
			matureRefLevel = 1,
			cir_Friend = CirnoMod.miscItems.cirFriends.hou,
			
			loc_txt = {
				-- The name the player will see in-game.
				name = "Houdini111",
				-- The description the player will see in-game.
				text = {
					"Every played {C:attention}card",
					"{C:attention}permanently{} gains {C:mult}+#1#{} Mult per",
					"{C:attention}enhancement{}, {C:dark_edition}edition{} and/or",
					"{C:attention}seal{} when scored",
					"{s:0.8,C:inactive}\"Like a sight of what's to be,",
					"{s:0.8,C:inactive}but harsher and lacking a most",
					"{s:0.8,C:inactive}central piece. Don't let that",
					"{s:0.8,C:inactive}stop you, ascend and have",
					"{s:0.8,C:inactive}some fun becoming #2#.\""
				}
			},
			
			config = {
				extra = {
					extra = 1
				}
			},
			
			blueprint_compat = true,
			loc_vars = function(self, info_queue, card)
				-- Art credit tooltip
				if CirnoMod.config['artCredits'] and not card.fake_card then
					info_queue[#info_queue + 1] = { key = "jA_DaemonTsun_BigNTFEdit", set = "Other" }
				end
				
				return { vars = { card.ability.extra.extra, '#1' } }
			end,
			
			pos = { x = 3, y = 0}, -- Defines base card graphic position in the atlas.
			soul_pos = { x = 3, y = 1}, -- Defines where this card's soul overlay is in the given atlas
			cost = 20, -- Sell value, since Legendary Jokers only appear via Soul spectral cards.
			eternal_compat = true,
			perishable_compat = true,
			
			calculate = function(self, card, context)
				if
					context.individual
					and (context.cardarea == G.play
					or context.cardarea == 'unscored')
					and context.other_card
					and context.other_card:can_calculate()
				then
					-- Work out how much mult to add
					local permMultToAdd = 0
					
					--[[ Is there an enhancement? If so, set amount
					(Since this is the first in sequence)]]
					if next(SMODS.get_enhancements(context.other_card)) then
						permMultToAdd = card.ability.extra.extra
					end
					
					-- Is there a seal? If so, add amount.
					if context.other_card.seal then
						permMultToAdd = permMultToAdd + card.ability.extra.extra
					end
					
					-- Is there an edition? If so, add amount.
					if context.other_card.edition then
						permMultToAdd = permMultToAdd + card.ability.extra.extra
					end
					
					-- If we're adding any mult, do so
					if permMultToAdd > 0 then
						context.other_card.ability.perma_mult = to_big(context.other_card.ability.perma_mult) or 0
						context.other_card.ability.perma_mult = to_big(context.other_card.ability.perma_mult) + to_big(permMultToAdd)
						
						-- Return table (in extra to prevent the colour being overridden by Blueprint/Brainstorm)
						return {
							extra = {
								message = localize('k_upgrade_ex'),
								colour = G.C.RED,
								message_card = context.other_card
							}
						}
					end
				end
			end
		},
		-- Wolsk Legendary
		{
			-- How the Joker will be referred to internally.
			key = 'wolsk_l',
			
			matureRefLevel = 1,
			cir_Friend = CirnoMod.miscItems.cirFriends.wls,
			
			loc_txt = {
				-- The name the player will see in-game.
				name = "Wolsk",
				-- The description the player will see in-game.
				text = {
					"Every played {C:attention}card",
					"in the first {C:blue}hand{} of the round",
					"{C:attention}permanently{} gains {X:mult,C:white}X#1#{} Mult"
				}
			},
			
			config = {
				extra = {
					extra = 0.1
				}
			},
			
			create_main_end = function()
				return {{
					n = G.UIT.C,
					config = {
						align = 'bm',
						padding = 0.02
					},
					nodes = {{
						n = G.UIT.R,
						config = { align = 'cm' },
						nodes = { CirnoMod.miscItems.addUISpriteNode(nil, AnimatedSprite(
								0, 0, -- Sprite X & Y
								1.575, 0.8, -- Sprite W & H
								CirnoMod.miscItems.funnyAtlases.hareHareYukai, -- Sprite Atlas
								{ x = 0, y = 0 } -- Position in the Atlas
							)) }
					}}
				}}
			end,
			
			blueprint_compat = true,
			loc_vars = function(self, info_queue, card)
				-- Art credit tooltip
				if CirnoMod.config['artCredits'] and not card.fake_card then
					info_queue[#info_queue + 1] = { key = "jA_DaemonTsun_BigNTFEdit", set = "Other" }
				end
				
				return { vars = { to_big(card.ability.extra.extra) },
				main_end = self.create_main_end() }
			end,
			
			pos = { x = 3, y = 2}, -- Defines base card graphic position in the atlas.
			soul_pos = { x = 3, y = 3}, -- Defines where this card's soul overlay is in the given atlas
			cost = 20, -- Sell value, since Legendary Jokers only appear via Soul spectral cards.
			eternal_compat = true,
			perishable_compat = true,
			
			updateState = function(jkr)
				if
					CirnoMod.miscItems.isState(G.STATE, G.STATES.SELECTING_HAND)
					and G.GAME.current_round.hands_played == 0
				then
					juice_card_until(jkr, function()
						return G.GAME.current_round.hands_played == 0
							and not G.RESET_JIGGLES
					end, true)
				end
			end,
			
			calculate = function(self, card, context)
				if
					not context.blueprint
					and context.first_hand_drawn
					and not (context.retrigger_joker
					or context.retrigger_joker_check)
				then					
					juice_card_until(card, function()
						return G.GAME.current_round.hands_played == 0
							and not G.RESET_JIGGLES
					end, true)
					
					return { doNotRedSeal = true,
						no_retrigger = true,
						message = localize('k_active_ex') }
				elseif
					G.GAME.current_round.hands_played < 1
					and context.individual
					and (context.cardarea == G.play
					or context.cardarea == 'unscored')
					and context.other_card
				then
					context.other_card.ability.perma_x_mult = to_big(context.other_card.ability.perma_x_mult) or 0
					context.other_card.ability.perma_x_mult = to_big(context.other_card.ability.perma_x_mult) + to_big(card.ability.extra.extra)
					
					-- Return table (in extra to prevent the colour being overridden by Blueprint/Brainstorm)
					return {
						extra = {
							message = localize('k_upgrade_ex'),
							colour = G.C.RED,
							message_card = context.other_card
						}
					}
				end
			end
		},
		-- Demeorin Legendary
		{
			-- How the Joker will be referred to internally.
			key = 'demeorin_l',
			
			matureRefLevel = 1,
			cir_Friend = CirnoMod.miscItems.cirFriends.dme,
			
			loc_txt = {
				-- The name the player will see in-game.
				name = "Demeorin",
				-- The description the player will see in-game.
				text = {
					'After defeating a {C:attention}Boss Blind{},',
					'create a {C:dark_edition}Negative {C:spectral}Spectral{} card',
					'{s:0.8,C:inactive}"Nya"'
				}
			},
			
			blueprint_compat = true,
			loc_vars = function(self, info_queue, card)
				info_queue[#info_queue + 1] = { key = 'e_negative_consumable', set = 'Edition', config = { extra = 1 } }
				
				-- Art credit tooltip
				if CirnoMod.config['artCredits'] and not card.fake_card then
					info_queue[#info_queue + 1] = { key = "jA_DaemonTsun_BigNTFEdit", set = "Other" }
				end
				
				return nil
			end,
			
			pos = { x = 1, y = 4}, -- Defines base card graphic position in the atlas.
			soul_pos = { x = 1, y = 5}, -- Defines where this card's soul overlay is in the given atlas
			cost = 20, -- Sell value, since Legendary Jokers only appear via Soul spectral cards.
			eternal_compat = true,
			perishable_compat = true,
			
			calculate = function(self, card, context)
				if
					context.end_of_round
					and context.main_eval
					and context.beat_boss
					and not context.game_over
				then
					return { func = function()
							card:juice_up()
							play_sound('generic1')
							SMODS.add_card({ set = 'Spectral', edition = 'e_negative' })
						end }
				end
			end
		},
		-- Tom Legendary.
		{
			key = 'tom_l',
			
			matureRefLevel = 1,
			cir_Friend = CirnoMod.miscItems.cirFriends.tom,
			
			loc_txt = {
				name = "Tom",
				text = {
					"After {C:attention}2{} rounds, create {C:attention}2",
					"{C:dark_edition}Negative{C:spectral} #1#{} cards",
					"{s:0.8}One-time action",
					"{C:inactive}(Currently {C:attention}#2#{C:inactive}/2)",
					"{s:0.8,C:inactive}Remember kids, when you fail",
					"{s:0.8,C:inactive}to kill your assassination",
					"{s:0.8,C:inactive}target, open the bible."
				}
			},
			
			config = { extra = { noPerf = { scalar = 1 }, rCounter = 0 } },
			
			blueprint_compat = false,
			loc_vars = function(self, info_queue, card)
				local ret = { vars = {} }
				
				if CirnoMod.config.addCustomConsumables then
					info_queue[#info_queue + 1] = { key = 'e_negative_consumable', set = 'Edition', config = { extra = 1 } }
					
					if CirnoMod.miscItems.obscurePerfectionismNameUnlessDiscovered then
						ret.vars[1] = CirnoMod.miscItems.obscurePerfectionismNameUnlessDiscovered()
					else
						if CirnoMod.miscItems.isUnlockedAndDisc(G.P_CENTERS.c_cir_sPerfectionism_l) then
							info_queue[#info_queue + 1] = G.P_CENTERS.c_cir_sPerfectionism_l
							ret.vars[1] = 'Perfectionism'
						else
							info_queue[#info_queue + 1] = { key = 'questionMarkTooltip', set = 'Other' }
							ret.vars[1] = '?????'
						end
					end
					
					ret.vars[2] = card.ability.extra.rCounter
				else
					ret.key = 'j_cir_tom_l_noPerfectionism'
					
					info_queue[#info_queue + 1] = CirnoMod.miscItems.getEditionScalingInfo({ type = 'example' }, card.ability.extra.noPerf.scalar )
					
					ret.vars[1] = card.ability.extra.noPerf.scalar
				end
				
				if CirnoMod.config['artCredits'] and not card.fake_card then
					info_queue[#info_queue + 1] = { key = "jA_NTF", set = "Other" }
				end
				
				return ret
			end,
			
			pos = { x = 0, y = 4},
			soul_pos = { x = 0, y = 5},
			cost = 20, -- Sell value, since Legendary Jokers only appear via Soul spectral cards.
			eternal_compat = false,
			perishable_compat = false,
			
			calculate = function(self, card, context)
				if
					context.end_of_round
					and context.main_eval
					and not context.blueprint
					and not context.game_over
				then
					if CirnoMod.config.addCustomConsumables then
						if card.ability.extra.rCounter < 2 then
							card.ability.extra.rCounter = card.ability.extra.rCounter + 1
							
							if card.ability.extra.rCounter == 2 then
								return { func = function()
										card:juice_up()
										play_sound('generic1')
										SMODS.add_card({ key = 'c_cir_sPerfectionism_l', edition = 'e_negative' })
										SMODS.add_card({ key = 'c_cir_sPerfectionism_l', edition = 'e_negative' })
									end }
							else
								return { message = card.ability.extra.rCounter..'/2' }
							end
						end
					else
						if context.beat_boss then
							local cardRef = card
							
							for i, jkr in ipairs (G.jokers.cards) do
								if
									jkr.edition
									and CirnoMod.miscItems.pullEditionModifierValue(jkr.edition) ~= nil
								then
									SMODS.calculate_effect({
											message = CirnoMod.miscItems.scaleEdition_FHP(jkr, cardRef.ability.extra.noPerf.scalar),
											message_card = jkr
										}, cardRef)
								end
							end
						end
					end
				end
			end
		},
		-- Nope Legendary.
		{
			-- How the Joker will be referred to internally.
			key = 'nope_l',
			
			matureRefLevel = 1,
			cir_Friend = CirnoMod.miscItems.cirFriends.ntf,
			
			loc_txt = {
				-- The name the player will see in-game.
				name = "NopeTooFast",
				-- The description the player will see in-game.
				text = {
					'This {C:joker}Joker{} gains',
					'{X:mult,C:white} X#1# {} Mult when failing',
					'a {C:attention}#2#',
					'{C:inactive}(Currently {X:mult,C:white} X#3# {C:inactive} Mult)',
					'{s:0.8,C:inactive}Well, it IS my wheel...'
				}
			},
			
			--[[
			'Growth' is how much the joker will gain on wheel failure.
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
			config = { extra = { growth = 1, x_mult = 1 } }, 
			
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
				-- Adds a description of Wheel of Fortune to tooltip by appending
				-- to info_queue
				info_queue[#info_queue + 1] = copy_table(G.P_CENTERS.c_wheel_of_fortune)
				info_queue[#info_queue].fake_card = true
				
				-- Art credit tooltip
				if CirnoMod.config['artCredits'] and not card.fake_card then
					info_queue[#info_queue + 1] = { key = "jA_DaemonTsun_BigNTFEdit", set = "Other" }
				end
				
				-- Here is how #1#, #2# & #3# are defined.
				return { vars = {
					to_big(card.ability.extra.growth),
					G.localization.descriptions.Tarot.c_wheel_of_fortune.name,
					to_big(card.ability.extra.x_mult)
				} }
			end,
			
			pos = { x = 1, y = 0}, -- Defines base card graphic position in the atlas.
			soul_pos = { x = 1, y = 1}, -- Defines where this card's soul overlay is in the given atlas
			cost = 20, -- Sell value, since Legendary Jokers only appear via Soul spectral cards.
			eternal_compat = true,
			perishable_compat = true,
			
			change_soul_pos = function(card, newSoulPos)
				card.config.center.soul_pos = newSoulPos
				card:set_sprites(card.config.center)
			end,
			
			set_badges = function(self, card, badges)
				if CirnoMod.miscItems.isUnlockedAndDisc(card) then
					CirnoMod.miscItems.addBadgesToJokerByKey(badges, 'j_cir_nope_l')
				end
			end,
			
			-- Define what the card does
			calculate = function(self, card, context)
				-- This section seems to define the standard joker function? Which would be multiplying the mult by the stored around
				if
					context.joker_main -- If the context is during the main scoring timing of jokers
					and (card.ability.extra.x_mult > 1) -- And the card's mult is more than 1
				then
					return { -- Multiply the current mult by mult accrued on card?
						x_mult = to_big(card.ability.extra.x_mult) -- Multiplies the current mult by the card's stored mult
					}, true
				end
				
				if
					not context.blueprint -- Don't do this if blueprint
					and context.pseudorandom_result -- Check for pseudorandom proc
					and not context.result -- Check for failure
					and context.trigger_obj -- nil check
					and context.trigger_obj.ability -- nil check
					and context.trigger_obj.ability.name == "The Wheel of Fortune"
				then
					--[[
					Add the xmult to grow by as defined in
					config extra.growth above, to the card's
					stored xmult in config.extra.x_mult]]
					card.ability.extra.x_mult = to_big(card.ability.extra.x_mult) + to_big(card.ability.extra.growth)
					
					-- Animate wink
					G.E_MANAGER:add_event(Event({
						trigger = 'immediate',
						delay = 0.01,
						blocking = false,
						func = function()
							self.change_soul_pos(card, { x = 1, y = 2 })
							
							G.E_MANAGER:add_event(Event({
								trigger = 'after',
								delay = 0.3,
								blocking = false,
								func = function()
									self.change_soul_pos(card, { x = 1, y = 1 })
									return true
								end}))
							return true
						end}))
					
					return { -- Pop message with the new xmult total
						message = localize({
							type = "variable",
							key = "a_xmult",
							vars = { to_big(card.ability.extra.x_mult) } }),
						colour = G.C.PURPLE,
						message_card = card
					}, true
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
	jkr.atlas = 'cir_cLegendaries'
	jkr.rarity = 4
	jkr.loadOrder = 'lgnd'
	
	jkr.unlocked = false
	jkr.loc_txt.unlock = {
		"Find this {C:joker}Joker",
		"from the {E:1,C:spectral}Soul{} card"
	}
end

return jokerInfo