-- Renames the planets accordingly
if CirnoMod.config['planetTarotSpectralRenames'] then
	SMODS.process_loc_text(G.localization.descriptions.Planet.c_mercury, "name", "Aya")
	SMODS.process_loc_text(G.localization.descriptions.Planet.c_mercury, "text", {
                    "{S:0.8}({S:0.8,V:1}lvl.#1#{S:0.8}){} Level up",
                    "{C:attention}#2#",
                    "{C:mult}+#3#{} Mult and",
                    "{C:chips}+#4#{} chips",
					"{s:0.8,C:inactive}\"Extra, extra! ...Nothing",
					"{s:0.8,C:inactive}big happened, but it's",
					"{s:0.8,C:inactive}still an extra!\""
                })
	
	SMODS.process_loc_text(G.localization.descriptions.Planet.c_venus, "name", "Byakuren")
	SMODS.process_loc_text(G.localization.descriptions.Planet.c_venus, "text", {
                    "{S:0.8}({S:0.8,V:1}lvl.#1#{S:0.8}){} Level up",
                    "{C:attention}#2#",
                    "{C:mult}+#3#{} Mult and",
                    "{C:chips}+#4#{} chips",
					"{s:0.8,C:inactive}I love the smell",
					"{s:0.8,C:inactive}of incense."
                })
	
	SMODS.process_loc_text(G.localization.descriptions.Planet.c_earth, "name", "Renko")
	SMODS.process_loc_text(G.localization.descriptions.Planet.c_earth, "text", {
                    "{S:0.8}({S:0.8,V:1}lvl.#1#{S:0.8}){} Level up",
                    "{C:attention}#2#",
                    "{C:mult}+#3#{} Mult and",
                    "{C:chips}+#4#{} chips",
					"{s:0.8,C:inactive}No problem here."
                })
	
	SMODS.process_loc_text(G.localization.descriptions.Planet.c_mars, "name", "Shou")
	--[[
	SMODS.process_loc_text(G.localization.descriptions.Planet.c_mars, "text", {
                    "{S:0.8}({S:0.8,V:1}lvl.#1#{S:0.8}){} Level up",
                    "{C:attention}#2#",
                    "{C:mult}+#3#{} Mult and",
                    "{C:chips}+#4#{} chips",
					"{s:0.8,C:inactive}"
                })]]
	
	SMODS.process_loc_text(G.localization.descriptions.Planet.c_jupiter, "name", "Daiyousei")
	SMODS.process_loc_text(G.localization.descriptions.Planet.c_jupiter, "text", {
                    "{S:0.8}({S:0.8,V:1}lvl.#1#{S:0.8}){} Level up",
                    "{C:attention}#2#",
                    "{C:mult}+#3#{} Mult and",
                    "{C:chips}+#4#{} chips",
					"{s:0.8,C:inactive}And now look at",
					"{s:0.8,C:inactive}the big fairy!"
                })
	
	SMODS.process_loc_text(G.localization.descriptions.Planet.c_saturn, "name", "Momiji")
	--[[
	SMODS.process_loc_text(G.localization.descriptions.Planet.c_saturn, "text", {
                    "{S:0.8}({S:0.8,V:1}lvl.#1#{S:0.8}){} Level up",
                    "{C:attention}#2#",
                    "{C:mult}+#3#{} Mult and",
                    "{C:chips}+#4#{} chips",
					"{s:0.8,C:inactive}"
                })]]
	
	SMODS.process_loc_text(G.localization.descriptions.Planet.c_uranus, "name", "Rumia")
	SMODS.process_loc_text(G.localization.descriptions.Planet.c_uranus, "text", {
                    "{S:0.8}({S:0.8,V:1}lvl.#1#{S:0.8}){} Level up",
                    "{C:attention}#2#",
                    "{C:mult}+#3#{} Mult and",
                    "{C:chips}+#4#{} chips",
					"{s:0.8,C:inactive}\"Are you the kind",
					"{s:0.8,C:inactive}of person I can eat?\""
                })
	
	SMODS.process_loc_text(G.localization.descriptions.Planet.c_pluto, "name", "Nazrin")
	SMODS.process_loc_text(G.localization.descriptions.Planet.c_pluto, "text", {
                    "{S:0.8}({S:0.8,V:1}lvl.#1#{S:0.8}){} Level up",
                    "{C:attention}#2#",
                    "{C:mult}+#3#{} Mult and",
                    "{C:chips}+#4#{} chips",
					"{s:0.8,C:inactive}Cheesed to meet you."
                })
	
	SMODS.process_loc_text(G.localization.descriptions.Planet.c_planet_x, "name", "Yukari")
	SMODS.process_loc_text(G.localization.descriptions.Planet.c_planet_x, "text", {
                    "{S:0.8}({S:0.8,V:1}lvl.#1#{S:0.8}){} Level up",
                    "{C:attention}#2#",
                    "{C:mult}+#3#{} Mult and",
                    "{C:chips}+#4#{} chips",
					"{s:0.8,C:inactive}\"Noctambulism? That's ",
					"{s:0.8,C:inactive}my hobby too.\""
                })
	
	SMODS.process_loc_text(G.localization.descriptions.Planet.c_ceres, "name", "Kagerou")
	SMODS.process_loc_text(G.localization.descriptions.Planet.c_ceres, "text", {
                    "{S:0.8}({S:0.8,V:1}lvl.#1#{S:0.8}){} Level up",
                    "{C:attention}#2#",
                    "{C:mult}+#3#{} Mult and",
                    "{C:chips}+#4#{} chips",
					"{s:0.8,C:inactive}Remember to",
					"{s:0.8,E:1,C:inactive}Lycansubscribe."
                })
	
	SMODS.process_loc_text(G.localization.descriptions.Planet.c_eris, "name", "Nue")
	--[[
	SMODS.process_loc_text(G.localization.descriptions.Planet.c_eris, "text", {
                    "{S:0.8}({S:0.8,V:1}lvl.#1#{S:0.8}){} Level up",
                    "{C:attention}#2#",
                    "{C:mult}+#3#{} Mult and",
                    "{C:chips}+#4#{} chips",
					"{s:0.8,C:inactive}"
                })]]
end

if CirnoMod.config['miscRenames'] then
	-- Boosters
	SMODS.process_loc_text(G.localization.descriptions.Other.p_celestial_normal, "name", "Gensokyo Pack")
	SMODS.process_loc_text(G.localization.descriptions.Other.p_celestial_jumbo, "name", "Jumbo Gensokyo Pack")
	SMODS.process_loc_text(G.localization.descriptions.Other.p_celestial_mega, "name", "Mega Gensokyo Pack")
	
	-- Vouchers
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