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
					and not context.post_trigger
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
					and not context.post_trigger
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
		}
	}
}

return jokerInfo