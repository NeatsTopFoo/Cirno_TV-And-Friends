local cirAch = { }

cirAch.crazyFace = {
	shouldBeAdded = function()
		return (CirnoMod.config.malverkReplacements
			and CirnoMod.config.addCustomJokers)
	end,
	
	info = {
		loc_txt = {
			name = "Hm, I Wonder What's Down Here?",
			description = {
				"Encounter "..CirnoMod.miscItems.obscureStringIfJokerKeyLockedOrUndisc('Scary Face', 'j_scary_face').."'s reskin",
				"(in an unseeded run)"
			}
		},
		
		unlock_condition = function(self, args)
			CirnoMod.miscItems.updateModAchievementDesc(self.key, {
				"Encounter "..CirnoMod.miscItems.obscureStringIfJokerKeyLockedOrUndisc('Scary Face', 'j_scary_face').."'s reskin",
				"(in an unseeded run)"
			})
			
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
				"skin that is "..CirnoMod.miscItems.obscureStringIfNoneInJokerKeyGroupEncountered(CirnoMod.miscItems.getJokerNameByKey('j_bootstraps', '{C:red}Not Active{}'), 'allegations')..", "..CirnoMod.miscItems.obscureStringIfNoneInJokerKeyGroupEncountered('2 max', 'TwoMax').." or",
				CirnoMod.miscItems.obscureStringIfNoneInJokerKeyGroupEncountered('cirGuns', 'fingerGuns').." related.",
				"(in an unseeded run)"
			}
		},
		
		-- hidden_text = true,
				
		unlock_condition = function(self, args)
			CirnoMod.miscItems.updateModAchievementDesc(self.key, {
				"Encounter at least one Joker reskin per",
				"skin that is "..CirnoMod.miscItems.obscureStringIfNoneInJokerKeyGroupEncountered(CirnoMod.miscItems.getJokerNameByKey('j_bootstraps', '{C:red}Not Active{}'), 'allegations')..", "..CirnoMod.miscItems.obscureStringIfNoneInJokerKeyGroupEncountered('2 max', 'TwoMax').." or",
				CirnoMod.miscItems.obscureStringIfNoneInJokerKeyGroupEncountered('cirGuns', 'fingerGuns').." related.",
				"(in an unseeded run)"
			})
			
			return (CirnoMod.miscItems.jkrKeyGroupTotalEncounters('allegations', true) > 0
					and CirnoMod.miscItems.jkrKeyGroupTotalEncounters('TwoMax', true) > 0
					and CirnoMod.miscItems.jkrKeyGroupTotalEncounters('fingerGuns', true) > 0)
		end
	}
}

cirAch.gottem = {
	shouldBeAdded = function()
		return CirnoMod.config.addCustomJokers
	end,
	
	info = {
		loc_txt = {
			name = 'Gottem',
			description = {
				'Unlock Dabber'
			}
		},
		
		hidden_text = true,
		
		unlock_condition = function(self, args)
			return CirnoMod.config.jkrVals[G.SETTINGS.profile].store.dabber_altf4
		end
	}
}

return cirAch