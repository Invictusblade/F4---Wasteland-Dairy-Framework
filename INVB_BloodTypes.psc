Scriptname INVB_BloodTypes extends ObjectReference

Actor target
Armor Property pArmor_Blood Auto Const Mandatory
Keyword Property kw_HC Auto
Keyword Property kw_Repeat Auto
Perk Property Perk_TypeO Auto
Perk Property Perk_TypeA Auto
Perk Property Perk_TypeB Auto
Perk Property Perk_TypeAB Auto
Potion Property Blood_TypeO Auto Const
Potion Property Blood_TypeA Auto Const
Potion Property Blood_TypeB Auto Const
Potion Property Blood_TypeAB Auto Const
MiscObject Property Blood_Empty1 Auto Const
MiscObject Property Blood_Empty2 Auto Const
Potion Property Blood_Empty_Clean Auto Const
ActorValue Property Rads Auto Const
Potion Property Milk_Rads Auto Const
GlobalVariable property INVB_Global_Rads_Blood auto Const
GlobalVariable property INVB_Global_Notes Auto Const Mandatory
GlobalVariable property INVB_Global_Notes_Repeat Auto Const Mandatory
GlobalVariable property INVB_Global_Blood_Amount_Max Auto Const Mandatory
GlobalVariable property INVB_Global_Blood_Damage Auto Const Mandatory
GlobalVariable property INVB_Global_Blood_Resources Auto Const Mandatory
GlobalVariable property INVB_Global_Blood_Time Auto Mandatory
GlobalVariable property INVB_Global_Blood_Time_Type Auto Const Mandatory
GlobalVariable property INVB_Global_Blood_Time_modifier Auto Const Mandatory
SPELL Property SP_BloodExtract_DamagePlayer Auto
SPELL Property SP_BloodExtract_DamagePlayer_Kill Auto
SPELL Property SP_BloodExtract_SPECIAL Auto

SPELL Property SP_BloodOverlay Auto
SPELL Property SP_BloodOverlay_Green Auto
GlobalVariable property INVB_Global_Overlay_Boolean Auto Const Mandatory
Bool Property bool_Slow Auto

string Property Custom_string auto

Bool Equipped = False
Bool FirstTime_start = true
Bool FirstTime_end = true
int int_Bloodcount

Function Do_Blood_Resources(Actor akActor)
	if (akActor.GetItemCount(Blood_Empty_Clean) >= 1)
	    akActor.removeitem(Blood_Empty_Clean, 1, true)
		Utility.Wait(5)
	elseif (akActor.GetItemCount(Blood_Empty1) >= 1)
		if INVB_Global_Notes.GetValue() == 1	
			if FirstTime_start == true
				debug.notification(Blood_Empty1.GetName() +" is Dirty, Cleaning Now")
				if INVB_Global_Notes_Repeat.GetValue() == 1
					FirstTime_start = false
				endif	
			endif
		endif
		Utility.Wait(10)
		akActor.removeitem(Blood_Empty1, 1, true)
					
		Utility.Wait(5)
	elseif (akActor.GetItemCount(Blood_Empty2) >= 1)
		if INVB_Global_Notes.GetValue() == 1	
			if FirstTime_start == true
				debug.notification(Blood_Empty2.GetName() +" is Dirty, Cleaning Now")	
				if INVB_Global_Notes_Repeat.GetValue() == 1
					FirstTime_start = false
				endif	
			endif
		endif
		Utility.Wait(10)
		akActor.removeitem(Blood_Empty2, 1, true)
		Utility.Wait(5)		
	else
		akActor.unequipitem(pArmor_Blood,true,true)
		if INVB_Global_Notes.GetValue() == 1
			Debug.MessageBox("You don't have any "+ Blood_Empty_Clean.GetName() +" or "+ Blood_Empty1.GetName() +" or "+ Blood_Empty2.GetName())	
			debug.notification("Unequipping "+ pArmor_Blood.GetName())
		endif
	endif
EndFunction

