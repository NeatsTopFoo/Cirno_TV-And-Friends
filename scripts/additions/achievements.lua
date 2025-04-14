local cirAch = { }

cirAch.crazyFace = {
	shouldBeAdded = function()
		return (CirnoMod.config.malverkReplacements
			and CirnoMod.config.addCustomJokers)
	end,
	
	info = {
		loc_txt = {
			name = "I See Your Scary Face And Raise You...",
			description = {
				"Encounter Scary Face's reskin"
			}
		},
		
		unlock_condition = function(self, args)
			return CirnoMod.miscItems.hasEncounteredJoker('j_scary_face')
		end
	}
}

cirAch.hasThreeJokes = {
	shouldBeAdded = function()
		return (CirnoMod.config.malverkReplacements
			and CirnoMod.config.addCustomJokers)
	end,
	
	info = {
		loc_txt = {
			name = "CHAT, YOU HAVE OTHER EMOTES",
			description = {
				"Encounter at least one Joker reskin per",
				"skin that is "..CirnoMod.miscItems.getJokerNameByKey('j_bootstraps', '{C:red}Not Active{}')..", 2 max or",
				"cirGuns related."
			}
		},
		
		hidden_text = true,
				
		unlock_condition = function(self, args)
			return (CirnoMod.miscItems.jkrKeyGroupTotalEncounters('allegations', true) > 0
					and CirnoMod.miscItems.jkrKeyGroupTotalEncounters('TwoMax', true) > 0
					and CirnoMod.miscItems.jkrKeyGroupTotalEncounters('fingerGuns', true) > 0)
		end
	}
}

return cirAch