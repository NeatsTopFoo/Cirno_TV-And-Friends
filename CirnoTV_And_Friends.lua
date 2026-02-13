local cMod_SMODSLoc = SMODS.find_mod("CTVaF")[1]

cMod_SMODSLoc.optional_features = function()
	return {
		retrigger_joker = true,
		post_trigger = true
	}
end

SMODS.Sound:register_global()

CirnoMod = {}
CirnoMod.id = cMod_SMODSLoc.id
CirnoMod.path = cMod_SMODSLoc.path
CirnoMod.config = cMod_SMODSLoc.config

CirnoMod.miscItems = assert(SMODS.load_file("scripts/other/miscItems.lua"))()

--[[ My understanding of the way Talisman works is
that you have to run every major component of a
numerical calculation through its to_big() function.
To support that while retaining functionality when
Talisman isn't installed, you make a dummy function
with the same name. This just returns what is input
if Talisman's to_big() doesn't exist, but if Talisman
is around, then it defaults io its to_big().
This way, you can just run everything through to_big()
and it will work.
...It's very stupid. It's also the second best
solution. The first best solution is to mark Talisman
as a conflicting mod and wait until Talisman implements
a better method :^)
But people have been asking me about Talisman compatibility,
so this... Shooould work? For now? I hope? This mod
is primarily just a texture pack in the first place,
so]]
to_big = to_big or function(x) return x end

if
	#SMODS.find_mod("soj") > 0
then
	CirnoMod.miscItems.otherModPresences.isSealsOnJokersPresent = true
end

CirnoMod.miscItems.getLocColour = function(colourNameStr, defaultColourStr)
	if CirnoMod.miscItems.colours[colourNameStr] then
		return colourNameStr
	end
	return defaultColourStr
end

--[[ Hook into localise colour and interposes
with detection for our own custom colours.]]
local old_loc_colour = loc_colour
function loc_colour(_c, _default)
	if CirnoMod.miscItems.colours[_c] then
		return CirnoMod.miscItems.colours[_c]
	end
	return old_loc_colour(_c, _default)
end

--[[
This is what the new cycle option calls when it's cycled
Yes, it HAS to be in G.FUNCS.]]
G.FUNCS.cir_CycMatureReferencesVal = function(e)
	CirnoMod.config.matureReferences_cyc = e.to_key
end

local cirInitConfig = {
	-- Mature reference level is now determined within each Joker.
	customJokers = {
		'customCommons',
		'customUncommons',
		'customRares',
		'customUpgradeds',
		'customLegendaries'
	},
	customConsumables = {
		'customSpectrals'
	},
	-- Mature reference level is now determined within each Challenge.
	additionalChallenges = {
		'jokerStencils'
	}
}

--[[
Defines Steamodded mod menu config & extra tabs
See the files for more info.]]
cMod_SMODSLoc.config_tab = assert(SMODS.load_file("scripts/UI_bs/steamodded_mod_menu/config_ui.lua"))()

cMod_SMODSLoc.extra_tabs = assert(SMODS.load_file("scripts/UI_bs/steamodded_mod_menu/additional_mod_tabs.lua"))()

--[[
Change title screen logo to mod's logo & replace the ace that appears first with the blueprint joker (If the setting is enabled)
Has corresponding patcher code in the lovely.toml]]
if CirnoMod.config.titleLogo then
	-- Replaces the Ace that appears at start with the Blueprint Joker.
	G.TITLE_SCREEN_CARD = 'j_blueprint'
	
	-- Title Screen Logo Texture
	SMODS.Atlas {
		key = "balatro",
		path = "Vanilla_Replacements/cir_BalatroLogo.png",
		px = 333,
		py = 216,
		prefix_config = { key = false }
	}
else
	-- Necessary for the below
	G.TITLE_SCREEN_CARD = G.P_CARDS.S_A
end

-- These three are necessary function definition for above
-- title screen replacement stuff to both actually facilitate
-- the replacement and also make it not error because I'm giving it a string instead
function G.FUNCS.title_screen_card(self, SC_scale)
	if type(G.TITLE_SCREEN_CARD) == "table" then
			return Card(self.title_top.T.x, self.title_top.T.y, 1.2*G.CARD_W*SC_scale, 1.2*G.CARD_H*SC_scale, G.TITLE_SCREEN_CARD, G.P_CENTERS.c_base)
		elseif type(G.TITLE_SCREEN_CARD) == "string" then
			return  Card(self.title_top.T.x, self.title_top.T.y, 1.2*G.CARD_W*SC_scale, 1.2*G.CARD_H*SC_scale, G.P_CARDS.empty, G.P_CENTERS[G.TITLE_SCREEN_CARD])
		else
			return Card(self.title_top.T.x, self.title_top.T.y, 1.2*G.CARD_W*SC_scale, 1.2*G.CARD_H*SC_scale, G.P_CARDS.S_A, G.P_CENTERS.c_base)
	end
end

function G.FUNCS.center_splash_screen_card(SC_scale)
	return Card(G.ROOM.T.w/2 - SC_scale*G.CARD_W/2, 10. + G.ROOM.T.h/2 - SC_scale*G.CARD_H/2, SC_scale*G.CARD_W, SC_scale*G.CARD_H, G.P_CARDS.empty, G.P_CENTERS['j_joker'])
end

function G.FUNCS.splash_screen_card(card_pos, card_size)
	return Card(card_pos.x + G.ROOM.T.w/2 - G.CARD_W*card_size/2,
				card_pos.y + G.ROOM.T.h/2 - G.CARD_H*card_size/2,
				card_size*G.CARD_W, card_size*G.CARD_H, pseudorandom_element(G.P_CARDS), G.P_CENTERS.c_base)
end

