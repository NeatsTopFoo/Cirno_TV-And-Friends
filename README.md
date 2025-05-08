# Cirno_TV And Friends
A Balatro mod themed around [Cirno_TV](https://www.twitch.tv/Cirno_TV/), with various references & memes.

**WARNING:** Cirno_TV & Friends isn't explicitly an NSFW-oriented mod, but it does contain a handful of overt, (hopefully) stream-safe mature references in relation to community inside jokes (most particularly those with varying degrees of sexual connotation). This mod is *NOT* intended for children. By default, these (especially overt) mature references are significantly toned-down/altered, with the intent of having reduced mature references (in both number and intensity) encounterable in gameplay for anyone who wants to experience the mod, but is not particularly as interested in the some of the more mature references (and/or wants to stream it, but does not want to have that kind of stuff on their stream) - These changes can be adjusted in the mod's config settings, via the Mature References setting (Config setting changes require a game restart to take effect).

![CTVaF Logo](https://i.imgur.com/CcRk9nq.png)

**Cirno_TV & Friends** is a collaborative effort between [DaemonTsun](https://bsky.app/profile/daemontsun.bsky.social) & [NοpeTooFast](https://bsky.app/profile/nopetoofast.bsky.expert), which retextures existing Jokers and adds some new ones, as well as various other changes such as some Joker names & descriptions, retextures of some enhancers & all blinds, and more!

DaemonTsun's art contributions are public domain - Some memes or pictures are not by him and copied as is, with some Jokers only being slightly edited. Further credits are available at the bottom of this README. Original Balatro art is property of LocalThunk.

![Showcase of Blueprint](https://i.imgur.com/Y87Kxfm.png)

![Showcase of Gluttonous Joker](https://i.imgur.com/du2Qrgf.png)

![Showcase of Playing Cards](https://i.imgur.com/mV5wuaO.png)

**Cirno_TV & Friends** currently:
- Retextures:
  - 121 Jokers (Some get filtered/altered by the Mature Reference setting depending on what it is set to.)
  - All Blind Chips
  - All Seals
  - All Planet Cards
  - 13 Booster Packs
  - 11 Tags
  - 7 Spectral Cards
  - 6 Tarot Cards
  - 6 Decks
  - 4 Enhancements
  - The title screen

- Renames & Alters Descriptions Of:
  - All Seals
  - All Planet Cards
  - Most blinds
  - A significant amount of retextured Jokers
  - 6 Tarot Cards
  - 6 Spectral Cards
  - 5 Tags
  - 1 Enhancement

- Adds:
  - Various fun flavour text to numerous items
  - Some custom playing card skins
  - 11 custom Jokers
  - 1 custom Spectral Card
  - 1 custom Challenge

All retextures and renames are optional and they're somewhat mix n' match (You can't have it rename some Jokers enabled in the texture pack and not others. You either get all Joker renames or none - But you do otherwise have decent control over it) - But all additions are fully optional.

## Installation
This mod requires [Lovely](https://github.com/ethangreen-dev/lovely-injector), the latest version of [Steammodded](https://github.com/Steamodded/smods) & the latest version of [Malverk](https://github.com/Eremel/Malverk). Without these dependencies, this mod will not function.

**IMPORTANT:** At the current time of writing, Steamodded's install instructions start by talking about installing Lovely and Malverk does not explicitly state its install instructions, which may be confusing for players newer to modding Balatro - So included below are some installation steps intended to be followed from the conclusion of **[following Steamodded's tutorial on installing both Lovely & Steamodded](https://github.com/Steamodded/smods/wiki)**, which confusingly is where you should start, because again, it instructs you how to install Lovely first  ...Yeah .-. - *To be safe, ensure that Balatro runs properly both after installing Lovely and after installing Steamodded*:

**Installing Malverk:**
- After following the previously linked tutorial, download the latest version of Malverk from its releases page (At time of writing, getting Malverk's "Source code" .zip *should* be fine (and is recommended) unless that page explicitly states something specific for you to download instead).
- Either by extracting the contents of or otherwise opening the Malverk .zip, you should get a folder of the same name as the zip file (or similar). Move that folder to the .../Balatro/mods directory you created in the previous tutorial.
- (To be safe) Ensure that Balatro runs properly. 

**Installing this mod:**
- Download the latest version of this mod from the releases page.
- Either by extracting the contents of or otherwise opening this mod's .zip, you should get a folder of the same name as the zip file (or similar). Move that folder to the .../Balatro/mods directory you created in the previous tutorial.
- You have finished installing Cirno & Friends. *Changes may not immediately appear* as they need to be enabled in both the Steamodded mod menu (Specifically in this mod's config, although they are set to enabled by default) and in Malverk's textures menu for them to appear in-game.
- *IMPORTANT*: Because of a bug in the current release of Malverk (at the time of writing), enabling the default textures in Malverk and then trying to interact with its card afterwards causes the game to error. Disabling (As in, removing from the top line. It does not remove it from the mod entirely) the default texture pack card either requires removal of the '"default",' line in Malverk's config file under ["selected"], Which itself is generally accessible by going up one level from the .../Balatro/mods/ folder, into the /config folder that should be under that /Balatro directory. This is currently fixed in the current dev version of Malverk & should be fixed with the next Malverk release.

**Updating this mod:**
- If this mod has since added any new dependencies since the last time you downloaded it (We probably won't? But generally it's safer to check than be confused why things broke later, and for whatever reason the possibility isn't zero), get those dependencies and ensure Balatro runs.
- Delete any previous version of this mod that exists in the .../Balatro/mods directory.
- Follow the steps outlined in **Installing this mod** again.

## Credits
- The Cirno_TV & Friends mod is a collaborative effort between [DaemonTsun](https://bsky.app/profile/daemontsun.bsky.social) & [NοpeTooFast](https://bsky.app/profile/nopetoofast.bsky.expert), additionally with some idea and art contributions from the Cirno_TV community discord.
- [Turpix](https://bsky.app/profile/turpix.bsky.social) for [the art](https://www.nexusmods.com/balatro/mods/114) used for the Stone Joker.
- This [Miku replacement mod](https://www.nexusmods.com/balatro/mods/223) for art used for the Chaos the Clown Joker.
- [Muddleee for art used for The Sun Tarot card](https://github.com/Muddieee/sun_is_sus).
- The [Cardsauce](https://github.com/BarrierTrio/Cardsauce) mod for art used for the DNA Joker (The art itself appears to not be credited to any specific contributing artist), as well as code for changing the card that appears on the title screen.
- Code for a certain custom Legendary Joker was based off of a similar Joker in the [Cryptid](https://github.com/MathIsFun0/Cryptid) mod.
- Code that changes the colours of the main menu vortex was based off of similar functionality in the [Trance](https://github.com/MathIsFun0/Trance) mod.
- [Aikoyori](https://bsky.app/profile/aikoyori.xyz), BreezeBuilder, Eremel, Somethimgcom515 and many other members of the Balatro modding community for help with code & troubleshooting code issues.
- [Cirno_TV](https://www.twitch.tv/Cirno_TV/) for the art used for the Misprint Joker.
- Credits are also included in in-game tooltips to any cards that are edited & added; Optionally disableable in the mod's config menu.