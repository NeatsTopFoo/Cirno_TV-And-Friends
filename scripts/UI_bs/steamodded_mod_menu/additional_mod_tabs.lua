-- Oh boy, do I sure love working with the bullshit UI in this.
local creditLinkBt_w = 0.9
local creditLinkBt_h = 0.5

local extraUI = function()
	return {
		{
			label = 'Credits',
			tab_definition_function = function()
			return {
					n = G.UIT.ROOT,
					config = {
						r = 0.1,
						padding = 0.0,
						align = 'tm',
						colour = G.C.CLEAR
					},
					nodes = {
						{
							n = G.UIT.R,
							config = { 
								r = 0.1,
								padding = 0.2,
								align = 'cm',
								colour = G.C.BLACK
							},
							nodes = {
								{
									n = G.UIT.C,
									config = { align = 'cm' },
									nodes = {
										{
											n = G.UIT.R,
											config = { align = 'tm' },
											nodes = {{
												n = G.UIT.T,
												config = {
														text = "This Mod Was Made Possible By:",
														maxw = G.ROOM.T.w*0.9,
														scale = 0.8,
														colour = G.C.TEXT_LIGHT,
														align = 'tm',
														hover = true
													}
											}}
										},
										{
											n = G.UIT.R,
											config = { align = 'tm' },
											nodes = {{
												n = G.UIT.B,
												config = {
													colour = G.C.CLEAR,
													w = 0.1,
													h = 0.3
												}
											}}
										},
										{
											n = G.UIT.R,
											config = { align = 'cm' },
											nodes = {
												{
													n = G.UIT.C,
													config = { align = 'cm' },
													nodes = {
														{
															n = G.UIT.R,
															config = { align = 'cm' },
															nodes = {
																{
																	n = G.UIT.C,
																	config = { align = 'tm' },
																	nodes = {
																	{
																		n = G.UIT.R,
																		config = { align = 'cm' },
																		nodes = { 
																			{
																				n = G.UIT.T,
																				config = {
																						text = "DaemonTsun ",
																						maxw = G.ROOM.T.w*0.9,
																						scale = 0.4,
																						colour = G.C.UI.TEXT_LIGHT,
																						align = 'tm',
																						hover = true
																					}
																			}, {
																			n = G.UIT.C,
																			config = { align = 'cm' },
																			nodes = {
																				UIBox_button{
																					button = 'cir_credit_daemonTsun_link',
																					colour = CirnoMod.miscItems.colours.cirCyan,
																					label = {"BSky"},
																					minh = creditLinkBt_h,
																					minw = creditLinkBt_w}
																			}
																		} }
																	}, {
																		n = G.UIT.R,
																		config = { align = 'cm' },
																		nodes = { {
																			n = G.UIT.T,
																			config = {
																					text = "Started the mod, Majority of Art, Ideas + Misc.",
																					maxw = G.ROOM.T.w*0.9,
																					scale = 0.3,
																					colour = G.C.UI.TEXT_INACTIVE,
																					align = 'tm',
																					hover = true
																				}
																		} }
																	} }
																},
																{
																	-- Spacer
																	n = G.UIT.B,
																	config = {
																		colour = G.C.CLEAR,
																		w = 0.4,
																		h = 0.1
																	}
																},
																{
																	n = G.UIT.C,
																	config = { align = 'tm' },
																	nodes = {
																	{
																		n = G.UIT.R,
																		config = { align = 'cm' },
																		nodes = { 
																			{
																				n = G.UIT.T,
																				config = {
																						text = "NopeTooFast ",
																						maxw = G.ROOM.T.w*0.9,
																						scale = 0.4,
																						colour = G.C.UI.TEXT_LIGHT,
																						align = 'tm',
																						hover = true
																					}
																			}, {
																			n = G.UIT.C,
																			config = { align = 'cm' },
																			nodes = {
																				UIBox_button{
																					button = 'cir_credit_ntf_link',
																					colour = CirnoMod.miscItems.colours.cirCyan,
																					label = {"BSky"},
																					minh = creditLinkBt_h,
																					minw = creditLinkBt_w}
																				}
																			}, {
																				-- Spacer
																				n = G.UIT.B,
																				config = {
																					colour = G.C.CLEAR,
																					w = 0.15,
																					h = 0.1
																				}
																			}, {
																				n = G.UIT.C,
																				config = { align = 'cm' },
																				nodes = {
																					UIBox_button{
																						button = 'cir_credit_ntf_link2',
																						colour = G.C.PURPLE,
																						label = {"Twitch"},
																						minh = creditLinkBt_h,
																						minw = creditLinkBt_w}
																					}
																			} 
																		}
																	}, {
																		n = G.UIT.R,
																		config = { align = 'cm' },
																		nodes = { {
																			n = G.UIT.T,
																			config = {
																					text = "Programming, Some art, Ideas + Misc.",
																					maxw = G.ROOM.T.w*0.9,
																					scale = 0.3,
																					colour = G.C.UI.TEXT_INACTIVE,
																					align = 'tm',
																					hover = true
																				}
																		} }
																	} }
																},
																{
																	-- Spacer
																	n = G.UIT.B,
																	config = {
																		colour = G.C.CLEAR,
																		w = 0.4,
																		h = 0.1
																	}
																},
																{
																	n = G.UIT.C,
																	config = { align = 'tm' },
																	nodes = {
																	{
																		n = G.UIT.R,
																		config = { align = 'cm' },
																		nodes = { 
																			{
																				n = G.UIT.T,
																				config = {
																						text = "Cirno_TV ",
																						maxw = G.ROOM.T.w*0.9,
																						scale = 0.4,
																						colour = G.C.UI.TEXT_LIGHT,
																						align = 'tm',
																						hover = true
																					}
																			}, {
																			n = G.UIT.C,
																			config = { align = 'cm' },
																			nodes = {
																				UIBox_button{
																					button = 'cir_credit_cirno_link',
																					colour = CirnoMod.miscItems.colours.cirCyan,
																					label = {"BSky"},
																					minh = creditLinkBt_h,
																					minw = creditLinkBt_w}
																				}
																			}, {
																				-- Spacer
																				n = G.UIT.B,
																				config = {
																					colour = G.C.CLEAR,
																					w = 0.15,
																					h = 0.1
																				}
																			}, {
																			n = G.UIT.C,
																			config = { align = 'cm' },
																			nodes = {
																				UIBox_button{
																					button = 'cir_credit_cirno_link2',
																					colour = G.C.PURPLE,
																					label = {"Twitch"},
																					minh = creditLinkBt_h,
																					minw = creditLinkBt_w}
																			}
																		} }
																	}, {
																		n = G.UIT.R,
																		config = { align = 'cm' },
																		nodes = { {
																			n = G.UIT.T,
																			config = {
																					text = "Art used for Misprint + Is the doofy guy you see",
																					maxw = G.ROOM.T.w*0.9,
																					scale = 0.3,
																					colour = G.C.UI.TEXT_INACTIVE,
																					align = 'tm',
																					hover = true
																				}
																		} }
																	}, {
																		n = G.UIT.R,
																		config = { align = 'cm' },
																		nodes = { {
																			n = G.UIT.T,
																			config = {
																					text = "on some Jokers, Lmao Get Credited Idiot",
																					maxw = G.ROOM.T.w*0.9,
																					scale = 0.3,
																					colour = G.C.UI.TEXT_INACTIVE,
																					align = 'tm',
																					hover = true
																				}
																		} }
																	} }
																}
															}
														},
														{
															n = G.UIT.R,
															config = { align = 'cm' },
															nodes = { {	-- Spacer
																n = G.UIT.B,
																config = {
																	colour = G.C.CLEAR,
																	w = 0.1,
																	h = 0.25
																}
															}}
														},
														{
															n = G.UIT.R,
															config = { align = 'cm' },
															nodes = {
																{
																	n = G.UIT.C,
																	config = { align = 'tm' },
																	nodes = {
																	{
																		n = G.UIT.R,
																		config = { align = 'cm' },
																		nodes = { 
																			{
																				n = G.UIT.T,
																				config = {
																						text = "Cardsauce Devs & Artists ",
																						maxw = G.ROOM.T.w*0.9,
																						scale = 0.4,
																						colour = G.C.UI.TEXT_LIGHT,
																						align = 'tm',
																						hover = true
																					}
																			}, {
																			n = G.UIT.C,
																			config = { align = 'cm' },
																			nodes = {
																				UIBox_button{
																					button = 'cir_credit_csau_link',
																					colour = G.C.GREY,
																					label = {"GitHub"},
																					minh = creditLinkBt_h,
																					minw = creditLinkBt_w}
																			}
																		} }
																	}, {
																		n = G.UIT.R,
																		config = { align = 'cm' },
																		nodes = { {
																			n = G.UIT.T,
																			config = {
																					text = "Art used for DNA (by Gote),",
																					maxw = G.ROOM.T.w*0.9,
																					scale = 0.3,
																					colour = G.C.UI.TEXT_INACTIVE,
																					align = 'tm',
																					hover = true
																				}
																		} }
																	}, {
																		n = G.UIT.R,
																		config = { align = 'cm' },
																		nodes = { {
																			n = G.UIT.T,
																			config = {
																					text = "as well as some code & mechanic inspiration",
																					maxw = G.ROOM.T.w*0.9,
																					scale = 0.3,
																					colour = G.C.UI.TEXT_INACTIVE,
																					align = 'tm',
																					hover = true
																				}
																		} }
																	} }
																},
																{
																	-- Spacer
																	n = G.UIT.B,
																	config = {
																		colour = G.C.CLEAR,
																		w = 0.4,
																		h = 0.1
																	}
																},
																{
																	n = G.UIT.C,
																	config = { align = 'tm' },
																	nodes = {
																	{
																		n = G.UIT.R,
																		config = { align = 'cm' },
																		nodes = { 
																			{
																				n = G.UIT.T,
																				config = {
																						text = "Cryptid Devs ",
																						maxw = G.ROOM.T.w*0.9,
																						scale = 0.4,
																						colour = G.C.UI.TEXT_LIGHT,
																						align = 'tm',
																						hover = true
																					}
																			}, {
																			n = G.UIT.C,
																			config = { align = 'cm' },
																			nodes = {
																				UIBox_button{
																					button = 'cir_credit_cry_link',
																					colour = G.C.GREY,
																					label = {"GitHub"},
																					minh = creditLinkBt_h,
																					minw = creditLinkBt_w}
																			}
																		} }
																	}, {
																		n = G.UIT.R,
																		config = { align = 'cm' },
																		nodes = { {
																			n = G.UIT.T,
																			config = {
																					text = "Code & some mechanic inspirations",
																					maxw = G.ROOM.T.w*0.9,
																					scale = 0.3,
																					colour = G.C.UI.TEXT_INACTIVE,
																					align = 'tm',
																					hover = true
																				}
																		} }
																	} }
																},
																{
																	-- Spacer
																	n = G.UIT.B,
																	config = {
																		colour = G.C.CLEAR,
																		w = 0.4,
																		h = 0.1
																	}
																},
																{
																	n = G.UIT.C,
																	config = { align = 'tm' },
																	nodes = {
																	{
																		n = G.UIT.R,
																		config = { align = 'cm' },
																		nodes = { 
																			{
																				n = G.UIT.T,
																				config = {
																						text = "Trance Devs ",
																						maxw = G.ROOM.T.w*0.9,
																						scale = 0.4,
																						colour = G.C.UI.TEXT_LIGHT,
																						align = 'tm',
																						hover = true
																					}
																			}, {
																			n = G.UIT.C,
																			config = { align = 'cm' },
																			nodes = {
																				UIBox_button{
																					button = 'cir_credit_trance_link',
																					colour = G.C.GREY,
																					label = {"GitHub"},
																					minh = creditLinkBt_h,
																					minw = creditLinkBt_w}
																			}
																		} }
																	}, {
																		n = G.UIT.R,
																		config = { align = 'cm' },
																		nodes = { {
																			n = G.UIT.T,
																			config = {
																					text = "Code inspiration for changing the main menu vortex colours",
																					maxw = G.ROOM.T.w*0.9,
																					scale = 0.3,
																					colour = G.C.UI.TEXT_INACTIVE,
																					align = 'tm',
																					hover = true
																				}
																		} }
																	} }
																}
															}
														},
														{
															n = G.UIT.R,
															config = { align = 'cm' },
															nodes = { {	-- Spacer
																n = G.UIT.B,
																config = {
																	colour = G.C.CLEAR,
																	w = 0.1,
																	h = 0.25
																}
															}}
														},
														{
															n = G.UIT.R,
															config = { align = 'cm' },
															nodes = {
																{
																	n = G.UIT.C,
																	config = { align = 'tm' },
																	nodes = {
																	{
																		n = G.UIT.R,
																		config = { align = 'cm' },
																		nodes = {
																			{
																				n = G.UIT.T,
																				config = {
																						text = "Turpix_00 ",
																						maxw = G.ROOM.T.w*0.9,
																						scale = 0.4,
																						colour = G.C.UI.TEXT_LIGHT,
																						align = 'tm',
																						hover = true
																					}
																			}, {
																				n = G.UIT.C,
																				config = { align = 'cm' },
																				nodes = {
																					UIBox_button{
																						button = 'cir_credit_turpix_link1',
																						colour = CirnoMod.miscItems.colours.bbBlack,
																						label = {"Twitter"},
																						minh = creditLinkBt_h,
																						minw = creditLinkBt_w}
																					}
																			}, {
																				-- Spacer
																				n = G.UIT.B,
																				config = {
																					colour = G.C.CLEAR,
																					w = 0.15,
																					h = 0.1
																				}
																			}, {
																				n = G.UIT.C,
																				config = { align = 'cm' },
																				nodes = {
																					UIBox_button{
																						button = 'cir_credit_turpix_link2',
																						colour = G.C.FILTER,
																						label = {"Nexus"},
																						minh = creditLinkBt_h,
																						minw = creditLinkBt_w}
																					}
																			}
																		}
																	}, {
																		n = G.UIT.R,
																		config = { align = 'cm' },
																		nodes = { {
																			n = G.UIT.T,
																			config = {
																					text = "Art edited for Stone Joker",
																					maxw = G.ROOM.T.w*0.9,
																					scale = 0.3,
																					colour = G.C.UI.TEXT_INACTIVE,
																					align = 'tm',
																					hover = true
																				}
																		} }
																	} }
																},
																{
																	-- Spacer
																	n = G.UIT.B,
																	config = {
																		colour = G.C.CLEAR,
																		w = 0.4,
																		h = 0.1
																	}
																},
																{
																	n = G.UIT.C,
																	config = { align = 'tm' },
																	nodes = {
																	{
																		n = G.UIT.R,
																		config = { align = 'cm' },
																		nodes = { 
																			{
																				n = G.UIT.T,
																				config = {
																						text = "Solgalestia ",
																						maxw = G.ROOM.T.w*0.9,
																						scale = 0.4,
																						colour = G.C.UI.TEXT_LIGHT,
																						align = 'tm',
																						hover = true
																					}
																			}, {
																			n = G.UIT.C,
																			config = { align = 'cm' },
																			nodes = {
																				UIBox_button{
																					button = 'cir_credit_solgalestia_link',
																					colour = G.C.FILTER,
																					label = {"Nexus"},
																					minh = creditLinkBt_h,
																					minw = creditLinkBt_w}
																			}
																		} }
																	}, {
																		n = G.UIT.R,
																		config = { align = 'cm' },
																		nodes = { {
																			n = G.UIT.T,
																			config = {
																					text = "Art edited for the Chaos the Clown Joker",
																					maxw = G.ROOM.T.w*0.9,
																					scale = 0.3,
																					colour = G.C.UI.TEXT_INACTIVE,
																					align = 'tm',
																					hover = true
																				}
																		} }
																	} }
																},
																{
																	-- Spacer
																	n = G.UIT.B,
																	config = {
																		colour = G.C.CLEAR,
																		w = 0.4,
																		h = 0.1
																	}
																},
																{
																	n = G.UIT.C,
																	config = { align = 'tm' },
																	nodes = {
																	{
																		n = G.UIT.R,
																		config = { align = 'cm' },
																		nodes = { 
																			{
																				n = G.UIT.T,
																				config = {
																						text = "Solgryn ",
																						maxw = G.ROOM.T.w*0.9,
																						scale = 0.4,
																						colour = G.C.UI.TEXT_LIGHT,
																						align = 'tm',
																						hover = true
																					}
																			}, {
																			n = G.UIT.C,
																			config = { align = 'cm' },
																			nodes = {
																				UIBox_button{
																					button = 'cir_credit_solgryn_link',
																					colour = G.C.PURPLE,
																					label = {"Twitch"},
																					minh = creditLinkBt_h,
																					minw = creditLinkBt_w}
																			}
																		} }
																	}, {
																		n = G.UIT.R,
																		config = { align = 'cm' },
																		nodes = { {
																			n = G.UIT.T,
																			config = {
																					text = "OG Artist of the 8-bit looking Cirno",
																					maxw = G.ROOM.T.w*0.9,
																					scale = 0.3,
																					colour = G.C.UI.TEXT_INACTIVE,
																					align = 'tm',
																					hover = true
																				}
																		} }
																	}, {
																		n = G.UIT.R,
																		config = { align = 'cm' },
																		nodes = { {
																			n = G.UIT.T,
																			config = {
																					text = "emotes like cirGreed, cirLove & such",
																					maxw = G.ROOM.T.w*0.9,
																					scale = 0.3,
																					colour = G.C.UI.TEXT_INACTIVE,
																					align = 'tm',
																					hover = true
																				}
																		} }
																	} }
																}
															}
														},
														{
															n = G.UIT.R,
															config = { align = 'cm' },
															nodes = { {	-- Spacer
																n = G.UIT.B,
																config = {
																	colour = G.C.CLEAR,
																	w = 0.1,
																	h = 0.25
																}
															}}
														},
														{
															n = G.UIT.R,
															config = { align = 'cm' },
															nodes = {
																{
																	n = G.UIT.C,
																	config = { align = 'tm' },
																	nodes = {
																	{
																		n = G.UIT.R,
																		config = { align = 'cm' },
																		nodes = { 
																			{
																				n = G.UIT.T,
																				config = {
																						text = "RadicalHighway ",
																						maxw = G.ROOM.T.w*0.9,
																						scale = 0.4,
																						colour = G.C.UI.TEXT_LIGHT,
																						align = 'tm',
																						hover = true
																					}
																			}, {
																			n = G.UIT.C,
																			config = { align = 'cm' },
																			nodes = {
																				UIBox_button{
																					button = 'cir_credit_radicalHighway_link',
																					colour = G.C.PURPLE,
																					label = {"Twitch"},
																					minh = creditLinkBt_h,
																					minw = creditLinkBt_w}
																			}
																		} }
																	}, {
																		n = G.UIT.R,
																		config = { align = 'cm' },
																		nodes = { {
																			n = G.UIT.T,
																			config = {
																					text = "OG Artist of the other Cirno emotes used",
																					maxw = G.ROOM.T.w*0.9,
																					scale = 0.3,
																					colour = G.C.UI.TEXT_INACTIVE,
																					align = 'tm',
																					hover = true
																				}
																		} }
																	} }
																},
																{
																	-- Spacer
																	n = G.UIT.B,
																	config = {
																		colour = G.C.CLEAR,
																		w = 0.4,
																		h = 0.1
																	}
																},
																{
																	n = G.UIT.C,
																	config = { align = 'tm' },
																	nodes = {
																	{
																		n = G.UIT.R,
																		config = { align = 'cm' },
																		nodes = { 
																			{
																				n = G.UIT.T,
																				config = {
																						text = "Muddleee ",
																						maxw = G.ROOM.T.w*0.9,
																						scale = 0.4,
																						colour = G.C.UI.TEXT_LIGHT,
																						align = 'tm',
																						hover = true
																					}
																			}, {
																			n = G.UIT.C,
																			config = { align = 'cm' },
																			nodes = {
																				UIBox_button{
																					button = 'cir_credit_muddleee_link',
																					colour = G.C.GREY,
																					label = {"GitHub"},
																					minh = creditLinkBt_h,
																					minw = creditLinkBt_w}
																			}
																		} }
																	}, {
																		n = G.UIT.R,
																		config = { align = 'cm' },
																		nodes = { {
																			n = G.UIT.T,
																			config = {
																					text = "Art edited for The Sun Tarot",
																					maxw = G.ROOM.T.w*0.9,
																					scale = 0.3,
																					colour = G.C.UI.TEXT_INACTIVE,
																					align = 'tm',
																					hover = true
																				}
																		} }
																	} }
																},
																{
																	-- Spacer
																	n = G.UIT.B,
																	config = {
																		colour = G.C.CLEAR,
																		w = 0.4,
																		h = 0.1
																	}
																},
																{
																	n = G.UIT.C,
																	config = { align = 'tm' },
																	nodes = {
																	{
																		n = G.UIT.R,
																		config = { align = 'cm' },
																		nodes = { 
																			{
																				n = G.UIT.C,
																				config = { align = 'cm' },
																				nodes = {
																					{
																						n = G.UIT.R,
																						config = { align = 'cm' },
																						nodes = { {
																						n = G.UIT.T,
																						config = {
																								text = "Aikoyori ",
																								maxw = G.ROOM.T.w*0.9,
																								scale = 0.4,
																								colour = G.C.UI.TEXT_LIGHT,
																								align = 'tm',
																								hover = true
																							}
																						} }
																					}
																				}
																			}, {
																			n = G.UIT.C,
																			config = { align = 'cm' },
																			nodes = {
																				UIBox_button{
																					button = 'cir_credit_aikoyori_link',
																					colour = CirnoMod.miscItems.colours.cirCyan,
																					label = {"BSky"},
																					minh = creditLinkBt_h,
																					minw = creditLinkBt_w}
																			}
																		} }
																	}, {
																		n = G.UIT.R,
																		config = { align = 'cm' },
																		nodes = { {
																			n = G.UIT.T,
																			config = {
																					text = "Help with code & troubleshooting",
																					maxw = G.ROOM.T.w*0.9,
																					scale = 0.3,
																					colour = G.C.UI.TEXT_INACTIVE,
																					align = 'tm',
																					hover = true
																				}
																		} }
																	} }
																}
															}
														}
													}
												}
											}
										},
										{
											n = G.UIT.R,
											config = { align = 'tm' },
											nodes = {{
												n = G.UIT.B,
												config = {
													colour = G.C.CLEAR,
													w = 0.1,
													h = 0.3
												}
											}}
										},
										{
											n = G.UIT.R,
											config = { align = 'cm' },
											nodes = { {
											n = G.UIT.T,
											config = {
													text = "+ Many, many Balatro modding community members, too many to list here x.x",
													maxw = G.ROOM.T.w*0.9,
													scale = 0.25,
													colour = G.C.UI.TEXT_LIGHT,
													align = 'tm',
													hover = true
												}
											} }
										}
									}
								}
							}
						}
					}
				}
			end
		}
	}
