local planetsAreHus = { planets = {}, boosters = {}, vouchers = {} }

-- Renames the planets accordingly
if CirnoMod.config['planetTarotSpectralRenames'] then
	planetsAreHus.planets.c_mercury = {
		name = "Aya",
		text = {
            "{S:0.8}({S:0.8,V:1}lvl.#1#{S:0.8}){} Level up",
            "{C:attention}#2#",
            "{C:mult}+#3#{} Mult and",
            "{C:chips}+#4#{} chips",
			"{s:0.8,C:inactive}\"Extra, extra! ...Nothing",
			"{s:0.8,C:inactive}big happened, but it's",
			"{s:0.8,C:inactive}still an extra!\""
        }
	}
	
	planetsAreHus.planets.c_venus = {
		name = "Byakuren",
		text = {
            "{S:0.8}({S:0.8,V:1}lvl.#1#{S:0.8}){} Level up",
            "{C:attention}#2#",
            "{C:mult}+#3#{} Mult and",
            "{C:chips}+#4#{} chips",
			"{s:0.8,C:inactive}I love the smell",
			"{s:0.8,C:inactive}of incense."
        }
	}
		
	planetsAreHus.planets.c_earth = {
		name = "Renko",
		text = {
            "{S:0.8}({S:0.8,V:1}lvl.#1#{S:0.8}){} Level up",
            "{C:attention}#2#",
            "{C:mult}+#3#{} Mult and",
            "{C:chips}+#4#{} chips",
			"{s:0.8,C:inactive}No problem here."
        }
	}
		
	planetsAreHus.planets.c_mars = {
		name = "Shou",
		text = {
		--[[
            "{S:0.8}({S:0.8,V:1}lvl.#1#{S:0.8}){} Level up",
            "{C:attention}#2#",
            "{C:mult}+#3#{} Mult and",
            "{C:chips}+#4#{} chips",
			"{s:0.8,C:inactive}"
		]]
        }
	}
	
	planetsAreHus.planets.c_jupiter = {
		name = "Daiyousei",
		text = {
            "{S:0.8}({S:0.8,V:1}lvl.#1#{S:0.8}){} Level up",
            "{C:attention}#2#",
            "{C:mult}+#3#{} Mult and",
            "{C:chips}+#4#{} chips",
			"{s:0.8,C:inactive}And now look at",
			"{s:0.8,C:inactive}the big fairy!"
        }
	}
		
	planetsAreHus.planets.c_saturn = {
		name = "Momiji",
		text = {
		--[[
            "{S:0.8}({S:0.8,V:1}lvl.#1#{S:0.8}){} Level up",
            "{C:attention}#2#",
            "{C:mult}+#3#{} Mult and",
            "{C:chips}+#4#{} chips",
			"{s:0.8,C:inactive}"
		]]
        }
	}
	
	planetsAreHus.planets.c_uranus = {
		name = "Rumia",
		text = {
            "{S:0.8}({S:0.8,V:1}lvl.#1#{S:0.8}){} Level up",
            "{C:attention}#2#",
            "{C:mult}+#3#{} Mult and",
            "{C:chips}+#4#{} chips",
			"{s:0.8,C:inactive}\"Are you the kind",
			"{s:0.8,C:inactive}of person I can eat?\""
        }
	}
	
	planetsAreHus.planets.c_pluto = {
		name = "Nazrin",
		text = {
            "{S:0.8}({S:0.8,V:1}lvl.#1#{S:0.8}){} Level up",
            "{C:attention}#2#",
            "{C:mult}+#3#{} Mult and",
            "{C:chips}+#4#{} chips",
			"{s:0.8,C:inactive}Cheesed to meet you."
        }
	}
	
	planetsAreHus.planets.c_planet_x = {
		name = "Yukari",
		text = {
            "{S:0.8}({S:0.8,V:1}lvl.#1#{S:0.8}){} Level up",
            "{C:attention}#2#",
            "{C:mult}+#3#{} Mult and",
            "{C:chips}+#4#{} chips",
			"{s:0.8,C:inactive}\"Noctambulism? That's ",
			"{s:0.8,C:inactive}my hobby too.\""
        }
	}
	
	planetsAreHus.planets.c_ceres = {
		name = "Kagerou",
		text = {
            "{S:0.8}({S:0.8,V:1}lvl.#1#{S:0.8}){} Level up",
            "{C:attention}#2#",
            "{C:mult}+#3#{} Mult and",
            "{C:chips}+#4#{} chips",
			"{s:0.8,C:inactive}Remember to",
			"{s:0.8,E:1,C:inactive}Lycansubscribe."
        }
	}
		
	planetsAreHus.planets.c_eris = {
		name = "Nue",
		text = {
		--[[
            "{S:0.8}({S:0.8,V:1}lvl.#1#{S:0.8}){} Level up",
            "{C:attention}#2#",
            "{C:mult}+#3#{} Mult and",
            "{C:chips}+#4#{} chips",
			"{s:0.8,C:inactive}"
		]]
        }
	}
