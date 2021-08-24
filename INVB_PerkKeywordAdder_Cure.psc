Scriptname INVB_PerkKeywordAdder_Cure extends activemagiceffect

GlobalVariable property INVB_Global_Notes Auto Const Mandatory
Perk Property Perk_Addiction Auto
string Property string_Enable auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
	if akTarget.HasPerk(Perk_Addiction)
		akTarget.RemovePerk(Perk_Addiction)
		if INVB_Global_Notes.GetValue() == 1
			debug.notification(string_Enable)
		endIf
	endIf
	
EndEvent