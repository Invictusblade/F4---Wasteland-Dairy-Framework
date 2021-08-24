Scriptname INVB_ALCHadder_Blood extends activemagiceffect

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

Event OnEffectStart(Actor akActor, Actor akCaster)
	Float RadLevel = akActor.GetValue(Rads) as float
	
    If akActor.GetLeveledActorBase().GetRace() == GhoulRace
		akActor.additem(Milk_Rads, 1, true)
	elseIf akActor.GetLeveledActorBase().GetRace() == SynthGen1Race
		akActor.additem(Milk_Synth, 1, true)
	elseIf akActor.GetLeveledActorBase().GetRace() == SynthGen2Race
		akActor.additem(Milk_Synth, 1, true)
	elseIf akActor.GetLeveledActorBase().GetRace() == SynthGen2RaceValentine
		akActor.additem(Milk_Synth, 1, true)
	elseIf RadLevel > INVB_Global_Rads_Blood.GetValue()
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
	endif
	
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
	
EndEvent