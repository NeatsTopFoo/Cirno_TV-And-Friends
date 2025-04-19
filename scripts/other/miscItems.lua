local miscItems = {
	artCreditKeys = {},
	weirdArtCreditExceptionalCircumstanceKeys = {}, -- Some things seem to do weird things, like Wild cards.
	descExtensionTooltips = {},
	-- handsThatContainOtherHands = {},
	alphabetNumberConv = {
		numToAlphabet = {},
		alphabetToNum = {}
	},
	deckSkinNames = {}, -- How the custom deck skins are referred to internally. Used for art credit tooltips.
	deckSkinWhich = {}, -- Differentiate between different deck skins we might want to add, in case we have different crediting to do per skin.
	keysOfAllCirnoModItems = {}, -- This will be used for any effects the focus on stuff edited or introduced by this mod
	jkrKeyGroups = {},
	jkrKeyGroupArrays = {},
	funnyAtlases = {},
	otherAtlases = {},
	switchKeys = {},
	switchTables = {}
}

miscItems.cirGunsSpriteX = 0

miscItems.keysOfJokersToUpdateStateOnLoad = {
	j_cir_arumia_l = true,
	j_cir_naro_l = true,
	j_cir_crystalTap = true
}
	
miscItems.otherModPresences = {
	isSealsOnJokersPresent = false,
	isTalismanPresent = false
}
	
miscItems.matureReferencesOpt = { "(Hopefully) Safest", "Some", "All" } -- These are the options that appear on the new cycle option for mature references.

-- Table containing keys of jokers and what contexts should be ignored for red seal retriggers
miscItems.redSealRetriggerIgnoreTable = {
		j_fortune_teller = { 'using_consumeable' },
		j_cir_naro_l = { 'using_consumeable' },
		j_cir_arumia_l = { 'using_consumeable', 'setting_blind', 'hand_drawn' }
	}
	
miscItems.colours = {
	cirInactiveAtt = HEX('BFB199FF'),
	cirBlue = HEX('0766EBFF'),
	cirCyan = HEX('0AD0F7FF'),
	cirLucy = HEX('7BB083FF'),
	cirNep = HEX('D066ADFF'),
	bbBlack = HEX('000000FF'),
	bbInvisText = HEX('00000000')
}

miscItems.colours.cirNope = SMODS.Gradient({
	key = 'cirNope',
	colours = {
		G.C.PURPLE,
		miscItems.colours.cirNep
	}
})

miscItems.badges = {
	allegations = function(bootstrapsName) return create_badge(bootstrapsName, G.C.GREEN, G.C.UI.TEXT_LIGHT, 0.8 ) end,
	TwoMax = function() return create_badge("2 Max", miscItems.colours.cirNep, G.C.UI.TEXT_LIGHT, 0.8) end,
	cirGuns = function() return create_badge("cirGuns", miscItems.colours.cirCyan, G.C.UI.TEXT_LIGHT, 0.8 ) end,
	crazyWomen = function() return create_badge("Crazy Women", G.C.RED, G.C.UI.TEXT_LIGHT, 0.8 ) end
}

