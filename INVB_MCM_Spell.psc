Scriptname INVB_MCM_Spell extends Quest

Actor Property PlayerRef Auto Const
SPELL Property Spell_Spell Auto 
bool Property bool_NeedItem auto
form Property obj_Object Auto Const 
bool Property bool_NeedPerk auto
Perk Property Perk_Perk Auto
GlobalVariable property INVB_Global_Notes Auto Const Mandatory


Actor Function GetActorUnderCrosshairs()
	Actor ScannedActor = LL_FourPlay.LastCrossHairActor()
	
	If ScannedActor == NONE || ScannedActor.GetDistance(PlayerRef) > 256.000
		return None
	EndIf
	Return ScannedActor
EndFunction

Function GiveNPCUnderCrosshairs()
	Actor akActor = GetActorUnderCrosshairs()
	
	if bool_NeedPerk == true && Game.GetPlayer().HasPerk(Perk_Perk)
		If (akActor)
			Spell_Spell.Cast(PlayerREF, akActor)
		Else
			if INVB_Global_Notes.GetValue() == 1
				debug.notification("There is no NPC to give stuff to.")
			EndIf	
		EndIf
	elseif bool_NeedItem == true && (Game.GetPlayer().GetItemCount(obj_Object) >= 1)
		If (akActor)
			Spell_Spell.Cast(PlayerREF, akActor)
			PlayerREF.removeitem(obj_Object, 1, true)
		Else
			if INVB_Global_Notes.GetValue() == 1
				Debug.notification("There is no NPC to give stuff to.")
			EndIf
		EndIf
	
	
	elseif bool_NeedItem == false
		If (akActor)
			Spell_Spell.Cast(PlayerREF, akActor)
		Else
			if INVB_Global_Notes.GetValue() == 1
				Debug.notification("There is no NPC to give stuff to.")
			EndIf
		EndIf
	EndIf	
	
EndFunction

Function GiveMyselfStuff()
	Actor akActor = PlayerREF
	
	if bool_NeedPerk == true && Game.GetPlayer().HasPerk(Perk_Perk)
		If (akActor)
			Spell_Spell.Cast(PlayerREF, akActor)
		Else
			if INVB_Global_Notes.GetValue() == 1
				Debug.notification("There is no NPC to give stuff to.")
			EndIf
		EndIf
	elseif bool_NeedItem == true && (Game.GetPlayer().GetItemCount(obj_Object) >= 1)
		If (akActor)
			Spell_Spell.Cast(PlayerREF, akActor)
			PlayerREF.removeitem(obj_Object, 1, true)
		Else
			if INVB_Global_Notes.GetValue() == 1
				Debug.notification("There is no NPC to give stuff to.")
			EndIf
		EndIf
	elseif bool_NeedItem == false
		If (akActor)
			Spell_Spell.Cast(PlayerREF, akActor)
		Else
			if INVB_Global_Notes.GetValue() == 1
				Debug.notification("There is no NPC to give stuff to.")
			EndIf	
		EndIf
	EndIf
	
EndFunction