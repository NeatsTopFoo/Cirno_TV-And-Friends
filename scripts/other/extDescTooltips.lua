-- Primary definition
CirnoMod.extendedDescTooltip = SMODS.Center:extend{
	set = 'extendedDescTooltip',
	obj_buffer = {},
	obj_table = CirnoMod.miscItems.descExtensionTooltips,
	class_prefix = 'eDT',
	required_params = { 'key' },
	pre_inject_class = function(self)
		G.localization.descriptions[self.set] = {}
		G.P_CENTER_POOLS[self.set] = {}
	end,
	
	inject = function(self)
		SMODS.Center.inject(self)
	end,
	
	get_obj = function(self, key)
		if key == nil then return nil end
		return self.obj_table[key]
	end
}

-- Test Tooltip
CirnoMod.extendedDescTooltip{
	key = 'testTTip',
	
	loc_txt = {
		name = 'Test Tooltip',
		text = {
			{
				'This is a test tooltip.'
			},
			{
				'It should appear next to the',
				'description of what it gets',
				'added to.'
			}
		}
	}
}

-- Allegations Jokers
CirnoMod.extendedDescTooltip{
	key = 'allegations',
	
	loc_txt = {
		name = CirnoMod.miscItems.getJokerNameByKey('j_bootstraps', '{C:red}Not Active{}').." Jokers",
		text = {}
	},
	
	updateName = function()
		SMODS.process_loc_text(G.localization.descriptions.extendedDescTooltip.eDT_cir_allegations, "name", CirnoMod.miscItems.getJokerNameByKey('j_bootstraps', '{C:red}Not Active{}').." Jokers")
	end,
	
	generate_ui = function(self, info_queue, card, desc_nodes, specific_vars, full_UI_table)
		if
			CirnoMod.miscItems.jkrKeyGroups.allegations
			and next(CirnoMod.miscItems.jkrKeyGroups.allegations)
		then
			for k, b in pairs(CirnoMod.miscItems.jkrKeyGroups.allegations) do
				desc_nodes[#desc_nodes+1] = {}
				CirnoMod.miscItems.addUITextNode(desc_nodes[#desc_nodes], CirnoMod.miscItems.obscureJokerNameIfNotEncountered(k), G.C.FILTER, 0.8)
				
				if next(CirnoMod.miscItems.jkrKeyGroups.allegations, k) ~= nil then
					CirnoMod.miscItems.addUITextNode(desc_nodes[#desc_nodes], ',', G.C.UI.TEXT_DARK, 0.8)
				end
			end
		else
			desc_nodes[#desc_nodes+1] = {}
			CirnoMod.miscItems.addUITextNode(desc_nodes[#desc_nodes], 'Not Active', G.C.RED, 0.8)
		end
		SMODS.Center.generate_ui(self, info_queue, card, desc_nodes, specific_vars, full_UI_table)
	end
}

-- 2 Max Jokers
CirnoMod.extendedDescTooltip{
	key = '2max',
	
	loc_txt = { name = "2 Max Jokers", text = {} },
	
	generate_ui = function(self, info_queue, card, desc_nodes, specific_vars, full_UI_table)
		if
			CirnoMod.miscItems.jkrKeyGroups.TwoMax
			and next(CirnoMod.miscItems.jkrKeyGroups.TwoMax)
		then
			for k, b in pairs(CirnoMod.miscItems.jkrKeyGroups.TwoMax) do
				desc_nodes[#desc_nodes+1] = {}
				CirnoMod.miscItems.addUITextNode(desc_nodes[#desc_nodes], CirnoMod.miscItems.obscureJokerNameIfNotEncountered(k), G.C.FILTER, 0.8)
				
				if next(CirnoMod.miscItems.jkrKeyGroups.TwoMax, k) ~= nil then
					CirnoMod.miscItems.addUITextNode(desc_nodes[#desc_nodes], ',', G.C.UI.TEXT_DARK, 0.8)
				end
			end
		else
			desc_nodes[#desc_nodes+1] = {}
			CirnoMod.miscItems.addUITextNode(desc_nodes[#desc_nodes], 'Not Active', G.C.RED, 0.8)
		end
		SMODS.Center.generate_ui(self, info_queue, card, desc_nodes, specific_vars, full_UI_table)
	end
}

-- cirGuns Jokers
CirnoMod.extendedDescTooltip{
	key = 'Guns',
	
	loc_txt = { name = "cirGuns Jokers", text = {} },
	
	generate_ui = function(self, info_queue, card, desc_nodes, specific_vars, full_UI_table)
		if
			CirnoMod.miscItems.jkrKeyGroups.fingerGuns
			and next(CirnoMod.miscItems.jkrKeyGroups.fingerGuns)
		then
			for k, b in pairs(CirnoMod.miscItems.jkrKeyGroups.fingerGuns) do
				desc_nodes[#desc_nodes+1] = {}
				CirnoMod.miscItems.addUITextNode(desc_nodes[#desc_nodes], CirnoMod.miscItems.obscureJokerNameIfNotEncountered(k), G.C.FILTER, 0.8)
				
				if next(CirnoMod.miscItems.jkrKeyGroups.fingerGuns, k) ~= nil then
					CirnoMod.miscItems.addUITextNode(desc_nodes[#desc_nodes], ',', G.C.UI.TEXT_DARK, 0.8)
				end
			end
		else
			desc_nodes[#desc_nodes+1] = {}
			CirnoMod.miscItems.addUITextNode(desc_nodes[#desc_nodes], 'Not Active', G.C.RED, 0.8)
		end
		SMODS.Center.generate_ui(self, info_queue, card, desc_nodes, specific_vars, full_UI_table)
	end
}

-- Unhinged Jokers
CirnoMod.extendedDescTooltip{
	key = 'unhinged',
	
	loc_txt = { name = "Unhinged Jokers", text = {} },
	
	generate_ui = function(self, info_queue, card, desc_nodes, specific_vars, full_UI_table)
		if
			CirnoMod.miscItems.jkrKeyGroups.unhinged
			and next(CirnoMod.miscItems.jkrKeyGroups.unhinged)
		then
			local counter = 0
			desc_nodes[#desc_nodes+1] = {}
			
			for k, b in pairs(CirnoMod.miscItems.jkrKeyGroups.unhinged) do
				CirnoMod.miscItems.addUITextNode(desc_nodes[#desc_nodes], CirnoMod.miscItems.obscureJokerNameIfNotEncountered(k), G.C.FILTER, 0.8)
				
				if next(CirnoMod.miscItems.jkrKeyGroups.unhinged, k) == nil then
					break
				end
				
				if counter >= 2 then
					CirnoMod.miscItems.addUITextNode(desc_nodes[#desc_nodes], ',', G.C.UI.TEXT_DARK, 0.8)
					desc_nodes[#desc_nodes+1] = {}
					counter = 0
				else
					CirnoMod.miscItems.addUITextNode(desc_nodes[#desc_nodes], ', ', G.C.UI.TEXT_DARK, 0.8)
					counter = counter + 1
				end
			end
		else
			desc_nodes[#desc_nodes+1] = {}
			CirnoMod.miscItems.addUITextNode(desc_nodes[#desc_nodes], 'Not Active', G.C.RED, 0.8)
		end
		SMODS.Center.generate_ui(self, info_queue, card, desc_nodes, specific_vars, full_UI_table)
	end
}

-- Chat Brainrot Jokers
CirnoMod.extendedDescTooltip{
	key = 'chatBrainrot',
	
	loc_txt = { name = "Chat Brainrot Jokers", text = {} },
	
	generate_ui = function(self, info_queue, card, desc_nodes, specific_vars, full_UI_table)
		if
			CirnoMod.miscItems.jkrKeyGroups.chatBrainrot
			and next(CirnoMod.miscItems.jkrKeyGroups.chatBrainrot)
		then
			local counter = 0
			desc_nodes[#desc_nodes+1] = {}
			
			for k, b in pairs(CirnoMod.miscItems.jkrKeyGroups.chatBrainrot) do
				CirnoMod.miscItems.addUITextNode(desc_nodes[#desc_nodes], CirnoMod.miscItems.obscureJokerNameIfNotEncountered(k), G.C.FILTER, 0.8)
				
				if next(CirnoMod.miscItems.jkrKeyGroups.chatBrainrot, k) == nil then
					break
				end
				
				if counter >= 2 then
					CirnoMod.miscItems.addUITextNode(desc_nodes[#desc_nodes], ',', G.C.UI.TEXT_DARK, 0.8)
					desc_nodes[#desc_nodes+1] = {}
					counter = 0
				else
					CirnoMod.miscItems.addUITextNode(desc_nodes[#desc_nodes], ', ', G.C.UI.TEXT_DARK, 0.8)
					counter = counter + 1
				end
			end
		else
			desc_nodes[#desc_nodes+1] = {}
			CirnoMod.miscItems.addUITextNode(desc_nodes[#desc_nodes], 'Not Active', G.C.RED, 0.8)
		end
		SMODS.Center.generate_ui(self, info_queue, card, desc_nodes, specific_vars, full_UI_table)
	end
}


-- cirGuns (It's just cirGuns)
CirnoMod.extendedDescTooltip{
	key = 'cirGuns',
	
	loc_txt = { name = '', text = {} },
	
	generate_ui = function(self, info_queue, card, desc_nodes, specific_vars, full_UI_table)		
		desc_nodes[#desc_nodes+1] = {}
		
		CirnoMod.miscItems.addUISpriteNode(desc_nodes[#desc_nodes], Sprite(
					0, 0, -- Sprite X & Y
					1.0, 1.3, -- Sprite W & H
					CirnoMod.miscItems.funnyAtlases.cirGuns, -- Sprite Atlas
					{ x = CirnoMod.miscItems.cirGunsSpriteX, y = 0 } -- Position in the Atlas
				)
			)
		SMODS.Center.generate_ui(self, info_queue, card, desc_nodes, specific_vars, full_UI_table)
	end
}

-- Specific Upgrade Tooltip
CirnoMod.extendedDescTooltip{
	key = 'perfectionismSpecific',
	
	loc_txt = { name = 'Upgrade Info', text = {} },
	
	-- Store Joker upgrade text table
	myText = nil,
	
	generate_ui = function(self, info_queue, card, desc_nodes, specific_vars, full_UI_table)
		-- Parse stored table into UI text nodes
		if self.myText and type(self.myText) == 'table' then
			for _, t in ipairs(self.myText) do
				desc_nodes[#desc_nodes+1] = {{
					n = G.UIT.R,
					config = { align = "cm", padding = 0.03 },
					nodes = SMODS.localize_box(loc_parse_string(t), {scale = 1.0})
				}}
			end
		end
		
		SMODS.Center.generate_ui(self, info_queue, card, desc_nodes, specific_vars, full_UI_table)
	end
}

-- Flesh Deck Extra Info
CirnoMod.extendedDescTooltip{
	key = 'fleshDeck_ext',
	
	loc_txt = { name = 'Addressed Gripes',
		text = {
			'Changed {C:attention}Straight\'s{} name to {C:attention}Consecutive',
			'{s:0.8} (inc. Straight Flush)',
			'At end of round earn {C:money}$1{} per {C:attention}25% of score overkill',
			'The same item (hopefully) {C:attention}cannot appear twice',
			'{C:attention}across two back-to-back rerolls{}, or {C:attention}in a reroll',
			'{C:attention}following being in a #1#',
			'{s:0.8}(Note that {s:0.8,C:planet}#2#s{s:0.8}/{s:0.8,C:tarot}Tarots{s:0.8} in the shop can prevent them being',
			'{s:0.8}in their respective packs, PS3 limitations please understand)',
			'{C:attention}#3#s{} have a {C:green}#4# in #5#{} chance',
			'to create another {C:attention}#3#',
			'Holding a {C:attention}#6#{} and a',
			'{C:attention}#7#{} without a {C:attention}#8# guarantees',
			'a {C:attention}#8#{} in an upcoming shop',
			'{C:attention}#9#{} & {C:attention}#10# are {C:attention}banned',
			-- 'A {C:attention}Flesh Deck{} run doesn\'t',
			-- 'require a working internet',
			-- 'connection to play'
		}
	},
	
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = { key = 'tag_coupon', set = 'Tag', config = { fake_card = true } }
		
		info_queue[#info_queue + 1] = SMODS.shallow_copy(G.P_CENTERS.j_vampire)
		info_queue[#info_queue].fake_card = true
		
		info_queue[#info_queue + 1] = SMODS.shallow_copy(G.P_CENTERS.j_midas_mask)
		info_queue[#info_queue].fake_card = true
		
		info_queue[#info_queue + 1] = SMODS.shallow_copy(G.P_CENTERS.j_pareidolia)
		info_queue[#info_queue].fake_card = true
		
		info_queue[#info_queue + 1] = SMODS.shallow_copy(G.P_CENTERS.j_bloodstone)
		info_queue[#info_queue].fake_card = true
				
		info_queue[#info_queue + 1] = { key = 'bl_needle', set = 'Blind', config = { fake_card = true } }
		
		local numerator, denominator = SMODS.get_probability_vars(card or self, 1, G.GAME and G.GAME.selected_back.effect.config and G.GAME.selected_back.effect.config.tagOdds or 4)
		
		return { vars = {
			localize{ type = 'name_text', key = 'p_buffoon_normal', set = 'Other' },
			G.localization.misc.labels.planet,
			localize{ type = 'name_text', key = 'tag_coupon', set = 'Tag' },
			numerator,
			denominator,
			localize{ type = 'name_text', key = 'j_vampire', set = 'Joker' },
			localize{ type = 'name_text', key = 'j_midas_mask', set = 'Joker' },
			localize{ type = 'name_text', key = 'j_pareidolia', set = 'Joker' },
			localize{ type = 'name_text', key = 'j_bloodstone', set = 'Joker' },
			localize{ type = 'name_text', key = 'bl_needle', set = 'Blind' }
		} }
	end
}