miscItems.addUITextNode = function(nodes, text, colour, scale)
	nodes[#nodes + 1] = {
		n = G.UIT.T,
		config = {
			text = text,
			colour = colour,
			scale = scale*0.32
		}
	}
	
	return nodes[#nodes]
end
	
miscItems.addUISpriteNode = function(nodes, sprite)
	local RV = nil
	
	if nodes then
		nodes[#nodes + 1] = {
			n = G.UIT.O,
			config = { object = sprite }
		}
		RV = nodes[#nodes]
	else
		RV = {
			n = G.UIT.O,
			config = { object = sprite }
		}
	end
	
	if sprite.atlas.manualFrameParsing	then
		RV.config.thisObjFrameParse = copy_table(sprite.atlas.manualFrameParsing)
		RV.config.thisObjFrameParse.counter = 0
		CirnoMod.miscItems.manuallyAnimateAtlasItem(RV.config)
	elseif sprite.atlas.typewriterFrameParsing then
		RV.config.thisObjFrameParse = copy_table(sprite.atlas.typewriterFrameParsing)
		RV.config.thisObjFrameParse.counter = 0
		CirnoMod.miscItems.doTypewriterAtlasAnimation(RV.config)
	end
	
	return RV
end
	
miscItems.addUIColumnOrRowNode = function(nodes, alignment, type, colour, radius, padding)
	if
		type == 'C'
		or type == 'R'
	then
		nodes[#nodes + 1] = {
			n = G.UIT[type],
			config = {
				align = alignment,
				colour = colour,
				r = radius,
				padding = padding,
				res = 0.15
			},
			nodes = {}
		}
	end
	
	return nodes[#nodes]
end
	
miscItems.restructureNodesTableIntoRowsOrColumns = function(nodesTable, orderedKeysTable, RowOrColumn, config)
	local RV = {}
	
	if
		RowOrColumn == 'R'
		or RowOrColumn == 'C'
	then		
		for i, k in ipairs (orderedKeysTable) do
			table.insert(RV, {
				n = G.UIT[RowOrColumn],
				config = config,
				nodes = nodesTable[k]
			})
		end
	end
	
	return RV
end
	
miscItems.addHighlightedUITextNode = function(nodes, alignment, HColour, radius, padding, text, TColour, scale)
	nodes[#nodes + 1] = {
		n = G.UIT.C,
		config = {
			align = alignment,
			colour = HColour,
			r = radius,
			padding = padding,
			res = 0.15
		},
		nodes = {{
			n = G.UIT.T,
			config = {
				text = text,
				colour = TColour,
				scale = scale*0.32
			}
		}}
	}
	
	return nodes[#nodes]
end
	
miscItems.manuallyAnimateAtlasItem = function(UINodeConfigTable)
	G.E_MANAGER:add_event(Event({
		trigger = 'immediate',
		blocking = false,
		blockable = false,			
		func = function()
			if
				UINodeConfigTable
				and UINodeConfigTable.object
				and UINodeConfigTable.object.sprite_pos
				and UINodeConfigTable.object.atlas
				and UINodeConfigTable.thisObjFrameParse
			then
				if UINodeConfigTable.thisObjFrameParse.counter < UINodeConfigTable.thisObjFrameParse.delay then
					UINodeConfigTable.thisObjFrameParse.counter = UINodeConfigTable.thisObjFrameParse.counter + 0.1
				else
					if UINodeConfigTable.object.sprite_pos.x < (UINodeConfigTable.object.atlas.frames - 1) then
						UINodeConfigTable.object.sprite_pos.x = UINodeConfigTable.object.sprite_pos.x + 1
					else
						UINodeConfigTable.object.sprite_pos.x = 0
					end
					
					UINodeConfigTable.thisObjFrameParse.counter = 0
				end
				
				return false
			else
				return true
			end
		end
	}))
end

miscItems.doTypewriterAtlasAnimation = function(UINodeConfigTable)
	G.E_MANAGER:add_event(Event({
		trigger = 'immediate',
		blocking = false,
		blockable = false,			
		func = function()
			if
				UINodeConfigTable
				and UINodeConfigTable.object
				and UINodeConfigTable.object.sprite_pos
				and UINodeConfigTable.object.atlas
				and UINodeConfigTable.thisObjFrameParse
			then
				local XendPoint = UINodeConfigTable.thisObjFrameParse.rowLength
				
				if UINodeConfigTable.object.sprite_pos.y == UINodeConfigTable.thisObjFrameParse.finalRowY then
					XendPoint = UINodeConfigTable.thisObjFrameParse.finalRowFrames
				end
				
				if UINodeConfigTable.thisObjFrameParse.counter < UINodeConfigTable.thisObjFrameParse.delay then
					UINodeConfigTable.thisObjFrameParse.counter = UINodeConfigTable.thisObjFrameParse.counter + 0.1
				else
					if UINodeConfigTable.object.sprite_pos.x < XendPoint then
						UINodeConfigTable.object.sprite_pos.x = UINodeConfigTable.object.sprite_pos.x + 1
					else
						if UINodeConfigTable.object.sprite_pos.y == UINodeConfigTable.thisObjFrameParse.finalRowY then
							UINodeConfigTable.object.sprite_pos.y = 0
						else
							UINodeConfigTable.object.sprite_pos.y = UINodeConfigTable.object.sprite_pos.y + 1
						end
						
						UINodeConfigTable.object.sprite_pos.x = 0
					end
					
					UINodeConfigTable.thisObjFrameParse.counter = 0
				end
				
				return false
			else
				return true
			end
		end
	}))
end

miscItems.filterTable = function(sourceTable, destinationTable, filterTable)
	for i, F in ipairs (filterTable) do
		if sourceTable[F] then
			destinationTable[F] = sourceTable[F]
		end
	end
end
	
miscItems.newFilteredTable = function(inputTable, filterTable)
local RV = {}
	for i, F in ipairs (filterTable) do
		if inputTable[F] then
			RV[F] = inputTable[F]
		end
	end
return RV
end

miscItems.getAllDebuffedCardsInCardTable = function(cardTable)
	RV = {}
	
	for i, card in ipairs (cardTable) do
		if
			card.debuff
			and Card:can_calculate(true)
		then
			table.insert(RV, card)
		end
	end
	
	return RV
end

miscItems.isState = function(curGameState, stateToCheck)
	if
		curGameState
		and stateToCheck
	then 
		return curGameState == stateToCheck
	end
	return false
end
	
miscItems.isStage = function(curGameStage, stageToCheck)
	if
		curGameStage
		and stageToCheck
	then 
		return curGameStge == stageToCheck
	end
	return false
end

miscItems.roundEvalDollarCalc = {
	part = function(CDBret, dollars_, pitch_, card_, i_)
		local RV = { i = i_ + 1, pitch = pitch_, dollars = dollars_ + CDBret }
		add_round_eval_row({dollars = CDBret, bonus = true, name='joker'..RV.i, pitch = RV.pitch, card = card_})
		RV.pitch = RV.pitch + 0.06
		dollars_ = dollars_ + CDBret
		return RV
	end,
	
	full = function(CDBret, dollars_, pitch_, card_, i_)
		local RV = CirnoMod.miscItems.roundEvalDollarCalc.part(CDBret, dollars_, pitch_, card_, i_)
		
		if
			card_.seal
			and card_.seal == 'Red'
		then
			SMODS.calculate_effect({ message = localize('k_again_ex'), colour = G.C.FILTER, card = card_ }, card_)
			
			RV = CirnoMod.miscItems.roundEvalDollarCalc.part(CDBret, RV.dollars, RV.pitch, card_, RV.i)
		end
		
		return RV
	end
}

miscItems.buildArrayFromKVPTable = function(kvpTable)
	local RV = {}
	
	for k, v in kvpTable do
		table.insert(RV, k)
	end
	
	if #RV == 0 then
		print("buildArrayFromKVPTable() created empty table from")
		print(tprint(kvpTable))
	end
	
	return RV
end

--[[ Thank you aikoooo T_T
Honestly dumb that I need to do this
in the first place for what I initially
want it for, but I guess it's a useful
tool we can keep around]]
for i = 97, 122 do
	table.insert(miscItems.alphabetNumberConv.numToAlphabet, string.char(i))
	miscItems.alphabetNumberConv.alphabetToNum[string.char(i)] = i - 96
end

--[[
TODO: Describe what these are and how they work.
I probably won't and this will stay like this
forever, which would be even funnier. Good luck.]]
miscItems.createABSwitchLatch = function(itemKey, chance, startOnAOrB)
	if 
		not CirnoMod.miscItems.switchKeys[itemKey]
		and (startOnAOrB == 'A' or startOnAOrB == 'B')
	then
		table.insert(CirnoMod.miscItems.switchKeys, itemKey)
		
		CirnoMod.miscItems.switchTables[itemKey] = {
			AB = startOnAOrB,
			sType = "ABSwitchLatch",
			first = noFirstHoverProc,
			procChance = chance
		}
	end	
	return CirnoMod.miscItems.switchTables[itemKey]
end

miscItems.processSwitch = function(itemKey)
	if CirnoMod.miscItems.switchTables[itemKey] then
		if CirnoMod.miscItems.switchTables[itemKey].first then
			CirnoMod.miscItems.switchTables[itemKey].first = false
		else
			if CirnoMod.miscItems.switchTables[itemKey].sType == "ABSwitchLatch" then
				-- AB Switch processing					
				if CirnoMod.miscItems.switchTables[itemKey].AB == 'A' then
					if pseudorandom(itemKey) < CirnoMod.miscItems.switchTables[itemKey].procChance then
						CirnoMod.miscItems.switchTables[itemKey].AB = 'B'
					end
				elseif CirnoMod.miscItems.switchTables[itemKey].AB == 'B' then
					CirnoMod.miscItems.switchTables[itemKey].AB = 'A'
				end
			end
		end
	end
	
	return CirnoMod.miscItems.switchTables[itemKey]
end

miscItems.getJokerNameByKey = function(jkrKey, default)
	local RV = default or G.localization.descriptions.Joker[jkrKey] and G.localization.descriptions.Joker[jkrKey].name or nil
	
	if
		CirnoMod.replaceDef
		and CirnoMod.replaceDef.locChanges
		and CirnoMod.replaceDef.locChanges.jkrLoc.nrmJkrs
		and CirnoMod.replaceDef.locChanges.jkrLoc.nrmJkrs[jkrKey]
	then
		RV = CirnoMod.replaceDef.locChanges.jkrLoc.nrmJkrs[jkrKey].name
	end
	
	return RV
end

miscItems.jkrKeyGroups.TwoMax = {}
miscItems.jkrKeyGroups.crazyWomen = {}

if
	CirnoMod.config.malverkReplacements
then
	miscItems.jkrKeyGroups.allegations = {
		j_bootstraps = true,
		j_riff_raff = true
	}
	
	miscItems.jkrKeyGroups.TwoMax.j_duo = true
	miscItems.jkrKeyGroups.TwoMax.j_sly = true
	
	miscItems.jkrKeyGroups.fingerGuns = {
		j_golden = true,
		j_ring_master = true,
		j_stuntman = true
	}
	
	miscItems.jkrKeyGroups.crazyWomen.j_chaos = true
	miscItems.jkrKeyGroups.crazyWomen.j_zany = true
	miscItems.jkrKeyGroups.crazyWomen.j_crazy = true
	miscItems.jkrKeyGroups.crazyWomen.j_drunkard = true
	miscItems.jkrKeyGroups.crazyWomen.j_sock_and_buskin = true
	miscItems.jkrKeyGroups.crazyWomen.j_mime = true
	miscItems.jkrKeyGroups.crazyWomen.j_greedy_joker = true
	miscItems.jkrKeyGroups.crazyWomen.j_lusty_joker = true
	miscItems.jkrKeyGroups.crazyWomen.j_delayed_grat = true
	miscItems.jkrKeyGroups.crazyWomen.j_even_steven = true
	miscItems.jkrKeyGroups.crazyWomen.j_odd_todd = true
	miscItems.jkrKeyGroups.crazyWomen.j_supernova = true
	miscItems.jkrKeyGroups.crazyWomen.j_swashbuckler = true
	miscItems.jkrKeyGroups.crazyWomen.j_astronomer = true
	miscItems.jkrKeyGroups.crazyWomen.j_burnt = true
	miscItems.jkrKeyGroups.crazyWomen.j_caino = true
	miscItems.jkrKeyGroups.crazyWomen.j_triboulet = true
	miscItems.jkrKeyGroups.crazyWomen.j_yorick = true
	miscItems.jkrKeyGroups.crazyWomen.j_chicot = true
	miscItems.jkrKeyGroups.crazyWomen.j_vampire = true
	miscItems.jkrKeyGroups.crazyWomen.j_midas_mask = true
	miscItems.jkrKeyGroups.crazyWomen.j_wily = true
	miscItems.jkrKeyGroups.crazyWomen.j_devious = true
	miscItems.jkrKeyGroups.crazyWomen.j_lucky_cat = true
end

if CirnoMod.config.addCustomJokers then
	miscItems.jkrKeyGroups.TwoMax.j_cir_naro_l = true
	
	miscItems.jkrKeyGroups.crazyWomen.j_cir_crazyFace = true
	miscItems.jkrKeyGroups.crazyWomen.j_cir_nope_l = true
	miscItems.jkrKeyGroups.crazyWomen.j_cir_naro_l = true
	miscItems.jkrKeyGroups.crazyWomen.j_cir_arumia_l = true
end

miscItems.jkrKeyGroupTotalEncounters = function(groupName, stopAt1)
	local RV = 0
	
	if miscItems.jkrKeyGroups[groupName] then
		for i, k in ipairs(miscItems.jkrKeyGroups[groupName]) do
			if
				CirnoMod.config.encounteredJokers[G.PROFILES[G.SETTINGS.profile].name]
				and CirnoMod.config.encounteredJokers[G.PROFILES[G.SETTINGS.profile].name][k]
			then
				RV = RV + CirnoMod.config.encounteredJokers[k]
			end
		
			if stopAt1 and RV > 0 then
				break
			end
		end
	end
	
	return RV
end

miscItems.keyGroupOfJokerKey = function(jkrKey)
	for k, t in pairs(CirnoMod.miscItems.jkrKeyGroups) do
		if t[jkrKey] then
			return k
		end
	end
	
	return nil
end

miscItems.encounterJoker = function(jkrKey)
	if
		CirnoMod.config.encounteredJokers
	then
		if not CirnoMod.config.encounteredJokers[G.PROFILES[G.SETTINGS.profile].name] then
			CirnoMod.config.encounteredJokers[G.PROFILES[G.SETTINGS.profile].name] = {}
		end
		
		if not CirnoMod.config.encounteredJokers[G.PROFILES[G.SETTINGS.profile].name][jkrKey] then
			CirnoMod.config.encounteredJokers[G.PROFILES[G.SETTINGS.profile].name][jkrKey] = 0
		end
		
		CirnoMod.config.encounteredJokers[G.PROFILES[G.SETTINGS.profile].name][jkrKey] = CirnoMod.config.encounteredJokers[G.PROFILES[G.SETTINGS.profile].name][jkrKey] + 1
		return true
	end
	
	return false
end

miscItems.hasEncounteredJoker = function(jkrKey)
	if
		CirnoMod.config.encounteredJokers
		and CirnoMod.config.encounteredJokers[G.PROFILES[G.SETTINGS.profile].name]
		and CirnoMod.config.encounteredJokers[G.PROFILES[G.SETTINGS.profile].name][jkrKey]
	then
		return CirnoMod.config.encounteredJokers[G.PROFILES[G.SETTINGS.profile].name][jkrKey] > 0
	end
	
	return false
end

miscItems.obscureJokerNameIfNotEncountered = function(jkrKey)
	if CirnoMod.miscItems.hasEncounteredJoker(jkrKey) then
		return CirnoMod.miscItems.getJokerNameByKey(jkrKey)
	else
		return '?????'
	end
end

miscItems.obscureJokerTooltipIfNotEncountered = function(jkrKey)
	if CirnoMod.miscItems.hasEncounteredJoker(jkrKey) then
		if G.P_CENTERS[jkrKey] then
			return G.P_CENTERS[jkrKey]
		else
			return { key = 'errorTooltip', set = 'Other' }
		end
	else
		return { key = 'questionMarkTooltip', set = 'Other' }
	end
end

miscItems.obscureJokerNameIfLockedOrUndisc = function(jkrKey)
	if CirnoMod.miscItems.isUnlockedAndDisc(G.P_CENTERS[jkrKey]) then
		return CirnoMod.miscItems.getJokerNameByKey(jkrKey)
	else
		return '?????'
	end
end

miscItems.obscureStringIfJokerKeyLockedOrUndisc = function(string, jkrKey)
	if CirnoMod.miscItems.isUnlockedAndDisc(G.P_CENTERS[jkrKey]) then
		return string
	else
		return '?????'
	end
end

miscItems.obscureStringIfNoneInJokerKeyGroupEncountered = function(string, groupName)
	if CirnoMod.miscItems.jkrKeyGroupTotalEncounters(groupName, true) > 0 then
		return string
	else
		return '?????'
	end
end

miscItems.isUnlockedAndDisc = function(card)
	if
		card.unlocked ~= nil
		and card.discovered ~= nil
	then
		return card.unlocked and card.discovered
	end
	
	return card and card.config.center.unlocked and card.config.center.discovered
end

miscItems.updateModAchievementDesc = function(achKey, newDescTable)
	SMODS.process_loc_text(
		G.localization.misc.achievement_descriptions,
		achKey,
		newDescTable)
end

-- These are surprise tools that will help us later. :)
miscItems.funnyAtlases.cirGuns = SMODS.Atlas({
	key = 'cir_Guns',
	path = 'Misc/cirGuns.png',
	px = 71,
	py = 95
})

miscItems.funnyAtlases.japaneseGoblin = SMODS.Atlas({
	key = 'cir_jGoblin',
	path = 'Misc/japaneseGoblin.png',
	px = 64,
	py = 64,
	atlas_table = 'ANIMATION_ATLAS',
	frames = 52
})
-- miscItems.funnyAtlases.japaneseGoblin.manualFrameParsing = { delay = 0.2 }

miscItems.funnyAtlases.emotes = SMODS.Atlas({
	key = 'cir_Emotes',
	path = 'Misc/cir_Emotes.png',
	px = 64,
	py = 64
})

miscItems.funnyAtlases.rumiSleep = SMODS.Atlas({
	key = 'cir_rumiSleep',
	path = 'Misc/rumiSleep.png',
	px = 64,
	py = 64,
	atlas_table = 'ANIMATION_ATLAS',
	frames = 38
})
-- miscItems.funnyAtlases.rumiSleep.manualFrameParsing = { delay = 0.4 }

--[[ This one I have to do funky stuff with because
Balatro gets weird with big atlases. Can't do the
whole of Bad Apple in one line.]]
miscItems.funnyAtlases.badApple = SMODS.Atlas({
	key = 'cir_badApple',
	path = 'Misc/badApple.png',
	px = 80,
	py = 64
})
miscItems.funnyAtlases.badApple.typewriterFrameParsing = { delay = 0.3, rowLength = 99, finalRowY = 4, finalRowFrames = 77 }

miscItems.funnyAtlases.badAppleInv = SMODS.Atlas({
	key = 'cir_badApple_inv',
	path = 'Misc/badApple_inv.png',
	px = 80,
	py = 64
})
miscItems.funnyAtlases.badAppleInv.typewriterFrameParsing = { delay = 0.3, rowLength = 99, finalRowY = 4, finalRowFrames = 77 }

miscItems.funnyAtlases.hareHareYukai = SMODS.Atlas({
	key = 'cir_hareHareYukai',
	path = 'Misc/hareHareYukai.png',
	px = 128,
	py = 64,
	atlas_table = 'ANIMATION_ATLAS',
	frames = 111
})

miscItems.funnyAtlases.canadaFlag = SMODS.Atlas({
	key = 'cir_Canada',
	path = 'Misc/canadaFlag.png',
	px = 40,
	py = 20
})

miscItems.otherAtlases.cardKnifeStab = SMODS.Atlas({
	key = 'cir_cardKnifeStab',
	path = 'Misc/knifeStab.png',
	px = 71,
	py = 95
})

return miscItems