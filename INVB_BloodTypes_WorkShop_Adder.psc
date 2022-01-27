Scriptname INVB_BloodTypes_WorkShop_Adder extends ObjectReference

Actor Property PlayerRef Auto Const
Actor target
INVB_QuestScript Property varTrigger Auto Const
GlobalVariable property INVB_Global_Gift_Amount Auto Const Mandatory
ActorValue Property Rads Auto Const
Potion Property Milk_Rads Auto Const
Race Property GhoulRace Auto Const Mandatory 
Race Property SynthGen1Race Auto Const Mandatory 
Potion Property Milk_Synth Auto Const
Race Property SynthGen2Race Auto Const Mandatory 
Race Property SynthGen2RaceValentine Auto Const Mandatory 
Perk Property Perk_TypeO Auto
Perk Property Perk_TypeA Auto
Perk Property Perk_TypeB Auto
Perk Property Perk_TypeAB Auto
Potion Property Blood_TypeO Auto Const
Potion Property Blood_TypeA Auto Const
Potion Property Blood_TypeB Auto Const
Potion Property Blood_TypeAB Auto Const
GlobalVariable property INVB_Global_Rads_Blood auto Const
GlobalVariable property INVB_Global_Notes Auto Const Mandatory
GlobalVariable property INVB_Global_Notes_Repeat Auto Const Mandatory
GlobalVariable property INVB_Global_Blood_Amount_Max Auto Const Mandatory
GlobalVariable property INVB_Global_Blood_Damage Auto Const Mandatory
Bool Property bool_Slow Auto

SPELL Property SP_BloodOverlay Auto
SPELL Property SP_BloodOverlay_Green Auto
GlobalVariable property INVB_Global_Overlay_Boolean Auto Const Mandatory
GlobalVariable property INVB_Global_NPC_Workshop_Blood Auto Const Mandatory
GlobalVariable property INVB_Global_Gift_GameHours Auto Mandatory
GlobalVariable property INVB_Global_Milking_Time_Type Auto Const Mandatory

GlobalVariable property INVB_Global_Spend_Toggle Auto Const Mandatory
Perk Property Perk_Active Auto
Perk Property Perk_Spend Auto
Potion Property Aid_Spend Auto Const

Bool FirstTime_end = true

Bool Equipped = False
int int_Bloodcount
Armor Property pArmor_Blood Auto Const Mandatory
GlobalVariable property INVB_Global_Workshop_Gifter Auto Const Mandatory

Event OnEquipped(Actor akActor)
	int_Bloodcount = 0
	Equipped = True
	target = akActor
	If akActor != PlayerRef && INVB_Global_NPC_Workshop_Blood.GetValue() == 1
		Do_Milk_Timer(akActor)
	endif	
	
EndEvent

Event OnUnequipped(Actor akActor)
    Equipped = False
	Float RadLevel = akActor.GetValue(Rads) as float
	
	if akActor.HasPerk(Perk_Active)	
		akActor.removeperk(Perk_Active)
	endIf
	
	if int_Bloodcount >= 1
		if INVB_Global_Spend_Toggle.GetValue() == 1	
			akActor.equipitem(Aid_Spend, false, true)
		endIf
		
		if INVB_Global_Overlay_Boolean.GetValue() == 1
			If RadLevel > INVB_Global_Rads_Blood.GetValue()
				SP_BloodOverlay_Green.Cast(akActor, akActor)
			else
				SP_BloodOverlay.Cast(akActor, akActor)
			endIf	
		endIf
	endIf	
EndEvent

Function Do_Milk_Timer(Actor akActor)
	if INVB_Global_Milking_Time_Type.GetValue() == 1
		if int_Bloodcount < INVB_Global_Blood_Amount_Max.getvalue() && Equipped
			RegisterForCustomEvent(varTrigger, "TriggerCollection")
		elseif int_Bloodcount >= INVB_Global_Blood_Amount_Max.getvalue() && Equipped
			akActor.unequipitem(pArmor_Blood, true, true)
			if INVB_Global_Notes.GetValue() == 1
				debug.notification(akActor.GetLeveledActorBase().GetName() +" is running dry")	
			endif	
		endif
	else
		if int_Bloodcount < INVB_Global_Blood_Amount_Max.getvalue() && Equipped
			Utility.WaitGameTime(GetUpdateTime())
			Get_Blood(akActor)
			Do_Milk_Timer(akActor)
		elseif int_Bloodcount >= INVB_Global_Blood_Amount_Max.getvalue() && Equipped
			akActor.unequipitem(pArmor_Blood, true, true)
			if INVB_Global_Notes.GetValue() == 1
				debug.notification(akActor.GetLeveledActorBase().GetName() +" is running dry")	
			endif
		endif
	endIf
EndFunction


Float Function GetUpdateTime()
	float time_milking = INVB_Global_Gift_GameHours.getvalue()
	
	if bool_Slow == true
		time_milking = time_milking * 2
	endIf
	
	If time_milking > 0
		return time_milking
	Else
		return 24.0
	EndIf
EndFunction

Event INVB_QuestScript.TriggerCollection(INVB_QuestScript varSender, Var[] varArgs)
	if canproduceforworkshop() == true
		Get_Blood(target)
	endif
	RegisterForCustomEvent(varTrigger, "TriggerCollection")
EndEvent

