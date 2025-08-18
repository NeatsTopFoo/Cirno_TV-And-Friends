local jokerInfo = {
	isMultipleJokers = true,
	
	-- Defines the Atlas
	atlasInfo = {
		key = 'cir_cRares',
		path = "Additional/cir_custRares.png",
		px = 71,
		py = 95
	},
	
	--[[ TODO:
		- Fixer; X1 Mult for every unique face card
		- Ornstein & Smough Joker pair that respectively become Super Ornstein & Super Smough when the other of the two is destroyed (not sold)
		- Redacted '██████' Joker whose effects are not clear, highly unpredictable and inconsistent, heavily RNG-based but also extremely confusing (Note, Mario the Idea vs. Mario the Man)
		- Mac n' Cheese Joker; Every 2 Boss Blinds, if there's room, creates a Ketchup (Seltzer). Gains x0.1 mult every time a ketchup runs out.
		- Bloodborne on PC Joker: Dithering between the effect of "Sell this Joker during a blind to draw 2x hand size to card", "In X rounds, sell this Joker to multiply your number of discards by 1.5" & "Sell this Joker during a blind to discard all held cards and draw a new hand (If deck is empty, refresh deck)."
		- "Help! I'm Trapped In The Joker Factory" will have some different effects that get selected randomly on joker creation, all related to blinds, one off the top of my head is "This Joker gives +5 mult during The Memory (the boss blind) & also gains X0.05 mult whenever Cirno forgets something" and then it just randomly gains X0.05 mult based on random, unpredictable criteria.
		- "Fuckin' Catgirl Sex Fuckin Footjob Dick Suckin' Simulator" No idea what this could do.
		- Endless Eight Joker
		- Sonic '06 Joker
		- Emotional Support Broken Man Joker
		- Money laundry?
		- Air fryer?
	]]
	jokerConfigs = {
		-- Crystal Tap
		{
			-- How the Joker will be referred to internally.
			key = 'crystalTap',
						
			matureRefLevel = 1,
			
			loc_txt = {
				name = "Crystal Tap",
				text = { '' }
			},
			
			pos = { x = 7, y = 1}, -- Defines base card graphic position in the atlas.
			soul_pos = { x = 9, y = 1}, -- Defines where this card's soul overlay is in the given atlas
			cost = 8, -- Base sell value is half of cost
			eternal_compat = true,
			perishable_compat = true,
			
			config = {
				extra = {
					mult = 15,
					xmult = 2.5,
					spriteX = 7,
					pHand = '[HAND]',
					preventEndOfRoundChange = false
				}
			},
			
			--[[
			How do I do this one '-'
			joker_display_def = function(JokerDisplay)
				---@type JDJokerDefinition
				return {
					mod_function = function(card, mod_joker)
						if card.ability.extra.spriteX == 7 then
							return { mult = card.ability.extra.mult }
						else
							return { x_mult = card.ability.extra.xmult }
						end
					end
				}
			end,
			]]
			
			updateState = function(jkr)
				if
					jkr.ability
					and jkr.children
				then
					if -- If the soul_pos is not what I want it to be. I make it what I wnt it to be.
						jkr.config.center.pos.x ~= jkr.ability.extra.spriteX
					then
						jkr.config.center.pos.x = jkr.ability.extra.spriteX
					end
				end
				
				-- Set the sprites.
				jkr.children.center:set_sprite_pos(jkr.config.center.pos)
				jkr.children.floating_sprite:set_sprite_pos(jkr.config.center.soul_pos)
			end,
			
			pickRandHand = function(card, silent)
				if
					G.GAME
					and G.GAME.hands
				then
					local poker_hands = {}
					for k, h in pairs (G.GAME.hands) do
						if
							h.visible
							and k ~= card.ability.extra.pHand
						then
							poker_hands[#poker_hands + 1] = k
						end
					end
					
					local oldH = card.ability.extra.pHand
					card.ability.extra.pHand = nil
					
					while not card.ability.extra.pHand do
						card.ability.extra.pHand = pseudorandom_element(poker_hands, pseudoseed('crysTap_Hand'))
						
						if card.ability.extra.pHand == oldH then card.ability.extra.pHand = nil end
					end
					
					if not silent then
						SMODS.calculate_effect({ message = "Change Hand!", colour = G.C.FILTER }, card)
					end
					return true
				end
				return false
			end,
			
			switchWaterState = function(card, silent)
				if card.ability.extra.spriteX == 7 then
					card.ability.extra.spriteX = 8
				elseif card.ability.extra.spriteX == 8 then
					card.ability.extra.spriteX = 7
				end
				
				card.ability.extra.preventEndOfRoundChange = true
				
				card.config.center.pos.x = card.ability.extra.spriteX
				card:set_sprites(card.config.center)
				
				if not silent then
					local rMessage = ''
					
					if card.ability.extra.spriteX == 7 then
						rMessage = 'Lower!'
					elseif card.ability.extra.spriteX == 8 then
						rMessage = 'Raise!'
					end
					
					SMODS.calculate_effect({ message = rMessage, colour = G.C.BLUE }, card)
				end
			end,
			
			makeRaiseLower = function(center)
				if center.ability.extra.spriteX == 7 then
					return 'raises'
				elseif center.ability.extra.spriteX == 8 then
					return 'lowers'
				end
			end,
			
			create_main_end = function(self, card)
				local nodes_ = {
					Ln1 = {},
					Ln2 = {},
					Ln3 = {},
					Ln4 = {},
					Ln5 = {},
					Ln6 = {},
					Ln7 = {},
					Ln8 = {}
				}
				
				local nodeKeys = {
					'Ln1',
					'Ln2',
					'Ln3',
					'Ln4',
					'Ln5',
					'Ln6',
					'Ln7',
					'Ln8'
				}
				
				if card.ability.extra.spriteX == 7 then
					CirnoMod.miscItems.addUITextNode(
						nodes_.Ln1,
						'+'..card.ability.extra.mult,
						G.C.MULT,
						1)
				elseif card.ability.extra.spriteX == 8 then
					CirnoMod.miscItems.addUITextNode(
						CirnoMod.miscItems.addUIColumnOrRowNode(
							nodes_.Ln1,
							'm',
							'C',
							G.C.MULT,
							0,
							0.025).nodes,
						'X'..card.ability.extra.xmult,
						G.C.UI.TEXT_LIGHT,
						1)
				end
				
				CirnoMod.miscItems.addUITextNode(nodes_.Ln1, ' Mult,', G.C.UI.TEXT_DARK, 1)
				
				CirnoMod.miscItems.addUITextNode(nodes_.Ln2, 'If played ', G.C.UI.TEXT_DARK, 1)
				CirnoMod.miscItems.addUITextNode(nodes_.Ln2, 'poker hand', G.C.FILTER, 1)
				
				CirnoMod.miscItems.addUITextNode(nodes_.Ln3, 'contains a ', G.C.UI.TEXT_DARK, 1)
				CirnoMod.miscItems.addUITextNode(nodes_.Ln3, localize(card.ability.extra.pHand, 'poker_hands') or card.ability.extra.pHand, G.C.FILTER, 1)
				CirnoMod.miscItems.addUITextNode(nodes_.Ln3, ',', G.C.UI.TEXT_DARK, 1)
				
				CirnoMod.miscItems.addUITextNode(nodes_.Ln4, self.makeRaiseLower(card), G.C.FILTER, 1)
				CirnoMod.miscItems.addUITextNode(nodes_.Ln4, ' the water level', G.C.UI.TEXT_DARK, 1)
				
				CirnoMod.miscItems.addUITextNode(nodes_.Ln5, '(Poker hand changes either', G.C.UI.TEXT_DARK, 0.8)
				CirnoMod.miscItems.addUITextNode(nodes_.Ln6, 'every round', G.C.FILTER, 0.8)
				CirnoMod.miscItems.addUITextNode(nodes_.Ln6, ' or ', G.C.UI.TEXT_DARK, 0.8)
				CirnoMod.miscItems.addUITextNode(nodes_.Ln6, 'on trigger', G.C.FILTER, 0.8)
				CirnoMod.miscItems.addUITextNode(nodes_.Ln6, ')', G.C.UI.TEXT_DARK, 0.8)
				
				CirnoMod.miscItems.addUITextNode(nodes_.Ln7, 'Spiders dropping on your head', G.C.UI.TEXT_INACTIVE, 0.8)
				
				CirnoMod.miscItems.addUITextNode(nodes_.Ln8, 'not included.', G.C.UI.TEXT_INACTIVE, 0.8)
				
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
			loc_vars = function(self, info_queue, card)
				-- Art credit tooltip
				if CirnoMod.config['artCredits'] and not card.fake_card then
					info_queue[#info_queue + 1] = { key = "jA_CrysTap", set = "Other" }
				end
				
				if
					card.ability.extra.pHand == '[HAND]'
					and self.pickRandHand(card, true) == false
				then
					card.ability.extra.pHand = 'Flush'
				end
				
				return { vars = {
						to_big(card.ability.extra.mult),
						to_big(card.ability.extra.xmult)
					},
					main_end = self.create_main_end(self, card)
				}
			end,
			
			cir_upgradeInfo = function(self, card)
				return {
					'{C:mult}+'..to_big(card.ability.extra.mult)..'{} Mult,',
					'{X:mult,C:white}X'..to_big(card.ability.extra.xmult)..'{} Mult',
					'->',
					'{C:mult}+'..to_big(card.ability.extra.mult) + to_big(15)..'{} Mult,',
					'{X:mult,C:white}X'..to_big(card.ability.extra.xmult) + to_big(1)..'{} Mult'
				}
			end,
			
			cir_upgrade = function(self, card)
				card.ability.extra.mult = to_big(card.ability.extra.mult) + to_big(15)
				card.ability.extra.xmult = to_big(card.ability.extra.xmult) + to_big(1)
				
				return { message = localize('k_upgrade_ex'), colour = G.C.MULT }
			end,
			
			calculate = function(self, card, context)
				if
					context.cardarea == G.jokers
					and not context.blueprint
					and (not context.setting_blind
					and card.ability.extra.pHand ~= '[HAND]')
					and not context.using_consumeable
					and not context.retrigger_joker
				then
					if
						context.before
						and card.ability.extra.pHand ~= '[HAND]'
						and next(context.poker_hands[card.ability.extra.pHand])
					then
						self.switchWaterState(card)
						self.pickRandHand(card, true)
					elseif
						(context.end_of_round
						and card.ability.extra.preventEndOfRoundChange == false
						and not context.game_over)
						or (context.card_added
						and context.card == card)
						or (context.setting_blind
						and card.ability.extra.pHand == '[HAND]')
					then
						self.pickRandHand(card, context.card_added)
					elseif
						(context.end_of_round
						and card.ability.extra.preventEndOfRoundChange)
					then
						card.ability.extra.preventEndOfRoundChange = false
					end
				end
				
				if
					context.cardarea == G.jokers
					and context.joker_main
				then
					RV = {}
					
					if card.ability.extra.spriteX == 7 then
						RV.mult = to_big(card.ability.extra.mult)
					elseif card.ability.extra.spriteX == 8 then
						RV.x_mult = to_big(card.ability.extra.xmult)
					end
					
					RV.colour = G.C.MULT
					
					return RV
				end
			end
		},
		-- Crazy Face
		{
			key = 'crazyFace',
						
			matureRefLevel = 1,
			
			loc_txt = {
				name = "Crazy Face",
				text = {
					"{X:mult,C:white}X#1#{} Mult",
					"{C:green}#2# in #3#{} chance to",
					"{C:red}destroy{C:attention} played cards{},",
					"per card.",
					"{s:0.8,C:inactive}\"...You can't fix her.\"",
					"{s:0.8,C:inactive}...What are you talking about?"
				},
				unlock = {
					"Encounter {C:attention}#1#{}'s",
					"reskin"
				}
			},
			unlocked = false,
			
			pos = { x = 6, y = 1 },
			cost = 8,
			eternal_compat = true,
			perishable_compat = true,
			
			config = {
				extra = {
					xmult = 4,
					odds = 7
				}
			},
			
			--[[
			joker_display_def = function(JokerDisplay)
				---@type JDJokerDefinition
				return {
					text = {
						{ border_nodes = {
							{ ref_table = 'card.ability.extra', ref_value = 'xmult' }
						} },
						{ text = "Destroy:", color = G.C.RED, scale = 0.45 }
					},
					extra = { {
						ref_table = "card.joker_display_values", ref_value = "odds"
					} },
					extra_config { color = G.C.GREEN, scale = 0.45 },
					calc_function = function(card)
						if not card.joker_display_values then
							card.joker_display_values = {}
						end
						
						card.joker_display_values.odds = localize { type = 'variable', key = "jdis_odds", vars = { (G.GAME and G.GAME.probabilities.normal or 1), card.ability.extra.odds } }
					end
				}
			end,
			]]
			
			create_main_end = function(self, card)
				local nodes_ = {
					Ln1 = {},
					Ln2 = {},
					Ln3 = {}
				}
				
				local nodeKeys = {
					'Ln1',
					'Ln2',
					'Ln3'
				}
				
				CirnoMod.miscItems.addUISpriteNode(nodes_.Ln1, Sprite(
						0, 0, -- Sprite X & Y
						0.8, 0.8, -- Sprite W & H
						CirnoMod.miscItems.funnyAtlases.emotes, -- Sprite Atlas
						{ x = 3, y = 0 } -- Position in the Atlas
					)
				)
				
				CirnoMod.miscItems.addUITextNode(nodes_.Ln2, "I don't want to fix her.", G.C.UI.TEXT_INACTIVE, 0.8)
				
				CirnoMod.miscItems.addUITextNode(nodes_.Ln3, "I want to make her worse.", G.C.UI.TEXT_INACTIVE, 0.8)
				
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
			loc_vars = function(self, info_queue, card)
				-- Art credit tooltip
				if CirnoMod.config['artCredits'] and not card.fake_card then
					info_queue[#info_queue + 1] = { key = "jA_NTF", set = "Other" }
				end
				
				local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds)
				
				return { vars = {
						to_big(card.ability.extra.xmult),
						numerator,
						denominator
					},
					main_end = self.create_main_end(self, card)
				}
			end,
			
			locked_loc_vars = function(self, info_queue, card)
				return { vars = {
					CirnoMod.miscItems.obscureStringIfJokerKeyLockedOrUndisc('Scary Face', 'j_scary_face')
				}}
			end,
			
			set_badges = function(self, card, badges)
				if CirnoMod.miscItems.isUnlockedAndDisc(card) then
					CirnoMod.miscItems.addBadgesToJokerByKey(badges, 'j_cir_crazyFace')
				end
			end,
			
			calculate = function(self, card, context)
				-- Normal Joker xMult.
				if
					context.cardarea == G.jokers
					and context.joker_main
				then
					return {
						x_mult = to_big(card.ability.extra.xmult),
						colour = G.C.MULT
					}
				end
				
				-- Card destroy chance processing
				if
					not context.blueprint
					and (context.cardarea == G.play
					or context.cardarea == 'unscored')
					--[[ Looks at the entire hand, including unscored cards.
					I would like this to include debuffed cards at some point,
					but there appears to be no reasonable way to include them
					in sequence]]
				then
					if
						context.individual
						and context.other_card
						and context.other_card:can_calculate(true)
					then
						local RT = { message_card = context.other_card }
						
						-- Decide if card should be destroyed
						if SMODS.pseudorandom_probability(context.other_card, 'mitaKill', 1, card.ability.extra.odds) then
							
							context.other_card.getting_sliced = true -- Marks the card for destruction.
							-- If the card is being destroyed, we don't need to retrigger this card
							RT.doNotRedSeal = true
							RT.no_retrigger = true
							RT.message = '  '
							RT.colour = G.C.RED
							RT.func = function()
								local cardRef = context.other_card
								
								G.E_MANAGER:add_event(Event({
									trigger = 'immediate',
									blocking = false,
									blockable = true,
									func = function()
										cardRef.stab = true -- Purely for the visual effect on the Drawstep.
										return true
									end}))
							end
							RT.sound = 'slice1'
						else -- Branch for if the card is not to be destroyed.
							RT.message = localize('k_safe_ex')
							RT.colour = G.C.GREEN
						end
						
						return RT
					end
					
					-- Destroy marked cards
					if context.destroy_card and context.destroy_card.getting_sliced then
						return { remove = true }
					end
				end
			end,
			
			check_for_unlock = function(self, args)
				return CirnoMod.miscItems.hasEncounteredJoker('j_scary_face')
			end
		},
		-- We Only Have 3 Jokes?
		{
			key = 'onlyHaveThreeJokes',
						
			matureRefLevel = 1,
			cir_Friend = CirnoMod.miscItems.cirFriends.cir,
			
			loc_txt = {
				name = "We Only Have 3 Jokes?",
				text = {
					"{X:mult,C:white}X#1#{} Mult for every {C:attention}Joker{}",
					"whose graphic or reskin is",
					"related to {C:attention}#2#{},",
					"{C:attention}2 max{} or {C:attention}cirGuns{}",
					"{C:inactive}(Currently {X:mult,C:white}X#3#{C:inactive} Mult)",
					"{s:0.8,C:inactive}#2#, 2 max, cirGuns.",
					"{s:0.8,C:inactive}#2#, 2 max, cirGuns.",
					"{s:0.8,C:inactive}#2#, 2 max, cirGuns.",
					"{s:0.8,C:inactive}THIS COMMUNITY ONLY HAS THREE JOKES?!",
					"{s:0.5,C:inactive}Chat gets a little bully too, as a treat."
				},
				unlock = {
					"Encounter at least one Joker reskin per",
					"skin that is {E:1,C:attention}#1#{}, {E:1,C:attention}#2#{} or",
					"{E:1,C:attention}#3#{} related."
				}
			},
			unlocked = false,
			
			pos = { x = 0, y = 2 },
			cost = 8,
			eternal_compat = true,
			perishable_compat = true,
			
			joker_display_def = function(JokerDisplay)
				---@type JDJokerDefinition
				return {
					text = {
						{ border_nodes = {
							{ text = 'X' },
							{ ref_table = 'card.ability.extra', ref_value = 'xmult' }
						} }
					}
				}
			end,
			
			config = {
				extra = {
					xmult = 1,
					growth = 2.3,
					checkEm = {
						allegations = true,
						TwoMax = true,
						fingerGuns = true
					}
				}
			},
			
			shouldAdd = function()
				return CirnoMod.config.malverkReplacements
			end,
			
			updateCurMult = function(extraTable)
				if not CirnoMod.miscItems.isState(G.STAGE, G.STAGES.MAIN_MENU) then
					local counter = 0
					
					for i, jkr in ipairs(G.jokers.cards) do
						if jkr.config.center.key ~= 'j_cir_onlyHaveThreeJokes' then
							local jkrKeyGroup = CirnoMod.miscItems.keyGroupOfJokerKey(jkr.config.center.key)
							
							if jkrKeyGroup and extraTable.checkEm[jkrKeyGroup] then
								counter = counter + 1
							end
						end
					end
					
					if counter > 0 then
						extraTable.xmult = to_big(counter) * to_big(extraTable.growth)
					else
						extraTable.xmult = to_big(1)
					end
				end
			end,
			
			blueprint_compat = true,
			loc_vars = function(self, info_queue, card)
				self.updateCurMult(card.ability.extra)
				
				info_queue[#info_queue + 1] = CirnoMod.miscItems.descExtensionTooltips['eDT_cir_allegations']
				
				info_queue[#info_queue + 1] = CirnoMod.miscItems.descExtensionTooltips['eDT_cir_2max']
				
				info_queue[#info_queue + 1] = CirnoMod.miscItems.descExtensionTooltips['eDT_cir_Guns']
				
				-- Art credit tooltip
				if CirnoMod.config['artCredits'] and not card.fake_card then
					info_queue[#info_queue + 1] = { key = 'jA_NTF', set = 'Other' }
				end
				
				return { vars = { 
					to_big(card.ability.extra.growth),
					CirnoMod.miscItems.getJokerNameByKey('j_bootstraps', '{C:red}Not Active{}'),
					to_big(card.ability.extra.xmult)
					} }
			end,
			
			locked_loc_vars = function(self, info_queue, cneter)
				return {
					vars = {
					CirnoMod.miscItems.obscureStringIfNoneInJokerKeyGroupEncountered(CirnoMod.miscItems.getJokerNameByKey('j_bootstraps', '{C:red}Not Active{}'), 'allegations'),
					CirnoMod.miscItems.obscureStringIfNoneInJokerKeyGroupEncountered('2 max', 'TwoMax'),
					CirnoMod.miscItems.obscureStringIfNoneInJokerKeyGroupEncountered('cirGuns', 'fingerGuns')
				}}
			end,
			
			cir_upgradeInfo = function(self, card)
				return {
					'{X:mult,C:white}X'..to_big(card.ability.extra.growth)..'{} Mult scaling',
					'->',
					'{X:mult,C:white}X'..to_big(card.ability.extra.growth) + to_big(0.5)..'{} Mult scaling'
				}
			end,
			
			cir_upgrade = function(self, card)
				card.ability.extra.growth = to_big(card.ability.extra.growth) + to_big(0.5)
				
				return { message = localize('k_upgrade_ex'), colour = G.C.MULT }
			end,
			
			calculate = function(self, card, context)				
				-- Mult updating
				if
					not context.blueprint
					and not context.retrigger_joker
					and (context.setting_blind
					or context.buying_card
					or context.selling_card
					or context.ending_shop
					or context.joker_main)
				then
					if context.joker_main then
						self.updateCurMult(card.ability.extra)
					else
						G.E_MANAGER:add_event(Event({
						trigger = 'after',
						delay = 0.1,
						blocking = false,
						blockable = true,
						func = function()
							self.updateCurMult(card.ability.extra)
						end}))
					end
				end
				
				-- Normal Joker xMult.
				if
					context.cardarea == G.jokers
					and context.joker_main
				then
					return {
						x_mult = to_big(card.ability.extra.xmult),
						colour = G.C.RED
					}
				end
			end,
			
			check_for_unlock = function(self, args)
				return (CirnoMod.miscItems.jkrKeyGroupTotalEncounters('allegations', true) > 0
					and CirnoMod.miscItems.jkrKeyGroupTotalEncounters('TwoMax', true) > 0
					and CirnoMod.miscItems.jkrKeyGroupTotalEncounters('fingerGuns', true) > 0)
			end
		},
		-- Rubber Room
		{
			key = 'rubberRoom',
						
			matureRefLevel = 1,
			
			loc_txt = {
				name = "Rubber Room",
				text = {
					"{X:mult,C:white}X#1#{} Mult for every {C:attention}Joker{}",
					"whose graphic or reskin either",
					"is or is otherwise related",
					"to being {C:attention}unhinged{}.",
					"{C:inactive}(Currently {X:mult,C:white}X#2#{C:inactive} Mult)",
					"{s:0.8,C:inactive}I was gonna reference the pasta,",
					"{s:0.8,C:inactive}but I'm more intrigued in the fact",
					"{s:0.8,C:inactive}that no-one seems to agree whether",
					"{s:0.8,C:inactive}or not 'rubber rats' is part of it."
				},
				unlock = {
					"Encounter at least",
					"three Jokers that",
					"either are or are",
					"references to #1#{E:1,C:attention}#2#"
				}
			},
			unlocked = false,
			
			pos = { x = 1, y = 2 },
			cost = 8,
			eternal_compat = true,
			perishable_compat = true,
			
			joker_display_def = function(JokerDisplay)
				---@type JDJokerDefinition
				return {
					text = {
						{ border_nodes = {
							{ text = 'X' },
							{ ref_table = 'card.ability.extra', ref_value = 'xmult' }
						} }
					}
				}
			end,
			
			config = {
				extra = {
					xmult = 1,
					growth = 1.75
				}
			},
			
			shouldAdd = function()
				return CirnoMod.config.malverkReplacements
			end,
			
			updateCurMult = function(extraTable)
				if not CirnoMod.miscItems.isState(G.STAGE, G.STAGES.MAIN_MENU) then
					local prevMult = to_big(extraTable.xmult)
					local counter = 0
					
					for i, jkr in ipairs(G.jokers.cards) do
						if jkr.config.center.key ~= 'j_cir_rubberRoom' then
							local jkrKeyGroup = CirnoMod.miscItems.keyGroupOfJokerKey(jkr.config.center.key)
							
							if jkrKeyGroup and jkrKeyGroup == 'unhinged' then
								counter = counter + 1
							end
						end
					end
					
					if counter > 0 then
						extraTable.xmult = to_big(counter) * to_big(extraTable.growth)
						
						return extraTable.xmult > prevMult
					else
						extraTable.xmult = 1
					end
				end
				return false
			end,
			
			blueprint_compat = true,
			loc_vars = function(self, info_queue, card)
				self.updateCurMult(card.ability.extra)
				
				info_queue[#info_queue + 1] = CirnoMod.miscItems.descExtensionTooltips['eDT_cir_unhinged']
				
				--[Art credit tooltip
				if CirnoMod.config['artCredits'] and not card.fake_card then
					info_queue[#info_queue + 1] = { key = "jA_NTF", set = "Other" }
				end
				
				return { vars = { to_big(card.ability.extra.growth), to_big(card.ability.extra.xmult) } }
			end,
			
			locked_loc_vars = function(self, info_queue, card)
				if CirnoMod.miscItems.jkrKeyGroupTotalEncounters('unhinged', true) > 0 then
					return { vars = { 'being ', 'unhinged' } }
				end
				
				return { vars = { '', '?????' } }
			end,
			
			cir_upgradeInfo = function(self, card)
				return {
					'{X:mult,C:white}X'..to_big(card.ability.extra.growth)..'{} Mult scaling',
					'->',
					'{X:mult,C:white}X'..to_big(card.ability.extra.growth) + to_big(0.25)..'{} Mult scaling'
				}
			end,
			
			cir_upgrade = function(self, card)
				card.ability.extra.growth = to_big(card.ability.extra.growth) + to_big(0.25)
				
				return { message = localize('k_upgrade_ex'), colour = G.C.MULT }
			end,
			
			calculate = function(self, card, context)				
				-- Mult updating
				if
					not context.blueprint
					and not context.retrigger_joker
					and (context.setting_blind
					or context.buying_card
					or context.selling_card
					or context.ending_shop
					or context.joker_main)
				then
					if context.joker_main then
						self.updateCurMult(card.ability.extra)
					else
						G.E_MANAGER:add_event(Event({
						trigger = 'after',
						delay = 0.1,
						blocking = false,
						blockable = true,
						func = function()
							if self.updateCurMult(card.ability.extra) then
								SMODS.calculate_effect({ message = 'Into The Room.' }, card)
							end
						end}))
					end
				end
				
				-- Normal Joker xMult.
				if
					context.cardarea == G.jokers
					and context.joker_main
				then
					return {
						x_mult = to_big(card.ability.extra.xmult),
						colour = G.C.RED
					}
				end
			end,
			
			check_for_unlock = function(self, args)
				return CirnoMod.miscItems.jkrKeyGroupTotalEncounters('unhinged', true) > 3
			end
		},
		-- B3313
		{
			key = 'b3313',
			
			matureRefLevel = 1,
			cir_Friend = CirnoMod.miscItems.cirFriends.cir,
			
			loc_txt = CirnoMod.miscItems.createErrorLocTxt('B3313'),
			
			pos = { x = 0, y = 0 },
			cost = 17,
			eternal_compat = true,
			perishable_compat = true,
			
			config = { extra = {
				currentForm = 'base',
				scoredHandName = nil,
				formsList = { 'base', 'betaLob', 'plexalLob', 'toadLob', 'vanLob', 'uncanny', '4thFloor', 'crescent', 'forestMaze', 'loogi', 'peachCell', 'nebLob', 'floor3B' },
				handToForm = {
					['High Card'] = 'betaLob',
					['Pair'] = 'plexalLob',
					['Two Pair'] = 'toadLob',
					['Three of a Kind'] = 'vanLob',
					['Straight'] = 'uncanny',
					['Flush'] = '4thFloor',
					['Full House'] = 'crescent',
					['Four of a Kind'] = 'forestMaze',
					['Straight Flush'] = 'loogi',
					['Five of a Kind'] = 'peachCell',
					['Flush House'] = 'nebLob',
					['Flush Five'] = 'floor3B'
				},
				formsInfo = {
					['base'] = { atlasX = 0 },
					['betaLob'] = {
						atlasX = 1,
						threeThreeOneThree = false,
						pitch = 1,
						xmult = 3.313,
						funcName = 'calc_highCard'
					},
					['plexalLob'] = {
						atlasX = 2,
						phcChips = 20,
						tpMult = 10,
						toakMult = 15,
						flush_xmult = 1.25,
						fh_xmult = 1.5,
						foak_xmult = 2,
						funcName = 'calc_pair'
					},
					['toadLob'] = {
						atlasX = 3,
						monGain = 1,
						funcName = 'calc_twoPair'
					},
					['vanLob'] = {
						atlasX = 4,
						scalar = 1,
						funcName = 'calc_threeKind'
					},
					['uncanny'] = {
						atlasX = 5,
						xmult = 1,
						rankTable = {
							"Ace",
							"10",
							"9",
							"8",
							"7",
							"6",
							"5",
							"4",
							"3",
							"2" },
						funcName = 'calc_straight'
					},
					['4thFloor'] = {
						atlasX = 6,
						rankChange = 1,
						funcName = 'calc_flush'
					},
					['crescent'] = {
						atlasX = 7,
						monGain = 1,
						accruedMoney = 0,
						funcName = 'calc_fullHouse'
					},
					['forestMaze'] = {
						atlasX = 8,
						xmult = 1.5,
						chance1 = 3,
						chance2 = 4,
						chance3 = 5,
						chance4 = 6,
						funcName = 'calc_fourKind'
					},
					['loogi'] = {
						atlasX = 9,
						storedHandSize = 8,
						negativeChance = 2,
						xchips = 2,
						funcName = 'calc_straightFlush'
					},
					['peachCell'] = {
						atlasX = 10,
						parsedKingsJacks = {},
						queenPolycule = {}, -- Tee hee.
						handContainedFaceCards = false,
						polyChance = 4,
						funcName = 'calc_fiveKind'
					},
					['nebLob'] = {
						atlasX = 11,
						funcName = 'calc_flushHouse'
					},
					['floor3B'] = {
						atlasX = 12,
						funcName = 'calc_flushFive'
					}
				}
			} },
			
			--[[
			HJGKNUEJKNHUGSEGKJSEDNKJSGEKJUIN
			joker_display_def = function(JokerDisplay)
				---@type JDJokerDefinition
				return {
					mod_function = function(card, mod_joker)
						
					end
				}
			end,
			]]
			
			updateState = function(jkr)
				if
					jkr.ability.extra.currentForm ~= 'base'
					and (CirnoMod.miscItems.isState(G.STATE, G.STATES.SHOP)
					or CirnoMod.miscItems.isState(G.STATE, G.STATES.BLIND_SELECT)
					or CirnoMod.miscItems.isState(G.STATE, 999)
					or CirnoMod.miscItems.isState(G.STATE, G.STATES.TAROT_PACK)
					or CirnoMod.miscItems.isState(G.STATE, G.STATES.PLANET_PACK)
					or CirnoMod.miscItems.isState(G.STATE, G.STATES.SPECTRAL_PACK)
					or CirnoMod.miscItems.isState(G.STATE, G.STATES.STANDARD_PARK)
					or CirnoMod.miscItems.isState(G.STATE, G.STATES.BUFFOON_PACK))
				then
					jkr.ability.extra.currentForm = 'base'
				end
				
				if jkr.ability and jkr.children then
					if -- If the soul_pos is not what I want it to be. I make it what I want it to be.
						jkr.config.center.pos.x ~= jkr.ability.extra.formsInfo[jkr.ability.extra.currentForm].atlasX
					then
						jkr.config.center.pos.x = jkr.ability.extra.formsInfo[jkr.ability.extra.currentForm].atlasX
					end
				end
				
				-- Set the sprites.
				jkr.children.center:set_sprite_pos(jkr.config.center.pos)
			end,
			
			-- Crying
			toAppendToInfoQueue = function(extraTable, curEdition)
				if extraTable.currentForm == 'vanLob' then
					if
						curEdition
						and curEdition.type ~= 'negative'
					then
						return { CirnoMod.miscItems.getEditionScalingInfo(curEdition, extraTable.formsInfo.vanLob.scalar) }
					end
				elseif extraTable.currentForm == 'loogi' then
					return { { key = 'e_negative_playing_card',
						set = 'Edition',
						config = { extra = 1 },
						vars = { 1,
							G.localization.descriptions.Joker.j_splash.name,
							string.sub(G.localization.descriptions.Enhanced.m_stone.name, 1, #G.localization.descriptions.Enhanced.m_stone.name - 5)
						} } }
				elseif extraTable.currentForm == 'peachCell' then
					if curEdition.type ~= 'polychrome' then
						return { G.P_CENTERS.e_polychrome }
					end
				elseif extraTable.currentForm == 'floor3B' then
					return { G.P_CENTERS.m_steel }
				end
				return nil
			end,
			
			create_vars_table = function(extraTable, card)
				--[[ This is why Lua is a fucking laughing stock.
				What the fuck do you mean 'Lua doesn't need a switch statement'?!?!?
				And no, I can't do a table lookup for this, because some of the
				things that need to be returned, like the probability, have to
				be up to date with the current game state - And
				A. those are not initialised at game startup, so it would error
				B. even if they were, having a variable copy it at that point
				would not update to reflect changes to it such as with oops all 6s
				Which would leave the possibility of storing a function that
				grabs it, HOWEVER this would mean trying to store a
				function in the config table. And a very fun thing
				about this game is that if you try to save the game
				and a card has a function in its config table, it
				doesn't seem to like it all that much.]]
				if extraTable.currentForm == 'plexalLob' then
					return {
						to_big(extraTable.formsInfo.plexalLob.phcChips),
						to_big(extraTable.formsInfo.plexalLob.tpMult),
						to_big(extraTable.formsInfo.plexalLob.toakMult),
						to_big(extraTable.formsInfo.plexalLob.flush_xmult),
						to_big(extraTable.formsInfo.plexalLob.fh_xmult),
						to_big(extraTable.formsInfo.plexalLob.foak_xmult)
					}
				elseif extraTable.currentForm == 'toadLob' then
					return { SMODS.signed_dollars(to_big(extraTable.formsInfo.toadLob.monGain)) }
				elseif extraTable.currentForm == '4thFloor' then
					return { extraTable.formsInfo['4thFloor'].rankChange }
				elseif extraTable.currentForm == 'crescent' then
					return { 
						SMODS.signed_dollars(to_big(extraTable.formsInfo.crescent.monGain)),
						extraTable.formsInfo.crescent.accruedMoney > 0 and SMODS.signed_dollars(to_big(extraTable.formsInfo.crescent.accruedMoney)) or '$0'
					}
				elseif extraTable.currentForm == 'forestMaze' then
					local curProbability, chance1 = SMODS.get_probability_vars(card or self, 1, extraTable.formsInfo.forestMaze.chance1)
					
					return {
						to_big(extraTable.formsInfo.forestMaze.xmult),
						curProbability,
						chance1,
						extraTable.formsInfo.forestMaze.chance2,
						extraTable.formsInfo.forestMaze.chance3,
						extraTable.formsInfo.forestMaze.chance4
					}
				elseif extraTable.currentForm == 'loogi' then
					local curProbability, negativeChance = SMODS.get_probability_vars(card or self, 1, extraTable.formsInfo.loogi.negativeChance)
					
					return {
						curProbability,
						negativeChance,
						to_big(extraTable.formsInfo.loogi.xchips)
					}
				elseif extraTable.currentForm == 'peachCell' then
					local curProbability, polyChance = SMODS.get_probability_vars(card or self, 1, extraTable.formsInfo.peachCell.polyChance)
					
					return {
						curProbability,
						polyChance
					}
				elseif extraTable.currentForm == 'floor3B' then
					return { G.localization.descriptions.Enhanced.m_steel.name }
				else
					return {}
				end
			end,
			
			blueprint_compat = true,
			loc_vars = function(self, info_queue, card)
				local RT = { key = 'cir_b3313_'..card.ability.extra.currentForm, vars = self.create_vars_table(card.ability.extra, card) }
								
				local infoQueueAppend = self.toAppendToInfoQueue(card.ability.extra, card.edition)
				
				if infoQueueAppend then
					for i, item in ipairs(infoQueueAppend) do
						info_queue[#info_queue + 1] = item
					end
				end
				
				-- Art credit tooltip
				if CirnoMod.config['artCredits'] and not card.fake_card then
					if card.ability.extra.currentForm == 'uncanny' then
						info_queue[#info_queue + 1] = { key = "jA_b3313_uncanny", set = "Other" }
					else
						info_queue[#info_queue + 1] = { key = "jA_b3313", set = "Other" }
					end
				end
				
				return RT
			end,
			
			shouldReturnToHand = function(self, card)
				--[[ Returns true if the card is in the correct form,
				And if the amount of cards played is 5, 3 or 1 ]]
				return (card.ability.extra.currentForm == '4thFloor'
					or (card.ability.extra.currentForm == 'base'
					and card.ability.extra.scoredHandName
					and card.ability.extra.scoredHandName == 'Flush'))
					and (#G.play.cards == 5
					or #G.play.cards == 3
					or #G.play.cards == 1)
			end,
			
			returnToHand_func = function(self, card, isLastIteration, old_dfptd)
				local ret = {}
				local play_count = #G.play.cards
				local cardToReturn = 1
				local finalCount = 0
				
				if play_count == 5 then
					cardToReturn = 3
				elseif play_count == 3 then
					cardToReturn = 2
				end
				
				for i = 1, play_count do
					-- Ensures we're not dealing with a destroyed card
					if
						not G.play.cards[i].beingRedrawn
						and not G.play.cards[i].shattered
						and not G.play.cards[i].destroyed
					then
						if i == cardToReturn then
							-- If it's the middle card, return it to hand.
							G.play.cards[i].beingRedrawn = true
							table.insert(ret, G.play.cards[i])
							draw_card(G.play, G.hand or G.discard, i*100/play_count, 'down', false, G.play.cards[i], 0.1, false, false)
						elseif isLastIteration then
							-- If it's any other card, discard as normal.
							draw_card(G.play, G.discard, i*100/play_count, 'down', false, G.play.cards[i])
						end
					end
				end
				
				return ret
			end,
			
			change_form = function(self, card, form)				
				CirnoMod.miscItems.flippyFlip.fStart(card)
				
				local formTarg = form
				local cardRef = card
				
				G.E_MANAGER:add_event(Event({
					trigger = 'after',
					delay = 0.1,
					blocking = true,
					blockable = true,
					func = function()
						cardRef.ability.extra.currentForm = formTarg
						cardRef.config.center.pos.x = cardRef.ability.extra.formsInfo[formTarg].atlasX
						cardRef.children.center:set_sprite_pos(cardRef.config.center.pos)
						cardRef:juice_up()
						play_sound('generic1')
						return true 
					end }))
				
				CirnoMod.miscItems.flippyFlip.fEnd(card)
			end,
			
			calc_dollar_bonus = function(self, card)
				if
					not (context.blueprint
					or context.retrigger_joker)
				then
					--[[ If calc_dollar_bonus is always called
					during end of round eval regardless of if
					there's a condition for its use, may as
					well use it for things that always need
					to happen, such as form reversion.]]
					
					self.change_form(self, card, 'base')
				end
				
				if to_big(card.ability.extra.formsInfo.crescent.accruedMoney) > 0 then
					local RV = to_big(card.ability.extra.formsInfo.crescent.accruedMoney)
					
					return RV
				end
			end,
			
			jkr_shouldSkipRedSeal = function(self, context, card)
				return CirnoMod.miscItems.isState(G.STATE, G.STATES.SELECTING_HAND)
					or context.other_context.first_hand_drawn
			end,
			
			calc_highCard = function(self, card, context, formTable)
				-- Looks to see if the played hand is 3, 3, Ace, 3
				if context.before and context.cardarea == G.jokers then
					formTable.threeThreeOneThree = (#G.play.cards == 4
						and G.play.cards[1].base.value == "3"
						and G.play.cards[2].base.value == "3"
						and G.play.cards[3].base.value == "Ace"
						and G.play.cards[4].base.value == "3")
				end
				
				--[[ Assigns the random enhancement to played 3s
				and Aces that are undebuffed & do not have one.]]
				if
					not context.blueprint
					and not context.retrigger_joker
					and not context.retrigger_joker_check
					and context.individual
					and context.cardarea == G.play
					and context.other_card:can_calculate()
					and (context.other_card.base.value == "3"
					or context.other_card.base.value == "Ace")
					and not next(SMODS.get_enhancements(context.other_card))
				then
					local formTable_ = formTable
					local cardRef = context.other_card
					local jkrRef = card
					
					-- This setup looks weird, but it's all to achieve a specific visual timing.
					CirnoMod.miscItems.flippyFlip.fStart(cardRef, formTable_.pitch)
					
					return { doNotRedSeal = true,
					func = function()
						-- Sets the random enhancement
						cardRef:set_ability(SMODS.poll_enhancement{ guaranteed = true }, nil, true)
						
						formTable_.pitch = 1
						
						G.E_MANAGER:add_event(Event({
							trigger = 'immediate',
							blocking = true,
							blockable = true,
							func = function()								
								formTable_.pitch = math.max(formTable_.pitch - 0.09, 0.3)
								jkrRef:juice_up();play_sound('generic1', formTable_.pitch)
								return true 
							end }))
						
						formTable_.pitch = 1
						
						CirnoMod.miscItems.flippyFlip.fEnd(cardRef, formTable_.pitch)
					end }
				end
				
				if context.joker_main and context.cardarea == G.jokers then
					--[[ Resets card flip sound pitch. I don't even know
					If this works properly.]]
					formTable.pitch = 1
					
					-- Gives the X3.313 mult if the hand is 3, 3, Ace, 3
					if formTable.threeThreeOneThree then
						if
							card.seal
							and card.seal == 'Red'
						then
							if context.retrigger_joker then
								formTable.threeThreeOneThree = false
							end
						else
							formTable.threeThreeOneThree = false
						end
						
						return { xmult = to_big(formTable.xmult) }
					end
				end
			end,
			
			calc_pair = function(self, card, context, formTable)
				if context.joker_main and context.cardarea == G.jokers then
					local RT = { extra = {}, mult = to_big(0) }
										
					if
						context.scoring_name == 'High Card'
						or context.scoring_name == 'Pair'
					then
						RT.chips = to_big(formTable.phcChips)
					end
					
					if next(context.poker_hands['Two Pair']) then
						RT.mult = to_big(formTable.tpMult)
					end
					
					if
						next(context.poker_hands['Three of a Kind'])
						or next(context.poker_hands['Straight'])
					then
						RT.mult = to_big(RT.mult) + to_big(formTable.toakMult)
					end
					
					if next(context.poker_hands['Flush']) then
						RT.xmult = to_big(formTable.flush_xmult)
					end
					
					if next(context.poker_hands['Full House']) then
						RT.extra.xmult = to_big(formTable.fh_xmult)
					elseif
						next(context.poker_hands['Four of a Kind'])
						or next(context.poker_hands['Straight Flush'])
					then
						RT.extra.xmult = to_big(formTable.foak_xmult)
					end
					
					return RT
				end
			end,
			
			calc_twoPair = function(self, card, context, formTable)
				if
					context.post_trigger
					and not (context.other_context.mod_probability
					or context.other_context.fix_probability)
				then
					-- Gives money when other Jokers are triggered
					return { dollars = to_big(formTable.monGain), message_card = context.blueprint_card or card }
				end
			end,
			
			calc_threeKind = function(self, card, context, formTable)
				if card.ability.extra.currentForm ~= 'base' then
					if
						context.before
						and context.cardarea == G.jokers
						and card.edition
						and card.edition.type ~= 'negative'
					then						
						-- Processes edition scaling				
						local cardRef = card
						
						return {
							message = CirnoMod.miscItems.scaleEdition_FHP(cardRef, formTable.scalar),
							colour = CirnoMod.miscItems.cardEditionTypeToColour(cardRef) or G.C.FILTER,
							sound = CirnoMod.miscItems.cardEditionTypeToSfx(cardRef) or 'generic1',
							volume = 0.5,
							message_card = card
						}
					end
					
					-- Inverse splash mechanics
					if
						context.modify_scoring_hand
						and context.main_eval
						and not (context.retrigger_joker
						or context.retrigger_joker_check)
						and not context.blueprint
					then
						-- Ensure we're only looking at undebuffed cards
						if context.other_card:can_calculate() then
							-- First checks always scores, to capture wild/stone cards.
							local cardScores = SMODS.always_scores(context.other_card)
							
							if not cardScores then
								-- If it's not an always scoring card, see if it's in the hand.
								for i, c in pairs(context.scoring_hand) do
									if c == context.other_card then
										cardScores = true
										break
									end
								end
							end
							
							--[[ Makes the card be removed from or
							added to the scoring hand appropriately.
							Bless Steamodded devs (Although this is
							an undocumented context as of writing).]]
							if cardScores then
								return { doNotRedSeal = true, remove_from_hand = true }
							else
								return { doNotRedSeal = true, add_to_hand = true }
							end
						end
					end
				end
			end,
			
			calc_straight = function(self, card, context, formTable)
				if
					context.before
					and context.cardarea == G.jokers
				then
					local contextRef = context
					local handRef = G.play.cards
					local findLowest = CirnoMod.miscItems.cardRanksToValues_AceLow[G.play.cards[1].base.value]
					local entireHandDebuffed = true
					local percent = 1
					
					for i = 1, #G.play.cards do
						if G.play.cards[i]:can_calculate() then
							entireHandDebuffed = false
							break
						end
					end
					
					return { doNotRedSeal = entireHandDebuffed, func = function()
						--[[ Works out the lowest ranked card in hand,
						out of all the ones that can calculate, then
						flips them.]]
						for i = 1, #handRef do
							if
								handRef[i]:can_calculate()
								and not SMODS.has_no_rank(handRef[i])
							then
								if CirnoMod.miscItems.cardRanksToValues_AceLow[handRef[i].base.value] < findLowest then
									findLowest = CirnoMod.miscItems.cardRanksToValues_AceLow[handRef[i].base.value]
								end
								
								if
									not handRef[i]:is_face()
									and not SMODS.has_no_rank(handRef[i])
								then
									CirnoMod.miscItems.flippyFlip.fStart(handRef[i], percent)
								end
							end
						end
						
						if
							not contextRef.blueprint
							and not contextRef.retrigger_joker
						then
							-- Sets up the xmult.
							if entireHandDebuffed then
								formTable.xmult = 1
							else
								formTable.xmult = findLowest
							end
						end
						
						percent = 1
						
						-- Randomises numbered rank cards, then unflips them.
						for i = 1, #handRef do
							if
								not handRef[i]:is_face()
								and handRef[i]:can_calculate()
								and not SMODS.has_no_rank(handRef[i])
							then
								G.E_MANAGER:add_event(Event({
									trigger = 'immediate',
									blocking = true,
									blockable = true,
									func = function()
										local cardRef = handRef[i]
										
										SMODS.change_base(cardRef, nil, pseudorandom_element(formTable.rankTable, pseudoseed('uncannyRanks')))
										
										return true
										end }))
								
								CirnoMod.miscItems.flippyFlip.fEnd(handRef[i], percent)
							end
						end
					end }
				end
				
				if context.joker_main and context.cardarea == G.jokers then
					return { xmult = to_big(formTable.xmult) }
				end
			end,
			
			calc_flush = function(self, card, context, formTable)
				if context.before and context.cardarea == G.jokers then
					-- Captures if played hand has 5, 3 or 1 card(s)
					local isOdd = (#G.play.cards == 5
						or #G.play.cards == 3
						or #G.play.cards == 1)
					
					if isOdd then
						local handRef = G.play.cards
						local middleCard = nil
						local percent = 1
						
						if #G.play.cards == 5 then
							middleCard = 3
						elseif #G.play.cards == 3 then
							middleCard = 2
						else
							middleCard = 1
						end
						
						--[[ This setup looks odd, but if I don't do it this way,
						it displaces the retrigger messages in instances where
						this joker is retriggered.]]
						return { func = function()
							for i = 1, #handRef do
								if
									i ~= middleCard
									and handRef[i]:can_calculate()
								then
									CirnoMod.miscItems.flippyFlip.fStart(handRef[i], percent)
								end
							end
							
							for i = 1, #handRef do
								if
									i ~= middleCard
									and handRef[i]:can_calculate()
								then
									local amount = formTable.rankChange
									
									if i > middleCard then
										amount = -formTable.rankChange
									end
									
									G.E_MANAGER:add_event(Event({
									trigger = 'immediate',
									blocking = true,
									blockable = true,
									func = function()
										local cardRef = handRef[i]
										local amount_ = amount
										
										SMODS.modify_rank(cardRef, amount_)
										
										return true
										end }))
								end
							end
							
							percent = 1
							
							for i = 1, #handRef do
								if
									i ~= middleCard
									and handRef[i]:can_calculate() 
								then
									CirnoMod.miscItems.flippyFlip.fEnd(handRef[i], percent)
								end
							end
						end }
					end
				end
			end,
			
			calc_fullHouse = function(self, card, context, formTable)			
				if
					context.individual
					and context.cardarea == G.play
					and context.other_card
					and context.other_card:can_calculate()
					and context.other_card:is_face()
					and not SMODS.has_no_rank(context.other_card)
				then
					local juiceCard = card
					
					if context.blueprint then
						juiceCard = context.blueprint_card
					end
					
					formTable.accruedMoney = to_big(formTable.accruedMoney) + to_big(formTable.monGain)
					return { func = function()
						juiceCard:juice_up()
					end }
				end
			end,
			
			calc_fourKind = function(self, card, context, formTable)
				if
					context.individual
					and context.other_card
					and context.scoring_hand
					and context.scoring_hand[1] == context.other_card
				then
					local firstCardChips = to_big(CirnoMod.miscItems.cardRanksToValues_AceHigh[context.other_card.base.value])
					
					local e_Table = SMODS.get_enhancements(context.other_card)
					local replacesBase = false
					local enhancement = nil
					
					if e_Table then
						for k, b in pairs(e_Table) do
							replacesBase = k == 'm_stone'
							enhancement = G.P_CENTERS[k]
							break
						end
					end
					
					if enhancement and enhancement.config.bonus then
						if replacesBase then
							firstCardChips = to_big(enhancement.config.bonus)
						else
							firstCardChips = to_big(firstCardChips) + to_big(enhancement.config.bonus)
						end
					end
					
					if card.ability.perma_bonus and to_big(card.ability.perma_bonus) > 0 then
						firstCardChips = to_big(firstCardChips) + to_big(card.ability.perma_bonus)
					end
					
					local edition = context.other_card.edition
					
					if edition and edition.chips then
						firstCardChips = to_big(firstCardChips) + to_big(edition.chips)
					end
					
					local final_xChips = math.max(to_big(firstCardChips) / to_big(4), 1)
					
					if final_xChips > 1 then
						return { x_chips = to_big(final_xChips) }
					end
				end
				
				if context.joker_main and context.cardarea == G.jokers then
					local mCard = context.blueprint_card or card
					local mColour = G.C.MULT
					
					if context.blueprint then
						if mCard.ability.name == "Brainstorm" then
							mColour = G.C.RED
						else
							mColour = G.C.BLUE
						end
					end
					
					local RT = {}
					local xmultsRequired = 0
					
					if SMODS.pseudorandom_probability(card, 'forestMazeOne', 1, formTable.chance1) then
						xmultsRequired = 1
					end
					
					if SMODS.pseudorandom_probability(card, 'forestMazeTwo', 1, formTable.chance2) then
						xmultsRequired = xmultsRequired + 1
					end
					
					if SMODS.pseudorandom_probability(card, 'forestMazeThree', 1, formTable.chance3) then
						xmultsRequired = xmultsRequired + 1
					end
					
					if SMODS.pseudorandom_probability(card, 'forestMazeFour', 1, formTable.chance4) then
						xmultsRequired = xmultsRequired + 1
					end
					
					-- .-.
					if xmultsRequired > 0 then
						RT.xmult = to_big(formTable.xmult)
						
						if xmultsRequired > 1 then
							RT.extra = {
							xmult = to_big(formTable.xmult),
							message_card = mCard,
							colour = mColour }
							
							if xmultsRequired > 2 then
								RT.extra.extra = {
								xmult = to_big(formTable.xmult),
								message_card = mCard,
								colour = mColour }
								
								if xmultsRequired == 4 then
									RT.extra.extra.extra = {
									xmult = to_big(formTable.xmult),
									message_card = mCard,
									colour = mColour }
								end
							end
						end
					end
					
					return RT
				end
			end,
			
			calc_straightFlush = function(self, card, context, formTable)
				if
					not context.blueprint
					and not context.retrigger_joker
					and not context.retrigger_joker_check
					and context.before
					and context.cardarea == G.jokers
				then
					if context.b3313_formChange then
						formTable.storedHandSize = to_big(G.hand.config.card_limit)
						
						local discardTarget = to_big(G.GAME.current_round.discards_left) - to_big(2)
						local handSizeTarget = to_big(G.hand.config.card_limit) - to_big(2)
						
						if to_big(discardTarget) < to_big(0) then
							discardTarget = to_big(0)
						end
						
						if to_big(handSizeTarget) <= to_big(0) then
							handSizeTarget = to_big(1)
						end
						
						ease_discard(to_big(-G.GAME.current_round.discards_left) + to_big(discardTarget), nil, true)
						
						G.hand:change_size(to_big(-G.hand.config.card_limit) + to_big(handSizeTarget))
					end
					
					for i, c in ipairs(G.play.cards) do
						if
							c.base.value == "2"
							and not c.edition
							and c:can_calculate()
							and not SMODS.has_no_rank(c)
						then
							local cardRef = c
							
							if SMODS.pseudorandom_probability(card, '2negativeChance', 1, formTable.negativeChance) then
								G.E_MANAGER:add_event(Event({
											trigger = 'immediate',
											blocking = true,
											blockable = true,
											func = function()
												cardRef:set_edition('e_negative')
											end }))
							else
								G.E_MANAGER:add_event(Event({
									trigger = 'immediate',
									blocking = true,
									blockable = true,
									func = function()
										attention_text({
											text = localize('k_nope_ex'),
											scale = 1.3,
											hold = 1.4,
											major = cardRef,
											backdrop_colour = G.C.UI.TEXT_DARK,
											align = 'cm',
											offset = {x = 0, y = 0},
											silent = true })
										
										G.E_MANAGER:add_event(Event({
											trigger = 'after',
											delay = 0.06*G.SETTINGS.GAMESPEED,
											blockable = false,
											blocking = false,
											func = function()
												play_sound('tarot2', 0.76, 0.4);return true
											end}))
									
										play_sound('tarot2', 1, 0.4)
										cardRef:juice_up(0.3, 0.5)
									return true 
									end }))
							end
						end
					end
				end
				
				if
					not context.end_of_round
					and not context.game_over
					and context.individual
					and context.cardarea == G.hand
					and context.other_card
					and context.other_card.base.value == "2"
					and not SMODS.has_no_rank(context.other_card)
				then
					if context.other_card.debuff then
						return {
							message = localize('k_debuffed'),
							colour = G.C.RED,
							sound = 'cancel'
						}
					else
						return { x_chips = to_big(formTable.xchips) }
					end
				end
				
				if
					not context.blueprint
					and not context.retrigger_joker
					and not context.retrigger_joker_check
					and context.end_of_round
					and context.main_eval
					and not context.game_over
				then
					G.hand:change_size(to_big(2))
				end
			end,
			
			calc_fiveKind = function(self, card, context, formTable)
				if
					not context.blueprint
					and not context.retrigger_joker
					and not context.retrigger_joker_check
					and context.individual
					and context.cardarea == G.play
					and context.other_card:can_calculate()
					and context.other_card:is_face()
					and not SMODS.has_no_rank(context.other_card)
				then
					if not formTable.handContainedFaceCards then
						formTable.handContainedFaceCards = true
					end
					
					local formTable_ = formTable
					local cardRef = context.other_card
					local jkrRef = card
					
					if
						not cardRef.edition
						and (cardRef.base.value == "Queen"
						or formTable.parsedKingsJacks[cardRef])
						and not formTable.queenPolycule[cardRef]						
					then
						if SMODS.pseudorandom_probability(card, 'queenPolyChance', 1, formTable.polyChance) then
							formTable.queenPolycule[cardRef] = true
							
							return { doNotRedSeal = true,
								func = function()
									G.E_MANAGER:add_event(Event({
										trigger = 'immediate',
										blocking = true,
										blockable = true,
										func = function()
											cardRef:set_edition('e_polychrome', true)
										return true 
										end }))
								end }
						else
							return { doNotRedSeal = true,
								func = function()
									G.E_MANAGER:add_event(Event({
										trigger = 'immediate',
										blocking = true,
										blockable = true,
										func = function()
											attention_text({
												text = localize('k_nope_ex'),
												scale = 1.3,
												hold = 1.4,
												major = cardRef,
												backdrop_colour = G.C.SECONDARY_SET.Tarot,
												align = 'cm',
												offset = {x = 0, y = 0},
												silent = true })
											
											G.E_MANAGER:add_event(Event({
												trigger = 'after',
												delay = 0.06*G.SETTINGS.GAMESPEED,
												blockable = false,
												blocking = false,
												func = function()
													play_sound('tarot2', 0.76, 0.4);return true
												end}))
										
											play_sound('tarot2', 1, 0.4)
											cardRef:juice_up(0.3, 0.5)
										return true 
										end }))
								end }
						end
					elseif
						cardRef.base.value == "King"
						or cardRef.base.value == "Jack"
						and not formTable.parsedKingsJacks[cardRef]
					then
						formTable.parsedKingsJacks[cardRef] = true
						
						-- This setup looks weird, but it's all to achieve a specific visual timing.
						CirnoMod.miscItems.flippyFlip.fStart(cardRef, formTable_.pitch)
						
						return { doNotRedSeal = true,
							func = function()
								formTable_.pitch = 1
								
								G.E_MANAGER:add_event(Event({
									trigger = 'immediate',
									blocking = true,
									blockable = true,
									func = function()
										if cardRef.base.value == "King" then
											SMODS.modify_rank(cardRef, -1)
										elseif cardRef.base.value == "Jack" then
											SMODS.modify_rank(cardRef, 1)
										end
										
										formTable_.pitch = math.max(formTable_.pitch - 0.09, 0.5)
										jkrRef:juice_up();play_sound('generic1', formTable_.pitch)
									return true 
									end }))
								
								formTable_.pitch = 1
								
								CirnoMod.miscItems.flippyFlip.fEnd(cardRef, formTable_.pitch)
							end }
					end
				end
				
				if
					not context.blueprint
					and not context.retrigger_joker
					and not context.retrigger_joker_check
					and context.joker_main
					and context.cardarea == G.jokers
				then
					if not formTable.handContainedFaceCards then
						G.E_MANAGER:add_event(Event({
									trigger = 'immediate',
									blocking = true,
									blockable = true,
									func = function()
										card:juice_up();play_sound('tarot2')
										SMODS.debuff_card(card, true, 'cir_Jkr_autoEORUndebuff')
									return true 
									end }))
					end
					formTable.parsedKingsJacks = {}
					formTable.queenPolycule = {}
					formTable.handContainedFaceCards = false
				end
			end,
			
			calc_flushHouse = function(self, card, context, formTable)
				if
					not context.blueprint
					and not context.retrigger_joker
					and not context.retrigger_joker_check
					and context.before
					and context.cardarea == G.jokers
				then
					return { balance = true }
				end
				
				if context.joker_main and context.cardarea == G.jokers then
					local combinedBaseValue = 0
					
					for i, c in ipairs (G.hand.cards) do
						if
							c:can_calculate()
							and not SMODS.has_no_rank(c)
						then
							combinedBaseValue = to_big(combinedBaseValue) + to_big(CirnoMod.miscItems.cardRanksToValues_AceHigh[c.base.value])
						end
					end
					
					return { mult = to_big(combinedBaseValue) }
				end
			end,
			
			calc_flushFive = function(self, card, context, formTable)
				if
					not context.blueprint
					and not context.retrigger_joker
					and not context.retrigger_joker_check
					and context.individual
					and context.cardarea == G.play
					and context.other_card:can_calculate()
					and context.other_card:is_suit("Clubs")
					and context.other_card.base.value == "Queen"
					and not next(SMODS.get_enhancements(context.other_card))
				then
					local formTable_ = formTable
					local cardRef = context.other_card
					local jkrRef = card
					
					-- This setup looks weird, but it's all to achieve a specific visual timing.
					CirnoMod.miscItems.flippyFlip.fStart(cardRef, formTable_.pitch)
					
					return { doNotRedSeal = true,
						func = function()
							-- Sets the random enhancement
							cardRef:set_ability('m_steel', nil, true)
							
							formTable_.pitch = 1
							
							G.E_MANAGER:add_event(Event({
								trigger = 'immediate',
								blocking = true,
								blockable = true,
								func = function()								
									formTable_.pitch = math.max(formTable_.pitch - 0.09, 0.5)
									jkrRef:juice_up();play_sound('generic1', formTable_.pitch)
									return true 
								end }))
							
							formTable_.pitch = 1
							
							CirnoMod.miscItems.flippyFlip.fEnd(cardRef, formTable_.pitch)
						end }
				end
			end,
			
			calculate = function(self, card, context)
				if
					context.setting_blind
					or context.starting_shop
				then
					if card.ability.extra.currentForm ~= 'base' then
						cardRef.ability.extra.currentForm = 'base'
						self.updateState(card)
					end
					
					card.ability.extra.formsInfo.crescent.accruedMoney = 0
					card.ability.extra.formsInfo.peachCell.handContainedFaceCards = false
					card.ability.extra.scoredHandName = nil
				end
				
				if
					not context.blueprint
					and not context.retrigger_joker
					and context.first_hand_drawn
				then
					juice_card_until(card, function()
						return G.GAME.current_round.hands_played == 0
							and not G.RESET_JIGGLES
					end, true)
				end
				
				local formTable = nil
				
				-- Order of operations is a bitch.
				if card.ability.extra.currentForm == 'base' then
					if
						context.before
						and not context.blueprint
						and not context.retrigger_joker
						and not context.retrigger_joker_check
					then
						if context.scoring_name then
							card.ability.extra.scoredHandName = context.scoring_name
						end
						
						self:change_form(card, card.ability.extra.handToForm[context.scoring_name])
						context.b3313_formChange = true
					end
					
					if
						context.before
						or context.joker_main
						or context.main_eval
						or (context.post_trigger
						and not (CirnoMod.miscItems.isState(G.STATE, G.STATES.SHOP)
						or CirnoMod.miscItems.isState(G.STATE, G.STATES.BLIND_SELECT)
						or CirnoMod.miscItems.isState(G.STATE, G.STATES.NEW_ROUND)
						or CirnoMod.miscItems.isState(G.STATE, G.STATES.TAROT_PACK)
						or CirnoMod.miscItems.isState(G.STATE, G.STATES.PLANET_PACK)
						or CirnoMod.miscItems.isState(G.STATE, G.STATES.SPECTRAL_PACK)
						or CirnoMod.miscItems.isState(G.STATE, G.STATES.STANDARD_PACK)
						or CirnoMod.miscItems.isState(G.STATE, G.STATES.BUFFOON_PACK)
						or CirnoMod.miscItems.isState(G.STATE, 999)))
						or context.cardarea == G.play
						or (context.individual
						and context.cardarea == G.hand)
					then
						local findScoringName = context.scoring_name
						
						if
							not findScoringName
							and card.ability.extra.scoredHandName
						then
							findScoringName = card.ability.extra.scoredHandName
						end
						
						formTable = card.ability.extra.formsInfo[card.ability.extra.handToForm[findScoringName]]
					end
				elseif card.ability.extra.currentForm ~= 'base' then
					formTable = card.ability.extra.formsInfo[card.ability.extra.currentForm]
				end
				
				if
					formTable
					and self[formTable.funcName]
					and type(self[formTable.funcName]) == 'function'
				then
					local RT = self[formTable.funcName](self, card, context, formTable)
					
					if context.b3313_formChange then
						context.b3313_formChange = nil
					end
					
					if RT then
						return RT
					end
				end
			end
		},
		-- Confused Rumi
		{
			key = 'confusedRumi',
			
			matureRefLevel = 1,
			cir_Friend = CirnoMod.miscItems.cirFriends.rmi,
			
			loc_txt = {
				name = "Confused Rumi",
				text = {
					'During the first {C:attention}#1#{C:blue}#2#{} of a round,',
					'Convert all played {C:attention}left{} cards',
					'into {C:attention}right{} cards',
					'{s:0.8,C:inactive}What is "left card?"',
					'{s:0.8,C:inactive}How do you define "left card?"',
					'{s:0.8,C:inactive}If you\'re talking about what',
					'{s:0.8,C:inactive}you can feel, what you can taste,',
					'{s:0.8,C:inactive}and see, then "left card" is',
					'{s:0.8,C:inactive}simply Balatro-cal signals,',
					'{s:0.8,C:inactive}interpreted by your brain'
				}
			},
			
			config = { extra = { upToHands = 1 } },
			pos = { x = 2, y = 2 },
			cost = 8,
			eternal_compat = true,
			perishable_compat = true,
			
			blueprint_compat = true,
			loc_vars = function(self, info_queue, card)
				local ret = { vars = { '', 'hand' } }
				
				if card.ability.extra.upToHands > 1 then
					ret.vars[1] = card.ability.extra.upToHands..' '
					ret.vars[2] = 'hands'
				end
				
				if CirnoMod.config.negativePCardsBalancing then
					ret.key = 'cir_j_confusedRumi_nPCardRebalanced'
					
					info_queue[#info_queue + 1] = { key = 'e_negative_playing_card',
						set = 'Edition',
						config = { extra = 1 },
						vars = { 1,
							G.localization.descriptions.Joker.j_splash.name,
							string.sub(G.localization.descriptions.Enhanced.m_stone.name, 1, #G.localization.descriptions.Enhanced.m_stone.name - 5)
						} }
				end
				
				-- Art credit tooltip
				if CirnoMod.config['artCredits'] and not card.fake_card then
					info_queue[#info_queue + 1] = { key = "jA_confusedRumi", set = "Other" }
				end
				
				return ret
			end,
			
			set_badges = function(self, card, badges)
				if CirnoMod.miscItems.isUnlockedAndDisc(card) then
					CirnoMod.miscItems.addBadgesToJokerByKey(badges, 'j_cir_confusedRumi')
				end
			end,
			
			cir_upgradeInfo = function(self, card)
				if card.ability.extra.upToHands > 1 then
					return {
						'During the first {C:attention}'..to_big(card.ability.extra.upToHands)..'{} hands',
						'->',
						'During the first {C:attention}'..to_big(card.ability.extra.upToHands) + to_big(1)..'{} hands'
					}
				else
					return {
						'During the first hand',
						'->',
						'During the first {C:attention}2{} hands'
					}
				end
			end,
			
			cir_upgrade = function(self, card)
				card.ability.extra.upToHands = to_big(card.ability.extra.upToHands) + to_big(1)
				
				self.updateState(card)
				
				return { message = localize('k_upgrade_ex') }
			end,
			
			updateState = function(jkr)
				if
					CirnoMod.miscItems.isState(G.STATE, G.STATES.SELECTING_HAND)
					and to_big(G.GAME.current_round.hands_played) < to_big(jkr.ability.extra.upToHands)
				then
					juice_card_until(jkr, function()
						return to_big(G.GAME.current_round.hands_played) < to_big(jkr.ability.extra.upToHands)
							and not G.RESET_JIGGLES
					end, true)
				end
			end,
			
			calculate = function(self, card, context)
				if
					not context.blueprint
					and not (context.retrigger_joker
					or context.retrigger_joker_check)
					and context.first_hand_drawn
				then
					juice_card_until(card, function()
						return to_big(G.GAME.current_round.hands_played) < to_big(card.ability.extra.upToHands)
							and not G.RESET_JIGGLES
					end, true)
					
					return { doNotRedSeal = true,
						no_retrigger = true,
						message = localize('k_active_ex') }
				end
				
				if
					context.main_eval
					and context.before
					and to_big(G.GAME.current_round.hands_played) < to_big(card.ability.extra.upToHands)
				then
					local handRef = G.play.cards
					local cardRef = context.blueprint_card or card
					local pitch = 1
					
					--[[ This setup looks odd, but if I don't do it this way,
						it displaces the retrigger messages in instances where
						this joker is retriggered.]]
					return { func = function()
						for i = 1, #handRef do
							CirnoMod.miscItems.flippyFlip.fStart(handRef[i], pitch)
						end
						
						G.E_MANAGER:add_event(Event({
							trigger = 'immediate',
							blocking = true,
							blockable = true,
							func = function()
								cardRef:juice_up()
								
								return true
								end }))
						
						for i = 1, #handRef do
							if handRef[i+1] then
								G.E_MANAGER:add_event(Event({
									trigger = 'after',
									delay = 0.1,
									blocking = true,
									blockable = true,
									func = function()
										local fromCard = handRef[i]
										local toCard = handRef[i+1]
										
										copy_card(toCard, fromCard)
										
										return true
										end }))
							end
						end
						
						pitch = 1
						
						for i = 1, #handRef do
							CirnoMod.miscItems.flippyFlip.fEnd(handRef[i], pitch)
						end
					end }
				end
			end
		},
		-- Sir No
		{
			key = 'sirNo',
			matureRefLevel = 1,
			
			loc_txt = { name = '"Sir No"',
				text = {
					'{X:chips,C:white}X#1#{} Chips',
					'Played {C:attention}#2#',
					'{C:red}will not score{},',
					'poker hand changes',
					'at end of round',
					'{s:0.8,C:inactive}I get a lot of requests',
					'{s:0.8,C:inactive}to add a "Sir No" to the mod.',
					'{s:0.8,C:inactive}I\'m not sure what that is,',
					'{s:0.8,C:inactive}or what it has to with Cirno,',
					'{s:0.8,C:inactive}especially as they sound',
					'{s:0.8,C:inactive}nothing alike, but I aim to',
					'{s:0.8,C:inactive}please. So hopefully, this is',
					'{s:0.8,C:inactive}what people wanted'
				}
			},
			
			config = { extra = { pHand = '[poker hand]', x_chips = 4 } },
			
			pos = { x = 3, y = 2 },
			cost = 3,
			eternal_compat = true,
			perishable_compat = true,
			
			blueprint_compat = true,
			loc_vars = function(self, info_queue, card)
				local ret = { vars = { to_big(card.ability.extra.x_chips) } }
				
				if card.ability.extra.pHand == '[poker hand]' then
					ret.vars[2] = card.ability.extra.pHand
				else
					ret.vars[2] = localize(card.ability.extra.pHand, 'poker_hands')
					
					if string.sub(card.ability.extra.pHand, #card.ability.extra.pHand - 4, #card.ability.extra.pHand) == 'Flush' then
						ret.vars[2] = ret.vars[2]..'es'
					else
						ret.vars[2] = ret.vars[2]..'s'
					end
				end
				
				if CirnoMod.config['artCredits'] and not card.fake_card then
					info_queue[#info_queue + 1] = { key = "jA_MIYAZAKI", set = "Other" }
				end
				
				return ret
			end,
			
			cir_upgradeInfo = function(self, card)
				return {
					'{X:chips,C:white}X'..to_big(card.ability.extra.x_chips)..'{} Chips',
					'->',
					'{X:chips,C:white}X'..to_big(card.ability.extra.x_chips) + to_big(1)..'{} Chips'
				}
			end,
			
			cir_upgrade = function(self, card)
				card.ability.extra.x_chips = to_big(card.ability.extra.x_chips) + to_big(1)
				
				return { message = localize('k_upgrade_ex'), colour = G.C.CHIPS }
			end,
			
			pickRandHand = function(card, silent)
				if
					G.GAME
					and G.GAME.hands
				then
					local poker_hands = {}
					for k, h in pairs (G.GAME.hands) do
						if
							h.visible
							and k ~= card.ability.extra.pHand
						then
							poker_hands[#poker_hands + 1] = k
						end
					end
					
					local oldH = card.ability.extra.pHand
					card.ability.extra.pHand = nil
					
					while not card.ability.extra.pHand do
						card.ability.extra.pHand = pseudorandom_element(poker_hands, pseudoseed('sirNo_Hand'))
						
						if card.ability.extra.pHand == oldH then card.ability.extra.pHand = nil end
					end
					
					if not silent then
						SMODS.calculate_effect({ message = localize('k_reset'), colour = G.C.FILTER }, card)
					end
					return true
				end
				
				return false
			end,
			
			add_to_deck = function(self, card, from_debuff)
				self.pickRandHand(card)
			end,
			
			calculate = function(self, card, context)
				if
					context.debuff_hand
					and context.main_eval
					and context.scoring_name == card.ability.extra.pHand
				then
					return { debuff = true }
				end
				
				if
					context.end_of_round
					and context.main_eval
					and not context.game_over
				then
					self.pickRandHand(card)
				end			
				
				if context.joker_main then
					return { x_chips = to_big(card.ability.extra.x_chips) }
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
	jkr.atlas = 'cir_cRares'
	jkr.loadOrder = 'rare'
	jkr.rarity = 3
end

return jokerInfo