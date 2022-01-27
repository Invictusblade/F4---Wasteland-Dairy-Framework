Scriptname INVB_ALCHadder_Milk extends activemagiceffect

Actor Property PlayerRef Auto Const
Potion Property Milk_Rads Auto Const
Potion Property Milk_Breast  Auto Const
ActorValue Property Rads Auto Const
Race Property GhoulRace Auto Const Mandatory 
Race Property SynthGen1Race Auto Const Mandatory 
Potion Property Milk_Synth Auto Const
Race Property SynthGen2Race Auto Const Mandatory 
Race Property SynthGen2RaceValentine Auto Const Mandatory 
GlobalVariable property INVB_Global_Rads auto Const
GlobalVariable property INVB_Global_Notes Auto Const Mandatory
string Property String_Object auto
Potion Property Aid_Spend Auto Const
Perk Property Perk_Lactation Auto
GlobalVariable property INVB_Global_Lactation Auto Const Mandatory

Potion Property Milk_empty Auto Const
bool Property Milk Auto Const
GlobalVariable property INVB_Global_Gender_Roles Auto Const Mandatory
GlobalVariable property INVB_Global_Spend_Toggle Auto Const Mandatory
GlobalVariable property INVB_Global_Milking_Time Auto Const Mandatory
Perk Property Perk_Active Auto
Perk Property Perk_Spend Auto

SPELL Property SP_MilkOverlay Auto
SPELL Property SP_MilkOverlay_Green Auto
GlobalVariable property INVB_Global_Overlay_Boolean Auto Const Mandatory
GlobalVariable property INVB_Global_Quick_Milk Auto Const Mandatory
Armor Property pArmor_Milker_furn Auto Const Mandatory


Actor Function GetActorUnderCrosshairs()
	Actor ScannedActor = LL_FourPlay.LastCrossHairActor()
	
	If ScannedActor == NONE || ScannedActor.GetDistance(PlayerRef) > 256.000
		return PlayerREF
	EndIf
	Return ScannedActor
EndFunction

Event OnEffectStart(Actor akActor, Actor akCaster)
	akActor = GetActorUnderCrosshairs()
	
	if (!akActor.HasPerk(Perk_Active) || !akActor.HasPerk(Perk_Spend) && INVB_Global_Spend_Toggle.GetValue() == 1) || INVB_Global_Spend_Toggle.GetValue() == 0
		Utility.Wait(2.5)
			if Milk == true
				if INVB_Global_Gender_Roles.GetValue() == 0 ;Enforced
					if akActor.GetLeveledActorBase().GetSex() == 1 && akActor.HasPerk(Perk_Lactation) && INVB_Global_Lactation.GetValue() <= 1
						Action(akActor)
					elseIf akActor.GetLeveledActorBase().GetSex() == 1 && !akActor.HasPerk(Perk_Lactation) && INVB_Global_Lactation.GetValue() <= 1
						if INVB_Global_Notes.GetValue() == 1
							Debug.notification(akActor.GetLeveledActorBase().GetName() +" is not Lactating")
						endif
						akActor.additem(Milk_empty, 1, true)
					elseif akActor.GetLeveledActorBase().GetSex() == 1 && INVB_Global_Lactation.GetValue() == 2
						Action(akActor)
					elseif akActor.GetLeveledActorBase().GetSex() == 0
						if INVB_Global_Notes.GetValue() == 1
							Debug.notification(akActor.GetLeveledActorBase().GetName() +" is a Male")
						endif
						akActor.additem(Milk_empty, 1, true)
					endIf
					
				elseif INVB_Global_Gender_Roles.GetValue() == 1 ;Disabled
					if akActor.GetLeveledActorBase().GetSex() == 1 && akActor.HasPerk(Perk_Lactation) && INVB_Global_Lactation.GetValue() <= 1
						Action(akActor)
					elseIf akActor.GetLeveledActorBase().GetSex() == 1 && !akActor.HasPerk(Perk_Lactation) && INVB_Global_Lactation.GetValue() <= 1
						if INVB_Global_Notes.GetValue() == 1
							Debug.notification(akActor.GetLeveledActorBase().GetName() +" is not Lactating")
						endif
						akActor.additem(Milk_empty, 1, true)
					elseif akActor.GetLeveledActorBase().GetSex() == 1 && INVB_Global_Lactation.GetValue() == 2
						Action(akActor)
					elseif akActor.GetLeveledActorBase().GetSex() == 0
						Action(akActor)
					endIf
				endIf
			else 		
				if INVB_Global_Gender_Roles.GetValue() == 0 ;Enforced
					if akActor.GetLeveledActorBase().GetSex() == 0
						Action(akActor)
					elseif akActor.GetLeveledActorBase().GetSex() == 1
						if INVB_Global_Notes.GetValue() == 1
							Debug.notification(akActor.GetLeveledActorBase().GetName() +" is a Female")
						endif
						akActor.additem(Milk_empty, 1, true)
					endIf
					
				elseif INVB_Global_Gender_Roles.GetValue() == 1 ;Disabled
					Action(akActor)
				endIf	
			endIf
	else
		if INVB_Global_Notes.GetValue() == 1
			Debug.notification(akActor.GetLeveledActorBase().GetName() +" is not producing enough")
		endif
		akActor.additem(Milk_empty, 1, true)
	endIf
	
