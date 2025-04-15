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
		-- B3313 form-changing Joker
		-- Ornstein & Smough Joker pair that respectively become Super Ornstein & Super Smough when the other of the two is destroyed (not sold)
		-- Redacted '██████' Joker whose effects are not clear, highly unpredictable and inconsistent, heavily RNG-based but also extremely confusing
		-- Mac n' Cheese Joker; Every 2 Boss Blinds, if there's room, creates a Ketchup (Seltzer). Gains x0.1 mult every time a ketchup runs out.
		-- SM64 Water Diamond Joker, switches between two forms if a given hand is played, that changes every round or on trigger.
		-- Bloodborne on PC Joker: Dithering between the effect of "Sell this Joker during a blind to draw 2x hand size to card", "In X rounds, sell this Joker to multiply your number of discards by 1.5" & "Sell this Joker during a blind to discard all held cards and draw a new hand (If deck is empty, refresh deck)."
		-- "Help I'm Trapped In The Joker Factory" will have some different effects that get selected randomly on joker creation, all related to blinds, one off the top of my head is "This Joker gives +5 mult during The Memory (the boss blind) & also gains X0.05 mult whenever Cirno forgets something" and then it just randomly gains X0.05 mult based on random, unpredictable criteria.
		-- "Fuckin' Catgirl Sex Fuckin Footjob Dick Suckin' Simulator" No idea what this could do.
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
			
			change_soul_pos = function(card, newSoulPos)
				card.config.center.soul_pos = newSoulPos
				card:set_sprites(card.config.center)
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
			
			create_main_end = function(self, center)
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
				
				if center.ability.extra.spriteX == 7 then
					CirnoMod.miscItems.addUITextNode(
						nodes_.Ln1,
						'+'..center.ability.extra.mult,
						G.C.MULT,
						1)
				elseif center.ability.extra.spriteX == 8 then
					CirnoMod.miscItems.addUITextNode(
						CirnoMod.miscItems.addUIColumnOrRowNode(
							nodes_.Ln1,
							'm',
							'C',
							G.C.MULT,
							0,
							0.025).nodes,
						'X'..center.ability.extra.xmult,
						G.C.UI.TEXT_LIGHT,
						1)
				end
				
				CirnoMod.miscItems.addUITextNode(nodes_.Ln1, ' Mult,', G.C.UI.TEXT_DARK, 1)
				
				CirnoMod.miscItems.addUITextNode(nodes_.Ln2, 'If played ', G.C.UI.TEXT_DARK, 1)
				CirnoMod.miscItems.addUITextNode(nodes_.Ln2, 'poker hand ', G.C.FILTER, 1)
				
				CirnoMod.miscItems.addUITextNode(nodes_.Ln3, 'contains a ', G.C.UI.TEXT_DARK, 1)
				CirnoMod.miscItems.addUITextNode(nodes_.Ln3, localize(center.ability.extra.pHand, 'poker_hands') or center.ability.extra.pHand, G.C.FILTER, 1)
				CirnoMod.miscItems.addUITextNode(nodes_.Ln3, ',', G.C.UI.TEXT_DARK, 1)
				
				CirnoMod.miscItems.addUITextNode(nodes_.Ln4, self.makeRaiseLower(center), G.C.FILTER, 1)
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
			loc_vars = function(self, info_queue, center)
				-- Art credit tooltip
				if CirnoMod.config['artCredits'] then
					info_queue[#info_queue + 1] = { key = "jA_CrysTap", set = "Other" }
				end
				
				if
					center.ability.extra.pHand == '[HAND]'
					and self.pickRandHand(center, true) == false
				then
					center.ability.extra.pHand = 'Flush'
				end
				
				return { vars = {
						center.ability.extra.mult,
						center.ability.extra.xmult
					},
					main_end = self.create_main_end(self, center)
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
					"Encounter {C:attention}"..CirnoMod.miscItems.obscureStringIfJokerKeyLockedOrUndisc('Scary Face', 'j_scary_face').."{}'s",
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
			
			create_main_end = function(self, center)
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
			loc_vars = function(self, info_queue, center)
				-- Art credit tooltip
				if CirnoMod.config['artCredits'] then
					info_queue[#info_queue + 1] = { key = "jA_NTF", set = "Other" }
				end
				
				return { vars = {
						center.ability.extra.xmult,
						''..(G.GAME and G.GAME.probabilities.normal or 1),
						center.ability.extra.odds
					},
					main_end = self.create_main_end(self, center)
				}
			end,
			
			set_badges = function(self, card, badges)
				if CirnoMod.miscItems.isUnlockedAndDisc(card) then
					badges[#badges+1] = create_badge("Crazy Women", G.C.RED, G.C.UI.TEXT_LIGHT, 0.8 )
				end
			end,
			
			--[[
			knifeCard = function(card)
				G.E_MANAGER:add_event(Event({
					trigger = 'after',
					delay = 1.25,
					blocking = false,
					blockable = true,
					func = function()
						card.children.knifeSprite = Sprite(
							card.children.center.T.x, card.children.center.T.y, -- Sprite X & Y
							card.children.center.T.w, card.children.center.T.w, -- Sprite W & H
							CirnoMod.miscItems.otherAtlases.cardKnifeStab, -- Sprite Atlas
							{ x = 0, y = 0 } -- Position in the Atlas
						)
						
						G.E_MANAGER:add_event(Event({
							trigger = 'immediate',
							blocking = false,
							blockable = false,
							func = function()
								if
									card
									and card.children
									and card.children.knifeSprite
								then									
									if card.children.knifeSprite.T.y ~= card.children.center.T.y then
										card.children.knifeSprite.T.y = card.children.center.T.y
									end									
									
									return false
								end
								return true								
							end}))
						
						return true
					end}))
			end,
			]]
			
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
						context.other_card
						and not context.other_card.markedForDestroy
						and context.individual
					then
						if pseudorandom('mitaKill') < G.GAME.probabilities.normal/card.ability.extra.odds then
							context.other_card.markedForDestroy = true
							return {
								message = '  ',
								colour = G.C.RED,
								message_card = context.other_card,
								func = CirnoMod.miscItems.attachSpriteToCard(context.other_card, CirnoMod.miscItems.otherAtlases.cardKnifeStab, { x = 0, y = 0 }, 1.5, true),
								sound = 'gold_seal'
							}
						else
							return {
								message = localize('k_safe_ex'),
								colour = G.C.GREEN,
								message_card = context.other_card
							}
						end
					end
					
					if
						context.destroy_card
						and context.destroy_card.markedForDestroy
					then
						return {
							remove = true
						}
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
					"related to {C:attention}"..CirnoMod.miscItems.getJokerNameByKey('j_bootstraps', '{C:red}Not Active{}').."{},",
					"{C:attention}2 max{} or {C:attention}cirGuns{}",
					"{C:inactive}(Currently {X:mult,C:white}X#2#{C:inactive} Mult)",
					"{s:0.8,C:inactive}"..CirnoMod.miscItems.getJokerNameByKey('j_bootstraps', '{s:0.8,C:red}Not Active{}')..", 2 max, cirGuns.",
					"{s:0.8,C:inactive}"..CirnoMod.miscItems.getJokerNameByKey('j_bootstraps', '{s:0.8,C:red}Not Active{}')..", 2 max, cirGuns.",
					"{s:0.8,C:inactive}"..CirnoMod.miscItems.getJokerNameByKey('j_bootstraps', '{s:0.8,C:red}Not Active{}')..", 2 max, cirGuns.",
					"{s:0.8,C:inactive}THIS COMMUNITY ONLY HAS THREE JOKES?!",
					"{s:0.5,C:inactive}Chat gets a little bully too, as a treat."
				},
				unlock = {
					"?????"
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
			loc_vars = function(self, info_queue, center)
				self.updateCurMult(center.ability.extra)
				
				info_queue[#info_queue + 1] = CirnoMod.miscItems.descExtensionTooltips['eDT_cir_allegations']
				
				info_queue[#info_queue + 1] = CirnoMod.miscItems.descExtensionTooltips['eDT_cir_2max']
				
				info_queue[#info_queue + 1] = CirnoMod.miscItems.descExtensionTooltips['eDT_cir_Guns']
				
				--[[ Art credit tooltip
				if CirnoMod.config['artCredits'] then
					info_queue[#info_queue + 1] = { key = "", set = "Other" }
				end]]
				
				return { vars = { center.ability.extra.growth, center.ability.extra.xmult } }
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
					"three {C:attention}crazy women{}."
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
			end,
			
			blueprint_compat = true,
			loc_vars = function(self, info_queue, center)
				self.updateCurMult(center.ability.extra)
				
				info_queue[#info_queue + 1] = CirnoMod.miscItems.descExtensionTooltips['eDT_cir_crazyWomen']
				
				--[Art credit tooltip
				if CirnoMod.config['artCredits'] then
					info_queue[#info_queue + 1] = { key = "jA_NTF", set = "Other" }
				end
				
				return { vars = { center.ability.extra.growth, center.ability.extra.xmult } }
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
		}
	}
}

return jokerInfo