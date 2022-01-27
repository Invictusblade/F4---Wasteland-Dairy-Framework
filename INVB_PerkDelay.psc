Scriptname INVB_PerkDelay extends activemagiceffect

perk Property Perk_Misc Auto Const Mandatory
GlobalVariable property INVB_Global_Milking_Time_modifier Auto Const Mandatory

Event OnEffectStart(Actor akTarget, Actor akCaster)
	akTarget.addperk(Perk_Misc)
	
	Debug.notification(akTarget.GetLeveledActorBase().GetName() +" is spend")
	
	Utility.WaitGameTime(INVB_Global_Milking_Time_modifier.getvalue())
	
	Debug.notification(akTarget.GetLeveledActorBase().GetName() +" is filled up again")
	akTarget.removeperk(Perk_Misc)
	
EndEvent