--[[local planetIntent = G.localization.misc.labels.planet

Can't go based off the actual localisation variable name because it isn't changed  yet.
Thus, we need to establish what our intended changes will be and do it that way.
if CirnoMod.config.planetsAreHus then
	planetIntent = "Hu"
end]]

-- ...There's probably a better way to do this.
local sealIntent = {
		blue_seal = G.localization.descriptions.Other.blue_seal.name,
		red_seal = G.localization.descriptions.Other.red_seal.name,
		gold_seal = G.localization.descriptions.Other.gold_seal.name,
		purple_seal = G.localization.descriptions.Other.purple_seal.name
	}

if
	CirnoMod.replaceDef.locChanges.sealLoc.blue_seal
	and CirnoMod.replaceDef.locChanges.sealLoc.red_seal
	and CirnoMod.replaceDef.locChanges.sealLoc.gold_seal
	and CirnoMod.replaceDef.locChanges.sealLoc.purple_seal
then
	sealIntent = {
		blue_seal = CirnoMod.replaceDef.locChanges.sealLoc.blue_seal.name,
		red_seal = CirnoMod.replaceDef.locChanges.sealLoc.red_seal.name,
		gold_seal = CirnoMod.replaceDef.locChanges.sealLoc.gold_seal.name,
		purple_seal = CirnoMod.replaceDef.locChanges.sealLoc.purple_seal.name
	}
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
			
			loc_txt = {
				name = "Revelry",
				text = {
					"Adds a {C:red}"..sealIntent.red_seal,
					"to {C:attention}1{} random {C:attention}Joker{}",
					"{s:0.8}(Does not retrigger Joker editions)",
					"{s:0.8,C:inactive}Cirno can stop any time he wants."
				}
			},
			
			loc_vars = function(self, info_queue, card)
				info_queue[#info_queue + 1] = { key = "jkrRedSeal", set = "Other" }
				
				if CirnoMod.config.artCredits then
					info_queue[#info_queue + 1] = { key = "gA_NTF", set = "Other" }
				end
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
			
			loc_txt = {
				name = "Perfectionism",
				text = {
					'{C:attention}Upgrades{} the currently',
					'selected {C:attention}Joker',
					'{B:1,C:white}#1#',
					'If no compatible Jokers are',
					'present scales a random',
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
			soul_rate = 0.06,
			
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
				
				if
					G.jokers
					and G.jokers.highlighted
					and #G.jokers.highlighted > 0
				then
					if #G.jokers.highlighted > 1 then
						ret.vars[1] = 'Select only one Joker'
					elseif CirnoMod.miscItems.perfectionismUpgradable_Jokers[G.jokers.highlighted[1].config.center_key] then
						if type(CirnoMod.miscItems.perfectionismUpgradable_Jokers[G.jokers.highlighted[1].config.center_key]) == 'function' then
							local upJkrRet = CirnoMod.miscItems.perfectionismUpgradable_Jokers[G.jokers.highlighted[1].config.center_key]()
							
							if upJkrRet.clr then
								ret.vars.colours[1] = upJkrRet.clr
							end
							
							ret.vars[1] = upJkrRet.msg
						else
							ret.vars.colours[1] = G.C.GREEN
							ret.vars[1] = ' '..localize('k_compatible')..' '
						end
					else
						ret.vars[1] = ' '..localize('k_incompatible')..' '
					end
				end
				
				return ret
			end,
			
			can_use = function(self, card)
				local ret = false
				
				if
					G.jokers
					and G.jokers.highlighted
					and #G.jokers.highlighted == 1
					and CirnoMod.miscItems.perfectionismUpgradable_Jokers[G.jokers.highlighted[1].config.center_key]
				then
					if type(CirnoMod.miscItems.perfectionismUpgradable_Jokers[G.jokers.highlighted[1].config.center_key]) == 'function' then
						local upJkrRet = CirnoMod.miscItems.perfectionismUpgradable_Jokers[G.jokers.highlighted[1].config.center_key]()
						
						if upJkrRet.frc_incompatible then
							ret = false
						end
					end
				else
					ret = false
				end
				
				if
					#G.jokers.cards > 0
					and not ret
				then
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
					
					if type(CirnoMod.miscItems.perfectionismUpgradable_Jokers[jkrRef.config.center_key]) == 'function' then
						targetKey = CirnoMod.miscItems.perfectionismUpgradable_Jokers[jkrRef.config.center_key]().key
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
										sound = 'timpani'
									},jkrRef)
									jkrRef:set_ability(targetKey)
									
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
								message_card = jkrRef
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