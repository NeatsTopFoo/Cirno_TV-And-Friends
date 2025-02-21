CirnoMod = {}
CirnoMod.path = SMODS.current_mod.path
CirnoMod.config = SMODS.current_mod.config
CirnoMod.allEnabledOptions = copy_table(CirnoMod.config)

-- Defines Steamodded mod menu config tab
SMODS.current_mod.config_tab = function()
	return {
		n = G.UIT.ROOT,
		config = {
			r = 0.1,
			minh = 6,
			minw= 6,
			align = 'cm',
			colour = G.C.CLEAR
		},
		nodes = {
			{
				n = G.UIT.C,
				config = { align = 'tl', minw = 2, id = 'cir_config_sidebar' },
				nodes = {
					{
						n = G.UIT.R,
						config = { align = 'tr', id = 'cir_config_toggles' },
						nodes = {
							{
								n = G.UIT.C,
								nodes = {
									{
										n = G.UIT.R,
										config = { align = 'tr', padding = 0.05 },
										nodes = {
											create_toggle({
												label = "Enable Title Screen Logo",
												w = 1.5,
												text_scale = 0.7,
												ref_table = CirnoMod.config,
												ref_value = 'titleLogo',
												callback = CirnoMod.callback_titleLogoToggle
											})
										}
									},
									{
										n = G.UIT.R,
										config = { align = 'tr', padding = 0.05 },
										nodes = {
											create_toggle({
												label = "Enable Title Screen Colours (NOT YET FUNCTIONAL)",
												w = 1.5,
												text_scale = 0.7,
												ref_table = CirnoMod.config,
												ref_value = 'titleColours',
												callback = CirnoMod.callback_titleColoursToggle
											})
										}
									},
									{
										n = G.UIT.R,
										config = { align = 'tr', padding = 0.05 },
										nodes = {
											create_toggle({
												label = "Enable Playing Card Textures (Currently Broken???)",
												w = 1.5,
												text_scale = 0.7,
												ref_table = CirnoMod.config,
												ref_value = 'playingCardTextures',
												callback = CirnoMod.callback_cardTexturesToggle
											})
										}
									},
									{
										n = G.UIT.R,
										config = { align = 'tr', padding = 0.05 },
										nodes = {
											create_toggle({
												label = "Enable Malverk Texture Replacements",
												w = 1.5,
												text_scale = 0.7,
												ref_table = CirnoMod.config,
												ref_value = 'malverkReplacements',
												callback = CirnoMod.callback_malverkReplacementsToggle
											})
										}
									},
									{
										n = G.UIT.R,
										config = { align = 'tr', padding = 0.05 },
										nodes = {
											create_toggle({
												label = "Enable Joker Renames",
												w = 1.5,
												text_scale = 0.7,
												ref_table = CirnoMod.config,
												ref_value = 'jokerRenames',
												callback = CirnoMod.callback_jokerRenamesToggle
											})
										}
									},
									{
										n = G.UIT.R,
										config = { align = 'tr', padding = 0.05 },
										nodes = {
											create_toggle({
												label = "Enable Blind Renames",
												w = 1.5,
												text_scale = 0.7,
												ref_table = CirnoMod.config,
												ref_value = 'blindRenames',
												callback = CirnoMod.callback_blindRenamesToggle
											})
										}
									},
									{
										n = G.UIT.R,
										config = { align = 'tr', padding = 0.05 },
										nodes = {
											create_toggle({
												label = "Enable Deck Renames",
												w = 1.5,
												text_scale = 0.7,
												ref_table = CirnoMod.config,
												ref_value = 'deckRenames',
												callback = CirnoMod.callback_deckRenamesToggle
											})
										}
									},
									{
										n = G.UIT.R,
										config = { align = 'tr', padding = 0.05 },
										nodes = {
											create_toggle({
												label = "Enable Enhancer Renames",
												w = 1.5,
												text_scale = 0.7,
												ref_table = CirnoMod.config,
												ref_value = 'enhancerRenames',
												callback = CirnoMod.callback_enhancerRenamesToggle
											})
										}
									},
									{
										n = G.UIT.R,
										config = { align = 'tr', padding = 0.05 },
										nodes = {
											create_toggle({
												label = "Enable Tarots & Spectral Renames",
												w = 1.5,
												text_scale = 0.7,
												ref_table = CirnoMod.config,
												ref_value = 'tarotSpectralRenames',
												callback = CirnoMod.callback_tarotSpectralRenamesToggle
											})
										}
									},
									{
										n = G.UIT.R,
										config = { align = 'tr', padding = 0.05 },
										nodes = {
											create_toggle({
												label = "Enable Misc Renames",
												w = 1.5,
												text_scale = 0.7,
												ref_table = CirnoMod.config,
												ref_value = 'miscRenames',
												callback = CirnoMod.callback_miscRenamesToggle
											})
										}
									}
								}
							}
						}
					}
				}
			}
		}
	}
