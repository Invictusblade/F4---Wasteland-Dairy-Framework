Scriptname INVB_Extractionchair_Blood extends workshopobjectscript

Idle Property IdleExtractionChair auto const mandatory
Idle Property FurnitureExitToStand auto const mandatory
Keyword Property AnimFaceArchetypeInPain auto const mandatory
Actor skActor
Potion Property Blood_TypeO Auto Const
Potion Property Blood_TypeA Auto Const
Potion Property Blood_TypeB Auto Const
Potion Property Blood_TypeAB Auto Const
Perk Property Perk_TypeO Auto
Perk Property Perk_TypeA Auto
Perk Property Perk_TypeB Auto
Perk Property Perk_TypeAB Auto
Potion Property Milk_Rads Auto Const
Race Property GhoulRace Auto Const Mandatory 
Race Property SynthGen1Race Auto Const Mandatory 
Potion Property Milk_Synth Auto Const
Race Property SynthGen2Race Auto Const Mandatory 
Race Property SynthGen2RaceValentine Auto Const Mandatory 
ActorValue Property Rads Auto Const
GlobalVariable property INVB_Global_Rads_Blood auto Const
GlobalVariable property INVB_Global_Notes Auto Const Mandatory
GlobalVariable property INVB_Global_Blood_Amount_Max Auto Const Mandatory
GlobalVariable property INVB_Global_Blood_Damage Auto Const Mandatory
SPELL Property SP_BloodExtract_DamagePlayer Auto
SPELL Property SP_BloodExtract_DamagePlayer_Kill Auto
SPELL Property SP_BloodExtract_SPECIAL Auto


Bool bOccupied = false
Bool FirstTime = true

Event OnActivate(ObjectReference akActionRef)
	int i
	bOccupied = true
	skActor = akActionRef as Actor
			
	Utility.Wait(1.0)
	
	while (i <= INVB_Global_Blood_Amount_Max.getvalue()) && (bOccupied == true)
		
		if (skActor != Game.GetPlayer())
			skActor.SetRestrained()
		endif
		Utility.Wait(8.0)
		skActor.PlayIdle(IdleExtractionChair)
		Utility.Wait(1.5)
		
		if (skActor == Game.GetPlayer()) && (INVB_Global_Blood_Damage.GetValue() == 1.000000)
			SP_BloodExtract_DamagePlayer.Cast(skActor, skActor)
		elseIf (INVB_Global_Blood_Damage.GetValue() == 2.000000)
			SP_BloodExtract_DamagePlayer.Cast(skActor, skActor)
		elseIf (skActor == Game.GetPlayer()) && (INVB_Global_Blood_Damage.GetValue() == 3.000000)
			SP_BloodExtract_DamagePlayer_Kill.Cast(skActor, skActor)
		elseIf (INVB_Global_Blood_Damage.GetValue() == 4.000000)
			SP_BloodExtract_DamagePlayer_Kill.Cast(skActor, skActor)
		elseIf (INVB_Global_Blood_Damage.GetValue() == 5.000000)
			SP_BloodExtract_SPECIAL.Cast(skActor, skActor)
		elseif (INVB_Global_Blood_Damage.GetValue() == 0.000000)
		endif
		
		
		skActor.ChangeAnimFaceArchetype(AnimFaceArchetypeInPain)
		Utility.Wait(13.5)
		Extract_Blood(skActor)
		i += 1
		Utility.Wait(10)
		skActor.ClearExpressionOverride()
	endwhile
	Utility.Wait(1.0)
	skActor.PlayIdle(FurnitureExitToStand)
EndEvent

Event OnExitFurniture(ObjectReference akActionRef)
	if (skActor != Game.GetPlayer())
		skActor.SetRestrained(false)
	endif
	bOccupied = false
	skActor.ClearExpressionOverride()
	skActor = none
	
EndEvent

Function Extract_Blood(Actor akActor)
	Float RadLevel = akActor.GetValue(Rads) as float
	
    If akActor.GetLeveledActorBase().GetRace() == GhoulRace
		akActor.additem(Milk_Rads, 2, true)
	elseIf akActor.GetLeveledActorBase().GetRace() == SynthGen1Race
		akActor.additem(Milk_Synth, 2, true)
	elseIf akActor.GetLeveledActorBase().GetRace() == SynthGen2Race
		akActor.additem(Milk_Synth, 2, true)
	elseIf akActor.GetLeveledActorBase().GetRace() == SynthGen2RaceValentine
		akActor.additem(Milk_Synth, 2, true)
	elseIf RadLevel > INVB_Global_Rads_Blood.GetValue()
		akActor.additem(Milk_Rads, 2, true)
	elseIf akActor.HasPerk(Perk_TypeO)
		akActor.additem(Blood_TypeO, 2, true)
	elseIf akActor.HasPerk(Perk_TypeA)
		akActor.additem(Blood_TypeA, 2, true)
	elseIf akActor.HasPerk(Perk_TypeB)
		akActor.additem(Blood_TypeB, 2, true)	
	elseIf akActor.HasPerk(Perk_TypeAB)
		akActor.additem(Blood_TypeAB, 2, true)
	else
		int randomBlood = Utility.RandomInt(1, 100)
	
		If randomBlood >= 90
			akActor.AddPerk(Perk_TypeAB)
			akActor.additem(Blood_TypeAB, 2, true)	
		elseIf randomBlood >= 75
			akActor.AddPerk(Perk_TypeB)
			akActor.additem(Blood_TypeB, 2, true)			
		elseIf randomBlood >= 50
			akActor.AddPerk(Perk_TypeA)
			akActor.additem(Blood_TypeA, 2, true)
		elseIf randomBlood <= 49
			akActor.AddPerk(Perk_TypeO)
			akActor.additem(Blood_TypeO, 2, true)
		Endif
	endif
	

	if FirstTime == true
		if INVB_Global_Notes.GetValue() == 1
			If RadLevel > INVB_Global_Rads_Blood.GetValue()
				Debug.notification(akActor.GetLeveledActorBase().GetName() +" Has Donated Glowing Blood")
			ElseIf akActor.HasPerk(Perk_TypeO)
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
	FirstTime = false
EndFunction