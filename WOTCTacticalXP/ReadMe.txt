You created an XCOM 2 Mod Project!
Wellllll... not really... Grimy made this, I just updated it!

Requested by; Wolf Renegade [6thAB] && DarthMagus

ORIG MOD:	https://steamcommunity.com/sharedfiles/filedetails/?id=643507985 GRIMY TACTICAL KILL COUNTER

===============================================================================
STEAM DESC	https://steamcommunity.com/sharedfiles/filedetails/?id=2415446578
===============================================================================
[h1]What is this?[/h1]
This is a WOTC update to a small Grimy mod [url=https://steamcommunity.com/sharedfiles/filedetails/?id=643507985] Tactical Kill Counter [/url], [b]not[/b] to be confused with my other recently released redux [url=https://steamcommunity.com/sharedfiles/filedetails/?id=2405013108] Tactical UI Kill Counter mod [/url]! 
Grimy was a great modder that has stepped away from the modding scene, with the instructions
that his mods can be used, updated etc as long as credit is given. So thank you Grimy!

[h1]Features[/h1][list]
[*]Displays a [b]unit's[/b] kill count and kills required to level up in the Tactical HUD.
[*]Slightly adjusts the Soldier Info names layout for clarity.
[*]Fixes class icons for Civvie's/VIP's
[*]Fixes class icons for Advent/Aliens under mind control or from Double Agent
[*]Fixes class icon of the Commanders Avatar to not be hard coded to the psi-op icon
[*]Optional Extra to give the Commanders Avatar a NickName. 
[b][i]Yes Really! See the localisation file.[/i][/b]
[*]Uses newer CHL methods to get soldiers Class and Rank Icons
[*]Respects Bond Icon Flags and [url=https://steamcommunity.com/sharedfiles/filedetails/?id=1124175584] Colour Coded Bonds [/url]
[*]Works with Hero Class Progressive Icons
[*]Respects CHL Focus Bar
[/list]
Should work with all CHL Versions (LWotC, CI ... RPGO)

[h1]Config and Options[/h1][olist]
[*]Option to use a full count or short count for xp/kills. Defaults to short.
[*]Option to just have the class icon fixes and name to nickname swap
[*]Option to use either a localised string or promotion icon. Defaults to icon.
[*]Option to name the Commanders Avatar, yes still really!
[/olist]
[h1]Overrides[/h1]
UITacticalHUD_SoldierInfo   SetStats
I can't think of any other mods that do so...

[h1]Known Issues[/h1][olist]
[*][strike][url=https://steamcommunity.com/sharedfiles/filedetails/?id=2134513735] Psi Overhaul v3 [/url]: when used with this mod the option in Psi Overhaul v3 to colour units names should be turned off (it is off by default)
[url=https://steamcommunity.com/sharedfiles/filedetails/?id=2299170518] Kirukas LWOTC ModJam [/url] also turns this feature 'on', so you need to switch it off here if using this mod too.[/strike] Fixed in v1.1.
[*][url=https://steamcommunity.com/sharedfiles/filedetails/?id=1872744482] Skirmisher Rebalance [/url]: this mod will conflict due to using its own version of UITacticalHUD_SoldierInfo for the unique action stacks bar. This mod could achieve the same results by updating to use the CHL focus bar ...

[/olist] ... Bug Reports welcome as always

[h1]Credits and Thanks[/h1]
[b]HUGE[/b] thanks to [b]GrimyBunyip[/b] for the original vanilla mod, linked above.
[b]MANY[/b] thanks to [b]Wolf Renegade [6thAB][/b] and [b]DarthMagus[/b] for making me aware of the original and it's issues in WotC. I hope I addressed all your concerns.
As always much thanks and appreciation to the XCOM2 Modders Discord, for constant support!

~ Enjoy [b]!![/b] and please buy me a [url=https://www.buymeacoffee.com/RustyDios] Cuppa Tea [/url]
===============================================================================
UILibrary_WOTC_SI_KC.ClassIcon_Advent
UILibrary_WOTC_SI_KC.ClassIcon_Aliens
UILibrary_WOTC_SI_KC.ClassIcon_Avatar
UILibrary_WOTC_SI_KC.ClassIcon_Civvie