Function Get_Blood(Actor akActor)
	Float RadLevel = akActor.GetValue(Rads) as float
	
	If Equipped
		If RadLevel > INVB_Global_Rads_Blood.GetValue()
			akActor.additem(Milk_Rads, 1, true)
		elseIf akActor.HasPerk(Perk_TypeO)
			akActor.additem(Blood_TypeO, 1, true)
		elseIf akActor.HasPerk(Perk_TypeA)
			akActor.additem(Blood_TypeA, 1, true)
		elseIf akActor.HasPerk(Perk_TypeB)
			akActor.additem(Blood_TypeB, 1, true)	
		elseIf akActor.HasPerk(Perk_TypeAB)
			akActor.additem(Blood_TypeAB, 1, true)
		else
			int randomBlood = Utility.RandomInt(1, 100)
		
			If randomBlood >= 90
				akActor.AddPerk(Perk_TypeAB)
				akActor.additem(Blood_TypeAB, 1, true)	
			elseIf randomBlood >= 75
				akActor.AddPerk(Perk_TypeB)
				akActor.additem(Blood_TypeB, 1, true)			
			elseIf randomBlood >= 50
				akActor.AddPerk(Perk_TypeA)
				akActor.additem(Blood_TypeA, 1, true)
			elseIf randomBlood <= 49
				akActor.AddPerk(Perk_TypeO)
				akActor.additem(Blood_TypeO, 1, true)
			Endif
		Endif
	endif
	If Equipped	
		if (akActor == Game.GetPlayer()) && (INVB_Global_Blood_Damage.GetValue() == 1)
			SP_BloodExtract_DamagePlayer.Cast(akActor, akActor)
		elseIf (INVB_Global_Blood_Damage.GetValue() == 2)
			SP_BloodExtract_DamagePlayer.Cast(akActor, akActor)
		elseIf (akActor == Game.GetPlayer()) && (INVB_Global_Blood_Damage.GetValue() == 3)
			SP_BloodExtract_DamagePlayer_Kill.Cast(akActor, akActor)
		elseIf (INVB_Global_Blood_Damage.GetValue() == 4)
			SP_BloodExtract_DamagePlayer_Kill.Cast(akActor, akActor)
		elseIf (INVB_Global_Blood_Damage.GetValue() == 5)
			SP_BloodExtract_SPECIAL.Cast(akActor, akActor)
		endif
	endif	
	
	If Equipped
		if INVB_Global_Notes.GetValue() == 1
			if INVB_Global_Notes_Repeat.GetValue() == 0
				FirstTime_end = true
			endif
		
			if FirstTime_end == true
				if Custom_string != ""
					Debug.notification(akActor.GetLeveledActorBase().GetName() +" Has Donated "+ Custom_string)
				elseIf akActor.HasPerk(Perk_TypeO)
					Debug.notification(akActor.GetLeveledActorBase().GetName() +" Has Donated Type O Blood")
				ElseIf akActor.HasPerk(Perk_TypeA)
					Debug.notification(akActor.GetLeveledActorBase().GetName() +" Has Donated Type A Blood")
				ElseIf akActor.HasPerk(Perk_TypeB)
					Debug.notification(akActor.GetLeveledActorBase().GetName() +" Has Donated Type B Blood")
				ElseIf akActor.HasPerk(Perk_TypeAB)
					Debug.notification(akActor.GetLeveledActorBase().GetName() +" Has Donated Type AB Blood")
				Endif
			endif
			
			if INVB_Global_Notes_Repeat.GetValue() == 1
				FirstTime_end = false
			endif
		endif
	endif
EndFunction


Event OnEquipped(Actor akActor)
	int_Bloodcount = 0
	Equipped = True
	
	If Game.GetPlayer().wornHasKeyword(kw_HC) && Equipped && INVB_Global_Blood_Resources.GetValue() == 0
		Do_Blood_Resources(Game.GetPlayer())
	endIf
	
	if akActor == Game.GetPlayer()
		while Equipped
		if INVB_Global_Blood_Time_Type.GetValue() == 1
			StartTimerGameTime(GetUpdateTime())		
		else
			if bool_Slow == true
				Utility.Wait(INVB_Global_Blood_Time_modifier.getvalue() * 2)
			else
				Utility.Wait(INVB_Global_Blood_Time_modifier.getvalue())
			endIf
			WaitandBlood()
		endIf
		EndWhile
	endIf		
EndEvent



Float Function GetUpdateTime()
	
	float time_Blood = INVB_Global_Blood_Time.getvalue()
	
	if bool_Slow == true
		time_Blood = time_Blood * 2
	endIf
	
	If time_Blood > 0
		return time_Blood
	Else
		return 24.0
	EndIf
	
EndFunction

Function WaitandBlood()

	Get_Blood(Game.GetPlayer())
	Utility.Wait(5)
	int_Bloodcount += 1
	
	if int_Bloodcount < INVB_Global_Blood_Amount_Max.getvalue() && Equipped
		If Game.GetPlayer().wornHasKeyword(kw_HC) && Equipped && INVB_Global_Blood_Resources.GetValue() == 0
			Do_Blood_Resources(Game.GetPlayer())
		endIf
		StartTimerGameTime(GetUpdateTime())
	elseif int_Bloodcount >= INVB_Global_Blood_Amount_Max.getvalue() && Equipped
		Game.GetPlayer().unequipitem(pArmor_Blood, true, true)
		if INVB_Global_Notes.GetValue() == 1
			debug.notification(Game.GetPlayer().GetLeveledActorBase().GetName() +" is running dry")	
		endif
	endIf	
EndFunction

Event OnTimerGameTime(int aiTID)
;	Debug.Trace("Do_Feeding_Cycle Trigger")
	
	Get_Blood(Game.GetPlayer())
	Utility.Wait(5)
	int_Bloodcount += 1
	
	if int_Bloodcount < INVB_Global_Blood_Amount_Max.getvalue() && Equipped
		If Game.GetPlayer().wornHasKeyword(kw_HC) && Equipped && INVB_Global_Blood_Resources.GetValue() == 0
			Do_Blood_Resources(Game.GetPlayer())
		endIf
		StartTimerGameTime(GetUpdateTime())
	elseif int_Bloodcount >= INVB_Global_Blood_Amount_Max.getvalue() && Equipped
		Game.GetPlayer().unequipitem(pArmor_Blood, true, true)
		if INVB_Global_Notes.GetValue() == 1
			debug.notification(Game.GetPlayer().GetLeveledActorBase().GetName() +" is running dry")	
		endif
	endIf	
EndEvent


Event OnUnequipped(Actor akActor)
    Equipped = False
	Float RadLevel = akActor.GetValue(Rads) as float
	if INVB_Global_Overlay_Boolean.GetValue() == 1 && int_Bloodcount > 0
		If RadLevel > INVB_Global_Rads_Blood.GetValue()
			SP_BloodOverlay_Green.Cast(akActor, akActor)
		else
			SP_BloodOverlay.Cast(akActor, akActor)
		endIf	
	endIf
EndEvent