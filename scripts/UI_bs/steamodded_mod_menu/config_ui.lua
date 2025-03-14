-- Wrestling with this shit sucks, if you
-- want to try and fix it yourself, go
-- right ahead. Because I don't have a clue
-- how to make it work how I want. I don't
-- understand why it constantly wants to
-- make the box unreasonably wide and why
-- it constantly wants to put everything
-- on the left side despite the lack of
-- left alignment anywhere here. This shit
-- is fucking stupid.
local configUI = function()
	return {
		n = G.UIT.ROOT,
		config = {
			r = 0.1,
			padding = 0.0,
			h = 6,
			maxw = G.ROOM.T.w, -- Without this, it will just try to make the box really really wide for some reason. And with it, it fucks with the scaling.
			align = 'tm',
			colour = G.C.CLEAR
		},
		nodes = {
			{
				n = G.UIT.C,
				config = {
					r = 0.1,
					align = 'tm',
					-- colour = G.C.UI.TEXT_INACTIVE
				},
				nodes = {
					{
						n = G.UIT.R,
						config = {
							r = 0.1,
							align = 'tm'
						},
						nodes = {
							{
								n = G.UIT.C,
								config = {
									r = 0.1,
									align = 'tm'
								},
								nodes = {
									{
										-- I have to do this or it won't go in the middle.
										n = G.UIT.R,
										config = {
											align = 'tm'
										},
										nodes = {
											{	
												-- Changes apply on restart text
												n = G.UIT.T,
												config = {
														text = "Changes Apply On Restart",
														maxw = G.ROOM.T.w*0.9,
														scale = 0.5,
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
										-- I have to do this or it won't go in the middle.
										n = G.UIT.R,
										config = {
											align = 'cm'
										},
										nodes = {
											{
												-- HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH
												n = G.UIT.T,
												config = {
													text = "(Yes, I know this menu is messed up. Working with UI in this SUCKS.)",
													maxw = G.ROOM.T.w*0.9,
													-- colour = G.C.UI.TEXT_LIGHT,
													colour = G.C.UI.TEXT_INACTIVE,
													scale = 0.5,
													w = 3,
													h = 2,
													hover = true
												}
											}
										}
									},
									{
										-- Options columns wrapper
										n = G.UIT.C,
										config = { align = 'bm', id = 'cir_config_toggles' },
										nodes = {
											{
												-- First options column
												n = G.UIT.C,
												config = {
														align = 'tm',
														r = 0.4,
														padding = 0.25,
														colour = G.C.GREY,
														outline = 0.5,
														outline_colour = G.C.BLUE,
														hover = true,
														shadow= true
													},
												nodes = {
													{
														n = G.UIT.R,
														config = { align = 'tr', padding = 0.05 },
														nodes = {
															create_toggle({
																label = "Enable Title Screen Logo",
																w = 1.5,
																text_scale = 1.2,
																ref_table = CirnoMod.config,
																ref_value = 'titleLogo',
																-- callback = CirnoMod.callback_titleLogoToggle
															})
														}
													},
													{
														n = G.UIT.R,
														config = { align = 'tr', padding = 0.05 },
														nodes = {
															create_toggle({
																label = "Enable Mature References (Stream-Safe)",
																w = 1.5,
																text_scale = 1.2,
																ref_table = CirnoMod.config,
																ref_value = 'matureReferences',
																-- callback = CirnoMod.callback_matureReferencesToggle
															})
														}
													},
													{
														n = G.UIT.R,
														config = { align = 'tr', padding = 0.05 },
														nodes = {
															create_toggle({
																label = "Enable Playing Card Texture Replacements",
																w = 1.5,
																text_scale = 1.2,
																ref_table = CirnoMod.config,
																ref_value = 'playingCardTextures',
																-- callback = CirnoMod.callback_playingCardTexturesToggle
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
																text_scale = 1.2,
																ref_table = CirnoMod.config,
																ref_value = 'enhancerRenames',
																-- callback = CirnoMod.callback_enhancerRenamesToggle
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
																text_scale = 1.2,
																ref_table = CirnoMod.config,
																ref_value = 'deckRenames',
																-- callback = CirnoMod.callback_deckRenamesToggle
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
																text_scale = 1.2,
																ref_table = CirnoMod.config,
																ref_value = 'miscRenames',
																-- callback = CirnoMod.callback_miscRenamesToggle
															})
														}
													},
													{
														n = G.UIT.R,
														config = { align = 'tr', padding = 0.05 },
														nodes = {
															create_toggle({
																label = "Enable Additional Custom Jokers",
																w = 1.5,
																text_scale = 1.2,
																ref_table = CirnoMod.config,
																ref_value = 'addCustomJokers',
																-- callback = CirnoMod.callback_addCustomJokersToggle
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
													w = 0.2,
													h = 3
												}
											},
											{
												-- Second options column
												n = G.UIT.C,
												config = {
														align = 'tm',
														r = 0.4,
														padding = 0.25,
														colour = G.C.GREY,
														outline = 0.5,
														outline_colour = G.C.BLUE,
														hover = true,
														shadow= true
													},
												nodes = {
													{
														n = G.UIT.R,
														config = { align = 'tr', padding = 0.05 },
														nodes = {
															create_toggle({
																label = "Enable Title Screen Colours (Not Yet Implemented)",
																w = 1.5,
																text_scale = 0.6,
																ref_table = CirnoMod.config,
																ref_value = 'titleColours',
																-- callback = CirnoMod.callback_titleColoursToggle
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
																text_scale = 1.2,
																ref_table = CirnoMod.config,
																ref_value = 'malverkReplacements',
																-- callback = CirnoMod.callback_malverkReplacementsToggle
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
																text_scale = 1.2,
																ref_table = CirnoMod.config,
																ref_value = 'jokerRenames',
																-- callback = CirnoMod.callback_jokerRenamesToggle
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
																text_scale = 1.2,
																ref_table = CirnoMod.config,
																ref_value = 'blindRenames',
																-- callback = CirnoMod.callback_blindRenamesToggle
															})
														}
													},
													{
														n = G.UIT.R,
														config = { align = 'tr', padding = 0.05 },
														nodes = {
															create_toggle({
																label = "Enable Planets, Tarots & Spectral Renames",
																w = 1.5,
																text_scale = 1.2,
																ref_table = CirnoMod.config,
																ref_value = 'planetTarotSpectralRenames',
																-- callback = CirnoMod.callback_planetTarotSpectralRenamesToggle
															})
														}
													},
													{
														n = G.UIT.R,
														config = { align = 'tr', padding = 0.05 },
														nodes = {
															create_toggle({
																label = "Enable Additional Challenges",
																w = 1.5,
																text_scale = 1.2,
																ref_table = CirnoMod.config,
																ref_value = 'additionalChallenges',
																-- callback = CirnoMod.callback_additionalChallengesToggle
															})
														}
													},
													{
														n = G.UIT.R,
														config = { align = 'tr', padding = 0.05 },
														nodes = {
															create_toggle({
																label = "Enable Art Credit Tooltips",
																w = 1.5,
																text_scale = 1.2,
																ref_table = CirnoMod.config,
																ref_value = 'artCredits',
																-- callback = CirnoMod.callback_artCreditsToggle
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
				}
			}
		}
	}
end

return configUI