SMODS.Atlas{
	key = 'modicon',
	path = 'modicon.png',
	px = 34,
	py = 34
}

--[[
Hate UI in this, holy. This is ridiculous to deal with.]]
local configUI = function()
	return {
		n = G.UIT.ROOT,
		config = {
			r = 0.1,
			padding = 0.0,
			align = 'tm',
			colour = G.C.CLEAR
		},
		nodes = {
		--[[
		Each node needs to be its own table inside the table. ...Yeah. I'm chalking this up to a LOVE Engine quirk.
		For this to size itself properly, you always need to alternate rows and columns. The order depends on the
		final intended layout.]]
			{
				n = G.UIT.R,
				config = {
					r = 0.1,
					padding = 0.0,
					align = 'tm',
					colour = G.C.CLEAR
				},
				nodes = {
					{
						n = G.UIT.C,
						config = {
							r = 0.1,
							padding = 0.0,
							align = 'tm',
							colour = G.C.CLEAR
						},
						nodes = {
							{
								n = G.UIT.R, -- Text rows wrapper
								config = {
									r = 0.1,
									padding = 0.0,
									align = 'tm',
									colour = G.C.CLEAR
								},
								nodes = {
									{
										n = G.UIT.T, -- Top text
										config = {
											text = "Restart Balatro to Fully Apply Changes",
											scale = 0.7,
											colour = G.C.RED,
											align = 'tm',
											juice = true,
											w = 3,
											h = 2,
											hover = true
										}
									}
								}
							},
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
											w = 0.1,
											h = 0.2
										}
									}
								}
							},
							{
								n = G.UIT.R, -- Text rows wrapper
								config = {
									r = 0.1,
									padding = 0.0,
									align = 'tm',
									colour = G.C.CLEAR
								},
								nodes = {
									{
										n = G.UIT.T, -- Top text
										config = {
											text = "Steamodded's Balatro Quick Restart Shortcut = Alt + F5",
											scale = 0.4,
											colour = G.C.UI.TEXT_LIGHT,
											align = 'tm',
											w = 3,
											h = 1,
											hover = true
										}
									}
								}
							},
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
											h = 0.2
										}
									}
								}
							},
							{
								n = G.UIT.R, -- Text rows wrapper
								config = {
									r = 0.1,
									padding = 0.0,
									align = 'tm',
									colour = G.C.CLEAR
								},
								nodes = {
									{
										n = G.UIT.T, -- Top text
										config = {
											text = "(I can't believe Steamodded devs hate people without function keys, such as Girl_DM_.",
											scale = 0.25,
											colour = G.C.UI.TEXT_LIGHT,
											align = 'tm',
											w = 3,
											h = 1,
											hover = true
										}
									}
								}
							},
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
											w = 0.1,
											h = 0.1
										}
									}
								}
							},
							{
								n = G.UIT.R, -- Text rows wrapper
								config = {
									r = 0.1,
									padding = 0.0,
									align = 'tm',
									colour = G.C.CLEAR
								},
								nodes = {
									{
										n = G.UIT.T, -- Top text
										config = {
											text = "Very clear case of discrimination specifically against her, smh >:( )",
											scale = 0.25,
											colour = G.C.UI.TEXT_LIGHT,
											align = 'tm',
											w = 3,
											h = 1,
											hover = true
										}
									}
								}
							},
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
											w = 0.15,
											h = 0.2
										}
									}
								}
							},
							{
								n = G.UIT.R, -- Options rows wrapper
								config = {
									id = 'cir_config_toggles',
									r = 0.1,
									padding = 0.0,
									align = 'tm',
									colour = G.C.CLEAR
								},
								nodes = {
									{
										n = G.UIT.C, -- First Options Column
										config = {
											align = 'tm',
											r = 0.4,
											padding = 0.05,
											colour = G.C.GREY,
											outline = 0.75,
											outline_colour = CirnoMod.miscItems.colours.cirBlue,
											hover = true,
											shadow= true
										},
										nodes = {
											{
												n = G.UIT.R,
												config = { align = 'tr', padding = 0.025 },
												nodes = {
													create_toggle({
														label = "Title Screen Logo",
														w = 1,
														text_scale = 0.75,
														ref_table = CirnoMod.config,
														ref_value = 'titleLogo',
														-- callback = CirnoMod.callback_titleLogoToggle,
														active_colour = G.C.SECONDARY_SET.Spectral
													})
												}
											},
											{
												n = G.UIT.R,
												config = { align = 'tr', padding = 0.025 },
												nodes = {
													create_toggle({
														label = "Malverk Texture Pack",
														w = 1,
														text_scale = 1,
														ref_table = CirnoMod.config,
														ref_value = 'malverkReplacements',
														-- callback = CirnoMod.callback_malverkReplacementsToggle,
														active_colour = G.C.SECONDARY_SET.Spectral
													})
												}
											},
											{
												n = G.UIT.R,
												config = { align = 'tr', padding = 0.025 },
												nodes = {
													create_toggle({
														label = "Enhancer Renames",
														w = 1,
														text_scale = 0.75,
														ref_table = CirnoMod.config,
														ref_value = 'enhancerRenames',
														-- callback = CirnoMod.callback_enhancerRenamesToggle,
														active_colour = G.C.SECONDARY_SET.Spectral
													})
												}
											},
											{
												n = G.UIT.R,
												config = { align = 'tr', padding = 0.025 },
												nodes = {
													create_toggle({
														label = "Blind Renames",
														w = 1,
														text_scale = 0.75,
														ref_table = CirnoMod.config,
														ref_value = 'blindRenames',
														-- callback = CirnoMod.callback_blindRenamesToggle,
														active_colour = G.C.SECONDARY_SET.Spectral
													})
												}
											},
											{
												n = G.UIT.R,
												config = { align = 'tr', padding = 0.025 },
												nodes = {
													create_toggle({
														label = "Additional Custom Jokers",
														w = 1,
														text_scale = 0.75,
														ref_table = CirnoMod.config,
														ref_value = 'addCustomJokers',
														-- callback = CirnoMod.callback_addCustomJokersToggle,
														active_colour = G.C.SECONDARY_SET.Spectral
													})
												}
											},
											{
												n = G.UIT.R,
												config = { align = 'tr', padding = 0.025 },
												nodes = {
													create_toggle({
														label = "Planets, Tarots & Spectral Renames",
														w = 1,
														text_scale = 0.8,
														ref_table = CirnoMod.config,
														ref_value = 'planetTarotSpectralRenames',
														-- callback = CirnoMod.callback_planetTarotSpectralRenamesToggle,
														active_colour = G.C.SECONDARY_SET.Spectral
													})
												}
											}
										}
									},
									{
										-- Spacer
										n = G.UIT.B,
										config = {
											colour = G.C.CLEAR,
											w = 0.1,
											h = 0.2
										}
									},
									{
										n = G.UIT.C, -- Second Options Column
										config = {
											align = 'tm',
											r = 0.4,
											padding = 0.05,
											colour = G.C.GREY,
											outline = 0.75,
											outline_colour = CirnoMod.miscItems.colours.cirBlue,
											hover = true,
											shadow = true
										},
										nodes = {
											{
												n = G.UIT.R,
												config = { align = 'tr', padding = 0.025 },
												nodes = {
													create_toggle({
														label = "Title Screen Colours",
														w = 1,
														text_scale = 0.75,
														ref_table = CirnoMod.config,
														ref_value = 'titleColours',
														-- callback = CirnoMod.callback_titleColoursToggle,
														active_colour = G.C.SECONDARY_SET.Spectral
													})
												}
											},
											{
												n = G.UIT.R,
												config = { align = 'tr', padding = 0.025 },
												nodes = {
													create_toggle({
														label = "Custom Playing Card Skins",
														w = 1,
														text_scale = 0.75,
														ref_table = CirnoMod.config,
														ref_value = 'playingCardTextures',
														-- callback = CirnoMod.callback_playingCardTexturesToggle,
														active_colour = G.C.SECONDARY_SET.Spectral
													})
												}
											},
											{
												n = G.UIT.R,
												config = { align = 'tr', padding = 0.025 },
												nodes = {
													create_toggle({
														label = "Blind Renames",
														w = 1,
														text_scale = 1,
														ref_table = CirnoMod.config,
														ref_value = 'blindRenames',
														-- callback = CirnoMod.callback_blindRenamesToggle,
														active_colour = G.C.SECONDARY_SET.Spectral
													})
												}
												
											},
											{
												n = G.UIT.R,
												config = { align = 'tr', padding = 0.025 },
												nodes = {
													create_toggle({
														label = "Planets Are Hus",
														w = 1,
														text_scale = 0.75,
														ref_table = CirnoMod.config,
														ref_value = 'planetsAreHus',
														-- callback = CirnoMod.callback_planetsAreHusToggle,
														active_colour = G.C.SECONDARY_SET.Spectral
													})
												}
											},
											{
												n = G.UIT.R,
												config = { align = 'tr', padding = 0.025 },
												nodes = {
													create_toggle({
														label = "Additional Custom Consumables",
														w = 1,
														text_scale = 0.75,
														ref_table = CirnoMod.config,
														ref_value = 'addCustomConsumables',
														-- callback = CirnoMod.callback_addCustomConsumablesToggle,
														active_colour = G.C.SECONDARY_SET.Spectral
													})
												}
											},
											{
												n = G.UIT.R,
												config = { align = 'tr', padding = 0.025 },
												nodes = {
													create_toggle({
														label = "Art Credit Tooltips",
														w = 1.,
														text_scale = 0.75,
														ref_table = CirnoMod.config,
														ref_value = 'artCredits',
														-- callback = CirnoMod.callback_artCreditsToggle,
														active_colour = G.C.SECONDARY_SET.Spectral
													})
												}
											}
										}
									},
									{
										-- Spacer
										n = G.UIT.B,
										config = {
											colour = G.C.CLEAR,
											w = 0.1,
											h = 0.2
										}
									},
									{
										n = G.UIT.C, -- Third Options Column
										config = {
											align = 'tm',
											r = 0.4,
											padding = 0.05,
											colour = G.C.GREY,
											outline = 0.75,
											outline_colour = CirnoMod.miscItems.colours.cirBlue,
											hover = true,
											shadow = true
										},
										nodes = {
											{
												n = G.UIT.R,
												config = { align = 'tr', padding = 0.025 },
												nodes = {
													create_option_cycle({
													label = "Mature References (All (Hopefully) Stream-Safe)",
													colour = G.C.SECONDARY_SET.Spectral,
													text_scale = 0.5,
													scale = 0.75,
													w = 4,
													options = CirnoMod.miscItems.matureReferencesOpt,
													current_option = CirnoMod.config.matureReferences_cyc,
													ref_table = CirnoMod.config,
													ref_value = 'matureReferences_cyc',
													opt_callback = 'cir_CycMatureReferencesVal'
													})
												}
											},
											{
												n = G.UIT.R,
												config = { align = 'tr', padding = 0.025 },
												nodes = {
													create_toggle({
														label = "Joker Renames",
														w = 1,
														text_scale = 0.75,
														ref_table = CirnoMod.config,
														ref_value = 'jokerRenames',
														-- callback = CirnoMod.callback_jokerRenamesToggle,
														active_colour = G.C.SECONDARY_SET.Spectral
													})
												}
											},
											{
												n = G.UIT.R,
												config = { align = 'tr', padding = 0.025 },
												nodes = {
													create_toggle({
														label = "Deck Renames",
														w = 1,
														text_scale = 0.75,
														ref_table = CirnoMod.config,
														ref_value = 'deckRenames',
														-- callback = CirnoMod.callback_deckRenamesToggle,
														active_colour = G.C.SECONDARY_SET.Spectral
													})
												}
											},
											{
												n = G.UIT.R,
												config = { align = 'tr', padding = 0.025 },
												nodes = {
													create_toggle({
														label = "Misc Renames",
														w = 1,
														text_scale = 0.75,
														ref_table = CirnoMod.config,
														ref_value = 'miscRenames',
														-- callback = CirnoMod.callback_miscRenamesToggle,
														active_colour = G.C.SECONDARY_SET.Spectral
													})
												}
											},
											{
												n = G.UIT.R,
												config = { align = 'tr', padding = 0.025 },
												nodes = {
													create_toggle({
														label = "Allow Cosmetic SMODS Take_Ownership()s",
														w = 1.,
														text_scale = 0.75,
														ref_table = CirnoMod.config,
														ref_value = 'allowCosmeticTakeOwnership',
														-- callback = CirnoMod.callback_allowCosmeticTakeOwnershipToggle,
														active_colour = G.C.SECONDARY_SET.Spectral
													})
												}
											},
											{
												n = G.UIT.R,
												config = { align = 'tr', padding = 0.025 },
												nodes = {
													create_toggle({
														label = "Negative Playing Card Rebalance",
														w = 1,
														text_scale = 0.75,
														ref_table = CirnoMod.config,
														ref_value = 'negativePCardsBalancing',
														-- callback = CirnoMod.callback_negativePCardsBalancingToggle,
														active_colour = G.C.SECONDARY_SET.Spectral
													})
												}
											}
										}
									}
								}
							},
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
											w = 0.15,
											h = 0.2
										}
									}
								}
							},
							{
								n = G.UIT.R, -- Text rows wrapper
								config = {
									r = 0.1,
									padding = 0.0,
									align = 'tm',
									colour = G.C.CLEAR
								},
								nodes = {
									{
										n = G.UIT.T, -- Top text
										config = {
											text = "(The majority of renames are tied to the Malverk texture pack)",
											scale = 0.4,
											colour = G.C.UI.TEXT_LIGHT,
											align = 'tm',
											w = 3,
											h = 2,
											hover = true
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

return configUI