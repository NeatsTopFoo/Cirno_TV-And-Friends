-- Primary definition
CirnoMod.extendedDescTooltip = SMODS.Center:extend{
	set = 'extendedDescTooltip',
	obj_buffer = {},
	obj_table = CirnoMod.miscItems.descExtensionTooltips,
	class_prefix = 'eDT',
	required_params = { 'key' },
	pre_inject_class = function(self)
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