EndEvent



Function Action(Actor akActor)
	Float RadLevel = akActor.GetValue(Rads) as float
	
	if INVB_Global_Spend_Toggle.GetValue() == 1	
		akActor.addperk(Perk_Active)
	endIf
	
	if INVB_Global_Quick_Milk.GetValue() == 0
		akActor.equipitem(pArmor_Milker_furn,false,true)
		Utility.Wait(2.5)
		Utility.WaitGameTime(INVB_Global_Milking_Time.getvalue())
	endIf
	
	
	If akActor.GetLeveledActorBase().GetRace() == GhoulRace
			akActor.additem(Milk_Rads, 1, true)
		elseIf akActor.GetLeveledActorBase().GetRace() == SynthGen1Race
			akActor.additem(Milk_Synth, 1, true)
		elseIf akActor.GetLeveledActorBase().GetRace() == SynthGen2Race
			akActor.additem(Milk_Synth, 1, true)
		elseIf akActor.GetLeveledActorBase().GetRace() == SynthGen2RaceValentine
			akActor.additem(Milk_Synth, 1, true)
		elseIf RadLevel > INVB_Global_Rads.GetValue()
			akActor.additem(Milk_Rads, 1, true)
		else
			akActor.additem(Milk_Breast, 1, true)
		endif
		
		if INVB_Global_Notes.GetValue() == 1
			If RadLevel > INVB_Global_Rads.GetValue()
				Debug.notification(akActor.GetLeveledActorBase().GetName() +" Has Donated Radioactive "+ String_Object)
			ElseIf akActor.GetLeveledActorBase().GetRace() == GhoulRace
				Debug.notification(akActor.GetLeveledActorBase().GetName() +" Has Donated Radioactive "+ String_Object)
			ElseIf akActor.GetLeveledActorBase().GetRace() == SynthGen1Race
				Debug.notification(akActor.GetLeveledActorBase().GetName() +" Has Donated "+ String_Object)
			ElseIf akActor.GetLeveledActorBase().GetRace() == SynthGen2Race
				Debug.notification(akActor.GetLeveledActorBase().GetName() +" Has Donated "+ String_Object)
			ElseIf akActor.GetLeveledActorBase().GetRace() == SynthGen2RaceValentine
				Debug.notification(akActor.GetLeveledActorBase().GetName() +" Has Donated "+ String_Object)
			Else
				Debug.notification(akActor.GetLeveledActorBase().GetName() +" Has Donated "+ String_Object)
			Endif
		endif
		
	if INVB_Global_Spend_Toggle.GetValue() == 1	
		akActor.equipitem(Aid_Spend, false, true)	
		akActor.removeperk(Perk_Active)
	endIf
	
	if INVB_Global_Quick_Milk.GetValue() == 0
		akActor.unequipitem(pArmor_Milker_furn,false,true)
	endIf
	
	if INVB_Global_Overlay_Boolean.GetValue() == 1
		If RadLevel > INVB_Global_Rads.GetValue()
			SP_MilkOverlay_Green.Cast(akActor, akActor)
		else
			SP_MilkOverlay.Cast(akActor, akActor)
		endIf	
	endIf
EndFunction