end

-- Change title screen logo to mod's logo & replace the ace that appears first with the blueprint joker (If the setting is enabled) - Has corresponding patcher code in the lovely.toml
if CirnoMod.allEnabledOptions['titleLogo'] then
	-- Replaces the Ace that appears at start with the Blueprint Joker.
	G.TITLE_SCREEN_CARD = 'j_blueprint'
	
	-- Title Screen Logo Texture
	SMODS.Atlas {
		key = "balatro",
		path = "cir_BalatroLogo.png",
		px = 333,
		py = 216,
		prefix_config = { key = false }
	}
else
	-- Necessary for the below
	G.TITLE_SCREEN_CARD = G.P_CARDS.S_A
end

-- Necessary function definition for above title screen replacement stuff to both actually facilitate the replacement and also make it not error because I'm giving it a string instead
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

------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------
----- An attempt at lifting the code from Cardsauce that alters the shader colours,  -----
----- to try and make the vortex in the main menu Cirno themed (Blue & Cyan instead  -----
----- of Red & Blue), that is not functional and causes an error every time it tries -----
----- to load. I'm probably missing something or have done something wrong, but if   -----
----- you're willing to try and make it work, or have some other idea to accomplish  -----
----- the same thing, go ahead. I have no idea how to make this work at this point & -----
----- to be honest, I'm surprised that the Blueprint replacement stuff above works.  -----
----- Bear in mind that both the above and below code have corresponding patches in  -----
----- the lovely.toml that will likely need to be revised in order to work properly. -----
------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------