Function Get_Blood(Actor akActor)
	Float RadLevel = akActor.GetValue(Rads) as float
	int GiftAmount = INVB_Global_Gift_Amount.getvalue() as int
	
	int_Bloodcount += 1
	
	if bool_Slow == true && GiftAmount > 1
		GiftAmount = GiftAmount / 2
	endIf	

	if INVB_Global_Workshop_Gifter.GetValue() == 1	
		If akActor.GetDistance(PlayerRef) > 1024.000
			If RadLevel > INVB_Global_Rads_Blood.GetValue()
				PlayerRef.additem(Milk_Rads, GiftAmount, true)
			elseIf akActor.HasPerk(Perk_TypeO)
				PlayerRef.additem(Blood_TypeO, GiftAmount, true)
			elseIf akActor.HasPerk(Perk_TypeA)
				PlayerRef.additem(Blood_TypeA, GiftAmount, true)
			elseIf akActor.HasPerk(Perk_TypeB)
				PlayerRef.additem(Blood_TypeB, GiftAmount, true)	
			elseIf akActor.HasPerk(Perk_TypeAB)
				PlayerRef.additem(Blood_TypeAB, GiftAmount, true)
			else
				int randomBlood = Utility.RandomInt(1, 100)
			
				If randomBlood >= 90
					akActor.AddPerk(Perk_TypeAB)
					PlayerRef.additem(Blood_TypeAB, GiftAmount, true)	
				elseIf randomBlood >= 75
					akActor.AddPerk(Perk_TypeB)
					PlayerRef.additem(Blood_TypeB, GiftAmount, true)			
				elseIf randomBlood >= 50
					akActor.AddPerk(Perk_TypeA)
					PlayerRef.additem(Blood_TypeA, GiftAmount, true)
				elseIf randomBlood <= 49
					akActor.AddPerk(Perk_TypeO)
					PlayerRef.additem(Blood_TypeO, GiftAmount, true)
				Endif
			Endif	
		else
			If RadLevel > INVB_Global_Rads_Blood.GetValue()
				akActor.additem(Milk_Rads, GiftAmount, true)
			elseIf akActor.HasPerk(Perk_TypeO)
				akActor.additem(Blood_TypeO, GiftAmount, true)
			elseIf akActor.HasPerk(Perk_TypeA)
				akActor.additem(Blood_TypeA, GiftAmount, true)
			elseIf akActor.HasPerk(Perk_TypeB)
				akActor.additem(Blood_TypeB, GiftAmount, true)	
			elseIf akActor.HasPerk(Perk_TypeAB)
				akActor.additem(Blood_TypeAB, GiftAmount, true)
			else
				int randomBlood = Utility.RandomInt(1, 100)
			
				If randomBlood >= 90
					akActor.AddPerk(Perk_TypeAB)
					akActor.additem(Blood_TypeAB, GiftAmount, true)	
				elseIf randomBlood >= 75
					akActor.AddPerk(Perk_TypeB)
					akActor.additem(Blood_TypeB, GiftAmount, true)			
				elseIf randomBlood >= 50
					akActor.AddPerk(Perk_TypeA)
					akActor.additem(Blood_TypeA, GiftAmount, true)
				elseIf randomBlood <= 49
					akActor.AddPerk(Perk_TypeO)
					akActor.additem(Blood_TypeO, GiftAmount, true)
				Endif
			Endif
		endif
	else
		If RadLevel > INVB_Global_Rads_Blood.GetValue()
			akActor.additem(Milk_Rads, GiftAmount, true)
		elseIf akActor.HasPerk(Perk_TypeO)
			akActor.additem(Blood_TypeO, GiftAmount, true)
		elseIf akActor.HasPerk(Perk_TypeA)
			akActor.additem(Blood_TypeA, GiftAmount, true)
		elseIf akActor.HasPerk(Perk_TypeB)
			akActor.additem(Blood_TypeB, GiftAmount, true)	
		elseIf akActor.HasPerk(Perk_TypeAB)
			akActor.additem(Blood_TypeAB, GiftAmount, true)
		else
			int randomBlood = Utility.RandomInt(1, 100)
		
			If randomBlood >= 90
				akActor.AddPerk(Perk_TypeAB)
				akActor.additem(Blood_TypeAB, GiftAmount, true)	
			elseIf randomBlood >= 75
				akActor.AddPerk(Perk_TypeB)
				akActor.additem(Blood_TypeB, GiftAmount, true)			
			elseIf randomBlood >= 50
				akActor.AddPerk(Perk_TypeA)
				akActor.additem(Blood_TypeA, GiftAmount, true)
			elseIf randomBlood <= 49
				akActor.AddPerk(Perk_TypeO)
				akActor.additem(Blood_TypeO, GiftAmount, true)
			Endif
		Endif
	endif
	
	if INVB_Global_Notes.GetValue() == 1
		if FirstTime_end == true
			If akActor.HasPerk(Perk_TypeO)
				Debug.notification(akActor.GetLeveledActorBase().GetName() +" Has Donated Type O Blood")
			ElseIf akActor.HasPerk(Perk_TypeA)
				Debug.notification(akActor.GetLeveledActorBase().GetName() +" Has Donated Type A Blood")
			ElseIf akActor.HasPerk(Perk_TypeB)
				Debug.notification(akActor.GetLeveledActorBase().GetName() +" Has Donated Type B Blood")
			ElseIf akActor.HasPerk(Perk_TypeAB)
				Debug.notification(akActor.GetLeveledActorBase().GetName() +" Has Donated Type AB Blood")
			Endif
		endif
	endif

	if INVB_Global_Notes_Repeat.GetValue() == 1
		FirstTime_end = false
	endif
EndFunction