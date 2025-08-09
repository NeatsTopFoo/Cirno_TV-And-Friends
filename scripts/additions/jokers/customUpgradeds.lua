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
		
		return '?????'
	end
end

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
		- Platinum Joker
		- Floor Plan
		- Cirno's Perfect Freeze
		- Obsessive Face
		- Utsuho Reiuji
		- VIP Diamond
		- Best Buds
		- Contentious Prediction
		- Four of a Kind
		- Rough Sketch
		- Power Seal Steel King
		- Whatever I name the Bootstraps upgrade
		- Whatever I name the Blackboard upgrade
		- God Gamer
		- Baldi
		- Dark Bead
		- Lava Chicken
		- Horse Gacha
		- Cirno Duty
		- Smug Iris Heart
		- Perfect Body Double
		- Collection
		- Cirno_TV & Friends
		- Cokeman
		- Albedo
		- Sattaton
		- Haurchefant
		- Modern-Day Makai's Charismatic Mistress
	]]
	jokerConfigs = {
		-- The Villainess
		{
			key = 'villainess',
			upgradesFrom = 'j_caino', -- (sic)
			
			matureRefLevel = 1,
			loadOrder = 'upgLgnd',
			cir_Friend = CirnoMod.miscItems.cirFriends.dm,
			
			loc_txt = { name = 'The Villainess',
				text = { {
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
			
			postPerfInit = function(self, card, orgRarity, orgExtTable, orgAbilityTbl)
				card.ability.extra = {
					originalRarity = orgRarity,
					growth = to_big(1),
					odds = 3,
					oddsDM = 2,
					heldDM = 2,
					creatingMoreThanDestroyed = false,
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
						'distributing milk'
					}
				}
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
					info_queue[#info_queue + 1] = { key = "jA_NTF", set = "Other" }
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
				
				return { message = localize('k_upgrade_ex'), colour = G.C.MULT }
			end,
			
			calculate = function(self, card, context)
				if
					card.ability.extra
					and card.ability.extra.creatingMoreThanDestroyed
					and context.hand_drawn
				then
					card.ability.extra.creatingMoreThanDestroyed = false
				end
				
				if context.remove_playing_cards then
					local face_cards = {}
					
					for i, removed_card in ipairs(context.removed) do
						if removed_card:is_face() then table.insert(face_cards, removed_card) end
					end
					
					if #face_cards > 0 then
						card.ability.caino_xmult = to_big(card.ability.caino_xmult) + (to_big(#face_cards) * to_big(card.ability.extra.growth))
						
						local jkrRef = card
						
						return { message = localize{ type = 'variable', key = 'a_xmult', vars = { to_big(card.ability.caino_xmult) } },
							func = function()
								for i, faceCard in ipairs(face_cards) do
									if
										not (faceCard.edition
										and faceCard.edition.type == 'negative')
									then
										local createNegativeOdds = card.ability.extra.odds
										
										if
											faceCard.base.value == 'Queen'
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
													
													if jkrRef.ability.extra.creatingMoreThanDestroyed then
														G.deck.config.card_limit = G.deck.config.card_limit + 1
													end
													
													G.hand:emplace(copy)
													
													copy.states.visible = nil
													
													copy:start_materialize()
													
													jkrRef.ability.extra.creatingMoreThanDestroyed = true
													
													SMODS.calculate_effect({ message = localize('k_copied_ex') }, faceCard)
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
					return { x_mult = to_big(card.ability.caino_xmult) }
				end
				
				if
					context.individual
					and not context.end_of_round
					and context.cardarea == G.hand
					and context.other_card:is_suit('Diamonds')
					and context.other_card.base.value == 'Queen'
				then
					if context.other_card.debuff then
						return {
							message = localize('k_debuffed'),
							colour = G.C.RED,
							sound = 'cancel'
						}
					else
						return { x_mult = to_big(card.ability.extra.heldDM) }
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
			
			loc_txt = { name = 'The Baka',
				text = { {
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
			
			postPerfInit = function(self, card, orgRarity, orgExtTable, orgAbilityTbl)
				card.ability.extra = orgExtTable
				card.ability.extra.originalRarity = orgRarity
				card.ability.extra.odds = 4
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
				
				return { message = localize('k_upgrade_ex'), colour = G.C.CHIPS }
			end,
			
			calculate = function(self, card, context)
				if
					context.end_of_round
					and context.main_eval
					and context.beat_boss
					and not context.blueprint
				then
					if SMODS.pseudorandom_probability(card, 'duskOrCavendish', 1, card.ability.extra.odds) then
						local targetKey = 'j_dusk'
						
						if
							G.GAME.pool_flags.vremade_gros_michel_extinct
							and math.random() < 0.5
						then
							targetKey = 'j_cavendish'
						end
						
						return { func = function()
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
				
				if context.before and context.main_eval then
					local jkrRef = card
					local foolCount = 0
					local nineCounter = 0
					
					for i, c in ipairs(context.scoring_hand) do
						if
							c:can_calculate()
							and c.base.value == '9'
						then
							nineCounter = nineCounter + 1
							
							if nineCounter == 2 then
								nineCounter = 0
								
								foolCount = foolCount + 1
							end
						end
					end
					
					for i = 1, foolCount do
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
			
			loc_txt = { name = 'The Captain',
				text = { {
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
			
			postPerfInit = function(self, card, orgRarity, orgExtTable, orgAbilityTbl)
				card.ability.extra = {}
				card.ability.extra.x_mult = orgExtTable
				card.ability.extra.growth = 0.25
				card.ability.extra.dGrowth = 1
				card.ability.extra.KoH_dollars = 1
				card.ability.extra.originalRarity = orgRarity
				card.ability.extra_value = CirnoMod.miscItems.upgradedExtraValue[orgRarity]
				card:set_cost()
			end,
			
			blueprint_compat = true,
			loc_vars = function(self, info_queue, card)
				info_queue[#info_queue + 1] = G.P_CENTERS.m_gold
				
				if CirnoMod.config.artCredits and not card.fake_card then
					info_queue[#info_queue + 1] = { key = "jA_Hannah", set = "Other" }
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
				
				if context.before and context.main_eval then
					local upgMult = true
					
					for i, c in ipairs(context.full_hand) do
						if
							not c:is_suit('Hearts')
							or c.base.value ~= 'King'
						then
							upgMult = false
							break
						end
					end
					
					if upgMult then
						card.ability.extra.x_mult = to_big(card.ability.extra.x_mult) + to_big(card.ability.extra.growth)
						
						return {
							extra = { 
								message = localize {
									type = 'variable',
									key = 'a_xmult',
									vars = { to_big(card.ability.extra.x_mult) }
								},
								colour = G.C.PURPLE,
								message_card = card
							}
						}
					end
				end
				
				if
					context.individual
					and context.cardarea == G.play
				then
					local RT = {}
					
					if SMODS.has_enhancement(context.other_card, 'm_gold') then
						context.other_card.ability.h_dollars = to_big(context.other_card.ability.h_dollars) + to_big(card.ability.extra.dGrowth)
						
						RT.extra = {
							message = localize('k_upgrade_ex'),
							colour = G.C.MONEY,
							sound = 'coin'..pseudorandom('dolSnd', 1, 5),
							message_card = context.other_card
						}
					end
					
					if
						context.other_card.base.value == 'King'
						or context.other_card.base.value == 'Queen'
					then
						RT.x_mult = to_big(card.ability.extra.x_mult)
						
						if
							context.other_card.base.value == 'King'
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
			
			loc_txt = { name = 'The Comfy Vibes',
				text = { {
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
			
			postPerfInit = function(self, card, orgRarity, orgExtTable, orgAbilityTbl)
				card.ability.extra = orgExtTable
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
				
				card.ability.extra_value = CirnoMod.miscItems.upgradedExtraValue[orgRarity]
				card:set_cost()
				
				self.updateState(card)
			end,
			
			blueprint_compat = true,
			loc_vars = function(self, info_queue, card)
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
			
			updateState = function(jkr)
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
				add_tag(Tag('tag_meteor'))
				add_tag(Tag('tag_meteor'))
				card:juice_up()
				play_sound('generic1')
			end,
			
			calculate = function(self, card, context)
				if context.before and context.main_eval then
					local makePlanet = true
					
					for i, c in ipairs(context.full_hand) do
						if
							not c:is_suit('Clubs')
							or c.base.value ~= 'King'
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
						x_mult = self.calcXMult(card) -- Multiplies the current mult by the desired amount
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
								colour = CirnoMod.miscItems.colours.cirNep,
								message_card = card
							}
						}, true
					end
				elseif
					context.end_of_round
					and context.main_eval
					and not context.blueprint
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
			
			loc_txt = { name = 'The Enthusiast',
				text = { {
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
			
			postPerfInit = function(self, card, orgRarity, orgExtTable, orgAbilityTbl)
				card.ability.x_mult = orgAbilityTbl.x_mult
				card.ability.extra = orgExtTable
				card.ability.extra.xmult = 2
				card.ability.extra.EoR_dollars = 0
				card.ability.extra.KoD_dollarsEarn = 1
				card.ability.extra.retrigger_odds = 3
				card.ability.extra.redraw_odds = 4
				card.ability.extra.originalRarity = orgRarity
				
				card.ability.extra_value = CirnoMod.miscItems.upgradedExtraValue[orgRarity]
				card:set_cost()
			end,
			
			blueprint_compat = true,
			loc_vars = function(self, info_queue, card)
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
			
			shouldReturnToHand = function(self, card)
				for _, c in ipairs(G.play.cards) do
					if c:can_calculate() and c:is_face() then return true end
				end
				
				return false
			end,
			
			returnToHand_func = function(self, card, isLastIteration, old_dfptd)
				local ret = {}
				
				for i = 1, #G.play.cards do
					if not G.play.cards[i].beingRedrawn then
						if
							G.play.cards[i]:can_calculate()
							and G.play.cards[i]:is_face()
							and SMODS.pseudorandom_probability(G.play.cards[i], 'redrawKoD', 1, card.ability.extra.redraw_odds)
						then
							G.play.cards[i].beingRedrawn = true
							table.insert(ret, G.play.cards[i])
							draw_card(G.play, G.hand or G.discard, i*100/#G.play.cards, 'down', false, G.play.cards[i], 0.1, false, false)
						elseif isLastIteration then
							draw_card(G.play, G.discard, i*100/#G.play.cards, 'down', false, G.play.cards[i])
						end
					end
				end
				
				return ret
			end,
			
			calc_dollar_bonus = function(self, card)
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
				
				return { message = localize('k_upgrade_ex'), colour = G.C.MULT }
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
						and context.other_card.base.value == 'King'
						and context.other_card:is_suit('Diamonds')
					then
						card.ability.extra.EoR_dollars = to_big(card.ability.extra.EoR_dollars) + to_big(card.ability.extra.KoD_dollarsEarn)
					end
					
					if not context.cardarea == 'unscored' and context.repetition and SMODS.pseudorandom_probability(context.other_card, 'retriggerKoD', 1, card.ability.extra.retrigger_odds) then
						if context.other_card:can_calculate() then
							return { repetitions = 1 }
						else
							return {
								message = localize('k_debuffed'),
								colour = G.C.RED,
								message_card = context.other_card
							}
						end
					end
				end
				
				if context.discard and not context.blueprint then
					if card.ability.yorick_discards <= 1 then
						card.ability.yorick_discards = card.ability.extra.discards
						card.ability.x_mult = to_big(card.ability.x_mult) + to_big(card.ability.extra.xmult)
						return {
							message = localize {
								type = 'variable',
								key = 'a_xmult',
								vars = { to_big(card.ability.x_mult) }
							}
						}
					else
						card.ability.yorick_discards = card.ability.yorick_discards - 1
						return nil, true
					end
				end
				
				if context.joker_main then return { x_mult = to_big(card.ability.x_mult) } end
			end
		},
		-- The Challenger
		{
			key = 'challenger',
			upgradesFrom = 'j_chicot',
			
			matureRefLevel = 1,
			loadOrder = 'upgLgnd',
			cir_Friend = CirnoMod.miscItems.cirFriends.mom,
			
			loc_txt = { name = 'The Challenger',
				text = { {
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
			
			blueprint_compat = true,
			loc_vars = function(self, info_queue, card)
				-- Art credit tooltip
				if CirnoMod.config.artCredits and not card.fake_card then
					info_queue[#info_queue + 1] = { key = 'jA_Reimmomo', set = 'Other' }
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
				card.ability.extra = {
					growth = 1,
					x_mult = 1,
					hands = 1,
					handSize = 2,
					originalRarity = 4
				}
				
				G.hand:change_size(card.ability.extra.handSize)
				
				card.ability.extra_value = CirnoMod.miscItems.upgradedExtraValue[orgRarity]
				card:set_cost()
				
				if G.GAME.blind and G.GAME.blind.boss and not G.GAME.blind.disabled then
					G.GAME.blind:disable()
					play_sound('timpani')
					SMODS.calculate_effect({ message = localize('ph_boss_disabled') }, card)
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
				
				return { message = localize('k_upgrade_ex'), colour = G.C.MULT }
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
										SMODS.calculate_effect({ message = localize('ph_boss_disabled') }, card)
										return true
									end
								}))
							end
						end }
				end
				
				if
					context.end_of_round
					and context.main_eval
					and G.GAME.chips >= (G.GAME.blind.chips * 2)
				then
					card.ability.extra.x_mult = to_big(card.ability.extra.x_mult) + to_big(card.ability.extra.growth)
					
					return {
						message = localize {
							type = 'variable',
							key = 'a_xmult',
							vars = { to_big(card.ability.extra.x_mult) }
						},
						colour = G.C.RED,
						message_card = card
					}
				end
				
				if context.joker_main then return { x_mult = to_big(card.ability.extra.x_mult) } end
			end
		},
		-- The Somnolent
		{
			key = 'somnolent',
			upgradesFrom = 'j_cir_arumia_l',
			
			matureRefLevel = 1,
			loadOrder = 'upgLgnd',
			cir_Friend = CirnoMod.miscItems.cirFriends.rmi,
			
			loc_txt = { name = 'The Somnolent',
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
			
			postPerfInit = function(self, card, orgRarity, orgExtTable, orgAbilityTbl)
				card.ability.extra = orgExtTable
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
				
				card.ability.extra_value = CirnoMod.miscItems.upgradedExtraValue[orgRarity]
				card:set_cost()
				self.updateState(card)
			end,
			
			blueprint_compat = true,
			loc_vars = function(self, info_queue, card)
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
			
			shouldReturnToHand = function(self, card)
				for _, c in ipairs(G.play.cards) do
					if c:can_calculate() and SMODS.has_enhancement(c, 'm_wild') then return true end
				end
				
				return false
			end,
			
			returnToHand_func = function(self, card, isLastIteration, old_dfptd)
				local ret = {}
				
				for i = 1, #G.play.cards do
					if not G.play.cards[i].beingRedrawn then
						if
							G.play.cards[i]:can_calculate()
							and SMODS.has_enhancement(G.play.cards[i], 'm_wild')
						then
							G.play.cards[i].beingRedrawn = true
							table.insert(ret, G.play.cards[i])
							draw_card(G.play, G.hand or G.discard, i*100/#G.play.cards, 'down', false, G.play.cards[i], 0.1, false, false)
						elseif isLastIteration then
							draw_card(G.play, G.discard, i*100/#G.play.cards, 'down', false, G.play.cards[i])
						end
					end
				end
				
				return ret
			end,
			
			cir_upgradeInfo = function(self, card)
				return {
					'Create 5 random',
					'{C:dark_edition}Negative {C:tarot}Tarot Cards'
				}
			end,
			
			cir_upgrade = function(self, card)
				SMODS.add_card({ set = 'Tarot', edition = 'e_negative' })
				SMODS.add_card({ set = 'Tarot', edition = 'e_negative' })
				SMODS.add_card({ set = 'Tarot', edition = 'e_negative' })
				SMODS.add_card({ set = 'Tarot', edition = 'e_negative' })
				SMODS.add_card({ set = 'Tarot', edition = 'e_negative' })
				card:juice_up()
				play_sound('generic1')
			end,
			
			calculate = function(self, card, context)
				if
					context.modify_scoring_hand
					and context.main_eval
					and not context.retrigger_joker
					and not context.retrigger_joker_check
					and not context.blueprint
					and context.other_card
					and context.other_card:can_calculate()
					and SMODS.has_enhancement(context.other_card, 'm_wild')
				then
					return { doNotRedSeal = true, add_to_hand = true }
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
								return { repetitions = 1 }
							else
								return {
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
						and context.hand_drawn
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
		-- The Anon
		{
			key = 'anon',
			upgradesFrom = 'j_perkeo',
			
			matureRefLevel = 1,
			loadOrder = 'upgLgnd',
			cir_Friend = CirnoMod.miscItems.cirFriends.dck,
			
			loc_txt = { name = 'The Anon',
				text = { {
					'Creates a {C:dark_edition}Negative{} copy of',
                    'the leftmost {C:attention}consumable{}',
                    'card in your possession',
                    'at the end of the {C:attention}shop'
					}, {
					'Played {C:attention}Queens{} of {C:spades_hc}Spades',
					'without an enhancement',
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
			
			postPerfInit = function(self, card, orgRarity, orgExtTable, orgAbilityTbl)
				card.ability.extra = {
					originalRarity = orgRarity,
					extraHandsCount = 0,
					prevHandsCount = 0,
					flipPitch = 1
				}
				
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
					'{C:attention}'..G.localization.descriptions.Tag.tag_negative.name..'s'
				}
			end,
			
			cir_upgrade = function(self, card)
				add_tag(Tag('tag_negative'))
				add_tag(Tag('tag_negative'))
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
						and context.main_eval
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
						and context.other_card.base.value == 'Queen'
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
			
			loc_txt = { name = 'The Enigma',
				text = { {
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
			
			postPerfInit = function(self, card, orgRarity, orgExtTable, orgAbilityTbl)
				card.ability.extra = orgExtTable
				card.ability.extra.originalRarity = orgRarity
				
				card.ability.extra.xChips = 1.11
				card.ability.extra.dollars = 1
				card.ability.extra.cardsMultAdded = 0
				card.ability.extra.retriggerBypass = false
				
				card.ability.extra_value = CirnoMod.miscItems.upgradedExtraValue[orgRarity]
				card:set_cost()
			end,
			
			blueprint_compat = true,
			loc_vars = function(self, info_queue, card)
				-- Art credit tooltip
				if CirnoMod.config.artCredits and not card.fake_card then
					info_queue[#info_queue + 1] = { key = 'jA_Houdini', set = 'Other' }
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
				return { dollars = 111 }
			end,
			
			calculate = function(self, card, context)
				if context.setting_blind and card.ability.extra.cardsMultAdded > 0 then
					card.ability.extra.cardsMultAdded = 0
				end
				
				if
					(context.before
					or context.hand_drawn)
					and card.ability.extra.retriggerBypass
				then
					card.ability.extra.retriggerBypass = false
				end
				
				if
					context.individual
					and (context.cardarea == G.play
					or context.cardarea == 'unscored')
					and context.other_card
				then
					local ret = { no_retrigger = true }
					
					if context.other_card:can_calculate() then
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
							-- Return table (in extra to prevent the colour being overridden by Blueprint/Brainstorm)
							ret.no_retrigger = false
							ret.extra = {
									message = localize('k_upgrade_ex'),
									colour = G.C.RED,
									message_card = context.other_card
								}
							
							context.other_card.ability.perma_mult = to_big(context.other_card.ability.perma_mult) or 0
							context.other_card.ability.perma_mult = to_big(context.other_card.ability.perma_mult) + to_big(permMultToAdd)
							
							if not context.blueprint and not (context.retrigger_joker or context.retrigger_joker_check) then
								card.ability.extra.cardsMultAdded = card.ability.extra.cardsMultAdded + 1
							end
						end
					end
					
					if context.other_card == context.full_hand[#context.full_hand] then
						if
							card.ability.extra.cardsMultAdded == #context.full_hand
							or (card.ability.extra.retriggerBypass
							and (context.retrigger_joker
							or context.retrigger_joker_check))
						then
							if not (context.retrigger_joker or context.retrigger_joker_check) then
								card.ability.extra.retriggerBypass = true
							end
							
							ret.no_retrigger = false
							ret.extra.extra = {
								dollars = to_big(card.ability.extra.dollars),
								colour = G.C.MONEY,
								message_card = context.blueprint_card or card
							}
						end
						
						if
							not context.blueprint
							and not (context.retrigger_joker
							or context.retrigger_joker_check)
						then
							card.ability.extra.cardsMultAdded = 0
						end
					end
					
					return ret
				end
				
				if context.joker_main then return { x_chips = to_big(card.ability.extra.xChips) } end
			end
		},
		-- The Catboy
		{
			key = 'catboy',
			upgradesFrom = 'j_cir_wolsk_l',
			
			matureRefLevel = 1,
			loadOrder = 'upgLgnd',
			cir_Friend = CirnoMod.miscItems.cirFriends.wls,
			
			loc_txt = { name = 'The Catboy',
				text = { {
					'Every played {C:attention}card',
					'in the first {C:blue}hand{} of the round',
					'{C:attention}permanently{} gains {X:mult,C:white}X#1#{} Mult',
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
			
			postPerfInit = function(self, card, orgRarity, orgExtTable, orgAbilityTbl)
				card.ability.extra = orgExtTable
				card.ability.extra.originalRarity = orgRarity
				
				card.ability.extra.extra_KoS = 0.25
				
				card.ability.extra_value = CirnoMod.miscItems.upgradedExtraValue[orgRarity]
				card:set_cost()
			end,
			
			blueprint_compat = true,
			loc_vars = function(self, info_queue, card)
				if CirnoMod.config['artCredits'] and not card.fake_card then
					info_queue[#info_queue + 1] = { key = "jA_Wolsk", set = "Other" }
				end
				
				local denom = 0
				
				if G.play and G.play.cards and #G.play.cards > 0 then
					denom = #G.play.cards
				elseif G.hand and G.hand.highlighted and #G.hand.highlighted > 0 then
					denom = #G.hand.highlighted
				end
				
				local numerator, denominator = SMODS.get_probability_vars(card or self, 1, denom)
				
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
					'{s:0.8( Kings of Spades {s:0.8,X:mult,C:white}X'..to_big(card.ability.extra.extra_KoS)..'{s:0.8})',
					'->',
					'{X:mult,C:white}X'..to_big(card.ability.extra.extra) + to_big(0.1)..'{} Mult scaling',
					'{s:0.8( Kings of Spades {s:0.8,X:mult,C:white}X'..to_big(card.ability.extra.extra_KoS) + to_big(0.1)..'{s:0.8})'
				}
			end,
			
			cir_upgrade = function(self, card)
				card.ability.extra.extra = to_big(card.ability.extra.extra) + to_big(0.1)
				card.ability.extra.extra_KoS = to_big(card.ability.extra.extra_KoS) + to_big(0.1)
				
				return { message = localize('k_upgrade_ex'), colour = G.C.MULT }
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
					
					if
						context.other_card.base.value == 'King'
						and context.other_card:is_suit('Spades')
					then
						context.other_card.ability.perma_x_mult = to_big(context.other_card.ability.perma_x_mult) + to_big(card.ability.extra.extra_KoS)
					else
						context.other_card.ability.perma_x_mult = to_big(context.other_card.ability.perma_x_mult) + to_big(card.ability.extra.extra)
					end
					
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
			
			loc_txt = { name = 'The Soft-Spoken',
				text = { {
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
				if CirnoMod.config['artCredits'] and not card.fake_card then
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
					and context.main_eval
				then
					if card.ability.extra.finalHandHadJoS then
						card.ability.extra.finalHandHadJoS = false
					end
					
					for i, c in ipairs(context.full_hand) do
						if
							c.base.value == 'Jack'
							and c:is_suit('Spades')
						then
							card.ability.extra.finalHandHadJoS = true
							break
						end
					end
				end
				
				if context.end_of_round and context.main_eval then
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
			
			loc_txt = { name = 'Quality Assured',
				text = { {
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
					'the entire hand is',
					'flipped during the above,',
					'create a free {C:attention}Negative Tag',
					'{s:0.8,C:inactive}#4#',
					'{s:0.8,C:inactive}#5#'
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
				
				info_queue[#info_queue + 1] = { key = 'tag_negative', set = 'Tag', config = { type = 'store_joker_modify', edition = 'negative', odds = 5 } }
				
				if CirnoMod.config.artCredits and not card.fake_card then
					info_queue[#info_queue + 1] = { key = "jA_NTF", set = "Other" }
				end
				
				local flavour = ''
				local flavour2 = ''
				
				if CirnoMod.config.matureReferences_cyc > 1 then
					flavour = 'Tom\'s favourite Chinese'
					flavour2 = 'snack food, sticky FUCK!'
				end
				
				return { vars = {
					#G.jokers.cards - 1,
					to_big(card.ability.extra.scalar),
					card.ability.extra.rCounter,
					flavour,
					flavour2
				} }
			end,
			
			pos = { x = 7, y = 2 },
			soul_pos = { x = 7, y = 3 },
			cost = 30,
			eternal_compat = false,
			perishable_compat = false,
			
			updateState = function(jkr)
				if
					jkr.ability.extra.rCounter >= 2
					and CirnoMod.miscItems.isState(G.STATE, G.STATES.SELECTING_HAND)
				then
					local eval = function(card)
						if card.ability.extra.selling then
							return false
						end
						
						return (not card.REMOVED
							or not CirnoMod.miscItems.isState(G.STATE, G.STATES.SELECTING_HAND))
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
									or not CirnoMod.miscItems.isState(G.STATE, G.STATES.SELECTING_HAND))
									and not G.RESET_JIGGLES
							end
							juice_card_until(card, eval, true)
						end
						
						if
							context.selling_self
							and CirnoMod.miscItems.isState(G.STATE, G.STATES.SELECTING_HAND)
						then
							card.ability.extra.selling = true
							
							local qa_chainTbl = { 
								saved_HL_Limit = G.hand.config.highlighted_limit,
								eligibleJkrs = {},
								cardFlipCountTable = {},
								toFlip = {},
								scalar = card.ability.extra.scalar,
								flipCount = #G.jokers.cards - 1,
								curTotalHandFlipCount = 0,
								eventStage = 0,
								sfxPrc = 0.975,
								sfxNme = nil,
								microstageProg = 1,
								juiceStrength = 0.1
							}
							
							G.hand.config.highlighted_limit = 0
							G.hand:unhighlight_all()
							
							for i = 1, #G.hand.cards do
								G.hand.cards[i].states.drag.can = false
								qa_chainTbl.cardFlipCountTable['card'..i..'_flipCount'] = 0
							end
							
							for i, jkr in ipairs (G.jokers.cards) do
								if
									jkr.edition
									and jkr.ability.name ~= 'j_cir_qualityAssured'
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
		-- The Sadist
		{
			key = 'sadist',
			upgradesFrom = 'j_cir_nope_l',
			
			matureRefLevel = 1,
			loadOrder = 'upgLgnd',
			cir_Friend = CirnoMod.miscItems.cirFriends.ntf,
			
			loc_txt = { name = 'The Sadist',
				text = { {
					'This {C:joker}Joker{} gains',
					'{X:mult,C:white} X#1# {} Mult when failing',
					'a {C:attention}#2#',
					'{C:inactive}(Currently {X:mult,C:white} X#3# {C:inactive} Mult)'
					}, {
					'If played hand contains a',
					'{C:attention}#4#{}, stores',
					'all {C:attention}scored{} card values',
					'{C:inactive}(Currently {C:chips}+#5#{C:inactive} Chips {C:mult}+#6#{C:inactive} Mult,',
					'{X:chips,C:white} X#7# {C:inactive} Chips, {X:mult,C:white} X#8# {C:inactive} Mult, {C:money}#9#{C:inactive})',
					'Until a hand containing a',
					'{C:attention}Queen{} of {C:hearts_hc}Hearts',
					'is played'
					}, {
					'{C:attention}Queens{} of {C:diamonds_hc}Diamonds{} and',
					'{C:attention}Girl_DM_{C:joker} Jokers{C:attention} retrigger',
					'{s:0.8,C:inactive}Bias? In my house?',
					'{s:0.8,C:inactive}Nahhhhhh'
				} }
			},
			
			postPerfInit = function(self, card, orgRarity, orgExtTable, orgAbilityTbl)
				card.ability.extra = orgExtTable
				card.ability.extra.originalRarity = orgRarity
				
				card.ability.extra.growth = 1.25
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
				
				self.resetStored(card)
				
				card.ability.extra_value = CirnoMod.miscItems.upgradedExtraValue[orgRarity]
				card:set_cost()
			end,
			
			blueprint_compat = true,
			loc_vars = function(self, info_queue, card)
				info_queue[#info_queue + 1] = copy_table(G.P_CENTERS.c_wheel_of_fortune)
				info_queue[#info_queue].fake_card = true
				
				-- Art credit tooltip
				if CirnoMod.config['artCredits'] and not card.fake_card then
					info_queue[#info_queue + 1] = { key = "jA_NTF", set = "Other" }
				end
				
				return { vars = {
					to_big(card.ability.extra.growth),
					G.localization.descriptions.Tarot.c_wheel_of_fortune.name,
					to_big(card.ability.extra.x_mult),
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
				return {
					'{X:mult,C:white}X'..to_big(card.ability.extra.growth)..'{} Mult scaling',
					'->',
					'{X:mult,C:white}X'..to_big(card.ability.extra.growth) + to_big(0.5)..'{} Mult scaling',
					'& {C:attention}all stored values X2'
				}
			end,
			
			cir_upgrade = function(self, card)
				card.ability.extra.growth = to_big(card.ability.extra.growth) + to_big(0.5)
				
				for k, v in pairs(card.ability.extra.stored) do
					if
						(k ~= 'x_chips'
						and k ~= 'x_mult')
						or ((k == 'x_chips'
						or k == 'x_mult')
						and v > to_big(1))
					then
						v = to_big(v) * to_big(2)
					end
				end
				
				return { message = localize('k_upgrade_ex'), colour = G.C.MULT }
			end,
			
			calculate = function(self, card, context)
				if
					not context.blueprint
					and not (context.retrigger_joker
					and not context.retrigger_joker_check)
					and (context.before
					or context.hand_drawn
					or context.end_of_round
					or context.starting_shop)
					and context.main_eval
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
								c.base.value == 'Queen'
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
					and context.cardarea == G.play
					and next(context.poker_hands[card.ability.extra.handType])
				then
					local jkrRef = card
					local initialX = {
						x_chips = to_big(card.ability.extra.stored.x_chips),
						x_mult = to_big(card.ability.extra.stored.x_mult)
					}
					
					card.ability.extra.stored.chips = to_big(card.ability.extra.stored.chips) + to_big(context.other_card.base.nominal) + to_big(context.other_card.ability.bonus) + to_big(context.other_card.ability.perma_bonus)
					
					card.ability.extra.stored.mult = to_big(card.ability.extra.stored.mult) + to_big(context.other_card.ability.perma_mult)
					
					card.ability.extra.stored.x_chips = to_big(card.ability.extra.stored.x_chips) + (context.other_card.ability.x_chips > 1 and to_big(context.other_card.ability.x_chips) or 0) + (context.other_card.ability.perma_x_chips > 1 and to_big(context.other_card.ability.perma_x_chips) or 0)
					
					if
						initialX.x_chips == to_big(1)
						and card.ability.extra.stored.x_chips > initialX.x_chips
					then
						card.ability.extra.stored.x_chips = to_big(card.ability.extra.stored.x_chips) - to_big(1)
					end
					
					card.ability.extra.stored.x_mult = to_big(card.ability.extra.stored.x_mult) + (context.other_card.ability.x_mult > 1 and to_big(context.other_card.ability.x_mult) or 0) + (context.other_card.ability.perma_x_mult > 1 and to_big(context.other_card.ability.perma_x_mult) or 0)
					
					if
						initialX.x_chips == to_big(1)
						and card.ability.extra.stored.x_mult > initialX.x_mult
					then
						card.ability.extra.stored.x_mult = to_big(card.ability.extra.stored.x_mult) - to_big(1)
					end
					
					card.ability.extra.stored.dollars = to_big(card.ability.extra.stored.dollars) + to_big(context.other_card.ability.perma_p_dollars)
					
					if context.other_card.ability.effect ~= 'Lucky Card' then
					card.ability.extra.stored.mult = to_big(card.ability.extra.stored.mult) + to_big(context.other_card.ability.mult)
					
					card.ability.extra.stored.dollars = to_big(card.ability.extra.stored.dollars) + to_big(context.other_card.ability.p_dollars)
					end
					
					return { func = function() jkrRef:juice_up() end }
				end
				
				if context.joker_main then
					local ret = {
						x_mult = to_big(card.ability.extra.x_mult),
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
				then
					if
						not context.blueprint
						and not context.result
						and context.trigger_obj.ability.name == "The Wheel of Fortune"
					then
						card.ability.extra.x_mult = to_big(card.ability.extra.x_mult) + to_big(card.ability.extra.growth)
						
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
								vars = { to_big(card.ability.extra.x_mult) } }),
							colour = CirnoMod.miscItems.colours.cirNope,
							message_card = card
						}, true
					end
					
					if
						card.ability.extra.containsFH
						and context.trigger_obj.ability.effect == 'Lucky Card'
						and context.result
					then
						if context.identifier == 'lucky_mult' then
							card.ability.extra.stored.mult = to_big(card.ability.extra.stored.mult) + to_big(context.trigger_obj.ability.mult)
						end
						
						if context.identifier == 'lucky_money' then
							card.ability.extra.stored.dollars = to_big(card.ability.extra.stored.dollars) + to_big(context.trigger_obj.ability.p_dollars)
						end
					end
				end
				
				if
					(context.repetition
					and (context.cardarea == G.play
					or context.cardarea == G.hand)
					and context.other_card.base.value == 'Queen'
					and context.other_card:is_suit('Diamonds'))
					or (context.retrigger_joker_check
					and card.ability.extra.dm_jokers[context.other_card.config.center.key])
				then
					return { repetitions = 1 }
				end
			end
		},
		-- THE Queen of Diamonds
		{
			key = 'queenOfDiamonds',
			upgradesFrom = 'j_greedy_joker',
			
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
			
			postPerfInit = function(self, card, orgRarity, orgExtTable, orgAbilityTbl)
				card.ability.extra = orgExtTable
				card.ability.extra.originalRarity = orgRarity
				
				card.ability.extra.s_mult = to_big(card.ability.extra.s_mult) + to_big(2)
				card.ability.extra.s_x_mult = 1.5
				
				card.ability.extra_value = CirnoMod.miscItems.upgradedExtraValue[orgRarity]
				card:set_cost()
			end,
			
			blueprint_compat = true,
			loc_vars = function(self, info_queue, card)
				if CirnoMod.config['artCredits'] and not card.fake_card then
					info_queue[#info_queue + 1] = { key = 'jA_DaemonTsun_NTFEdit', set = 'Other' }
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
					'{C:diamonds_hc}'..card.ability.extra.suit..'{} cards give',
					'{C:mult}+'..to_big(card.ability.s_mult)..'{} Mult',
					'And {C:attention}Queens',
					'{X:mult,C:white}X'..to_big(card.ability.s_x_mult)..'{} Mult',
					'->',
					'{C:diamonds_hc}'..card.ability.extra.suit..'{} cards give',
					'{C:mult}+'..to_big(card.ability.s_mult) + to_big(5)..'{} Mult',
					'And {C:attention}Queens',
					'{X:mult,C:white}X'..to_big(card.ability.s_x_mult) + to_big(1)..'{} Mult'
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
					
					if context.other_card.base.value == 'Queen' then
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
			
			postPerfInit = function(self, card, orgRarity, orgExtTable, orgAbilityTbl)
				card.ability.extra = orgExtTable
				card.ability.extra.originalRarity = orgRarity
				
				card.ability.extra.s_mult = to_big(card.ability.extra.s_mult) + to_big(2)
				card.ability.extra.s_x_mult = 1.5
				
				card.ability.extra_value = CirnoMod.miscItems.upgradedExtraValue[orgRarity]
				card:set_cost()
			end,
			
			blueprint_compat = true,
			loc_vars = function(self, info_queue, card)
				if CirnoMod.config['artCredits'] and not card.fake_card then
					info_queue[#info_queue + 1] = { key = 'jA_DaemonTsun_NTFEdit', set = 'Other' }
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
					'{C:hearts_hc}'..card.ability.extra.suit..'{} cards give',
					'{C:mult}+'..to_big(card.ability.s_mult)..'{} Mult',
					'And {C:attention}Kings',
					'{X:mult,C:white}X'..to_big(card.ability.s_x_mult)..'{} Mult',
					'->',
					'{C:hearts_hc}'..card.ability.extra.suit..'{} cards give',
					'{C:mult}+'..to_big(card.ability.s_mult) + to_big(5)..'{} Mult',
					'And {C:attention}Kings',
					'{X:mult,C:white}X'..to_big(card.ability.s_x_mult) + to_big(1)..'{} Mult'
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
					
					if context.other_card.base.value == 'King' then
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
			
			postPerfInit = function(self, card, orgRarity, orgExtTable, orgAbilityTbl)
				card.ability.extra = orgExtTable
				card.ability.extra.originalRarity = orgRarity
				
				card.ability.extra.s_mult = to_big(card.ability.extra.s_mult) + to_big(2)
				card.ability.extra.s_x_mult = 1.5
				
				card.ability.extra_value = CirnoMod.miscItems.upgradedExtraValue[orgRarity]
				card:set_cost()
			end,
			
			blueprint_compat = true,
			loc_vars = function(self, info_queue, card)
				if CirnoMod.config['artCredits'] and not card.fake_card then
					info_queue[#info_queue + 1] = { key = 'jA_DaemonTsun_NTFEdit', set = 'Other' }
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
					'{C:spades_hc}'..card.ability.extra.suit..'{} cards give',
					'{C:mult}+'..to_big(card.ability.s_mult)..'{} Mult',
					'And {C:attention}Queens',
					'{X:mult,C:white}X'..to_big(card.ability.s_x_mult)..'{} Mult',
					'->',
					'{C:spades_hc}'..card.ability.extra.suit..'{} cards give',
					'{C:mult}+'..to_big(card.ability.s_mult) + to_big(5)..'{} Mult',
					'And {C:attention}Queens',
					'{X:mult,C:white}X'..to_big(card.ability.s_x_mult) + to_big(1)..'{} Mult'
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
					
					if context.other_card.base.value == 'Queen' then
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
			
			matureRefLevel = 1,
			loadOrder = 'upgCmn',
			cir_Friend = CirnoMod.miscItems.cirFriends.dck,
			
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
			
			postPerfInit = function(self, card, orgRarity, orgExtTable, orgAbilityTbl)
				card.ability.extra = orgExtTable
				card.ability.extra.originalRarity = orgRarity
				
				card.ability.extra.s_mult = to_big(card.ability.extra.s_mult) + to_big(2)
				card.ability.extra.s_x_mult = to_big(1.5)
				
				card.ability.extra_value = CirnoMod.miscItems.upgradedExtraValue[orgRarity]
				card:set_cost()
			end,
			
			blueprint_compat = true,
			loc_vars = function(self, info_queue, card)
				if CirnoMod.config['artCredits'] and not card.fake_card then
					info_queue[#info_queue + 1] = { key = 'jA_DaemonTsun_NTFEdit', set = 'Other' }
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
					'{C:clubs_hc}'..card.ability.extra.suit..'{} cards give',
					'{C:mult}+'..to_big(card.ability.s_mult)..'{} Mult',
					'And {C:attention}Queens',
					'{X:mult,C:white}X'..to_big(card.ability.s_x_mult)..'{} Mult',
					'->',
					'{C:clubs_hc}'..card.ability.extra.suit..'{} cards give',
					'{C:mult}+'..to_big(card.ability.s_mult) + to_big(5)..'{} Mult',
					'And {C:attention}Queens',
					'{X:mult,C:white}X'..to_big(card.ability.s_x_mult) + to_big(1)..'{} Mult'
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
					
					if context.other_card.base.value == 'Queen' then
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
			
			postPerfInit = function(self, card, orgRarity, orgExtTable, orgAbilityTbl)
				card.ability.extra = { originalRarity = orgRarity }
				
				card.ability.x_mult = 2
				card.ability.mult = 0
				
				card.ability.extra_value = CirnoMod.miscItems.upgradedExtraValue[orgRarity]
				card:set_cost()
			end,
			
			blueprint_compat = true,
			loc_vars = function(self, info_queue, card)
				if CirnoMod.config['artCredits'] and not card.fake_card then
					info_queue[#info_queue + 1] = { key = 'jA_NTF_Rend', set = 'Other' }
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
				if CirnoMod.config['artCredits'] and not card.fake_card then
					info_queue[#info_queue + 1] = { key = 'jA_NTF_Rend', set = 'Other' }
				end
				
				return nil
			end,
			
			pos = { x = 5, y = 4 },
			eternal_compat = true,
			perishable_compat = true,
			
			calculate = function(self, card, context)
				if
					context.initial_scoring_step
					and context.main_eval
				then
					local lowest_card_ind = nil
					
					for i = 1, #G.hand.cards do
						if
							lowest_card_ind == nil
							or CirnoMod.miscItems.cardRanksToValues_AceLow[G.hand.cards[i].base.value] <= CirnoMod.miscItems.cardRanksToValues_AceLow[G.hand.cards[lowest_card_ind].base.value]
						then
							lowest_card_ind = i
						end
					end
					
					G.hand.cards[lowest_card_ind].lowest_card = true
				end
				
				if
					(context.hand_drawn
					or context.end_of_round)
					and context.main_eval
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
							message = localiez('k_debuffed'),
							colour = G.C.RED
						}
					else
						return { x_chips = to_big(CirnoMod.miscItems.cardRanksToValues_AceLow[context.other_card.base.value]) }
					end
				end
			end
		},
		-- Cirno's Perfect Freeze
		{
			key = 'perfectFreeze',
			upgradesFrom = 'j_glass',
			
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
					'The odds for {C:attention}#2#{}',
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
			
			postPerfInit = function(self, card, orgRarity, orgExtTable, orgAbilityTbl)
				card.ability.extra = {
					originalRarity = orgRarity,
					growth = 1,
					x_chips = orgAbilityTbl.x_mult,
					odds = 9
				}
				
				card.ability.extra_value = CirnoMod.miscItems.upgradedExtraValue[orgRarity]
				card:set_cost()
			end,
			
			blueprint_compat = true,
			loc_vars = function(self, info_queue, card)
				info_queue[#info_queue + 1] = G.P_CENTERS.m_glass
				
				if CirnoMod.config['artCredits'] and not card.fake_card then
					info_queue[#info_queue + 1] = { key = 'jA_DaemonTsun_BigNTFEdit', set = 'Other' }
				end
				
				local breakNom, breakDenom = SMODS.get_probability_vars(card or self, 1, card.ability.extra.odds, 'glass')
				
				local iceNom, iceDenom = SMODS.get_probability_vars(card or self, 1, card.ability.extra.odds, 'perfectFreeze')
				
				return { vars = {
					to_big(card.ability.extra.growth),
					G.localization.descriptions.Enhanced.m_glass.name,
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
					if context.before and context.main_eval then
						local cardsToSet = {}
						
						for i, c in ipairs(context.full_hand) do
							if
								not next(SMODS.get_enhancements(c))
								and (c.base.value == '9'
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
	}
}

--[[ Define things that are constant with every Joker in
this file once in a loop, rather than repeatedly per
table element ]]
for i, jkr in ipairs(jokerInfo.jokerConfigs) do
	jkr.object_type = 'Joker'
	jkr.atlas = 'cir_cUpgraded'
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
			info_queue[#info_queue + 1] = copy_table(G.P_CENTERS.c_cir_sPerfectionism_l)
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