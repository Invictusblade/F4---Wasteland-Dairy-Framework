Scriptname INVB_PerkKeywordAdder_Virus extends activemagiceffect

GlobalVariable property INVB_Global_Notes Auto Const Mandatory 
Keyword Property FPE_NoPreg Auto
Perk Property Perk_IUD Auto
potion Property Potion_IUD Auto Const
string Property string_Enable auto
string Property string_Disable auto
bool Property bool_CanRemove auto
bool Property bool_GiveKeyword auto
bool Property bool_GivePerk auto
bool Property bool_GiveBackPotion auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
    
	if akTarget.HasPerk(Perk_IUD) && bool_CanRemove == true
		if bool_GivePerk == true
			akTarget.RemovePerk(Perk_IUD)
		endIf
		
		if bool_GiveKeyword == true
			akTarget.RemoveKeyword(FPE_NoPreg)
		endIf
		
		if bool_GiveBackPotion == true
			Game.GetPlayer().additem(Potion_IUD, 1, true)
		endIf
		
		if INVB_Global_Notes.GetValue() == 1
			debug.notification(string_Disable)
		endIf
	else	
		if bool_GivePerk == true
			akTarget.AddPerk(Perk_IUD)
		endIf
		
		if bool_GiveKeyword == true
			akTarget.AddKeyword(FPE_NoPreg)
		endIf
		
		if bool_GiveBackPotion == true
			Game.GetPlayer().additem(Potion_IUD, 1, true)
		endIf
		
		if INVB_Global_Notes.GetValue() == 1
			debug.notification(string_Enable)
		endIf
	endIf
EndEvent