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
		- Ornstein & Smough Joker pair that respectively become Super Ornstein & Super Smough when the other of the two is destroyed (not sold)
		- Redacted '██████' Joker whose effects are not clear, highly unpredictable and inconsistent, heavily RNG-based but also extremely confusing
		- Mac n' Cheese Joker; Every 2 Boss Blinds, if there's room, creates a Ketchup (Seltzer). Gains x0.1 mult every time a ketchup runs out.
		- Bloodborne on PC Joker: Dithering between the effect of "Sell this Joker during a blind to draw 2x hand size to card", "In X rounds, sell this Joker to multiply your number of discards by 1.5" & "Sell this Joker during a blind to discard all held cards and draw a new hand (If deck is empty, refresh deck)."
		- "Help I'm Trapped In The Joker Factory" will have some different effects that get selected randomly on joker creation, all related to blinds, one off the top of my head is "This Joker gives +5 mult during The Memory (the boss blind) & also gains X0.05 mult whenever Cirno forgets something" and then it just randomly gains X0.05 mult based on random, unpredictable criteria.
		- "Fuckin' Catgirl Sex Fuckin Footjob Dick Suckin' Simulator" No idea what this could do.
		- Endless Eight Joker
		- Sonic '06 Joker
		- Emotional Support Broken Man Joker
		- Turn all left cards into right cards
		- Money laundry?
		- Air fryer?
	]]
	jokerConfigs = {
		-- Crystal Tap
		{
			-- How the Joker will be referred to internally.
			key = 'crystalTap',
			
			object_type = 'Joker',
			
			matureRefLevel = 1,
			
			loc_txt = {
				name = "Crystal Tap",
				text = { '' }
			},
			
			atlas = 'cir_cRares',
			pos = { x = 7, y = 1}, -- Defines base card graphic position in the atlas.
			soul_pos = { x = 9, y = 1}, -- Defines where this card's soul overlay is in the given atlas
			rarity = 3, -- Rare rarity
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
					
					if
						not silent
						or silent == false
					then
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
					
					SMODS.calculate_effect({ message = rMessage, colour, G.C.BLUE }, card)
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
				if CirnoMod.config['artCredits'] then
					info_queue[#info_queue + 1] = { key = "jA_CrysTap", set = "Other" }
				end
				
				if
					card.ability.extra.pHand == '[HAND]'
					and self.pickRandHand(card, true) == false
				then
					card.ability.extra.pHand = 'Flush'
				end
				
				return { vars = {
						card.ability.extra.mult,
						card.ability.extra.xmult
					},
					main_end = self.create_main_end(self, card)
				}
			end,
			
			calculate = function(self, card, context)
				if
					context.cardarea == G.jokers
					and context.blueprint_card == nil
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
						and card.ability.extra.preventEndOfRoundChange == false)
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
			
			object_type = 'Joker',
			
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
			
			atlas = 'cir_cRares',
			pos = { x = 6, y = 1 },
			rarity = 3,
			cost = 8,
			eternal_compat = true,
			perishable_compat = true,
			
			config = {
				extra = {
					xmult = 4,
					odds = 7
				}
			},
			
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
				if CirnoMod.config['artCredits'] then
					info_queue[#info_queue + 1] = { key = "jA_NTF", set = "Other" }
				end
				
				return { vars = {
						card.ability.extra.xmult,
						''..(G.GAME and G.GAME.probabilities.normal or 1),
						card.ability.extra.odds
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
						colour = G.C.RED
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
						if to_big(pseudorandom('mitaKill')) < to_big(G.GAME.probabilities.normal)/to_big(card.ability.extra.odds) then
							context.other_card.getting_sliced = true -- Marks the card for destruction.
							RT.doNotRedSeal = true
							RT.message = '  '
							RT.colour = G.C.RED
							RT.func = function()
								G.E_MANAGER:add_event(Event({
									trigger = 'after',
									delay = 1.5,
									blocking = false,
									blockable = true,
									func = function()
										context.other_card.children.knifeSprite = Sprite(
											context.other_card.T.x, context.other_card.T.y, -- Sprite X & Y
											context.context.other_card.T.w, card.T.w, -- Sprite W & H
											CirnoMod.miscItems.otherAtlases.cardKnifeStab, -- Sprite Atlas
											{ x = 0, y = 0 }) -- Position in the Atlas
										
										context.other_card.children.knifeSprite.role.draw_major = context.other_card
										context.other_card.mitaKill = true -- Purely for the visual effect.
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
			
			object_type = 'Joker',
			
			matureRefLevel = 1,
			
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
					"skin that is {C:attention}#1#{}, {C:attention}#2#{} or",
					"{C:attention}#3#{} related."
				}
			},
			unlocked = false,
			
			atlas = 'cir_cRares',
			pos = { x = 0, y = 2 },
			rarity = 3,
			cost = 8,
			eternal_compat = true,
			perishable_compat = true,
			
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
				
				--[[ Art credit tooltip
				if CirnoMod.config['artCredits'] then
					info_queue[#info_queue + 1] = { key = "", set = "Other" }
				end]]
				
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
			
			object_type = 'Joker',
			
			matureRefLevel = 1,
			
			loc_txt = {
				name = "Rubber Room",
				text = {
					"{X:mult,C:white}X#1#{} Mult for every {C:attention}Joker{}",
					"whose graphic or reskin either",
					"is or is otherwise related",
					"to {C:attention}crazy women{}.",
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
					"references to",
					"{C:attention}#1#"
				}
			},
			unlocked = false,
			
			atlas = 'cir_cRares',
			pos = { x = 1, y = 2 },
			rarity = 3,
			cost = 8,
			eternal_compat = true,
			perishable_compat = true,
			
			config = {
				extra = {
					xmult = 1,
					growth = 1.75
				}
			},
			
			updateCurMult = function(extraTable)
				if not CirnoMod.miscItems.isState(G.STAGE, G.STAGES.MAIN_MENU) then
					local prevMult = to_big(extraTable.xmult)
					local counter = 0
					
					for i, jkr in ipairs(G.jokers.cards) do
						if jkr.config.center.key ~= 'j_cir_rubberRoom' then
							local jkrKeyGroup = CirnoMod.miscItems.keyGroupOfJokerKey(jkr.config.center.key)
							
							if jkrKeyGroup and jkrKeyGroup == 'crazyWomen' then
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
				
				info_queue[#info_queue + 1] = CirnoMod.miscItems.descExtensionTooltips['eDT_cir_crazyWomen']
				
				--[Art credit tooltip
				if CirnoMod.config['artCredits'] then
					info_queue[#info_queue + 1] = { key = "jA_NTF", set = "Other" }
				end
				
				return { vars = { to_big(card.ability.extra.growth), to_big(card.ability.extra.xmult) } }
			end,
			
			locked_loc_vars = function(self, info_queue, card)
				return { vars = { CirnoMod.miscItems.obscureStringIfNoneInJokerKeyGroupEncountered('crazy women', 'crazyWomen') } }
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
				return CirnoMod.miscItems.jkrKeyGroupTotalEncounters('crazyWomen', true) > 3
			end
		},
		-- B3313
		{
			key = 'b3313',
			
			object_type = 'Joker',
			
			matureRefLevel = 1,
			
			loc_txt = CirnoMod.miscItems.createErrorLocTxt('B3313'),
			
			atlas = 'cir_cRares',
			pos = { x = 0, y = 0 },
			rarity = 3,
			cost = 12,
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
					return { { key = 'e_negative_playing_card', set = 'Edition', config = { extra = 1 } } }
				elseif extraTable.currentForm == 'peachCell' then
					if curEdition.type ~= 'polychrome' then
						return { G.P_CENTERS.e_polychrome }
					end
				elseif extraTable.currentForm == 'floor3B' then
					return { G.P_CENTERS.m_steel }
				end
				return nil
			end,
			
			create_vars_table = function(extraTable)
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
					local currentCount = nil
					
					if extraTable.formsInfo.crescent.accruedMoney > 0 then
						currentCount = SMODS.signed_dollars(to_big(extraTable.formsInfo.crescent.accruedMoney))
					else
						currentCount = '$0'
					end
					
					return { 
						SMODS.signed_dollars(to_big(extraTable.formsInfo.crescent.monGain)),
						currentCount
					}
				elseif extraTable.currentForm == 'forestMaze' then
					return {
						to_big(extraTable.formsInfo.forestMaze.xmult),
						''..(G.GAME and to_big(G.GAME.probabilities.normal) or 1),
						extraTable.formsInfo.forestMaze.chance1,
						extraTable.formsInfo.forestMaze.chance2,
						extraTable.formsInfo.forestMaze.chance3,
						extraTable.formsInfo.forestMaze.chance4
					}
				elseif extraTable.currentForm == 'loogi' then
					return { to_big(extraTable.formsInfo.loogi.xchips) }
				elseif extraTable.currentForm == 'peachCell' then
					return {
						''..(G.GAME and G.GAME.probabilities.normal or 1),
						extraTable.formsInfo.peachCell.polyChance
					}
				elseif extraTable.currentForm == 'floor3B' then
					return { G.localization.descriptions.Enhanced.m_steel.name }
				else
					return {}
				end
			end,
			
			blueprint_compat = true,
			loc_vars = function(self, info_queue, card)
				local RT = { key = 'cir_b3313_'..card.ability.extra.currentForm, vars = self.create_vars_table(card.ability.extra) }
								
				local infoQueueAppend = self.toAppendToInfoQueue(card.ability.extra, card.edition)
				
				if infoQueueAppend then
					for i, item in ipairs(infoQueueAppend) do
						info_queue[#info_queue + 1] = item
					end
				end
				
				-- Art credit tooltip
				if CirnoMod.config['artCredits'] then
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
				And if the amount of cards played is 5, 3 or 1]]
				return (card.ability.extra.currentForm == '4thFloor'
					or (card.ability.extra.currentForm == 'base'
					and card.ability.extra.scoredHandName
					and card.ability.extra.scoredHandName == 'Flush'))
					and (#G.play.cards == 5
					or #G.play.cards == 3
					or #G.play.cards == 1)
			end,
			
			returnToHand_func = function(self, old_dfptd)
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
						not G.play.cards[i].shattered
						and not G.play.cards[i].destroyed
					then
						if i == cardToReturn then
							-- If it's the middle card, return it to hand.
							draw_card(G.play, G.hand or G.discard, i*100/play_count, 'down', false, G.play.cards[i], 0.1, false, false)
						else
							-- If it's any other card, discard as normal.
							draw_card(G.play, G.discard, i*100/play_count, 'down', false, G.play.cards[i])
						end
					end
				end
				
				return true
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
				--[[ If calc_dollar_bonus is always called
				during end of round eval regardless of if
				there's a condition for its use, may as
				well use it for things that always need
				to happen, such as form reversion.]]
				self.change_form(self, card, 'base')
				
				if to_big(card.ability.extra.formsInfo.crescent.accruedMoney) > 0 then
					local RV = to_big(card.ability.extra.formsInfo.crescent.accruedMoney)
					
					return RV
				end
			end,
			
			jkr_shouldSkipRedSeal = function(self, context, card)
				return CirnoMod.miscItems.isState(G.STATE, G.STATES.SELECTING_HAND)
					or context.other_context.first_hand_drawn
					
					--[[
					
					In the process of being deprecated.
					
					or ((card.ability.extra.currentForm == 'betaLob'
					or (card.ability.extra.currentForm == 'base'
					and context.other_context.scoring_name == 'High Card'))
					and context.other_context.individual) -- High Card form skip conditions
					or ((card.ability.extra.currentForm == 'peachCell'
					or (card.ability.extra.currentForm == 'base'
					and context.other_context.scoring_name == 'Five of a Kind'))
					and context.other_context.individual
					and context.other_context.other_card
					and context.other_context.other_card.base.value ~= 'Queen') -- Five of a Kind form skip conditions
					-- or ((card.ability.extra.currentForm == 'nebLob'
					-- or (card.ability.extra.currentForm == 'base'
					-- and context.other_context.scoring_name == 'Flush House'))
					-- and context.other_context.before) -- Flush House form skip conditions
					or (card.ability.extra.currentForm == 'floor3B'
					or (card.ability.extra.currentForm == 'base'
					and context.other_context.scoring_name == 'Flush Five')) -- Flush Five form skip conditions
					
					]]
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
						cardRef:set_ability(SMODS.poll_enhancement({ guaranteed = true }), nil, true)
						
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
					and not (card.ability.extra.currentForm == 'base'
					and CirnoMod.miscItems.isState(G.STATE, G.STATES.SELECTING_HAND))
				then
					-- Gives money when other Jokers are triggered
					local mCard = card
					
					if context.blueprint then
						mCard = context.blueprint_card
					end
					
					return { dollars = to_big(formTable.monGain), message_card = mCard }
				end
			end,
			
			calc_threeKind = function(self, card, context, formTable)
				if card.ability.extra.currentForm ~= 'base' then
					if
						context.before
						and context.cardarea == G.jokers
					then
						if
							not context.retrigger_joker
							and not context.retrigger_joker_check
							and not context.blueprint
						then
							--[[ Gives the Joker a little jiggle to visually connect it
							to the inverse splash mechanic occurring]]
							card:juice_up()
						end
						
						-- Processes edition scaling				
						if card.edition and card.edition.type ~= 'negative' then
							local cardRef = card
							
							return {
								message = localize('k_upgrade_ex'),
								message_card = card,
								func = function()
									CirnoMod.miscItems.scaleEdition_FHP(cardRef, formTable.scalar)
								end
							}
						end
					end
					
					-- Inverse splash mechanics
					if
						context.modify_scoring_hand
						and context.main_eval
						and not context.retrigger_joker
						and not context.retrigger_joker_check
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
					and not context.blueprint
				then
					local findLowest = CirnoMod.miscItems.cardRanksToValues_AceLow[G.play.cards[1].base.value]
					local entireHandDebuffed = true
					local percent = 1
					
					--[[ Works out the lowest ranked card in hand,
					out of all the ones that can calculate, then
					flips them.]]
					for i = 1, #G.play.cards do
						if
							G.play.cards[i]:can_calculate()
							and not SMODS.has_enhancement(G.play.cards[i], 'm_stone')
						then
							entireHandDebuffed = false
							if CirnoMod.miscItems.cardRanksToValues_AceLow[G.play.cards[i].base.value] < findLowest then
								findLowest = CirnoMod.miscItems.cardRanksToValues_AceLow[G.play.cards[i].base.value]
							end
							
							if
								not G.play.cards[i]:is_face()
								and not SMODS.has_enhancement(G.play.cards[i], 'm_stone')
							then
								CirnoMod.miscItems.flippyFlip.fStart(G.play.cards[i], percent)
							end
						end
					end
					
					-- Sets up the xmult.
					if entireHandDebuffed then
						formTable.xmult = 1
					else
						formTable.xmult = findLowest
					end
					
					percent = 1
					
					-- Randomises numbered rank cards, then unflips them.
					for i = 1, #G.play.cards do
						if
							not G.play.cards[i]:is_face()
							and G.play.cards[i]:can_calculate()
							and not SMODS.has_enhancement(G.play.cards[i], 'm_stone')
						then
							G.E_MANAGER:add_event(Event({
								trigger = 'immediate',
								blocking = true,
								blockable = true,
								func = function()
									local cardRef = G.play.cards[i]
									
									SMODS.change_base(cardRef, nil, pseudorandom_element(formTable.rankTable, pseudoseed('uncannyRanks')))
									
									return true
									end }))
							
							CirnoMod.miscItems.flippyFlip.fEnd(G.play.cards[i], percent)
						end
					end
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
					
					local middleCard = nil
					
					if isOdd then
						local percent = 1
						
						if #G.play.cards == 5 then
							middleCard = 3
						elseif #G.play.cards == 3 then
							middleCard = 2
						else
							middleCard = 1
						end
						
						for i = 1, #G.play.cards do
							if
								G.play.cards[i]:can_calculate()
								and i ~= middleCard
							then
								CirnoMod.miscItems.flippyFlip.fStart(G.play.cards[i], percent)
								
								local amount = formTable.rankChange
								
								if i > middleCard then
									amount = -formTable.rankChange
								end
								
								G.E_MANAGER:add_event(Event({
								trigger = 'immediate',
								blocking = true,
								blockable = true,
								func = function()
									local cardRef = G.play.cards[i]
									local amount_ = amount
									
									SMODS.modify_rank(cardRef, amount_)
									
									return true
									end }))
								
								CirnoMod.miscItems.flippyFlip.fEnd(G.play.cards[i], percent)
							end
						end
						
						return nil
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
					and not SMODS.has_enhancement(context.other_card, 'm_stone')
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
					local mCard = card
					local mColour = G.C.MULT
					
					if context.blueprint then
						mCard = context.blueprint_card
						
						if mCard.ability.name == "Brainstorm" then
							mColour = G.C.RED
						else
							mColour = G.C.BLUE
						end
					end
					
					local RT = {}
					local xmultsRequired = 0
					
					if pseudorandom('forestMazeOne'..G.GAME.round_resets.ante) < G.GAME.probabilities.normal/formTable.chance1 then
						xmultsRequired = 1
					end
					
					if pseudorandom('forestMazeTwo'..G.GAME.round_resets.ante) < G.GAME.probabilities.normal/formTable.chance2 then
						xmultsRequired = xmultsRequired + 1
					end
					
					if pseudorandom('forestMazeThree'..G.GAME.round_resets.ante) < G.GAME.probabilities.normal/formTable.chance3 then
						xmultsRequired = xmultsRequired + 1
					end
					
					if pseudorandom('forestMazeFour'..G.GAME.round_resets.ante) < G.GAME.probabilities.normal/formTable.chance4 then
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
							and not SMODS.has_enhancement(c, 'm_stone')
						then
							c:set_edition('e_negative')
						end
					end
				end
				
				if
					not context.end_of_round
					and context.individual
					and context.cardarea == G.hand
					and context.other_card
					and context.other_card.base.value == "2"
					and not SMODS.has_enhancement(context.other_card, 'm_stone')
				then
					if context.other_card.debuff then
						return {
							message = localize('k_debuffed'),
							colour = G.C.RED
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
					and not SMODS.has_enhancement(context.other_card, 'm_stone')
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
						if to_big(pseudorandom('queenPolyChance'..G.GAME.round_resets.ante)) < to_big(G.GAME.probabilities.normal)/to_big(formTable.polyChance) then
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
							and not SMODS.has_enhancement(c, 'm_stone')
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
					and (card.ability.extra.formsInfo.crescent.accruedMoney > 0
					or card.ability.extra.formsInfo.peachCell.handContainedFaceCards)
				then
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
						or context.post_trigger
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
		}
	}
}

return jokerInfo