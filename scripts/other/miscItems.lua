local miscItems = {
	artCreditKeys = {},
	allFaceCards = { 'Jack', 'Queen', 'King' },
	cardRanksToValues_AceLow = {
		['King'] = 10,
		['Queen'] = 10,
		['Jack'] = 10,
		['10'] = 10,
		['9'] = 9,
		['8'] = 8,
		['7'] = 7,
		['6'] = 6,
		['5'] = 5,
		['4'] = 4,
		['3'] = 3,
		['2'] = 2,
		['Ace'] = 1
	},
	cardRanksToValues_AceHigh = {
		['Ace'] = 11,
		['King'] = 10,
		['Queen'] = 10,
		['Jack'] = 10,
		['10'] = 10,
		['9'] = 9,
		['8'] = 8,
		['7'] = 7,
		['6'] = 6,
		['5'] = 5,
		['4'] = 4,
		['3'] = 3,
		['2'] = 2
	},
	weirdArtCreditExceptionalCircumstanceKeys = {}, -- Some things seem to do weird things, like Wild cards.
	descExtensionTooltips = {},
	eDT_edScale_T = {},
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
	mlvrk_tex_keys = {},
	funnyAtlases = {},
	otherAtlases = {},
	returnToHand_Jokers = {
		'j_cir_b3313'
	},
	switchKeys = {},
	switchTables = {},
	createErrorLocTxt = function(custName) return { name = custName or 'ERROR', text = {
			'This text should {C:red}not{} be visible.',
			'If you are seeing this, please contact',
			'your local {C:dark_edition}system administrator',
			'for {C:attention}troubleshooting{}.',
			'{s:0.8,C:inactive}Seriously, this shouldn\'t be',
			'{s:0.8,C:inactive}appearing anywhere. This IS a bug.'
		} }
	end
}

miscItems.cirGunsSpriteX = 0

miscItems.keysOfJokersToUpdateStateOnLoad = {
	j_cir_arumia_l = true,
	j_cir_naro_l = true,
	j_cir_crystalTap = true,
	j_cir_b3313 = true
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
		j_cir_arumia_l = { 'using_consumeable', 'setting_blind', 'hand_drawn' },
		j_cir_b3313 = { 'modify_scoring_hand' }
	}
	
miscItems.colours = {
	cirInactiveAtt = HEX('BFB199FF'),
	cirFaintLavender = HEX('ABA3CCFF'),
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
	allegations = function(bootstrapsName) return create_badge(bootstrapsName or 'You Forgot To Pass The Name In', G.C.GREEN, G.C.UI.TEXT_LIGHT, 0.8 ) end,
	TwoMax = function() return create_badge("2 Max", miscItems.colours.cirNep, G.C.UI.TEXT_LIGHT, 0.8) end,
	cirGuns = function() return create_badge("cirGuns", miscItems.colours.cirCyan, G.C.UI.TEXT_LIGHT, 0.8 ) end,
	crazyWomen = function() return create_badge("Crazy Women", G.C.RED, G.C.UI.TEXT_LIGHT, 0.8 ) end
}

