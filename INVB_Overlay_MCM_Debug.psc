Scriptname INVB_Overlay_MCM_Debug extends Quest

Actor property PlayerRef Auto Const Mandatory
Armor Property pArmor_Manager Auto Const Mandatory
Keyword Property kw_Overlay Auto

Actor Function GetActorUnderCrosshairs()
	Actor ScannedActor = LL_FourPlay.LastCrossHairActor()
	
	If ScannedActor == NONE || ScannedActor.GetDistance(PlayerRef) > 256.000
		return PlayerRef
	EndIf
	Return ScannedActor
EndFunction


Function GiveNPCUnderCrosshairs_RemoveAll()
	Actor akActor = GetActorUnderCrosshairs()
	Bool isFemale = akActor.GetLeveledActorBase().GetSex() as Bool
	Overlays.RemoveAll(akActor, isFemale)
	
	if akActor.HasKeyword(kw_Overlay)
		akActor.RemoveKeyword(kw_Overlay)
	endif
	
	debug.notification("Debug: All Overlays on NPC is clean")
	Overlays.Update(akActor)
EndFunction

Function GiveNPCUnderCrosshairs_ClearAll()
	Overlays.ClearAll()
	debug.notification("Debug: All Overlays in game is clear")
EndFunction

Function GiveNPCUnderCrosshairs_Cycle()
	Actor akActor = GetActorUnderCrosshairs()
	Bool isFemale = akActor.GetLeveledActorBase().GetSex() as Bool
	Overlays.RemoveAll(akActor, isFemale)
	debug.notification("Debug: Started Cycle of Overlays")
	Overlays.Update(akActor)
	if akActor.HasKeyword(kw_Overlay)
		akActor.RemoveKeyword(kw_Overlay)
	endif
	
	akActor.equipitem(pArmor_Manager, false, true)
	
EndFunction

Function GiveNPCUnderCrosshairs_Regenerate()
	Actor akActor = GetActorUnderCrosshairs()
	Bodygen.RegenerateMorphs(akActor)
	Debug.Notification("Debug: Regenerating Body Morphs")
EndFunction