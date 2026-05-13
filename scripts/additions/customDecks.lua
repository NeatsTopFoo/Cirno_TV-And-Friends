local keepsakeInfo = assert(SMODS.load_file('scripts/additions/jokers/cirKeepsakes.lua'))()
local keepsakeKeys = {}

SMODS.Atlas{
		key = 'cir_decksAndKeepsakes',
		path = "Additional/cir_custDecks.png",
		px = 71,
		py = 95
	}

CirnoMod.jkrLoadTable.kpsk = {}

CirnoMod.miscItems.markedShopCard = SMODS.Sticker{
	key = 'markedShopCard',
	loc_txt = { name = 'Marked', label = 'Marked', text = {
		'Item is marked',
		'for theft'
	} },
	pos = { x = 4, y = 3 },
	badge_colour = HEX('6a3847'),
	sets = {},
	no_collection = true
}

for i, kps in ipairs (keepsakeInfo.keepsakeConfigs) do
	if
		kps.matureRefLevel <= CirnoMod.config.matureReferences_cyc
	then
		table.insert(CirnoMod.jkrLoadTable.kpsk, kps)
		table.insert(CirnoMod.miscItems.keysOfAllCirnoModItems, 'j_cir_'..kps.key)
		keepsakeKeys['j_cir_'..kps.key] = true
	end
end

--[[
	Todo:
	 - Pirate Deck: During a shop, use Ollie to mark a card, pack, or voucher. On shop end, 1 in 4 chance to steal it for free
	 - Narp Deck: 
	 - Fate Deck: 
	 - Bigg Deck: 
	 - Cryptic Deck: 
	 - The Guy Deck: 
	 - Snek Deck: 
	 - Hack Deck: 
	 - (Reimmomo, unnamed)
	 - (Vileelf, unnamed) 
	 - (Kaizur, unnamed) 
	 - (Octopimp, unnamed) 
	 === FRIEND DECKS END ===
	 - Purple Deck: Unlocked by beating a run with all purple-associated Friend Decks (myself, Rumi, Hannah, Momo) Start with 26 Hearts & 26 Clubs
	 - Chimata (Tenkyuu) Deck: Vouchers cost $3*Ante#, Shop has 3 booster packs instead of 2
	 - Royal Deck: Unlocked by converting a 2 to a Queen in a siungle blind, 12K 12Q 12J 16 eternal 2s +2 dollars per round inc. skips, random suit's KQJ debuffed a turn, respects boss debuffs, rarities inverted
	 - AFK Deck: Once a blind, be inactive for 60 seconds for a random positive effect
	 - (Unknown): Highest and lowest level hand swap levels every Ante
]]

