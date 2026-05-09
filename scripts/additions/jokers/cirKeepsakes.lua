CirnoMod.miscItems.keepsakeRarity = SMODS.Rarity{
		key = 'keepsake_r',
		loc_txt = { name = 'Keepsake' },
		badge_colour = CirnoMod.miscItems.colours.cirKeepsakeClr,
		pools = {}
	}

local keepsakeInfo = {
	--[[
	isMultipleJokers = true,
	
	dependenciesForAddition = function()
		return CirnoMod.config.addCustomConsumables
	end,
	]]
	
	--[[ Defines the Atlas
	atlasInfo = {
		key = 'cir_decksAndKeepsakes',
		path = "Additional/cir_custDecks.png",
		px = 71,
		py = 95
	}
	]]
	
	--[[ TODO:
		- Pudding
		- Artorias
		- Pot of Greed
		- Red Star (tentative, will probably ask Houdini about it)
		- Whatever I figure out for Wolsk
		- Whatever I figure out for Demeorin
		- Bingo Sheet
		- Whatever I figure out for Reimmomo
		- Whatever I figure out for Octopimp
		- Lucky Chloe
		- Whatever I figure out for Vileelf
	]]
	keepsakeConfigs = {
		-- Zayne
		{
			key = 'zayne',
			forWhichFDeck = 'b_cir_flesh',
			cir_Friend = CirnoMod.miscItems.cirFriends.dm,
			matureRefLevel = 1,
			loc_txt = { name = 'Zayne', text = {
					'Played cards without',
					'an {C:attention}enhancement{} have',
					'a {C:green}#1# in #2#{} chance of',
					'becoming {C:attention}#3#s',
					'{s:0.8,C:inactive}Doing just fine'
				}
			},
			
			loc_vars = function(self, info_queue, card)
				info_queue[#info_queue + 1] = SMODS.shallow_copy(G.P_CENTERS.m_glass)
				info_queue[#info_queue].fake_card = true
				
				-- Art credit tooltip
				if CirnoMod.config.artCredits and not card.fake_card then
					info_queue[#info_queue + 1] = { key = "kA_zayne", set = "Other" }
				end
				
				local numerator, denominator = SMODS.get_probability_vars(card or self, 1, card.ability.extra.odds, 'zayneIce')
				
				return { vars = {
					numerator,
					denominator,
					localize{ type = 'name_text', key = 'm_glass', set = 'Enhanced' }
				} }
			end,
			
			config = { extra = {
				odds = 4
			} },
			
			pos = { x = 0, y = 1 },
			eternal_compat = false,
			perishable_compat = false,
			
			calculate = function(self, card, context)
				if
					context.before
					and not context.blueprint
					and not context.retrigger_joker
					and not context.retrigger_joker_check
				then
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
		},
		-- Chocola Figure
		{
			key = 'cola',
			forWhichFDeck = 'b_cir_frozen',
			cir_Friend = CirnoMod.miscItems.cirFriends.cir,
			cir_btn_clr = CirnoMod.miscItems.colours.cirNo,
			matureRefLevel = 1,
			loc_txt = { name = 'Chocola Figure', text = {
					'{C:attention}+#1#{} consumable slot#2#',
					'{C:attention}#3#{} time#4# every {C:attention}Ante{},',
					'use the button on',
					'this {C:cirKeepsakeClr}Keepsake{C:attention} while',
					'{C:attention}selecting a hand{} to',
					'{C:attention}balance{C:chips} Chips{} & {C:mult}Mult',
					'after scoring',
					'{C:inactive}(Currently {C:cirNo}#5#{C:inactive}/{C:cirNo}#3#{C:inactive})',
					'{s:0.8,C:inactive}Don\'t worry, the stickers',
					'{s:0.8,C:inactive}on Cirno\'s RL figure',
					'{s:0.8,C:inactive}keep his stream safe',
					'{s:0.8,C:inactive}so this should be fine'
				}
			},
			
			loc_vars = function(self, info_queue, card)
				-- Art credit tooltip
				if CirnoMod.config.artCredits and not card.fake_card then
					info_queue[#info_queue + 1] = { key = "kA_NTF_Rend", set = "Other" }
				end
				
				return { vars = {
					card.ability.extra.consumSlots,
					card.ability.extra.consumSlots > 1 and 's' or '',
					card.ability.extra.max_btn_uses,
					card.ability.extra.max_btn_uses > 1 and 's' or '',
					card.ability.extra.cur_btn_uses
				} }
			end,
			
			config = { extra = {
				consumSlots = 1,
				consumOdds = 9,
				max_btn_uses = 1,
				cur_btn_uses = 1,
				active = false
			} },
			
			pos = { x = 1, y = 1 },
			eternal_compat = false,
			perishable_compat = false,
			
			add_to_deck = function(self, card, from_debuff)
				G.consumeables.config.card_limit = G.consumeables.config.card_limit + card.ability.extra.consumSlots
			end,
			
			cir_btn_use = function(self, card)
				card.ability.extra.active = true
				card:juice_up()
				card.ability.extra.cur_btn_uses = card.ability.extra.cur_btn_uses - 1
			end,
			
			cir_btn_can_use = function(self, card)
				return (not card.ability.extra.active) and G.STATE ~= G.STATES.HAND_PLAYED and G.GAME.blind.in_blind and card.ability.extra.cur_btn_uses > 0
			end,
			
			cir_upgradeInfo = function(self, card)
				local numerator, denominator = SMODS.get_probability_vars(card or self, 1, card.ability.extra.consumOdds)
				
				return {
					'{C:green}'..numerator..' in '..denominator..'{} chance to',
					'gain an extra',
					'{C:attention}consumable slot{},',
					'otherwise {C:attention}+1 balance',
					'{C:attention}button uses'
				}
			end,
			
			cir_upgrade = function(self, card)
				if SMODS.pseudorandom_probability(card, 'cola_consume', 1, card.ability.extra.consumOdds) then
					G.consumeables.config.card_limit = to_big(G.consumeables.config.card_limit) + to_big(card.ability.extra.consumSlots)
					return {  message = '+'..to_big(card.ability.extra.consumSlots)..' Consumable Slot' }
				end
				
				card.ability.extra.max_btn_uses = to_big(card.ability.extra.max_btn_uses) + to_big(1)
				
				if to_big(card.ability.extra.cur_btn_uses) < to_big(card.ability.extra.max_btn_uses) then
					card.ability.extra.cur_btn_uses = to_big(card.ability.extra.cur_btn_uses) + to_big(1)
				end
				
				return { message = '+1 Balance' }
			end,
			
			calculate = function(self, card, context)
				if
					context.final_scoring_step
					and card.ability.extra.active
				then
					card.ability.extra.active = false
					return { balance = true }
				end
				
				if
					context.ante_change
					and context.ante_end
					and to_big(card.ability.extra.cur_btn_uses) < to_big(card.ability.extra.max_btn_uses)
				then
					card.ability.extra.cur_btn_uses = to_big(card.ability.extra.max_btn_uses)
					return { message = localize('k_reset'), delay = 1.5 }
				end
			end
		},
		-- Ollie
		{
			key = 'ollie',
			forWhichDeck = 'b_cir_pirate',
			cir_Friend = CirnoMod.miscItems.cirFriends.han,
			cir_btn_clr = CirnoMod.miscItems.colours.cirHan,
			matureRefLevel = 1,
			loc_txt = { name = 'Ollie', text = { {
					'During the shop phase,',
					'select any {C:attention}item for sale',
					'and use the button on this',
					'{C:cirKeepsakeClr}Keepsake{} to {C:attention}mark{} it'
					}, {
					'Use without an item',
					'selected to unmark',
					'what\'s currently marked',
					'{s:0.8,C:inactive}That octopus sure got an',
					'{s:0.8,C:inactive}interesting mouth on him'
				} }
			},
			
			loc_vars = function(self, info_queue, card)
				-- Art credit tooltip
				if CirnoMod.config.artCredits and not card.fake_card then
					info_queue[#info_queue + 1] = { key = "kA_NTF_Rend", set = "Other" }
				end
			end,
			
			config = { extra = { reset_jiggle = false, card_marked = false } },
			pos = { x = 2, y = 1 },
			eternal_compat = false,
			perishable_compat = false,
			
			cir_btn_use = function(self, card)
				local all_shop_items = SMODS.merge_lists{ G.shop_jokers.cards, G.shop_booster.cards, G.shop_vouchers.cards }
				local all_highlighted = SMODS.merge_lists{ G.shop_jokers.highlighted, G.shop_booster.highlighted, G.shop_vouchers.highlighted }
				local juice_list = { card }
				local unmarked = {}
				
				for _, obj in ipairs(all_shop_items) do
					if obj.ability.cir_markedShopCard then
						obj.ability.cir_markedShopCard = nil
						unmarked[#unmarked + 1] = obj
					end
				end
				
				if #all_highlighted > 0 then
					for _, obj in ipairs(all_highlighted) do
						if not obj.ability.cir_markedShopCard then
							obj:add_sticker('cir_markedShopCard', true)
							attention_text{
								text = 'Marked!',
								backdrop_colour = CirnoMod.miscItems.colours.cirHan,
								scale = 1.3,
								hold = 1.4,
								align = 'cm',
								offset = {x = 0, y = 0},
								major = obj,
								silent = true
							}
							
							juice_list[#juice_list + 1] = obj
							
							G.E_MANAGER:add_event(Event({
								trigger = 'after',
								delay = 0.06*G.SETTINGS.GAMESPEED,
								blockable = false,
								blocking = false,
								func = function()
									play_sound('generic1');return true
								end}))
						end
					end
					
					card.ability.extra.card_marked = true
					CirnoMod.miscItems.unhighlightAllJokerAreas({ G.shop_jokers, G.shop_booster, G.shop_vouchers }, { G.keepsake_area })
				else
					for _, crd in ipairs(unmarked) do
						attention_text{
								text = 'Unmarked!',
								backdrop_colour = CirnoMod.miscItems.colours.cirHan,
								scale = 1.3,
								hold = 1.4,
								align = 'cm',
								offset = {x = 0, y = 0},
								major = crd,
								silent = true
							}
						
						juice_list[#juice_list + 1] = crd
						
						G.E_MANAGER:add_event(Event({
							trigger = 'after',
							delay = 0.06*G.SETTINGS.GAMESPEED,
							blockable = false,
							blocking = false,
							func = function()
								play_sound('generic1');return true
							end}))
					end
					
					card.ability.extra.card_marked = false
					self.cir_updateState(card, true)
				end
				
				for _, obj in ipairs(juice_list) do
					obj:juice_up()
				end
				
				G.E_MANAGER:add_event(Event({
					trigger = 'immediate',
					blockable = true,
					func = function()
						save_run()
						return true
						end }))
			end,
			
			cir_btn_can_use = function(self, card)
				if 
					CirnoMod.miscItems.isState(G.STATE, G.STATES.SHOP)
				then
					if
						(#G.shop_jokers.highlighted > 0
						or #G.shop_booster.highlighted > 0
						or #G.shop_vouchers.highlighted > 0)
					then
						local ret = true
						
						for i = 1, #G.shop_jokers.highlighted do							
							if G.shop_jokers.highlighted[i] and G.shop_jokers.highlighted[i].ability.cir_markedShopCard then
								return false
							end
							
							if
								(G.shop_jokers.highlighted[i].ability.set == 'Joker'
								and #G.jokers.cards >= G.jokers.config.card_limit)
								or (G.shop_jokers.highlighted[i].ability.consumeable
								and #G.consumeables.cards >= G.consumeables.config.card_limit)
							then
								ret = G.shop_jokers.highlighted[i].edition and G.shop_jokers.highlighted[i].edition.type == 'negative'
							end
						end
						
						for i = 1, #G.shop_booster.highlighted do
							if G.shop_booster.highlighted[i] and G.shop_booster.highlighted[i].ability.cir_markedShopCard then
								return false
							end
						end
						
						for i = 1, #G.shop_vouchers.highlighted do
							if G.shop_vouchers.highlighted[i] and G.shop_vouchers.highlighted[i].ability.cir_markedShopCard then
								return false
							end
						end
						
						return ret
					else
						local all_shop_items = SMODS.merge_lists{ G.shop_jokers.cards, G.shop_booster.cards, G.shop_vouchers.cards }
						
						for _, obj in ipairs(all_shop_items) do
							if obj.ability.cir_markedShopCard then
								return true
							end
						end
					end
				end
				
				return false
			end,
			
			cir_updateState = function(jkr, force)
				if
					G.GAME
					and (CirnoMod.miscItems.isState(G.STATE, G.STATES.SHOP)
					or force)
					and not jkr.ability.extra.card_marked
				then
					juice_card_until(jkr, function()
						return not (jkr.ability.extra.card_marked or jkr.ability.extra.reset_jiggle or G.RESET_JIGGLES)
					end, true)
				end
			end,
			
			calculate = function(self, card, context)
				if
					context.starting_shop
					or ((context.buying_card
					or context.open_booster)
					and context.card.ability.cir_markedShopCard)
				then
					card.ability.extra.reset_jiggle = false
					G.RESET_JIGGLES = false
					
					if not context.starting_shop then 						
						card.ability.extra.card_marked = false
						G.E_MANAGER:add_event(Event({
							trigger = 'after',
							delay = 0.2,
							blockable = true,
							blocking = false,
							func = function()
								G.RESET_JIGGLES = false
								self.cir_updateState(card, true)
							return true
							end }))
					else
						self.cir_updateState(card, force)
						return { message = localize('k_active_ex'), colour = CirnoMod.miscItems.colours.cirHan }
					end
				end
				
				if context.ending_shop then
					card.ability.extra.reset_jiggle = true
					card.ability.extra.card_marked = false
				end
			end
		},
		-- Candy Cookie Chocolate
		{
			key = 'candyCookieChocolate',
			forWhichFDeck = 'b_cir_zzz',
			cir_Friend = CirnoMod.miscItems.cirFriends.rmi,
			cir_btn_clr = CirnoMod.miscItems.colours.cirRumi,
			matureRefLevel = 1,
			loc_txt = { name = 'Candy Cookie Chocolate', text = { {
					'During the first {C:attention}#1#{C:blue}#2#{}/{C:red}#3#{} of',
					'a round, {C:attention}playing or discarding{} a hand',
					'{C:attention}containing{} your {C:attention}most played hand{} gives',
					'this {C:cirKeepsakeClr}Keepsake {C:blue}+1{} stored {C:blue}hand{},',
					'{C:attention}playing or discarding{} a hand {C:attention}containing',
					'your {C:attention}least played hand{} gives',
					'this {C:cirKeepsakeClr}Keepsake {C:red}+1{} stored {C:red}discard{}',
					'{C:inactive}(Currently {C:blue}+#4# hands{C:inactive}, {C:red}+#5# discards{C:inactive},',
					'{C:inactive}Most: {C:attention}#6#{C:inactive}, Least: {C:attention}#7#{C:inactive})'
					}, {
					'During a blind, use the button on',
					'this {C:cirKeepsakeClr}Keepsake{} to immediately gain',
					'all stored {C:blue}hands{} & {C:red}discards{} for',
					'the {C:attention}remainder of that blind',
					'{s:0.8,C:inactive}Blame Rumi for getting this song',
					'{s:0.8,C:inactive}stuck in my head'
				} }
			},
			
			loc_vars = function(self, info_queue, card)
				local ret = { vars = { '', 'hand', 'discard',
					to_big(card.ability.extra.hands),
					to_big(card.ability.extra.discards),
					card.ability.extra.most_played,
					card.ability.extra.least_played
				} }
				
				if card.ability.extra.upToHandsDiscards > 1 then
					ret.vars[1] = card.ability.extra.upToHandsDiscards
					ret.vars[2] = ' hands'
					ret.vars[3] = 'discards'
				end
				
				-- Art credit tooltip
				if CirnoMod.config.artCredits and not card.fake_card then
					info_queue[#info_queue + 1] = { key = "kA_NTF_Rend", set = "Other" }
				end
				
				if card.ability.extra.upgraded then
					ret.key = 'j_cir_candyCookieChocolate_upg'
					
					ret.vars[8] = 1
					
					if to_big(card.ability.extra.hands) > to_big(0) or to_big(card.ability.extra.discards) > to_big(0) then
						ret.vars[8] = math.max((to_big(card.ability.extra.hands) + to_big(card.ability.extra.discards)) / to_big(2), to_big(1))
					end
				end
				
				return ret
			end,
			
			config = { extra = {
				upToHandsDiscards = 1,
				hands = 0,
				discards = 0,
				upgraded = false,
				most_played = 'High Card',
				least_played = 'Full House'
			} },
			
			pos = { x = 5, y = 1 },
			eternal_compat = false,
			perishable_compat = false,
			
			cir_btn_use = function(self, card)
				if to_big(card.ability.extra.hands) > 0 then
					ease_hands_played(to_big(card.ability.extra.hands))
					card.ability.extra.hands = 0
				end
				
				if to_big(card.ability.extra.discards) > 0 then
					ease_discard(to_big(card.ability.extra.discards))
					card.ability.extra.discards = 0
				end
				
				card:juice_up()
			end,
			
			cir_btn_can_use = function(self, card)
				return G.STATE ~= G.STATES.HAND_PLAYED and G.GAME.blind.in_blind and (to_big(card.ability.extra.hands) > to_big(0) or to_big(card.ability.extra.discards) > to_big(0))
			end,
			
			cir_upgradeInfo = function(self, card)
				if not card.ability.extra.upgraded then
					return {
						'During the first {C:attention}'..to_big(card.ability.extra.upToHandsDiscards)..' {C:blue}hand{}/{C:red}discard',
						'->',
						'During the first {C:attention}'..to_big(card.ability.extra.upToHandsDiscards) + to_big(1)..' {C:blue}hands{}/{C:red}discards',
						'Stored {C:red}hands{} & {C:blue}discards{} give {C:attention}half',
						'their stored value as {X:purple,C:white}XScore'
					}
				end
				
				return {
					'During the first {C:attention}'..to_big(card.ability.extra.upToHandsDiscards)..' {C:blue}hands{}/{C:red}discards{}',
					'->',
					'During the first {C:attention}'..to_big(card.ability.extra.upToHandsDiscards) + to_big(1)..' {C:blue}hands{}/{C:red}discards'
				}
			end,
			
			cir_upgrade = function(self, card)
				if not card.ability.extra.upgraded then
					card.ability.extra.upgraded = true
				end
				
				card.ability.extra.upToHandsDiscards = to_big(card.ability.extra.upToHandsDiscards) + to_big(1)
				
				return { localize('k_upgrade_ex') }
			end,
			
			updateMostLeastPlayedHand = function(self, card)
				local mHand_name, lHand_name, mPlay_count, lPlay_count = 'High Card', 'High Card', 0, math.huge
				for hand_key, hand in pairs(G.GAME.hands) do
					if SMODS.is_poker_hand_visible(hand_key) then
						if hand.played > mPlay_count then
							mPlay_count = hand.played
							mHand_name = hand_key
						end
						
						if hand.played < lPlay_count then
							lPlay_count = hand.played
							lHand_name = hand_key
						end
					end
				end
				
				card.ability.extra.most_played = mHand_name
				card.ability.extra.least_played = lHand_name
			end,
			
			calculate = function(self, card, context)
				if
					context.setting_blind
					or context.after
				then
					self:updateMostLeastPlayedHand(card)
				end
				
				if context.first_hand_drawn then
					juice_card_until(card, function()
						return (to_big(G.GAME.current_round.hands_played) < to_big(card.ability.extra.upToHandsDiscards)
							or to_big(G.GAME.current_round.discards_used) < to_big(card.ability.extra.upToHandsDiscards))
							and not G.RESET_JIGGLES
					end, true)
					
					return { message = localize('k_active_ex') }
				end
				
				if
					(context.before
					and to_big(G.GAME.current_round.hands_played) < to_big(card.ability.extra.upToHandsDiscards))
					or ((context.pre_discard
					and not context.hook)
					and to_big(G.GAME.current_round.discards_used) < to_big(card.ability.extra.upToHandsDiscards))
				then
					-- Played/Discarded hand contains most played hand
					if next(select(3, G.FUNCS.get_poker_hand_info(context.full_hand))[card.ability.extra.most_played]) then
						card.ability.extra.hands = to_big(card.ability.extra.hands) + to_big(1)
						SMODS.calculate_effect({
								message = localize{ type = 'variable', key = 'a_hands', vars = { 1 } },
								colour = G.C.BLUE
							}, card)
					end
					
					-- Played/Discarded hand contains least played hand
					if next(select(3, G.FUNCS.get_poker_hand_info(context.full_hand))[card.ability.extra.least_played]) then
						card.ability.extra.discards = to_big(card.ability.extra.discards) + to_big(1)
						SMODS.calculate_effect({
								message = '+1 Discards',
								colour = G.C.RED
							}, card)
					end
				end
				
				if
					context.joker_main
					and card.ability.extra.upgraded
					and G.GAME.chips
					and G.GAME.chips > 0 
					and (to_big(card.ability.extra.hands) > to_big(0)
					or to_big(card.ability.extra.discards) > to_big(0))
				then
					return { xscore = math.max((to_big(card.ability.extra.hands) + to_big(card.ability.extra.discards)) / to_big(2), to_big(1)) }
				end
			end
		},
		-- True Dragon's Katana
		{
			key = 'tdkatana',
			forWhichFDeck = 'b_cir_sycophant',
			cir_Friend = { CirnoMod.miscItems.cirFriends.ntf, CirnoMod.miscItems.cirFriends.dm },
			cir_btn_clr = CirnoMod.miscItems.colours.cirNope,
			matureRefLevel = 1,
			loc_txt = { name = 'True Dragon\'s Katana', text = { {
					'{C:attention}#1#{} per {C:attention}Blind{} and {C:attention}Shop{},',
					'select a {C:attention}Joker{} and/or',
					'{C:attention}Consumable{}, then use the',
					'button on this {C:cirKeepsakeClr}Keepsake',
					'to {C:red}destroy{} it/them',
					'{C:inactive}(Currently {C:cirNope}#2#{C:inactive}/{C:cirNope}#3#{C:inactive})'
					}, {
					'This {C:cirKeepsakeClr}Keepsake{} gains',
					'{C:mult}+#5#{} Mult when it',
					'is used to {C:red}destroy',
					'something',
					'{C:inactive}(Currently {C:mult}+#6#{C:inactive} Mult)',
					'{s:0.8,C:inactive}"He is not the Dragon. I am."'
				} }
			},
			
			loc_vars = function(self, info_queue, card)
				-- Art credit tooltip
				if CirnoMod.config.artCredits and not card.fake_card then
					info_queue[#info_queue + 1] = { key = "kA_NTF_Rend", set = "Other" }
				end
				
				return { key = ((card.ability.extra.upgraded or card.ability.extra.do_eternals) and
					('j_cir_tdkatana'..(card.ability.extra.do_eternals and '_et' or '')..(card.ability.extra.upgraded and '_upg' or ''))) or nil,
					vars = {
						to_big(card.ability.extra.max_btn_uses) > 1 and to_big(card.ability.extra.max_btn_uses)..' times' or 'Once',
						to_big(card.ability.extra.cur_btn_uses),
						to_big(card.ability.extra.max_btn_uses),
						card.ability.extra.charges,
						to_big(card.ability.extra.growth),
						to_big(card.ability.extra.mult)
				} }
			end,
			
			config = { extra = {
				max_btn_uses = 1,
				cur_btn_uses = 1,
				charges = 0,
				mult = 0,
				growth = 2,
				upgraded = false
			} },
			
			pos = { x = 1, y = 3 },
			eternal_compat = false,
			perishable_compat = false,
			
			add_to_deck = function(self, card, from_debuff)
				card.ability.extra.do_eternals = G.GAME.modifiers.enable_eternals_in_shop
			end,
			
			cir_btn_use = function(self, card)
				local to_destroy = {}
				
				for _, d_card in ipairs(SMODS.merge_lists{
					G.jokers.highlighted or {},
					G.consumeables.highlighted or {}
				}) do
					local eternalCheck = SMODS.is_eternal(d_card, card)
					local should_destroy = (not eternalCheck) or card.ability.extra.charges > 0
					
					if eternalCheck and card.ability.extra.charges > 0 then
						card.ability.extra.charges = to_big(card.ability.extra.charges) - to_big(1)
					end
					
					if should_destroy then
						table.insert(to_destroy, d_card)
					end
				end
				
				if #to_destroy > 0 then
					local mult_increase_times = #to_destroy
					
					for i, dCard in ipairs(to_destroy) do
						dCard.setting_sliced = true
                        card:juice_up(0.8, 0.8)
                        dCard:start_dissolve({ HEX("57ecab") }, nil, 1.6)
						if i == 1 then
							play_sound('slice1', 0.96 + math.random() * 0.08)
						end
					end
					
					SMODS.scale_card(card, {
							ref_table = card.ability.extra,
							ref_value = 'mult',
							scalar_value = 'growth',
							operation = function(ref_table, ref_value, initial, change)
								ref_table[ref_value] = to_big(initial) + to_big(change) * to_big(mult_increase_times)
							end,
							scaling_message = {
								message = localize{ type = 'variable', key = card.ability.extra.upgraded and 'a_xmult' or 'a_mult', vars = { to_big(card.ability.extra.mult) + to_big(card.ability.extra.growth) * to_big(mult_increase_times) } },
								colour = G.C.MULT
							}
						})
					
					card.ability.extra.cur_btn_uses = to_big(card.ability.extra.cur_btn_uses) - to_big(1)
				end
			end,
			
			cir_btn_can_use = function(self, card)
				if to_big(card.ability.extra.cur_btn_uses) > to_big(0) then
					if #G.jokers.highlighted > 0 then
						for _, jkr in ipairs(G.jokers.highlighted) do
							if not SMODS.is_eternal(jkr, card) then
								return true
							end
						end
					end
					
					if #G.consumeables.highlighted > 0 then
						for _, jkr in ipairs(G.consumeables.highlighted) do
							if not SMODS.is_eternal(jkr, card) then
								return true
							end
						end
					end
				end
			end,
			
			cir_upgradeInfo = function(self, card)
				if not card.ability.extra.upgraded then
					return {
						'{C:red}+'..to_big(card.ability.extra.mult)..'{} Mult',
						'->',
						'{X:red,C:white} X'..math.max((to_big(card.ability.extra.mult) / to_big(20)) + to_big(1), to_big(1.1))..' {} Mult',
						' ',
						'{C:red}+'..to_big(card.ability.extra.growth)..'{} Mult growth',
						'->',
						'{X:red,C:white} X'..(to_big(card.ability.extra.growth) / to_big(20))..' {} Mult growth'
					}
				end
				
				return { '{C:cirNope}+1 Button Uses' }
			end,
			
			cir_upgrade = function(self, card)
				if not card.ability.extra.upgraded then
					card.ability.extra.mult = math.max((to_big(card.ability.extra.mult) / to_big(20)) + to_big(1), to_big(1.1))
					
					card.ability.extra.growth = to_big(card.ability.extra.growth) / to_big(20)
					
					card.ability.extra.upgraded = true
					return { localize('k_upgrade_ex') }
				end
				
				card.ability.extra.max_btn_uses = to_big(card.ability.extra.max_btn_uses) + to_big(1)
				return { message = '+1 Button Use' }
			end,
			
			calculate = function(self, card, context)
				if
					(context.setting_blind
					or context.starting_shop)
					and to_big(card.ability.extra.cur_btn_uses) < to_big(card.ability.extra.max_btn_uses)
				then
					card.ability.extra.cur_btn_uses = to_big(card.ability.extra.max_btn_uses)
					return {
						message = { 'Refreshed!' },
						colour = CirnoMod.miscItems.colours.cirNope
					}
				end
				
				if
					context.end_of_round
					and context.main_eval
					and context.beat_boss
					and not context.game_over
					and card.ability.extra.do_eternals
				then
					card.ability.extra.charges = to_big(card.ability.extra.charges) + to_big(1)
					return { message = '+1 Charge' }
				end
				
				if
					((not card.ability.extra.upgraded) and context.initial_scoring_step)
					or (card.ability.extra.upgraded and context.joker_main)
				then
					if card.ability.extra.upgraded then
						return { x_mult = card.ability.extra.mult }
					else
						return { mult = card.ability.extra.mult }
					end
				end
			end
		}
	}
}

for i, kps in ipairs(keepsakeInfo.keepsakeConfigs) do
	kps.object_type = 'Joker'
	kps.atlas = kps.atlas or 'cir_decksAndKeepsakes'
	kps.rarity = 'cir_keepsake_r'
	kps.loadOrder = 'kpsk'
	kps.pools = {}
	
	kps.can_sell = function(self, card, context)
		return false
	end
	
	kps.unlocked = false
	kps.loc_txt.unlock = { 'Unlock', '{E:1,C:attention}#1#' }
	
	kps.locked_loc_vars = function(self, info_queue, card)
		local orgDeckName = localize{ type = "name_text", set = "Back", key = self.forWhichFDeck }
		
		return { vars = {
			CirnoMod.miscItems.obscureStringIfJokerKeyLockedOrUndisc(string.sub(orgDeckName, 1, #orgDeckName - 5), self.forWhichFDeck, 'a certain Friend')..' Deck'
		} }
	end
	
	kps.check_for_unlock = function(self, args)
		if self.forWhichFDeck and G.P_CENTERS[self.forWhichFDeck] then
			return G.P_CENTERS[self.forWhichFDeck].unlocked
		end
	end
end

return keepsakeInfo