CirnoMod.quittingIsAnOption = function()
	local ret = nil
	
	if CirnoMod.config.quittingIsAnOption then
		ret = {n=G.UIT.ROOT, config={align = "cm", padding = 0.05, colour = G.C.CLEAR}, nodes={ {
			n = G.UIT.C,
			config = { align = "cm" },
			nodes = {{
				n = G.UIT.R,
				config = { align = "cm" },
				nodes = {
					create_option_cycle({label = localize('b_set_gamespeed'),scale = 0.8, options = {0.5, 1, 2, 4}, opt_callback = 'change_gamespeed', current_option = (G.SETTINGS.GAMESPEED == 0.5 and 1 or G.SETTINGS.GAMESPEED == 4 and 4 or G.SETTINGS.GAMESPEED + 1)}),
					
					create_option_cycle({w = 5, label = localize('b_set_play_discard_pos'),scale = 0.8, options = localize('ml_play_discard_pos_opt'), opt_callback = 'change_play_discard_position', current_option = (G.SETTINGS.play_button_pos)}),
					
					G.F_RUMBLE and create_toggle({label = localize('b_set_rumble'), ref_table = G.SETTINGS, ref_value = 'rumble'}) or nil,
					
					create_slider({label = localize('b_set_screenshake'),w = 4, h = 0.4, ref_table = G.SETTINGS, ref_value = 'screenshake', min = 0, max = 100}),
					
					create_toggle({label = localize('ph_display_stickers'), ref_table = G.SETTINGS, ref_value = 'run_stake_stickers'}),
					
					create_toggle({label = localize('b_high_contrast_cards'), ref_table = G.SETTINGS, ref_value = 'colourblind_option', callback = G.FUNCS.refresh_contrast_mode}),
					
					create_toggle({label = localize('b_reduced_motion'), ref_table = G.SETTINGS, ref_value = 'reduced_motion'}),
					
					G.F_CRASH_REPORTS and create_toggle({label = localize('b_set_crash_reports'), ref_table = G.SETTINGS, ref_value = 'crashreports', info = localize('ml_crash_report_info')}) or nil,
					
					{
						n = G.UIT.R, -- Spacer wrapper
						config = {
							r = 0.1,
							padding = 0.0,
							align = 'tm',
							colour = G.C.CLEAR
						},
						nodes = {
							{
								-- Spacer
								n = G.UIT.B,
								config = {
									colour = G.C.CLEAR,
									w = 0.05,
									h = 0.35
								}
							}
						}
					},
					
					UIBox_button{button = 'quit', colour = G.C.RED, label = {localize('b_quit_cap')}, scale = 0.7}
			}}}}
		}}
	end
	
	return ret
end

