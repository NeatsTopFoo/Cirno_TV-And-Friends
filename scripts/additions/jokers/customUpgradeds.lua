if CirnoMod.config.addCustomConsumables then
	CirnoMod.miscItems.upgradedJkrRarity = SMODS.Rarity{
		key = 'UpgradedJkr',
		loc_txt = { name = 'Upgraded' },
		badge_colour = CirnoMod.miscItems.colours.cirUpgradedJkrClr,
		pools = {}
	}

	CirnoMod.miscItems.obscurePerfectionismNameUnlessDiscovered = function()
		if CirnoMod.miscItems.isUnlockedAndDisc(G.P_CENTERS.c_cir_sPerfectionism_l) then
			return 'Perfectionism'
		end
		
		return localize('k_unknown')
	end
end
	
local rarityClr = {
	['upgCmn'] = G.C.RARITY[1],
	['upgUncmn'] = G.C.RARITY[2],
	['upgRare'] = G.C.RARITY[3],
	['upgLgnd'] = G.C.RARITY[4]
}

local jokerInfo = {
	isMultipleJokers = true,
	
	dependenciesForAddition = function()
		return CirnoMod.config.addCustomConsumables
	end,
	
	-- Defines the Atlas
	atlasInfo = {
		key = 'cir_cUpgraded',
		path = "Additional/cir_custUpgraded.png",
		px = 71,
		py = 95
	},
	
	--[[ TODO:
		- Whatever I name the Bootstraps upgrade
		- Whatever I name the Blackboard upgrade
		- God Gamer (Sixth Sense)
		- Baldi (Red Card)
		- Dark Bead (Madness/Soul Spear) - No Joker kill
		- Lava Chicken (Chicken Jockey/Luchador)
		- Horse Gacha (Idolmaster Gacha/Mail-In Rebate)
		- Cirno Duty (Imaginary Anomaly/Hallucination)
		- Perfect Body Double (Devious Doppelganger) - Original Effect + Death Save
		- Collection (Baseball Card) - Different bonuses per owned Jokers dependant on rarity
		- Cirno_TV & Friends (Bully)
		- Cokeman (Pepsiman/Diet Soda) - Regular Double Tags
		- Sattaton (SachikoPants/Spare Trousers)
		- Haurchefant (Smiley Face)
		- Dev Backseating (Hack)
		- Yayoi Akikawa (Tazuna Hayakawa) - Guaranteed Soul in next spectral/arcana pack, destroyed when Soul is used
	]]
	jokerConfigs = {
		-- The Villainess
		{
			key = 'villainess',
			upgradesFrom = 'j_caino', -- (sic)
			
			matureRefLevel = 1,
			loadOrder = 'upgLgnd',
			cir_Friend = CirnoMod.miscItems.cirFriends.dm,
			
			destroyed = { colours = { G.C.GREEN, CirnoMod.miscItems.colours.dmDark, G.C.MONEY, CirnoMod.miscItems.colours.dmDark, G.C.GREEN } },
			
			loc_txt = { name = 'The Villainess', text = { {
						'This {C:joker}Joker{} gains {X:mult,C:white} X#1# {} Mult when',
						'a {C:attention}face{} card is destroyed',
						'{C:inactive}(Currently {X:mult,C:white} X#2# {C:inactive} Mult)'
					}, {
						'Destroyed face cards, if not',
						'{C:dark_edition}Negative{}, have a {C:green}#3# in #4#{} chance',
						'to create a {C:dark_edition}Negative{} version',
						'{s:0.8}({s:0.8,C:green}#3# in #5#{s:0.8} chance for {s:0.8,C:attention}Queens{s:0.8} of {s:0.8,C:diamonds_hc}Diamonds{s:0.8})',
						' ',
						'If created during a blind,',
						'card is drawn to {C:attention}hand'
					}, {
						'Each {C:attention}Queen{} of {C:diamonds_hc}Diamonds',
						'held in hand gives {X:mult,C:white} X#6# {} Mult',
						'{s:0.8,C:inactive}The "DM" stands for {s:0.8,C:inactive,E:1}"#7#"'
					}
				}
			},
			
			abiInit = function(card, orgRarity)
				card.ability.extra = {
					originalRarity = orgRarity,
					growth = to_big(1),
					odds = 3,
					oddsDM = 2,
					heldDM = 2,
					dmStandsFor = {
						'direct message',
						'delicious mayo',
						'd-yume m-joshi',
						'devouring manhwa',
						'diatomaceous mars',
						'digiorno mozzarella',
						'drinkin\' m\'sludge',
						'defenestration machine',
						'deliver money (for backseating)',
						'dedicated monk',
						'dial management',
						'Detective Mischief',
						'ding! microwave',
						'daily malaise',
						'damage modifier',
						'dieletric material',
						'designated messenger',
						'drinking milk (in the form of cheese)'
					}
				}
			end,
			
			postPerfInit = function(self, card, orgRarity, orgExtTable, orgAbilityTbl)
				self.abiInit(card, orgRarity)
				
				card.ability.extra_value = CirnoMod.miscItems.upgradedExtraValue[orgRarity]
				card:set_cost()
			end,
			
			blueprint_compat = true,
			loc_vars = function(self, info_queue, card)
				info_queue[#info_queue + 1] = { key = 'e_negative_playing_card',
					set = 'Edition',
					config = { extra = 1 },
					vars = { 1,
						G.localization.descriptions.Joker.j_splash.name,
						string.sub(G.localization.descriptions.Enhanced.m_stone.name, 1, #G.localization.descriptions.Enhanced.m_stone.name - 5)
					} }
				
				if CirnoMod.config.artCredits and not card.fake_card then
					info_queue[#info_queue + 1] = { key = "jA_DM", set = "Other" }
				end
				
				if
					not card.ability.extra
					or type(card.ability.extra) ~= 'table'
				then
					self.abiInit(card, 4)
				end
				
				local numerator, denominator = SMODS.get_probability_vars(card or self, 1, card.ability.extra.odds)
				
				return { vars = {
						to_big(card.ability.extra.growth),
						to_big(card.ability.caino_xmult),
						numerator,
						denominator,
						card.ability.extra.oddsDM,
						to_big(card.ability.extra.heldDM),
						pseudorandom_element(card.ability.extra.dmStandsFor)
					} }
			end,
			
			pos = { x = 0, y = 0 }, -- Defines base card graphic position in the atlas.
			soul_pos = { x = 0, y = 1 }, -- Defines where this card's soul overlay is in the given atlas
			cost = 30, -- Sell value (half of this value), since Upgraded Jokers only appear via Perfectionism spectral cards.
			eternal_compat = true,
			perishable_compat = false,
			
			cir_upgradeInfo = function(self, card)
				return {
					'{X:mult,C:white}X'..to_big(card.ability.extra.growth)..'{} Mult scaling',
					'->',
					'{X:mult,C:white}X'..to_big(card.ability.extra.growth) + to_big(1)..'{} Mult scaling'
				}
			end,
			
			cir_upgrade = function(self, card)
				card.ability.extra.growth = to_big(card.ability.extra.growth) * to_big(2)
				
				return { message = localize('k_upgrade_ex'), colour = CirnoMod.miscItems.colours.cirDM }
			end,
			
			calculate = function(self, card, context)
				if context.remove_playing_cards then
					local face_cards = {}
					
					for i, removed_card in ipairs(context.removed) do
						if removed_card:is_face() then table.insert(face_cards, removed_card) end
					end
					
					if #face_cards > 0 then
						SMODS.scale_card(card, {
							ref_table = card.ability,
							ref_value = 'caino_xmult',
							operation = function(ref_table, ref_value, initial, change)
								ref_table[ref_value] = to_big(initial) + to_big(#face_cards) * to_big(change)
							end,
							scalar_table = card.ability.extra,
							scalar_value = 'growth',
							no_message = true
						})
						
						local jkrRef = card
						
						return { message = localize{ type = 'variable', key = 'a_xmult', vars = { to_big(card.ability.caino_xmult) } },
						colour = CirnoMod.miscItems.colours.cirDM,
							func = function()
								for i, faceCard in ipairs(face_cards) do
									if
										not (faceCard.edition
										and faceCard.edition.type == 'negative')
									then
										local createNegativeOdds = card.ability.extra.odds
										
										if
											faceCard:get_id() == 12
											and faceCard:is_suit('Diamonds')
										then
											createNegativeOdds = card.ability.extra.oddsDM
										end
										
										if SMODS.pseudorandom_probability(faceCard, 'makeNegativeFace', 1, createNegativeOdds) then
											G.E_MANAGER:add_event(Event({
												trigger = 'immediate',
												blocking = true,
												blockable = true,
												func = function()
													G.playing_card = (G.playing_card and G.playing_card + 1) or 1
													local copy = copy_card(faceCard, nil, nil, G.playing_card)
													
													copy:set_edition('e_negative')
													
													copy:add_to_deck()
													
													G.deck.config.card_limit = G.deck.config.card_limit + 1
													table.insert(G.playing_cards, copy)
													G.hand:emplace(copy)
													
													copy.states.visible = nil
													
													copy:start_materialize()
													
													SMODS.calculate_effect({ message = localize('k_copied_ex'), colour = CirnoMod.miscItems.colours.cirDM }, faceCard)
													SMODS.calculate_context({ playing_card_added = true, cards = { copy } })
												return true
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
														major = faceCard,
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
													faceCard:juice_up(0.3, 0.5)
												return true 
												end }))
										end
									end
								end
							end
						}
					end
				end
				
				if context.joker_main then
					return { x_mult = to_big(card.ability.caino_xmult), colour = CirnoMod.miscItems.colours.cirDM }
				end
				
				if
					context.individual
					and not context.end_of_round
					and context.cardarea == G.hand
					and context.other_card:is_suit('Diamonds')
					and context.other_card:get_id() == 12
				then
					if context.other_card.debuff then
						return {
							doNotRedSeal = true,
							no_retrigger = true,
							message = localize('k_debuffed'),
							colour = G.C.RED,
							sound = 'cancel'
						}
					else
						return { x_mult = to_big(card.ability.extra.heldDM), colour = CirnoMod.miscItems.colours.cirDM }
					end
				end
			end
		},
		-- The Baka
		{
			key = 'baka',
			upgradesFrom = 'j_cir_cirno_l',
			
			matureRefLevel = 1,
			loadOrder = 'upgLgnd',
			cir_Friend = CirnoMod.miscItems.cirFriends.cir,
			
			destroyed = { colours = { G.C.BLUE, CirnoMod.miscItems.colours.cirCyan, G.C.BLACK, CirnoMod.miscItems.colours.cirCyan, G.C.BLUE } },
			
			loc_txt = { name = 'The Baka', text = { {
					'This {C:joker}Joker{} gains {X:chips,C:white}X#1#{} Chips',
					'for each played {C:attention}9{}',
					'{s:0.8,C:red}If {s:0.8,C:attention}#2#{s:0.8,C:red} is present, it',
					'{s:0.8,C:red}expires after the first trigger.',
					'{C:inactive}(Currently {X:chips,C:white}X#3# {C:inactive} Chips)'
					}, {
					'For every two {C:attenton}9s{} in scoring hand,',
					'Create one {C:dark_edition}Negative{C:tarot} #4#'
					}, {
					'After beating a boss blind, has a {C:green}#5# in #6#',
					'chance of creating a {C:dark_edition}Negative{C:attention} #7#{}',
					'or a {C:dark_edition}Negative{C:attention} #8#{}',
					'{s:0.8}(But only if #9# has gone extinct first)',
					'{s:0.8,C:inactive}"We\'re free now.',
					'{s:0.8,C:inactive}And that\'s poggers."'
				} }
			},
			
			abiInit = function(card, orgRarity, orgExtTable, orgAbilityTbl)
				card.ability.extra = orgExtTable
				
				if
					not card.ability.extra
					and orgAbilityTbl
					and type(orgAbilityTbl) == 'table'
					and orgAbilityTbl.extra
				then
					card.ability.extra = orgAbilityTbl.extra
				end
				
				card.ability.extra.originalRarity = orgRarity
				card.ability.extra.odds = 4
				card.ability.extra.nineCounter = 0
			end,
			
			postPerfInit = function(self, card, orgRarity, orgExtTable, orgAbilityTbl)
				self.abiInit(card,orgRarity, orgExtTable, orgAbilityTbl)
				
				card.ability.extra_value = CirnoMod.miscItems.upgradedExtraValue[orgRarity]
				card:set_cost()
			end,
			
			blueprint_compat = true,
			loc_vars = function(self, info_queue, card)
				info_queue[#info_queue + 1] = CirnoMod.miscItems.obscureJokerTooltipIfNotEncountered('j_ice_cream', true)
				
				info_queue[#info_queue + 1] = { key = 'c_fool', set = 'Tarot', config = { } }
				
				info_queue[#info_queue + 1] = CirnoMod.miscItems.obscureJokerTooltipIfNotEncountered('j_dusk', true)
				
				info_queue[#info_queue + 1] = CirnoMod.miscItems.obscureJokerTooltipIfNotEncountered('j_cavendish', true)
				
				if CirnoMod.config.artCredits and not card.fake_card then
					info_queue[#info_queue + 1] = { key = "jA_NTF", set = "Other" }
				end
				
				if
					not card.ability.extra
					or type(card.ability.extra) ~= 'table'
				then
					self.abiInit(card, 4, { growth = 0.09, xchips = 1 })
				end
				
				local numerator, denominator = SMODS.get_probability_vars(card or self, 1, card.ability.extra.odds)
				
				return { vars = {
						to_big(card.ability.extra.growth), 
						CirnoMod.miscItems.obscureJokerNameIfNotEncountered('j_ice_cream'), 
						to_big(card.ability.extra.xchips),
						G.localization.descriptions.Tarot.c_fool.name,
						numerator,
						denominator,
						CirnoMod.miscItems.obscureJokerNameIfNotEncountered('j_dusk'),
						CirnoMod.miscItems.obscureJokerNameIfNotEncountered('j_cavendish'),
						CirnoMod.miscItems.obscureJokerNameIfNotEncountered('j_gros_michel')
					} }
			end,
			
			pos = { x = 1, y = 0 },
			soul_pos = { x = 1, y = 1 },
			cost = 30,
			eternal_compat = true,
			perishable_compat = false,
			
			cir_upgradeInfo = function(self, card)
				return {
					'{X:chips,C:white}X'..to_big(card.ability.extra.growth)..'{} Chips scaling',
					'->',
					'{X:chips,C:white}X'..to_big(card.ability.extra.growth) + to_big(0.09)..'{} Chips scaling'
				}
			end,
			
			cir_upgrade = function(self, card)
				card.ability.extra.growth = to_big(card.ability.extra.growth) + to_big(0.09)
				
				return { message = localize('k_upgrade_ex'), colour = CirnoMod.miscItems.colours.cirNo }
			end,
			
			calculate = function(self, card, context)
				if
					context.end_of_round
					and context.main_eval
					and not context.blueprint
				then
					card.ability.extra.nineCounter = 0
					
					if context.beat_boss then
						if SMODS.pseudorandom_probability(card, 'duskOrCavendish', 1, card.ability.extra.odds) then
							local targetKey = 'j_dusk'
						
							if
								G.GAME.pool_flags.vremade_gros_michel_extinct
								and math.random() < 0.5
							then
								targetKey = 'j_cavendish'
							end
							
							return { no_juice = true, func = function()
									SMODS.add_card({ key = targetKey, edition = 'e_negative' })
									play_sound('generic1')
									card:juice_up()							
								end }
						else
							local jkrRef = card
							
							return { func = function()
									attention_text({
										text = localize('k_nope_ex'),
										scale = 1.3,
										hold = 1.4,
										major = jkrRef,
										backdrop_colour = CirnoMod.miscItems.colours.cirNo,
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
									jkrRef:juice_up(0.3, 0.5)
								end }
						end
					end
				end
				
				if context.joker_main then
					return {
						x_chips = to_big(card.ability.extra.xchips),
						colour = CirnoMod.miscItems.colours.cirNo,
						card = card
					}
				end
				
				if
					context.individual
					and (context.cardarea == G.play
					or context.cardarea == 'unscored')
					and not context.post_trigger
				then
					if
						context.other_card:can_calculate()
						and context.other_card:get_id() == 9
					then
						if context.cardarea == G.play then
							card.ability.extra.nineCounter = card.ability.extra.nineCounter or 0
							card.ability.extra.nineCounter = card.ability.extra.nineCounter + 1
							
							if card.ability.extra.nineCounter >= 2 then
								card.ability.extra.nineCounter = 0
								
								local jkrRef = card
								
								G.E_MANAGER:add_event(Event({
									trigger = 'after',
									delay = 0.8,
									blocking = false,
									blockable = true,
									func = function()
										SMODS.add_card({ key = 'c_fool', edition = 'e_negative' })
										play_sound('generic1')
										jkrRef:juice_up()
										return true
									end}))
							end
						end
						
						SMODS.scale_card(card, {
							ref_table = card.ability.extra,
							ref_value = 'xchips',
							scalar_value = 'growth',
							no_message = true
						})
						
						return {
							extra = { 
								message = localize {
									type = 'variable',
									key = 'a_xchips',
									vars = { to_big(card.ability.extra.xchips) }
								},
								colour = CirnoMod.miscItems.colours.cirNo,
								message_card = card
							}
						}
					end
				end
				
				if
					not context.blueprint
					and context.post_trigger
					and not context.retrigger_joker
					and context.other_context.joker_main
					and context.other_card
					and context.other_card.config.center.key == 'j_ice_cream'
				then
					return {
						message_card = context.other_card,
						message = "Dropped!",
						delay = 1.5,
						colour = G.C.RED,
						sound = 'cir_j_matchaDrop',
						pitch = 1.0,
						func = self.dropIceCream(context.other_card)
					}
				end
			end
		},
		-- The Captain
		{
			key = 'captain',
			upgradesFrom = 'j_triboulet',
			
			matureRefLevel = 1,
			loadOrder = 'upgLgnd',
			cir_Friend = CirnoMod.miscItems.cirFriends.han,
			
			destroyed = { colours = { G.C.PURPLE, CirnoMod.miscItems.colours.hanDark, G.C.BLACK, CirnoMod.miscItems.colours.hanDark, G.C.PURPLE } },
			
			loc_txt = { name = 'The Captain', text = { {
					'Played {C:attention}Kings{} and',
                    '{C:attention}Queens{} each give',
                    '{X:mult,C:white} X#1# {} Mult when scored'
					}, {
					'{C:attention}#2#s',
					'always score, and',
					'grow by {C:money}#3#{}',
					'{s:0.8}If not debuffed'
					}, {
					'If the played hand',
                    'only contains',
                    '{C:attention}Kings{} of {C:hearts_hc}Hearts{}, the',
					'{X:mult,C:white}XMult{} given by',
					'played {C:attention}Kings{} and',
                    '{C:attention}Queens{} increases by',
					'{X:mult,C:white} X#4# {}, additionally',
                    'played {C:attention}Kings{} of {C:hearts_hc}Hearts',
					'give {C:money}#5#',
					'{s:0.8,C:inactive}Hannah, the clock on',
					'{s:0.8,C:inactive}the microwave is wrong'
				} }
			},
			
			abiInit = function(card, orgRarity, orgExtTable)
				card.ability.extra = {}
				card.ability.extra.x_mult = orgExtTable
				card.ability.extra.growth = 0.25
				card.ability.extra.dGrowth = 1
				card.ability.extra.KoH_dollars = 1
				card.ability.extra.originalRarity = orgRarity
			end,
			
			postPerfInit = function(self, card, orgRarity, orgExtTable, orgAbilityTbl)
				self.abiInit(card, orgRarity, orgExtTable)
				
				card.ability.extra_value = CirnoMod.miscItems.upgradedExtraValue[orgRarity]
				card:set_cost()
			end,
			
			blueprint_compat = true,
			loc_vars = function(self, info_queue, card)
				info_queue[#info_queue + 1] = G.P_CENTERS.m_gold
				
				if CirnoMod.config.artCredits and not card.fake_card then
					info_queue[#info_queue + 1] = { key = "jA_Hannah", set = "Other" }
				end
				
				if
					not card.ability.extra
					or type(card.ability.extra) ~= 'table'
				then
					self.abiInit(card, 4, 2)
				end
				
				return { vars = {
						to_big(card.ability.extra.x_mult),
						G.localization.descriptions.Enhanced.m_gold.name,
						SMODS.signed_dollars(to_big(card.ability.extra.dGrowth)),
						to_big(card.ability.extra.growth),
						SMODS.signed_dollars(to_big(card.ability.extra.KoH_dollars))
					} }
			end,
			
			pos = { x = 2, y = 0 },
			soul_pos = { x = 2, y = 1 },
			cost = 30,
			eternal_compat = true,
			perishable_compat = false,
			
			cir_upgradeInfo = function(self, card)
				return {
					'{C:attention}'..G.localization.descriptions.Enhanced.m_gold.name..'s{} grow by',
					'{C:money}'..SMODS.signed_dollars(to_big(card.ability.extra.dGrowth)),
					'->',
					'{C:attention}'..G.localization.descriptions.Enhanced.m_gold.name..'s{} grow by',
					'{C:money}'..SMODS.signed_dollars(to_big(card.ability.extra.dGrowth) + to_big(1)),
				}
			end,
			
			cir_upgrade = function(self, card)
				card.ability.extra.dGrowth = to_big(card.ability.extra.dGrowth) + to_big(1)
				
				return { message = localize('k_upgrade_ex'), colour = G.C.MONEY }
			end,
			
			calculate = function(self, card, context)
				if
					context.setting_ability
					and context.unchanged
					and context.new == 'm_gold'
					and context.other_card.ability.h_dollars < context.old_ability.h_dollars
				then
					context.other_card.ability.h_dollars = context.old_ability.h_dollars
				end
				
				if
					context.modify_scoring_hand
					and context.main_eval
					and not context.retrigger_joker
					and not context.retrigger_joker_check
					and not context.blueprint
					and context.other_card
					and context.other_card:can_calculate()
				then
					local add = SMODS.has_enhancement(context.other_card, 'm_gold')
					
					if not add then
						local midasMask = SMODS.find_card('j_midas_mask')
						
						if next(midasMask) and midasMask[1]:can_calculate() then
							add = context.other_card:is_face()
						end
					end
					
					if add then
						return { doNotRedSeal = true, add_to_hand = true }
					end
				end
				
				if context.before then
					local upgMult = true
					
					for i, c in ipairs(context.full_hand) do
						if
							not c:is_suit('Hearts')
							or c:get_id() ~= 13
						then
							upgMult = false
							break
						end
					end
					
					if upgMult then
						SMODS.scale_card(card, {
							ref_table = card.ability.extra,
							ref_value = 'x_mult',
							scalar_value = 'growth',
							no_message = true
						})
						
						return {
							extra = { 
								message = localize {
									type = 'variable',
									key = 'a_xmult',
									vars = { to_big(card.ability.extra.x_mult) }
								},
								delay = 1.5,
								colour = CirnoMod.miscItems.colours.cirHan,
								message_card = card
							}
						}
					end
				end
				
				if
					context.individual
					and context.cardarea == G.play
				then
					local RT = { colour = CirnoMod.miscItems.colours.cirHan }
					
					if SMODS.has_enhancement(context.other_card, 'm_gold') then
						
						SMODS.scale_card(context.other_card, {
							ref_table = context.other_card.ability,
							ref_value = 'h_dollars',
							scalar_table = card.ability.extra,
							scalar_value = 'dGrowth',
							no_message = true
						})
						
						RT.extra = {
							message = localize('k_upgrade_ex'),
							colour = G.C.MONEY,
							sound = 'coin'..pseudorandom('dolSnd', 1, 5),
							message_card = context.other_card
						}
					end
					
					if
						context.other_card:get_id() == 13
						or context.other_card:get_id() == 12
					then
						RT.x_mult = to_big(card.ability.extra.x_mult)
						
						if
							context.other_card:get_id() == 13
							and context.other_card:is_suit('Hearts')
						then
							RT.dollars = to_big(card.ability.extra.KoH_dollars)
						end
					end
					
					if next(RT) then
						return RT
					end
				end
			end
		},
		-- The Comfy Vibes
		{
			key = 'comfyVibes',
			upgradesFrom = 'j_cir_naro_l',
			
			matureRefLevel = 1,
			loadOrder = 'upgLgnd',
			cir_Friend = CirnoMod.miscItems.cirFriends.nrp,
			
			destroyed = { colours = { G.C.RED, CirnoMod.miscItems.colours.cirNep, G.C.BLACK, CirnoMod.miscItems.colours.cirNep, G.C.BLUE } },
			
			loc_txt = { name = 'The Comfy Vibes', text = { {
					'This {C:joker}Joker{} gains {X:mult,C:white} X#1# ',
					'Mult for every {C:cirNep}#2#',
					'used this run,',
					'and {X:mult,C:white} X#3# {} Mult for',
					'other {C:planet}#4#{} cards',
					'{C:inactive}(Currently {X:mult,C:white} X#5# {C:inactive} Mult)'
					}, {
					'If the played hand',
                    'only contains',
                    '{C:attention}Kings{} of {C:clubs_hc}Clubs{},',
					'create a random',
					'{C:dark_edition}Negative{C:planet} #4#{} card',
					'{s:0.8,C:inactive}Come get your churros!'
				} }
			},
			
			abiInit = function(card, orgRarity, orgExtTable, orgAbilityTbl)
				card.ability.extra = orgExtTable
				
				if
					not card.ability.extra
					and orgAbilityTbl
					and type(orgAbilityTbl) == 'table'
					and orgAbilityTbl.extra
				then
					card.ability.extra = orgAbilityTbl.extra
				end
				
				card.ability.extra.soulY = card.ability.extra.soulX + 1
				card.ability.extra.soulX = nil
				card.ability.extra.originalRarity = orgRarity
				card.ability.extra.extraPlanet = 0.5
				card.ability.extra.otherPlanetNames = {}
				
				for k, tbl in pairs(G.localization.descriptions.Planet) do
					if k ~= 'c_neptune' then
						card.ability.extra.otherPlanetNames[k] = true
					end
				end
			end,
			
			postPerfInit = function(self, card, orgRarity, orgExtTable, orgAbilityTbl)
				self.abiInit(card, orgRarity, orgExtTable, orgAbilityTbl)
				
				card.ability.extra_value = CirnoMod.miscItems.upgradedExtraValue[orgRarity]
				card:set_cost()
				
				self.cir_updateState(card)
			end,
			
			blueprint_compat = true,
			loc_vars = function(self, info_queue, card)
				if
					not card.ability.extra
					or type(card.ability.extra) ~= 'table'
				then
					self.abiInit(card, 4, { extra = 1, soulX = 1 })
				end
				
				local RT = { vars = {
					to_big(card.ability.extra.extra),
					G.localization.descriptions.Planet.c_neptune.name,
					to_big(card.ability.extra.extraPlanet),
					G.localization.misc.labels.planet,
					self.calcXMult(card)
				} }
				
				info_queue[#info_queue + 1] = { key = 'c_neptune', set = 'Planet', config = { hand_type = 'Straight Flush' } }
				
				info_queue[#info_queue + 1] = { key = 'e_negative_consumable', set = 'Edition', config = { extra = 1 } }
				
				-- Art credit tooltip
				if CirnoMod.config.artCredits and not card.fake_card then
					if card.ability.extra.soulY == 1 then
						info_queue[#info_queue + 1] = { key = 'jA_Naro', set = 'Other' }
					else
						info_queue[#info_queue + 1] = { key = 'jA_IF_NTF', set = 'Other' }
					end
				end
				
				return RT
			end,
			
			pos = { x = 3, y = 0 },
			soul_pos = { x = 3, y = 1 },
			cost = 30,
			eternal_compat = true,
			perishable_compat = false,
			
			cir_updateState = function(jkr)
				if
					jkr.ability
					and jkr.children
				then
					if -- If the soul_pos is not what I want it to be. I make it what I wnt it to be.
						jkr.config.center.soul_pos.y ~= jkr.ability.extra.soulY
					then
						jkr.config.center.soul_pos.y = jkr.ability.extra.soulY
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
			
			calcXMult = function(card)
				local xMult = 1
				
				if
					G.GAME.consumeable_usage.c_neptune
					and G.GAME.consumeable_usage.c_neptune.count
				then
					xMult = to_big(xMult) + (to_big(G.GAME.consumeable_usage.c_neptune.count) * to_big(card.ability.extra.extra))
				end
				
				for k, tbl in pairs(G.GAME.consumeable_usage) do
					if card.ability.extra.otherPlanetNames[k] then
						xMult = to_big(xMult) + (to_big(tbl.count) * to_big(card.ability.extra.extraPlanet))
					end
				end
				
				return xMult
			end,
			
			cir_upgradeInfo = function(self, card)
				return {
					'Create 2 free',
					'{C:tarot}'..G.localization.descriptions.Tag.tag_meteor.name..'s',
					'{s:0.8,C:inactive}2 max'
				}
			end,
			
			cir_upgrade = function(self, card)
				for i = 1, 2 do
					add_tag(Tag('tag_meteor'))
				end
				
				card:juice_up()
				play_sound('generic1')
			end,
			
			calculate = function(self, card, context)
				if context.before then
					local makePlanet = true
					
					for i, c in ipairs(context.full_hand) do
						if
							not c:is_suit('Clubs')
							or c:get_id() == 13
						then
							makePlanet = false
							break
						end
					end
					
					if makePlanet then
						return { func = function()
							card:juice_up()
							play_sound('generic1')
							SMODS.add_card({ set = 'Planet', edition = 'e_negative' })
						end }
					end
				end
				
				if
					context.cardarea == G.jokers -- If we are iterating through owned jokers
					and	context.joker_main -- If the context is during the main scoring timing of jokers
					and G.GAME.consumeable_usage -- And global consumeable usage exists
				then					
					return { -- Multiply the current mult by mult accrued on card?
						x_mult = self.calcXMult(card), -- Multiplies the current mult by the desired amount
						colour = CirnoMod.miscItems.colours.cirNaro
					}, true
				elseif
					not context.blueprint
					and context.consumeable
					and G.GAME.consumeable_usage
					and not context.retrigger_joker
				then
					if
						context.consumeable.ability.set == 'Planet'
					then
						return { -- Multiply the current mult by mult accrued on card?
							extra = {
								message = localize(
								{
									type = "variable",
									key = "a_xmult",
									vars = { self.calcXMult(card) }
								}),
								delay = 1.5,
								colour = CirnoMod.miscItems.colours.cirNaro,
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
					local newY = pseudorandom('naroSpriteChange', 1, 2)
					
					if card.ability.extra.soulY ~= newY then
						card.ability.extra.soulY = newY
						
						card:juice_up()
						self.change_soul_pos(card, { x = 3, y = card.ability.extra.soulY})
					end
				end
			end
		},
		-- The Enthusiast
		{
			key = 'enthusiast',
			upgradesFrom = 'j_yorick',
			
			matureRefLevel = 1,
			loadOrder = 'upgLgnd',
			cir_Friend = CirnoMod.miscItems.cirFriends.thr,
			
			destroyed = { colours = { G.C.MONEY, CirnoMod.miscItems.colours.cirInactiveAtt, G.C.BLACK, CirnoMod.miscItems.colours.cirInactiveAtt, G.C.MONEY } },
			
			loc_txt = { name = 'The Enthusiast', text = { {
					'This {C:joker}Joker{} gains',
                    '{X:mult,C:white} X#1# {} Mult every {C:attention}#2#{C:inactive} [#3#]{}',
                    'cards discarded',
                    '{C:inactive}(Currently {X:mult,C:white} X#4# {C:inactive} Mult)'
					}, {
					'Earn {C:money}#5#{}',
					'at end of round',
					'per {C:attention}King{} of {C:diamonds_hc}Diamonds',
					'scored this round',
					'{C:inactive}(Currently {C:money}#6#{C:inactive})'
					}, {
					'Played {C:attention}face cards',
					'have a {C:green}#7# in #8#{} chance',
					'to retrigger and a',
					'{C:green}#7# in #9#{} chance',
					'to be returned to hand',
					'{s:0.8,C:inactive}\"Chat, do you know',
					'{s:0.8,C:inactive}what \'rizz\' is?"'
				} }
			},
			
			abiInit = function(card, orgRarity, orgAbilityTbl, orgExtTable)
				card.ability.x_mult = orgAbilityTbl.x_mult
				card.ability.extra = orgExtTable
				
				if
					not card.ability.extra
				then
					if
						orgAbilityTbl
						and type(orgAbilityTbl) == 'table'
						and orgAbilityTbl.extra
					then
						card.ability.extra = orgAbilityTbl.extra
					else
						card.ability.extra = { discards = 0 }
					end
				end
				
				card.ability.extra.xmult = 2
				card.ability.extra.EoR_dollars = 0
				card.ability.extra.KoD_dollarsEarn = 1
				card.ability.extra.retrigger_odds = 3
				card.ability.extra.redraw_odds = 4
				card.ability.extra.originalRarity = orgRarity
			end,
			
			postPerfInit = function(self, card, orgRarity, orgExtTable, orgAbilityTbl)
				self.abiInit(card, orgRarity, orgAbilityTbl, orgExtTable)
				
				card.ability.extra_value = CirnoMod.miscItems.upgradedExtraValue[orgRarity]
				card:set_cost()
			end,
			
			blueprint_compat = true,
			loc_vars = function(self, info_queue, card)
				if
					not card.ability.extra
					or type(card.ability.extra) ~= 'table'
				then
					self.abiInit(card, 4, { x_mult = 1 }, { discards = 0 })
				end
				
				local RT = { vars = {
					to_big(card.ability.extra.xmult),
					card.ability.extra.discards,
					card.ability.yorick_discards,
					to_big(card.ability.x_mult),
					SMODS.signed_dollars(to_big(card.ability.extra.KoD_dollarsEarn)),
					card.ability.extra.EoR_dollars > 0 and SMODS.signed_dollars(to_big(card.ability.extra.EoR_dollars)) or '$0'
				} }
				
				local numerator, denominator = SMODS.get_probability_vars(card or self, 1, card.ability.extra.retrigger_odds)
				
				local numerator2, denominator2 = SMODS.get_probability_vars(card or self, 1, card.ability.extra.redraw_odds)
				
				RT.vars[7] = numerator
				RT.vars[8] = denominator
				RT.vars[9] = denominator2
				
				-- Art credit tooltip
				if CirnoMod.config.artCredits and not card.fake_card then
					info_queue[#info_queue + 1] = { key = 'jA_DaemonTsun_BigNTFEdit', set = 'Other' }
				end
				
				return RT
			end,
			
			pos = { x = 4, y = 0 },
			soul_pos = { x = 4, y = 1 },
			cost = 30,
			eternal_compat = true,
			perishable_compat = false,
			
			calc_dollar_bonus = function(self, card, context)
				if to_big(card.ability.extra.EoR_dollars) > 0 then
					return to_big(card.ability.extra.EoR_dollars)
				end
			end,
			
			cir_upgradeInfo = function(self, card)
				return {
					'{X:mult,C:white}X'..to_big(card.ability.extra.xmult)..'{} Mult scaling',
					'{C:money}'..SMODS.signed_dollars(to_big(card.ability.extra.KoD_dollarsEarn))'{} at end of round',
					'for scored  {C:attention}Kings{} of {C:diamonds_hc}Diamonds',
					'->',
					'{X:mult,C:white}X'..to_big(card.ability.extra.xmult) + to_big(1)..'{} Mult scaling',
					'{C:money}'..SMODS.signed_dollars(to_big(card.ability.extra.KoD_dollarsEarn) + to_big(1))'{} at end of round',
					'for scored  {C:attention}Kings{} of {C:diamonds_hc}Diamonds'
				}
			end,
			
			cir_upgrade = function(self, card)
				card.ability.extra.xmult = to_big(card.ability.extra.xmult) + to_big(0.5)
				card.ability.extra.KoD_dollarsEarn = to_big(card.ability.extra.KoD_dollarsEarn) + to_big(1)
				
				return { message = localize('k_upgrade_ex'), colour = CirnoMod.miscItems.colours.cirThor }
			end,
			
			calculate = function(self, card, context)
				if
					context.setting_blind
					or context.starting_shop
					and card.ability.extra.EoR_dollars > 0
				then
					card.ability.extra.EoR_dollars = 0
				end
				
				if
					(context.cardarea == G.play
					or context.cardarea == 'unscored')
					and context.other_card
					and context.other_card:is_face()
				then
					
					if
						context.individual
						and context.other_card:can_calculate()
						and context.other_card:get_id() == 13
						and context.other_card:is_suit('Diamonds')
					then
						card.ability.extra.EoR_dollars = to_big(card.ability.extra.EoR_dollars) + to_big(card.ability.extra.KoD_dollarsEarn)
					end
					
					if
						context.repetition
						and context.cardarea == G.play
						and SMODS.pseudorandom_probability(context.other_card, 'retriggerKoD', 1, card.ability.extra.retrigger_odds)
					then						
						if context.other_card:can_calculate() then
							return { repetitions = 1, colour = CirnoMod.miscItems.colours.cirThor }
						else
							return {
								doNotRedSeal = true,
								no_retrigger = true,
								message = localize('k_debuffed'),
								colour = G.C.RED,
								message_card = context.other_card
							}
						end
					end
				end
				
				if
					context.stay_flipped
					and context.from_area == G.play
					and context.other_card
					and context.other_card:is_face()
					and SMODS.pseudorandom_probability(context.other_card, 'redrawKoD', 1, card.ability.extra.redraw_odds)
				then
					return {
						doNotRedSeal = true,
						no_retrigger = true,
						modify = { to_area = G.hand }
					}
				end
				
				if context.discard and not context.blueprint then
					if card.ability.yorick_discards <= 1 then
						card.ability.yorick_discards = card.ability.extra.discards
						
						SMODS.scale_card(card, {
							ref_table = card.ability,
							ref_value = 'x_mult',
							scalar_table = card.ability.extra,
							scalar_value = 'xmult',
							no_message = true
						})
						
						return {
							message = localize {
								type = 'variable',
								key = 'a_xmult',
								vars = { to_big(card.ability.x_mult) }
							},
							colour = CirnoMod.miscItems.colours.cirThor
						}
					else
						card.ability.yorick_discards = card.ability.yorick_discards - 1
						return nil, true
					end
				end
				
				if context.joker_main then return { x_mult = to_big(card.ability.x_mult), colour = CirnoMod.miscItems.colours.cirThor } end
			end
		},
		-- The Challenger
		{
			key = 'challenger',
			upgradesFrom = 'j_chicot',
			
			matureRefLevel = 1,
			loadOrder = 'upgLgnd',
			cir_Friend = CirnoMod.miscItems.cirFriends.mom,
			
			destroyed = { colours = { G.C.PURPLE, CirnoMod.miscItems.colours.momoCyan, G.C.RED, CirnoMod.miscItems.colours.momoCyan, G.C.PURPLE } },
			
			loc_txt = { name = 'The Challenger', text = { {
					'Disables effect of',
                    'every {C:attention}Boss Blind'
					}, {
					'This {C:joker}Joker{} gains',
					'{X:mult,C:white} X#1# {} Mult every time',
					'a blind is beaten',
					'with at least {C:attention}twice',
					'the required score',
                    '{C:inactive}(Currently {X:mult,C:white} X#2# {C:inactive} Mult)'
					}, {
					'{C:blue}+#3#{} hand',
					'every round',
					'{C:attention}+#4#{} hand size',
					'{s:0.8,C:inactive}I personally could',
					'{s:0.8,C:inactive}not tolerate using',
					'{s:0.8,C:inactive}a chair in that state,',
					'{s:0.8,C:inactive}I\'d get all the tunnels'
				} }
			},
			
			abiInit = function(card)
				card.ability.extra = {
					growth = 1,
					x_mult = 1,
					hands = 1,
					handSize = 2,
					originalRarity = 4
				}
			end,
			
			blueprint_compat = true,
			loc_vars = function(self, info_queue, card)
				-- Art credit tooltip
				if CirnoMod.config.artCredits and not card.fake_card then
					info_queue[#info_queue + 1] = { key = 'jA_Reimmomo', set = 'Other' }
				end
				
				if
					not card.ability.extra
					or type(card.ability.extra) ~= 'table'
				then
					self.abiInit(card)
				end
				
				return { vars = {
					to_big(card.ability.extra.growth),
					to_big(card.ability.extra.x_mult),
					to_big(card.ability.extra.hands),
					to_big(card.ability.extra.handSize)
				} }
			end,
			
			pos = { x = 5, y = 0 },
			soul_pos = { x = 5, y = 1 },
			cost = 30,
			eternal_compat = true,
			perishable_compat = false,
			
			add_to_deck = function(self, card, from_debuff)
				self.abiInit(card)
				
				G.hand:change_size(card.ability.extra.handSize)
				
				card.ability.extra_value = CirnoMod.miscItems.upgradedExtraValue[orgRarity]
				card:set_cost()
				
				if G.GAME.blind and G.GAME.blind.boss and not G.GAME.blind.disabled then
					G.GAME.blind:disable()
					play_sound('timpani')
					SMODS.calculate_effect({ message = localize('ph_boss_disabled'), colour = CirnoMod.miscItems.colours.cirMomo }, card)
				end
			end,
			
			remove_from_deck = function(self, card, from_debuff)
				ease_hands_played(-card.ability.extra.hands)
				G.hand:change_size(-card.ability.extra.handSize)
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
				
				return { message = localize('k_upgrade_ex'), colour = CirnoMod.miscItems.colours.cirMomo }
			end,
			
			calculate = function(self, card, context)
				if context.setting_blind then
					return { 
						message = localize { type = 'variable', key = 'a_hands', vars = { card.ability.extra.hands } },
						func = function()
							ease_hands_played(card.ability.extra.hands)
							
							if not context.blueprint and context.blind.boss then
								G.E_MANAGER:add_event(Event({
									func = function()
										G.E_MANAGER:add_event(Event({
											func = function()
												G.GAME.blind:disable()
												play_sound('timpani')
												delay(0.4)
												return true
											end
										}))
										SMODS.calculate_effect({ message = localize('ph_boss_disabled'), colour = CirnoMod.miscItems.colours.cirMomo }, card)
										return true
									end
								}))
							end
						end }
				end
				
				if
					context.end_of_round
					and context.main_eval
					and to_big(G.GAME.chips) >= (to_big(G.GAME.blind.chips) * to_big(2))
				then
					SMODS.scale_card(card, {
							ref_table = card.ability.extra,
							ref_value = 'x_mult',
							scalar_value = 'growth',
							no_message = true
						})
					
					return {
						message = localize {
							type = 'variable',
							key = 'a_xmult',
							vars = { to_big(card.ability.extra.x_mult) }
						},
						colour = CirnoMod.miscItems.colours.cirMomo,
						message_card = card
					}
				end
				
				if context.joker_main then return { x_mult = to_big(card.ability.extra.x_mult), colour = CirnoMod.miscItems.colours.cirMomo } end
			end
		},
		-- The Somnolent
		{
			key = 'somnolent',
			upgradesFrom = 'j_cir_arumia_l',
			
			matureRefLevel = 1,
			loadOrder = 'upgLgnd',
			cir_Friend = CirnoMod.miscItems.cirFriends.rmi,
			
			destroyed = { colours = { G.C.RED, CirnoMod.miscItems.colours.cirCyan, G.C.PURPLE, CirnoMod.miscItems.colours.cirCyan, G.C.RED } },
			
			loc_txt = { name = 'The Somnolent', text = { {
					'{C:attention}Swaps{} between {X:chips,C:white}XChips{} & {X:mult,C:white}XMult',
					'after {C:attention}drawing{} a new {C:blue}hand',
					'{C:inactive}(Currently: {B:1,C:white}X#1#{C:inactive})'
					}, {
					'After {C:green}2-9{} cards {C:red}discarded{}',
					'{C:inactive}({C:attention}#2#{C:inactive} remaining)',
					'unchosen {C:mult}mu{C:chips}lt{C:mult}ip{C:chips}li{C:mult}er{} gains {C:attention}X#3#{},',
					'then {C:green}choose{} a new discard requirement',
					'{C:inactive}(Currently {X:chips,C:white}X#4#{C:inactive} Chips, {X:mult,C:white}X#5#{C:inactive} Mult)'
					}, {
					'When {X:chips,C:white}XChips{} is selected:',
					'{C:attention}#6#s{} & {C:attention}#7#s{} retrigger',
					'When {X:mult,C:white}XMult{} is selected:',
					'{C:attention}#8#s{}, {C:attention}#9#s{}',
					'{C:attention}#10#s{}, & {C:attention}#11#s{} retrigger'
					}, {
					'Played {C:attention}#12#s{} always score',
					'and are returned to hand',
					'{s:0.8}If not debuffed',
					'{s:0.8,C:inactive}Good job, here\'s some tooltip overload as a treat'
				} }
			},
			
			abiInit = function(card, orgRarity, orgAbilityTbl)
				card.ability.extra = orgAbilityTbl.extra
				card.ability.extra.originalRarity = orgRarity
				card.ability.extra.ChipsRetrigger = {
					'm_bonus',
					'm_stone'
				}
				
				card.ability.extra.MultRetrigger = {
					'm_mult',
					'm_glass',
					'm_steel',
					'm_lucky'
				}
				
				for k, pos in pairs(card.ability.extra.chipsMultSoulSpritePos) do
					pos.x = 6
				end
			end,
			
			postPerfInit = function(self, card, orgRarity, orgExtTable, orgAbilityTbl)
				self.abiInit(card, orgRarity, orgAbilityTbl)
				
				card.ability.extra_value = CirnoMod.miscItems.upgradedExtraValue[orgRarity]
				card:set_cost()
				self.cir_updateState(card)
			end,
			
			blueprint_compat = true,
			loc_vars = function(self, info_queue, card)
				if
					not card.ability.extra
					or type(card.ability.extra) ~= 'table'
				then
					self.abiInit(card, 4, { extra = {
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
					} } )
				end
				
				for i, cEnhKey in ipairs(card.ability.extra.ChipsRetrigger) do
					info_queue[#info_queue + 1] = G.P_CENTERS[cEnhKey]
				end
				
				for i, cEnhKey in ipairs(card.ability.extra.MultRetrigger) do
					info_queue[#info_queue + 1] = G.P_CENTERS[cEnhKey]
				end
				
				info_queue[#info_queue + 1] = G.P_CENTERS.m_wild
				
				-- Art credit tooltip
				if CirnoMod.config.artCredits and not card.fake_card then
					info_queue[#info_queue + 1] = { key = 'jA_Rumi', set = 'Other' }
				end
				
				return { vars = {
					to_big(card.ability.extra.active),
					to_big(card.ability.extra.discardDecrementCounter),
					to_big(card.ability.extra.extra),
					to_big(card.ability.extra.xChips),
					to_big(card.ability.extra.xMult),
					G.localization.descriptions.Enhanced[card.ability.extra.ChipsRetrigger[1]].name,
					G.localization.descriptions.Enhanced[card.ability.extra.ChipsRetrigger[2]].name,
					G.localization.descriptions.Enhanced[card.ability.extra.MultRetrigger[1]].name,
					G.localization.descriptions.Enhanced[card.ability.extra.MultRetrigger[2]].name,
					G.localization.descriptions.Enhanced[card.ability.extra.MultRetrigger[3]].name,
					G.localization.descriptions.Enhanced[card.ability.extra.MultRetrigger[4]].name,
					G.localization.descriptions.Enhanced.m_wild.name,
					colours = { card.ability.extra.chipsMultColour[card.ability.extra.active] }
				} }
			end,
			
			pos = { x = 6, y = 0 },
			soul_pos = { x = 6, y = 1 },
			cost = 30,
			eternal_compat = true,
			perishable_compat = false,
			
			cir_updateState = function(jkr)
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
			
			change_multiplier = function(self, card, chipsMult, silent)
				local toChangeTo = {
					msg = false,
					msgColour = G.C.FILTER
				}
				
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
						
			cir_upgradeInfo = function(self, card)
				return {
					'Create 5 random',
					'{C:dark_edition}Negative {C:tarot}Tarot Cards'
				}
			end,
			
			cir_upgrade = function(self, card)
				for i = 1, 5 do
					SMODS.add_card({ set = 'Tarot', edition = 'e_negative' })
				end
				
				card:juice_up()
				play_sound('generic1')
			end,
			
			calculate = function(self, card, context)
				if
					not context.retrigger_joker
					and not context.retrigger_joker_check
					and not context.blueprint
					and context.other_card
					and context.other_card:can_calculate()
					and SMODS.has_enhancement(context.other_card, 'm_wild')
				then
					local cardHandRT = { doNotRedSeal = true, no_retrigger = true }
					
					if
						context.modify_scoring_hand
						and context.main_eval
					then
						cardHandRT.add_to_hand = true
						return cardHandRT
					end
					
					if
						context.stay_flipped
						and context.from_area == G.play
					then
						cardHandRT.modify = { to_area = G.hand }
						return cardHandRT
					end
				end
				
				if
					context.repetition
					and (context.cardarea == G.play
					or (context.cardarea == G.hand
					and not context.end_of_round))
					and next(SMODS.get_enhancements(context.other_card))
				then
					for i, enhKey in ipairs(card.ability.extra[card.ability.extra.active..'Retrigger']) do
						if SMODS.has_enhancement(context.other_card, enhKey) then
							if context.other_card:can_calculate() then
								return { repetitions = 1, colour = CirnoMod.miscItems.colours.cirRumi }
							else
								return {
									doNotRedSeal = true,
									no_retrigger = true,
									message = localize('k_debuffed'),
									colour = G.C.RED,
									message_card = context.other_card
								}
							end
						end
					end
				end
				
				local noMoreConditions = false
				
				if
					context.setting_blind
					and not context.blueprint
					and not context.retrigger_joker
					and not context.post_trigger
				then
					self.change_multiplier(self, card, 'Chips', false)
					
					noMoreConditions = true
				elseif
					context.discard
					and not context.blueprint
				then
					card.ability.extra.discardDecrementCounter = card.ability.extra.discardDecrementCounter - 1
					
					if card.ability.extra.discardDecrementCounter <= 0 then
						-- If the counter is 0, we reroll a new value from 2 to 9 as our new counter
						local initialCounterAmount = pseudorandom('arumiaDiscards', 2, 9)
						card.ability.extra.discardDecrementCounter = initialCounterAmount
						
						-- Whichever multiplier is INACTIVE (for chips, mult and mult, chips), we increase that by our extra value.
						SMODS.scale_card(card, {
							ref_table = card.ability.extra,
							ref_value = 'x'..card.ability.extra.chipsMultOpposite[card.ability.extra.active],
							scalar_value = 'extra',
							no_message = true
						})
						
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
						if card.ability.extra.handWasPlayed then
							card.ability.extra.handWasPlayed = false
						end
						
						self.change_multiplier(self, card, false)
					elseif context.joker_main then
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
						card.ability.extra
						and card.ability.extra.handWasPlayed
						and (context.hand_drawn
						or context.end_of_round)
						and not context.retrigger_joker
					then						
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
		-- Bashful, Demure & Shy Maiden
		{
			key = 'maiden',
			upgradesFrom = 'j_cir_vileelf_l',
			
			matureRefLevel = 1,
			loadOrder = 'upgLgnd',
			cir_Friend = CirnoMod.miscItems.cirFriends.vle,
			
			destroyed = { colours = { CirnoMod.miscItems.colours.cirCyan, CirnoMod.miscItems.colours.cirNep,
				G.C.JOKER_GREY, CirnoMod.miscItems.colours.cirNep, CirnoMod.miscItems.colours.cirCyan
			} },
			
			loc_txt = { name = 'Bashful, Demure & Shy Maiden', text = { {
						'All played {C:hearts_hc}Hearts{} and',
						'{C:clubs_hc}Clubs{} without an',
						'{C:dark_edition}edition{} become',
						'{C:dark_edition}#1#'
					},
					{
						'If all played cards',
						'have an {C:dark_edition}edition{},',
						'scale them by {C:attention}#2#'
					},
					{
						'{C:tarot}#3#{C:attention} permanently',
						'adds {C:chips}+#4# Chips{} to',
						'affected cards, {C:tarot}#5#{}',
						'{C:mult}+#6# Mult{}, and',
						'{C:tarot}#7#{} adds both',
						'{s:0.8,C:inactive}This\'ll get some',
						'{s:0.8,C:inactive}oestrogen in your score'
				} }
			},
			
			abiInit = function(self, card, orgRarity, orgExtTable, orgAbilityTbl)
				card.ability.extra = orgExtTable
				
				if
					not card.ability.extra
					and orgAbilityTbl
					and type(orgAbilityTbl) == 'table'
					and orgAbilityTbl.extra
				then
					card.ability.extra = orgAbilityTbl.extra
				end
				
				card.ability.extra.chipsConsumKey = 'c_moon'
				card.ability.extra.extChips = 10
				card.ability.extra.multConsumKey = 'c_sun'
				card.ability.extra.extMult = 4
				
				card.ability.extra.bothConsumKey = 'c_lovers'
								
				card.ability.extra.scaleAmount = CirnoMod.miscItems.changeVarWhileRespectingAdditions(card.ability.extra.scaleAmount, 0.05, 0.1)
			end,
			
			postPerfInit = function(self, card, orgRarity, orgExtTable, orgAbilityTbl)
				self.abiInit(self, card, orgRarity, orgExtTable, orgAbilityTbl)
				
				card.ability.extra_value = CirnoMod.miscItems.upgradedExtraValue[orgRarity]
				card:set_cost()
			end,
			
			blueprint_compat = true,
			loc_vars = function(self, info_queue, card)
				if
					not card.ability.extra
					or type(card.ability.extra) ~= 'table'
				then
					self.abiInit(self, card, 4, {
						scaleAmount = 0.05,
						setEditionTbl = { edition = 'e_polychrome' }
					})
				end
				
				info_queue[#info_queue + 1] = G.P_CENTERS[card.ability.extra.setEditionTbl.edition]
				
				info_queue[#info_queue + 1] = SMODS.shallow_copy(G.P_CENTERS[card.ability.extra.chipsConsumKey])
				info_queue[#info_queue].fake_card = true
				
				info_queue[#info_queue + 1] = SMODS.shallow_copy(G.P_CENTERS[card.ability.extra.multConsumKey])
				info_queue[#info_queue].fake_card = true
				
				info_queue[#info_queue + 1] = SMODS.shallow_copy(G.P_CENTERS[card.ability.extra.bothConsumKey])
				info_queue[#info_queue].fake_card = true
				
				info_queue[#info_queue + 1] = CirnoMod.miscItems.getEditionScalingInfo({ type = 'example' }, to_big(card.ability.extra.scaleAmount) )
				
				-- Art credit tooltip
				if CirnoMod.config.artCredits and not card.fake_card then
					info_queue[#info_queue + 1] = { key = "jA_NTF", set = "Other" }
				end
				
				return { vars = {
					localize{
						type = 'name_text',
						set = 'Edition',
						key = card.ability.extra.setEditionTbl.edition
					},
					to_big(card.ability.extra.scaleAmount),
					localize{
						type = 'name_text',
						set = 'Tarot',
						key = card.ability.extra.chipsConsumKey
					},
					to_big(card.ability.extra.extChips),
					localize{
						type = 'name_text',
						set = 'Tarot',
						key = card.ability.extra.multConsumKey
					},
					to_big(card.ability.extra.extMult),
					localize{
						type = 'name_text',
						set = 'Tarot',
						key = card.ability.extra.bothConsumKey
					}
				} }
			end,
			
			pos = { x = 0, y = 2 },
			soul_pos = { x = 0, y = 3 },
			cost = 30,
			eternal_compat = true,
			perishable_compat = false,
			
			cir_upgradeInfo = function(self, card)
				return {
					'{C:chips}+'..to_big(card.ability.extra.extChips)..' Chips{},',
					'{C:mult}+'..to_big(card.ability.extra.extMult)..' Mult',
					'->',
					'{C:chips}+'..to_big(card.ability.extra.extChips)+to_big(10)..' Chips{},',
					'{C:mult}+'..to_big(card.ability.extra.extMult)+to_big(4)..' Mult'
				}
			end,
			
			cir_upgrade = function(self, card)
				card.ability.extra.extChips = to_big(card.ability.extra.extChips) + to_big(10)
				card.ability.extra.extMult = to_big(card.ability.extra.extMult) + to_big(4)
				
				return { message = localize('k_upgrade_ex'), colour = CirnoMod.miscItems.colours.cirVile }
			end,
			
			calculate = function(self, card, context)
				if 
					not context.blueprint
					and not context.retrigger_joker
					and not context.retrigger_joker_check
				then
					if context.before then
						local fullHand = context.full_hand
						local allCardsHaveEditions = true
						
						for i, pCard in ipairs(fullHand) do
							if not pCard.edition then
								allCardsHaveEditions = false
								break
							end
						end
						
						if allCardsHaveEditions then
							local jkrRef = card
							
							return {
								func = function()
									-- Processes edition scaling	
									for i, cardRef in ipairs(fullHand) do
										SMODS.calculate_effect({
											message = CirnoMod.miscItems.scaleEdition_FHP(cardRef, to_big(jkrRef.ability.extra.scaleAmount)),
											colour = CirnoMod.miscItems.cardEditionTypeToColour(cardRef) or G.C.FILTER,
											sound = CirnoMod.miscItems.cardEditionTypeToSfx(cardRef) or 'generic1',
											-- volume = 0.5,
											message_card = cardRef
										}, jkrRef)
									end
								end,
								no_juice = true
							}
						end
					end
					
					if
						context.individual
						and (context.cardarea == G.play
						or context.cardarea == 'unscored')
						and context.other_card
						and (context.other_card:is_suit('Hearts')
						or context.other_card:is_suit('Clubs'))
						and not context.other_card.edition
					then
						local jkrRef = card
						local cardRef = context.other_card
						
						return {
							func = function()
								cardRef:set_edition(jkrRef.ability.extra.setEditionTbl.edition)
								
								G.E_MANAGER:add_event(Event({
								trigger = 'after',
								delay = 0.0,
								func = function()
									jkrRef:juice_up()
									return true
								end}))
								
							end,
							no_juice = true,
							no_retrigger = true,
							doNotRedSeal = true
						}
					end
				end
				
				if
					context.using_consumeable
				then
					local cardScaling = {}
					local jkrRef = context.blueprint_card or card
					local doRet = false
					
					if
						context.consumeable.config.center.key == card.ability.extra.chipsConsumKey
						or context.consumeable.config.center.key == card.ability.extra.bothConsumKey
					then
						cardScaling.perma_bonus = 'extChips'
						doRet = true
					end
					
					if
						context.consumeable.config.center.key == card.ability.extra.multConsumKey
						or context.consumeable.config.center.key == card.ability.extra.bothConsumKey
					then
						cardScaling.perma_mult = 'extMult'
						doRet = true
					end
					
					for cardPerma, extName in pairs(cardScaling) do
						for _, pCard in ipairs(G.hand.highlighted) do
							SMODS.scale_card(pCard, {
								ref_table = pCard.ability,
								ref_value = cardPerma,
								scalar_table = card.ability.extra,
								scalar_value = extName,
								message_colour = CirnoMod.miscItems.colours.cirVile
							})
							
							if jkrRef.seal == 'Red' then
								SMODS.calculate_effect({
									message = localize('k_again_ex'),
									doNotRedSeal = true,
									no_retrigger = true
								}, jkrRef)
								
								SMODS.scale_card(pCard, {
									ref_table = pCard.ability,
									ref_value = cardPerma,
									scalar_table = card.ability.extra,
									scalar_value = extName,
									message_colour = CirnoMod.miscItems.colours.cirVile
								})
							end
						end
					end
					
					if doRet then return { doNotRedSeal = true, no_retrigger = true }, true end
				end
			end
		},
		-- The Anon
		{
			key = 'anon',
			upgradesFrom = 'j_perkeo',
			
			matureRefLevel = 1,
			loadOrder = 'upgLgnd',
			cir_Friend = CirnoMod.miscItems.cirFriends.dck,
			
			destroyed = { colours = { G.C.PURPLE, G.C.RED, G.C.BLACK, G.C.GREEN, G.C.PURPLE } },
			
			loc_txt = { name = 'The Anon', text = { {
					'Creates a {C:dark_edition}Negative{} copy of',
                    'the {C:attention}leftmost consumable{}',
                    'card in your possession',
                    'at the end of the {C:attention}shop'
					}, {
					'Played {C:attention}Queens{} of {C:spades_hc}Spades',
					'without an {C:attention}enhancement',
					'become {C:attention}#1#s'
					}, {
					'For every hand played this',
					'round that had a {C:attention}debuffed',
					'{C:attention}card{}, that many hands',
					'next round',
					'{C:inactive}(Currently {C:blue}+#2# hands{C:inactive})',
					'{s:0.8,C:inactive}If you hold your breath,',
					'{s:0.8,C:inactive}towels can also be',
					'{s:0.8,C:inactive}heavier than feathers'
				} }
			},
			
			abiInit = function(card, orgRarity)
				card.ability.extra = {
					originalRarity = orgRarity,
					extraHandsCount = 0,
					prevHandsCount = 0,
					flipPitch = 1
				}
			end,
			
			postPerfInit = function(self, card, orgRarity, orgExtTable, orgAbilityTbl)
				self.abiInit(card, orgRarity)
				
				card.ability.extra_value = CirnoMod.miscItems.upgradedExtraValue[orgRarity]
				card:set_cost()
			end,
			
			blueprint_compat = true,
			loc_vars = function(self, info_queue, card)
				info_queue[#info_queue + 1] = { key = 'e_negative_consumable', set = 'Edition', config = { extra = 1 } }
				
				info_queue[#info_queue + 1] = G.P_CENTERS.m_steel
				
				-- Art credit tooltip
				if CirnoMod.config.artCredits and not card.fake_card then
					info_queue[#info_queue + 1] = { key = 'jA_Deck', set = 'Other' }
				end
				
				if
					not card.ability.extra
					or type(card.ability.extra) ~= 'table'
				then
					self.abiInit(card, 4)
				end
				
				return { vars = {
					G.localization.descriptions.Enhanced.m_steel.name,
					card.ability.extra.extraHandsCount
				} }
			end,
			
			pos = { x = 7, y = 0 },
			soul_pos = { x = 7, y = 1 },
			cost = 30,
			eternal_compat = true,
			perishable_compat = false,
			
			cir_upgradeInfo = function(self, card)
				return {
					'Create 2 free',
					'{C:attention}'..localize{ type = 'name_text', key = 'tag_negative', set = 'Tag' }..'s'
				}
			end,
			
			cir_upgrade = function(self, card)
				for i = 1, 2 do
					add_tag(Tag('tag_negative'))
				end
				
				card:juice_up()
				play_sound('generic1')
			end,
			
			calculate = function(self, card, context)
				if context.ending_shop and G.consumeables.cards[1] then
					return { message = localize('k_duplicated_ex'),
						func = function()
							local card_to_copy = G.consumeables.cards[1]
							local copied_card = copy_card(card_to_copy)
							copied_card:set_edition('e_negative', true)
							copied_card:add_to_deck()
							G.consumeables:emplace(copied_card)
						end }
				end
				
				if context.setting_blind then
					local handsToAdd = card.ability.extra.extraHandsCount
					
					if context.retrigger_joker or context.retrigger_joker_check then
						handsToAdd = card.ability.extra.prevHandsCount
					end
					
					if handsToAdd > 0 then
						local msg = localize { type = 'variable', key = 'a_hands', vars = { handsToAdd } }
						
						return { message = msg,
							colour = G.C.BLUE,
							func = function()
								ease_hands_played(handsToAdd)
						
								if
									not context.blueprint
									and not (context.retrigger_joker or context.retrigger_joker_check)
								then
									card.ability.extra.extraHandsCount = 0
								end
							end }
					end
				end
				
				if
					not context.blueprint
					and not (context.retrigger_joker
					or context.retrigger_joker_check)
				then
					if
						context.before
						and G.GAME.current_round.hands_left > 0
					then
						if card.ability.extra.prevHandsCount > 0 then
							card.ability.extra.prevHandsCount = 0
						end
						
						for i, c in ipairs(context.full_hand) do
							if c.debuff then
								card.ability.extra.extraHandsCount = card.ability.extra.extraHandsCount + 1
								
								local msg = localize { type = 'variable', key = 'a_hands', vars = { card.ability.extra.extraHandsCount } }
								
								return { doNotRedSeal = true,
									message = string.sub(msg, 2, #msg),
									colour = G.C.BLUE }
							end
						end
					end
					
					if
						context.individual
						and (context.cardarea == G.play
						or context.cardarea == 'unscored')
						and context.other_card:can_calculate()
						and context.other_card:get_id() == 12
						and context.other_card:is_suit('Spades')
						and not next(SMODS.get_enhancements(context.other_card))
					then
						local cardRef = context.other_card
						local jkrRef = card
						
						CirnoMod.miscItems.flippyFlip.fStart(cardRef, card.ability.extra.flipPitch)
						
						return { doNotRedSeal = true,
							no_retrigger = true,
							func = function()
								-- Sets the random enhancement
								cardRef:set_ability('m_steel', nil, true)
								
								G.E_MANAGER:add_event(Event({
									trigger = 'immediate',
									blocking = true,
									blockable = true,
									func = function()
										card.ability.extra.flipPitch = math.max(jkrRef.ability.extra.flipPitch - 0.09, 0.5)
										jkrRef:juice_up();play_sound('generic1', jkrRef.ability.extra.flipPitch)
										return true 
									end }))
								
								CirnoMod.miscItems.flippyFlip.fEnd(cardRef, jkrRef.ability.extra.flipPitch)
							end }
					end
					
					if context.hand_drawn or context.starting_shop then
						if card.ability.extra.extraHandsCount > card.ability.extra.prevHandsCount then
							card.ability.extra.prevHandsCount = card.ability.extra.extraHandsCount
						end
						
						card.ability.extra.flipPitch = 1
					end
				end
			end
		}, 
		-- The Enigma
		{
			key = 'enigma',
			upgradesFrom = 'j_cir_houdini_l',
			
			matureRefLevel = 1,
			loadOrder = 'upgLgnd',
			cir_Friend = CirnoMod.miscItems.cirFriends.hou,
			
			destroyed = { colours = { G.C.ORANGE, CirnoMod.miscItems.colours.houAqua, G.C.BLACK, G.C.ORANGE, CirnoMod.miscItems.colours.houAqua } },
			
			loc_txt = { name = 'The Enigma', text = { {
					'Every played {C:attention}card',
					'{C:attention}permanently{} gains {C:mult}+#1#{} Mult per',
					'{C:attention}enhancement{}, {C:dark_edition}edition{} and/or',
					'{C:attention}seal{} when scored'
					}, {
					'Gain {C:money}#2#{} if the entire hand',
					'had {C:mult}mult{} added to it',
					'via the above'
					}, {
					'{X:blue,C:white} X#3# {} Chips',
					'{s:0.8,C:inactive}"Hello Hoshimi Miyabi from ZZZ"',
					'{s:0.8,C:inactive}"Hello Fie from Houdini111"',
					'{s:0.8,C:inactive}*long ears*'
				} }
			},
			
			abiInit = function(card, orgRarity, orgExtTable, orgAbilityTbl)
				card.ability.extra = orgExtTable
				
				if
					not card.ability.extra
					and orgAbilityTbl
					and type(orgAbilityTbl) == 'table'
					and orgAbilityTbl.extra
				then
					card.ability.extra = orgAbilityTbl.extra
				end
				
				card.ability.extra.originalRarity = orgRarity
				
				card.ability.extra.xChips = 1.11
				card.ability.extra.dollars = 1
				card.ability.extra.retriggerBypass = false
			end,
			
			postPerfInit = function(self, card, orgRarity, orgExtTable, orgAbilityTbl)
				self.abiInit(card, orgRarity, orgExtTable, orgAbilityTbl)
				
				card.ability.extra_value = CirnoMod.miscItems.upgradedExtraValue[orgRarity]
				card:set_cost()
			end,
			
			blueprint_compat = true,
			loc_vars = function(self, info_queue, card)
				-- Art credit tooltip
				if CirnoMod.config.artCredits and not card.fake_card then
					info_queue[#info_queue + 1] = { key = 'jA_Houdini', set = 'Other' }
				end
				
				if
					not card.ability.extra
					or type(card.ability.extra) ~= 'table'
				then
					self.abiInit(card, 4, { extra = 1 })
				end
				
				return { vars = {
					to_big(card.ability.extra.extra),
					SMODS.signed_dollars(to_big(card.ability.extra.dollars)),
					to_big(card.ability.extra.xChips)
					} }
			end,
			
			pos = { x = 8, y = 0 },
			soul_pos = { x = 8, y = 1 },
			cost = 30,
			eternal_compat = true,
			perishable_compat = false,
			
			cir_upgradeInfo = function(self, card)
				return {
					'Gain {C:money}$111'
				}
			end,
			
			cir_upgrade = function(self, card)
				return { dollars = 111, colour = CirnoMod.miscItems.colours.cirHoudini, delay = 1 }
			end,
			
			calculate = function(self, card, context)
				if
					(context.before
					or context.hand_drawn)
					and card.ability.extra.retriggerBypass
				then
					card.ability.extra.retriggerBypass = false
				end
				
				if context.initial_scoring_step then
					local ret = { no_retrigger = true }
					local cardsMultAdded = 0
					
					for i, pCard in ipairs(context.full_hand) do
						if pCard:can_calculate() then
							-- Work out how much mult to add
							local eesCount = 0
							
							--[[ Is there an enhancement? If so, set amount
							(Since this is the first in sequence)]]
							if next(SMODS.get_enhancements(pCard)) then
								eesCount = 1
							end
							
							-- Is there a seal? If so, add amount.
							if pCard.seal then
								eesCount = eesCount + 1
							end
							
							-- Is there an edition? If so, add amount.
							if pCard.edition then
								eesCount = eesCount + 1
							end
							
							-- If we're adding any mult, do so
							if eesCount > 0 then
								-- Return table (in extra to prevent the colour being overridden by Blueprint/Brainstorm)
								ret.no_retrigger = nil
								
								pCard.ability.perma_mult = to_big(pCard.ability.perma_mult) or 0
								
								SMODS.scale_card(pCard, {
									ref_table = pCard.ability,
									ref_value = 'perma_mult',
									operation = function(ref_table, ref_value, initial, change)
										ref_table[ref_value] = to_big(initial) + to_big(eesCount) * to_big(change)
									end,
									scalar_table = card.ability.extra,
									scalar_value = 'extra',
									no_message = true
								})
								
								if not context.blueprint and not (context.retrigger_joker or context.retrigger_joker_check) then
									cardsMultAdded = cardsMultAdded + 1
								end
								
								SMODS.calculate_effect({
									message = localize('k_upgrade_ex'),
									colour = G.C.RED
								}, pCard)
							end
						end
					end
					
					if
						cardsMultAdded == #context.full_hand
						or (card.ability.extra.retriggerBypass
						and (context.retrigger_joker
						or context.retrigger_joker_check))
					then
						if not (context.retrigger_joker or context.retrigger_joker_check) then
							card.ability.extra.retriggerBypass = true
						end
						
						ret = {
							dollars = to_big(card.ability.extra.dollars),
							colour = G.C.MONEY,
							message_card = context.blueprint_card or card
						}
					end
					
					return ret
				end
				
				if context.joker_main then return { x_chips = to_big(card.ability.extra.xChips), colour = CirnoMod.miscItems.colours.cirHoudini } end
			end
		},
		-- The Catboy
		{
			key = 'catboy',
			upgradesFrom = 'j_cir_wolsk_l',
			
			matureRefLevel = 1,
			loadOrder = 'upgLgnd',
			cir_Friend = CirnoMod.miscItems.cirFriends.wls,
			
			destroyed = { colours = { CirnoMod.miscItems.colours.cirCyan, G.C.PURPLE, G.C.BLACK, CirnoMod.miscItems.colours.cirCyan, G.C.PURPLE } },
			
			loc_txt = { name = 'The Catboy', text = { {
					'Every played {C:attention}card',
					'in the first {C:blue}hand{} of the round',
					'{C:attention}permanently{} gains {X:mult,C:white}X#1#{} Mult',
					' ',
					'{C:attention}Kings{} of {C:spades_hc}Spades',
					'instead gain {X:mult,C:white}X#2#{} Mult'
					}, {
					'In non-first hands,',
					'{C:green}#3# in #4#{} chance',
					'for the above',
					'{s:0.8,C:inactive}I\'d like to state for',
					'{s:0.8,C:inactive}the record that I asked',
					'{s:0.8,C:inactive}Wolsk\'s Discord for one',
					'{s:0.8,C:inactive}word that described him',
					'{s:0.8,C:inactive}and "Catboy" was the',
					'{s:0.8,C:inactive}response I got, which was',
					'{s:0.8,C:inactive}validated by Wolsk himself',
					' ',
					'{s:0.8,C:inactive}This is the result'
				} }
			},
			
			abiInit = function(card, orgRarity, orgExtTable, orgAbilityTbl)
				card.ability.extra = orgExtTable
				
				if
					not card.ability.extra
					and orgAbilityTbl
					and type(orgAbilityTbl) == 'table'
					and orgAbilityTbl.extra
				then
					card.ability.extra = orgAbilityTbl.extra
				end
				
				card.ability.extra.originalRarity = orgRarity
				
				card.ability.extra.extra_KoS = 0.25
			end,
			
			postPerfInit = function(self, card, orgRarity, orgExtTable, orgAbilityTbl)
				self.abiInit(card, orgRarity,orgExtTable, orgAbilityTbl)
				
				card.ability.extra_value = CirnoMod.miscItems.upgradedExtraValue[orgRarity]
				card:set_cost()
			end,
			
			blueprint_compat = true,
			loc_vars = function(self, info_queue, card)
				if CirnoMod.config.artCredits and not card.fake_card then
					info_queue[#info_queue + 1] = { key = "jA_Wolsk", set = "Other" }
				end
				
				local denom = 0
				
				if G.play and G.play.cards and #G.play.cards > 0 then
					denom = #G.play.cards
				elseif G.hand and G.hand.highlighted and #G.hand.highlighted > 0 then
					denom = #G.hand.highlighted
				end
				
				local numerator, denominator = SMODS.get_probability_vars(card or self, 1, denom)
				
				if
					not card.ability.extra
					or type(card.ability.extra) ~= 'table'
				then
					self.abiInit(card, 4, { extra = 0.1 })
				end
				
				return { vars = {
					to_big(card.ability.extra.extra),
					to_big(card.ability.extra.extra_KoS),
					numerator,
					denominator > 0 and denominator or '[played hand size]'
				} }
			end,
			
			pos = { x = 9, y = 0 },
			soul_pos = { x = 9, y = 1 },
			cost = 30,
			eternal_compat = true,
			perishable_compat = false,
			
			cir_upgradeInfo = function(self, card)
				return {
					'{X:mult,C:white}X'..to_big(card.ability.extra.extra)..'{} Mult scaling',
					'{s:0.8}(Kings of Spades {s:0.8,X:mult,C:white}X'..to_big(card.ability.extra.extra_KoS)..'{s:0.8})',
					'->',
					'{X:mult,C:white}X'..to_big(card.ability.extra.extra) + to_big(0.1)..'{} Mult scaling',
					'{s:0.8}(Kings of Spades {s:0.8,X:mult,C:white}X'..to_big(card.ability.extra.extra_KoS) + to_big(0.1)..'{s:0.8})'
				}
			end,
			
			cir_upgrade = function(self, card)
				card.ability.extra.extra = to_big(card.ability.extra.extra) + to_big(0.1)
				card.ability.extra.extra_KoS = to_big(card.ability.extra.extra_KoS) + to_big(0.1)
				
				return { message = localize('k_upgrade_ex'), colour = CirnoMod.miscItems.colours.cirWolsk }
			end,
			
			calculate = function(self, card, context)
				if
					context.individual
					and (context.cardarea == G.play
					or context.cardarea == 'unscored')
					and context.other_card
					and (G.GAME.current_round.hands_played < 1
					or SMODS.pseudorandom_probability(context.other_card, 'wlskXMult', 1, #context.full_hand))
				then
					context.other_card.ability.perma_x_mult = to_big(context.other_card.ability.perma_x_mult) or 0
					
					local scaleTable = {
							ref_table = context.other_card.ability,
							ref_value = 'perma_x_mult',
							scalar_table = card.ability.extra,
							no_message = true
						}
					
					if
						context.other_card:get_id() == 13
						and context.other_card:is_suit('Spades')
					then
						scaleTable.scalar_table = card.ability.extra.extra_KoS
					end
					
					SMODS.scale_card(context.other_card, scaleTable)
					
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
		-- The Soft-Spoken
		{
			key = 'softSpoken',
			upgradesFrom = 'j_cir_demeorin_l',
			
			matureRefLevel = 1,
			loadOrder = 'upgLgnd',
			cir_Friend = CirnoMod.miscItems.cirFriends.dme,
			
			destroyed = { colours = { G.C.RED, G.C.BLACK, G.C.RED, G.C.BLACK, G.C.RED } },
			
			loc_txt = { name = 'The Soft-Spoken', text = { {
					'After defeating a {C:attention}Boss Blind{},',
					'create a {C:dark_edition}Negative {C:spectral}Spectral{} card'
					}, {
					'If blind was defeated with a hand',
					'containing a {C:attention}Jack{} of {C:spades_hc}Spades{},',
					'create a {C:dark_edition}Negative {C:spectral}Spectral{} card',
					-- "{s:0.8,C:inactive}"
				} }
			},
			
			postPerfInit = function(self, card, orgRarity, orgExtTable, orgAbilityTbl)
				card.ability.extra = {
					originalRarity = orgRarity,
					finalHandHadJoS = false
				}
				
				card.ability.extra_value = CirnoMod.miscItems.upgradedExtraValue[orgRarity]
				card:set_cost()
			end,
			
			blueprint_compat = true,
			loc_vars = function(self, info_queue, card)				
				info_queue[#info_queue + 1] = { key = 'e_negative_consumable', set = 'Edition', config = { extra = 1 } }
				
				-- Art credit tooltip
				if CirnoMod.config.artCredits and not card.fake_card then
					info_queue[#info_queue + 1] = { key = "jA_Deme", set = "Other" }
				end
				
				return nil
			end,
			
			pos = { x = 5, y = 2 },
			soul_pos = { x = 5, y = 3 },
			cost = 30,
			eternal_compat = true,
			perishable_compat = false,
			
			calculate = function(self, card, context)
				if
					card.ability.extra
					and card.ability.extra.finalHandHadJoS
					and (context.setting_blind
					or context.starting_shop)
				then
					card.ability.extra.finalHandHadJoS = false
				end
				
				if
					not context.blueprint
					and not (context.retrigger_joker
					and not context.retrigger_joker_check)
					and context.before
				then
					if card.ability.extra.finalHandHadJoS then
						card.ability.extra.finalHandHadJoS = false
					end
					
					for i, c in ipairs(context.full_hand) do
						if
							c:get_id() == 11
							and c:is_suit('Spades')
						then
							card.ability.extra.finalHandHadJoS = true
							break
						end
					end
				end
				
				if
					context.end_of_round
					and context.main_eval
					and not context.game_over
				then
					local spectralCount = 0
					
					if context.beat_boss then
						spectralCount = 1
					end
					
					if card.ability.extra.finalHandHadJoS then
						spectralCount = spectralCount + 1
					end
					
					if spectralCount > 0 then
						return { func = function()
								card:juice_up()
								play_sound('generic1')
								
								for i = 1, spectralCount do
									SMODS.add_card({ set = 'Spectral', edition = 'e_negative' })
								end
							end }
					end
				end
			end
		},
		-- Quality Assured
		{
			key = 'qualityAssured',
			upgradesFrom = 'j_cir_tom_l',
			
			matureRefLevel = 1,
			loadOrder = 'upgLgnd',
			cir_Friend = CirnoMod.miscItems.cirFriends.tom,
			
			destroyed = { colours = { G.C.GREEN, CirnoMod.miscItems.colours.cirCyan, G.C.GREEN, CirnoMod.miscItems.colours.cirCyan, G.C.GREEN } },
			
			loc_txt = { name = 'Quality Assured', text = { {
					'In {C:attention}2{} rounds,',
					'sell this card {C:attention}during a blind',
					'({s:0.85}Not during scoring)',
					'to do the following in order:',
					'{s:0.85}1. Flip {s:0.85,C:attention}#1#{s:0.85} random cards in hand',
					'{s:0.85}2. Scale all {s:0.85,C:joker}Joker {s:0.85,C:dark_edition}editions',
					'{s:0.85}  by a scalar of #2#',
					'{s:0.85}({s:0.85,C:dark_edition}Foil{s:0.85}/{s:0.85,C:dark_edition}Holographic{s:0.85}/{s:0.85,C:dark_edition}Polychrome{s:0.85} only)',
					'{s:0.85}3. If all cards in hand are {s:0.85,C:attention}not',
					'{s:0.85}face up or face down, restart',
					'{s:0.85}from the first step',
					'{C:inactive}(Currently {C:attention}#3#{C:inactive}/2)'
					}, {
					'For every {C:attention}ten times{} that',
					'the entire hand is flipped',
					'during the above, create',
					'a free {C:dark_edition}#4#',
					'{s:0.85,C:red}2+ Jokers required for sale',
					'{s:0.8,C:inactive}#5#',
					'{s:0.8,C:inactive}#6#'
				} }
			},
			
			config = { extra = { scalar = 0.05, rCounter = 0, selling = false } },
			
			postPerfInit = function(self, card, orgRarity, orgExtTable, orgAbilityTbl)
				card.ability.extra.rCounter = 0
				card.ability.extra_value = CirnoMod.miscItems.upgradedExtraValue[orgRarity]
				card:set_cost()
			end,
			
			blueprint_compat = false,
			loc_vars = function(self, info_queue, card)
				info_queue[#info_queue + 1] = CirnoMod.miscItems.getEditionScalingInfo({ type = 'example' }, card.ability.extra.scalar )
				
				info_queue[#info_queue + 1] = { key = 'tag_negative', set = 'Tag', config = { type = 'store_joker_modify', fake_card = true, edition = 'negative', odds = 5 } }
				
				if CirnoMod.config.artCredits and not card.fake_card then
					info_queue[#info_queue + 1] = { key = "jA_NTF", set = "Other" }
				end
				
				local flavour = ''
				local flavour2 = ''
				
				if CirnoMod.config.matureReferences_cyc > 1 then
					flavour = 'Tom\'s favourite Chinese'
					flavour2 = 'snack food, sticky FUCK!'
				end
				
				local cardFlipCount = "[Current Joker Count - 1]"
				
				if
					G.jokers
					and G.jokers.cards
				then
					cardFlipCount = math.min(#G.jokers.cards, G.jokers.config.card_limits.base) - 1
				end
				
				return { vars = {
					cardFlipCount,
					to_big(card.ability.extra.scalar),
					card.ability.extra.rCounter,
					localize{ type = 'name_text', key = 'tag_negative', set = 'Tag' },
					flavour,
					flavour2
				} }
			end,
			
			pos = { x = 7, y = 2 },
			soul_pos = { x = 7, y = 3 },
			cost = 30,
			eternal_compat = false,
			perishable_compat = false,
			
			can_sell = function(self, card, context)
				if
					G.jokers
					and G.jokers.cards
				then
					return #G.jokers.cards > 1
				end
				
				return false
			end,
			
			cir_updateState = function(jkr)
				if
					jkr.ability.extra.rCounter >= 2
					and G.GAME
					and G.GAME.blind.in_blind
				then
					local eval = function(card)
						if card.ability.extra.selling then
							return false
						end
						
						return (not card.REMOVED
							or not G.GAME.blind.in_blind)
							and not G.RESET_JIGGLES
					end
					juice_card_until(jkr, eval, true)
				end
			end,
			
			calculate = function(self, card, context)
				if not context.blueprint then
					if
						card.ability.extra.rCounter < 2
						and context.end_of_round
						and context.main_eval
						and not context.game_over
					then
						card.ability.extra.rCounter = card.ability.extra.rCounter + 1
						
						if card.ability.extra.rCounter == 2 then
							return { message = localize('k_active_ex') }
						else
							return { message = card.ability.extra.rCounter..'/2' }
						end
					end
					
					if
						card.ability.extra.rCounter >= 2
					then
						if context.hand_drawn then
							local eval = function(card)
								if card.ability.extra.selling then
									return false
								end
								
								return (not card.REMOVED
									or not G.GAME.blind.in_blind)
									and not G.RESET_JIGGLES
							end
							juice_card_until(card, eval, true)
						end
						
						if
							context.selling_self
							and G.GAME.blind.in_blind
						then
							card.ability.extra.selling = true
							G.GAME.cir_tomming = true
							
							local qa_chainTbl = { 
								saved_HL_Limit = G.hand.config.highlighted_limit,
								eligibleJkrs = {},
								scaleResponders = {},
								cardFlipCountTable = {},
								toFlip = {},
								scalar = card.ability.extra.scalar,
								flipCount = math.min(#G.jokers.cards, G.jokers.config.card_limits.base) - 1,
								curTotalHandFlipCount = 0,
								eventStage = 0,
								sfxPrc = 0.975,
								sfxNme = nil,
								microstageProg = 1,
								juiceStrength = 0.1
							}
							
							if qa_chainTbl.flipCount > #G.hand.cards then
								qa_chainTbl.flipCount = #G.hand.cards
							end
							
							if qa_chainTbl.flipCount < 1 then
								qa_chainTbl.flipCount = 1
							end
							
							G.hand.config.highlighted_limit = 0
							G.hand:unhighlight_all()
							
							CirnoMod.miscItems.unhighlightAllJokerAreas()
							
							for i = 1, #G.hand.cards do
								G.hand.cards[i].states.drag.can = false
								qa_chainTbl.cardFlipCountTable['card'..i..'_flipCount'] = 0
							end
							
							for i, jkr in ipairs (G.jokers.cards) do
								if
									jkr.config.center.tom_finish
									and type(jkr.config.center.tom_finish) == 'function'
								then
									table.insert(qa_chainTbl.scaleResponders, jkr)
								end
								
								if
									jkr.edition
									and jkr.config.center.key ~= 'j_cir_qualityAssured'
									and CirnoMod.miscItems.pullEditionModifierValue(jkr.edition) ~= nil
								then
									table.insert(qa_chainTbl.eligibleJkrs, jkr)
								end
							end
							
							play_sound('timpani')
							
							local qaEvent
							qaEvent = Event({
								trigger = 'after',
								timer = 'UPTIME',
								delay = 0.1125,
								blocking = true,
								blockable = true,
								func = function()
									if qa_chainTbl.eventStage == 0 then
										if card then
											card:juice_up(qa_chainTbl.juiceStrength, qa_chainTbl.juiceStrength)
										end
										
										for i = 1, qa_chainTbl.flipCount do
											table.insert(qa_chainTbl.toFlip, pseudorandom('tom_Flip'..i, 1, #G.hand.cards))
										end
										
										qa_chainTbl.eventStage = 1
										
									elseif qa_chainTbl.eventStage == 1 then
										G.hand.cards[qa_chainTbl.toFlip[qa_chainTbl.microstageProg]]:flip();play_sound('card1', qa_chainTbl.sfxPrc);G.hand.cards[qa_chainTbl.toFlip[qa_chainTbl.microstageProg]]:juice_up(0.3, 0.3)
										qa_chainTbl.cardFlipCountTable['card'..qa_chainTbl.toFlip[qa_chainTbl.microstageProg]..'_flipCount'] = qa_chainTbl.cardFlipCountTable['card'..qa_chainTbl.toFlip[qa_chainTbl.microstageProg]..'_flipCount'] + 1
										
										if qa_chainTbl.sfxPrc < 20 then
											qa_chainTbl.sfxPrc = qa_chainTbl.sfxPrc + 0.00175
										end
										
										if qa_chainTbl.microstageProg == #qa_chainTbl.toFlip then
											qa_chainTbl.microstageProg = 1
											qa_chainTbl.eventStage = 2
										else
											qa_chainTbl.microstageProg = qa_chainTbl.microstageProg + 1
										end
										
									elseif qa_chainTbl.eventStage == 2 then
										for k, counter in pairs(qa_chainTbl.cardFlipCountTable) do
											if qa_chainTbl.curTotalHandFlipCount >= counter then
												break
											end
											
											if k == 'card'..#G.hand.cards..'_flipCount' then
												qa_chainTbl.curTotalHandFlipCount = qa_chainTbl.curTotalHandFlipCount + 1
												
												if qa_chainTbl.curTotalHandFlipCount % 10 == 0 then
													add_tag(Tag('tag_negative'));play_sound('highlight1', qa_chainTbl.sfxPrc)
													
													if qa_chainTbl.sfxPrc < 20 then
														qa_chainTbl.sfxPrc = qa_chainTbl.sfxPrc + 0.00225
													end
												end
											end
										end
										
										CirnoMod.miscItems.scaleEdition_FHP(qa_chainTbl.eligibleJkrs[qa_chainTbl.microstageProg], to_big(qa_chainTbl.scalar))
										qa_chainTbl.eligibleJkrs[qa_chainTbl.microstageProg]:juice_up(qa_chainTbl.juiceStrength, qa_chainTbl.juiceStrength)
										qa_chainTbl.sfxNme = CirnoMod.miscItems.cardEditionTypeToSfx(qa_chainTbl.eligibleJkrs[qa_chainTbl.microstageProg])
												
										if qa_chainTbl.sfxNme then
											play_sound(qa_chainTbl.sfxNme, qa_chainTbl.sfxPrc)
											
											if qa_chainTbl.sfxPrc < 20 then
												qa_chainTbl.sfxPrc = qa_chainTbl.sfxPrc + 0.00175
											end
										end
										
										if qa_chainTbl.microstageProg == #qa_chainTbl.eligibleJkrs then
											qa_chainTbl.microstageProg = 1
											qa_chainTbl.eventStage = 3
										else
											qa_chainTbl.microstageProg = qa_chainTbl.microstageProg + 1
										end
										
									elseif qa_chainTbl.eventStage == 3 then
										qa_chainTbl.toFlip = {}
										local toLookFor = G.hand.cards[1].facing
										local allFacingSame = true
										
										for i, c in ipairs(G.hand.cards) do
											if c.facing ~= toLookFor then
												allFacingSame = false
												break
											end
										end
										
										if allFacingSame then
											G.hand.config.highlighted_limit = qa_chainTbl.saved_HL_Limit
											
											for i = 1, #G.hand.cards do
												G.hand.cards[i].states.drag.can = true
											end
											
											for i, jkr in ipairs (qa_chainTbl.eligibleJkrs) do
												SMODS.calculate_effect({
													message = CirnoMod.miscItems.pullCardFHPEditionInfo(jkr),
													colour = CirnoMod.miscItems.cardEditionTypeToColour(jkr) or G.C.FILTER
												}, jkr)
											end
											
											for i, jkr in ipairs (qa_chainTbl.scaleResponders) do
												jkr.config.center:tom_finish(jkr)
											end
											
											G.GAME.cir_tomming = nil
											return true
										else
											if qa_chainTbl.juiceStrength < 1 then
												qa_chainTbl.juiceStrength = math.min(qa_chainTbl.juiceStrength + 0.0075, 1)
											end
											
											if 
												qaEvent.delay > 0.0001
												and qa_chainTbl.eventStage > 0
											then
												qaEvent.delay = math.max(qaEvent.delay - 0.0015, 0.0001)
											end
											
											qa_chainTbl.eventStage = 0
										end
									end
									
									qaEvent.start_timer = false
									return false
								end})
							
							G.E_MANAGER:add_event(qaEvent)
						end
					end
				end
			end
		},
		-- The Carefree
		{
			key = 'carefree',
			upgradesFrom = 'j_cir_kaizur_l',
			matureRefLevel = 1,
			loadOrder = 'upgLgnd',
			cir_Friend = CirnoMod.miscItems.cirFriends.kzr,
			
			destroyed = { colours = { G.C.MONEY, CirnoMod.miscItems.colours.cirInactiveAtt, G.C.BLACK, CirnoMod.miscItems.colours.cirInactiveAtt, G.C.MONEY } },
			
			loc_txt = { name = 'The Carefree', text = { {
					'{C:green}#1# in #2#{} chance for all',
					'scored cards to permanently',
					'gain {C:attention}#3# retrigger#4#'
					}, {
					'If scoring hand contains',
					'any {C:attention}Aces{} of {C:diamonds_hc}Diamonds{},',
					'{C:green}#5# in #6#',
					'chance for {C:blue}+#7#{} hand#8#',
					'{s:0.8}(Added hands only last for that round)',
					'{s:0.8,C:inactive}This is the part of',
					'{s:0.8,C:inactive}the tourney where I',
					'{s:0.8,C:inactive}as your opponent, get',
					'{s:0.8,C:inactive}up, walk over to the',
					'{s:0.8,C:inactive}other side of you',
					'{s:0.8,C:inactive}and then coach you'
				} }
			},
			
			abiInit = function(self, card, orgRarity, orgExtTable, orgAbilityTbl)
				card.ability.extra = orgExtTable
				
				if
					not card.ability.extra
					and orgAbilityTbl
					and type(orgAbilityTbl) == 'table'
					and orgAbilityTbl.extra
				then
					card.ability.extra = orgAbilityTbl.extra
				end
				
				card.ability.extra.originalRarity = orgRarity
				
				card.ability.extra.oddsPerAce = 2
				card.ability.extra.addHands = 1
			end,
			
			postPerfInit = function(self, card, orgRarity, orgExtTable, orgAbilityTbl)
				self.abiInit(self, card, orgRarity, orgExtTable, orgAbilityTbl)
				
				card.ability.extra_value = CirnoMod.miscItems.upgradedExtraValue[orgRarity]
				card:set_cost()
			end,
			
			blueprint_compat = true,
			loc_vars = function(self, info_queue, card)
				if
					not card.ability.extra
					or type(card.ability.extra) ~= 'table'
				then
					self.abiInit(self, card, 4, { oddsNom = 2, oddsDenom = 7, retriggers = 1 })
				end
				
				local numerator, denominator = SMODS.get_probability_vars(card or self, card.ability.extra.oddsNom, card.ability.extra.oddsDenom, 'kaizurRT')
				
				local aceNumerator, aceDenominator = SMODS.get_probability_vars(card or self, 1, self:getAceDenom(card), 'kaizurAceHand')
				
				-- Art credit tooltip
				if CirnoMod.config.artCredits and not card.fake_card then
					info_queue[#info_queue + 1] = { key = "jA_NTF_Rend", set = "Other" }
				end	
				
				return { vars = {
					numerator,
					denominator,
					to_big(card.ability.extra.retriggers),
					to_big(card.ability.extra.retriggers) > to_big(1) and 's' or '',
					aceNumerator,
					aceDenominator > to_big(0) and to_big(aceDenominator) or '[Ace of Diamonds count X'..to_big(card.ability.extra.oddsPerAce)..']',
					to_big(card.ability.extra.addHands),
					to_big(card.ability.extra.addHands) > to_big(1) and 's' or ''
				} }
			end,
			
			getAceDenom = function(self, card)
				local ret = 0
				local cardsToCheck = false
				
				if G.play and G.play.cards and #G.play.cards > 0 then
					cardsToCheck = G.play.cards
					c_in_scoring = true
				elseif G.hand and G.hand.highlighted and #G.hand.highlighted > 0 then
					cardsToCheck = G.hand.highlighted
				end
				
				if cardsToCheck then
					local scoring_hand = select(4, G.FUNCS.get_poker_hand_info(cardsToCheck))
					local splash_present = next(SMODS.find_card('j_splash'))
					
					for i, pCard in ipairs(cardsToCheck) do
						if
							not pCard.debuff
							and pCard:get_id() == 14
							and pCard:is_suit('Diamonds')
						then
							local splashed = SMODS.always_scores(pCard) or splash_present
							local unsplashed = SMODS.never_scores(pCard)
							
							if not splashed then
								for _, sCard in pairs(scoring_hand) do
									if sCard == pCard then splashed = true end
								end
							end
							
							local effects = {}
							SMODS.calculate_context({ modify_scoring_hand = true, cir_kaizurCheck = true, other_card = pCard, full_hand = cardsToCheck, scoring_hand = scoring_hand, ignore_other_debuff = true }, effects)
							local flags = SMODS.trigger_effects(effects, pCard)
							if flags.add_to_hand then splashed = true end
							if flags.remove_to_hand then unsplashed = true end
							
							if splashed and not unsplashed then
								ret = to_big(ret) + to_big(card.ability.extra.oddsPerAce)
							end
						end
					end
				end
				
				return ret
			end,
			
			pos = { x = 1, y = 2 },
			soul_pos = { x = 1, y = 3 },
			cost = 30,
			eternal_compat = true,
			perishable_compat = false,
			
			calculate = function(self, card, context)
				if context.before then
					local jkrRef = context.blueprint_card or card
					local msgClr = context.cir_bp_col or false
					local addRetrig = SMODS.pseudorandom_probability(card, 'kaizurRT', card.ability.extra.oddsNom, card.ability.extra.oddsDenom)
					local addHand = false
					local buildDenom = 0
					
					if not msgClr and context.blueprint_card then
						if context.blueprint_card.config.center.key == 'j_blueprint' then
							msgClr = G.C.BLUE
						elseif context.blueprint_card.config.center.key == 'j_brainstorm' then
							msgClr = G.C.RED
						end
					end
					
					for _, pCard in ipairs(context.scoring_hand) do
						if not pCard.debuff then
							if
								pCard:get_id() == 14
								and pCard:is_suit('Diamonds')
							then
								buildDenom = to_big(buildDenom) + to_big(card.ability.extra.oddsPerAce)
							end
							
							if addRetrig then
								pCard.ability.perma_repetitions = to_big(pCard.ability.perma_repetitions) or 0
								
								G.E_MANAGER:add_event(Event({
										func = function()
											jkrRef:juice_up()
											return true
										end
									}))
								
								SMODS.scale_card(pCard, {
										ref_table = pCard.ability,
										ref_value = 'perma_repetitions',
										scalar_table = card.ability.extra,
										scalar_value = 'retriggers',
										message_colour = msgClr
									})
							end
						end
					end
					
					if
						buildDenom > to_big(0)
						and SMODS.pseudorandom_probability(card, 'kaizurAceHand', 1, buildDenom)
					then
						return { message = localize{
								type = 'variable',
								key = 'a_hands',
								vars = { to_big(card.ability.extra.addHands) }
							},
							colour = G.C.BLUE,
							func = function()
								ease_hands_played(to_big(card.ability.extra.addHands))
							end }
					end
				end
			end
		},
		-- The Connoisseur
		{
			key = 'connoisseur',
			upgradesFrom = 'j_cir_octo_l',
			
			matureRefLevel = 1,
			loadOrder = 'upgLgnd',
			cir_Friend = CirnoMod.miscItems.cirFriends.oct,
			
			destroyed = { colours = { G.C.PURPLE, G.C.BLACK, G.C.RED, G.C.PURPLE, G.C.PURPLE } },
			
			loc_txt = { name = 'The Connoisseur', text = { {
					'This Joker gains {X:purple,C:white} X#1# {} Score',
					'in response to most',
					'scaling operations',
					'{C:inactive}(Currently {X:purple,C:white} X#2# {C:inactive} Score)',
					}, {
					'Said scaling operations',
					'gain a {C:attention}X#3#{} increase in',
					'how much they scale by'
					}, {
					'Other jokers that give',
					'{C:chips}+Chips{} or {C:mult}+Mult',
					'additionally contribute half',
					'of those values as {C:purple}+Score',
					'{s:0.8,C:inactive}Yes, I deliberately looked',
					'{s:0.8,C:inactive}for the least flattering',
					'{s:0.8,C:inactive}image of Octo possible for',
					'{s:0.8,C:inactive}reference when making this'
				} }
			},
			
			abiInit = function(self, card, orgRarity, orgExtTable, orgAbilityTbl)
				card.ability.extra = orgExtTable
				
				if
					not card.ability.extra
					and orgAbilityTbl
					and type(orgAbilityTbl) == 'table'
					and orgAbilityTbl.extra
				then
					card.ability.extra = orgAbilityTbl.extra
				end
				
				card.ability.extra.originalRarity = orgRarity
				
				card.ability.extra.scaleInc = 1.5
			end,
			
			postPerfInit = function(self, card, orgRarity, orgExtTable, orgAbilityTbl)
				self.abiInit(self, card, orgRarity, orgExtTable, orgAbilityTbl)
				
				card.ability.extra_value = CirnoMod.miscItems.upgradedExtraValue[orgRarity]
				card:set_cost()
			end,
			
			blueprint_compat = true,
			loc_vars = function(self, info_queue, card)
				if
					not card.ability.extra
					or type(card.ability.extra) ~= 'table'
				then
					self.abiInit(self, card, 4, { noPerf = { scalar = 1 }, rCounter = 0 })
				end
				
				-- Art credit tooltip
				if CirnoMod.config.artCredits and not card.fake_card then
					info_queue[#info_queue + 1] = { key = "jA_NTF", set = "Other" }
				end
				
				return { vars = {
					to_big(card.ability.extra.growth),
					to_big(card.ability.extra.xscore),
					to_big(card.ability.extra.scaleInc)
				} }
			end,
			
			pos = { x = 2, y = 2 },
			soul_pos = { x = 2, y = 3 },
			cost = 30,
			eternal_compat = true,
			perishable_compat = false,
			
			tom_finish = function(self, card)
				SMODS.calculate_effect({
						message = localize({
						type = "variable",
						key = "a_xscore",
						vars = { to_big(card.ability.extra.xscore) } }),
						colour = G.C.PURPLE
					}, card)
			end,
			
			calc_scaling = function(self, card, other_card, initial_value, scalar_value, args)
				if
					scalar_value > 0
					and other_card.config.center.key ~= 'j_cir_octo_l'
					and other_card.config.center.key ~= 'j_cir_connoisseur'
				then
					local scaleTable = {
						ref_table = card.ability.extra,
						ref_value = 'xscore',
						scalar_value = 'growth',
						no_message = true
					}
					local ret = { override_scalar_value = { value = to_big(scalar_value) * to_big(card.ability.extra.scaleInc) } }
					
					if G.GAME.cir_tomming then
						scaleTable.operation = function(ref_table, ref_value, initial, change)
							ref_table[ref_value] = to_big(initial) + 0.05
						end
					else
						ret.post = {
							message = localize({
							type = "variable",
							key = "a_xscore",
							vars = { to_big(card.ability.extra.xscore) + to_big(card.ability.extra.growth) } }),
							colour = G.C.PURPLE
						}
					end
					
					SMODS.scale_card(card, scaleTable)
					
					return ret
				end
			end,
			
			calculate = function(self, card, context)
				if context.joker_main and G.GAME.chips and G.GAME.chips > 0 then
					return { xscore = to_big(card.ability.extra.xscore) }
				end
				
				if
					context.post_trigger
					and context.other_ret
				then
					local ret = { message_card = context.other_card or context.blueprint_card or card, score = 0 }
					
					for k, jkrRet in pairs(context.other_ret) do
						if jkrRet.chips then
							ret.score = to_big(ret.score) + math.floor(jkrRet.chips / 2)
						end
						
						if jkrRet.chips_mod then
							ret.score = to_big(ret.score) + math.floor(jkrRet.chips_mod / 2)
						end
						
						if jkrRet.mult then
							ret.score = to_big(ret.score) + math.floor(jkrRet.mult / 2)
						end
						
						if jkrRet.mult_mod then
							ret.score = to_big(ret.score) + math.floor(jkrRet.mult_mod / 2)
						end
					end
					
					if ret.score > 0 then
						return ret
					end
				end
			end
		},
		-- The Sadist
		{
			key = 'sadist',
			upgradesFrom = 'j_cir_nope_l',
			
			matureRefLevel = 1,
			loadOrder = 'upgLgnd',
			cir_Friend = CirnoMod.miscItems.cirFriends.ntf,
			
			destroyed = { colours = { G.C.PURPLE, CirnoMod.miscItems.colours.cirNep, G.C.BLACK, G.C.PURPLE, CirnoMod.miscItems.colours.cirNep } },
			
			loc_txt = { name = 'The Sadist', text = { {
					'This {C:joker}Joker{} gains',
					'{X:mult,C:white} X1 {} Mult from failed',
					'{C:tarot}#1#s',
					'{C:inactive}(Currently {X:mult,C:white} X#2# {C:inactive} Mult)'
					}, {
					'If played hand contains a',
					'{C:attention}#3#{}, stores',
					'all {C:attention}scored{} card values',
					'{C:inactive}(Currently {C:chips}+#4#{C:inactive} Chips {C:mult}+#5#{C:inactive} Mult,',
					'{X:chips,C:white} X#6# {C:inactive} Chips, {X:mult,C:white} X#7# {C:inactive} Mult, {C:money}#8#{C:inactive})',
					'Until a hand containing a',
					'{C:attention}Queen{} of {C:hearts_hc}Hearts',
					'is played'
					}, {
					'{C:attention}Queens{} of {C:diamonds_hc}Diamonds{} and',
					'{C:cirDM}Girl_DM_{C:joker} Jokers{C:attention} retrigger',
					'{s:0.8,C:inactive}Bias? In my house?',
					'{s:0.8,C:inactive}Nahhhhhh'
				} }
			},
			
			abiInit = function(self, card, orgRarity, orgExtTable, orgAbilityTbl)
				card.ability.extra = orgExtTable
				
				if
					not card.ability.extra
					and orgAbilityTbl
					and type(orgAbilityTbl) == 'table'
					and orgAbilityTbl.extra
				then
					card.ability.extra = orgAbilityTbl.extra
				end
				
				card.ability.extra.originalRarity = orgRarity
				
				card.ability.extra.QoH_played = false
				card.ability.extra.handType = 'Full House'
				card.ability.extra.containsFH = false
				card.ability.extra.dm_jokers = {
					j_crazy = true,
					j_devious = true,
					j_greedy_joker = true,
					j_cir_queenOfDiamonds = true,
					j_caino = true,
					j_cir_villainess = true
				}
				card.ability.extra.dmRepetitions = 1
				
				self.resetStored(card)
			end,
			
			postPerfInit = function(self, card, orgRarity, orgExtTable, orgAbilityTbl)
				self.abiInit(self, card, orgRarity, orgExtTable, orgAbilityTbl)
				
				card.ability.extra_value = CirnoMod.miscItems.upgradedExtraValue[orgRarity]
				card:set_cost()
			end,
			
			blueprint_compat = true,
			loc_vars = function(self, info_queue, card)
				info_queue[#info_queue + 1] = SMODS.shallow_copy(G.P_CENTERS.c_wheel_of_fortune)
				info_queue[#info_queue].fake_card = true
				
				-- Art credit tooltip
				if CirnoMod.config.artCredits and not card.fake_card then
					info_queue[#info_queue + 1] = { key = "jA_NTF", set = "Other" }
				end
				
				if
					not card.ability.extra
					or type(card.ability.extra) ~= 'table'
				then
					self.abiInit(self, card, 4, { growth = 1, x_mult = 1 })
				end
				
				return { vars = {
					G.localization.descriptions.Tarot.c_wheel_of_fortune.name,
					G.GAME and to_big(G.GAME.wheelFailures) > to_big(1) and to_big(G.GAME.wheelFailures) or 1,
					localize(card.ability.extra.handType, 'poker_hands'),
					to_big(card.ability.extra.stored.chips),
					to_big(card.ability.extra.stored.mult),
					to_big(card.ability.extra.stored.x_chips),
					to_big(card.ability.extra.stored.x_mult),
					to_big(card.ability.extra.stored.dollars) > to_big(0) and SMODS.signed_dollars(to_big(card.ability.extra.stored.dollars)) or '$0'
				} }
			end,
			
			pos = { x = 4, y = 2 },
			soul_pos = { x = 4, y = 3 },
			cost = 30,
			eternal_compat = true,
			perishable_compat = false,
			
			resetStored = function(card)
				card.ability.extra.stored = {
					chips = 0,
					mult = 0,
					x_chips = 1,
					x_mult = 1,
					dollars = 0
				}
			end,
			
			change_soul_pos = function(card, newSoulPos)
				card.config.center.soul_pos = newSoulPos
				card:set_sprites(card.config.center)
			end,
			
			cir_upgradeInfo = function(self, card)
				if to_big(card.ability.extra.repetitions) == to_big(1) then
					return {
						'{C:attention}Queens{} of {C:diamonds_hc}Diamonds{} and',
						'{C:cirDM}Girl_DM_{C:joker} Jokers{C:attention} retrigger',
						'->',
						'{C:attention}Queens{} of {C:diamonds_hc}Diamonds{} and',
						'{C:cirDM}Girl_DM_{C:joker} Jokers{C:attention} retrigger',
						'{C:attention}2{} times',
						'& {C:attention}all stored values X2'
					}
				end
				
				return {
					'{C:attention}Queens{} of {C:diamonds_hc}Diamonds{} and',
					'{C:cirDM}Girl_DM_{C:joker} Jokers{C:attention} retrigger',
					'{C:attention}'..to_big(card.ability.extra.dmRepetitions)'{} times',
					'->',
					'{C:attention}Queens{} of {C:diamonds_hc}Diamonds{} and',
					'{C:cirDM}Girl_DM_{C:joker} Jokers{C:attention} retrigger',
					'{C:attention}'..to_big(card.ability.extra.dmRepetitions) + to_big(1)'{} times',
					'& {C:attention}all stored values X2'
				}
			end,
			
			cir_upgrade = function(self, card)
				card.ability.extra.repetitions = to_big(card.ability.extra.dmRepetitions) + to_big(1)
				
				for k, v in pairs(card.ability.extra.stored) do
					if
						(k ~= 'x_chips'
						and k ~= 'x_mult')
						or ((k == 'x_chips'
						or k == 'x_mult')
						and to_big(v) > to_big(1))
					then
						v = to_big(v) * to_big(2)
					end
				end
				
				return { 
					message = localize('k_upgrade_ex'),
					colour = CirnoMod.miscItems.colours.cirNope
				}
			end,
			
			onWheelFail = function(self, card)
				G.E_MANAGER:add_event(Event({
					trigger = 'immediate',
					delay = 0.01,
					blocking = false,
					func = function()
						self.change_soul_pos(card, { x = 3, y = 3 })
						
						G.E_MANAGER:add_event(Event({
							trigger = 'after',
							delay = 0.3,
							blocking = false,
							func = function()
								self.change_soul_pos(card, { x = 4, y = 3 })
								return true
							end}))
						return true
					end}))
				
				return {
					message = localize({
						type = "variable",
						key = "a_xmult",
						vars = { to_big(G.GAME.wheelFailures) } }),
					delay = 1.25,
					colour = CirnoMod.miscItems.colours.cirNope,
					message_card = card,
					doNotRedSeal = true,
					no_retrigger = true
				}
			end,
			
			calculate = function(self, card, context)
				if
					not context.blueprint
					and not (context.retrigger_joker
					and not context.retrigger_joker_check)
					and (context.before
					or context.hand_drawn
					or (context.end_of_round and context.main_eval)
					or context.starting_shop)
				then
					if context.poker_hands then
						card.ability.extra.containsFH = next(context.poker_hands[card.ability.extra.handType])
					elseif card.ability.extra.containsFH then
						card.ability.extra.containsFH = false
					end
					
					if card.ability.extra.QoH_played then
						card.ability.extra.QoH_played = false
						self.resetStored(card)
					end
					
					if context.scoring_hand then
						for i, c in ipairs(context.scoring_hand) do
							if
								c:get_id() == 12
								and c:is_suit('Hearts')
							then
								card.ability.extra.QoH_played = true
								break
							end
						end
					end
				end
				
				if
					context.individual
					and (context.cardarea == G.play
					or context.cardarea == G.hand)
					-- and (context.card_effects
					-- and (next(context.card_effects[1])
					-- or #context.card_effects > 1))))
					and ((context.poker_hands
					and next(context.poker_hands[card.ability.extra.handType]))
					or (context.end_of_round
					and SMODS.last_hand.scoring_name == card.ability.extra.handType))
				then
					local jkrRef = card
					local initialX = {
						x_chips = to_big(card.ability.extra.stored.x_chips),
						x_mult = to_big(card.ability.extra.stored.x_mult)
					}
					local doReturn = false
					
					if context.cardarea == G.play then
						card.ability.extra.stored.chips = to_big(card.ability.extra.stored.chips) + to_big(context.other_card.base.nominal) + to_big(context.other_card.ability.bonus) + to_big(context.other_card.ability.perma_bonus)
					
						if to_big(context.other_card.ability.perma_mult) > to_big(0) then
							card.ability.extra.stored.mult = to_big(card.ability.extra.stored.mult) + to_big(context.other_card.ability.perma_mult)
							
							doReturn = true
						end
						
						if
							to_big(context.other_card.ability.x_chips) > to_big(0)
							or to_big(context.other_card.ability.perma_x_chips) > to_big(0)
						then
							card.ability.extra.stored.x_chips = to_big(card.ability.extra.stored.x_chips) + (context.other_card.ability.x_chips > 1 and to_big(context.other_card.ability.x_chips) or 0) + (context.other_card.ability.perma_x_chips > 1 and to_big(context.other_card.ability.perma_x_chips) or 0)
							
							if
								initialX.x_chips == to_big(1)
								and card.ability.extra.stored.x_chips > initialX.x_chips
							then
								card.ability.extra.stored.x_chips = to_big(card.ability.extra.stored.x_chips) - to_big(1)
							end
							
							doReturn = true
						end
						
						if
							to_big(context.other_card.ability.x_mult) > to_big(0)
							or to_big(context.other_card.ability.perma_x_mult) > to_big(0)
						then
							card.ability.extra.stored.x_mult = to_big(card.ability.extra.stored.x_mult) + (context.other_card.ability.x_mult > 1 and to_big(context.other_card.ability.x_mult) or 0) + (context.other_card.ability.perma_x_mult > 1 and to_big(context.other_card.ability.perma_x_mult) or 0)
							
							if
								initialX.x_mult == to_big(1)
								and card.ability.extra.stored.x_mult > initialX.x_mult
							then
								card.ability.extra.stored.x_mult = to_big(card.ability.extra.stored.x_mult) - to_big(1)
							end
							
							doReturn = true
						end
						
						if to_big(context.other_card.ability.perma_p_dollars) > to_big(0) then
							card.ability.extra.stored.dollars = to_big(card.ability.extra.stored.dollars) + to_big(context.other_card.ability.perma_p_dollars)
							
							doReturn = true
						end
						
						if context.other_card.seal and context.other_card.seal == 'Gold' then
							card.ability.extra.stored.dollars = to_big(card.ability.extra.stored.dollars) + to_big(3)
							
							doReturn = true
						end
					end
					
					--[[
					if context.other_card.ability.effect ~= 'Lucky Card' then
					card.ability.extra.stored.mult = to_big(card.ability.extra.stored.mult) + to_big(context.other_card.ability.mult)
					
					card.ability.extra.stored.dollars = to_big(card.ability.extra.stored.dollars) + to_big(context.other_card.ability.p_dollars)
					end
					]]
					
					if
						context.cardarea == G.hand
						and ((not context.end_of_round)
						or (context.other_card.ability
						and context.other_card.ability.effect == 'Gold Card'))
					then
						if to_big(context.other_card.ability.h_chips) > to_big(0) then
							card.ability.extra.stored.chips = to_big(card.ability.extra.stored.chips) + to_big(context.other_card.ability.h_chips)
							
							doReturn = true
						end
						
						if to_big(context.other_card.ability.h_mult) > to_big(0) then
							card.ability.extra.stored.mult = to_big(card.ability.extra.stored.mult) + to_big(context.other_card.ability.h_mult)
							
							doReturn = true
						end
						
						if to_big(context.other_card.ability.h_x_chips) > to_big(1) then
							card.ability.extra.stored.h_x_chips = to_big(card.ability.extra.stored.h_x_chips) + to_big(context.other_card.ability.h_x_chips)
							
							if
								initialX.x_chips == to_big(1)
								and card.ability.extra.stored.x_chips > initialX.x_chips
							then
								card.ability.extra.stored.x_chips = to_big(card.ability.extra.stored.x_chips) - to_big(1)
							end
							
							doReturn = true
						end
						
						if to_big(context.other_card.ability.h_x_mult) > to_big(1) then
							card.ability.extra.stored.x_mult = to_big(card.ability.extra.stored.x_mult) + to_big(context.other_card.ability.h_x_mult)
							
							if
								initialX.x_mult == to_big(1)
								and card.ability.extra.stored.x_mult > initialX.x_mult
							then
								card.ability.extra.stored.x_mult = to_big(card.ability.extra.stored.x_mult) - to_big(1)
							end
							
							doReturn = true
						end
						
						if
							to_big(context.other_card.ability.h_dollars) > to_big(0)
							and not ((context.other_card.ability
							and context.other_card.ability.effect == 'Gold Card') and not context.end_of_round)
						then
							card.ability.extra.stored.dollars = to_big(card.ability.extra.stored.dollars) + to_big(context.other_card.ability.h_dollars)
							
							doReturn = true
						end
					end
					
					if doReturn then
						return {
							func = function()
								G.E_MANAGER:add_event(Event({
									trigger = 'after',
									delay = 0.1,
									func = function()
										jkrRef:juice_up()
										return true
									end}))
								end,
							no_juice = true
						}
					end
				end
				
				if context.joker_main then
					local ret = {
						x_mult = to_big(G.GAME.wheelFailures),
						colour = CirnoMod.miscItems.colours.cirNope
					}
					ret.doNotRedSeal = ret.x_mult == 1
					ret.no_retrigger = ret.doNotRedSeal
					
					if card.ability.extra.QoH_played then
						for retKey, retVal in pairs(card.ability.extra.stored) do
							if
								((retKey == 'x_chips'
								or retKey == 'x_mult')
								and retVal > 1)
								or (not (retKey == 'x_chips'
								or retKey == 'x_mult')
								and retVal > 0)
							then
								if retKey == 'x_mult' then
									ret.x_mult = to_big(ret.x_mult) + to_big(retVal)
								else
									ret[retKey] = to_big(retVal)
								end
								
								if ret.doNotRedSeal or ret.no_retrigger then
									ret.doNotRedSeal = false
									ret.no_retrigger = false
								end
							end
						end
					end
					
					return ret
				end
				
				if
					context.pseudorandom_result
					and context.trigger_obj
					and card.ability.extra.containsFH
					and context.trigger_obj.ability -- nil check
				then
					local doReturn = false
					
					if 
						context.result
						and context.trigger_obj.ability.effect == 'Lucky Card'
					then
						if context.identifier == 'lucky_mult' then
							card.ability.extra.stored.mult = to_big(card.ability.extra.stored.mult) + to_big(context.trigger_obj.ability.mult)
						end
						
						if context.identifier == 'lucky_money' then
							card.ability.extra.stored.dollars = to_big(card.ability.extra.stored.dollars) + to_big(context.trigger_obj.ability.p_dollars)
						end
						
						doReturn = true
					elseif context.trigger_obj.ability.effect == 'Glass Card' then
						local initialXmult = to_big(card.ability.extra.stored.x_mult)
						
						card.ability.extra.stored.x_mult = to_big(card.ability.extra.stored.x_mult) + to_big(context.trigger_obj.ability.extra.multiplier)
						
						if to_big(initialXmult) == to_big(1) then
							card.ability.extra.stored.x_mult = to_big(card.ability.extra.stored.x_mult) - to_big(1)
						end
						
						doReturn = true
					end
					
					if doReturn then
						local jkrRef = card
						
						return {
							func = function()
								G.E_MANAGER:add_event(Event({
									trigger = 'after',
									delay = 0.1,
									func = function()
										jkrRef:juice_up()
										return true
									end}))
								end,
							no_juice = true
						}
					end
				end
				
				if
					(context.repetition
					and (context.cardarea == G.play
					or context.cardarea == G.hand)
					and context.other_card:get_id() == 12
					and context.other_card:is_suit('Diamonds'))
					or (context.retrigger_joker_check
					and card.ability.extra.dm_jokers[context.other_joker and context.other_joker.config.center.key or nil])
				then
					return { repetitions = to_big(card.ability.extra.dmRepetitions), colour = CirnoMod.miscItems.colours.cirNope }
				end
			end
		},
		-- Dawnbreaker
		{
			key = 'dawnbreaker',
			upgradesFrom = 'j_cir_zayne',
			
			matureRefLevel = 1,
			loadOrder = 'upgKpsk',
			cir_Friend = CirnoMod.miscItems.cirFriends.dm,
			
			loc_txt = { name = 'Dawnbreaker', text = { {
					'Played cards without an',
					'{C:attention}enhancement{} have a',
					'{C:green}#1# in #2#{} chance of',
					'becoming {C:attention}#3#s'
					}, {
					'{C:attention}#3#s{} that break are',
					'immediately recreated',
					'with {C:green}+#4#{} to their',
					'{C:green}denumerator{} and an',
					'additional {X:mult,C:white} X#5# {} Mult,',
					'but are {C:red}debuffed{} until',
					'the {C:attention}next Ante',
					'{s:0.8,C:inactive}"Dying with a clear mind',
					'{s:0.8,C:inactive}is better than living',
					'{s:0.8,C:inactive}as a walking corpse."'
				} }
			},
			
			abiInit = function(card, orgRarity, orgExtTable, orgAbilityTbl)
				card.ability.extra = orgExtTable
				
				if
					not card.ability.extra
					and orgAbilityTbl
					and type(orgAbilityTbl) == 'table'
					and orgAbilityTbl.extra
				then
					card.ability.extra = orgAbilityTbl.extra
				end
				
				card.ability.extra.originalRarity = orgRarity
				G.GAME.EoA_cardUndebuff = true
				
				card.ability.extra.extDenom = 1
				card.ability.extra.extXMult = 2
			end,
			
			postPerfInit = function(self, card, orgRarity, orgExtTable, orgAbilityTbl)
				self.abiInit(card, orgRarity, orgExtTable, orgAbilityTbl)
				
				card.ability.extra_value = CirnoMod.miscItems.upgradedExtraValue[orgRarity]
				card:set_cost()
			end,
			
			loc_vars = function(self, info_queue, card)				
				info_queue[#info_queue + 1] = SMODS.shallow_copy(G.P_CENTERS.m_glass)
				info_queue[#info_queue].fake_card = true
				
				info_queue[#info_queue + 1] = { key = "extraDenominator", set = "Other" }
				
				-- Art credit tooltip
				if CirnoMod.config.artCredits and not card.fake_card then
					info_queue[#info_queue + 1] = { key = "kA_zayne", set = "Other" }
				end
				
				if
					not card.ability.extra
					or type(card.ability.extra) ~= 'table'
				then
					self.abiInit(card, 'cir_keepsake_r', { odds = 4 })
				end
				
				local numerator, denominator = SMODS.get_probability_vars(card or self, 1, card.ability.extra.odds, 'zayneIce')
				
				return { vars = {
					numerator,
					denominator,
					localize{ type = 'name_text', key = 'm_glass', set = 'Enhanced' },
					to_big(card.ability.extra.extDenom),
					to_big(card.ability.extra.extXMult)
				} }
			end,
			
			pos = { x = 6, y = 7 },
			eternal_compat = false,
			perishable_compat = false,
			
			can_sell = function(self, card, context)
				return false
			end,
			
			cir_upgradeInfo = function(self, card)				
				return {
					'{X:mult,C:white} X'..to_big(card.ability.extra.extXMult)..' {} Mult growth',
					'->',
					'{X:mult,C:white} X'..to_big(card.ability.extra.extXMult)+to_big(1)..' {} Mult growth',
					'(Not retroactive (Could you imagine x.x))'
				}
			end,
			
			cir_upgrade = function(self, card)
				card.ability.extra.extXMult = to_big(card.ability.extra.extXMult) + to_big(1)
				
				return {  message = localize('k_upgrade_ex') }
			end,
			
			calculate = function(self, card, context)
				if
					not context.blueprint
					and not context.retrigger_joker
					and not context.retrigger_joker_check
				then					
					if
						context.mod_probability
						and context.identifier == 'glass'
						and context.trigger_obj
						and context.trigger_obj.ability
						and context.trigger_obj.ability.extra.dwn_extDenom
					then
						return { denominator = context.denominator + context.trigger_obj.ability.extra.dwn_extDenom }
					end
					
					if context.before then
						local cardsToChange = {}
						
						for _, pCard in ipairs(G.play.cards) do
							if
								not next(SMODS.get_enhancements(pCard))
								and pCard:can_calculate()
								and SMODS.pseudorandom_probability(card, 'zayneIce', 1, card.ability.extra.odds)
							then
								table.insert(cardsToChange, pCard)
							end
						end
						
						if #cardsToChange > 0 then
							local jkrRef = card
							local percent = 1
							
							for _, pCard in ipairs(cardsToChange) do
								CirnoMod.miscItems.flippyFlip.fStart(pCard, percent)
							end
							
							return { doNotRedSeal = true,
								no_retrigger = true,
								no_juice = true,
								func = function()
									for _, pCard in ipairs(cardsToChange) do
										pCard:set_ability('m_glass', nil, true)
										
										G.E_MANAGER:add_event(Event({
											trigger = 'after',
											delay = 0.0,
											func = function()
												pCard:juice_up()
												jkrRef:juice_up()
												return true
											end}))
										
										CirnoMod.miscItems.flippyFlip.fEnd(pCard, percent)
									end
								end
							}
						end
					end
				end
				
				if context.remove_playing_cards and context.removed then
					local breakingIce = {}
					
					for _, pCard in ipairs(context.removed) do
						if pCard.glass_trigger then
							table.insert(breakingIce, pCard)
						end
					end
					
					if #breakingIce > 0 then
						local jkrRef = card
						
						return { no_juice = true, func = function()
							G.E_MANAGER:add_event(Event({
								trigger = 'immediate',
								blocking = true,
								blockable = true,
								func = function()
									local createdCopies = {}
									
									for i, pCard in ipairs(breakingIce) do
										G.playing_card = (G.playing_card and G.playing_card + 1) or 1
										local copy = copy_card(pCard, nil, nil, G.playing_card)
										
										copy:add_to_deck()
										
										SMODS.scale_card(copy, {
											ref_table = copy.ability.extra,
											ref_value = 'multiplier',
											scalar_table = jkrRef.ability.extra,
											scalar_value = 'extXMult',
											no_message = true
										})
										
										copy.ability.extra.dwn_extDenom = copy.ability.extra.dwn_extDenom or 0
										
										SMODS.scale_card(copy, {
											ref_table = copy.ability.extra,
											ref_value = 'dwn_extDenom',
											scalar_table = jkrRef.ability.extra,
											scalar_value = 'extDenom',
											no_message = true
										})
										
										G.deck.config.card_limit = G.deck.config.card_limit + 1
										table.insert(G.playing_cards, copy)
										G.deck:emplace(copy)
										
										SMODS.debuff_card(copy, true, 'cir_crd_autoEOAUndebuff')
										
										copy.states.visible = nil
										
										copy:start_materialize()
									end
									
									jkrRef:juice_up()
																		
									SMODS.calculate_context({ playing_card_added = true, cards = { createdCopies } })
								return true
								end }))
						end }
					end
				end
			end
		},
		-- THE Queen of Diamonds
		{
			key = 'queenOfDiamonds',
			upgradesFrom = 'j_greedy_joker',
			mutuallyExclusive = true,
			
			matureRefLevel = 1,
			loadOrder = 'upgCmn',
			cir_Friend = CirnoMod.miscItems.cirFriends.dm,
			
			loc_txt = { name = 'THE Queen Of Diamonds',
				text = { {
					'Played cards with',
                    '{C:diamonds_hc}#1#{} suit give',
                    '{C:mult}+#2#{} Mult when scored'
					}, {
					'Scored {C:attention}Queens{} of {C:diamonds_hc}#1#',
					'give {X:mult,C:white} X#3# {} Mult',
					'{s:0.8,C:inactive}Gwenchana, ding ding ding ding ding'
				} }
			},
			
			abiInit = function(card, orgRarity, orgExtTable, orgAbilityTbl)
				card.ability.extra = orgExtTable
				
				if
					not card.ability.extra
					and orgAbilityTbl
					and type(orgAbilityTbl) == 'table'
					and orgAbilityTbl.extra
				then
					card.ability.extra = orgAbilityTbl.extra
				end
				
				card.ability.extra.originalRarity = orgRarity
				
				card.ability.extra.s_mult = to_big(card.ability.extra.s_mult) + to_big(2)
				card.ability.extra.s_x_mult = 1.5
			end,
			
			postPerfInit = function(self, card, orgRarity, orgExtTable, orgAbilityTbl)
				self.abiInit(card, orgRarity, orgExtTable, orgAbilityTbl)
				
				card.ability.extra_value = CirnoMod.miscItems.upgradedExtraValue[orgRarity]
				card:set_cost()
			end,
			
			blueprint_compat = true,
			loc_vars = function(self, info_queue, card)
				if CirnoMod.config.artCredits and not card.fake_card then
					info_queue[#info_queue + 1] = { key = 'jA_DaemonTsun_NTFEdit', set = 'Other' }
				end
				
				if
					not card.ability.extra
					or type(card.ability.extra) ~= 'table'
				then
					self.abiInit(card, 1, { suit = 'Diamonds', s_mult = 3 })
				end
				
				return { vars = {
					card.ability.extra.suit,
					to_big(card.ability.extra.s_mult),
					to_big(card.ability.extra.s_x_mult)
				} }
			end,
			
			pos = { x = 8, y = 2 },
			soul_pos = { x = 8, y = 3 },
			eternal_compat = true,
			perishable_compat = true,
			
			cir_upgradeInfo = function(self, card)
				return {
					'{C:diamonds_hc}'..card.ability.extra.suit..'{} give',
					'{C:mult}+'..to_big(card.ability.extra.s_mult)..'{} Mult',
					'And {C:attention}Queens',
					'of {C:diamonds_hc}'..card.ability.extra.suit,
					'{X:mult,C:white}X'..to_big(card.ability.extra.s_x_mult)..'{} Mult',
					'->',
					'{C:diamonds_hc}'..card.ability.extra.suit..'{} give',
					'{C:mult}+'..to_big(card.ability.extra.s_mult) + to_big(5)..'{} Mult',
					'And {C:attention}Queens',
					'of {C:diamonds_hc}'..card.ability.extra.suit,
					'{X:mult,C:white}X'..to_big(card.ability.extra.s_x_mult) + to_big(1)..'{} Mult'
				}
			end,
			
			cir_upgrade = function(self, card)
				card.ability.s_mult = to_big(card.ability.s_mult) + to_big(5)
				card.ability.s_x_mult = to_big(card.ability.s_x_mult) + to_big(1)
				
				return { message = localize('k_upgrade_ex'), colour = G.C.MULT }
			end,
			
			calculate = function(self, card, context)
				if
					context.individual
					and context.cardarea == G.play
					and context.other_card:is_suit(card.ability.extra.suit)
				then
					local ret = { mult = to_big(card.ability.extra.s_mult) }
					
					if context.other_card:get_id() == 12 then
						ret.x_mult = to_big(card.ability.extra.s_x_mult)
					end
					
					return ret
				end
			end
		},
		-- THE King of Hearts
		{
			key = 'kingOfHearts',
			upgradesFrom = 'j_lusty_joker',
			mutuallyExclusive = true,
			
			matureRefLevel = 1,
			loadOrder = 'upgCmn',
			cir_Friend = CirnoMod.miscItems.cirFriends.han,
			
			loc_txt = { name = 'THE King Of Hearts',
				text = { {
					'Played cards with',
                    '{C:hearts_hc}#1#{} suit give',
                    '{C:mult}+#2#{} Mult when scored'
					}, {
					'Scored {C:attention}Kings{} of {C:hearts_hc}#1#',
					'give {X:mult,C:white} X#3# {} Mult',
					'{s:0.8,C:inactive}"This is my house',
					'{s:0.8,C:inactive}can you get out of here?"'
				} }
			},
			
			abiInit = function(card, orgRarity, orgExtTable, orgAbilityTbl)
				card.ability.extra = orgExtTable
				
				if
					not card.ability.extra
					and orgAbilityTbl
					and type(orgAbilityTbl) == 'table'
					and orgAbilityTbl.extra
				then
					card.ability.extra = orgAbilityTbl.extra
				end
				
				card.ability.extra.originalRarity = orgRarity
				
				card.ability.extra.s_mult = to_big(card.ability.extra.s_mult) + to_big(2)
				card.ability.extra.s_x_mult = 1.5
			end,
			
			postPerfInit = function(self, card, orgRarity, orgExtTable, orgAbilityTbl)
				self.abiInit(card, orgRarity, orgExtTable, orgAbilityTbl)
				
				card.ability.extra_value = CirnoMod.miscItems.upgradedExtraValue[orgRarity]
				card:set_cost()
			end,
			
			blueprint_compat = true,
			loc_vars = function(self, info_queue, card)
				if CirnoMod.config.artCredits and not card.fake_card then
					info_queue[#info_queue + 1] = { key = 'jA_DaemonTsun_NTFEdit', set = 'Other' }
				end
				
				if
					not card.ability.extra
					or type(card.ability.extra) ~= 'table'
				then
					self.abiInit(card, 1, { suit = 'Hearts', s_mult = 3 })
				end
				
				return { vars = {
					card.ability.extra.suit,
					to_big(card.ability.extra.s_mult),
					to_big(card.ability.extra.s_x_mult)
				} }
			end,
			
			pos = { x = 9, y = 2 },
			soul_pos = { x = 9, y = 3 },
			eternal_compat = true,
			perishable_compat = true,
			
			cir_upgradeInfo = function(self, card)
				return {
					'{C:hearts_hc}'..card.ability.extra.suit..'{} give',
					'{C:mult}+'..to_big(card.ability.extra.s_mult)..'{} Mult',
					'And {C:attention}Kings',
					'of {C:hearts_hc}'..card.ability.extra.suit,
					'{X:mult,C:white}X'..to_big(card.ability.extra.s_x_mult)..'{} Mult',
					'->',
					'{C:hearts_hc}'..card.ability.extra.suit..'{} give',
					'{C:mult}+'..to_big(card.ability.extra.s_mult) + to_big(5)..'{} Mult',
					'And {C:attention}Kings',
					'of {C:hearts_hc}'..card.ability.extra.suit,
					'{X:mult,C:white}X'..to_big(card.ability.extra.s_x_mult) + to_big(1)..'{} Mult'
				}
			end,
			
			cir_upgrade = function(self, card)
				card.ability.s_mult = to_big(card.ability.s_mult) + to_big(5)
				card.ability.s_x_mult = to_big(card.ability.s_x_mult) + to_big(1)
				
				return { message = localize('k_upgrade_ex'), colour = G.C.MULT }
			end,
			
			calculate = function(self, card, context)
				if
					context.individual
					and context.cardarea == G.play
					and context.other_card:is_suit(card.ability.extra.suit)
				then
					local ret = { mult = to_big(card.ability.extra.s_mult) }
					
					if context.other_card:get_id() == 13 then
						ret.x_mult = to_big(card.ability.extra.s_x_mult)
					end
					
					return ret
				end
			end
		},
		-- THE Queen of Spades
		{
			key = 'queenOfSpades',
			upgradesFrom = 'j_wrathful_joker',
			mutuallyExclusive = true,
			
			matureRefLevel = 1,
			loadOrder = 'upgCmn',
			cir_Friend = CirnoMod.miscItems.cirFriends.dck,
			
			loc_txt = { name = 'THE Queen Of Spades',
				text = { {
					'Played cards with',
                    '{C:spades_hc}#1#{} suit give',
                    '{C:mult}+#2#{} Mult when scored'
					}, {
					'Scored {C:attention}Queens{} of {C:spades_hc}#1#',
					'give {X:mult,C:white} X#3# {} Mult',
					'{s:0.8,C:inactive}"Guys, I\'m not evil"'
				} }
			},
			
			abiInit = function(card, orgRarity, orgExtTable, orgAbilityTbl)
				card.ability.extra = orgExtTable
				
				if
					not card.ability.extra
					and orgAbilityTbl
					and type(orgAbilityTbl) == 'table'
					and orgAbilityTbl.extra
				then
					card.ability.extra = orgAbilityTbl.extra
				end
				
				card.ability.extra.originalRarity = orgRarity
				
				card.ability.extra.s_mult = to_big(card.ability.extra.s_mult) + to_big(2)
				card.ability.extra.s_x_mult = 1.5
			end,
			
			postPerfInit = function(self, card, orgRarity, orgExtTable, orgAbilityTbl)
				self.abiInit(card, orgRarity, orgExtTable, orgAbilityTbl)
				
				card.ability.extra_value = CirnoMod.miscItems.upgradedExtraValue[orgRarity]
				card:set_cost()
			end,
			
			blueprint_compat = true,
			loc_vars = function(self, info_queue, card)
				if CirnoMod.config.artCredits and not card.fake_card then
					info_queue[#info_queue + 1] = { key = 'jA_DaemonTsun_NTFEdit', set = 'Other' }
				end
				
				if
					not card.ability.extra
					or type(card.ability.extra) ~= 'table'
				then
					self.abiInit(card, 1, { suit = 'Spades', s_mult = 3 })
				end
				
				return { vars = {
					card.ability.extra.suit,
					to_big(card.ability.extra.s_mult),
					to_big(card.ability.extra.s_x_mult)
				} }
			end,
			
			pos = { x = 0, y = 4 },
			soul_pos = { x = 1, y = 4 },
			eternal_compat = true,
			perishable_compat = true,
			
			cir_upgradeInfo = function(self, card)
				return {
					'{C:spades_hc}'..card.ability.extra.suit..'{} give',
					'{C:mult}+'..to_big(card.ability.extra.s_mult)..'{} Mult',
					'And {C:attention}Queens',
					'of {C:spades_hc}'..card.ability.extra.suit,
					'{X:mult,C:white}X'..to_big(card.ability.extra.s_x_mult)..'{} Mult',
					'->',
					'{C:spades_hc}'..card.ability.extra.suit..'{} give',
					'{C:mult}+'..to_big(card.ability.extra.s_mult) + to_big(5)..'{} Mult',
					'And {C:attention}Queens',
					'of {C:spades_hc}'..card.ability.extra.suit,
					'{X:mult,C:white}X'..to_big(card.ability.extra.s_x_mult) + to_big(1)..'{} Mult'
				}
			end,
			
			cir_upgrade = function(self, card)
				card.ability.s_mult = to_big(card.ability.s_mult) + to_big(5)
				card.ability.s_x_mult = to_big(card.ability.s_x_mult) + to_big(1)
				
				return { message = localize('k_upgrade_ex'), colour = G.C.MULT }
			end,
			
			calculate = function(self, card, context)
				if
					context.individual
					and context.cardarea == G.play
					and context.other_card:is_suit(card.ability.extra.suit)
				then
					local ret = { mult = to_big(card.ability.extra.s_mult) }
					
					if context.other_card:get_id() == 12 then
						ret.x_mult = to_big(card.ability.extra.s_x_mult)
					end
					
					return ret
				end
			end
		},
		-- THE Queen of Clubs
		{
			key = 'queenOfClubs',
			upgradesFrom = 'j_gluttenous_joker',
			mutuallyExclusive = true,
			
			matureRefLevel = 1,
			loadOrder = 'upgCmn',
			cir_Friend = CirnoMod.miscItems.cirFriends.cir,
			
			loc_txt = { name = 'THE Queen Of Clubs',
				text = { {
					'Played cards with',
                    '{C:clubs_hc}#1#{} suit give',
                    '{C:mult}+#2#{} Mult when scored'
					}, {
					'Scored {C:attention}Queens{} of {C:clubs_hc}#1#',
					'give {X:mult,C:white} X#3# {} Mult',
					'{s:0.8,C:inactive}"I\'m being ironic."',
					'{s:0.8,C:inactive}(He wasn\'t.)'
				} }
			},
			
			abiInit = function(card, orgRarity, orgExtTable, orgAbilityTbl)
				card.ability.extra = orgExtTable
				
				if
					not card.ability.extra
					and orgAbilityTbl
					and type(orgAbilityTbl) == 'table'
					and orgAbilityTbl.extra
				then
					card.ability.extra = orgAbilityTbl.extra
				end
				
				card.ability.extra.originalRarity = orgRarity
				
				card.ability.extra.s_mult = to_big(card.ability.extra.s_mult) + to_big(2)
				card.ability.extra.s_x_mult = 1.5
			end,
			
			postPerfInit = function(self, card, orgRarity, orgExtTable, orgAbilityTbl)
				self.abiInit(card, orgRarity, orgExtTable, orgAbilityTbl)
				
				card.ability.extra_value = CirnoMod.miscItems.upgradedExtraValue[orgRarity]
				card:set_cost()
			end,
			
			blueprint_compat = true,
			loc_vars = function(self, info_queue, card)
				if CirnoMod.config.artCredits and not card.fake_card then
					info_queue[#info_queue + 1] = { key = 'jA_DaemonTsun_NTFEdit', set = 'Other' }
				end
				
				if
					not card.ability.extra
					or type(card.ability.extra) ~= 'table'
				then
					self.abiInit(card, 1, { suit = 'Clubs', s_mult = 3 })
				end
				
				return { vars = {
					card.ability.extra.suit,
					to_big(card.ability.extra.s_mult),
					to_big(card.ability.extra.s_x_mult)
				} }
			end,
			
			pos = { x = 2, y = 4 },
			soul_pos = { x = 3, y = 4 },
			eternal_compat = true,
			perishable_compat = true,
			
			cir_upgradeInfo = function(self, card)
				return {
					'{C:clubs_hc}'..card.ability.extra.suit..'{} give',
					'{C:mult}+'..to_big(card.ability.extra.s_mult)..'{} Mult',
					'And {C:attention}Queens',
					'of {C:clubs_hc}'..card.ability.extra.suit,
					'{X:mult,C:white}X'..to_big(card.ability.extra.s_x_mult)..'{} Mult',
					'->',
					'{C:clubs_hc}'..card.ability.extra.suit..'{} give',
					'{C:mult}+'..to_big(card.ability.extra.s_mult) + to_big(5)..'{} Mult',
					'And {C:attention}Queens',
					'of {C:clubs_hc}'..card.ability.extra.suit,
					'{X:mult,C:white}X'..to_big(card.ability.extra.s_x_mult) + to_big(1)..'{} Mult'
				}
			end,
			
			cir_upgrade = function(self, card)
				card.ability.s_mult = to_big(card.ability.s_mult) + to_big(5)
				card.ability.s_x_mult = to_big(card.ability.s_x_mult) + to_big(1)
				
				return { message = localize('k_upgrade_ex'), colour = G.C.MULT }
			end,
			
			calculate = function(self, card, context)
				if
					context.individual
					and context.cardarea == G.play
					and context.other_card:is_suit(card.ability.extra.suit)
				then
					local ret = { mult = to_big(card.ability.extra.s_mult) }
					
					if context.other_card:get_id() == 12 then
						ret.x_mult = to_big(card.ability.extra.s_x_mult)
					end
					
					return ret
				end
			end
		},
		-- Lookin Cool Joker
		{
			key = 'lookinCoolJoker',
			upgradesFrom = 'j_joker',
			
			matureRefLevel = 1,
			loadOrder = 'upgCmn',
			cir_Friend = {
				CirnoMod.miscItems.cirFriends.cir,
				CirnoMod.miscItems.cirFriends.dm,
				CirnoMod.miscItems.cirFriends.thr
			},
			
			loc_txt = { name = 'Lookin\' Cool, Joker!',
				text = {
					'{X:mult,C:white} X#1# {} Mult',
					'{s:0.8,C:inactive}Go to bed'
				}
			},
			
			abiInit = function(card, orgRarity)
				card.ability.extra = { originalRarity = orgRarity }
				
				card.ability.x_mult = 2
				card.ability.mult = 0
			end,
			
			postPerfInit = function(self, card, orgRarity, orgExtTable, orgAbilityTbl)
				self.abiInit(card, orgRarity)
				
				card.ability.extra_value = CirnoMod.miscItems.upgradedExtraValue[orgRarity]
				card:set_cost()
			end,	
			
			blueprint_compat = true,
			loc_vars = function(self, info_queue, card)
				if CirnoMod.config.artCredits and not card.fake_card then
					info_queue[#info_queue + 1] = { key = 'jA_NTF_Rend', set = 'Other' }
				end
				
				if
					not card.ability.extra
					or type(card.ability.extra) ~= 'table'
				then
					self.abiInit(card, 1)
				end
				
				return { vars = { to_big(card.ability.x_mult) } }
			end,
			
			pos = { x = 4, y = 4 },
			eternal_compat = true,
			perishable_compat = true,
			
			cir_upgradeInfo = function(self, card)
				return {
					'{X:mult,C:white}X'..to_big(card.ability.x_mult)..'{} Mult',
					'->',
					'{X:mult,C:white}X'..to_big(card.ability.x_mult) * to_big(2)..'{} Mult'
				}
			end,
			
			cir_upgrade = function(self, card)
				card.ability.x_mult = to_big(card.ability.x_mult) * to_big(2)
				
				return { message = localize('k_upgrade_ex'), colour = G.C.MULT }
			end,
			
			calculate = function(self, card, context)
				if joker_main then
					return { x_mult = to_big(card.ability.x_mult) }
				end
			end
		},
		-- Scarlet Police Ghetto Patrol
		{
			key = 'SPGP',
			upgradesFrom = 'j_raised_fist',
			mutuallyExclusive = true,
			
			matureRefLevel = 1,
			loadOrder = 'upgCmn',
			
			loc_txt = { name = 'Scarlet Police Ghetto Patrol',
				text = {
					'{X:chips,C:white}XChips{} equal to the {C:attention}lowest',
                    'ranked card held in hand',
					'{s:0.8,C:inactive}Funky!'
				}
			},
			
			postPerfInit = function(self, card, orgRarity, orgExtTable, orgAbilityTbl)
				card.ability.extra = { originalRarity = orgRarity }
				
				card.ability.extra_value = CirnoMod.miscItems.upgradedExtraValue[orgRarity]
				card:set_cost()
			end,
			
			blueprint_compat = true,
			loc_vars = function(self, info_queue, card)
				if CirnoMod.config.artCredits and not card.fake_card then
					info_queue[#info_queue + 1] = { key = 'jA_NTF_Rend', set = 'Other' }
				end
				
				return nil
			end,
			
			pos = { x = 5, y = 4 },
			eternal_compat = true,
			perishable_compat = true,
			
			calculate = function(self, card, context)
				if context.initial_scoring_step then
					local lowest_card_ind = nil
					
					for i = 1, #G.hand.cards do
						if
							lowest_card_ind == nil
							or CirnoMod.miscItems.cardRanksToValues_AceLow[CirnoMod.miscItems.ID_To_String[G.hand.cards[i]:get_id()]] or 0 <= CirnoMod.miscItems.cardRanksToValues_AceLow[CirnoMod.miscItems.ID_To_String[G.hand.cards[lowest_card_ind]:get_id()]] or 1
						then
							lowest_card_ind = i
						end
					end
					
					if lowest_card_ind then
						G.hand.cards[lowest_card_ind].lowest_card = true
					end
				end
				
				if
					(context.hand_drawn
					or (context.end_of_round and context.main_eval))					
					and not context.game_over
				then
					for i = 1, #G.hand.cards do
						if G.hand.cards[i].lowest_card then
							G.hand.cards[i].lowest_card = false
						end
					end
				end
				
				if
					context.individual
					and context.cardarea == G.hand
					and not context.end_of_round
					and context.other_card.lowest_card
				then
					if context.other_card.debuff then
						return {
							doNotRedSeal = true,
							no_retrigger = true,
							message = localize('k_debuffed'),
							colour = G.C.RED
						}
					else
						return { x_chips = to_big(CirnoMod.miscItems.cardRanksToValues_AceLow[CirnoMod.miscItems.ID_To_String[context.other_card:get_id()]] or 1) }
					end
				end
			end
		},
		-- Cirno's Perfect Freeze
		{
			key = 'perfectFreeze',
			upgradesFrom = 'j_glass',
			mutuallyExclusive = true,
			
			matureRefLevel = 1,
			loadOrder = 'upgUncmn',
			
			loc_txt = { name = 'Cirno\'s Perfect Freeze',
				text = { {
					'This Joker gains {X:chips,C:white} X#1# {} Chips',
                    'for every destroyed {C:attention}#2#',
                    '{C:inactive}(Currently {X:chips,C:white} X#3# {C:inactive} Chips)'
					}, {
					'{C:attention}#2#s{} give {X:chips,C:white}XChips',
                    'instead of {X:mult,C:white}XMult',
					' ',
					'The odds for {C:attention}#2#s',
					'breaking are now {C:green}#4# in #5#'
					}, {
					'Played cards without an',
					'{C:attention}enhancement{} have a',
					'{C:green}#6# in #7#{} chance',
					'to become {C:attention}#2#s',
					'{s:0.8}(Guaranteed for{s:0.8,C:attention}9s{s:0.8})',
					'{s:0.8,C:inactive}"I\'m CIRNO TELEVISION!',
					'{s:0.8,C:inactive}Of course I\'ll get accepted"'
				} }
			},
			
			abiInit = function(card, orgRarity, orgAbilityTbl)
				card.ability.extra = {
					originalRarity = orgRarity,
					growth = 1,
					x_chips = orgAbilityTbl.x_mult,
					odds = 9
				}
			end,
			
			postPerfInit = function(self, card, orgRarity, orgExtTable, orgAbilityTbl)
				self.abiInit(card, orgRarity, orgAbilityTbl)
				
				card.ability.extra_value = CirnoMod.miscItems.upgradedExtraValue[orgRarity]
				card:set_cost()
			end,
			
			blueprint_compat = true,
			loc_vars = function(self, info_queue, card)
				info_queue[#info_queue + 1] = G.P_CENTERS.m_glass
				
				if CirnoMod.config.artCredits and not card.fake_card then
					info_queue[#info_queue + 1] = { key = 'jA_DaemonTsun_BigNTFEdit', set = 'Other' }
				end
				
				if
					not card.ability.extra
					or type(card.ability.extra) ~= 'table'
				then
					self.abiInit(card, 2, { x_mult = 1 })
				end
				
				local breakNom, breakDenom = SMODS.get_probability_vars(card or self, 1, card.ability.extra.odds, 'm_glass')
				
				local iceNom, iceDenom = SMODS.get_probability_vars(card or self, 1, card.ability.extra.odds, 'perfectFreeze')
				
				return { vars = {
					to_big(card.ability.extra.growth),
					localize{ type = 'name_text', key = 'm_glass', set = 'Enhanced' },
					to_big(card.ability.extra.x_chips),
					breakNom,
					breakDenom,
					iceNom,
					iceDenom
				} }
			end,
			
			pos = { x = 8, y = 4 },
			eternal_compat = true,
			perishable_compat = false,
			
			cir_upgradeInfo = function(self, card)
				return {
					'{X:chips,C:white}X'..to_big(card.ability.extra.growth)..'{} Chips scaling',
					'->',
					'{X:chips,C:white}X'..to_big(card.ability.extra.growth) + to_big(0.5)..'{} Chips scaling'
				}
			end,
			
			cir_upgrade = function(self, card)
				card.ability.extra.growth = to_big(card.ability.extra.growth) + to_big(0.5)
				
				return { message = localize('k_upgrade_ex'), colour = G.C.CHIPS }
			end,
			
			calculate = function(self, card, context)
				if not context.blueprint then
					if context.before then
						local cardsToSet = {}
						
						for i, c in ipairs(context.full_hand) do
							if
								not next(SMODS.get_enhancements(c))
								and (c:get_id() == 9
								or SMODS.pseudorandom_probability(card, 'perfectFreeze', 1, card.ability.extra.odds))
							then
								table.insert(cardsToSet, c)
							end
						end
						
						if #cardsToSet > 0 then
							for _, pCard in ipairs(cardsToSet) do
								CirnoMod.miscItems.flippyFlip.fStart(pCard)
								
								G.E_MANAGER:add_event(Event({
									trigger = 'immediate',
									blocking = true,
									blockable = true,
									func = function()								
										pCard:set_ability('m_glass')
										return true 
									end }))
								
								CirnoMod.miscItems.flippyFlip.fEnd(pCard)
							end
						end
					end
					
					if
						context.remove_playing_cards
						or (context.using_consumeable
						and context.consumeable.config.center.key == 'c_hanged_man')
					then
						local removedCards = (context.remove_playing_cards and context.removed) or (context.using_consumeable and G.hand.highlighted) or nil
						
						if removedCards then
							local glass_cards = 0
							
							for _, removed_card in ipairs(removedCards) do
								if
									removed_card.shattered
									or (context.using_consumeable
									and SMODS.has_enhancement(removed_card, 'm_glass'))
								then
									glass_cards = glass_cards + 1
								end
							end
							
							if glass_cards > 0 then
								local jkrRef = card
								
								G.E_MANAGER:add_event(Event({
									func = function()
										G.E_MANAGER:add_event(Event({
											func = function()
												jkrRef.ability.extra.x_chips = to_big(jkrRef.ability.extra.x_chips) + to_big(jkrRef.ability.extra.growth) * to_big(glass_cards)
												return true
											end
										}))
										
										SMODS.calculate_effect( {
												message = localize { type = 'variable', key = 'a_xchips', vars = { to_big(jkrRef.ability.extra.x_chips) +
												to_big(jkrRef.ability.extra.growth) * to_big(glass_cards) } }
											}, jkrRef)
										return true
									end
								}))
								
								return nil, true
							end
						end
					end
				end
				
				if
					context.fix_probability
					and context.trigger_obj
					and (context.trigger_obj.ability.effect == 'Glass Card'
					or context.trigger_obj.ability.cir_ice
					or context.trigger_obj.ability.mod_conv == 'm_glass')
				then
					return { denominator = card.ability.extra.odds }
				end
				
				if context.joker_main then return { x_chips = to_big(card.ability.extra.x_chips) } end
			end
		},
		-- Platinum Joker
		{
			key = 'platinum',
			upgradesFrom = 'j_golden',
			cir_Friend = CirnoMod.miscItems.cirFriends.cir,
			mutuallyExclusive = true,
			
			matureRefLevel = 1,
			loadOrder = 'upgCmn',
			
			loc_txt = { name = 'Platinum Joker',
				text = { {
					'At end of round',
					'earn either {X:money,C:white}X#1#',
					'or {C:money}#2#{}, whichever',
					'is larger',
					'{C:inactive}(Currently {C:money}#3#{C:inactive})'
					}, {
					'{C:attention}#4#s',
					'held in hand',
					'have a {C:green}#5# in #6#',
					'chance to trigger',
					'{s:0.8,C:inactive}Metal Gear Rising 2',
					'{s:0.8,C:inactive}when?'
				} }
			},
			
			abiInit = function(card, orgRarity)
				card.ability.extra = {
					originalRarity = orgRarity,
					upgraded = false,
					dol_fallback = 4,
					heldOdds = 5,
					sealAddOdds = 5
				}
			end,
			
			postPerfInit = function(self, card, orgRarity, orgExtTable, orgAbilityTbl)
				self.abiInit(card, orgRarity)
				
				card.ability.extra_value = CirnoMod.miscItems.upgradedExtraValue[orgRarity]
				card:set_cost()
			end,
			
			blueprint_compat = true,
			
			econFormula = function()
				return (G.GAME and G.GAME.round_resets.ante > 0 and to_big(G.GAME.round_resets.ante) or to_big(1)) / to_big(20)
			end,
			
			loc_vars = function(self, info_queue, card)
				if
					not card.ability.extra
					or type(card.ability.extra) ~= 'table'
				then
					self.abiInit(card, 1)
				end
				
				local xDol = self.econFormula()
				xDol = xDol + 1
				
				local ret = { vars = {
					SMODS.signed_dollars(xDol),
					SMODS.signed_dollars(card.ability.extra.dol_fallback),
					SMODS.signed_dollars(self:calc_dollar_bonus(card)),
					G.localization.misc.labels.gold_seal
				} }
				
				local heldNom, heldDenom = SMODS.get_probability_vars(card or self, 1, card.ability.extra.heldOdds, 'platinum_held')
				
				ret.vars[5] = heldNom
				ret.vars[6] = heldDenom
				
				if card.ability.extra.upgraded then
					ret.key = 'j_cir_platinum_upg'
					
					local sealNom, sealDenom = SMODS.get_probability_vars(card or self, 1, card.ability.extra.sealAddOdds, 'platinum_seal')
					
					ret.vars[7] = sealNom
					ret.vars[8] = sealDenom
				end
				
				info_queue[#info_queue + 1] = { key = 'gold_seal', set = 'Other' }
				
				if CirnoMod.config.artCredits and not card.fake_card then
					info_queue[#info_queue + 1] = { key = 'jA_DaemonTsun_BigNTFEdit', set = 'Other' }
				end
				
				return ret
			end,
			
			pos = { x = 6, y = 4 },
			eternal_compat = true,
			perishable_compat = false,
			
			add_to_deck = function(self, card, from_debuff)
				self.abiInit(card)
				
				card.ability.extra_value = CirnoMod.miscItems.upgradedExtraValue[orgRarity]
				card:set_cost()
			end,
			
			cir_upgradeInfo = function(self, card)
				if card.ability.extra.upgraded then
					if card.ability.extra.sealAddOdds <= 1 then
						return nil
					end
					
					local sealNom, sealDenom = SMODS.get_probability_vars(card or self, 1, card.ability.extra.sealAddOdds, 'platinum_seal')
					
					local ret = {
						'{C:attention}'..G.localization.misc.labels.gold_seal,
						'add chance:',
						'{C:green}'..sealNom..' in '..sealDenom,
						'->',
						'{C:green}'..sealNom..' in '..math.max(sealDenom - 1, 1)
					}
					
					if card.ability.extra.sealAddOdds == 2 then
						table.insert(ret, '{C:red}Final upgrade')
					end
					
					return ret
				end
				
				if card.ability.extra.heldOdds == 1 then
					local sealNom, sealDenom = SMODS.get_probability_vars(card or self, 1, card.ability.extra.sealAddOdds, 'platinum_seal')
					
					return {
						'{s:1.2,C:dark_edition}Adds:',
						'Scored cards',
						'without a {C:attention}seal{',
						'will have a',
						'{C:green}'..sealNom..' in '..sealDenom..'{} chance',
						'to gain a',
						'{C:attention}'..G.localization.misc.labels.gold_seal
					}
				end
				
				local heldNom, heldDenom = SMODS.get_probability_vars(card or self, 1, card.ability.extra.heldOdds, 'platinum_held')
				
				return {
					'Held {C:attention}'..G.localization.misc.labels.gold_seal,
					'trigger chance:',
					'{C:green}'..heldNom..' in '..heldDenom,
					'->',
					'{C:green}'..heldNom..' in '..math.max(heldDenom - 1, 1)
				}
			end,
			
			cir_upgrade = function(self, card)
				local ret = { message = localize('k_upgrade_ex') }
				
				if card.ability.extra.upgraded then
					if card.ability.extra.sealAddOdds <= 1 then
						return nil
					end
					
					card.ability.extra.sealAddOdds = card.ability.extra.sealAddOdds - 1
					return ret
				end
				
				if card.ability.extra.heldOdds <= 1 then
					card.ability.extra.upgraded = true
					return ret
				end
				
				card.ability.extra.heldOdds = card.ability.extra.heldOdds - 1
				return ret
			end,
			
			calc_dollar_bonus = function(self, card, context)
				if
					G.GAME
					and G.GAME.dollars
					and to_big(G.GAME.dollars) > to_big(0)
				then
					--[[
					local x_dollars = to_big((G.GAME and G.GAME.round_resets.ante or 1)) / to_big(10)
					x_dollars = to_big(x_dollars) + to_big(1)
					]]
					
					local x_dol_ret = math.floor(to_big(0.5) + to_big(to_big(G.GAME.dollars) * to_big(self.econFormula())))
					
					return math.max(x_dol_ret, to_big(card.ability.extra.dol_fallback))
				end
				
				return to_big(card.ability.extra.dol_fallback)
			end,
			
			calculate = function(self, card, context)
				if
					context.individual
					and context.other_card
					and not context.game_over
				then
					if
						not (context.blueprint
						or context.retrigger_joker
						or context.retrigger_joker_check)
						and card.ability.extra
						and card.ability.extra.upgraded
						and context.cardarea == G.play
						and not context.other_card.seal
						and SMODS.pseudorandom_probability(card, 'platinum_seal', 1, card.ability.extra.sealAddOdds)
					then
						return { func = function()
							local jkrRef = card
							local cardRef = context.other_card
							
							G.E_MANAGER:add_event(Event({
									trigger = 'immediate',
									blocking = true,
									blockable = true,
									func = function()										
										jkrRef:juice_up()
										cardRef:set_seal('Gold', false, true)
										return true 
									end }))
						end }
					end
					
					if
						context.cardarea == G.hand
						and not context.end_of_round
						and context.other_card.seal == 'Gold'
						and SMODS.pseudorandom_probability(card, 'platinum_held', 1, card.ability.extra.heldOdds)
					then
						return { dollars = 3, message_card = context.other_card }
					end
				end
			end
		},
		-- Floor Plan
		{
			key = 'floorPlan',
			upgradesFrom = 'j_blueprint',
			
			matureRefLevel = 1,
			loadOrder = 'upgRare',
			
			loc_txt = {	name = 'Floor Plan',
				text = {
					'Copies ability of',
                    '{C:attention}2 Jokers{} to the right'
				}
			},
			
			abiInit = function(card, orgRarity)
				card.ability.extra = {
					originalRarity = orgRarity,
					upgraded = false,
					EoR_dollars = 0
				}
			end,
			
			postPerfInit = function(self, card, orgRarity, orgExtTable, orgAbilityTbl)
				self.abiInit(card, orgRarity)
				
				card.ability.extra_value = CirnoMod.miscItems.upgradedExtraValue[orgRarity]
				card:set_cost()
			end,
			
			blueprint_compat = true,
			
			loc_vars = function(self, info_queue, card)
				if
					not card.ability.extra
					or type(card.ability.extra) ~= 'table'
				then
					self.abiInit(card, 3)
				end
				
				local descAppend = {
					'{s:0.8,C:inactive}Everyone knows that the',
					'{s:0.8,C:inactive}electrical wiring goes',
					'{s:0.8,C:inactive}through the windows'
				}
				
				local other_joker = nil
				local other_joker2 = nil
				
				if G.GAME and G.jokers then
					for i = 1, #G.jokers.cards do
						if G.jokers.cards[i] == card then
							other_joker = G.jokers.cards[i + 1]
							other_joker2 = G.jokers.cards[i + 2]
						end
					end
				end
				
				local compatible = other_joker and other_joker ~= card and (CirnoMod.miscItems.checkBlueprintCompat(other_joker.config.center.blueprint_compat) or (card.ability.extra.upgraded and (other_joker.calculate_dollar_bonus or other_joker.config.center.calc_dollar_bonus)))
				
				local compatible2 = other_joker2 and other_joker2 ~= card and (CirnoMod.miscItems.checkBlueprintCompat(other_joker2.config.center.blueprint_compat) or (card.ability.extra.upgraded and (other_joker2.calculate_dollar_bonus or other_joker2.config.center.calc_dollar_bonus)))
				
				local fp_main_end = {
						{
							n = G.UIT.C,
							config = { align = "bm", minh = 0.4 },
							nodes = {
								{
									n = G.UIT.R,
									config = { align = "bm", minh = 0.4 },
									nodes = {
										{
											n = G.UIT.C, -- Spacer wrapper
											config = {
												r = 0.1,
												padding = 0.0,
												align = 'tm',
												colour = G.C.CLEAR
											},
											nodes = {
												{
													-- Spacer
													n = G.UIT.B,
													config = {
														colour = G.C.CLEAR,
														w = 0.2,
														h = 0.1
													}
												}
											}
										},
										{
											n = G.UIT.C,
											config = { ref_table = card, align = "m", colour = compatible and mix_colours(G.C.GREEN, G.C.JOKER_GREY, 0.8) or mix_colours(G.C.RED, G.C.JOKER_GREY, 0.8), r = 0.05, padding = 0.06 },
											nodes = {
												{ n = G.UIT.T, config = { text = ' 1: ' .. localize('k_' .. (compatible and 'compatible' or 'incompatible')) .. ' ', colour = G.C.UI.TEXT_LIGHT, scale = 0.32 * 0.8 } },
											}
										},
										{
											n = G.UIT.C, -- Spacer wrapper
											config = {
												r = 0.1,
												padding = 0.0,
												align = 'tm',
												colour = G.C.CLEAR
											},
											nodes = {
												{
													-- Spacer
													n = G.UIT.B,
													config = {
														colour = G.C.CLEAR,
														w = 0.2,
														h = 0.1
													}
												}
											}
										}
									}
								},
								{
									n = G.UIT.R, -- Spacer wrapper
									config = {
										r = 0.1,
										padding = 0.0,
										align = 'tm',
										colour = G.C.CLEAR
									},
									nodes = {
										{
											-- Spacer
											n = G.UIT.B,
											config = {
												colour = G.C.CLEAR,
												w = 0.1,
												h = 0.1
											}
										}
									}
								},
								{
									n = G.UIT.R,
									config = { align = "bm", minh = 0.4 },
									nodes = {
										{
											n = G.UIT.C, -- Spacer wrapper
											config = {
												r = 0.1,
												padding = 0.0,
												align = 'tm',
												colour = G.C.CLEAR
											},
											nodes = {
												{
													-- Spacer
													n = G.UIT.B,
													config = {
														colour = G.C.CLEAR,
														w = 0.2,
														h = 0.1
													}
												}
											}
										},
										{
											n = G.UIT.C,
											config = { ref_table = card, align = "m", colour = compatible2 and mix_colours(G.C.GREEN, G.C.JOKER_GREY, 0.8) or mix_colours(G.C.RED, G.C.JOKER_GREY, 0.8), r = 0.05, padding = 0.06 },
											nodes = {
												{ n = G.UIT.T, config = { text = ' 2: ' .. localize('k_' .. (compatible2 and 'compatible' or 'incompatible')) .. ' ', colour = G.C.UI.TEXT_LIGHT, scale = 0.32 * 0.8 } },
											}
										},
										{
											n = G.UIT.C, -- Spacer wrapper
											config = {
												r = 0.1,
												padding = 0.0,
												align = 'tm',
												colour = G.C.CLEAR
											},
											nodes = {
												{
													-- Spacer
													n = G.UIT.B,
													config = {
														colour = G.C.CLEAR,
														w = 0.2,
														h = 0.1
													}
												}
											}
										}
									}
								},
								{
									n = G.UIT.R, -- Spacer wrapper
									config = {
										r = 0.1,
										padding = 0.0,
										align = 'tm',
										colour = G.C.CLEAR
									},
									nodes = {
										{
											-- Spacer
											n = G.UIT.B,
											config = {
												colour = G.C.CLEAR,
												w = 0.1,
												h = 0.1
											}
										}
									}
								}
							}
						}
					}
				
				for _, t in ipairs(descAppend) do
					fp_main_end[1].nodes[#fp_main_end[1].nodes + 1] = {
						n = G.UIT.R,
						config = { align = "cm", padding = 0.03 },
						nodes = SMODS.localize_box(loc_parse_string(t), {scale = 1.0})
					}
				end
				
				if CirnoMod.config.artCredits and not card.fake_card then
					info_queue[#info_queue + 1] = { key = 'jA_NTF', set = 'Other' }
				end
				
				return { main_end = fp_main_end }
			end,
			
			pos = { x = 7, y = 4 },
			eternal_compat = true,
			perishable_compat = false,
			
			cir_upgradeInfo = function(self, card)
				if not card.ability.extra.upgraded then
					return {
						'Allows copying {C:attention}end of round',
						'economy type effects, such as {C:attention}'..G.localization.descriptions.Joker.j_golden.name,
						'{s:0.8}(Acts strangely & unexpectedly,',
						'{s:0.8}most notably when trying to copy',
						'{s:0.8}duplicates or similar econ copying)',
						'{C:red}Final upgrade'
					}
				end
			end,
			
			cir_upgrade = function(self, card)
				if not card.ability.extra.upgraded then
					card.ability.extra.upgraded = true
					
					return { message = localize('k_upgrade_ex') }
				end
			end,
			
			calc_dollar_bonus = function(self, card, context)
				if card.ability.extra.upgraded then
					local ret = 0
					
					if context and context.blueprint then
						local other_joker, other_joker2
						local ret = 0
						
						for i = 1, #G.jokers.cards do
							if G.jokers.cards[i] == card then
								other_joker = G.jokers.cards[i + 1]
								other_joker2 = G.jokers.cards[i + 2]
							end
						end
						
						ret = ret + (CirnoMod.blueprint_calcDol_effect(card, other_joker, context) or 0) + (CirnoMod.blueprint_calcDol_effect(card, other_joker2, context) or 0)
					end
					
					if card.ability.extra.EoR_dollars > 0 then
						ret = ret + card.ability.extra.EoR_dollars
					end
					
					if ret > 0 then
						return ret
					end
				end
			end,
			
			calculate = function(self, card, context)
				if
					(context.starting_shop
					or context.setting_blind)
					and card.ability.extra.EoR_dollars > 0
				then
					card.ability.extra.EoR_dollars = 0
				end
				
				local other_joker, other_joker2
				
				for i = 1, #G.jokers.cards do
					if G.jokers.cards[i] == card then
						other_joker = G.jokers.cards[i + 1]
						other_joker2 = G.jokers.cards[i + 2]
					end
				end
				
				if context.end_of_round and context.main_eval and card.ability.extra.upgraded then
					card.ability.extra.EoR_dollars = (CirnoMod.blueprint_calcDol_effect(card, other_joker, context) or 0) + (CirnoMod.blueprint_calcDol_effect(card, other_joker2, context) or 0)
				end
				
				context.cir_bp_col = G.C.UI.TEXT_DARK
				
				local ret1 = SMODS.blueprint_effect(card, other_joker, context, G.C.UI.TEXT_DARK)
				local ret2 = SMODS.blueprint_effect(card, other_joker2, context, G.C.UI.TEXT_DARK)
				
				if ret1 or ret2 then
					return SMODS.merge_effects{ ret1 or {}, ret2 or {} }
				end
			end
		},
		-- Rough Sketch
		{
			key = 'roughSketch',
			upgradesFrom = 'j_brainstorm',
			
			matureRefLevel = 1,
			loadOrder = 'upgRare',
			
			loc_txt = {	name = 'Rough Sketch',
				text = {
					'Copies the ability',
					'of both the {C:joker}Joker',
					'2nd from the {C:attention}left',
					'and 2nd from the {C:attention}right'
				}
			},
			
			abiInit = function(card, orgRarity)
				card.ability.extra = {
					originalRarity = orgRarity,
					upgraded = false,
					EoR_dollars = 0
				}
			end,
			
			postPerfInit = function(self, card, orgRarity, orgExtTable, orgAbilityTbl)
				self.abiInit(card, orgRarity)
				
				card.ability.extra_value = CirnoMod.miscItems.upgradedExtraValue[orgRarity]
				card:set_cost()
			end,
			
			blueprint_compat = true,
			
			loc_vars = function(self, info_queue, card)
				if
					not card.ability.extra
					or type(card.ability.extra) ~= 'table'
				then
					self.abiInit(card, 3)
				end
				
				local descAppend = {
					'{s:0.8,C:inactive}Finally, kerJoker'
				}
				
				local other_joker = nil
				local other_joker2 = nil
				
				if G.GAME and G.jokers then
					other_joker = G.jokers.cards[2]
					other_joker2 = G.jokers.cards[#G.jokers.cards - 1]
				end
				
				local compatible = other_joker and other_joker ~= card and (CirnoMod.miscItems.checkBlueprintCompat(other_joker.config.center.blueprint_compat) or (card.ability.extra.upgraded and (other_joker.calculate_dollar_bonus or other_joker.config.center.calc_dollar_bonus)))
				
				local compatible2 = other_joker2 and other_joker2 ~= card and (CirnoMod.miscItems.checkBlueprintCompat(other_joker2.config.center.blueprint_compat) or (card.ability.extra.upgraded and (other_joker2.calculate_dollar_bonus or other_joker2.config.center.calc_dollar_bonus)))
				
				local rs_main_end = {
						{
							n = G.UIT.C,
							config = { align = "bm", minh = 0.4 },
							nodes = {
								{
									n = G.UIT.R,
									config = { align = "bm", minh = 0.4 },
									nodes = {
										{
											n = G.UIT.C, -- Spacer wrapper
											config = {
												r = 0.1,
												padding = 0.0,
												align = 'tm',
												colour = G.C.CLEAR
											},
											nodes = {
												{
													-- Spacer
													n = G.UIT.B,
													config = {
														colour = G.C.CLEAR,
														w = 0.2,
														h = 0.1
													}
												}
											}
										},
										{
											n = G.UIT.C,
											config = { ref_table = card, align = "m", colour = compatible and mix_colours(G.C.GREEN, G.C.JOKER_GREY, 0.8) or mix_colours(G.C.RED, G.C.JOKER_GREY, 0.8), r = 0.05, padding = 0.06 },
											nodes = {
												{ n = G.UIT.T, config = { text = ' 1: ' .. localize('k_' .. (compatible and 'compatible' or 'incompatible')) .. ' ', colour = G.C.UI.TEXT_LIGHT, scale = 0.32 * 0.8 } },
											}
										},
										{
											n = G.UIT.C, -- Spacer wrapper
											config = {
												r = 0.1,
												padding = 0.0,
												align = 'tm',
												colour = G.C.CLEAR
											},
											nodes = {
												{
													-- Spacer
													n = G.UIT.B,
													config = {
														colour = G.C.CLEAR,
														w = 0.2,
														h = 0.1
													}
												}
											}
										}
									}
								},
								{
									n = G.UIT.R, -- Spacer wrapper
									config = {
										r = 0.1,
										padding = 0.0,
										align = 'tm',
										colour = G.C.CLEAR
									},
									nodes = {
										{
											-- Spacer
											n = G.UIT.B,
											config = {
												colour = G.C.CLEAR,
												w = 0.1,
												h = 0.1
											}
										}
									}
								},
								{
									n = G.UIT.R,
									config = { align = "bm", minh = 0.4 },
									nodes = {
										{
											n = G.UIT.C, -- Spacer wrapper
											config = {
												r = 0.1,
												padding = 0.0,
												align = 'tm',
												colour = G.C.CLEAR
											},
											nodes = {
												{
													-- Spacer
													n = G.UIT.B,
													config = {
														colour = G.C.CLEAR,
														w = 0.2,
														h = 0.1
													}
												}
											}
										},
										{
											n = G.UIT.C,
											config = { ref_table = card, align = "m", colour = compatible2 and mix_colours(G.C.GREEN, G.C.JOKER_GREY, 0.8) or mix_colours(G.C.RED, G.C.JOKER_GREY, 0.8), r = 0.05, padding = 0.06 },
											nodes = {
												{ n = G.UIT.T, config = { text = ' 2: ' .. localize('k_' .. (compatible2 and 'compatible' or 'incompatible')) .. ' ', colour = G.C.UI.TEXT_LIGHT, scale = 0.32 * 0.8 } },
											}
										},
										{
											n = G.UIT.C, -- Spacer wrapper
											config = {
												r = 0.1,
												padding = 0.0,
												align = 'tm',
												colour = G.C.CLEAR
											},
											nodes = {
												{
													-- Spacer
													n = G.UIT.B,
													config = {
														colour = G.C.CLEAR,
														w = 0.2,
														h = 0.1
													}
												}
											}
										}
									}
								},
								{
									n = G.UIT.R, -- Spacer wrapper
									config = {
										r = 0.1,
										padding = 0.0,
										align = 'tm',
										colour = G.C.CLEAR
									},
									nodes = {
										{
											-- Spacer
											n = G.UIT.B,
											config = {
												colour = G.C.CLEAR,
												w = 0.1,
												h = 0.1
											}
										}
									}
								}
							}
						}
					}
				
				for _, t in ipairs(descAppend) do
					rs_main_end[1].nodes[#rs_main_end[1].nodes + 1] = {
						n = G.UIT.R,
						config = { align = "cm", padding = 0.03 },
						nodes = SMODS.localize_box(loc_parse_string(t), {scale = 1.0})
					}
				end
				
				if CirnoMod.config.artCredits and not card.fake_card then
					info_queue[#info_queue + 1] = { key = 'jA_NTF', set = 'Other' }
				end
				
				return { main_end = rs_main_end }
			end,
			
			pos = { x = 6, y = 5 },
			eternal_compat = true,
			perishable_compat = false,
			
			cir_upgradeInfo = function(self, card)
				if not card.ability.extra.upgraded then
					return {
						'Allows copying {C:attention}end of round',
						'economy type effects, such as {C:attention}'..G.localization.descriptions.Joker.j_golden.name,
						'{s:0.8}(Acts strangely & unexpectedly,',
						'{s:0.8}most notably when trying to copy',
						'{s:0.8}duplicates or similar econ copying)',
						'{C:red}Final upgrade'
					}
				end
			end,
			
			cir_upgrade = function(self, card)
				if not card.ability.extra.upgraded then
					card.ability.extra.upgraded = true
					
					return { message = localize('k_upgrade_ex') }
				end
			end,
			
			calc_dollar_bonus = function(self, card, context)
				if card.ability.extra.upgraded then
					local ret = to_big(0)
					
					if context and context.blueprint then
						local other_joker, other_joker2
						
						for i = 1, #G.jokers.cards do
							if G.jokers.cards[i] == card then
								other_joker = G.jokers.cards[i + 1]
								other_joker2 = G.jokers.cards[i + 2]
							end
						end
						
						ret = ret + (CirnoMod.blueprint_calcDol_effect(card, other_joker, context) or 0) + (CirnoMod.blueprint_calcDol_effect(card, other_joker2, context) or 0)
					end
					
					if card.ability.extra.EoR_dollars > 0 then
						ret = ret + card.ability.extra.EoR_dollars
					end
					
					if ret > to_big(0) then
						return ret
					end
				end
			end,
			
			calculate = function(self, card, context)
				if
					(context.starting_shop
					or context.setting_blind)
					and card.ability.extra.EoR_dollars > 0
				then
					card.ability.extra.EoR_dollars = 0
				end
				
				local other_joker = G.jokers.cards[2]
				local other_joker2 = G.jokers.cards[#G.jokers.cards - 1]
				
				if context.end_of_round and context.main_eval and card.ability.extra.upgraded then
					card.ability.extra.EoR_dollars = (CirnoMod.blueprint_calcDol_effect(card, other_joker, context) or 0) + (CirnoMod.blueprint_calcDol_effect(card, other_joker2, context) or 0)
				end
				
				context.cir_bp_col = CirnoMod.miscItems.colours.cirCyan
				
				local ret1 = SMODS.blueprint_effect(card, other_joker, context, CirnoMod.miscItems.colours.cirCyan)
				
				local ret2 = SMODS.blueprint_effect(card, other_joker2, context, CirnoMod.miscItems.colours.cirCyan)
				
				if ret1 or ret2 then
					return SMODS.merge_effects{ ret1 or {}, ret2 or {} }
				end
			end
		},
		-- Steel Kingz
		{
			key = 'steelKingz',
			upgradesFrom = 'j_certificate',
			mutuallyExclusive = true,
			
			matureRefLevel = 1,
			loadOrder = 'upgUncmn',
			cir_Friend = CirnoMod.miscItems.cirFriends.cir,
			
			loc_txt = {	name = 'Steel Kingz',
				text = { {
					'When round begins,',
                    'add a random {C:attention}playing',
                    '{C:attention}card{} with a random',
                    '{C:attention}seal{} to your hand'
					}, {
					'{C:green}#1# in #2#{} chance for',
					'created card to be',
					'a {C:attention}King',
					'{C:green}#3# in #4#{} chance for',
					'created card to have',
					'a {C:red}#5#',
					'{C:green}#6# in #7#{} chance for',
					'created card to be',
					'a {C:attention}#8#',
					'{s:0.8,C:inactive}Prayers answered?'
				} }
			},
			
			abiInit = function(card, orgRarity)
				card.ability.extra = {
					upgraded = false,
					originalRarity = orgRarity,
					kingOdds = 2,
					sealOdds = 3,
					steelOdds = 4,
					polyOdds = 4,
					sealOptions = {}
				}
				
				for k, tbl in pairs(G.P_SEALS) do
					if k ~= 'Red' then
						table.insert(card.ability.extra.sealOptions, k)
					end
				end
			end,
			
			postPerfInit = function(self, card, orgRarity, orgExtTable, orgAbilityTbl)
				self.abiInit(card, orgRarity)
				
				card.ability.extra_value = CirnoMod.miscItems.upgradedExtraValue[orgRarity]
				card:set_cost()
			end,
			
			blueprint_compat = true,
			
			loc_vars = function(self, info_queue, card)
				if
					not card.ability.extra
					or type(card.ability.extra) ~= 'table'
				then
					self.abiInit(card, 2)
				end
				
				local kingNom, kingDenom = SMODS.get_probability_vars(card or self, 1, card.ability.extra.kingOdds, 'steelKingz_king')
				
				local sealNom, sealDenom = SMODS.get_probability_vars(card or self, 1, card.ability.extra.sealOdds, 'steelKingz_seal')
				
				local steelNom, steelDenom = SMODS.get_probability_vars(card or self, 1, card.ability.extra.steelOdds, 'steelKingz_steel')
				
				info_queue[#info_queue + 1] = G.P_SEALS.Red
				
				info_queue[#info_queue + 1] = G.P_CENTERS.m_steel
				
				local ret = { vars = {
					kingNom, kingDenom,
					sealNom, sealDenom,
					G.localization.misc.labels.red_seal,
					steelNom, steelDenom,
					localize{ type = 'name_text', key = 'm_steel', set = 'Enhanced' }
				} }
				
				if card.ability.extra.upgraded then
					info_queue[#info_queue + 1] = G.P_CENTERS.e_polychrome
					
					local polyNom, polyDenom = SMODS.get_probability_vars(card or self, 1, card.ability.extra.polyOdds, 'steelKingz_poly')
					
					ret.vars[9] = polyNom
					ret.vars[10] = polyDenom
					
					ret.key = 'j_cir_steelKingz_upg'
				end
				
				if CirnoMod.config.artCredits and not card.fake_card then
					info_queue[#info_queue + 1] = { key = 'jA_DuoDagger', set = 'Other' }
				end
				
				return ret
			end,
			
			cir_upgradeInfo = function(self, card)
				local procOdds = function(odds, seed)
					local num, denum = SMODS.get_probability_vars(card or self, 1, odds, seed)
					
					return '{C:green}'..num..' in '..denum..'{} chance'
				end
				
				local targetKingOdds = card.ability.extra.kingOdds
				local targetSealOdds = card.ability.extra.sealOdds
				local targetSteelOdds = card.ability.extra.steelOdds
				local procTable = nil
				
				if
					card.ability.extra.sealOdds == 2
					and card.ability.extra.steelOdds == 3
					and card.ability.extra.kingOdds > 1
				then
					targetKingOdds = targetKingOdds - 1
				end
				
				if
					card.ability.extra.sealOdds > 2
					or (card.ability.extra.sealOdds == 2
					and card.ability.extra.kingOdds == 1
					and card.ability.extra.steelOdds <= 3)
				then
					targetSealOdds = targetSealOdds - 1
				end
				
				if
					(card.ability.extra.steelOdds == 4
					and card.ability.extra.sealOdds == 2)
					or (card.ability.extra.steelOdds > 1
					and card.ability.extra.kingOdds == 1
					and card.ability.extra.sealOdds == 1)
				then
					targetSteelOdds = targetSteelOdds - 1
				end
				
				if targetKingOdds < card.ability.extra.kingOdds then
					procTable = {
						before = procOdds(card.ability.extra.kingOdds, 'steelKingz_king'),
						after = procOdds(targetKingOdds, 'steelKingz_king'),
						type = 'to create a {C:attention}King'
					}
				end
				
				if targetSealOdds < card.ability.extra.sealOdds then
					procTable = {
						before = procOdds(card.ability.extra.sealOdds, 'steelKingz_seal'),
						after = procOdds(targetSealOdds, 'steelKingz_seal'),
						type = 'for a {C:red}'..G.localization.misc.labels.red_seal
					}
				end
				
				if targetSteelOdds < card.ability.extra.steelOdds then
					procTable = {
						before = procOdds(card.ability.extra.steelOdds, 'steelKingz_steel'),
						after = procOdds(targetSteelOdds, 'steelKingz_steel'),
						type = 'to be a {C:attention}'..G.localization.descriptions.Enhanced.m_steel.name
					}
				end
				
				if procTable then
					return {
							procTable.before,
							procTable.type,
							'->',
							procTable.after,
							procTable.type
						}
				end
				
				if not card.ability.extra.upgraded then
					return {
						'{s:1.2,C:dark_edition}Adds:',
						procOdds(card.ability.extra.polyOdds, 'steelKingz_poly')..' for',
						'created card to be',
						'{C:dark_edition}Polychrome',
						'{C:red}Final upgrade'
					}
				end
			end,
			
			cir_upgrade = function(self, card)
				local ret = { message = localize('k_upgrade_ex') }
				
				if
					card.ability.extra.sealOdds == 2
					and card.ability.extra.steelOdds == 3
					and card.ability.extra.kingOdds > 1
				then
					card.ability.extra.kingOdds = card.ability.extra.kingOdds - 1
					return ret
				end
				
				if
					card.ability.extra.sealOdds > 2
					or (card.ability.extra.sealOdds == 2
					and card.ability.extra.kingOdds == 1
					and card.ability.extra.steelOdds <= 3)
				then
					card.ability.extra.sealOdds = card.ability.extra.sealOdds - 1
					return ret
				end
				
				if
					(card.ability.extra.steelOdds == 4
					and card.ability.extra.sealOdds == 2)
					or (card.ability.extra.steelOdds > 1
					and card.ability.extra.kingOdds == 1
					and card.ability.extra.sealOdds == 1)
				then
					card.ability.extra.steelOdds = card.ability.extra.steelOdds - 1
					return ret
				end
				
				if not card.ability.extra.upgraded then
					card.ability.extra.upgraded = true
					return ret
				end
			end,
			
			pos = { x = 7, y = 5 },
			eternal_compat = true,
			perishable_compat = false,
			
			calculate = function(self, card, context)
				if context.first_hand_drawn then
					local card_build_table = {
						set = 'Base',
						area = G.discard
					}
					
					if
						SMODS.pseudorandom_probability(card, 'steelKingz_king', 1, card.ability.extra.kingOdds)
					then
						card_build_table.rank = 'King'
					end
					
					if
						SMODS.pseudorandom_probability(card, 'steelKingz_seal', 1, card.ability.extra.sealOdds)
					then
						card_build_table.seal = 'Red'
					else
						card_build_table.seal = SMODS.poll_seal{ guaranteed = true, options = card.ability.extra.sealOptions }
					end
					
					if
						SMODS.pseudorandom_probability(card, 'steelKingz_steel', 1, card.ability.extra.steelOdds)
					then
						card_build_table.enhancement = 'm_steel'
					end
					
					if
						card.ability.extra.upgraded
						and SMODS.pseudorandom_probability(card, 'steelKingz_poly', 1, card.ability.extra.polyOdds)
					then
						card_build_table.edition = 'e_polychrome'
					end
					
					local jkrRef = context.blueprint_card or card
					
					return { func = function()
							local pCard = SMODS.create_card(card_build_table)
							G.playing_card = (G.playing_card and G.playing_card + 1) or 1
							pCard.playing_card = G.playing_card
							table.insert(G.playing_cards, pCard)
							
							 G.E_MANAGER:add_event(Event({
									func = function()
										G.hand:emplace(pCard)
										pCard:start_materialize()
										G.GAME.blind:debuff_card(pCard)
										G.hand:sort()
										jkrRef:juice_up()
										save_run()
										return true
									end
								}))
							
							SMODS.calculate_context({ playing_card_added = true, cards = { pCard } })
						end }
				end
			end
		},
		-- Smug Iris Heart
		{
			key = 'smug',
			upgradesFrom = 'j_sly',
			mutuallyExclusive = true,
			
			matureRefLevel = 1,
			loadOrder = 'upgCmn',
			
			loc_txt = {	name = 'Smug Iris Heart',
				text = {
					'{X:chips,C:white} X#1# {} Chips if played',
                    'hand contains',
                    'a {C:attention}#2#',
					'{s:0.8,C:inactive}"If you haven\'t sampled',
					'{s:0.8,C:inactive}enough of our services',
					'{s:0.8,C:inactive}menu, I can always offer',
					'{s:0.8,C:inactive}you some one-on-one service"'
				}
			},
			
			abiInit = function(card, orgRarity)
				card.ability.extra = {
					originalRarity = orgRarity,
					x_chips = 2,
					type = 'Pair'
				}
			end,
			
			postPerfInit = function(self, card, orgRarity, orgExtTable, orgAbilityTbl)
				self.abiInit(card, orgRarity)
				
				card.ability.extra_value = CirnoMod.miscItems.upgradedExtraValue[orgRarity]
				card:set_cost()
			end,
			
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
						{ x = 3, y = 2 } -- Position in the Atlas
					)
				)
				
				return { mainEndRV }
			end,
			
			blueprint_compat = true,
			loc_vars = function(self, info_queue, card)
				if
					not card.ability.extra
					or type(card.ability.extra) ~= 'table'
				then
					self.abiInit(card, 1)
				end
				
				if CirnoMod.config.artCredits and not card.fake_card then
					info_queue[#info_queue + 1] = { key = 'jA_LocalThunk_NTFEdit', set = 'Other' }
				end
				
				return { main_end = self.create_main_end(),
					vars = {
						card.ability.extra.x_chips,
						localize(card.ability.extra.type, 'poker_hands')
					} }
			end,
			
			cir_upgradeInfo = function(self, card)
				return {
					'{X:chips,C:white} X'..to_big(card.ability.extra.x_chips)..' {} Chips',
					'->',
					'{X:chips,C:white} X'..to_big(card.ability.extra.x_chips) * to_big(2)..' {} Chips'
				}
			end,
			
			cir_upgrade = function(self, card)
				card.ability.extra.x_chips = to_big(card.ability.extra.x_chips) * to_big(2)
				
				return { message = localize('k_upgrade_ex'), colour = G.C.CHIPS }
			end,
			
			pos = { x = 6, y = 6 },
			eternal_compat = true,
			perishable_compat = false,
			
			calculate = function(self, card, context)
				if context.joker_main and next(context.poker_hands[card.ability.extra.type]) then
					return { x_chips = card.ability.extra.x_chips }
				end
			end
		},
		-- Utsuho Reiuji
		{
			key = 'utsuho',
			upgradesFrom = 'j_supernova',
			mutuallyExclusive = true,
			
			matureRefLevel = 1,
			loadOrder = 'upgCmn',
			
			loc_txt = {	name = 'Utsuho Reiuji',
				text = {
					'Gives {X:mult,C:white} XMult {} equal to {C:attention}#1#{}the',
					'number of times {C:attention}poker hand{} has',
					'been played this run {C:inactive}({X:mult,C:white} X#2# {C:inactive})',
					'{s:0.8,C:inactive}YOU THOUGHT I DIDN\'T',
					'{s:0.8,C:inactive}DO ANYTHING FOR BEST HU?!',
					'{s:0.8,C:inactive}HAHA! YOU ARE WRONG!'
				}
			},
			
			abiInit = function(card, orgRarity)
				card.ability.extra = {
					originalRarity = orgRarity,
					mod = 1
				}
			end,
			
			postPerfInit = function(self, card, orgRarity, orgExtTable, orgAbilityTbl)
				self.abiInit(card, orgRarity)
				
				card.ability.extra_value = CirnoMod.miscItems.upgradedExtraValue[orgRarity]
				card:set_cost()
			end,
			
			blueprint_compat = true,
			loc_vars = function(self, info_queue, card)
				if
					not card.ability.extra
					or type(card.ability.extra) ~= 'table'
				then
					self.abiInit(card, 1)
				end
				
				if CirnoMod.config.artCredits and not card.fake_card then
					info_queue[#info_queue + 1] = { key = 'jA_NTF_Rend', set = 'Other' }
				end
				
				local ret = { vars = { '', 1 } }
				
				if card.ability.extra.mod > 1 then
					ret.vars[1] = card.ability.extra.mod..'X '
				end
				
				if
					G.GAME
					and G.GAME.current_round
					and G.GAME.current_round.current_hand
					and G.GAME.hands
					and G.GAME.hands[G.GAME.current_round.current_hand.handname]
				then
					ret.vars[2] = (to_big(G.GAME.hands[G.GAME.current_round.current_hand.handname].played) + to_big(1)) * to_big(card.ability.extra.mod)
				end
				
				return ret
			end,
			
			cir_upgradeInfo = function(self, card)
				local target = nil
				
				if card.ability.extra.mod == 1 then
					target = 4
				else
					target = to_big(card.ability.extra.mod) * to_big(2)
				end
				
				return {
					'{C:attention}'..to_big(card.ability.extra.mod)..'X{} the number of times {C:attention}poker hand{} has been played this run',
					'->',
					'{C:attention}'..target..'X{} the number of times {C:attention}poker hand{} has been played this run'
				}
			end,
			
			cir_upgrade = function(self, card)
				if card.ability.extra.mod == 1 then
					card.ability.extra.mod = 4
				else
					card.ability.extra.mod = to_big(card.ability.extra.mod) * to_big(2)
				end
				
				return { message = localize('k_upgrade_ex') }
			end,
			
			pos = { x = 0, y = 5 },
			soul_pos = { x = 1, y = 5 },
			eternal_compat = true,
			perishable_compat = false,
			
			calculate = function(self, card, context)
				if
					context.joker_main
					and to_big(G.GAME.hands[context.scoring_name].played) > to_big(0)
				then
					return { x_mult = to_big(G.GAME.hands[context.scoring_name].played) * to_big(card.ability.extra.mod) }
				end
			end
		},
		-- Albedo
		{
			key = 'albedo',
			upgradesFrom = 'j_flash',
			mutuallyExclusive = true,
			
			matureRefLevel = 1,
			loadOrder = 'upgUncmn',
			
			loc_txt = {	name = 'Albedo',
				text = {
					'This Joker gains {X:mult,C:white} X#1# {} Mult',
                    'per {C:attention}reroll{} in the shop',
                    '{C:inactive}(Currently {X:mult,C:white} X#2# {C:inactive} Mult)',
					'{s:0.8,C:inactive}I\'ve got another',
					'{s:0.8,C:inactive}confession to make',
					'{s:0.8,C:inactive}I\'m your fool',
					'{s:0.8,C:inactive}Everyone\'s got their',
					'{s:0.8,C:inactive}chains to break',
					'{s:0.8,C:inactive}Holdin\' you',
					'{s:0.8,C:inactive}Were you born to resist',
					'{s:0.8,C:inactive}or be abused?',
					'{s:0.8,C:inactive}Is someone getting THE BEST',
					'{s:0.8,C:inactive}THE BEST THE BEST THE BEST',
					'{s:0.7,C:inactive}THE BEST THE BEST THE BEST',
					'{s:0.6,C:inactive}THE BEST THE BEST THE BEST',
					'{s:0.5,C:inactive}THE BEST THE BEST THE BEST',
					'{s:0.4,C:inactive}THE BEST THE BEST THE BEST',
					'{s:0.3,C:inactive}THE BEST THE BEST THE BEST'
				}
			},
			
			abiInit = function(card, orgRarity, orgAbilityTbl)
				card.ability.extra = {
					originalRarity = orgRarity,
					xmult = to_big(to_big(math.max(orgAbilityTbl.mult, 2)) / to_big(2)) * to_big(0.25),
					growth = 0.25
				}
				
				if to_big(card.ability.extra.xmult) < to_big(1) then
					card.ability.extra.xmult = to_big(1)
				end
			end,
			
			postPerfInit = function(self, card, orgRarity, orgExtTable, orgAbilityTbl)
				self.abiInit(card, orgRarity, orgAbilityTbl)
				
				card.ability.extra_value = CirnoMod.miscItems.upgradedExtraValue[orgRarity]
				card:set_cost()
			end,
			
			blueprint_compat = true,
			loc_vars = function(self, info_queue, card)
				if
					not card.ability.extra
					or type(card.ability.extra) ~= 'table'
				then
					self.abiInit(card, 2, { mult = 2 })
				end
				
				if CirnoMod.config.artCredits and not card.fake_card then
					info_queue[#info_queue + 1] = { key = 'jA_NTF_Rend', set = 'Other' }
				end
				
				return { vars = { to_big(card.ability.extra.growth), to_big(card.ability.extra.xmult) } }
			end,
			
			pos = { x = 0, y = 7 },
			soul_pos = { x = 1, y =7 },
			eternal_compat = true,
			perishable_compat = false,
			
			cir_upgradeInfo = function(self, card)
				return {
					'{X:mult,C:white}X'..to_big(card.ability.extra.growth)..'{} Mult scaling',
					'->',
					'{X:mult,C:white}X'..to_big(card.ability.extra.growth) + to_big(0.25)..'{} Mult scaling'
				}
			end,
			
			cir_upgrade = function(self, card)
				card.ability.extra.growth = to_big(card.ability.extra.growth) + to_big(1)
				
				return { message = localize('k_upgrade_ex'), colour = G.C.MULT }
			end,
			
			calculate = function(self, card, context)
				if context.reroll_shop and not context.blueprint then
					card.ability.extra.xmult = to_big(card.ability.extra.xmult) + to_big(card.ability.extra.growth)
					return {
						message = localize { type = 'variable', key = 'a_xmult', vars = { to_big(card.ability.extra.xmult) } },
						delay = 1.5,
						colour = G.C.MULT,
					}
				end
				
				if context.joker_main then
					return { x_mult = to_big(card.ability.extra.xmult) }
				end
			end
		},
		-- Obsessive Face
		{
			key = 'obsessiveFace',
			upgradesFrom = 'j_cir_crazyFace',
			
			matureRefLevel = 1,
			loadOrder = 'upgRare',
			
			loc_txt = {	name = 'Obsessive Face',
				text = { {
					'{X:mult,C:white}X#1#{} Mult',
					'{C:green}#2# in #3#{} chance to',
					'{C:red}destroy{C:attention} played cards{},',
					'per card.'
					}, {
					'Gains an additional',
					'{X:mult,C:white}X#4#{} Mult for every',
					'card destroyed by',
					'the above effect',
					'{s:0.8,C:inactive}I\'m pre-emptively',
					'{s:0.8,C:inactive}denying any allegations',
					'{s:0.8,C:inactive}of affinity towards',
					'{s:0.8,C:inactive}purple-haired psychos'
				} }
			},
			
			abiInit = function(card, orgRarity, orgExtTable, orgAbilityTbl)
				card.ability.extra = orgExtTable
				
				if
					not card.ability.extra
					and orgAbilityTbl
					and type(orgAbilityTbl) == 'table'
					and orgAbilityTbl.extra
				then
					card.ability.extra = orgAbilityTbl.extra
				end
				
				card.ability.extra.growth = 2
				card.ability.extra.odds = 10
				card.ability.originalRarity = orgRarity
			end,
			
			postPerfInit = function(self, card, orgRarity, orgExtTable, orgAbilityTbl)
				self.abiInit(card, orgRarity, orgExtTable, orgAbilityTbl)
				
				card.ability.extra_value = CirnoMod.miscItems.upgradedExtraValue[orgRarity]
				card:set_cost()
			end,
			
			blueprint_compat = true,
			loc_vars = function(self, info_queue, card)
				if
					not card.ability.extra
					or type(card.ability.extra) ~= 'table'
				then
					self.abiInit(card, 3, { xmult = 4 })
				end
				
				if CirnoMod.config.artCredits and not card.fake_card then
					info_queue[#info_queue + 1] = { key = "jA_Yuri", set = "Other" }
				end
				
				local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds)
				
				return { vars = {
						to_big(card.ability.extra.xmult),
						numerator,
						denominator,
						to_big(card.ability.extra.growth)
					} }
			end,
			
			pos = { x = 9, y = 4 },
			eternal_compat = true,
			perishable_compat = true,
			
			cir_upgradeInfo = function(self, card)
				return {
					'{X:mult,C:white}X'..to_big(card.ability.extra.growth)..'{} Mult scaling',
					'->',
					'{X:mult,C:white}X'..to_big(card.ability.extra.growth) * to_big(2)..'{} Mult scaling'
				}
			end,
			
			cir_upgrade = function(self, card)
				card.ability.extra.growth = to_big(card.ability.extra.growth) * to_big(2)
				
				return { message = localize('k_upgrade_ex'), colour = G.C.MULT }
			end,
			
			calculate = function(self, card, context)
				if context.joker_main then
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
						if SMODS.pseudorandom_probability(context.other_card, 'yuriKill', 1, card.ability.extra.odds) then
							
							context.other_card.getting_sliced = true -- Marks the card for destruction.
							-- If the card is being destroyed, we don't need to retrigger this card
							RT.doNotRedSeal = true
							RT.no_retrigger = true
							RT.message = '  '
							RT.colour = G.C.RED
							RT.func = function()
								local cardRef = context.other_card
								local jkrRef = card
								
								G.E_MANAGER:add_event(Event({
									trigger = 'immediate',
									blocking = false,
									blockable = true,
									func = function()
										cardRef.stab = true -- Purely for the visual effect on the Drawstep.
										
										card.ability.extra.xmult = to_big(card.ability.extra.xmult) + to_big(card.ability.extra.growth)
										
										SMODS.calculate_effect({
												message = localize({
													type = "variable",
													key = "a_xmult",
													vars = { to_big(card.ability.extra.xmult) } }),
												colour = G.C.MULT
											}, jkrRef)
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
			end
		},
		-- VIP Diamond
		{
			key = 'vipDiamond',
			upgradesFrom = 'j_ceremonial',
			mutuallyExclusive = true,
			
			matureRefLevel = 1,
			loadOrder = 'upgUncmn',
			
			loc_txt = {	name = 'VIP Diamond',
				text = {
					'When {C:attention}Blind{} is selected,',
                    'permanently add {C:attention}double',
                    'the sell value of {C:joker}Joker',
					'to the right to',
                    'this {C:red}Mult',
                    '{C:inactive}(Currently {C:mult}+#1#{C:inactive} Mult)',
					'{s:0.8,C:inactive}Cry about it'
				}
			},
			
			abiInit = function(card, orgRarity, orgAbilityTbl)
				card.ability.extra = {
					originalRarity = orgRarity,
					mult = to_big(orgAbilityTbl.mult),
					upgraded = false
				}
			end,
			
			postPerfInit = function(self, card, orgRarity, orgExtTable, orgAbilityTbl)
				self.abiInit(card, orgRarity, orgAbilityTbl)
				
				card.ability.extra_value = CirnoMod.miscItems.upgradedExtraValue[orgRarity]
				card:set_cost()
			end,
			
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
			
			blueprint_compat = true,
			loc_vars = function(self, info_queue, card)
				if
					not card.ability.extra
					or type(card.ability.extra) ~= 'table'
				then
					self.abiInit(card, 2, { mult = 0 })
				end
				
				if CirnoMod.config.artCredits and not card.fake_card then
					info_queue[#info_queue + 1] = { key = 'jA_DuoDagger', set = 'Other' }
				end
				
				local ret = { main_end = self.create_main_end(),
					vars = { to_big(card.ability.extra.mult) }
				}
				
				if card.ability.extra.upgraded then
					ret.key = 'j_cir_vipDiamond_upg'
				end
				
				return ret
			end,
			
			pos = { x = 2, y = 5 },
			eternal_compat = true,
			perishable_compat = false,
			
			cir_upgradeInfo = function(self, card)
				if not card.ability.extra.upgraded then
					return {
						'Gain {C:attention}double sell value{} as {C:mult} Mult ',
						'->',
						'Gain {C:attention}half sell value{} as {X:mult,C:white} XMult ',
						'{C:red}Final upgrade'
					}
				end
			end,
			
			cir_upgrade = function(self, card)
				if not card.ability.extra.upgraded then
					card.ability.extra.mult = to_big(card.ability.extra.mult) / to_big(4)
					card.ability.extra.upgraded = true
					
					return { message = localize('k_upgrade_ex'), colour = G.C.MULT }
				end
			end,
			
			calculate = function(self, card, context)
				if
					context.setting_blind
					and not context.blueprint
				then
					local my_pos = nil
					for i = 1, #G.jokers.cards do
						if G.jokers.cards[i] == card then
							my_pos = i
							break
						end
					end
					
					if
						my_pos
						and G.jokers.cards[my_pos + 1]
					then
						local targetCard = G.jokers.cards[my_pos + 1]
						
						if card.ability.extra.upgraded then
							card.ability.extra.mult = to_big(card.ability.extra.mult) + to_big(targetCard.sell_cost) / to_big(2)
							
							return { message = localize {
									type = 'variable',
									key = 'a_xmult',
									vars = { card.ability.extra.mult }
								},
								colour = G.C.MULT
							}
						end
						
						card.ability.extra.mult = to_big(card.ability.extra.mult) + to_big(targetCard.sell_cost) * to_big(2)
						
						return { message = localize {
								type = 'variable',
								key = 'a_mult',
								vars = { card.ability.extra.mult }
							},
							colour = G.C.MULT
						}
					end
				end
				
				if context.joker_main then
					if card.ability.extra.upgraded then
						return { x_mult = to_big(card.ability.extra.mult) }
					end
					
					return { mult = to_big(card.ability.extra.mult) }
				end
			end
		},
		-- Modern-Day Makai's Charismatic Mistress
		{
			key = 'charismaticMistress',
			upgradesFrom = 'j_vampire',
			mutuallyExclusive = true,
			
			matureRefLevel = 1,
			loadOrder = 'upgUncmn',
			
			loc_txt = {	name = 'Modern-Day Makai\'s Charismatic Mistress',
                text = {
                    'This Joker gains {X:mult,C:white} X#1# {} Mult',
                    'per scoring {C:attention}Enhanced card{} played,',
                    'removes card {C:attention}Enhancement',
                    '{C:inactive}(Currently {X:mult,C:white} X#3# {C:inactive} Mult)',
					'{s:0.8,C:inactive}"So bored. Go and bring',
					'{s:0.8,C:inactive}someone interesting over"'
                }
			},
			
			abiInit = function(card, orgRarity, orgAbilityTbl)
				card.ability.extra = {
					originalRarity = orgRarity,
					growth = 0.2,
					upgraded = false
				}
				
				if to_big(orgAbilityTbl.x_mult) > to_big(1) then
					card.ability.x_mult = to_big(orgAbilityTbl.x_mult) * to_big(2)
				end
			end,
			
			postPerfInit = function(self, card, orgRarity, orgExtTable, orgAbilityTbl)
				self.abiInit(card, orgRarity, orgAbilityTbl)
				
				card.ability.extra_value = CirnoMod.miscItems.upgradedExtraValue[orgRarity]
				card:set_cost()
			end,
			
			blueprint_compat = true,
			loc_vars = function(self, info_queue, card)
				if
					not card.ability.extra
					or type(card.ability.extra) ~= 'table'
				then
					self.abiInit(card, 2, { x_mult = 1 })
				end
				
				if CirnoMod.config.artCredits and not card.fake_card then
					info_queue[#info_queue + 1] = { key = 'jA_LostWord_NTFRend', set = 'Other' }
				end
				
				local ret = { vars = {
						to_big(card.ability.extra.growth),
						G.localization.descriptions.Enhanced.m_bonus.name,
						to_big(card.ability.x_mult)
					} }
				
				if card.ability.extra.upgraded then
					ret.key = 'j_cir_charismaticMistress_upg'
				end
				
				return ret
			end,
			
			pos = { x = 5, y = 7 },
			eternal_compat = true,
			perishable_compat = false,
			
			cir_upgradeInfo = function(self, card)
				if not card.ability.extra.upgraded then
					return {
						'{s:1.1,C:dark_edition}Replaces:',
						'Removes card {C:attention}Enhancement',
						'{s:1.1,C:dark_edition}With:',
						'Card becomes a {C:attention}'..G.localization.descriptions.Enhanced.m_bonus.name
					}
				end
				
				if to_big(card.ability.extra.growth) < to_big(1) then
					return {
						'{X:mult,C:white} X'..to_big(card.ability.extra.growth)..' {} Mult scaling',
						'->',
						'{X:mult,C:white} X1 {} Mult scaling'
					}
				end
				
				return {
						'{X:mult,C:white} X'..to_big(card.ability.extra.growth)..' {} Mult scaling',
						'->',
						'{X:mult,C:white} X'..to_big(card.ability.extra.growth) + to_big(0.5)..' {} Mult scaling'
					}
			end,
			
			cir_upgrade = function(self, card)
				if not card.ability.extra.upgraded then
					card.ability.extra.upgraded = true
					
					return { message = localize('k_upgrade_ex') }
				end
				
				if to_big(card.ability.extra.growth) < to_big(1) then
					card.ability.extra.growth = to_big(1)
				else
					card.ability.extra.growth = to_big(card.ability.extra.growth) + to_big(0.5)
				end
				
				return { message = localize('k_upgrade_ex') }
			end,
			
			calculate = function(self, card, context)
				if
					context.before
					and not context.blueprint
				then
					local enhanced = {}
					
					for _, scored_card in ipairs(context.scoring_hand) do
						if
							next(SMODS.get_enhancements(scored_card))
							and not scored_card.debuff
							and not scored_card.makai
						then
							enhanced[#enhanced + 1] = scored_card
							
							if
								not SMODS.find_card('j_vampire')
								and not scored_card.vampired
							then
								scored_card.makai = true
								
								G.E_MANAGER:add_event(Event({
									func = function()
										scored_card:juice_up()
										scored_card.makai = nil
										return true
									end
								}))
							end
							
							scored_card:set_ability(
								card.ability.extra.upgraded and 'm_bonus' or 'c_base',
								nil,
								true)
						end
					end
		
					if #enhanced > 0 then
						card.ability.x_mult = to_big(card.ability.x_mult) + to_big(card.ability.extra.growth) * to_big(#enhanced)
						
						return {
							message = localize { type = 'variable', key = 'a_xmult', vars = { to_big(card.ability.x_mult) } },
							delay = 1.5,
							colour = G.C.MULT
						}
					end
				end
				
				if context.joker_main then
					return { xmult = to_big(card.ability.x_mult) }
				end
			end
		},
		-- Contentious Prediction
		{
			key = 'contentiousPrediction',
			upgradesFrom = 'j_hanging_chad',
			
			matureRefLevel = 1,
			loadOrder = 'upgCmn',
			
			loc_txt = {	name = 'Contentious Prediction',
                text = { {
                    'Retrigger {C:attention}first{} played card',
                    'used in scoring {C:attention}#1#',
                    'additional times'
					}, {
					'The other scored cards have a',
                    '{C:green}#2# in #3#{} chance to be',
                    '{C:attention}retriggered{} and a further',
                    '{C:green}#4# in #5#{} chance to be',
                    'retriggered again',
					'{s:0.8,C:inactive}...Wait, this bit doesn\'t work,',
					'{s:0.8,C:inactive}a tied prediction is fine'
                } }
			},
			
			abiInit = function(card, orgRarity, orgExtTable)
				card.ability.extra = {
					originalRarity = orgRarity,
					repetitions = orgExtTable,
					oneOddsNm = 3,
					bothOddsDnm = 4
				}
			end,
			
			postPerfInit = function(self, card, orgRarity, orgExtTable, orgAbilityTbl)
				self.abiInit(card, orgRarity, orgExtTable)
				
				card.ability.extra_value = CirnoMod.miscItems.upgradedExtraValue[orgRarity]
				card:set_cost()
			end,
			
			blueprint_compat = true,
			loc_vars = function(self, info_queue, card)
				if
					not card.ability.extra
					or type(card.ability.extra) ~= 'table'
				then
					self.abiInit(card, 1, 2)
				end
				
				if CirnoMod.config.artCredits and not card.fake_card then
					info_queue[#info_queue + 1] = { key = 'jA_NTF', set = 'Other' }
				end
				
				local oneNum, oneDenum = SMODS.get_probability_vars(card, card.ability.extra.oneOddsNm, card.ability.extra.bothOddsDnm)
				
				local twoNum, twoDenum = SMODS.get_probability_vars(card, 1, card.ability.extra.bothOddsDnm)
				
				return { vars = {
					card.ability.extra.repetitions,
					oneNum, oneDenum,
					twoNum, twoDenum
				} }
			end,
			
			pos = { x = 4, y = 5 },
			eternal_compat = true,
			perishable_compat = false,
			
			cir_upgradeInfo = function(self, card)
				return {
					'{C:attention}'..card.ability.extra.repetitions..'{} additional repetitions',
					'of the {C:attention}first card',
					'->',
					'{C:attention}'..(card.ability.extra.repetitions + 1)..'{} additional repetitions',
					'of the {C:attention}first card'
				}
			end,
			
			cir_upgrade = function(self, card)
				card.ability.extra.repetitions = card.ability.extra.repetitions + 1
				
				return { message = localize('k_upgrade_ex') }
			end,
			
			calculate = function(self, card, context)
				if
					context.repetition
					and context.cardarea == G.play
				then
					if context.other_card == context.scoring_hand[1] then
						return { repetitions = card.ability.extra.repetitions }
					elseif SMODS.pseudorandom_probability(context.other_card, 'predictionRepOne', card.ability.extra.oneOddsNm, card.ability.extra.bothOddsDnm) then
						if SMODS.pseudorandom_probability(context.other_card, 'predictionRepTwo', 1, card.ability.extra.bothOddsDnm) then
							return { repetitions = 2 }
						else
							return { repetitions = 1 }
						end
					end
				end
			end
		},
		-- Best Buds
		{
			key = 'best_buds',
			upgradesFrom = 'j_ring_master',
			
			matureRefLevel = 1,
			loadOrder = 'upgUncmn',
			
			loc_txt = {	name = 'Best Buds',
                text = { {
                    '{C:attention}Joker{}, {C:tarot}Tarot{}, {C:planet}#1#{},',
					'and {C:spectral}Spectral{} cards may',
					'appear multiple times'
					}, {
					'{X:mult,C:white} X#2# {} Mult for',
					'each duplicate {C:attention}Joker{} held',
					'{C:inactive}(Currently {X:mult,C:white} X#3# {C:inactive} Mult)',
					'{s:0.8,C:inactive}"It\'s Tom! Tom and I',
					'{s:0.8,C:inactive}are best... Buds."'
                } }
			},
			
			abiInit = function(card, orgRarity, orgExtTable)
				card.ability.extra = {
					originalRarity = orgRarity,
					dupeMult = 1
				}
			end,
			
			postPerfInit = function(self, card, orgRarity, orgExtTable, orgAbilityTbl)
				self.abiInit(card, orgRarity, orgExtTable)
				
				card.ability.extra_value = CirnoMod.miscItems.upgradedExtraValue[orgRarity]
				card:set_cost()
			end,
			
			blueprint_compat = true,
			loc_vars = function(self, info_queue, card)
				if
					not card.ability.extra
					or type(card.ability.extra) ~= 'table'
				then
					self.abiInit(card, 2)
				end
				
				if CirnoMod.config.artCredits and not card.fake_card then
					info_queue[#info_queue + 1] = { key = 'jA_NTF_Rend', set = 'Other' }
				end
				
				return { vars = {
						G.localization.misc.labels.planet,
						to_big(card.ability.extra.dupeMult),
						self:getFinalDupeMult(card)
					} }
			end,
			
			pos = { x = 3, y = 5 },
			eternal_compat = true,
			perishable_compat = false,
			
			cir_upgradeInfo = function(self, card)
				return {
					'{X:mult,C:white} X'..to_big(card.ability.extra.dupeMult)..' {} Mult per duplicate {C:attention}Joker',
					'->',
					'{X:mult,C:white} X'..to_big(card.ability.extra.dupeMult)+to_big(1)..' {} Mult per duplicate {C:attention}Joker'
				}
			end,
			
			cir_upgrade = function(self, card)
				card.ability.extra.dupeMult = to_big(card.ability.extra.dupeMult) + to_big(1)
				
				return { message = localize('k_upgrade_ex') }
			end,
			
			getFinalDupeMult = function(self, card)
				local ret = 1
				local existing_joker_keys = {}
				
				if G.jokers and G.jokers.cards then
					for _, jkr in ipairs(G.jokers.cards) do
						if existing_joker_keys[jkr.config.center.key] then
							ret = to_big(ret) + to_big(card.ability.extra.dupeMult)
						else
							existing_joker_keys[jkr.config.center.key] = true
						end
					end
				end
				
				return ret
			end,
			
			calculate = function(self, card, context)
				if context.joker_main then
					local dupeCount = self:getFinalDupeMult(card)
					
					if dupeCount > 1 then
						return { x_mult = dupeCount }
					end
				end
			end
		},
		-- Execution Clap
		{
			key = 'execution_clap',
			upgradesFrom = 'j_card_sharp',
			
			matureRefLevel = 1,
			loadOrder = 'upgUncmn',
			
			loc_txt = {	name = 'Execution Clap',
                text = { {
					'{X:mult,C:white} X#1# {} Mult if played',
                    '{C:attention}poker hand{} has already',
                    'been played this round'
					}, {
					'Gains {X:mult,C:white} X#2# {} Mult for',
					'every {C:red}destroyed card',
					'Loses {X:mult,C:white} X#3# {} Mult for',
					'every hand played {C:red}without',
					'{C:red}a destroyed card',
					'{s:0.8,C:inactive}Why\'d you stop?',
					'{s:0.8,C:inactive}Keep going'
                } }
			},
			
			abiInit = function(card, orgRarity, orgExtTable, orgAbilityTbl)
				card.ability.extra = {
					originalRarity = orgRarity,
					x_mult = to_big((orgExtTable or orgAbilityTbl.extra).Xmult) + to_big(2),
					growth = 0.25,
					loss = 0.05,
					no_destroys = true
				}
			end,
			
			postPerfInit = function(self, card, orgRarity, orgExtTable, orgAbilityTbl)
				self.abiInit(card, orgRarity, orgExtTable, orgAbilityTbl)
				
				card.ability.extra_value = CirnoMod.miscItems.upgradedExtraValue[orgRarity]
				card:set_cost()
			end,
			
			blueprint_compat = true,
			loc_vars = function(self, info_queue, card)
				if
					not card.ability.extra
					or type(card.ability.extra) ~= 'table'
				then
					self.abiInit(card, 2, { Xmult = 3 })
				end
				
				if CirnoMod.config.artCredits and not card.fake_card then
					info_queue[#info_queue + 1] = { key = 'jA_NTF_Rend', set = 'Other' }
				end
				
				return { vars = {
					to_big(card.ability.extra.x_mult),
					to_big(card.ability.extra.growth),
					to_big(card.ability.extra.loss) 
				} }
			end,
			
			pos = { x = 7, y = 7 },
			eternal_compat = true,
			perishable_compat = false,
			
			cir_upgradeInfo = function(self, card)
				return {
					'{X:mult,C:white} X'..to_big(card.ability.extra.growth)..' {} Mult growth per {C:red}destroyed card',
					'->',
					'{X:mult,C:white} X'..to_big(card.ability.extra.growth)+to_big(0.175)..' {} Mult growth per {C:red}destroyed card'
				}
			end,
			
			cir_upgrade = function(self, card)
				card.ability.extra.growth = to_big(card.ability.extra.growth) + to_big(0.175)
				
				return { message = localize('k_upgrade_ex') }
			end,
			
			calculate = function(self, card, context)
				if
					not context.blueprint
					and not context.retrigger_joker_check
					and (context.hand_drawn
					and not context.first_hand_drawn)
					and not card.ability.extra.no_destroys
				then
					card.ability.extra.no_destroys = true
				end
				
				if context.remove_playing_cards or context.joker_type_destroyed then
					local count = #(context.removed or {}) + (context.card and 1 or 0)
					card.ability.extra.no_destroys = false
					
					SMODS.scale_card(card, {
							ref_table = card.ability.extra,
							ref_value = 'x_mult',
							operation = function(ref_table, ref_value, initial, change)
								ref_table[ref_value] = to_big(initial) + to_big(count) * to_big(change)
							end,
							scalar_value = 'growth',
							no_message = true
						})
					
					return {
						message = localize({
							type = "variable",
							key = "a_xmult",
							vars = { to_big(card.ability.extra.x_mult) } }),
						colour = G.C.MULT
					}
				end
				
				if
					context.before
					and card.ability.extra.no_destroys
					and to_big(card.ability.extra.x_mult) > to_big(1)
				then
					SMODS.scale_card(card, {
							ref_table = card.ability.extra,
							ref_value = 'x_mult',
							scalar_value = 'loss',
							operation = '-',
							no_message = true
						})
					
					return {
						message = localize({
							type = "variable",
							key = "a_xmult",
							vars = { to_big(card.ability.extra.x_mult) } }),
						colour = G.C.MULT
					}
				end
				
				if
					context.joker_main
					and G.GAME.hands[context.scoring_name] and G.GAME.hands[context.scoring_name].played_this_round > 1
					and to_big(card.ability.extra.x_mult) > to_big(1)
				then
					return { x_mult = card.ability.extra.x_mult }
				end
			end
		},
		-- Four of a Kind
		{
			key = 'foak',
			upgradesFrom = 'j_burnt',
			
			matureRefLevel = 1,
			loadOrder = 'upgRare',
			
			loc_txt = {	name = 'Four of a Kind',
                text = { {
					'Upgrade the level of',
                    'the first#1# {C:attention}discarded',
                    'poker hand#2# each round'
					}, {
					'Hands that contain a',
					'{C:attention}#3#{} gain',
					'two levels'
					}, {
					'Playing a hand containing',
					'a {C:attention}#3#',
					'grants one more',
					'temporary upgrade',
					'opportunity',
					'{s:0.8,C:inactive}"I\'ve only ever seen',
					'{s:0.8,C:inactive}humans in the form',
					'{s:0.8,C:inactive}of a drink"'
                } }
			},
			
			abiInit = function(card, orgRarity, orgExtTable, orgAbilityTbl)
				card.ability.extra = {
					originalRarity = orgRarity,
					upToDiscards = 1,
					hand = 'Four of a Kind',
					opportunity = false
				}
			end,
			
			postPerfInit = function(self, card, orgRarity, orgExtTable, orgAbilityTbl)
				self.abiInit(card, orgRarity, orgExtTable, orgAbilityTbl)
				
				card.ability.extra_value = CirnoMod.miscItems.upgradedExtraValue[orgRarity]
				card:set_cost()
			end,
			
			blueprint_compat = true,
			loc_vars = function(self, info_queue, card)
				if
					not card.ability.extra
					or type(card.ability.extra) ~= 'table'
				then
					self.abiInit(card, 3)
				end
				
				if CirnoMod.config.artCredits and not card.fake_card then
					info_queue[#info_queue + 1] = { key = 'jA_DuoDagger', set = 'Other' }
				end
				
				return { vars = {
					to_big(card.ability.extra.upToDiscards) > to_big(1) and ' '..to_big(card.ability.extra.upToDiscards) or '',
					to_big(card.ability.extra.upToDiscards) > to_big(1) and 's' or '',
					localize(card.ability.extra.hand, 'poker_hands')
				} }
			end,
			
			pos = { x = 5, y = 5 },
			eternal_compat = true,
			perishable_compat = false,
			
			cir_upgradeInfo = function(self, card)
				if to_big(card.ability.extra.upToDiscards) > to_big(1) then
					return {
						'{C:attention}First '..to_big(card.ability.extra.upToDiscards)..'{} discarded hands',
						'->',
						'{C:attention}First '..to_big(card.ability.extra.upToDiscards) + to_big(1)..'{} discarded hands'
					}
				else
					return {
						'{C:attention}First{} discarded hand',
						'->',
						'{C:attention}First 2{} discarded hands'
					}
				end
			end,
			
			cir_upgrade = function(self, card)
				card.ability.extra.upToDiscards = to_big(card.ability.extra.upToDiscards) + to_big(1)
				
				self.cir_updateState(card)
				
				return { message = localize('k_upgrade_ex') }
			end,
			
			cir_updateState = function(jkr)
				if
					G.GAME
					and G.GAME.blind.in_blind
					and (to_big(G.GAME.current_round.discards_used) < to_big(jkr.ability.extra.upToDiscards)
					or jkr.ability.extra.opportunity)
				then
					juice_card_until(jkr, function()
						return (to_big(G.GAME.current_round.discards_used) < to_big(jkr.ability.extra.upToDiscards)
							or jkr.ability.extra.opportunity)
							and not G.RESET_JIGGLES
					end, true)
				end
			end,
			
			calculate = function(self, card, context)
				if
					not context.blueprint
					and not context.retrigger_joker
					and not context.retrigger_joker_check
				then
					if context.first_hand_drawn then
						G.E_MANAGER:add_event(Event({
							trigger = 'after',
							delay = 0.2,
							blockable = true,
							blocking = false,
							func = function()
								G.RESET_JIGGLES = false
								self.cir_updateState(card)
							return true
							end }))				
					elseif
						context.hand_drawn
						and card.ability.extra.opportunity
						and to_big(G.GAME.current_round.discards_left) > to_big(0)
					then
						self.cir_updateState(card)
					end
					
					if
						context.before
						and next(context.poker_hands[card.ability.extra.hand])
					then
						card.ability.extra.opportunity = true
					end
					
					if context.end_of_round then card.ability.extra.opportunity = false end
				end
				
				if
					context.pre_discard
					and (to_big(G.GAME.current_round.discards_used) < to_big(card.ability.extra.upToDiscards)
					or card.ability.extra.opportunity)
					and not context.hook
				then
					card.ability.extra.opportunity = false
					local text, _ = G.FUNCS.get_poker_hand_info(G.hand.highlighted)
					return {
						level_up = next(select(3, G.FUNCS.get_poker_hand_info(context.full_hand))[card.ability.extra.hand]) and 2 or true,
						level_up_hand = text
					}
				end
			end
		},
		-- Cokeman
		{
			key = 'cokeman',
			upgradesFrom = 'j_diet_cola',
			
			matureRefLevel = 1,
			loadOrder = 'upgUncmn',
			
			loc_txt = {	name = 'Cokeman',
                text = {
					'When beating a blind,',
					'{C:green}#1# in #2#{} chance',
                    'of generating a',
                    'free {C:attention}#3#',
					'{s:0.8,C:inactive}Yeah, I went there'
				}
			},
			
			abiInit = function(card, orgRarity)
				card.ability.extra = {
					originalRarity = orgRarity,
					tag = 'tag_double',
					odds = 2
				}
			end,
			
			postPerfInit = function(self, card, orgRarity, orgExtTable, orgAbilityTbl)
				self.abiInit(card, orgRarity)
				
				card.ability.extra_value = CirnoMod.miscItems.upgradedExtraValue[orgRarity]
				card:set_cost()
			end,
			
			blueprint_compat = true,
			loc_vars = function(self, info_queue, card)
				if
					not card.ability.extra
					or type(card.ability.extra) ~= 'table'
				then
					self.abiInit(card, 2)
				end
				
				info_queue[#info_queue + 1] = { key = card.ability.extra.tag, set = 'Tag' }
				
				local numerator, denumerator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds)
				
				if CirnoMod.config.artCredits and not card.fake_card then
					info_queue[#info_queue + 1] = { key = 'jA_LocalThunk_NTFEdit', set = 'Other' }
				end
				
				return { vars = {
					numerator,
					denumerator,
					localize{ type = 'name_text', key = card.ability.extra.tag, set = 'Tag' }
				} }
			end,
			
			pos = { x = 2, y = 7 },
			eternal_compat = true,
			perishable_compat = false,
			
			calculate = function(self, card, context)
				if
					context.end_of_round
					and context.main_eval
					and not context.game_over
				then
					if SMODS.pseudorandom_probability(card, 'cokeman', 1, card.ability.extra.odds) then
						G.E_MANAGER:add_event(Event({
							func = (function()
								add_tag({ key = card.ability.extra.tag })
								card:juice_up()
								play_sound('generic1', 0.9 + math.random() * 0.1, 0.8)
								play_sound('holo1', 1.2 + math.random() * 0.1, 0.4)
								return true
							end)
						}))
						return nil, true
					else
						return { message = localize('k_nope_ex') }
					end
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
	jkr.atlas = jkr.atlas or 'cir_cUpgraded'
	jkr.rarity = 'cir_UpgradedJkr'
	
	if not CirnoMod.miscItems.perfectionismUpgradable_Jokers[jkr.upgradesFrom] then
		CirnoMod.miscItems.perfectionismUpgradable_Jokers[jkr.upgradesFrom] = 'j_cir_'..jkr.key
	end
	
	jkr.unlocked = false
	jkr.loc_txt.unlock = {
		"Find this {C:joker}Joker by using",
		"the {E:1,C:spectral}#1#{} card",
		"on {E:1,C:attention}#2#"
	}
	
	jkr.locked_loc_vars = function(self, info_queue, card)
		if CirnoMod.miscItems.isUnlockedAndDisc(G.P_CENTERS.c_cir_sPerfectionism_l) then
			info_queue[#info_queue + 1] = SMODS.shallow_copy(G.P_CENTERS.c_cir_sPerfectionism_l)
			info_queue[#info_queue].fake_card = true
		else
			info_queue[#info_queue + 1] = { key = 'questionMarkTooltip', set = 'Other' }
		end
		
		info_queue[#info_queue + 1] = CirnoMod.miscItems.obscureJokerTooltipIfNotEncountered(self.upgradesFrom)
		
		return { vars = {
			CirnoMod.miscItems.obscurePerfectionismNameUnlessDiscovered(),
			CirnoMod.miscItems.obscureJokerNameIfNotEncountered(self.upgradesFrom, true)
		} }
	end
	
	jkr.set_card_type_badge = function(self, card, badges)
		if CirnoMod.miscItems.isUnlockedAndDisc(card) then
			badges[#badges + 1] = CirnoMod.miscItems.badges.upgradedJkr[(G.GAME and card.ability and card.ability.extra and card.ability.extra.orgRarity) or CirnoMod.miscItems.getJokerRarityByKey(self.upgradesFrom)]()
						
			CirnoMod.miscItems.addBadgesToJokerByKey(badges, card.config.center.key)
		end
	end
	
	if jkr.mutuallyExclusive == true then
		SMODS.Joker:take_ownership(jkr.upgradesFrom, {
			upgradedKey = 'j_cir_'..jkr.key,
			
			in_pool = function(self, args)
				if next(SMODS.find_card('j_ring_master'))
					or next(SMODS.find_card('j_cir_best_buds')) then
					return true
				end
				
				return not next(SMODS.find_card(self.upgradedKey))
			end
		})
	end
	
	jkr.destroyed = jkr.destroyed or { colours = { rarityClr[jkr.loadOrder], CirnoMod.miscItems.colours.cirUpgradedJkrClr, rarityClr[jkr.loadOrder], CirnoMod.miscItems.colours.cirUpgradedJkrClr, rarityClr[jkr.loadOrder] } }
end

SMODS.Enhancement:take_ownership('glass', {
	config = { cir_ice = true, Xmult = 1, x_mult = 1, extra = { multiplier = 2, odds = 4 } },
	
	shatters = true,
	
	loc_vars = function(self, info_queue, card)
		local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'glass')
		
		local ret = { vars = { to_big(card.ability.extra.multiplier), numerator, denominator } }
		
		if next(SMODS.find_card('j_cir_perfectFreeze')) then
			if CirnoMod.miscItems.atlasCheck(card) then
				ret.key = 'm_glass_pFreeze'
			else
				ret.key = 'm_glass_pFreeze_NoCir'
			end
		end
		
		return ret
	end,
	
	calculate = function(self, card, context)
		if context.main_scoring and context.cardarea == G.play then
			if
				not card.glass_trigger
				and SMODS.pseudorandom_probability(card, 'glass', 1, card.ability.extra.odds)
			then
				card.glass_trigger = true
			end
			
			if next(SMODS.find_card('j_cir_perfectFreeze')) then
				return { x_chips = to_big(card.ability.extra.multiplier) }
			end
			
			return { x_mult = to_big(card.ability.extra.multiplier) }
		end
		
		if context.destroy_card and context.destroy_card.glass_trigger then
			return { remove = true }
		end
    end
	
}, true)

return jokerInfo