miscItems.addBadgesToJokerByKey = function(badgesTable, jkrKey, extArg)
	for k, g in pairs(CirnoMod.miscItems.jkrKeyGroups) do
		if
			g[jkrKey]
			and CirnoMod.miscItems.badges[k]
		then
			badgesTable[#badgesTable+1] = CirnoMod.miscItems.badges[k](extArg)
		end
	end
end

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

miscItems.addJokerToTableIfDiscovered = function(t, joker)
	if joker.discovered then
		table.insert(t, joker)
	end
end

miscItems.addJokerToTableIfEncountered = function(t, joker)
	if CirnoMod.miscItems.hasEncounteredJoker(joker.key) then
		table.insert(t, joker)
	end
end

miscItems.doTitleCardCycle = function(viable_unlockables, cardIn, SC_scale)	
	if #viable_unlockables == 0 then
		for k, v in ipairs(G.P_CENTERS) do
			if
				(v.set == 'Voucher'
				or v.set == 'Tarot'
				or v.set == 'Planet'
				or v.set == 'Spectral'
				or v.set == 'Enhanced'
				or v.set == 'Joker')
				and v.discovered
				and not v.demo
			then
				viable_unlockables[#viable_unlockables+1] = v
			end
		end
	else
		CirnoMod.miscItems.addJokerToTableIfDiscovered(viable_unlockables, G.P_CENTERS.j_blueprint)
		
		CirnoMod.miscItems.addJokerToTableIfDiscovered(viable_unlockables, G.P_CENTERS.j_egg)
		
		if CirnoMod.miscItems.jkrKeyGroups.fingerGuns then
			for k, b in pairs (CirnoMod.miscItems.jkrKeyGroups.fingerGuns) do
				if
					k == 'j_ring_master'
					or CirnoMod.miscItems.hasEncounteredJoker(k)
				then
					CirnoMod.miscItems.addJokerToTableIfDiscovered(viable_unlockables, G.P_CENTERS[k])
				end
			end
		end
		
		if CirnoMod.miscItems.jkrKeyGroups.allegations then
			for k, b in pairs (CirnoMod.miscItems.jkrKeyGroups.allegations) do
				CirnoMod.miscItems.addJokerToTableIfEncountered(viable_unlockables, G.P_CENTERS[k])
			end
		end
		
		local jkrKeys_AddIfEncountered = {
			'j_joker',
			'j_mime',
			'j_credit_card',
			'j_duo',
			'j_family',
			'j_mr_bones',
			'j_smiley',
			'j_caino',
			'j_triboulet',
			'j_yorick',
			'j_chicot',
			'j_perkeo',
		}
		
		if CirnoMod.config.addCustomJokers then
			if G.P_CENTERS.j_cir_crazyFace.unlocked then
				table.insert(viable_unlockables, G.P_CENTERS.j_cir_crazyFace)
			end
			
			jkrKeys_AddIfEncountered = SMODS.merge_lists({ jkrKeys_AddIfEncountered, {
				'j_cir_cirno_l',
				'j_cir_nope_l',
				'j_cir_naro_l',
				'j_cir_arumia_l',
				'j_cir_houdini_l',
				'j_cir_wolsk_l',
				'j_cir_demeorin_l'
			} })
		end
		
		for i, k in ipairs (jkrKeys_AddIfEncountered) do
			CirnoMod.miscItems.addJokerToTableIfEncountered(viable_unlockables, G.P_CENTERS[k])
		end
	end
	
	viable_unlockables = SMODS.merge_lists({ viable_unlockables, {
		{ set = 'Playing', key = "C_K", suit = 'Clubs', skin = "cir_noAndFriends_Clubs_skin_hc" },
		{ set = 'Playing', key = "C_Q", suit = 'Clubs', skin = "cir_noAndFriends_Clubs_skin_hc" },
		{ set = 'Playing', key = "C_J", suit = 'Clubs', skin = "cir_noAndFriends_Clubs_skin_hc" },
		
		{ set = 'Playing', key = "D_K", suit = 'Diamonds', skin = "cir_noAndFriends_Diamonds_skin_hc" },
		{ set = 'Playing', key = "D_Q", suit = 'Diamonds', skin = "cir_noAndFriends_Diamonds_skin_hc" },
		{ set = 'Playing', key = "D_Q", suit = 'Diamonds', skin = "cir_noAndFriends_Diamonds_skin_hc" },
		{ set = 'Playing', key = "D_Q", suit = 'Diamonds', skin = "cir_noAndFriends_Diamonds_skin_hc" },
		--[[ Bias towards my kamioshi? No wayyyy
		(...Again, no. Not possessive 'my'.)]]
		{ set = 'Playing', key = "D_J", suit = 'Diamonds', skin = "cir_noAndFriends_Diamonds_skin_hc" },
		
		{ set = 'Playing', key = "H_K", suit = 'Hearts', skin = "cir_noAndFriends_Hearts_skin_hc" },
		{ set = 'Playing', key = "H_Q", suit = 'Hearts', skin = "cir_noAndFriends_Hearts_skin_hc" },
		{ set = 'Playing', key = "H_J", suit = 'Hearts', skin = "cir_noAndFriends_Hearts_skin_hc" },
		
		{ set = 'Playing', key = "S_K", suit = 'Spades', skin = "cir_noAndFriends_Spades_skin_hc" },
		{ set = 'Playing', key = "S_Q", suit = 'Spades', skin = "cir_noAndFriends_Spades_skin_hc" },
		{ set = 'Playing', key = "S_J", suit = 'Spades', skin = "cir_noAndFriends_Spades_skin_hc" }
	} })
	
	local holdUntilNew = false
	local texPack_ProbablyNotActive = false
	local lastFive = {}
	local existingCard = cardIn or CirnoMod.titleCard
	local newCard
	local doRandomEdition = false
	
	local isInLastFive = function(decidedElement)
			if #lastFive > 0 then
				for i = 1, #lastFive do
					if lastFive[i] == decidedElement.key then
						return true
					end
				end
			end
			
			return false
		end
	
	local cycleEvent
	cycleEvent = Event({
		trigger = 'after',
		timer = 'UPTIME',
		delay = 20,
		blockable = false,
		blocking = false,
		func = function()
			if not CirnoMod.miscItems.isStage(G.STAGE, G.STAGES.MAIN_MENU) then
				return true
			end
			
			if holdUntilNew or texPack_ProbablyNotActive then
				cycleEvent.start_timer = false
				return false
			end
			
			G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 4.04,
                func = (function()
					if not CirnoMod.miscItems.isStage(G.STAGE, G.STAGES.MAIN_MENU) then
						return true
					end
					
					local decidedElement = pseudorandom_element(viable_unlockables)
					
					for i = 1, 5 do						
						if not isInLastFive(decidedElement) then
							if decidedElement.set == 'Playing' then
								if G.SETTINGS.CUSTOM_DECK.Collabs[decidedElement.suit] == decidedElement.skin then
									texPack_ProbablyNotActive = false
									break
								end
							else
								if
									decidedElement.set == 'Joker'
									and decidedElement.unlocked
									and (decidedElement.atlas
									or (decidedElement.config
									and decidedElement.config.center
									and decidedElement.config.center.atlas))
								then
									if CirnoMod.miscItems.atlasCheck(decidedElement) then
										texPack_ProbablyNotActive = false
										break
									else
										texPack_ProbablyNotActive = true
										if i >= 5 then
											return false
										end
									end
								else
									texPack_ProbablyNotActive = false
									break
								end
							end
						end
						
						decidedElement = pseudorandom_element(viable_unlockables)
					end
					
					if decidedElement.set == 'Playing' then
						newCard = Card(CirnoMod.titleTop.T.x, CirnoMod.titleTop.T.y, 1.2*G.CARD_W*SC_scale, 1.2*G.CARD_H*SC_scale, G.P_CARDS[decidedElement.key], G.P_CENTERS.c_base)
						
						if decidedElement.key == 'D_Q' then
							doRandomEdition = 'dm'
						else
							doRandomEdition = 'nrm'
						end
					else
						newCard = Card(CirnoMod.titleTop.T.x, CirnoMod.titleTop.T.y, 1.2*G.CARD_W*SC_scale, 1.2*G.CARD_H*SC_scale, nil, decidedElement or self.P_CENTERS.j_blueprint)
												
						if decidedElement.key == 'j_caino' then
							doRandomEdition = 'dm'
						elseif decidedElement.discovered then
							doRandomEdition = 'nrm'
						else
							doRandomEdition = nil
						end
					end
					
					if decidedElement.key ~= 'D_Q' then -- No problem here, move along
						table.insert(lastFive, decidedElement.key)
					end
					
					if #lastFive > 5 then
						table.remove(lastFive, 1)
					end
					
					if decidedElement.set == 'Playing' then
						newCard.no_ui = true
					elseif not decidedElement.unlocked then
						newCard.no_ui = false
					else
						newCard.no_ui = #viable_unlockables > 0
						and not CirnoMod.miscItems.hasEncounteredJoker(decidedElement.key)
					end
                    
                    newCard.states.visible = false
                    existingCard.parent = nil
                    existingCard:start_dissolve({G.C.BLACK, G.C.ORANGE, G.C.RED, G.C.GOLD})
					
					if existingCard.edition then
						existingCard:set_edition(nil, true, true)
					end
					
                    return true
            end)}))
			
			G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 1.04,
                func = (function()
					if not CirnoMod.miscItems.isStage(G.STAGE, G.STAGES.MAIN_MENU) then
						return true
					end
					
					if texPack_ProbablyNotActive then
						return false
					end
					
                    newCard:start_materialize()
                    CirnoMod.titleTop:emplace(newCard)
					existingCard = newCard
					newCard = nil
					
					if doRandomEdition == 'dm' and pseudorandom('dmEdition', 1, 2) < 2 then
						existingCard:set_edition(poll_edition('dmEdition', 1, false, true), true)
					elseif doRandomEdition == 'nrm' then
						existingCard:set_edition(poll_edition('titleCard_edition'), true)
					end
					
					holdUntilNew = false
                    return true
            end)}))
			
			holdUntilNew = true
			cycleEvent.start_timer = false
			return false
		end })
	
	G.E_MANAGER:add_event(cycleEvent)