--[[
Hate. Hate. Hate. Hate that we have to do this this
way. Hatehatehatehatehate. I had a whole system set
up and I had to tear it right down because apparently
that's not how that fucking works and we need to do
this bullshit this way because we can't easily insert
thing into the other thing and do that thing and I'm
onna scream, I'M CRASHING OUT AAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
...See the patcher toml and localization/en-us.lua
for more info. Though for your sanity, it's probably
best not to.]]
CirnoMod.ParseVanillaCredit = function(card, specific_vars)
	if
		card.fake_card
		or (not specific_vars
		or not specific_vars.playing_card)
		and not CirnoMod.miscItems.atlasCheck(card)
	then
		return nil
	end

	--[[ Comes in from generate_card_ui() in common_events.lua,
	which passes in _c and specific_vars (After checking if the
	specified card isn't locked or undiscovered)]]
	local RV = nil
	local keyToCheck = card.key
	
	if
		specific_vars -- This is nil when it's a Joker, but needed when its a playing card
		and G.SETTINGS.CUSTOM_DECK -- Sanity check to make sure this is initialised
	then
		if
			G.SETTINGS.CUSTOM_DECK.Collabs -- Another sanity check
			and specific_vars.playing_card -- These are edge cases where specific_vars is passed and not nil, but these values aren't present.
			and specific_vars.suit
			and specific_vars.value
		then
			if
				G.SETTINGS.CUSTOM_DECK.Collabs[specific_vars.suit] == CirnoMod.miscItems.deckSkinNames[specific_vars.suit]
				and CirnoMod.miscItems.deckSkinWhich[G.SETTINGS.CUSTOM_DECK.Collabs[specific_vars.suit]]
			then
				keyToCheck = CirnoMod.miscItems.deckSkinWhich[G.SETTINGS.CUSTOM_DECK.Collabs[specific_vars.suit]].."_"..specific_vars.value.."_"..specific_vars.suit
			else
				
			end
		end
	end
	
	--[[
	If the key is present in the table of art keys,
	return the necessary localisation data
	Not the best way to facilitate this, but eh.]]
	if CirnoMod.miscItems.artCreditKeys[keyToCheck] then
		if type(CirnoMod.miscItems.artCreditKeys[keyToCheck]) == 'table' then
			if
				CirnoMod.config.planetsAreHus
				and CirnoMod.miscItems.artCreditKeys[keyToCheck].planetsAreHus
			then
				RV = { key = CirnoMod.miscItems.artCreditKeys[keyToCheck].planetsAreHus, set = 'Other' }
			elseif
				CirnoMod.config.matureReferences_cyc == 3
				and CirnoMod.miscItems.artCreditKeys[keyToCheck].nrmVer
			then
				RV = { key = CirnoMod.miscItems.artCreditKeys[keyToCheck].nrmVer, set = 'Other' }
			elseif
				CirnoMod.config.matureReferences_cyc >= 2
				and CirnoMod.miscItems.artCreditKeys[keyToCheck].saferVer
			then
				RV = { key = CirnoMod.miscItems.artCreditKeys[keyToCheck].saferVer, set = 'Other' }
			elseif CirnoMod.miscItems.artCreditKeys[keyToCheck].default then
				RV = { key = CirnoMod.miscItems.artCreditKeys[keyToCheck].default, set = 'Other' }
			end
		else
			RV = { key = CirnoMod.miscItems.artCreditKeys[keyToCheck], set = 'Other' }
		end
	end
	
	return RV
end

--[[ Unneeded for now, but may be investigated should a new, similar issue arise that this functionality can solve.
CirnoMod.miscItems.weirdArtCreditExceptionalCircumstanceKeys.m_gold = function(card, loc_vars, specific_vars, info_queue, card_type, badges, main_start, main_end)
	info_queue[#info_queue + 1] = { key = 'blankTooltipA', set = 'Other', replace_base_card = true }
end
]]

-- Load vanilla replacements definitions and puts its returned var into the var.
CirnoMod.replaceDef = assert(SMODS.load_file("Cir_Vanilla_Replacement_Definition.lua"))()

-- Playing Card Textures
if CirnoMod.config.playingCardTextures then
	-- Runs the lua only if the setting is enabled in Steamodded mod config.
	assert(SMODS.load_file("scripts/retextures/PlayingCards_Retext.lua"))()
end

-- Texture Pack
if CirnoMod.config.malverkReplacements then
	-- Runs the Lua that handles everything in the texture pack.
	SMODS.load_file("scripts/retextures/Malverk_Texture_Replacements.lua")()
end

assert(SMODS.load_file("scripts/other/extDescTooltips.lua"))()

local dependencyCheck = function(additionInfo_)
	if
		additionInfo_.dependenciesForAddition
		and type(additionInfo_.dependenciesForAddition) == 'function'
	then
		return additionInfo_.dependenciesForAddition()
	else
		return true
	end
end

-- Additional Custom Jokers
if CirnoMod.config.addCustomJokers then
	local jkrLoadTable = {}
	
	table.insert(CirnoMod.miscItems.jkrLoadOrder, 'cmn')
	table.insert(CirnoMod.miscItems.jkrLoadOrder, 'upgCmn')
	
	table.insert(CirnoMod.miscItems.jkrLoadOrder, 'uncmn')
	table.insert(CirnoMod.miscItems.jkrLoadOrder, 'upgUncmn')
	
	table.insert(CirnoMod.miscItems.jkrLoadOrder, 'rare')
	table.insert(CirnoMod.miscItems.jkrLoadOrder, 'upgRare')
	
	table.insert(CirnoMod.miscItems.jkrLoadOrder, 'lgnd')
	table.insert(CirnoMod.miscItems.jkrLoadOrder, 'upgLgnd')
	
	-- Iterates through all lua files in scripts\additions\jokers\ and SMODS.load_file them.
	for i, Jkr in ipairs (cirInitConfig.customJokers) do
		-- Runs the lua and puts its returned var into the var.
		local jokerInfo = assert(SMODS.load_file('scripts/additions/jokers/'..Jkr..".lua"))()
		local loadAtlas = true
		
		if
			dependencyCheck(jokerInfo)
			and ((jokerInfo.matureRefLevel or 3) <= CirnoMod.config.matureReferences_cyc
			or jokerInfo.isMultipleJokers)
		then
			if
				-- Atlas definition is required. No atlas, get out.
				jokerInfo.atlasInfo
				and
				-- Checking for valid structure before proceeding
				(
					jokerInfo.jokerConfig -- Either this for individual jokers
					or
					(jokerInfo.isMultipleJokers and jokerInfo.jokerConfigs) -- Or this for multiple jokers in one.
					--[[
					Yes, I could do just checking for either config singular or config plural
					but that makes this confusable at a quick glance since they're similar.
					Could ultimately name them something else, but then you run into stuff
					like "well how do you read back through this," etc. etc. It looks stupid,
					but when you stop and think about it, it makes sense. It's clunky, yes, but
					it makes sense.]]
				)
			then
				if jokerInfo.isMultipleJokers then
					loadAtlas = false -- No point in loading the Atlas if all the jokers in the file's mature ref levels are higher than the current setting.
					
					for i_, JkrChk in ipairs (jokerInfo.jokerConfigs) do
						loadAtlas = (dependencyCheck(JkrChk) and JkrChk.matureRefLevel <= CirnoMod.config.matureReferences_cyc)
						
						if loadAtlas then
							break
						end
					end
				end
				
				if loadAtlas then
					SMODS.Atlas(jokerInfo.atlasInfo)
				end
				
				--[[ For parsing other circumstances under
				which a joker shouldn't be added]]
				local jkr_shouldAdd = true
				
				if jokerInfo.isMultipleJokers then
					for iI_, Jkr_ in ipairs (jokerInfo.jokerConfigs) do
						jkr_shouldAdd = dependencyCheck(Jkr_)
						
						if
							Jkr_.shouldAdd
							and type(Jkr_.shouldAdd) == 'function'
						then
							jkr_shouldAdd = Jkr_.shouldAdd()
						end
						
						if
							jkr_shouldAdd
							and Jkr_.matureRefLevel <= CirnoMod.config.matureReferences_cyc
						then
							
							if
								Jkr_.loadOrder
								and type(Jkr_.loadOrder) == 'string'
							then
								if not jkrLoadTable[Jkr_.loadOrder] then
									jkrLoadTable[Jkr_.loadOrder] = {}
								end
								
								table.insert(jkrLoadTable[Jkr_.loadOrder], Jkr_)
							else
								SMODS.Joker(Jkr_)
							end
							
							table.insert(CirnoMod.miscItems.keysOfAllCirnoModItems, 'j_cir_'..Jkr_.key)
						end
					end
				else
					if
						jokerInfo.jokerConfig.shouldAdd
						and type(jokerInfo.jokerConfig.shouldAdd) == 'function'
					then
						jkr_shouldAdd = jokerInfo.jokerConfig.shouldAdd()
					end
					
					if jkr_shouldAdd then
						if
							jokerInfo.jokerConfig.loadOrder
							and type(jokerInfo.jokerConfig.loadOrder) == 'string'
						then
							if not jkrLoadTable[jokerInfo.jokerConfig.loadOrder] then
								jkrLoadTable[jokerInfo.jokerConfig.loadOrder] = {}
							end
							
							table.insert(jkrLoadOrder[jokerInfo.jokerConfig.loadOrder], jokerInfo.jokerConfig)
						else
							SMODS.Joker(jokerInfo.jokerConfig)
						end
					
						table.insert(CirnoMod.miscItems.keysOfAllCirnoModItems, 'j_cir_'..jokerInfo.jokerConfig.key)
					end
				end
			end
		end	
	end
	
	for i, tbl in ipairs(CirnoMod.miscItems.jkrLoadOrder) do
		if jkrLoadTable[tbl] and #jkrLoadTable[tbl] > 0 then
			for i, _jkr in ipairs(jkrLoadTable[tbl]) do
				SMODS.Joker(_jkr)
			end
		end
	end
	
end
	
--[[ Hooks into the normal calculate_seal()
to facilitate Red Seal Joker functionality
and deal with instances of ]]
local oldSealCalc = Card.calculate_seal
function Card:calculate_seal(context)
	if
		self.debuff
	then
		return nil
	end
	
	if
		self.ability
		and self.ability.set == 'Joker'
		and self.seal == 'Red'
	then
		if
			self == context.other_card
			and context.retrigger_joker_check
			and not context.retrigger_joker
		then
			local stopEvalling = false
			
			if 
				context.other_ret
				and context.other_ret.jokers
			then
				if context.other_ret.jokers.balance then
					stopEvalling = true
				elseif context.other_ret.jokers.doNotRedSeal then
					if type(context.other_ret.jokers.doNotRedSeal) == 'function' then
						stopEvalling = context.other_ret.jokers.doNotRedSeal()
					else
						stopEvalling = true
					end
				end
			end
			
			if
				stopEvalling
				or (self.config.center.jkr_shouldSkipRedSeal
				and type(self.config.center.jkr_shouldSkipRedSeal) == 'function'
				and self.config.center:jkr_shouldSkipRedSeal(context, self))
			then				
				return nil
			end
			
			local ret = { repetitions = 1 }
			
			if
				context.other_ret
				and context.other_ret.jokers
				and context.other_ret.jokers.suppressRetriggerMessage
			then
				ret.remove_default_message = true
			end
			
			if
				CirnoMod.miscItems.redSealRetriggerIgnoreTable[self.config.center.key]
			then
				local allowRedSeal = true
				
				for i, cntxt in ipairs (CirnoMod.miscItems.redSealRetriggerIgnoreTable[self.config.center.key]) do
					if
						context[cntxt]
						or cntxt == 'any'
						or (context.other_context
						and context.other_context[cntxt])
					then
						allowRedSeal = false
						break
					end
				end
				
				if
					allowRedSeal
				then
					return ret
				else
					return nil
				end
			else						
				return ret
			end
		end
		
		return nil
	end
	
	return oldSealCalc(self, context)
end

if
	CirnoMod.miscItems.otherModPresences.isSealsOnJokersPresent == false
then
	-- Fix for a weird-interaction with red seal on Mail-In Rebate
	SMODS.Joker:take_ownership('mail', {
			calculate = function(self, card, context)
				if
					context.discard
					and not context.other_card.debuff
					and (context.other_card:get_id() == G.GAME.current_round.mail_card.id)
				then
					return {
						dollars = to_big(card.ability.extra),
						colour = G.C.MONEY,
						card = card
					}
				end
			end
		}, true )
	
	-- Fix for red seal not doing the reroll message on flash card, thanks to Somethingcom515
	SMODS.Joker:take_ownership('j_flash', {
        calculate = function(self, card, context)
            if context.reroll_shop and not context.blueprint then
                SMODS.scale_card(card, {
                    ref_table = card.ability,
                    ref_value = 'mult',
                    scalar_value = 'extra',
                    no_message = true
                })
                return {
                    message = localize({type = 'variable', key = 'a_mult', vars = {card.ability.extra}}),
                    colour = G.C.MULT,
                }
            end
        end
    }, true)
end

-- Additional Custom Consumables
if CirnoMod.config.addCustomConsumables then
	for i, Csnm in ipairs (cirInitConfig.customConsumables) do
		-- Runs the lua and puts its returned var into the var.
		local cnsmInfo = assert(SMODS.load_file('scripts/additions/consumables/'..Csnm..".lua"))()
		local loadAtlas = true
		
		if
			(dependencyCheck(cnsmInfo)
			and (cnsmInfo.matureRefLevel or 3) <= CirnoMod.config.matureReferences_cyc)
			or cnsmInfo.isMultipleConsumables
		then
			if
				cnsmInfo.atlasInfo
				and
				(
					cnsmInfo.cnsmConfig
					or
					(cnsmInfo.isMultipleConsumables and cnsmInfo.cnsmConfigs)
					-- Same as joker setup
				)
			then
				if cnsmInfo.isMultipleConsumables then
					loadAtlas = false
					
					for i_, CnsmChk in ipairs (cnsmInfo.cnsmConfigs) do
						loadAtlas = (dependencyCheck(CnsmChk) and CnsmChk.matureRefLevel <= CirnoMod.config.matureReferences_cyc)
						
						if loadAtlas then
							break
						end
					end
				end
				
				if loadAtlas then
					SMODS.Atlas(cnsmInfo.atlasInfo)
				end
				
				if cnsmInfo.isMultipleConsumables then
					for iI_, Cnsm_ in ipairs (cnsmInfo.cnsmConfigs) do
						if
							dependencyCheck(Cnsm_)
							and Cnsm_.matureRefLevel <= CirnoMod.config.matureReferences_cyc
						then
							SMODS.Consumable(Cnsm_)
							
							table.insert(CirnoMod.miscItems.keysOfAllCirnoModItems, 'c_cir_'..Cnsm_.key)
						end
					end
				else
					SMODS.Consumable(cnsmInfo.cnsmConfig)
				
					table.insert(CirnoMod.miscItems.keysOfAllCirnoModItems, 'c_cir_'..cnsmInfo.cnsmConfig.key)
				end
			end
		end
	end
end

--[[ Negative playing card rebalance is optional:
Makes Negative always score when played like
Splash or Stone card, while also adjusting
card copying to prevent the propagation of
Negative across playing cards. ]]
if CirnoMod.config.negativePCardsBalancing then
	-- Adjusts Negative to make it always score.
	SMODS.Edition:take_ownership('negative', {
		always_scores = true 
	}, true)
	
	--[[ Rewrites copy_card() to strip Negative if the
	copied playing card was Negative ]]
	local oldCopyCard = copy_card
	copy_card = function(other, new_card, card_scale, playing_card, strip_edition)
		local returnCard = oldCopyCard(other, new_card, card_scale, playing_card, strip_edition)
		
		if CirnoMod.miscItems.isNegativePlayingCard(returnCard) then
			returnCard:set_edition(nil, true, true)
		end
		
		return returnCard
	end
	
	--[[ Adjusts DNA's description to account for the
	fact that Negative is removed from the copies. ]]
	SMODS.Joker:take_ownership('dna', {
		create_main_end = function()
			local RT = {{
					n = G.UIT.C,
					config = {
						align = 'bm',
						padding = 0.02
					},
					nodes = {}
				}}
				
			CirnoMod.miscItems.addUITextNode(RT[1].nodes,
				"(Removes ",
				G.C.UI.TEXT_INACTIVE,
				0.9)
			
			CirnoMod.miscItems.addUITextNode(RT[1].nodes,
				"Negative",
				G.C.DARK_EDITION,
				0.9)
			
			CirnoMod.miscItems.addUITextNode(RT[1].nodes,
				" from copy)",
				G.C.UI.TEXT_INACTIVE,
				0.9)
					
			return RT
		end,
		
		loc_vars = function(self, info_queue, card)
			local ret = {}
		
			info_queue[#info_queue + 1] = { key = 'e_negative_playing_card',
				set = 'Edition',
				config = { extra = 1 },
				vars = { 1,
					G.localization.descriptions.Joker.j_splash.name,
					string.sub(G.localization.descriptions.Enhanced.m_stone.name, 1, #G.localization.descriptions.Enhanced.m_stone.name - 5)
				} }
			
			if CirnoMod.miscItems.atlasCheck(card) and CirnoMod.config.matureReferences_cyc >= 2 then
				ret.key = 'cir_j_dna_negativePCardRebalancing'
			elseif CirnoMod.miscItems.atlasCheck(card) then
				ret.key = 'cir_j_dna_negativePCardRebalancing_safe'
			elseif CirnoMod.miscItems.isUsingAnyCustomAtlas(card) then
				ret.main_end = self.create_main_end()
			else
				ret.key = 'j_dna_negativePCardRebalancing'
			end
			
			return ret
		end
	}, true)
	
	--[[ Adjusts Death's description to account for the
	fact that Negative is removed from the copies. ]]
	SMODS.Consumable:take_ownership('death', {
		create_main_end = function(removeNegative)
			if removeNegative then
				local RT = {{
						n = G.UIT.C,
						config = {
							align = 'bm',
							padding = 0.02
						},
						nodes = {}
					}}
					
				CirnoMod.miscItems.addUITextNode(RT[1].nodes,
					"(Removes ",
					G.C.UI.TEXT_INACTIVE,
					0.9)
				
				CirnoMod.miscItems.addUITextNode(RT[1].nodes,
					"Negative",
					G.C.DARK_EDITION,
					0.9)
				
				CirnoMod.miscItems.addUITextNode(RT[1].nodes,
					" from copy)",
					G.C.UI.TEXT_INACTIVE,
					0.9)
						
				return RT
			end
		end,
		
		loc_vars = function(self, info_queue, card)
			local removeNegative = false
			
			if G.hand and G.hand.highlighted and #G.hand.highlighted > 0 then
				for i, c in ipairs (G.hand.highlighted) do
					if c.edition and c.edition.type == 'negative' and G.localization.descriptions.Other.remove_negative then
						info_queue[#info_queue + 1] = { key = 'e_negative_playing_card',
							set = 'Edition',
							config = { extra = 1 },
							vars = { 1,
								G.localization.descriptions.Joker.j_splash.name,
								string.sub(G.localization.descriptions.Enhanced.m_stone.name, 1, #G.localization.descriptions.Enhanced.m_stone.name - 5)
							} }
						
						removeNegative = true
						break
					end
				end
			end
			
			if not CirnoMod.miscItems.atlasCheck(card) then
				return { vars = { card.ability.max_highlighted }, main_end = self.create_main_end(removeNegative) }
			end
			
			return { vars = { card.ability.max_highlighted } }
		end
	}, true)
	
	--[[ Adjusts Cryptid's description to account for the
	fact that Negative is removed from the copies. ]]
	SMODS.Consumable:take_ownership('cryptid', {		
		create_main_end = function(removeNegative)
			if removeNegative then
				local RT = {{
						n = G.UIT.C,
						config = {
							align = 'bm',
							padding = 0.02
						},
						nodes = {}
					}}
					
				CirnoMod.miscItems.addUITextNode(RT[1].nodes,
					"(Removes ",
					G.C.UI.TEXT_INACTIVE,
					0.9)
				
				CirnoMod.miscItems.addUITextNode(RT[1].nodes,
					"Negative",
					G.C.DARK_EDITION,
					0.9)
				
				CirnoMod.miscItems.addUITextNode(RT[1].nodes,
					" from copy)",
					G.C.UI.TEXT_INACTIVE,
					0.9)
						
				return RT
			end
		end,
		
		loc_vars = function(self, info_queue, card)
			local removeNegative = false
			
			if G.hand and G.hand.highlighted and #G.hand.highlighted > 0 then
				for i, c in ipairs (G.hand.highlighted) do
					if c.edition and c.edition.type == 'negative' and G.localization.descriptions.Other.remove_negative then
						info_queue[#info_queue + 1] = { key = 'e_negative_playing_card',
							set = 'Edition',
							config = { extra = 1 },
							vars = { 1,
								G.localization.descriptions.Joker.j_splash.name,
								string.sub(G.localization.descriptions.Enhanced.m_stone.name, 1, #G.localization.descriptions.Enhanced.m_stone.name - 5)
							} }
						
						removeNegative = true
						break
					end
				end
			end
			
			if not CirnoMod.miscItems.atlasCheck(card) then
				return { vars = { card.ability.extra }, main_end = self.create_main_end(removeNegative) }
			end
			
			return { vars = { card.ability.extra } }
		end
	}, true)

end

if CirnoMod.config.allowCosmeticTakeOwnership or CirnoMod.config['8ballTo9ball'] then
	SMODS.Joker:take_ownership('8_ball', {
		loc_vars = function(self, info_queue, card)
			local ret = { vars = {
				''..(G.GAME and to_big(G.GAME.probabilities.normal) or 1), -- TODO: UPDATE TO NEW PROBABILITY READING METHOD
				card.ability.extra
			} }
			
			if CirnoMod.config['8ballTo9ball'] then
				ret.vars[3] = "9"
			else
				ret.vars[3] = "8"
			end
			
			return ret
		end,
		
		calculate = function(self, card, context)
			if 
				not context.end_of_round
				and G.consumeables.cards
				and (to_big(#G.consumeables.cards) + to_big(G.GAME.consumeable_buffer)) < to_big(G.consumeables.config.card_limit)
				and context.individual
				and context.cardarea == G.play
				and not SMODS.has_enhancement(context.other_card, 'm_stone')
			then
				local checkFor = "8"
				
				if CirnoMod.config['8ballTo9ball'] and CirnoMod.miscItems.atlasCheck(card) then
					checkFor = "9"
				end
				
				if
					context.other_card.base.value == checkFor
					and (to_big(pseudorandom('8ball')) < to_big(G.GAME.probabilities.normal)/to_big(card.ability.extra) -- TODO: UPDATE TO NEW PROBABILITY READING METHOD
					or context.retrigger_joker)
				then
					local ret = {
						extra = {
							func = function()
							G.E_MANAGER:add_event(Event({
								trigger = 'before',
								delay = 0.0,
								func = (function()
									SMODS.add_card({ set = 'Tarot' })
									return true
								end)}))
							end
						},
						focus = card,
						message = localize('k_plus_tarot'),
						colour = G.C.SECONDARY_SET.Tarot
					}
					
					if context.blueprint then
						ret.focus = context.blueprint_card
					end
					
					return ret
				end
			end
			
			return { doNotRedSeal = true }
		end
	}, not CirnoMod.config['8ballTo9ball'])
end

-- Additional Custom Challenges
if CirnoMod.config.additionalChallenges then	
	CirnoMod.ChallengeRefs = {}
	
	--[[ Initialises a challenge functions holder.
	This is then populated with any functions
	the challenge needs to use, in the challenge
	file itself.]]
	CirnoMod.ChalFuncs = {}
	
	for i, Ch in ipairs (cirInitConfig.additionalChallenges) do
		-- Runs the lua and puts its returned var into the var.
		local chalInfo = assert(SMODS.load_file('scripts/additions/challenges/'..Ch..".lua"))()
		
		if
			chalInfo.matureRefLevel <= CirnoMod.config.matureReferences_cyc
			and dependencyCheck(chalInfo)
		then
			chalInfo.key = Ch
			
			for i, ln in ipairs (chalInfo.loc_txt.text) do
				if i == 1 then
					table.insert(chalInfo.rules.custom, { id = 'cir_'..Ch })
				else
					table.insert(chalInfo.rules.custom, { id = 'cir_'..Ch..CirnoMod.miscItems.alphabetNumberConv.numToAlphabet[i - 1] })
				end
			end
			
			-- Adds the challenge.
			CirnoMod.ChallengeRefs['ch_c_cir_'..Ch] = SMODS.Challenge(chalInfo)
		end
	end
end

local cirAch = assert(SMODS.load_file('scripts/additions/achievements.lua'))()
CirnoMod.cirAchievements = {}

for k, ach in pairs(cirAch) do
	if
		ach.info
		and ach.shouldBeAdded
		and type(ach.shouldBeAdded) == 'function'
		and ach.shouldBeAdded()
	then
		local newAch = copy_table(ach.info)
		newAch.key = k
		CirnoMod.cirAchievements[k] = SMODS.Achievement(newAch)
	end
end

-- Calc_dollar_bonus version of SMODS.blueprint_effect
function CirnoMod.blueprint_calcDol_effect(copier, copied_card, context)
	if not copied_card or copied_card == copier or copied_card.debuff or context.no_blueprint then return end
	if (context.blueprint or 0) > #G.jokers.cards then return end
	
	context.blueprint = (context.blueprint and (context.blueprint + 1)) or 1
	
	context.blueprint_card = context.blueprint_card or copier
	
	if copied_card.calculate_dollar_bonus then
		return copied_card:calculate_dollar_bonus()
	end
	
	if copied_card.config.center.calc_dollar_bonus then
		return copied_card.config.center:calc_dollar_bonus(copied_card, context)
	end
end

local main_menuRef = Game.main_menu -- Main_menu() hook
function Game:main_menu(change_context)
	CirnoMod.quipReplace()
	
	if not CirnoMod.launching then
		if not CirnoMod.config.startedModOnce then
			CirnoMod.config.startedModOnce = true
		else
			CirnoMod.config.quittingIsAnOption = math.random() < 0.5
		end
		
		if G.F_QUIT_BUTTON == CirnoMod.config.quittingIsAnOption then
			G.F_QUIT_BUTTON = not CirnoMod.config.quittingIsAnOption
		end
		
		CirnoMod.launching = true
	end
	
	if not G.C.SPLASH then -- Ensure splash is initalised
		G.C.SPLASH = {}
	end
	
	--[[
	If our colours are enabled, set the vortex colours to
	our colours. If not, set them to the default ones.]]
	if CirnoMod.config.titleColours then
		G.C.SPLASH[1] = CirnoMod.miscItems.colours.cirBlue
		G.C.SPLASH[2] = CirnoMod.miscItems.colours.cirCyan
	else
		G.C.SPLASH[1] = G.C.SPLASH[1] or G.C.RED
		G.C.SPLASH[2] = G.C.SPLASH[2] or G.C.BLUE
	end
	
	G.C.SECONDARY_SET.UIDefault = G.C.SECONDARY_SET.Spectral
	
	main_menuRef(self, change_context) -- Calls the normal manu_menu() function in Game.
	
	-- Set Tarot colour.
	if
		CirnoMod.config.malverkReplacements
		and CirnoMod.miscItems.colours.tarot
	then
		G.C.SECONDARY_SET.Tarot = CirnoMod.miscItems.colours.tarot
	end
	
	-- Set Planet colour (If Planets Are Hus is active)
	if
		CirnoMod.config.planetsAreHus
		and CirnoMod.miscItems.colours.planet
	then
		G.C.SECONDARY_SET.Planet = CirnoMod.miscItems.colours.planet
	end
	
	if CirnoMod.config.additionalChallenges then
		--[[
		Should update the joker stencil challenge text
		with whatever name Joker Stencil is set to at this
		point in time, but for whatever reason doesn't work
		as intended.
		]]
		G.E_MANAGER:add_event(Event({
				trigger = 'after',
				delay = 2.0,
				blocking = false,
				blockable = true,
				func = function()
					CirnoMod.ChalFuncs.updateStencilName(G.localization.descriptions.Joker.j_stencil.name)
					return true
				end
			}))
		
		--[[
		TODO: For every new challenge that bans something,
		we need to run their ban functions here. Or any
		challenges that name specific things that can be
		renamed or w/e.]]
	end
	
	if CirnoMod.config.titleLogo then
		G.E_MANAGER:add_event(Event({
				trigger = 'immediate',
				blocking = false,
				blockable = false,
				func = function()
					math.randomseed(os.time())
					if math.random(4) == 1 then
						CirnoMod.titleCard:set_edition({ polychrome = true }, true, true)
						G.E_MANAGER:add_event(Event({
								trigger = 'after',
								delay = 0.75,
								blocking = false,
								blockable = false,
								func = function()
										CirnoMod.titleCard:juice_up(0.3, 0.3)
									return true
								end
							}))
					end
					return true
				end
			}))
	end
end

--[[
Hooks for things like challenge functionality.
Challenge functionality is a little weird and
primarily facilitated by checking G.GAME.modifiers
for the challenge id.]]
local oldRunStart = Game.start_run
Game.start_run = function(self, args)
	--[[
	Check if challenges are on and the
	challenge functions aren't empty]]
	if
		CirnoMod.config.additionalChallenges
		and CirnoMod.ChalFuncs ~= nil
	then
		--[[ Is the stencil jokers challenge active?
		If so, do the thing.]]
		if
			G.GAME.challenge == "c_cir_jokerStencils"
			and type(CirnoMod.ChalFuncs.jokerStencilsDebuffCheck) == 'function'
		then
			G.E_MANAGER:add_event(Event({
				trigger = 'after',
				delay = 0.1,
				blocking = false,
				blockable = true,
				func = function()
					if G.jokers then
						CirnoMod.ChalFuncs.jokerStencilsDebuffCheck("runStart")					
						return true
					end
					return false
				end
			}))
		end
		
		if not CirnoMod.config.suppress67Kill then
			G.E_MANAGER:add_event(Event({
				trigger = 'after',
				delay = 0.1,
				blocking = false,
				blockable = true,
				func = function()
					if G.GAME then
						if
							G.GAME.seeded
							and (G.GAME.pseudorandom.seed == '67'
							or G.GAME.pseudorandom.seed == 'SIXSEVEN'
							or G.GAME.pseudorandom.seed == '6SEVEN'
							or G.GAME.pseudorandom.seed == 'SIX7')
						then
							G.STATE = G.STATES.GAME_OVER
							G.STATE_COMPLETE = false
						end
						
						return true
					end
					return false
				end
			}))
		end
	end
	
	-- Randomises shop flavour text.
	if
		CirnoMod.config.miscRenames
		and type(CirnoMod.miscItems.pickRandShopFlavour) == 'function'
	then
		CirnoMod.miscItems.pickRandShopFlavour()
	end
	
	--[[ YEP,
	THIS IS HOW WE'RE DOING THIS NOW.
	BLAME THUNK.]]
	if
		CirnoMod.miscItems.keysOfJokersToUpdateStateOnLoad
	then
		G.E_MANAGER:add_event(Event({
			trigger = 'after',
			delay = 0.1,
			blocking = false,
			blockable = true,
			func = function()
				if G.jokers then
					for i, jkr in ipairs(G.jokers.cards) do
						if
							CirnoMod.miscItems.keysOfJokersToUpdateStateOnLoad[jkr.config.center.key]
							and jkr.config.center.updateState
							and type(jkr.config.center.updateState) == 'function'
						then
							jkr.config.center.updateState(jkr)
						end
					end
					return true
				end
				return false
			end
		}))
	end
	
	oldRunStart(self, args)
end

local oldCreateCard = create_card
function create_card(_type, area, legendary, _rarity, skip_materialize, soulable, forced_key, key_append)
	local RV = oldCreateCard(_type, area, legendary, _rarity, skip_materialize, soulable, forced_key, key_append)
		
	--[[ Persistently track joker
	encounters across unseeded runs. ]]
	if
		((not G.GAME.seeded)
		or SMODS.config.seeded_unlocks)
		and RV
		and _type == 'Joker'
		and CirnoMod.config.malverkReplacements
	then
		CirnoMod.miscItems.encounterJoker(RV.config.center.key)
	end
	
	check_for_unlock({ type = 'cardCreate' })
	return RV
end

--[[
local oldEvalCard = eval_card
function eval_card(card, context)
	
	return oldEvalCard(card, context)
end
]]

local oldNewRound = new_round
function new_round()
	--[[
	Check if challenges are on and the
	challenge functions aren't empty]]
	if
		CirnoMod.config.additionalChallenges
		and CirnoMod.ChalFuncs ~= nil
	then
		--[[ Is the stencil jokers challenge active?
		If so, do the thing.]]
		if
			G.GAME.challenge == "c_cir_jokerStencils"
			and type(CirnoMod.ChalFuncs.jokerStencilsDebuffCheck) == 'function'
		then
			G.E_MANAGER:add_event(Event({
				trigger = 'after',
				delay = 0.1,
				blocking = false,
				blockable = true,
				func = function()
					if G.jokers then
						CirnoMod.ChalFuncs.jokerStencilsDebuffCheck("blindStart")						
						return true
					end
					return false
				end
			}))
		end
	end
	
	oldNewRound()
end

local oldEndRound = end_round
function end_round()
	--[[
	Check if challenges are on and the
	challenge functions aren't empty]]
	if
		CirnoMod.config.additionalChallenges
		and CirnoMod.ChalFuncs ~= nil
	then
		--[[ Is the stencil jokers challenge active?
		If so, do the thing.]]
		if
			G.GAME.challenge == "c_cir_jokerStencils"
			and type(CirnoMod.ChalFuncs.jokerStencilsDebuffCheck) == 'function'
		then
			G.E_MANAGER:add_event(Event({
				trigger = 'after',
				delay = 0.1,
				blocking = false,
				blockable = true,
				func = function()
					if G.jokers then
						CirnoMod.ChalFuncs.jokerStencilsDebuffCheck("blindDefeat")					
						return true
					end
					return false
				end
			}))
		end
	end
	
	-- Randomises shop flavour text.
	if
		CirnoMod.config.miscRenames
		and type(CirnoMod.miscItems.pickRandShopFlavour) == 'function'
	then
		CirnoMod.miscItems.pickRandShopFlavour()
	end
	
	oldEndRound()
end


--[[
There appears to be no game function that can be
hooked relating to when a shop phase starts
]]

-- Need this hook for Joker functionality
local old_dfptd = G.FUNCS.draw_from_play_to_discard
G.FUNCS.draw_from_play_to_discard = function(e)
	local wasCalledOnce = false
	local redrawJkrs = {}
	local redrawCards = {}
	
	for i, k in ipairs(CirnoMod.miscItems.returnToHand_Jokers) do
		local FCR = SMODS.find_card(k)
		
		if next(FCR) then
			for i_, jkr in ipairs(FCR) do
				table.insert(redrawJkrs, jkr)
			end
		end
	end
	
	if #redrawJkrs > 0 then
		for _, card in ipairs(redrawJkrs) do
			if
				card.config.center.shouldReturnToHand
				and type(card.config.center.shouldReturnToHand) == 'function'
				and card.config.center:shouldReturnToHand(card)
				and card.config.center.returnToHand_func
				and type(card.config.center.returnToHand_func) == 'function'
			then
				local jkrRet = card.config.center:returnToHand_func(card, _ == #redrawJkrs, old_dfptd)
				wasCalledOnce = true
				
				if jkrRet and #jkrRet > 0 then
					SMODS.merge_lists({ redrawCards, jkrRet })
				end
			end
		end
	end
	
	if wasCalledOnce then
		for _, c in ipairs(redrawCards) do
			c.beingRedrawn = false
		end
		
		return
	end
	
	old_dfptd(e)
end

local old_smodsCalcContext = SMODS.calculate_context
SMODS.calculate_context = function(context, return_table)
	if
		not CirnoMod.config.suppress67Kill
		and context.before
		and #G.play.cards == 2
		and G.play.cards[1].base.value == '6'
		and G.play.cards[2].base.value == '7'
	then
		CirnoMod.sixSevenAttenpted = true
		G.STATE = G.STATES.GAME_OVER
		G.STATE_COMPLETE = false
	end
	
	if
		CirnoMod.miscItems.isState(G.STATE, G.STATES.SELECTING_HAND)
		and G.hand.cards
		and #G.hand.cards > 0
	then
		for i, c in ipairs(G.hand.cards) do
			if c.beingRedrawn then
				c.beingRedrawn = false
			end
		end
	end
	
	if 
		context.end_of_round
		and G.jokers
		and G.jokers.cards
		and #G.jokers.cards > 0
	then
		for i, jkr in ipairs(G.jokers.cards) do
			if
				jkr.ability.debuff_sources
				and next(jkr.ability.debuff_sources)
				and jkr.ability.debuff_sources['cir_Jkr_autoEORUndebuff']
			then
				jkr:juice_up()
				SMODS.debuff_card(jkr, false, 'cir_Jkr_autoEORUndebuff')
			end
		end
	end
	
	local ret = old_smodsCalcContext(context, return_table)
	
	if ret then
		return ret
	end
end

local old_sm_bp_eff = SMODS.blueprint_effect
SMODS.blueprint_effect = function(copier, copied_card, context, msg_colour)
	local ret = old_sm_bp_eff(copier, copied_card, context)
	
	if ret then
		if msg_colour then
			ret.colour = msg_colour
		end
		
		return ret
	end
end

--[[ This is the functionality that should make the
mod badge text cycle between the mod name and streamer(s)
the thing is relevant to. This is largely lifted from
Cryptid with some tweaks. ]]
local SMcmb = SMODS.create_mod_badges
function SMODS.create_mod_badges(obj, badges)
	SMcmb(obj, badges)
	
	if 
		not SMODS.no_mod_badges
		and obj
		and obj.cir_Friend
		and (type(obj.cir_Friend) == 'string'
		or type(obj.cir_Friend) == 'table')
	then
		local badge_text = { { string = 'Cirno_TV & Friends' } }
		
		if type(obj.cir_Friend) == 'table' then
			for i, str in ipairs(obj.cir_Friend) do
				table.insert(badge_text, { string = str })
			end
		else
			badge_text[2] = { string = obj.cir_Friend }
		end
		
		local cir_badge = CirnoMod.miscItems.createDynaTextBadge(badge_text, CirnoMod.miscItems.colours.cirCyan)
		
		--[[
		And then this part is about looking through the badges for
		the mod badge that Steamodded created by colour, yoinking
		that and replacing it with what we just created.
		
		...Not really the best way to look for it, but... Eh? ]]
		
		-- This is what compares the two colours to see if they're the same colour.
		local function eq_col(x, y)
			for i = 1, 4 do
				if x[1] ~= y[1] then
					return false
				end
			end
			return true
		end
		
		--[[
		This then looks through the badges and finds the first one matching
		the mod badge colour, then replaces it with the created badge. ]]
		for i = 1, #badges do
			if eq_col(badges[i].nodes[1].config.colour, CirnoMod.miscItems.colours.cirCyan) then
				badges[i].nodes[1].nodes[2].config.object:remove()
				badges[i] = cir_badge
				break
			end
		end
	end
end

local leq_ref = love.quit
love.quit = function()
	
	if 
		not CirnoMod.config.jkrVals[G.SETTINGS.profile].store.dabber_altf4
		and love.keyboard.isDown{ 'lalt', 'ralt' }
		and love.keyboard.isDown{ 'f4' }
		and (CirnoMod.dabber ~= nil
		or (CirnoMod.dabber
		and not CirnoMod.dabber.REMOVED))
	then
		CirnoMod.config.jkrVals[G.SETTINGS.profile].store.dabber_altf4 = true
		SMODS.save_mod_config(CirnoMod)
	end
	
	return leq_ref()
end