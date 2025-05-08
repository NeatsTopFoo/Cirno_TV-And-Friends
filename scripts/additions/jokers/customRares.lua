local jokerInfo = {
	isMultipleJokers = true,
	
	-- Defines the Atlas
	atlasInfo = {
		key = 'cir_cRares',
		path = "Additional/cir_custRares.png",
		px = 71,
		py = 95
	},
	
	-- TODO:
		-- Ornstein & Smough Joker pair that respectively become Super Ornstein & Super Smough when the other of the two is destroyed (not sold)
		-- Redacted '██████' Joker whose effects are not clear, highly unpredictable and inconsistent, heavily RNG-based but also extremely confusing
		-- Mac n' Cheese Joker; Every 2 Boss Blinds, if there's room, creates a Ketchup (Seltzer). Gains x0.1 mult every time a ketchup runs out.
		-- Bloodborne on PC Joker: Dithering between the effect of "Sell this Joker during a blind to draw 2x hand size to card", "In X rounds, sell this Joker to multiply your number of discards by 1.5" & "Sell this Joker during a blind to discard all held cards and draw a new hand (If deck is empty, refresh deck)."
		-- "Help I'm Trapped In The Joker Factory" will have some different effects that get selected randomly on joker creation, all related to blinds, one off the top of my head is "This Joker gives +5 mult during The Memory (the boss blind) & also gains X0.05 mult whenever Cirno forgets something" and then it just randomly gains X0.05 mult based on random, unpredictable criteria.
		-- "Fuckin' Catgirl Sex Fuckin Footjob Dick Suckin' Simulator" No idea what this could do.
		-- Endless Eight Joker
		-- Sonic '06 Joker
		-- Emotional Support Broken Man Joker
		-- Turn all left cards into right cards
		-- Money laundry?
		-- Air fryer?
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
				CirnoMod.miscItems.addUITextNode(nodes_.Ln2, 'poker hand ', G.C.FILTER, 1)
				
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
						RV.mult = card.ability.extra.mult
					elseif card.ability.extra.spriteX == 8 then
						RV.x_mult = card.ability.extra.xmult
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
						x_mult = card.ability.extra.xmult,
						colour = G.C.RED
					}
				end
				
				-- Card destroy chance processing
				if
					not context.blueprint
					and (context.cardarea == G.play
					or context.cardarea == 'unscored')
				then
					if
						context.individual
						and context.other_card
						and context.other_card:can_calculate(true)
					then
						local RT = { message_card = context.other_card }
						
						if pseudorandom('mitaKill') < G.GAME.probabilities.normal/card.ability.extra.odds then
							context.other_card.getting_sliced = true
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
										context.other_card.mitaKill = true
										return true
									end}))
							end
							RT.sound = 'slice1'
						else
							RT.message = localize('k_safe_ex')
							RT.colour = G.C.GREEN
						end
						
						return RT
					end
					
					if
						context.destroy_card
						and context.destroy_card.getting_sliced
					then
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
						extraTable.xmult = counter * extraTable.growth
					else
						extraTable.xmult = 1
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
					card.ability.extra.growth,
					CirnoMod.miscItems.getJokerNameByKey('j_bootstraps', '{C:red}Not Active{}'),
					card.ability.extra.xmult
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
						x_mult = card.ability.extra.xmult,
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
					local prevMult = extraTable.xmult
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
						extraTable.xmult = counter * extraTable.growth
						
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
				
				return { vars = { card.ability.extra.growth, card.ability.extra.xmult } }
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
						x_mult = card.ability.extra.xmult,
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
			
			loc_txt = { name = '', text = {} },
			
			atlas = 'cir_cRares',
			pos = { x = 0, y = 0 },
			rarity = 3,
			cost = 12,
			eternal_compat = true,
			perishable_compat = true,
			
			config = { extra = {
				currentForm = 'base',
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
						xmult = 3.313
					},
					['plexalLob'] = {
						atlasX = 2,
						phcChips = 20,
						tpMult = 10,
						toakMult = 15,
						flush_xmult = 1.25,
						fh_xmult = 1.5,
						foak_xmult = 2
					},
					['toadLob'] = {
						atlasX = 3,
						monGain = 1
					},
					['vanLob'] = {
						atlasX = 4
					},
					['uncanny'] = {
						atlasX = 5
					},
					['4thFloor'] = {
						atlasX = 6,
						rankChange = 1
					},
					['crescent'] = {
						atlasX = 7,
						monGain = 1,
						accruedMoney = 0
					},
					['forestMaze'] = {
						atlasX = 8,
						xmult = 1.5,
						chance1 = 3,
						chance2 = 4,
						chance3 = 5,
						chance4 = 6
					},
					['loogi'] = {
						atlasX = 9,
						xchips = 2
					},
					['peachCell'] = {
						atlasX = 10,
						polyChance = 4
					},
					['nebLob'] = {
						atlasX = 11
					},
					['floor3B'] = {
						atlasX = 12
					}
				}
			} },
			
			updateState = function(jkr)
				if
					jkr.ability
					and jkr.children
				then
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
			toAppendToInfoQueue = function(curForm)
				if curForm == 'loogi' then
					return { { key = 'pCardNegative', set = 'Other' } }
				elseif curForm == 'peachCell' then
					return { G.P_CENTERS.e_polychrome }					
				elseif curForm == 'floor3B' then
					return { G.P_CENTERS.m_steel }
				end
				return nil
			end,
			
			create_vars_table = function(extraTable)
				if extra.currentForm == 'betaLob' then
					return { extra.betaLob.xmult }
				elseif extra.currentForm == 'plexalLob' then
					return {
						extra.plexalLob.phcChips,
						extra.plexalLob.tpMult,
						extra.plexalLob.toakMult,
						extra.plexalLob.flush_xmult,
						extra.plexalLob.fh_xmult,
						extra.plexalLob.foak_xmult
					}
				elseif extra.currentForm == 'toadLob' then
					return { SMODS.signed_dollar(extra.toadLob.monGain) }
				elseif extra.currentForm == '4thFloor' then
					return { extra['4thFloor'].rankChange }
				elseif extra.currentForm == 'crescent' then
					return { 
						SMODS.signed_dollar(extra.crescent.monGain),
						extra.crescent.accruedMoney
					}
				elseif extra.currentForm == 'forestMaze' then
					return {
						extra.forestMaze.xmult,
						''..(G.GAME and G.GAME.probabilities.normal or 1),
						extra.forestMaze.chance1,
						extra.forestMaze.chance2,
						extra.forestMaze.chance3,
						extra.forestMaze.chance4
					}
				elseif extra.currentForm == 'loogi' then
					return { extra.loogi.xchips }
				elseif extra.currentForm == 'peachCell' then
					return {
						''..(G.GAME and G.GAME.probabilities.normal or 1),
						extra.peachCell.polyChance
					}
				elseif extra.currentForm == 'floor3B' then
					return { G.localization.descriptions.Enhanced.m_steel.name }
				else
					return {}
				end
			end,
			
			blueprint_compat = true,
			loc_vars = function(self, info_queue, card)
				local RT = { key = 'cir_b3313_'..card.ability.extra.currentForm, vars = self.create_vars_table(card.ability.extra) }				
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
								
				local infoQueueAppend = self.toAppendToInfoQueue(card.ability.extra.currentForm)
				
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
			
			shouldReturnToHand = function(self)
				return self.ability.extra.currentForm == '4thFloor'
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
					if
						not G.play.cards[i].shattered
						and not G.play.cards[i].destroyed
					then
						if i == cardToReturn then
							draw_card(G.play, G.hand or G.discard, i*100/play_count, 'down', false, G.play.cards[i])
						else
							draw_card(G.play, G.discard, i*100/play_count, 'down', false, G.play.cards[i])
						end
					end
				end
			end,
			
			calculate = function(self, card, context)
				
			end
		}
	}
}

return jokerInfo