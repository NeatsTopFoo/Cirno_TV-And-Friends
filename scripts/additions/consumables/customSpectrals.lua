local getSealName = function(type)
	if CirnoMod.replaceDef.locChanges.sealLoc[type..'_seal'] then
		return CirnoMod.replaceDef.locChanges.sealLoc[type..'_seal'].name
	end
	
	return G.localization.descriptions.Other[type..'_seal'].name
end

local spectralInfo = {
	isMultipleConsumables = true,
	
	atlasInfo = {
		key = 'cir_cSpectrals',
		path = "Additional/cir_custSpectrals.png",
		px = 71,
		py = 95
	},
	
	cnsmConfigs = {
		-- Revelry
		{
			key = 'sRevelry',
			cost = 4,
			pos = { x = 0, y = 0 },
			config = { extra = 'Red' },
			
			matureRefLevel = 1,
			cir_Friend = CirnoMod.miscItems.cirFriends.cir,
			
			loc_txt = { name = "Revelry", text = {
					'Adds a {C:red}#1#',
					'to {C:attention}1{} random {C:attention}Joker',
					'{s:0.8}(Does not retrigger Joker editions)',
					'{s:0.8,C:inactive}Cirno can stop any time he wants.'
				}
			},
			
			loc_vars = function(self, info_queue, card)
				info_queue[#info_queue + 1] = { key = "jkrRedSeal", set = "Other" }
				
				if CirnoMod.config.artCredits and not card.fake_card then
					info_queue[#info_queue + 1] = { key = "gA_NTF", set = "Other" }
				end
				
				return { vars = { getSealName('red') } }
			end,
			
			can_use = function(self, card)
				local ret = false
				
				if G.jokers then
					if G.jokers.cards then						
						for i, jkr in ipairs (G.jokers.cards) do
							if not jkr.seal then
								ret = true
								break
							end
						end
					end
				end
				
				return ret
			end,
			
			use = function(self, card, area)
				local jkrsToSeal = {}
				local finalSealChoice = nil
				
				for i, jkr in ipairs(G.jokers.cards) do
					if not jkr.seal then
						table.insert(jkrsToSeal, jkr)
					end
				end
				
				if #jkrsToSeal > 1 then
					pseudorandom_element(jkrsToSeal, pseudoseed('randJokerSeal'..G.GAME.round_resets.ante)):set_seal(card.ability.extra, false, true)
				else
					jkrsToSeal[1]:set_seal(card.ability.extra, false, true)
				end
			end
		},
		-- Perfectionism
		{
			key = 'sPerfectionism_l',
			cost = 14,
			pos = { x = 0, y = 1 },
			soul_pos = { x = 0, y = 2 },
			config = { extra = 2 },
			
			matureRefLevel = 1,
			cir_Friend = { CirnoMod.miscItems.cirFriends.cir, CirnoMod.miscItems.cirFriends.han },
			
			loc_txt = { name = "Perfectionism", text = {
					'{E:1,C:cirUpgradedJkrClr}Upgrades{} the currently',
					'selected {C:attention}Joker'
				}
			},
			
			hidden = true,
			soul_set = 'Tarot',
			soul_rate = 0.006,
			soul_juice = true,
			
			dependenciesForAddition = function()
				return CirnoMod.config.addCustomJokers
			end,
			
			loc_vars = function(self, info_queue, card)
				local ret = {}
				
				if G.keepsake_area then
					ret.key = 'c_perf_kpsk'
				end
				
				local compatibility = { mix_colours(G.C.RED, G.C.JOKER_GREY, 0.8), ' No Joker Selected ' }
				local descAppend = {
					'{s:0.8}If no compatible Jokers are',
					'{s:0.8}present, scales a random',
					'{s:0.8}Joker\'s {s:0.8,C:dark_edition}edition{s:0.8} by a scalar of {s:0.8,C:attention}'..card.ability.extra,
					'{s:0.8}({s:0.8,C:dark_edition}Foil{s:0.8}/{s:0.8,C:dark_edition}Holographic{s:0.8}/{s:0.8,C:dark_edition}Polychrome{s:0.8} only)',
					'{s:0.8,C:inactive}The factory must grow',
					'{s:0.8,C:inactive}The factory must grow',
					'{s:0.6,C:inactive}The factory must grow',
					'{s:0.4,C:inactive}The factory must grow'
				}
				
				local upJkrRet = nil
				local finalArea = 'jokers'
				
				--[[ Parse selected Joker to determine
				compatibility and find upgrade info ]]
				local parseJkrAreas = function(jkrAreaTbl)
					for _, areaTbl in ipairs(jkrAreaTbl) do
						if
							G[areaTbl.areaName]
							and G[areaTbl.areaName].highlighted
							and #G[areaTbl.areaName].highlighted > 0
						then
							finalArea = areaTbl.areaName
							
							if #G[areaTbl.areaName].highlighted > 1 then -- Normally impossible, but doesn't hurt to have
								compatibility[2] = 'Select only one '..areaTbl.areaLoc
								return
							end
							
							if
								-- Does the Joker upgrade via internal upgrade functions?
								(G[areaTbl.areaName].highlighted[1].config.center.cir_upgradeInfo
								and type(G[areaTbl.areaName].highlighted[1].config.center.cir_upgradeInfo) == 'function'
								and G[areaTbl.areaName].highlighted[1].config.center:cir_upgradeInfo(G[areaTbl.areaName].highlighted[1])
								and G[areaTbl.areaName].highlighted[1].config.center.cir_upgrade)
							then
								--[[ If so, get that upgrade info
								and put it into the dummy description
								Yes, messy call, I know]]
								CirnoMod.miscItems.descExtensionTooltips.eDT_cir_perfectionismSpecific.myText = G[areaTbl.areaName].highlighted[1].config.center:cir_upgradeInfo(G[areaTbl.areaName].highlighted[1])
								
								-- Add it to info queue as a tooltip
								info_queue[#info_queue + 1] = CirnoMod.miscItems.descExtensionTooltips.eDT_cir_perfectionismSpecific
								
								compatibility[1] = mix_colours(G.C.GREEN, G.C.JOKER_GREY, 0.8)
								compatibility[2] = ' '..localize('k_compatible')..' '
								return
							end
							
							if
								-- Is this Joker in the upgrade table?
								CirnoMod.miscItems.perfectionismUpgradable_Jokers[G[areaTbl.areaName].highlighted[1].config.center_key]
							then
								-- Parse Joker upgrade table entry
								if type(CirnoMod.miscItems.perfectionismUpgradable_Jokers[G[areaTbl.areaName].highlighted[1].config.center_key]) == 'function' then
									upJkrRet = CirnoMod.miscItems.perfectionismUpgradable_Jokers[G[areaTbl.areaName].highlighted[1].config.center_key]()
									
									if upJkrRet.clr then
										compatibility[1] = upJkrRet.clr
									end
									
									compatibility[2] = upJkrRet.msg
								else
									upJkrRet = CirnoMod.miscItems.perfectionismUpgradable_Jokers[G[areaTbl.areaName].highlighted[1].config.center_key]
									compatibility[1] = mix_colours(G.C.GREEN, G.C.JOKER_GREY, 0.8)
									compatibility[2] = ' '..localize('k_compatible')..' '
								end
								return
							else -- Otherwise, incompatible
								compatibility[2] = ' '..localize('k_incompatible')..' '
							end
						end
					end
				end
				
				parseJkrAreas{
					{ areaName = 'keepsake_area', areaLoc = 'Keepsake' },
					{ areaName = 'jokers', areaLoc = 'Joker' }
				}
				
				if upJkrRet and not upJkrRet.frc_incompatible then
					local upgTxtClrs = { G.C.CLEAR, G.C.FILTER }
					
					if CirnoMod.miscItems.getJokerRarityByKey(upJkrRet) == 'cir_UpgradedJkr' then
						upgTxtClrs[1] = CirnoMod.miscItems.colours.cirUpgradedJkrClr_tbl[CirnoMod.miscItems.getJokerRarityByKey(G[finalArea].highlighted[1].config.center_key)] or CirnoMod.miscItems.colours.cirUpgradedJkrClr
						upgTxtClrs[2] = G.C.WHITE
					end
					
					info_queue[#info_queue + 1] = { key = 'perfectionismUpg',
						set = 'Other',
						vars = {
							colours = upgTxtClrs,
							CirnoMod.miscItems.getJokerNameByKey(G[finalArea].highlighted[1].config.center.key),
							CirnoMod.miscItems.obscureJokerNameIfLockedOrUndisc(upJkrRet)
					} }
				end
				
				ret.main_end = {
						{
							n = G.UIT.C,
							config = { align = "bm", minh = 0.4 },
							nodes = { {
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
										config = { ref_table = card, align = "m", colour = compatibility[1], r = 0.05, padding = 0.06 },
										nodes = {
											{ n = G.UIT.T, config = { text = compatibility[2], colour = G.C.UI.TEXT_LIGHT, scale = 0.32 * 0.8 } },
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
							} }
						}
					}
				
				for _, t in ipairs(descAppend) do
					ret.main_end[1].nodes[#ret.main_end[1].nodes + 1] = {
						n = G.UIT.R,
						config = { align = "cm", padding = 0.03 },
						nodes = SMODS.localize_box(loc_parse_string(t), {scale = 1.0})
					}
				end
				
				if
					not card.fake_card
				then
					if
						not card.area
						and card.area.config.type == 'title'
					then
						info_queue[#info_queue + 1] = CirnoMod.miscItems.getEditionScalingInfo({ type = 'example' }, card.ability.extra )
					end
				
					if CirnoMod.config.artCredits then
						info_queue[#info_queue + 1] = { key = "gA_NTF", set = "Other" }
					end
				end
				
				return ret
			end,
			
			can_use = function(self, card)
				for _, jkrArea in ipairs{
					G.keepsake_area or {},
					G.jokers
				} do
					if jkrArea and jkrArea.cards and #jkrArea.cards > 0 then
						if
							jkrArea.highlighted
							and #jkrArea.highlighted == 1
							and (CirnoMod.miscItems.perfectionismUpgradable_Jokers[jkrArea.highlighted[1].config.center_key]
							or (jkrArea.highlighted[1].config.center.cir_upgradeInfo
							and type(jkrArea.highlighted[1].config.center.cir_upgradeInfo) == 'function'
							and jkrArea.highlighted[1].config.center:cir_upgradeInfo(jkrArea.highlighted[1])
							and jkrArea.highlighted[1].config.center.cir_upgrade))
						then
							if
								(jkrArea.highlighted[1].config.center.cir_upgradeInfo
								and jkrArea.highlighted[1].config.center.cir_upgrade)
							then
								return true
							end
							
							if type(CirnoMod.miscItems.perfectionismUpgradable_Jokers[jkrArea.highlighted[1].config.center_key]) == 'function' then
								local upJkrRet = CirnoMod.miscItems.perfectionismUpgradable_Jokers[jkrArea.highlighted[1].config.center_key]()
								
								if not upJkrRet.frc_incompatible then
									return true
								end
							else
								return true
							end
						end
						
						for i, jkr in ipairs (jkrArea.cards) do
							local upgradable = CirnoMod.miscItems.perfectionismUpgradable_Jokers[jkr.config.center_key]
							
							if
								upgradable
								and type(upgradable) == 'function'
							then
								upgradable = not upgradable().frc_incompatible
							end
							
							if
								not upgradable
								and jkr.edition
								and CirnoMod.miscItems.pullEditionModifierValue(jkr.edition) ~= nil
							then
								return true
							end
						end
					end
				end
				
				return false
			end,
			
			use = function(self, card, area)
				for _, jkrArea in ipairs{
					G.keepsake_area or {},
					G.jokers
				} do
					if
						jkrArea
						and jkrArea.highlighted
						and #jkrArea.highlighted == 1
						and (CirnoMod.miscItems.perfectionismUpgradable_Jokers[jkrArea.highlighted[1].config.center_key]
						or (jkrArea.highlighted[1].config.center.cir_upgradeInfo
						and jkrArea.highlighted[1].config.center.cir_upgrade))
					then
						local jkrRef = jkrArea.highlighted[1]
						
						CirnoMod.miscItems.flippyFlip.fStart(jkrRef)
						
						CirnoMod.miscItems.unhighlightAllJokerAreas()
						
						if
							(jkrRef.config.center.cir_upgradeInfo
							and jkrRef.config.center.cir_upgrade)
						then
							G.E_MANAGER:add_event(Event({
								trigger = 'after',
								after = 0.25,
								blocking = true,
								blockable = true,
								func = function()
									local ret = jkrRef.config.center:cir_upgrade(jkrRef)
									
									if ret and type(ret) == 'table' then
										ret.doNotRedSeal = true
										ret.no_retrigger = true
										
										if not ret.delay then
											ret.delay = 1.5
										end
										
										SMODS.calculate_effect(ret, jkrRef)
									end
									
									return true
									end }))
							
							CirnoMod.miscItems.flippyFlip.fEnd(jkrRef, 0.8, 0.45)
							
							return
						end
						
						local targetKey = nil
						local orgExtraTable = nil
						local orgRarity = jkrRef.config.center.rarity
						local orgAbilityTbl = copy_table(jkrRef.ability)
						local upgSound = 'timpani'
						
						if
							type(jkrRef.ability.extra) == 'table'
						then
							orgExtraTable = copy_table(jkrRef.ability.extra)
						elseif
							type(jkrRef.ability.extra) == 'number'
							and jkrRef.ability.extra > 1
						then
							orgExtraTable = jkrRef.ability.extra
						end
						
						if type(CirnoMod.miscItems.perfectionismUpgradable_Jokers[jkrRef.config.center_key]) == 'function' then
							local upgTable = CirnoMod.miscItems.perfectionismUpgradable_Jokers[jkrRef.config.center_key]()
							
							targetKey = upgTable.key
							
							if upgTable.sound then
								upgSound = upgTable.sound
							end
						else
							targetKey = CirnoMod.miscItems.perfectionismUpgradable_Jokers[jkrRef.config.center_key]
						end
						
						CirnoMod.miscItems.unhighlightAllJokerAreas()
						
						G.E_MANAGER:add_event(Event({
							trigger = 'after',
							after = 0.25,
							blocking = true,
							blockable = true,
							func = function()
								SMODS.calculate_effect({
									message = localize('k_upgrade_ex'),
									sound = upgSound
								},jkrRef)
								
								jkrRef:set_ability(targetKey)
								
								local unlockRequired = not G.P_CENTERS[targetKey].unlocked
								
								unlock_card(G.P_CENTERS[targetKey], orgRarity == 'cir_keepsake_r')
								discover_card(G.P_CENTERS[targetKey], orgRarity == 'cir_keepsake_r')
								
								if unlockRequired then
									updateVisibleCards()
								end
								
								if
									jkrRef.config.center.postPerfInit
									and type(jkrRef.config.center.postPerfInit) == 'function'
								then
									jkrRef.config.center:postPerfInit(jkrRef, orgRarity, orgExtraTable, orgAbilityTbl)
								end
								
								return true
							end }))
						
						CirnoMod.miscItems.flippyFlip.fEnd(jkrRef, 0.8, 0.45)
						return
					end
				end
				
				local eligibleJokers = {}
				
				if jkrArea then
					for i, jkr in ipairs (jkrArea.cards) do
						if
							jkr.edition
							and CirnoMod.miscItems.pullEditionModifierValue(jkr.edition) ~= nil
						then
							table.insert(eligibleJokers, jkr)
						end
					end
				end
				
				if
					G.keepsake_area
					and G.keepsake_area.cards
					and G.keepsake_area.cards[1]
					and G.keepsake_area.cards[1].edition
				then
					table.insert(eligibleJokers, G.keepsake_area.cards[1])
				end
				
				local cardRef = card
				local jkrRef = pseudorandom_element(eligibleJokers, pseudoseed('randJokerScale'..G.GAME.round_resets.ante))
				
				SMODS.calculate_effect({
						message = CirnoMod.miscItems.scaleEdition_FHP(jkrRef, cardRef.ability.extra),
						message_card = jkrRef,
						colour = CirnoMod.miscItems.cardEditionTypeToColour(jkrRef) or G.C.FILTER,
						sound = CirnoMod.miscItems.cardEditionTypeToSfx(jkrRef) or 'generic1',
						volume = 0.5
					}, cardRef)
			end
		},
		-- Tomfoolery
		{
			key = 'sTomfoolery',
			cost = 5,
			pos = { x = 1, y = 0 },
			
			matureRefLevel = 1,
			
			loc_txt = { name = "Tomfoolery", text = {
					'Shuffles {C:dark_edition}editions{} and {C:attention}seals',
					'across both {C:attentions}cards{} and {C:attention}Jokers',
					'{s:0.8}(Will not transfer {s:0.8,C:dark_edition}Negative{s:0.8} from {s:0.8,C:attention}Jokers',
					'{s:0.8}to {s:0.8,C:attention}cards{s:0.8}, but can transfer it from',
					'{s:0.8}from {s:0.8,C:attention}cards{s:0.8} to {s:0.8,C:attention}Jokers{s:0.8} - Also,',
					'{s:0.8,C:red}#1#s{s:0.8} are the only seal that can',
					'{s:0.8}be transferred from {s:0.8,C:attention}cards{s:0.8} to {s:0.8,C:attention}Jokers{s:0.8})',
					'{s:0.8,C:inactive}Go on. Which one is it under?'
				}
			},
			
			
			loc_vars = function(self, info_queue, card)
				ret = { vars = { getSealName('red') } }
				
				info_queue[#info_queue + 1] = G.P_CENTERS.e_negative
				
				if CirnoMod.config.artCredits and not card.fake_card then
					info_queue[#info_queue + 1] = { key = "gA_NTF_Rend", set = "Other" }
				end
				
				if CirnoMod.miscItems.otherModPresences.isSealsOnEverythingPresent then
					ret.key = 'c_tomfoolery_soe'
				end
				
				return ret
			end,
			
			can_use = function(self, card)
				for _, cards in ipairs{
					G.jokers.cards or {},
					#G.play.cards > 0 and G.play.cards or G.hand.cards or {}
				} do
					for _, card_obj in ipairs(cards) do
						if card_obj.seal or card_obj.edition then
							return true
						end
					end
				end
			end,
			
			use = function(self, card, area)
				local seal_pool = {}
				local non_negatives = {}
				local negatives = {}
				local percent = 1
				local red_seals = 0
				local isSealsOnEverything = CirnoMod.miscItems.otherModPresences.isSealsOnEverythingPresent
				--[[ Special thanks to SleepyG11 who helped me work uot some of the issues with this consumable
				They basically rewrote my code to be a little cleaner and make it not eat editions/seals ]]
				
				-- Step 1: collect all cards we are working with
				local all_cards = {}
				local secondary_area = #G.play.cards > 0 and G.play or G.hand
				for _, _card in ipairs(G.jokers.cards) do
					table.insert(all_cards, _card)
				end
				for _, _card in ipairs(secondary_area.cards) do
					table.insert(all_cards, _card)
				end
				
				-- Step 2: flippy flappy, collect card seals & editions
				for _, _card in ipairs(all_cards) do
					_card.noFlipping = card.facing == 'back'
					
					if not _card.noFlipping then
						CirnoMod.miscItems.flippyFlip.fStart(_card, percent)
					end
			
					-- Step 2.1: seal, collect red seals and other seals
					if _card.seal then
						if _card.seal == "Red" and not isSealsOnEverything then
							--[[ Frontloads every other seal than red
							(except under certain circumstances)
							Reds get added to the pool last, after the loop]]
							red_seals = red_seals + 1
						else
							table.insert(seal_pool, _card.seal)
						end
					end
			
					-- Step 2.2: edition, collect negatives and other editions + store their source & editionScaling
					if _card.edition then
						local insertTable =
							{ key = _card.edition.key, e_source = _card.ability.set == "Joker" and "Joker" or "Card" }
			
						-- Split up negative and non-negative to prioritise assigning negative
						if _card.edition.key ~= "e_negative" then
							if card.ability.extra and card.ability.extra.editionScaling then
								-- Respect edition scaling
								insertTable.editionScaling = card.ability.extra.editionScaling
							end
			
							table.insert(non_negatives, insertTable)
						else
							table.insert(negatives, insertTable)
						end
					end
				end
				
				-- Step 3: post-process pools if needed
				if red_seals > 0 then
					for i = 1, red_seals do
						table.insert(seal_pool, 'Red')
					end
				end
				local edition_pool = SMODS.merge_lists{ negatives, non_negatives }
				
				-- Step 4: remove old editions, start assigning new ones
				G.E_MANAGER:add_event(Event({
					func = function()
						-- Step 4.1: prepare list of cards to work with
						local temp_all_cards = SMODS.shallow_copy(all_cards)
						local temp_only_jokers_cards = SMODS.shallow_copy(G.jokers.cards)
						-- local appliedEditionCount = 0 -- For debugging
			
						-- Step 4.2: remove editions
						for _, _card in ipairs(temp_all_cards) do
							if _card.edition then
								_card:set_edition(nil, true, true)
							end
						end
			
						-- Step 4.3: start distributing
						for edition_index, edition_obj in ipairs(edition_pool) do
							-- Step 4.3.1: picking a pool
							local target_pool = (edition_obj.key == "e_negative" and edition_obj.e_source == "Joker")
									and temp_only_jokers_cards
								or temp_all_cards
							local other_pool = target_pool == temp_all_cards and temp_only_jokers_cards or temp_all_cards
			
							-- Step 4.3.2: GAMBLING
							local _card, roll_key = pseudorandom_element(target_pool)
			
							-- Step 4.3.3: assign edition for target, remove from poolsn and keep editionScaling; or report that there's no valid target left
							if _card then
								target_pool[roll_key] = nil
			
								for _k, _v in pairs(other_pool) do
									if _v == _card then
										other_pool[_k] = nil
										break
									end
								end
								
								--[[ -- For debugging
								if _card.edition then
									print(string.format(
										'!!! Edition #%s: Overwriting %s on %s with %s (This shouldn\'t happen) !!!',
										edition_index,
										_card.edition.key,
										_card.ability.set,
										edition_obj.key
									))
								end
								]]
								
								_card:set_edition(edition_obj.key, true, true)
								-- appliedEditionCount = appliedEditionCount + 1 -- For debugging
			
								-- Step 4.3.4: respect scaling
								if edition_obj.editionScaling then
									if edition_obj.editionScaling.chips then
										_card.edition.chips = edition_obj.editionScaling.chips
									elseif edition_obj.editionScaling.mult then
										_card.edition.mult = edition_obj.editionScaling.mult
									elseif edition_obj.editionScaling.x_mult then
										_card.edition.x_mult = edition_obj.editionScaling.x_mult
									end
			
									_card.ability.extra = _card.ability.extra or {}
			
									_card.ability.extra.editionScaling = edition_obj.editionScaling
								end
							--[[ else -- For debugging
								print(string.format(
										"No target left for edition #%s %s from source %s",
										edition_index,
										edition_obj.key,
										edition_obj.e_source
									)
								) ]]
							end
						end
				
						--[[ print(string.format(
								'Processed %s editions, applied %s',
								#edition_pool,
								appliedEditionCount
							))
						]]
						return true
					end,
				}))
			
				-- Step 5: remove old seals, start assigning new ones
				G.E_MANAGER:add_event(Event({
					func = function()
						-- Step 5.1: prepare list of cards to work with
						local temp_all_cards = SMODS.shallow_copy(all_cards)
						local temp_only_hand_cards = SMODS.shallow_copy(secondary_area.cards)
						-- local appliedSealCount = 0 -- For debugging
			
						-- Step 5.2: remove seals
						for _, _card in ipairs(temp_all_cards) do
							if _card.seal then
								_card:set_seal(nil, true, true)
							end
						end
			
						-- Step 5.3: start distributing
						for seal_index, seal in ipairs(seal_pool) do
							-- Step 5.3.1: picking a pool
							local target_pool = (seal == "Red" or isSealsOnEverything) and temp_all_cards or temp_only_hand_cards
							local other_pool = target_pool == temp_all_cards and temp_only_hand_cards or temp_all_cards
			
							-- Step 5.3.2: GAMBLING
							local _card, roll_key = pseudorandom_element(target_pool)
			
							-- Step 5.3.3: assign seal for target, remove from pools; or report that there's no valid target left
							if _card then
								target_pool[roll_key] = nil
			
								for _k, _v in pairs(other_pool) do
									if _v == _card then
										other_pool[_k] = nil
										break
									end
								end
								
								--[[ -- For debugging
								if _card.seal then
									print(string.format(
										'!!! Seal #%s: Overwriting %s on %s with %s (This shouldn\'t happen) !!!',
										seal_index,
										_card.seal,
										_card.ability.set,
										seal
									))
								end
								]]
			
								_card:set_seal(seal, true, true)
								-- appliedSealCount = appliedSealCount + 1 -- For debugging
							--[[else -- For debugging
								print(string.format("No target left for seal %s", seal))]]
							end
						end
						
						--[[
						print(string.format(
								'Processed %s seals, applied %s',
								#seal_pool,
								appliedSealCount
							))
						]]
						return true
					end,
				}))
				
				--[[ Unflip the cards if they didn't start flipped,
				but got flipped earlier in this use function
				(The condition is to ensure this can't be used to
				unflip cards flipped by say, The House) ]]
				percent = 1
				
				-- Step 6: flippy flappy, lemon juice!
				for _, _card in ipairs(all_cards) do
					if not _card.noFlipping then
						CirnoMod.miscItems.flippyFlip.fEnd(_card, percent)
					else
						_card:juice_up()
					end
					
					_card.noFlipping = nil
				end
			end
		},
		-- Tilt
		{
			key = 'sTilt',
			cost = 3,
			pos = { x = 1, y = 1},
			config = { extra = { odds = 99 } },
			
			matureRefLevel = 1,
			
			loc_txt = { name = 'Tilt', text = {
				'Randomises all {C:attention}Suits',
				'and {C:attention}Ranks{} of the',
				'{C:attention}entire deck',
				' ',
				'{C:green}#1# in #2#{} chance',
				'per card without an',
				'{C:dark_edition}edition{} to gain one'
			} },
			
			loc_vars = function(self, info_queue, card)				
				local numerator, denumerator = SMODS.get_probability_vars(card or self, 1, card.ability.extra.odds, 'cirTilt')
				
				return { vars = {
					numerator,
					denumerator
				}}
			end,
			
			can_use = function(self, card)
				return true
			end,
			
			use = function(self, card, area)
				local percent = 1
				for k, pCard in pairs(G.playing_cards) do
					local cardOut = (pCard.area ~= G.deck and pCard.area ~= G.discard)
					local noFlipping = pCard.facing == 'back'
					
					if cardOut and not noFlipping then
						CirnoMod.miscItems.flippyFlip.fStart(pCard, percent)
					end
					
					G.E_MANAGER:add_event(Event({
						func = function()
							if cardOut and noFlipping then
								pCard:juice_up()
							end
							
							SMODS.change_base(pCard, pseudorandom_element(SMODS.Suits).key, pseudorandom_element(SMODS.Ranks).key)
							
							if
								not pCard.edition
								and SMODS.pseudorandom_probability(pCard, 'cirTilt', 1, card.ability.extra.odds)
							then
								pCard:set_edition(SMODS.poll_edition{ guaranteed = true, no_negative = true })
							end
							
						return true end }))
				end
				
				percent = 1
				
				for k, pCard in pairs(G.playing_cards) do
					local cardOut = (pCard.area ~= G.deck and pCard.area ~= G.discard)
					local noFlipping = pCard.facing == 'back'
					
					if cardOut and not noFlipping then
						CirnoMod.miscItems.flippyFlip.fEnd(pCard, percent)
					end
				end
			end
		}
	}
}

--[[ Define things that are constant with every Spectral in
this file once in a loop, rather than repeatedly per
table element ]]
for i, spc in ipairs(spectralInfo.cnsmConfigs) do
	spc.set = 'Spectral'
	spc.atlas = 'cir_cSpectrals'
end

SMODS.Joker:take_ownership('half', {
	cir_upgradeInfo = function(self, card)
		return {
			'{C:mult}+'..to_big(card.ability.extra.mult)..'{} Mult',
			'->',
			'{C:mult}+'..to_big(card.ability.extra.mult) * to_big(2)..'{} Mult'
		}
	end,
	
	cir_upgrade = function(self, card)
		card.ability.extra.mult = to_big(card.ability.extra.mult) * to_big(2)
		
		return { message = localize('k_upgrade_ex'), colour = G.C.MULT }
	end
	
	}, true)

SMODS.Joker:take_ownership('abstract', {
	cir_upgradeInfo = function(self, card)
		return {
			'{C:mult}+'..to_big(card.ability.extra)..'{} Mult per Joker',
			'->',
			'{C:mult}+'..to_big(card.ability.extra) * to_big(2)..'{} Mult per Joker'
		}
	end,
	
	cir_upgrade = function(self, card)
		card.ability.extra = to_big(card.ability.extra) * to_big(2)
		
		return { message = localize('k_upgrade_ex'), colour = G.C.MULT }
	end
	
	}, true)

SMODS.Joker:take_ownership('photograph', {
	cir_upgradeInfo = function(self, card)
		return {
			'{X:mult,C:white}X'..to_big(card.ability.extra)..'{} Mult',
			'->',
			'{X:mult,C:white}X'..to_big(card.ability.extra) + to_big(1)..'{} Mult'
		}
	end,
	
	cir_upgrade = function(self, card)
		card.ability.extra = to_big(card.ability.extra) + to_big(1)
		
		return { message = localize('k_upgrade_ex'), colour = G.C.MULT }
	end
	
	}, true)

SMODS.Joker:take_ownership('gift', {
	cir_upgradeInfo = function(self, card)
		return {
			'Adds {C:money}'..SMODS.signed_dollars(to_big(card.ability.extra))..'{} of sell value',
			'->',
			'Adds {C:money}'..SMODS.signed_dollars(to_big(card.ability.extra) * to_big(2))..'{} of sell value'
		}
	end,
	
	cir_upgrade = function(self, card)
		card.ability.extra = to_big(card.ability.extra) * to_big(2)
		
		return { message = localize('k_upgrade_ex'), colour = G.C.MONEY }
	end
	
	}, true)

SMODS.Joker:take_ownership('credit_card', {
	cir_upgradeInfo = function(self, card)
		return {
			'{C:red}-'..SMODS.signed_dollars(to_big(card.ability.extra))..'{} in debt',
			'->',
			'{C:red}-'..SMODS.signed_dollars(math.floor(to_big(card.ability.extra) * to_big(2)))..'{} in debt'
		}
	end,
	
	cir_upgrade = function(self, card)
		G.GAME.bankrupt_at = to_big(G.GAME.bankrupt_at) + to_big(card.ability.extra)
		card.ability.extra = math.floor(to_big(card.ability.extra) * to_big(2))
		G.GAME.bankrupt_at = to_big(G.GAME.bankrupt_at) - to_big(card.ability.extra)
		
		return { message = localize('k_upgrade_ex'), colour = G.C.RED }
	end
	
	}, true)

SMODS.Joker:take_ownership('chaos', {
	cir_upgradeInfo = function(self, card)
		local firstTextAppend = '{} free {C:green}Reroll'
		
		if card.ability.extra > 1 then
			firstTextAppend = '{} free {C:green}Rerolls'
		end
		
		return {
			'{C:attention}'..card.ability.extra..firstTextAppend,
			'->',
			'{C:attention}'..(card.ability.extra * 2)..'{} free {C:green}Rerolls'
		}
	end,
	
	cir_upgrade = function(self, card)
		local before = card.ability.extra
		
		card.ability.extra = card.ability.extra * 2
		SMODS.change_free_rerolls(card.ability.extra - before)
		calculate_reroll_cost(true)
		
		return { message = localize('k_upgrade_ex'), colour = G.C.GREEN }
	end
	
	}, true)

SMODS.Joker:take_ownership('fibonacci', {
	cir_upgradeInfo = function(self, card)
		return {
			'{C:mult}+'..to_big(card.ability.extra)..'{} Mult',
			'->',
			'{C:mult}+'..math.floor(to_big(card.ability.extra) * to_big(2))..'{} Mult'
		}
	end,
	
	cir_upgrade = function(self, card)
		card.ability.extra = math.floor(to_big(card.ability.extra) * to_big(2))
		
		return { message = localize('k_upgrade_ex'), colour = G.C.MULT }
	end
	
	}, true)

SMODS.Joker:take_ownership('throwback', {
	cir_upgradeInfo = function(self, card)
		return {
			'{X:mult,C:white}X'..to_big(card.ability.extra)..'{} Mult',
			'->',
			'{X:mult,C:white}X'..to_big(card.ability.extra) * to_big(2)..'{} Mult'
		}
	end,
	
	cir_upgrade = function(self, card)
		card.ability.extra = to_big(card.ability.extra) * to_big(2)
		
		return { message = localize('k_upgrade_ex'), colour = G.C.MULT }
	end
	
	}, true)

SMODS.Joker:take_ownership('ticket', {
	cir_upgradeInfo = function(self, card)
		return {
			'{C:money}'..SMODS.signed_dollars(to_big(card.ability.extra)),
			'->',
			'{C:money}'..SMODS.signed_dollars(to_big(card.ability.extra) * to_big(2))
		}
	end,
	
	cir_upgrade = function(self, card)
		card.ability.extra = to_big(card.ability.extra) * to_big(2)
		
		return { message = localize('k_upgrade_ex'), colour = G.C.MONEY }
	end
	
	}, true)

SMODS.Joker:take_ownership('wee', {
	cir_upgradeInfo = function(self, card)
		return {
			'{C:chips}+'..to_big(card.ability.extra.chip_mod)..'{} Chips',
			'->',
			'{C:chips}+'..to_big(card.ability.extra.chip_mod) * to_big(2)..'{} Chips'
		}
	end,
	
	cir_upgrade = function(self, card)
		card.ability.extra.chip_mod = to_big(card.ability.extra.chip_mod) * to_big(2)
		
		return { message = localize('k_upgrade_ex'), colour = G.C.CHIPS }
	end
	
	}, true)

SMODS.Joker:take_ownership('rough_gem', {
	cir_upgradeInfo = function(self, card)
		return {
			'{C:money}'..SMODS.signed_dollars(to_big(card.ability.extra)),
			'->',
			'{C:money}'..SMODS.signed_dollars(to_big(card.ability.extra) * to_big(2))
		}
	end,
	
	cir_upgrade = function(self, card)
		card.ability.extra = to_big(card.ability.extra) * to_big(2)
		
		return { message = localize('k_upgrade_ex'), colour = G.C.MONEY }
	end
	
	}, true)

SMODS.Joker:take_ownership('onyx_agate', {
	cir_upgradeInfo = function(self, card)
		return {
			'{C:mult}+'..to_big(card.ability.extra)..'{} Mult',
			'->',
			'{C:mult}+'..to_big(card.ability.extra) * to_big(2)..'{} Mult'
		}
	end,
	
	cir_upgrade = function(self, card)
		card.ability.extra = to_big(card.ability.extra) * to_big(2)
		
		return { message = localize('k_upgrade_ex'), colour = G.C.MULT }
	end
	
	}, true)

SMODS.Joker:take_ownership('arrowhead', {
	cir_upgradeInfo = function(self, card)
		return {
			'{C:chips}+'..to_big(card.ability.extra)..'{} Chips',
			'->',
			'{C:chips}+'..to_big(card.ability.extra) * to_big(2)..'{} Chips'
		}
	end,
	
	cir_upgrade = function(self, card)
		card.ability.extra = to_big(card.ability.extra) * to_big(2)
		
		return { message = localize('k_upgrade_ex'), colour = G.C.CHIPS }
	end
	
	}, true)

SMODS.Joker:take_ownership('bloodstone', {
	cir_upgradeInfo = function(self, card)
		return {
			'{X:mult,C:white}X'..to_big(card.ability.extra.Xmult)..'{} Mult',
			'->',
			'{X:mult,C:white}X'..to_big(card.ability.extra.Xmult) + to_big(0.5)..'{} Mult'
		}
	end,
	
	cir_upgrade = function(self, card)
		card.ability.extra.Xmult = to_big(card.ability.extra.Xmult) + to_big(0.5)
		
		return { message = localize('k_upgrade_ex'), colour = G.C.MULT }
	end
	
	}, true)

SMODS.Joker:take_ownership('castle', {
	cir_upgradeInfo = function(self, card)
		return {
			'{C:chips}+'..to_big(card.ability.extra.chip_mod)..'{} Chips on discard',
			'->',
			'{C:chips}+'..to_big(card.ability.extra.chip_mod) * to_big(2)..'{} Chips on discard'
		}
	end,
	
	cir_upgrade = function(self, card)
		card.ability.extra.chip_mod = to_big(card.ability.extra.chip_mod) * to_big(2)
		
		return { message = localize('k_upgrade_ex'), colour = G.C.CHIPS }
	end
	
	}, true)

SMODS.Joker:take_ownership('matador', {
	cir_upgradeInfo = function(self, card)
		return {
			'{C:money}'..SMODS.signed_dollars(to_big(card.ability.extra)),
			'->',
			'{C:money}'..SMODS.signed_dollars(to_big(card.ability.extra) * to_big(2))
		}
	end,
	
	cir_upgrade = function(self, card)
		card.ability.extra = to_big(card.ability.extra) * to_big(2)
		
		return { message = localize('k_upgrade_ex'), colour = G.C.MONEY }
	end
	
	}, true)

SMODS.Joker:take_ownership('trading', {
	cir_upgradeInfo = function(self, card)
		return {
			'{C:money}'..SMODS.signed_dollars(to_big(card.ability.extra)),
			'->',
			'{C:money}'..SMODS.signed_dollars(to_big(card.ability.extra) * to_big(2))
		}
	end,
	
	cir_upgrade = function(self, card)
		card.ability.extra = to_big(card.ability.extra) * to_big(2)
		
		return { message = localize('k_upgrade_ex'), colour = G.C.MONEY }
	end
	
	}, true)

SMODS.Joker:take_ownership('shoot_the_moon', {
	cir_upgradeInfo = function(self, card)
		return {
			'{C:mult}+'..to_big(card.ability.extra)..'{} Mult',
			'->',
			'{C:mult}+'..math.floor(to_big(card.ability.extra) * to_big(2))..'{} Mult'
		}
	end,
	
	cir_upgrade = function(self, card)
		card.ability.extra = math.floor(to_big(card.ability.extra) * to_big(2))
		
		return { message = localize('k_upgrade_ex'), colour = G.C.MULT }
	end
	
	}, true)

SMODS.Joker:take_ownership('popcorn', {
	cir_upgradeInfo = function(self, card)
		local result = nil
		
		if to_big(card.ability.mult) < to_big(20) then
			result = 60
		else
			result = to_big(card.ability.mult) * to_big(2)
		end
		
		return {
			'{C:mult}+'..to_big(card.ability.mult)..'{} Mult',
			'->',
			'{C:mult}+'..result..'{} Mult'
		}
	end,
	
	cir_upgrade = function(self, card)
		if to_big(card.ability.mult) < to_big(20) then
			card.ability.mult = to_big(60)
		else
			card.ability.mult = to_big(card.ability.mult) * to_big(2)
		end
		
		return { message = localize('k_upgrade_ex'), colour = G.C.MULT }
	end
	
	}, true)

SMODS.Joker:take_ownership('seeing_double', {
	cir_upgradeInfo = function(self, card)
		return {
			'{X:mult,C:white}X'..to_big(card.ability.extra)..'{} Mult',
			'->',
			'{X:mult,C:white}X'..to_big(card.ability.extra) * to_big(2)..'{} Mult'
		}
	end,
	
	cir_upgrade = function(self, card)
		card.ability.extra = to_big(card.ability.extra) * to_big(2)
		
		return { message = localize('k_upgrade_ex'), colour = G.C.MULT }
	end
	
	}, true)

SMODS.Joker:take_ownership('idol', {
	cir_upgradeInfo = function(self, card)
		return {
			'{X:mult,C:white}X'..to_big(card.ability.extra)..'{} Mult',
			'->',
			'{X:mult,C:white}X'..to_big(card.ability.extra) * to_big(2)..'{} Mult'
		}
	end,
	
	cir_upgrade = function(self, card)
		card.ability.extra = to_big(card.ability.extra) * to_big(2)
		
		return { message = localize('k_upgrade_ex'), colour = G.C.MULT }
	end
	
	}, true)

SMODS.Joker:take_ownership('flower_pot', {
	cir_upgradeInfo = function(self, card)
		return {
			'{X:mult,C:white}X'..to_big(card.ability.extra)..'{} Mult',
			'->',
			'{X:mult,C:white}X'..to_big(card.ability.extra) * to_big(2)..'{} Mult'
		}
	end,
	
	cir_upgrade = function(self, card)
		card.ability.extra = to_big(card.ability.extra) * to_big(2)
		
		return { message = localize('k_upgrade_ex'), colour = G.C.MULT }
	end
	
	}, true)

SMODS.Joker:take_ownership('drivers_license', {
	cir_upgradeInfo = function(self, card)
		return {
			'{X:mult,C:white}X'..to_big(card.ability.extra)..'{} Mult',
			'->',
			'{X:mult,C:white}X'..to_big(card.ability.extra) * to_big(2)..'{} Mult'
		}
	end,
	
	cir_upgrade = function(self, card)
		card.ability.extra = to_big(card.ability.extra) * to_big(2)
		
		return { message = localize('k_upgrade_ex'), colour = G.C.MULT }
	end
	
	}, true)

return spectralInfo