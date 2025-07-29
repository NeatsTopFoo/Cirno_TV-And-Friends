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
			cost = 6,
			pos = { x = 0, y = 1 },
			soul_pos = { x = 0, y = 2 },
			config = { extra = 2 },
			
			matureRefLevel = 1,
			cir_Friend = { CirnoMod.miscItems.cirFriends.cir, CirnoMod.miscItems.cirFriends.han },
			
			loc_txt = {
				name = "Perfectionism",
				text = {
					'{C:attention}Upgrades{} the currently',
					'selected {C:attention}Joker',
					'{B:1,C:white}#1#',
					'If no compatible Jokers are',
					'present, scales a random',
					'Joker\'s {C:dark_edition}edition{} by a scalar of {C:attention}#2#',
					'{s:0.8}({s:0.8,C:dark_edition}Foil{s:0.8}/{s:0.8,C:dark_edition}Holographic{s:0.8}/{s:0.8,C:dark_edition}Polychrome{s:0.8} only)',
					'{s:0.8,C:inactive}The factory must grow.',
					'{s:0.8,C:inactive}The factory must grow.',
					'{s:0.6,C:inactive}The factory must grow.',
					'{s:0.4,C:inactive}The factory must grow.'
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
				local ret = {
					vars = {
						colours = { G.C.RED },
						' No Joker selected ',
						card.ability.extra }
				}
				
				local upJkrRet = nil
				
				if
					G.jokers
					and G.jokers.highlighted
					and #G.jokers.highlighted > 0
				then
					if #G.jokers.highlighted > 1 then
						ret.vars[1] = 'Select only one Joker'
					elseif CirnoMod.miscItems.perfectionismUpgradable_Jokers[G.jokers.highlighted[1].config.center_key] then
						if type(CirnoMod.miscItems.perfectionismUpgradable_Jokers[G.jokers.highlighted[1].config.center_key]) == 'function' then
							upJkrRet = CirnoMod.miscItems.perfectionismUpgradable_Jokers[G.jokers.highlighted[1].config.center_key]()
							
							if upJkrRet.clr then
								ret.vars.colours[1] = upJkrRet.clr
							end
							
							ret.vars[1] = upJkrRet.msg
						else
							upJkrRet = CirnoMod.miscItems.perfectionismUpgradable_Jokers[G.jokers.highlighted[1].config.center_key]
							ret.vars.colours[1] = G.C.GREEN
							ret.vars[1] = ' '..localize('k_compatible')..' '
						end
					else
						ret.vars[1] = ' '..localize('k_incompatible')..' '
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
				
				info_queue[#info_queue + 1] = CirnoMod.miscItems.getEditionScalingInfo({ type = 'example' }, card.ability.extra )
				
				if CirnoMod.config.artCredits and not card.fake_card then
					info_queue[#info_queue + 1] = { key = "gA_NTF", set = "Other" }
				end
				
				return ret
			end,
			
			can_use = function(self, card)
				local ret = false
				
				if G.jokers and G.jokers.cards and #G.jokers.cards > 0 then
					if
						G.jokers.highlighted
						and #G.jokers.highlighted == 1
						and CirnoMod.miscItems.perfectionismUpgradable_Jokers[G.jokers.highlighted[1].config.center_key]
					then
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
					and CirnoMod.miscItems.perfectionismUpgradable_Jokers[G.jokers.highlighted[1].config.center_key]
				then
					CirnoMod.miscItems.flippyFlip.fStart(G.jokers.highlighted[1])
					
					local jkrRef = G.jokers.highlighted[1]
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

return spectralInfo