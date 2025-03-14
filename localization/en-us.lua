local creditSources = {}

creditSources.cr_JokerArt = "Joker Art By"
creditSources.cr_DeckArt = "Deck Art By"
creditSources.cr_EnhancerArt = "Enhancer Art By"
creditSources.cr_GenericArt = "Art By"

-- Boo this individual please.
creditSources.NTF = "{X:purple,C:white}NopeTooFast{}"

-- Edit however you want, idk how you want it
creditSources.DTsun = "DaemonTsun"

-- Have to do underscores here because X doesn't work with spaces.
-- As a result, we end up with this nonsense.
creditSources.CommunityContrib = "{s:0.6,X:inactive,C:white}(Cirno_TV{s:0.6,X:inactive,C:inactive}_{s:0.6,X:inactive,C:white}Community-Contributed{s:0.6,X:inactive,C:inactive}_{s:0.6,X:inactive,C:white}Idea)"

-- The funny increases exponentially.
creditSources.CirnoTV = "{X:chips,C:white}Cirno_TV{}"
creditSources.CirnoTV_smol = "{s:0.8,X:chips,C:white}Cirno_TV{}"

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
			----- We need this bullshit because of how this dumb fucking system works -----
			----- The contempt I feel for this setup is beyond human comprehension.   -----
			----- Why are things this way? Why must LocalThunk torment us so? In this -----
			----- essay I will														  -----
			Joker_Art_By = { text = { creditSources.cr_JokerArt } },
			Deck_Art_By = { text = { creditSources.cr_DeckArt } },
			Enhancer_Art_By = { text = { creditSources.cr_EnhancerArt } },
			Generic_Art_By = { text = { creditSources.cr_GenericArt } },
			
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
			gA_BlackHole={
				name= creditSources.cr_JokerArt,
				text={
					creditSources.thunk.." & "..creditSources.unknown..",",
					"edited by "..creditSources.NTF,
					creditSources.CommunityContrib
				}
			},
			
			----- You -----
			jA_DaemonTsun={
				name= creditSources.cr_JokerArt,
				text={creditSources.DTsun}
			},
			jA_DaemonTsun_ComCon={
				name= creditSources.cr_JokerArt,
				text={
					creditSources.DTsun,
					creditSources.CommunityContrib
				}
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
			gA_DaemonTsunComCon={
				name= creditSources.cr_GenericArt,
				text={
					creditSources.DTsun,
					creditSources.CommunityContrib
				}
			},
			jA_DaemonTsun_NTF_Both={
				name= creditSources.cr_JokerArt,
				text={creditSources.DTsun.." &", creditSources.NTF}
			},
			jA_DaemonTsun_NTFEdit={
				name= creditSources.cr_JokerArt,
				text={
					creditSources.DTsun..", edited",
					"by "..creditSources.NTF
				}
			},
			gA_DaemonTsun_NTFEdit={
				name= creditSources.cr_GenericArt,
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
			gA_DaemonTsun_BigNTFEdit={
				name= creditSources.cr_GenericArt,
				text={
					creditSources.DTsun..", heavily",
					"edited by "..creditSources.NTF
				}
			},
			gA_DaemonTsun_BigNTFEdit_ComCon={
				name= creditSources.cr_GenericArt,
				text={
					creditSources.DTsun..", heavily",
					"edited by "..creditSources.NTF,
					creditSources.CommunityContrib
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
					creditSources.CirnoTV ..", edited", -- Yes, Cirno drew cirBairy.
					"by "..creditSources.NTF  -- ...Formally crediting him is funnier, trust me
				}
			},
			jA_JustIRLCirno={
				name= creditSources.cr_JokerArt,
				text={
					"{s:0.8}...I don't know what to",
					"{s:0.8}say, it's literally just",
					"{s:0.8}a picture of "..creditSources.CirnoTV_smol.."{s:0.8}."
				}
			},
			jA_Egg={
				name= creditSources.cr_JokerArt,
				text={
					"{s:0.8}...I don't know what to",
					"{s:0.8}say, it's literally just",
					"{s:0.8}a picture of "..creditSources.CirnoTV_smol.."{s:0.8}.",
					"{s:0.8,E:1}DEFINITELY{s:0.8} real, not an",
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
					"{s:0.8}still from Seinfeld."
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