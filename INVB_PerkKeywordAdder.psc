Scriptname INVB_PerkKeywordAdder extends activemagiceffect

GlobalVariable property INVB_Global_Notes Auto Const Mandatory 
Keyword Property FPE_NoPreg Auto
Perk Property Perk_IUD Auto
potion Property Potion_IUD Auto Const Mandatory
string Property string_Enable auto
string Property string_Disable auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
    
	if akTarget.HasPerk(Perk_IUD)
		akTarget.RemovePerk(Perk_IUD)
		akTarget.RemoveKeyword(FPE_NoPreg)
		Game.GetPlayer().additem(Potion_IUD, 1, true)
		if INVB_Global_Notes.GetValue() == 1
			debug.notification(string_Disable)
		endIf
	else	
		akTarget.AddPerk(Perk_IUD)
		akTarget.AddKeyword(FPE_NoPreg)
		Game.GetPlayer().additem(Potion_IUD, 1, true)
		if INVB_Global_Notes.GetValue() == 1
			debug.notification(string_Enable)
		endIf
	endIf
EndEvent