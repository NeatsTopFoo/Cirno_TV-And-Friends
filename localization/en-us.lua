local creditSources = {}

creditSources.cr_JokerArt = "Joker Art By"
creditSources.cr_DeckArt = "Deck Art By"
creditSources.cr_EnhancerArt = "Enhancer Art By"
creditSources.cr_GenericArt = "Art By"

-- Boo this individual please.
creditSources.NTF = "{X:purple,C:white}NopeTooFast{}"

-- Edit however you want, idk how you want it
creditSources.DTsun = "DaemonTsun"

creditSources.solga = "Solgalestia"
creditSources.nyong = "NyongNyong"
creditSources.turpix = "Turpix"
creditSources.thunk = "LocalThunk"
creditSources.unknown = "{X:black,C:white}Unknown{}"

-- So because of the way this bullshit works, we have to do one of these... For every unique case. Yes.
-- I'm mad. We could have done a lot more progammatically, but instead every time we run into a unique
-- circumstance, we have to add it here. Have fun sifting through this shit because apparently this.
-- is the way we have to do it.
return {
	descriptions = {
		Other = {
			----- Me -----
			jA_NTF={
				name= creditSources.cr_JokerArt,
				text= {creditSources.NTF}
			},
			gA_NTF={
				name= creditSources.cr_GenericArt,
				text={ creditSources.NTF}
			},
			jA_LocalThunk_NTFEdit={
				name= creditSources.cr_JokerArt,
				text={
					creditSources.thunk..", edited",
					"by "..creditSources.NTF
				}
			},
			jA_Unknown_NTFEdit={
				name= creditSources.cr_JokerArt,
				text={
					creditSources.unknown..", edited",
					"by "..creditSources.NTF
				}
			},
			
			----- You -----
			jA_DaemonTsun={
				name= creditSources.cr_JokerArt,
				text={creditSources.DTsun}
			},
			dA_DaemonTsun={
				name= creditSources.cr_DeckArt,
				text={creditSources.DTsun}
			},
			eA_DaemonTsun={
				name= creditSources.cr_EnhancerArt,
				text={creditSources.DTsun}
			},
			gA_DaemonTsun={
				name= creditSources.cr_GenericArt,
				text={creditSources.DTsun}
			},
			jA_DaemonTsun_NTF_Both={
				name= creditSources.cr_JokerArt,
				text={creditSources.DTsun.." &", creditSources.NTF}
			},
			jA_DaemonTsun_NTFEDit={
				name= creditSources.cr_JokerArt,
				text={
					creditSources.DTsun..", edited",
					"by "..creditSources.NTF
				}
			},
			jA_DaemonTsun_BigNTFEdit={
				name= creditSources.cr_JokerArt,
				text={
					creditSources.DTsun..", heavily",
					"edited by "..creditSources.NTF
				}
			},
			jA_LocalThunk_DaemonTsunEdit={
				name= creditSources.cr_JokerArt,
				text={
					creditSources.DTsun.." edit of",
					creditSources.thunk.." art."
				}
			},
			gA_LocalThunk_DaemonTsunEdit={
				name= creditSources.cr_GenericArt,
				text={
					creditSources.DTsun.." edit of",
					creditSources.thunk.." art."
				}
			},
			
			----- Wait, what -----
			jA_Misprint={
				name= creditSources.cr_JokerArt,
				text={
					"{C:blue}Cirno_TV{}, edited", -- Yes, Cirno drew cirBairy.
					"by "..creditSources.NTF  -- ...Formally crediting him is funnier, trust me
				}
			},
			jA_JustIRLCirno={
				name= creditSources.cr_JokerArt,
				text={
					"{s:0.8}...I don't know what to",
					"{s:0.8}say, it's literally just",
					"{s:0.8}a picture of {s:0.8,C:blue}Cirno_TV{}."
				}
			},
			jA_Egg={
				name= creditSources.cr_JokerArt,
				text={
					"{s:0.8}...I don't know what to",
					"{s:0.8}say, it's literally just",
					"{s:0.8}a picture of {s:0.8,C:blue}Cirno_TV{}.",
					"{s:0.8}DEFINITELY real, not an",
					"{s:0.8}edit of any kind."
				}
			},
			jA_Hack={
				name= creditSources.cr_JokerArt,
				text={
					"{s:0.6}...I don't know what to",
					"{s:0.6}say, it's literally just",
					"{s:0.6}a screenshot of the",
					"{s:0.6}stream."
				}
			},
			jA_Baseball={
				name= creditSources.cr_JokerArt,
				text={
					"{s:0.8}Literally how do I ",
					"{s:0.8}credit this, it's a",
					"{s:0.8}Seinfeld screenshot."
				}
			},
			
			----- Other -----
			jA_Mime={
				name= creditSources.cr_JokerArt,
				text={ creditSources.nyong }
			},
			jA_MikuTheClown={
				name= creditSources.cr_JokerArt,
				text={
					creditSources.solga..", edited",
					"by "..creditSources.NTF
				}
			},
			jA_BocchiTheRock={
				name= creditSources.cr_JokerArt,
				text={
					creditSources.turpix..", edited",
					"by "..creditSources.NTF
				}
			},
			jA_Unknown={
				name= creditSources.cr_JokerArt,
				text= {creditSources.unknown}
			},
			eA_Unknown={
				name= creditSources.cr_EnhancerArt,
				text= {creditSources.unknown}
			},
			jA_Unknown_LocalThunkEdit={
				name= creditSources.cr_JokerArt,
				text= {
					creditSources.unknown.." edit",
					"of "..creditSources.thunk.." art."
				}
			}
		}
	},
}