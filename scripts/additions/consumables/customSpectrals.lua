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
			set = 'Spectral',
			cost = 4,
			atlas = 'cir_cSpectrals',
			pos = { x = 0, y = 0 },
			config = { extra = 'Red' },
			
			matureRefLevel = 1,
			
			loc_txt = {
				name = "Revelry",
				text = {
					"Add a {C:red}"..sealIntent.red_seal,
					"to a random {C:attention}Joker{}",
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
		}
	}
}

return spectralInfo