end

miscItems.flippyFlip = {
	fStart = function(card, pitchPercent)
		local percent = pitchPercent and math.max(pitchPercent - 0.09, 0.5) or 1
		
		G.E_MANAGER:add_event(Event({
			trigger = 'after',
			delay = 0.1,
			blocking = true,
			blockable = true,
			func = function()
				card:flip();play_sound('card1', percent);card:juice_up(0.3, 0.3);return true 
			end }))
		
		pitchPercent = percent
	end,
	
	fEnd = function(card, pitchPercent)
		local percent = pitchPercent and math.max(pitchPercent - 0.09, 0.5) or 1
		
		G.E_MANAGER:add_event(Event({
			trigger = 'after',
			delay = 0.15,
			blocking = true,
			blockable = true,
			func = function()
				card:flip();play_sound('tarot2', percent, 0.6);card:juice_up(0.3, 0.3);return true
			end }))
		
		pitchPercent = percent
	end
}

miscItems.pullEditionModifierValue = function(edition)
	if edition.type == 'foil' then
		return edition.chips
	elseif edition.type == 'holo' then
		return edition.mult
	elseif edition.type == 'polychrome' then
		return edition.x_mult
	end
	return nil
end

miscItems.scaleEdition_FHP = function(card, scalar)
	if card.edition.type == 'foil' then
		card.edition.chips = card.edition.chips + 50 * scalar
	elseif card.edition.type == 'holo' then
		card.edition.mult = card.edition.mult + 10 * scalar
	elseif card.edition.type == 'polychrome' then
		card.edition.x_mult = card.edition.x_mult + 0.5 * scalar
	end
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

