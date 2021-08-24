Scriptname INVB_BabyFeeding extends ObjectReference

MiscObject Property Misc_Baby Auto Const Mandatory
potion Property Breast_Milk Auto Const Mandatory
potion Property Milk_Special Auto Const Mandatory
MiscObject Property milk_Empty Auto Const
Form Property c_BabyBits_scrap Auto Const
int Property int_MilkType auto
GlobalVariable property INVB_Global_BabyHardcore_Boolean Auto Const Mandatory
GlobalVariable property INVB_Global_BabyHardcore_Milk Auto Const Mandatory
GlobalVariable property INVB_Global_Notes Auto Const Mandatory
GlobalVariable property INVB_Global_Rads auto Const
GlobalVariable property INVB_Global_BabyHardcore_Effects Auto Mandatory
GlobalVariable property INVB_Global_BabyHardcore_Time Auto Mandatory
string Property String_MilkType auto
string Property String_MilkType_Special auto
SPELL Property Spell_BreastFeeding Auto
ActorValue Property Rads Auto Const
Perk Property Perk_Lactation Auto
GlobalVariable property INVB_Global_Lactation Auto Const Mandatory

Bool Equipped = False
int Hungerlevel

Function Hungry(Actor akActor)
	if Hungerlevel == 1
		Utility.Wait(2)
		if INVB_Global_Notes.GetValue() == 1				
			Debug.notification("The Baby is Hungry")
		EndIf	
	elseif Hungerlevel == 2
		Utility.Wait(2)
		if INVB_Global_Notes.GetValue() == 1
			Debug.notification("The Baby is Starving")
		EndIf		
	elseif Hungerlevel == 3
		Utility.Wait(2)
		if INVB_Global_Notes.GetValue() == 1
			Debug.notification("The Baby has Died")
		EndIf
		akActor.additem(c_BabyBits_scrap)	
		akActor.removeitem(Misc_Baby)
	endif
EndFunction

Function Fed(Actor akActor)
	if Hungerlevel == 1
		Utility.Wait(2)
	
		if INVB_Global_Notes.GetValue() == 1	
			Debug.notification("The Baby was Starving")
		EndIf
					
	elseif Hungerlevel == 2
		Utility.Wait(2)
				
		if INVB_Global_Notes.GetValue() == 1	
			Debug.notification("The Baby was Dying")
		EndIf	
					
	elseIf Hungerlevel == 0
		Utility.Wait(2.0)
		if INVB_Global_Notes.GetValue() == 1	
			Debug.notification("The Baby is Healthy")
		EndIf
	endif
EndFunction

Function Do_Feeding_Cycle_Milk(Actor akActor)
		ConfirmPlayer(akActor)
			
			if akActor.GetLeveledActorBase().GetSex() == 1 && Equipped == true
				if akActor.HasPerk(Perk_Lactation) && INVB_Global_Lactation.GetValue() == 1
					if INVB_Global_Notes.GetValue() == 1
						int random_Text = Utility.RandomInt(1, 5)
						if (random_Text == 1)
							Debug.notification("The Baby needs to Drink Breast Milk")
						elseif (random_Text == 2)
							Debug.notification("Let me Unzip my Top")
						elseif (random_Text == 3)
							Debug.notification("Don't Bite, Baby")
						elseif (random_Text == 4)
							Debug.notification("Don't Drink Too Much")
						elseif (random_Text == 5)
							Debug.notification("Need to Slip Out my Breast")
						endif
					Utility.Wait(3)
					EndIf
				
					if INVB_Global_BabyHardcore_Effects.GetValue() == 1
						Spell_BreastFeeding.Cast(akActor, akActor)
					endIf	
				elseif INVB_Global_Lactation.GetValue() == 1
					if INVB_Global_Notes.GetValue() == 1
						Debug.notification("You are not producing Breast Milk")
						Utility.Wait(3)
					EndIf
					Hungerlevel = Hungerlevel + 1
					Hungry(akActor)
				elseif INVB_Global_Lactation.GetValue() == 0
					if INVB_Global_Notes.GetValue() == 1
						Debug.notification("The Baby needs to Drink Breast Milk")
						Utility.Wait(3)
					EndIf
				
					if INVB_Global_BabyHardcore_Effects.GetValue() == 1
						Spell_BreastFeeding.Cast(akActor, akActor)
					endIf	
				endIf
				
			elseif (akActor.GetItemCount(Breast_Milk) == 0) && Equipped == true
				if INVB_Global_Notes.GetValue() == 1
					Debug.notification("The Baby needs "+ String_MilkType)
					Utility.Wait(6)
					Debug.notification("No "+ String_MilkType)
				EndIf
				
				Hungerlevel = Hungerlevel + 1
				Hungry(akActor)
				
			elseIf (akActor.GetItemCount(Breast_Milk) >= 1) && Equipped == true
				if INVB_Global_Notes.GetValue() == 1
					Debug.notification("The Baby needs "+ String_MilkType)
				EndIf	
				
				Utility.Wait(6)
				Hungerlevel = Hungerlevel - 1
				akActor.removeitem(Breast_Milk, 1, true)
				akActor.additem(milk_Empty, 1, true)
				Fed(akActor)	
			endIf
