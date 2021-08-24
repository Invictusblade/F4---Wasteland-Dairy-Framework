Scriptname INVB_MCM_Hotkeys_Perk extends Quest

Actor Property PlayerRef Auto Const
Keyword Property kw_Keyword Auto
Perk Property Pk_Perk Auto

Actor Function GetActorUnderCrosshairs()
	Actor ScannedActor = LL_FourPlay.LastCrossHairActor()
	
	If ScannedActor == NONE || ScannedActor.GetDistance(PlayerRef) > 256.000
		return None
	EndIf
	Return ScannedActor
EndFunction

Function GiveNPCUnderCrosshairs()
	Actor akActor = GetActorUnderCrosshairs()
	
	If (akActor)
		
		if akActor.HasPerk(Pk_Perk) == true
			akActor.RemovePerk(Pk_Perk)
		else
			akActor.AddPerk(Pk_Perk)
		endIf
		
		if akActor.HasKeyword(kw_Keyword) == true
			akActor.RemoveKeyword(kw_Keyword)
		else
			akActor.AddKeyword(kw_Keyword)
		endIf	
	
	Else
		Debug.MessageBox("There is no NPC to give perk to.")
	EndIf
	
EndFunction

Function GiveMyselfStuff()
	Actor akActor = PlayerRef
	
	If (akActor)
		
		if akActor.HasPerk(Pk_Perk) == true
			akActor.RemovePerk(Pk_Perk)
		else
			akActor.AddPerk(Pk_Perk)
		endIf
		
		if akActor.HasKeyword(kw_Keyword) == true
			akActor.RemoveKeyword(kw_Keyword)
		else
			akActor.AddKeyword(kw_Keyword)
		endIf	
			
	Else
		Debug.MessageBox("There is nothing to use.")
	EndIf
	
EndFunction