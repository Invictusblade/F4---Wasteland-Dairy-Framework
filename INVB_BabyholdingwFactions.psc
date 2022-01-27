Scriptname INVB_BabyholdingwFactions extends ObjectReference

Actor target
Keyword Property animflavorholdingbaby Auto Const
Keyword Property kw_babyWorn Auto
Faction Property Faction_01 Auto Const mandatory
Faction Property Faction_02 Auto Const mandatory
Faction Property Faction_03 Auto Const mandatory
GlobalVariable property INVB_Global_BabyFactions Auto Const Mandatory
GlobalVariable property INVB_Global_BabyFactions_WaitTime Auto Const Mandatory
GlobalVariable property INVB_Global_BabyFactions_WaitTime_RW Auto Const Mandatory
GlobalVariable property INVB_Global_BabyFactions_WaitTime_GH Auto Const Mandatory
Perk Property WLD_Perk_Baby_Smell Auto
GlobalVariable property INVB_Global_Notes Auto Const Mandatory

Event OnEquipped(Actor akActor)
	Actor PlayerRef = Game.GetFormFromFile(0x000014, "Fallout4.esm") as Actor
	Utility.Wait(0.5)
	
	if akActor == PlayerRef
		If (INVB_Global_BabyFactions.GetValue() == 0) ; All
			akActor.addPerk(WLD_Perk_Baby_Smell)
			Utility.Wait(0.5)
			akActor.addToFaction(Faction_01)
			akActor.addToFaction(Faction_02)
			akActor.addToFaction(Faction_03)
		ElseIf (INVB_Global_BabyFactions.GetValue() == 1) ; Player Only
			akActor.addPerk(WLD_Perk_Baby_Smell)
			Utility.Wait(0.5)
			akActor.addToFaction(Faction_01)
		Else ; None
		
		EndIf
	EndIf
		
	If akActor.wornHasKeyword(kw_babyWorn)
		akActor.ChangeAnimFlavor(animflavorholdingbaby)
		Disarm(akActor)
	EndIf
EndEvent

Function Disarm(Actor akActor)
	Weapon S
	S = akActor.getequippedweapon(0)
	
	if S != None
		akActor.Unequipitem(S, False, True)
	endif
EndFunction


Event OnUnequipped(Actor akActor)
	Actor PlayerRef = Game.GetFormFromFile(0x000014, "Fallout4.esm") as Actor
	Utility.Wait(0.5)	
	akActor.ChangeAnimFlavor()

	if akActor == PlayerRef && akActor.HasPerk(WLD_Perk_Baby_Smell) && INVB_Global_BabyFactions.GetValue() < 2
		If INVB_Global_BabyFactions_WaitTime.GetValue() == 1 ; Realworld
			;debug.notification("Realworld - Lasts for "+ INVB_Global_BabyFactions_WaitTime_RW.GetValue())
			Utility.Wait(INVB_Global_BabyFactions_WaitTime_RW.GetValue())
			
			If (INVB_Global_BabyFactions.GetValue() == 0) ; All
				akActor.removePerk(WLD_Perk_Baby_Smell)
				Utility.Wait(0.5)
				akActor.removeFromFaction(Faction_01)
				akActor.removeFromFaction(Faction_02)
				akActor.removeFromFaction(Faction_03)
			ElseIf (INVB_Global_BabyFactions.GetValue() == 1) ; Player Only
				akActor.removePerk(WLD_Perk_Baby_Smell)
				Utility.Wait(0.5)
				akActor.removeFromFaction(Faction_01)
			EndIf

			if INVB_Global_Notes.GetValue() == 1 && akActor == Game.GetPlayer()
				debug.notification(Self.GetName() +"  Smell is Gone Now")
			endif
		elseIf INVB_Global_BabyFactions_WaitTime.GetValue() == 0 ; GameHours
			;debug.notification("GameHours - Lasts for "+ INVB_Global_BabyFactions_WaitTime_GH.GetValue())
			target = akActor
			StartTimerGameTime(INVB_Global_BabyFactions_WaitTime_GH.GetValue())
		endif
	EndIf
EndEvent

Event OnTimerGameTime(int aiTID)
		If (INVB_Global_BabyFactions.GetValue() == 0) ; All
			target.removePerk(WLD_Perk_Baby_Smell)
			Utility.Wait(0.5)
			target.removeFromFaction(Faction_01)
			target.removeFromFaction(Faction_02)
			target.removeFromFaction(Faction_03)
		ElseIf (INVB_Global_BabyFactions.GetValue() == 1) ; Player Only
			target.removePerk(WLD_Perk_Baby_Smell)
			Utility.Wait(0.5)
			target.removeFromFaction(Faction_01)
		EndIf
		
		if INVB_Global_Notes.GetValue() == 1 && target == Game.GetPlayer()
			debug.notification(Self.GetName() +"  Smell is Gone Now")
		endif
EndEvent

