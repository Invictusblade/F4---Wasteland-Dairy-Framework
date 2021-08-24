Scriptname INVB_PocketWatch_1 extends activemagiceffect

Actor Property PlayerRef Auto Const
Perk Property WLD_perk_25_hypnotist Auto
SPELL Property Calm Auto

Event OnEffectStart(Actor akActor, Actor akCaster)
	Actor akActor_Target = GetActorUnderCrosshairs()
	GlobalVariable INVB_Global_hypnotis_Command_Chance = Game.GetFormFromFile(0x005B78, "INVB_WastelandDairy.esp") as GlobalVariable
	
	int random_LList = Utility.RandomInt(1, 100)
	if (random_LList <= INVB_Global_hypnotis_Command_Chance.GetValue()) && PlayerREF.HasPerk(WLD_perk_25_hypnotist)
		Calm.Cast(akActor_Target, akActor_Target)
	else
		Debug.notification(akActor_Target.GetLeveledActorBase().GetName() +" looks at you like you are a fucking creep")
	endIf
EndEvent

Actor Function GetActorUnderCrosshairs()
	Actor ScannedActor = LL_FourPlay.LastCrossHairActor()
	
	If ScannedActor == NONE || ScannedActor.GetDistance(PlayerRef) > 256.000
		return None
	EndIf
	Return ScannedActor
EndFunction