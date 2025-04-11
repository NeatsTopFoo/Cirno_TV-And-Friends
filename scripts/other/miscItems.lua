local miscItems = {
	artCreditKeys = {},
	weirdArtCreditExceptionalCircumstanceKeys = {}, -- Some things seem to do weird things, like Wild cards.
	-- handsThatContainOtherHands = {},
	alphabetNumberConv = {
		numToAlphabet = {},
		alphabetToNum = {}
	},
	deckSkinNames = {}, -- How the custom deck skins are referred to internally. Used for art credit tooltips.
	deckSkinWhich = {}, -- Differentiate between different deck skins we might want to add, in case we have different crediting to do per skin.
	keysOfAllCirnoModItems = {}, -- This will be used for any effects the focus on stuff edited or introduced by this mod
	funnyAtlases = {},
	switchKeys = {},
	switchTables = {}
}

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
		cirBlue = HEX('0766EBFF'),
		cirCyan = HEX('0AD0F7FF'),
		cirLucy = HEX('7BB083FF'),
		cirNep = HEX('D066ADFF'),
		bbBlack = HEX('000000FF'),
		bbInvisText = HEX('00000000')
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
		nodes[#nodes + 1] = {
			n = G.UIT.O,
			config = { object = sprite }
		}
		
		if sprite.atlas.manualFrameParsing	then
			nodes[#nodes].config.thisObjFrameParse = copy_table(sprite.atlas.manualFrameParsing)
			nodes[#nodes].config.thisObjFrameParse.counter = 0
			CirnoMod.miscItems.manuallyAnimateAtlasItem(nodes[#nodes].config)
		elseif sprite.atlas.typewriterFrameParsing then
			nodes[#nodes].config.thisObjFrameParse = copy_table(sprite.atlas.typewriterFrameParsing)
			nodes[#nodes].config.thisObjFrameParse.counter = 0
			CirnoMod.miscItems.doTypewriterAtlasAnimation(nodes[#nodes].config)
		end
		
		return nodes[#nodes]
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
	
miscItems.isState = function(curGameState, stateToCheck)
		if
			curGameState
			and stateToCheck
		then 
			return curGameState == stateToCheck
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

miscItems.getVanillaJokerNameByKey = function(jkrKey)
	local RV = G.localization.descriptions.Joker[jkrKey].name or 'Invalid Key'
	
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
miscItems.funnyAtlases.japaneseGoblin.manualFrameParsing = { delay = 0.2 }

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
miscItems.funnyAtlases.rumiSleep.manualFrameParsing = { delay = 0.4 }

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

return miscItems