Scriptname INVB_PerkKeywordLoyalAdder extends activemagiceffect

GlobalVariable property INVB_Global_Notes Auto Const Mandatory 
Keyword Property FPE_Loyal Auto
Perk Property Perk_Offspring Auto
Perk Property Perk_Loyal Auto


Event OnEffectStart(Actor akTarget, Actor akCaster)
    
	if akTarget.HasPerk(Perk_Offspring)
		if akTarget.HasPerk(Perk_Loyal)
			akTarget.RemovePerk(Perk_Loyal)
			akTarget.RemoveKeyword(FPE_Loyal)
			akTarget.SetCanDoCommand(false)
			akTarget.SetCommandState(false)
			akTarget.SetPlayerTeammate(false)
			Utility.Wait(2)
			akTarget.EvaluatePackage()
			if INVB_Global_Notes.GetValue() == 1
				debug.notification("Loyalty Chip Deactivated")
			endIf
		else	
			akTarget.AddPerk(Perk_Loyal)
			akTarget.AddKeyword(FPE_Loyal)
			akTarget.SetCanDoCommand(true)
			akTarget.SetCommandState(true)
			akTarget.SetPlayerTeammate(true)
			Utility.Wait(2)
			akTarget.EvaluatePackage()
			if INVB_Global_Notes.GetValue() == 1
				debug.notification("Loyalty Chip Activated")
			endIf
		endIf
	endIf
	
EndEvent