end

if CirnoMod.config['miscRenames'] then
	-- Boosters
	planetsAreHus.boosters.p_celestial_normal = { name = "Gensokyo Pack" }
	planetsAreHus.boosters.p_celestial_jumbo = { name = "Jumbo Gensokyo Pack" }
	planetsAreHus.boosters.p_celestial_mega = { name = "Mega Gensokyo Pack" }
	--[[
	Set booster descriptions in Misc because
	A. That's the main handler of boosters,
	B. Will handle boosters when planets are hus is off
	Although yeah, this is kinda funky, probably a much better way to do this]]
	
	-- Vouchers (TODO)
	--[[
	SMODS.process_loc_text(G.localization.descriptions.Voucher.v_telescope, "name", "Telescope")
	SMODS.process_loc_text(G.localization.descriptions.Voucher.v_observatory, "name", "Observatory")
	]]
	
	--[[
	SMODS.process_loc_text(G.localization.descriptions.Voucher.v_planet_merchant, "name", "Planet Merchant")
	SMODS.process_loc_text(G.localization.descriptions.Voucher.v_planet_tycoon, "name", "Planet Tycoon")
	]]
	
	-- Achievements
	SMODS.process_loc_text(G.localization.misc.achievement_descriptions, "astronomy", "Discover every Hu card")
	
	-- Dictionary entries
	SMODS.process_loc_text(G.localization.misc.dictionary, "b_planet_cards", "Hu Cards")
	SMODS.process_loc_text(G.localization.misc.dictionary, "b_stat_planet", "Hu's")
	SMODS.process_loc_text(G.localization.misc.dictionary, "k_planet", "Hu")
	SMODS.process_loc_text(G.localization.misc.dictionary, "k_planet_q", "...Nep?!")
	SMODS.process_loc_text(G.localization.misc.dictionary, "k_plus_planet", "+1 Hu")
	
	-- Labels
	SMODS.process_loc_text(G.localization.misc.labels, "planet", "Hu")
	SMODS.process_loc_text(G.localization.misc.labels, "pluto_planet", "...Nep?!")
	
	-- Changes around the badges on Planets and their colours.
	local planetRelabelling = {
		{ key = 'mercury', newLabelKey = 'k_planet', newLabelColour = CirnoMod.miscItems.colours.planet },
		{ key = 'venus', newLabelKey = 'k_planet', newLabelColour = CirnoMod.miscItems.colours.planet },
		{ key = 'earth', newLabelKey = 'k_planet', newLabelColour = CirnoMod.miscItems.colours.planet },
		{ key = 'mars', newLabelKey = 'k_planet', newLabelColour = CirnoMod.miscItems.colours.planet },
		{ key = 'jupiter', newLabelKey = 'k_planet', newLabelColour = CirnoMod.miscItems.colours.planet },
		{ key = 'saturn', newLabelKey = 'k_planet', newLabelColour = CirnoMod.miscItems.colours.planet },
		{ key = 'uranus', newLabelKey = 'k_planet', newLabelColour = CirnoMod.miscItems.colours.planet },
		{ key = 'neptune', newLabelKey = 'k_planet_q', newLabelColour = CirnoMod.miscItems.colours.cirNep },
		{ key = 'pluto', newLabelKey = 'k_planet', newLabelColour = CirnoMod.miscItems.colours.planet },
		{ key = 'ceres', newLabelKey = 'k_planet', newLabelColour = CirnoMod.miscItems.colours.planet },
		{ key = 'eris', newLabelKey = 'k_planet', newLabelColour = CirnoMod.miscItems.colours.planet },
		{ key = 'planet_x', newLabelKey = 'k_planet', newLabelColour = CirnoMod.miscItems.colours.planet }
	}
	
	for i, p in ipairs (planetRelabelling) do
		SMODS.Consumable:take_ownership(p.key, {
			set_card_type_badge = function(self, card, badge)
				badge[1] = create_badge(localize(p.newLabelKey), p.newLabelColour, G.C.WHITE, 1.2)
			end
		})
	end
	
	
end

return planetsAreHus