end

G.FUNCS.cir_credit_daemonTsun_link = function(e)
	love.system.openURL(CirnoMod.miscItems.creditLinks.daemonTsun)
end

G.FUNCS.cir_credit_ntf_link = function(e)
	love.system.openURL(CirnoMod.miscItems.creditLinks.ntf_bsky)
end

G.FUNCS.cir_credit_ntf_link2 = function(e)
	love.system.openURL(CirnoMod.miscItems.creditLinks.ntf_twch)
end

G.FUNCS.cir_credit_cirno_link = function(e)
	love.system.openURL(CirnoMod.miscItems.creditLinks.cirnotv_bsky)
end

G.FUNCS.cir_credit_cirno_link2 = function(e)
	love.system.openURL(CirnoMod.miscItems.creditLinks.cirnotv_twch)
end

G.FUNCS.cir_credit_csau_link = function(e)
	love.system.openURL(CirnoMod.miscItems.creditLinks.cardsauce)
end

G.FUNCS.cir_credit_cry_link = function(e)
	love.system.openURL(CirnoMod.miscItems.creditLinks.cryptid)
end

G.FUNCS.cir_credit_trance_link = function(e)
	love.system.openURL(CirnoMod.miscItems.creditLinks.trance)
end

G.FUNCS.cir_credit_turpix_link1 = function(e)
	love.system.openURL(CirnoMod.miscItems.creditLinks.turpix_tw)
end

G.FUNCS.cir_credit_turpix_link2 = function(e)
	love.system.openURL(CirnoMod.miscItems.creditLinks.turpix_nm)
end

G.FUNCS.cir_credit_solgalestia_link = function(e)
	love.system.openURL(CirnoMod.miscItems.creditLinks.solgalestia)
end

G.FUNCS.cir_credit_solgryn = function(e)
	love.system.openURL(CirnoMod.miscItems.creditLinks.solgryn)
end

G.FUNCS.cir_credit_radicalhighway = function(e)
	love.system.openURL(CirnoMod.miscItems.creditLinks.radicalhighway)
end

G.FUNCS.cir_credit_muddleee = function(e)
	love.system.openURL(CirnoMod.miscItems.creditLinks.muddleee)
end

G.FUNCS.cir_credit_aikoyori = function(e)
	love.system.openURL(CirnoMod.miscItems.creditLinks.aikoyori)
end

return extraUI