--	local color_presets = {
--		{
--			"RED",
--			"BLUE",
--			{'50846e', "BAL_DEF_SMALLBIGGREEN"},
--			{"4f6367", "BAL_DEF_ENDLESSBLUEGREY"},
--			'default_bal'
--		},
--		{
--			"CIR_BLUE",
--			"CIR_CYAN",
--			{'4161fb', "BAL_DEF_SMALLBIGGREEN" },
--			{"92d3ff", "BAL_DEF_ENDLESSBLUEGREY"},
--			'default_cir'
--		}
--	}
--	
--	local color_presets_nums = {}
--	local color_presets_strings = {}
--	for i, v in ipairs(color_presets) do
--		local k = v[#v]
--		table.insert(color_presets_strings, k)
--		color_presets_nums[k] = i
--		for i = 1, #v - 1 do
--			local func_name, color_name
--			if type(v[i]) == "string" then
--				func_name = "cs_"..v[i].."c"
--				color_name = v[i]
--			elseif type(v[i]) == "table" then
--				G.C[v[i][2]] = HEX(v[i][1])
--				func_name = "cs_"..v[i][2].."c"
--				color_name = v[i][2]
--			end
--		end
--	end
--	
--	-- Title Screen Colours
--	if CirnoMod.allEnabledOptions['titleColours'] then
--		G.C.COLOR1 = G.C.CIR_BLUE
--		G.C.COLOR2 = G.C.CIR_CYAN
--	else
--		G.C.COLOR1 = G.C.RED
--		G.C.COLOR2 = G.C.BLUE
--	end
--	G.C.COLOUR1 = G.C.COLOR1
--	G.C.COLOUR2 = G.C.COLOR2
--	
--	local function get_matching_color(name)
--			for i, v in ipairs(color_presets) do
--				if type(v[1]) == "string" then
--					if name == v[1] then
--						return G.C[name]
--					end
--				elseif type(v[1]) == "table" then
--					if name == v[1][2] then
--						return HEX(v[1][1])
--					end
--				end
--				if type(v[2]) == "string" then
--					if name == v[2] then
--						return G.C[name]
--					end
--				elseif type(v[2]) == "table" then
--					if name == v[2][2] then
--						return HEX(v[2][1])
--					end
--				end
--			end
--		end
--	
--	function cir_save_color(colour, val)
--		local color = get_matching_color(val)
--		local set = 'CS_COLOR'..colour
--		G.SETTINGS[set] = color
--		G:save_settings()
--	end
--	
--	local colors = {}
--	for _, preset in ipairs(color_presets) do
--		for i = 1, #preset - 1 do
--			if type(preset[i]) == "string" then
--				colors[preset[i]] = true
--			elseif type(preset[i]) == "table" then
--				colors[preset[i][2]] = true
--			end
--		end
--	end
--	
--	for color, _ in pairs (colors) do
--		G.FUNCS["change_color_1_" .. color] = function()
--			G.C.COLOUR1 = G.C[color]
--			cir_save_color(1, color)
--		end
--		
--		G.FUNCS["change_color_2_" .. color] = function()
--			G.C.COLOUR2 = G.C[color]
--			cir_save_color(2, color)
--		end
--		
--		G.FUNCS["change_color_3_" .. color] = function()
--			G.C.BLIND.Small = G.C[color]
--			G.C.BLIND.Big = G.C[color]
--			cir_save_color(3, color)
--		end
--		
--		G.FUNCS["change_color_4_" .. color] = function()
--			G.C.BLIND.won = G.C[color]
--			cir_save_color(4, color)
--		end
--	end
--	
--	for i=1, 4 do
--		G.FUNCS["paste_hex_"..i] = function(e)
--			G.CONTROLLER.text_input_hook = e.UIBox:get_UIE_by_ID('hex_set_'..i).children[1].children[1]
--			G.CONTROLLER.text_input_id = 'hex_set_'..i
--			for i = 1, 6 do
--				G.FUNCS.text_input_key({key = 'right'})
--			end
--			for i = 1, 6 do
--				G.FUNCS.text_input_key({key = 'backspace'})
--			end
--			local clipboard = (G.F_LOCAL_CLIPBOARD and G.CLIPBOARD or love.system.getClipboardText()) or ''
--			for i = 1, #clipboard do
--				local c = clipboard:sub(i,i)
--				if c ~= "#" then
--					G.FUNCS.text_input_key({key = c})
--				end
--			end
--			G.FUNCS.text_input_key({key = 'return'})
--		end
--	end
--	
--	local function validHEX(str)
--		local hex = str:match("^#?(%x%x%x%x%x%x)$") or str:match("^#?(%x%x%x)$")
--		return hex ~= nil
--	end
--	
--	local function replaceReplacedChars(str)
--		return str:gsub("[Oo]", "0")
--	end
--	
--	G.FUNCS.apply_colors = function()
--		for i=1, 4 do
--			if G["CUSTOMHEX"..i] then
--				local hex = replaceReplacedChars(G["CUSTOMHEX"..i])
--				if validHEX(hex) then
--					if i== 4 then
--						G.C.BLIND.won = HEX(hex)
--						if G.GAME and G.GAME..round_resets.ante >= 9 then
--							ease_background_colour{new_colour = HEX(hex), contrast = 1}
--						end
--						G:save_settings()
--					end
--					if i==3 then
--						G.C.BLIND.Small = HEX(hex)
--						G.C.BLIND.Big = HEX(hex)
--						if G.GAME and G.GAME..round_resets.ante < 9 then
--							ease_background_colour{new_colour = HEX(hex), contrast = 1}
--						end
--						G.SETTINGS["CS_COLOR"..i] = HEX(hex)
--						G:save_settings()
--					elseif i == 1 or i == 2 then
--						G.C["COLOUR"..i] = HEX(hex)
--						G.SETTINGS["CS_COLOR"..i] = HEX(hex)
--						G:save_settings()
--					end
--				end
--			end
--		end
--	end
--	
--	local main_menuRef = Game.main_menu
--	function Game:main_menu(change_context)
--		main_menuRef(self, change_context)
--		
--		local splash_args = {mid_flash = change_context == 'splash' and 1.6 or 0.}
--		ease_value(splash_args, 'mid_flash', -(change_context == 'splash' and 1.6 or 0), nil, nil, nil, 4)
--	
--		G.SPLASH_BACK:define_draw_steps({{
--			shader = 'splash',
--			send = {
--				{name = 'time', ref_table = G.TIMERS, ref_value = 'REAL'},
--				{name = 'vort_speed', val = 0.4},
--				{name = 'colour_1', ref_table = G.C, ref_value = 'COLOUR1'},
--				{name = 'colour_2', ref_table = G.C, ref_value = 'COLOUR2'},
--				{name = 'mid_flash', ref_table = splash_args, ref_value = 'mid_flash'},
--				{name = 'vort_offset', val = 0},
--			}}})
--			
--	end

-- Playing Card Textures
if CirnoMod.allEnabledOptions['playingCardTextures'] then
	-- Runs the lua only if the setting is enabled in Steamodded mod config.
	SMODS.load_file("scripts/retextures/PlayingCards_Retext.lua")(CirnoMod)
end

-- Joker Textures
if CirnoMod.allEnabledOptions['malverkReplacements'] then
	-- Runs the lua only if the setting is enabled in Steamodded mod config.
	SMODS.load_file("scripts/retextures/Malverk_Texture_Replacements.lua")(CirnoMod)
end

-- Joker Renames
if CirnoMod.allEnabledOptions['jokerRenames'] then
	-- Runs the lua only if the setting is enabled in Steamodded mod config.
	SMODS.load_file("scripts/renames_etc/Jokers_Rename.lua")(CirnoMod)
end

-- Blind Renames
if CirnoMod.allEnabledOptions['blindRenames'] then
	-- Runs the lua only if the setting is enabled in Steamodded mod config.
	SMODS.load_file("scripts/renames_etc/Blinds_Rename.lua")(CirnoMod)
end

-- Deck Renames
if CirnoMod.allEnabledOptions['deckRenames'] then
	-- Runs the lua only if the setting is enabled in Steamodded mod config.
	SMODS.load_file("scripts/renames_etc/Decks_Rename.lua")(CirnoMod)
end

-- Enhancer Renames
if CirnoMod.allEnabledOptions['enhancerRenames'] then
	-- Runs the lua only if the setting is enabled in Steamodded mod config.
	SMODS.load_file("scripts/renames_etc/Enhancers_Rename.lua")(CirnoMod)
end

-- Tarot & Spectral Renames
if CirnoMod.allEnabledOptions['tarotSpectralRenames'] then
	-- Runs the lua only if the setting is enabled in Steamodded mod config.
	SMODS.load_file("scripts/renames_etc/TarotsAndSpectrals_Rename.lua")(CirnoMod)
end

-- Tarot & Spectral Renames
if CirnoMod.allEnabledOptions['miscRenames'] then
	-- Runs the lua only if the setting is enabled in Steamodded mod config.
	SMODS.load_file("scripts/renames_etc/Misc_Rename.lua")(CirnoMod)
end