EndFunction

Function Do_Feeding_Cycle_Special(Actor akActor)
		Float RadLevel = akActor.GetValue(Rads) as float
		
		ConfirmPlayer(akActor)
		
		if akActor.GetLeveledActorBase().GetSex() == 1 && Equipped == true && (RadLevel > INVB_Global_Rads.GetValue()) && int_MilkType == 1
				
			if INVB_Global_Notes.GetValue() == 1
				int random_Text = Utility.RandomInt(1, 5)
				if (random_Text == 1)
					Debug.notification("The Baby needs to Drink Radioactive Breast Milk")
				elseif (random_Text == 2)
					Debug.notification("Hey, My Nipples Glow")
				elseif (random_Text == 3)
					Debug.notification("Don't Bite, you really do have Sharp Teeth, Don't you Baby")
				elseif (random_Text == 4)
					Debug.notification("Don't Drink Too Much Rads")
				elseif (random_Text == 5)
					Debug.notification("Need to Slip Out my Third Nipple")
				endif
				Utility.Wait(3)
			EndIf
			
			if INVB_Global_BabyHardcore_Effects.GetValue() == 1
				Spell_BreastFeeding.Cast(akActor, akActor)
			endIf
			
		elseif (akActor.GetItemCount(Milk_Special) == 0) && Equipped == true
			if INVB_Global_Notes.GetValue() == 1
				Debug.notification("The Baby needs "+ String_MilkType_Special)
				Utility.Wait(2)
				Debug.notification("No "+ String_MilkType_Special)
			EndIf
			Hungerlevel = Hungerlevel + 1
			Hungry(akActor)
		elseIf (akActor.GetItemCount(Milk_Special) >= 1) && Equipped == true
			if INVB_Global_Notes.GetValue() == 1
				Debug.notification("The Baby needs "+ String_MilkType_Special)
			EndIf	
			
			Utility.Wait(2)
			Hungerlevel = Hungerlevel - 1
			akActor.removeitem(Milk_Special, 1, true)
			akActor.additem(milk_Empty, 1, true)
			Fed(akActor)
			if INVB_Global_Notes.GetValue() == 1	
				Debug.notification("Feeding Time")
			EndIf	
		endIf
EndFunction

Function ConfirmPlayer(Actor akActor)
	if akActor != Game.GetPlayer()
		akActor.unequipitem(self)	
	elseIf INVB_Global_BabyHardcore_Boolean.GetValue() == 0.0
		akActor.unequipitem(self)	
	endif
	
EndFunction


Event OnEquipped(Actor akActor)
	Equipped = True
	
	if akActor == Game.GetPlayer()
		Hungerlevel = 0
		Utility.Wait(5.0)

		if INVB_Global_BabyHardcore_Boolean.GetValue() == 1.0
			StartTimerGameTime(GetUpdateTime())
		endIf
		
	endIf		
EndEvent

Float Function GetUpdateTime()
	
	float time_feeding = INVB_Global_BabyHardcore_Time.getvalue()
	If time_feeding > 0
		return time_feeding
	Else
		return 24.0
	EndIf
	
EndFunction

Event OnTimerGameTime(int aiTID)
;	Debug.Trace("Do_Feeding_Cycle Trigger")
	
	If INVB_Global_BabyHardcore_Milk.GetValue() == 0
		Do_Feeding_Cycle_Milk(Game.GetPlayer())
	elseIf INVB_Global_BabyHardcore_Milk.GetValue() == 1 && int_MilkType == 0
		Do_Feeding_Cycle_Milk(Game.GetPlayer())
	elseIf INVB_Global_BabyHardcore_Milk.GetValue() == 1 && int_MilkType >= 1
		Do_Feeding_Cycle_Special(Game.GetPlayer())
	endIf

	if Equipped
		StartTimerGameTime(GetUpdateTime())
	endIf	
EndEvent

Event OnUnequipped(Actor akActor)
    Equipped = False
EndEvent