miscItems.isNegativePlayingCard = function(card)
	return (card
		and card.edition
		and card.edition.type == 'negative'
		and (card.ability.set == 'Default'
		or card.ability.set == 'Enhanced'))
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
		return curGameStage == stageToCheck
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
		j_riff_raff = true,
		j_trading = true
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
	miscItems.jkrKeyGroups.crazyWomen.j_flash = true
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
				CirnoMod.config.encounteredJokers[G.SETTINGS.profile]
				and CirnoMod.config.encounteredJokers[G.SETTINGS.profile][k]
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
		if not CirnoMod.config.encounteredJokers[G.SETTINGS.profile][jkrKey] then
			CirnoMod.config.encounteredJokers[G.SETTINGS.profile][jkrKey] = 0
		end
		
		CirnoMod.config.encounteredJokers[G.SETTINGS.profile][jkrKey] = CirnoMod.config.encounteredJokers[G.SETTINGS.profile][jkrKey] + 1
		return true
	end
	
	return false
end

miscItems.hasEncounteredJoker = function(jkrKey)
	if
		CirnoMod.config.encounteredJokers
		and CirnoMod.config.encounteredJokers[G.SETTINGS.profile]
		and CirnoMod.config.encounteredJokers[G.SETTINGS.profile][jkrKey]
	then
		return CirnoMod.config.encounteredJokers[G.SETTINGS.profile][jkrKey] > 0
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

miscItems.atlasCheck = function(card)
	return CirnoMod.miscItems.mlvrk_tex_keys[card.atlas]
		or (card.config and card.config.center
		and CirnoMod.miscItems.mlvrk_tex_keys[card.config.center.atlas])
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

SMODS.DrawStep{
	key = 'cir_knifeStab',
	order = 52,
	func = function(card, layer)
		if
			card
			and card.children.knifeSprite
			and card.mitaKill
		then
			card.children.knifeSprite:draw_shader('dissolve', nil, nil, nil, card.children.center)
		end
	end,
	conditions = { vortex = false, facing = 'front' }
}

return miscItems