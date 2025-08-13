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
			
			loc_txt = {
				name = "Revelry",
				text = {
					"Adds a {C:red}#1#",
					"to {C:attention}1{} random {C:attention}Joker{}",
					"{s:0.8}(Does not retrigger Joker editions)",
					"{s:0.8,C:inactive}Cirno can stop any time he wants."
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
				local RV = false
				
				if G.jokers then
					if G.jokers.cards then						
						for i, jkr in ipairs (G.jokers.cards) do
							if not jkr.seal then
								RV = true
								break
							end
						end
					end
				end
				
				return RV
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
			
			loc_txt = {
				name = "Perfectionism",
				text = {
					'{C:attention}Upgrades{} the currently',
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
				
				local compatibility = { mix_colours(G.C.RED, G.C.JOKER_GREY, 0.8), ' No Joker Selected ' }
				local descAppend = {
					'If no compatible Jokers are',
					'present, scales a random',
					'Joker\'s {C:dark_edition}edition{} by a scalar of {C:attention}'..card.ability.extra,
					'{s:0.8}({s:0.8,C:dark_edition}Foil{s:0.8}/{s:0.8,C:dark_edition}Holographic{s:0.8}/{s:0.8,C:dark_edition}Polychrome{s:0.8} only)',
					'{s:0.8,C:inactive}The factory must grow',
					'{s:0.8,C:inactive}The factory must grow',
					'{s:0.6,C:inactive}The factory must grow',
					'{s:0.4,C:inactive}The factory must grow'
				}
				
				if not card.fake_card then
					local upJkrRet = nil
					
					if
						G.jokers
						and G.jokers.highlighted
						and #G.jokers.highlighted > 0
					then
						if #G.jokers.highlighted > 1 then
							compatibility[2] = 'Select only one Joker'
						elseif
							(G.jokers.highlighted[1].config.center.cir_upgradeInfo
							and type(G.jokers.highlighted[1].config.center.cir_upgradeInfo) == 'function'
							and G.jokers.highlighted[1].config.center:cir_upgradeInfo(G.jokers.highlighted[1])
							and G.jokers.highlighted[1].config.center.cir_upgrade)
						then
							CirnoMod.miscItems.descExtensionTooltips.eDT_cir_perfectionismSpecific.myText =G.jokers.highlighted[1].config.center:cir_upgradeInfo(G.jokers.highlighted[1])
							
							info_queue[#info_queue + 1] = CirnoMod.miscItems.descExtensionTooltips.eDT_cir_perfectionismSpecific
							
							compatibility[1] = mix_colours(G.C.GREEN, G.C.JOKER_GREY, 0.8)
							compatibility[2] = ' '..localize('k_compatible')..' '
						elseif
							CirnoMod.miscItems.perfectionismUpgradable_Jokers[G.jokers.highlighted[1].config.center_key]
						then
							if type(CirnoMod.miscItems.perfectionismUpgradable_Jokers[G.jokers.highlighted[1].config.center_key]) == 'function' then
								upJkrRet = CirnoMod.miscItems.perfectionismUpgradable_Jokers[G.jokers.highlighted[1].config.center_key]()
								
								if upJkrRet.clr then
									compatibility[1] = upJkrRet.clr
								end
								
								compatibility[2] = upJkrRet.msg
							else
								upJkrRet = CirnoMod.miscItems.perfectionismUpgradable_Jokers[G.jokers.highlighted[1].config.center_key]
								compatibility[1] = mix_colours(G.C.GREEN, G.C.JOKER_GREY, 0.8)
								compatibility[2] = ' '..localize('k_compatible')..' '
							end
						else
							compatibility[2] = ' '..localize('k_incompatible')..' '
						end
					end
					
					if upJkrRet and not upJkrRet.frc_incompatible then
						local upgTxtClrs = { G.C.CLEAR, G.C.FILTER }
						
						if CirnoMod.miscItems.getJokerRarityByKey(upJkrRet) == 'cir_UpgradedJkr' then
							upgTxtClrs[1] = CirnoMod.miscItems.colours.cirUpgradedJkrClr_tbl[CirnoMod.miscItems.getJokerRarityByKey(G.jokers.highlighted[1].config.center_key)] or CirnoMod.miscItems.colours.cirUpgradedJkrClr
							upgTxtClrs[2] = G.C.WHITE
						end
						
						info_queue[#info_queue + 1] = { key = 'perfectionismUpg',
							set = 'Other',
							vars = {
								colours = upgTxtClrs,
								CirnoMod.miscItems.getJokerNameByKey(G.jokers.highlighted[1].config.center.key),
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
					
					info_queue[#info_queue + 1] = CirnoMod.miscItems.getEditionScalingInfo({ type = 'example' }, card.ability.extra )
					
					if CirnoMod.config.artCredits and not card.fake_card then
						info_queue[#info_queue + 1] = { key = "gA_NTF", set = "Other" }
					end
				end
				
				return ret
			end,
			
			can_use = function(self, card)
				local ret = false
				
				if G.jokers and G.jokers.cards and #G.jokers.cards > 0 then
					if
						G.jokers.highlighted
						and #G.jokers.highlighted == 1
						and (CirnoMod.miscItems.perfectionismUpgradable_Jokers[G.jokers.highlighted[1].config.center_key]
						or (G.jokers.highlighted[1].config.center.cir_upgradeInfo
						and type(G.jokers.highlighted[1].config.center.cir_upgradeInfo) == 'function'
						and G.jokers.highlighted[1].config.center:cir_upgradeInfo(G.jokers.highlighted[1])
						and G.jokers.highlighted[1].config.center.cir_upgrade))
					then
						if
							(G.jokers.highlighted[1].config.center.cir_upgradeInfo
							and G.jokers.highlighted[1].config.center.cir_upgrade)
						then
							return true
						end
						
						if type(CirnoMod.miscItems.perfectionismUpgradable_Jokers[G.jokers.highlighted[1].config.center_key]) == 'function' then
							local upJkrRet = CirnoMod.miscItems.perfectionismUpgradable_Jokers[G.jokers.highlighted[1].config.center_key]()
							
							if upJkrRet.frc_incompatible then
								ret = false
							end
						else
							ret = true
						end
					else
						ret = false
					end
					
					
					if not ret then
						for i, jkr in ipairs (G.jokers.cards) do
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
				
				return ret
			end,
			
			use = function(self, card, area)
				if
					G.jokers
					and G.jokers.highlighted
					and #G.jokers.highlighted == 1
					and (CirnoMod.miscItems.perfectionismUpgradable_Jokers[G.jokers.highlighted[1].config.center_key]
					or (G.jokers.highlighted[1].config.center.cir_upgradeInfo
					and G.jokers.highlighted[1].config.center.cir_upgrade))
				then
					CirnoMod.miscItems.flippyFlip.fStart(G.jokers.highlighted[1])
					
					local jkrRef = G.jokers.highlighted[1]
					
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
						or (type(jkrRef.ability.extra) == 'number'
						and jkrRef.ability.extra > 1)
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
									
									if
										jkrRef.config.center.postPerfInit
										and type(jkrRef.config.center.postPerfInit) == 'function'
									then
										jkrRef.config.center:postPerfInit(jkrRef, orgRarity, orgExtraTable, orgAbilityTbl)
									end
									
									return true
									end }))
					
					CirnoMod.miscItems.flippyFlip.fEnd(jkrRef, 0.8, 0.45)
				else
					local eligibleJokers = {}
					
					for i, jkr in ipairs (G.jokers.cards) do
						if
							jkr.edition
							and CirnoMod.miscItems.pullEditionModifierValue(jkr.edition) ~= nil
						then
							table.insert(eligibleJokers, jkr)
						end
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