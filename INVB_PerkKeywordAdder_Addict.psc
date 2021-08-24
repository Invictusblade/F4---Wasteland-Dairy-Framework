Scriptname INVB_PerkKeywordAdder_Addict extends activemagiceffect

GlobalVariable property INVB_Global_Notes Auto Const Mandatory 
GlobalVariable property INVB_Global_AddictionChance Auto Mandatory
Perk Property Perk_Addiction Auto
string Property string_Enable auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
	int random_LList = Utility.RandomInt(1, 100)
	
	if (random_LList <= INVB_Global_AddictionChance.GetValue())		
		akTarget.AddPerk(Perk_Addiction)
		if INVB_Global_Notes.GetValue() == 1
			debug.notification(string_Enable)
		endIf
	endIf
	
EndEvent