local deckInfo = {
	deckConfigs = {
		-- Flesh Deck
		{
			key = 'flesh',
			cir_Friend = CirnoMod.miscItems.cirFriends.dm,
			friendCard = 'Q_D',
			keepsake_key = 'j_cir_zayne',
			loc_txt = { name = 'Flesh Deck',
				text = {
					'{s:0.85}Start a run with a full deck',
					'{s:0.85}of {s:0.8,C:attention}Face Cards',
					'{s:0.85}Addresses several of',
					'{s:0.85,E:1,C:cirDM}Girl_DM_\'s{s:0.85,C:attention,T:eDT_cir_fleshDeck_ext} gripes{s:0.85} stated',
					'{s:0.85}during her past Balatro streams',
					'{s:0.85,C:red}X#1#{s:0.85} base Blind size',
					'{s:0.85}Keepsake: {s:0.85,E:1,C:cirKeepsakeClr,T:j_cir_zayne}Zayne',
					'{s:0.65,C:inactive}flesh'
				}
			},
			config = { tagOdds = 4, ante_scaling = 4, overkillDol = 0 }, -- no_extra_hand_money = true, no_interest = true },
			pos = { x = 0, y = 0 },
			
			loc_vars = function(self, info_queue, back)
				return { vars = { self.config.ante_scaling } }
			end,
			
			locked_loc_vars = function(self, info_queue, back)
				return { vars = {
					colours = { CirnoMod.miscItems.colours.diamonds_hc }, 'Queens', 'Diamonds' }
				}
			end,
			
			cir_onStartLoad = function()
				SMODS.process_loc_text(G.localization.misc.poker_hands, "Straight", "Consecutive")
				SMODS.process_loc_text(G.localization.misc.poker_hands, "Straight Flush", "Consecutive Flush")
				
				table.insert(CirnoMod.funcQueue_mainMenu, function()
						SMODS.process_loc_text(G.localization.misc.poker_hands, "Straight", "Straight")
						SMODS.process_loc_text(G.localization.misc.poker_hands, "Straight Flush", "Straight Flush")
					end)
			end,
			
			initial_deck = { Ranks = {'King', 'Queen', 'Jack'} },
			
			apply = function(self, back)
				G.E_MANAGER:add_event(Event({
					trigger = 'immediate',
					blocking = false,
					blockable = false,
					func = function()
						if G.deck then
							local KQJ = { 'K', 'Q', 'J' }
							
							for _s, cSuit in ipairs(CirnoMod.miscItems.cardSuits) do
								for _r, cRank in ipairs(KQJ) do
									for am = 1, 3 do
										SMODS.add_card{
											set = 'Base',
											area = G.deck,
											rank = cRank,
											suit = cSuit,
											no_edition = true,
											skip_materialize = true
										}
									end
									
									if cRank == 'Q' then
										SMODS.add_card{
											set = 'Base',
											area = G.deck,
											rank = cRank,
											suit = cSuit,
											no_edition = true,
											skip_materialize = true
										}
									end
								end
							end
							
							-- G.GAME.modifiers.no_extra_hand_money = true
							CirnoMod.ban_obj('j_bloodstone')
							CirnoMod.ban_obj('bl_needle')
							
							return true
						end
						
						return false
					end
				}))
			end,
			
			add_to_infoQueue = function(card, back, info_queue, specific_vars)
				if card.key and card.key == 'tag_coupon' then
					local numerator, denominator = SMODS.get_probability_vars(card or self, 1, back.effect.config.tagOdds )
					
					info_queue[#info_queue + 1] = {
						key = 'flesh_coupon_odds',
						set = 'Other',
						config = { fake_card = true },
						vars = { numerator, denominator,
						localize{ type = 'name_text', key = 'tag_coupon', set = 'Tag' } }
					}
				end
			end,
			
			no_back_to_back = function(context)
				return context.reroll_shop
					or context.startiing_shop
					or context.ending_shop
					or (context.open_booster
					and context.booster.kind == 'Buffoon')
			end,
			
			calc_dollar_bonus = function(self, back)
				if back.effect.config.overkillDol > to_big(0) then
					return back.effect.config.overkillDol, { no_eval_row = true }
				end
			end,
			
			calculate = function(self, back, context)
				if
					context.ending_shop
					or context.setting_blind
				then
					G.GAME.cir_storeBlindReq = 0
					back.effect.config.ONLY_ONE_FFS = false
					back.effect.config.overkillDol = 0
				end
				
				if context.end_of_round and context.main_eval then
					G.GAME.cir_storeBlindReq = to_big(G.GAME.blind.chips)
					
					if back.effect.config.preventPareidolia and math.random(5) == 1 then
						back.effect.config.preventPareidolia = false
					end
				end
				
				if
					context.round_eval
					and G.GAME.cir_storeBlindReq
					and to_big(G.GAME.chips) > to_big(G.GAME.cir_storeBlindReq)
				then
					local overkillAm = to_big(G.GAME.chips) - to_big(G.GAME.cir_storeBlindReq)
					back.effect.config.overkillDol = math.floor(overkillAm / (to_big(G.GAME.cir_storeBlindReq) * 0.25))
					
					if back.effect.config.overkillDol > to_big(0) then
						local dckRef = (G.deck.cards[1] or G.deck)
						
						G.E_MANAGER:add_event(Event({
							trigger = 'after',
							blockable = true,
							delay = 0.5,
							func = (function()
								dckRef:juice_up()
								return true
							end)}))
						
						add_round_eval_row{
							dollars = back.effect.config.overkillDol,
							bonus = true,
							text = 'Overkill (' .. string.format("%.0f", (to_big(overkillAm) / to_big(G.GAME.cir_storeBlindReq)) * to_big(100)) .. '%)',
							text_colour = CirnoMod.miscItems.colours.cirDM,
							text_scale = 0.6,
							name = 'custom',
							pitch = 1
						}
					end
				end
				
				if
					context.create_shop_card
					and not back.effect.config.preventPareidolia
					and next(SMODS.find_card('j_vampire'))
					and next(SMODS.find_card('j_midas_mask'))
					and not next(SMODS.find_card('j_pareidolia'))
					and math.random(3) == 1
				then
					local makePare = true
					
					if G.shop_jokers then
						for _, jkr in ipairs(G.shop_jokers.cards) do
							if jkr.config.center.key == 'j_pareidolia' then
								makePare = false
								break
							end
						end
					end
					
					if makePare and CirnoMod.addItemToGuaranteeQueue('j_pareidolia', 'Joker') then
						back.effect.config.preventPareidolia = true
					end
				end
				
				if context.modify_shop_card then
					return { func = function()
						CirnoMod.ban_obj(context.card.config.center.key, {
								obj_key = 'back',
								func_name = 'no_back_to_back'
							})
					end }
				end
				
				if context.reroll_shop then
					return { func = function()
						G.E_MANAGER:add_event(Event({
							trigger = 'after',
							blockable = true,
							delay = 0.0,
							func = (function()
								if not CirnoMod.miscItems.isState(G.STATE, G.STATES.SHOP) then return true end
								local ret = true
								
								for _, sCard in ipairs(G.shop_jokers.cards) do
									if not CirnoMod.ban_obj(sCard.config.center.key, {
										obj_key = 'back',
										func_name = 'no_back_to_back'
									}) then
										ret = false
									end
								end
								
								return ret
							end)}))
					end }
				end
				
				if
					context.open_booster
					and context.booster.kind == 'Buffoon'
				then
					return { func = function()
						G.E_MANAGER:add_event(Event({
							trigger = 'immediate',
							blockable = true,
							delay = 0.0,
							func = (function()
								if G.pack_cards then
									for _, bCard in ipairs(G.pack_cards.cards) do
										CirnoMod.ban_obj(bCard.config.center.key, {
											obj_key = 'back',
											func_name = 'no_back_to_back'
										})
									end
									return true
								end
								return false
							end)}))
					end }
				end
				
				if
					context.tag_triggered
					and not context.tag_added
					and context.tag_triggered.key == 'tag_coupon'
					and not back.effect.config.ONLY_ONE_FFS
				then
					if SMODS.pseudorandom_probability(back, 'flesh_coupon', 1, back.effect.config.tagOdds) then
						local dckRef = (G.deck.cards[1] or G.deck)
						
						add_tag(Tag('tag_coupon'))
						
						G.E_MANAGER:add_event(Event({
							trigger = 'immediate',
							blockable = true,
							delay = 0.0,
							func = (function()
								dckRef:juice_up()
								return true
							end)}))
					end
					
					back.effect.config.ONLY_ONE_FFS = true
				end
			end
		},
		-- Frozen Deck
		{
			key = 'frozen',
			cir_Friend = CirnoMod.miscItems.cirFriends.cir,
			friendCard = 'Q_C',
			keepsake_key = 'j_cir_cola',
			loc_txt = { name = 'Frozen Deck',
				text = {
					'Start a run with {C:attention}#1# 9s',
					'{C:attention,T:m_glass}#1#s{} instead have a',
					'{C:green}#2# in #3#{} chance of breaking',
					'Keepsake: {E:1,C:cirKeepsakeClr,T:j_cir_cola}Chocola Figure',
					'{s:0.8,C:inactive}Was originally going',
					'{s:0.8,C:inactive}to be called "Fairy Deck,"',
					'{s:0.8,C:inactive}but I let that go'
				}
			},
			config = { break_odds = 9 },
			pos = { x = 1, y = 0 },
			
			loc_vars = function(self, info_queue, back)
				local numerator, denominator = SMODS.get_probability_vars(card or self, 1, self.config.break_odds)
				
				return { vars = {
					localize{ type = 'name_text', key = 'm_glass', set = 'Enhanced' },
					numerator,
					denominator
				} }
			end,
			
			locked_loc_vars = function(self, info_queue, back)
				return { vars = {
					colours = { CirnoMod.miscItems.colours.clubs_hc }, 'Queens', 'Clubs' }
				}
			end,
			
			apply = function(self, back)
				G.E_MANAGER:add_event(Event({
					trigger = 'immediate',
					blocking = false,
					blockable = false,
					func = function()
						if G.deck then
							for _, pCard in ipairs(G.deck.cards) do
								if pCard:get_id() == 9 then
									pCard:set_ability('m_glass', nil, true)
								end
							end
							
							return true
						end
						
						return false
					end
				}))
			end,
			
			calculate = function(self, back, context)
				if
					not context.blueprint
					and not context.retrigger_joker
					and not context.retrigger_joker_check
					and context.fix_probability
					and context.identifier == 'glass'
				then
					return { denominator = back.effect.config.break_odds }
				end
			end
		},
		-- Pirate Deck
		{
			key = 'pirate',
			cir_Friend = CirnoMod.miscItems.cirFriends.han,
			friendCard = 'K_H',
			keepsake_key = 'j_cir_ollie',
			loc_txt = { name = 'Pirate Deck',
				text = {
					'At the end of the shop',
					'phase, {C:green}#1# in #2#{} chance of',
					'stealing the {C:attention}marked item',
					'{C:attention,T:m_gold}#3#s{} gain an extra {C:money}#4#',
					'Keepsake: {E:1,C:cirKeepsakeClr,T:j_cir_ollie}Ollie',
					'{s:0.8,C:inactive}A for music, never',
					'{s:0.8,C:inactive}legally download'
				}
			},
			config = { stealOdds = 2, extra_dol = 1 },
			pos = { x = 2, y = 0 },
			
			loc_vars = function(self, info_queue, back)
				local numerator, denumerator = SMODS.get_probability_vars(card or self, 1, self.config.stealOdds)
				
				return { vars = { numerator, denumerator,
						localize{ type = 'name_text', key = 'm_gold', set = 'Enhanced' },
						SMODS.signed_dollars(self.config.extra_dol)
					} }
			end,
			
			locked_loc_vars = function(self, info_queue, back)
				return { vars = {
					colours = { CirnoMod.miscItems.colours.hearts_hc }, 'Kings', 'Hearts' }
				}
			end,
			
			add_to_infoQueue = function(card, back, info_queue, specific_vars)
				if card.key and card.key == 'm_gold' then
					info_queue[#info_queue + 1] = { key = "cir_pirate_gold", set = "Other" }
				end
			end,
			
			calculate = function(self, back, context)
				if
					(context.buying_card
					or context.open_booster)
					and context.card.ability.cir_markedShopCard
				then
					if context.open_booster then
						G.E_MANAGER:add_event(Event({ func = function()
							for _, card in ipairs(G.pack_cards.cards) do
								if SMODS.has_enhancement(card, 'm_gold') then
									SMODS.scale_card(card, {
										ref_table = card.ability,
										ref_value = 'h_dollars',
										scalar_table = back.effect.config,
										scalar_value = 'extra_dol',
										no_message = true
									})
								end
							end return true end }))
					end
					
					context.card.ability.cir_markedShopCard = nil
				end
				
				if context.ending_shop then
					local all_shop_items = SMODS.merge_lists{ G.shop_jokers.cards, G.shop_booster.cards, G.shop_vouchers.cards }
					local deckRef = (G.deck.cards[1] or G.deck)
					
					for _, obj in ipairs(all_shop_items) do
						if obj.ability.cir_markedShopCard then
							if SMODS.pseudorandom_probability(back, 'pirate_steal', 1, back.effect.config.stealOdds) then
								obj.cost = 0
								
								if obj.ability.set == 'Voucher' then
									obj:redeem(obj)
								elseif obj.ability.set == 'Booster' then
									back.effect.config.open_booster = obj.config.center.key
									G.CONTROLLER.locks.cir_pirate = true
								else
									G.FUNCS.buy_from_shop({ config = { ref_table = obj } })
								end
								
								if obj.ability.set ~= 'Booster' then
									G.E_MANAGER:add_event(Event({
										func = function() save_run() return true end }))
									deckRef:juice_up()
								end
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
											major = deckRef,
											backdrop_colour = CirnoMod.miscItems.colours.cirHan,
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
										deckRef:juice_up()
									return true 
									end }))
							end
						end
					end
				end
				
				if
					context.cir_blind_select
					and back.effect.config.open_booster
				then
					local deckRef = (G.deck.cards[1] or G.deck)
					
					G.E_MANAGER:add_event(Event({
						trigger = 'after',
						delay = 0.5,
						blockable = true,
						blocking = false,
						func = function()
							CirnoMod.miscItems.create_open_booster(back.effect.config.open_booster, { save_action = {
									type = 'cir_booster',
									b_key = back.effect.config.open_booster
								}, clear_stored_back_key = true, use_card_nosave = true })
							deckRef:juice_up()
							back.effect.config.open_booster = nil
							G.CONTROLLER.locks.cir_pirate = false
						return true end }))
				end
				
				if
					context.setting_ability
					and context.new == 'm_gold'
				then
					if not context.unchanged then
						SMODS.scale_card(context.other_card, {
							ref_table = context.other_card.ability,
							ref_value = 'h_dollars',
							scalar_table = back.effect.config,
							scalar_value = 'extra_dol',
							no_message = true
						})
					elseif context.other_card.ability.h_dollars < context.old_ability.h_dollars then
						context.other_card.ability.h_dollars = context.old_ability.h_dollars
					end
				end
			end
		},
		-- ZZZ Deck
		{
			key = 'zzz',
			cir_Friend = CirnoMod.miscItems.cirFriends.rmi,
			friendCard = 'J_H',
			keepsake_key = 'j_cir_candyCookieChocolate',
			loc_txt = { name = 'ZZZ Deck',
				text = {
					'{s:0.85}Start a run with a full deck',
					'{s:0.85}of {s:0.85,C:attention}2s{s:0.85} and {s:0.85,C:money}$2{s:0.85} less',
					'{s:0.85,C:attention}#1#s{s:0.85} instead give {s:0.85,X:mult,C:white} X2 ',
					'{s:0.85}Mult when held in hand',
					'{s:0.85,C:red}X#2#{s:0.85} base blind size',
					'{s:0.85}Keepsake: {s:0.85,E:1,C:cirKeepsakeClr,T:j_cir_candyCookieChocolate}Candy Cookie Chocolate',
					'{s:0.7,C:inactive}...No, different ZZZ. As in sleeping'
				}
			},
			config = { ante_scaling = 2, dollars = -2 },
			pos = { x = 5, y = 0 },
			
			loc_vars = function(self, info_queue, back)
				return { vars = {
					localize{ type = 'name_text', key = 'm_steel', set = 'Enhanced' },
					self.config.ante_scaling
				} }
			end,
			
			locked_loc_vars = function(self, info_queue, back)
				return { vars = {
					colours = { CirnoMod.miscItems.colours.hearts_hc }, 'Jacks', 'Hearts' }
				}
			end,
			
			initial_deck = { Ranks = { '2' } },
			
			apply = function(self, back)
				G.E_MANAGER:add_event(Event({
					trigger = 'immediate',
					blocking = false,
					blockable = false,
					func = function()
						if G.deck then
							for _, cSuit in ipairs(CirnoMod.miscItems.cardSuits) do
								for am = 1, 12 do
									SMODS.add_card{
											set = 'Base',
											area = G.deck,
											rank = '2',
											suit = cSuit,
											no_edition = true,
											skip_materialize = true
										}
								end
							end
							
							return true
						end
						
						return false
					end
				}))
			end,
			
			calculate = function(self, back, context)
				if
					context.setting_ability
					and context.new == 'm_steel'
				then
					context.other_card.ability.h_x_mult = 2
				end
				
				if context.playing_card_added then
					for _, pCard in ipairs(context.cards) do
						if SMODS.has_enhancement(pCard, 'm_steel') then
							pCard.ability.h_x_mult = 2
						end
					end
				end
			end
		},
		-- Sycophant Deck
		{
			key = 'sycophant',
			cir_Friend = { CirnoMod.miscItems.cirFriends.ntf, CirnoMod.miscItems.cirFriends.dm },
			friendCard = 'Q_H',
			keepsake_key = 'j_cir_tdkatana',
			loc_txt = { name = 'Sycophant Deck',
				text = {
					'{s:0.8,C:attention}Jokers{s:0.8} and {s:0.8,C:attention}Consumables',
					'{s:0.8,C:red}cannot be sold',
					'{s:0.8}If scoring card is not a {s:0.8,C:attention,T:m_lucky}Lucky',
					'{s:0.8,C:dark_edition,T:e_polychrome}Polychrome {s:0.8,C:attention}Queen {s:0.8}of {s:0.8,C:diamonds_hc}Diamonds{s:0.8},',
					'{s:0.8}transform it one step towards one',
					'{s:0.8,C:red}X#1#{s:0.8} base blind size',
					'{s:0.8}Keepsake: {s:0.8,E:1,C:cirKeepsakeClr,T:j_cir_tdkatana}True Dragon\'s Katana',
					'{s:0.65,C:inactive}Hey, check out this cool sword I found'
				}
			},
			config = { ante_scaling = 2 },
			pos = { x = 1, y = 2 },
			
			loc_vars = function(self, info_queue, back)				
				return { vars = { self.config.ante_scaling } }
			end,
			
			locked_loc_vars = function(self, info_queue, back)
				return { vars = {
					colours = { CirnoMod.miscItems.colours.hearts_hc }, 'Queens', 'Hearts' }
				}
			end,
			
			card_needs_processing = function(card)
				ret = {
					isQueen = card:get_id() == 12,
					isDiamonds = card:is_suit('Diamonds'),
					isLucky = SMODS.has_enhancement(card, 'm_lucky'),
					isPoly = card.edition and card.edition.key == 'e_polychrome'
				}
				
				if not (ret.isQueen and ret.isDiamonds and ret.isLucky and ret.isPoly) then
					return ret
				end
			end,
			
			eval_card_step = function(card, CNPtbl)
				local advanceStepTbl = {}
				
				if not CNPtbl.isQueen then
					table.insert(advanceStepTbl, 'rank')
				end
				
				if not CNPtbl.isDiamonds then
					table.insert(advanceStepTbl, 'suit')
				end
				
				if not CNPtbl.isLucky then
					table.insert(advanceStepTbl, 'lucky')
				end
				
				if not CNPtbl.isPoly and SMODS.poll_edition{
					options = { 'e_polychrome' },
					guaranteed = #advanceStepTbl == 0
				} then
					table.insert(advanceStepTbl, 'poly')
				end
				
				if #advanceStepTbl > 0 then
					if #advanceStepTbl == 1 then return advanceStepTbl[1] end
					
					return pseudorandom_element(advanceStepTbl)
				end
			end,
			
			calculate = function(self, back, context)
				if
					context.check_eternal
					and context.trigger
					and context.trigger.from_sell
				then
					return { no_destroy = { override_compat = true } }
				end
				
				if context.before then
					local cardsToChange = {}
					
					for _, pCard in ipairs(context.scoring_hand) do
						if not pCard.debuff then
							local CNP = self.card_needs_processing(pCard)
							
							if CNP then
								table.insert(cardsToChange,
									{ card = pCard, step = self.eval_card_step(pCard, CNP) })
							end
						end
					end
					
					if #cardsToChange > 0 then
						local dckRef = (G.deck.cards[1] or G.deck)
						local percent = 1
						
						for _, cardAndStep in ipairs(cardsToChange) do
							if cardAndStep.step ~= 'poly' then
								CirnoMod.miscItems.flippyFlip.fStart(cardAndStep.card, percent)
							end
						end
						
						return { no_juice = true,
							func = function()
								percent = 1
								
								for _, cardAndStep in ipairs(cardsToChange) do
									G.E_MANAGER:add_event(Event({
										trigger = 'immediate',
										blocking = true,
										blockable = true,
										func = function()
											--[[
											print(string.format('%s of %s: %s',
													cardAndStep.card.base.value,
													cardAndStep.card.base.suit,
													cardAndStep.step
												))
											]]
											
											if cardAndStep.step == 'poly' then
												cardAndStep.card:set_edition('e_polychrome', true)
											elseif cardAndStep.step == 'lucky' then
												cardAndStep.card:set_ability('m_lucky')
											elseif cardAndStep.step == 'rank' then
												SMODS.modify_rank(cardAndStep.card, cardAndStep.card:get_id() == 5 and pseudorandom_element({ -1, 1 }) or (cardAndStep.card:get_id() > 12 or cardAndStep.card:get_id() < 5) and -1 or 1)
											elseif cardAndStep.step == 'suit' then
												if cardAndStep.card.base.suit == 'Hearts' or cardAndStep.card.base.suit == 'Clubs' then
													SMODS.change_base(cardAndStep.card, 'Diamonds')
												elseif cardAndStep.card.base.suit == 'Spades' then
													SMODS.change_base(cardAndStep.card, math.random(2) == 1 and 'Hearts' or 'Clubs')
												else
													SMODS.change_base(cardAndStep.card, 'Spades')
												end
											end
											
											if cardAndStep.step ~= 'poly' then
												cardAndStep.card:juice_up()
											end
											dckRef:juice_up()
											
											return true
										end}))
									
									if cardAndStep.step ~= 'poly' then
										CirnoMod.miscItems.flippyFlip.fEnd(cardAndStep.card, percent)
									end
								end
							end
						}
					end
				end
			end
		}
	}
}

for i, dck in ipairs(deckInfo.deckConfigs) do
	dck.atlas = 'cir_decksAndKeepsakes'
	dck.unlocked = false
	
	if
		dck.friendCard
	then
		if not dck.loc_txt.unlock then
			dck.loc_txt.unlock = {
				'On a {C:attention}non-Friend Deck{},',
				'play a hand with at least',
				'{C:attention}3{} cards, consisting',
				'entirely of {C:attention,E:1}#1#{} of',
				'{V:1,E:1}#2#'
			}
		end
		
		if not dck.check_for_unlock then
			dck.check_for_unlock = function(self, args)
				if
					self.friendCard
					and G.PROFILES[G.SETTINGS.profile].cir_data
					and G.PROFILES[G.SETTINGS.profile].cir_data.store.friendDeckUnlocks[self.friendCard]
					and self.keepsake_key
				then
					G.E_MANAGER:add_event(Event({
						trigger = 'after',
						blockable = true,
						delay = 0.1,
						func = (function()
							unlock_card(G.P_CENTERS[self.keepsake_key])
							discover_card(G.P_CENTERS[self.keepsake_key])
							
							return true
						end)}))
					return true
				end
			end
		end
	end
	
end

return deckInfo