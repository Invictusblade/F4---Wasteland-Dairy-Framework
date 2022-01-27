Scriptname INVB_ALCHadder_Milk_Redux extends activemagiceffect

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
	elseIf RadLevel > INVB_Global_Rads.GetValue()
		akActor.additem(Milk_Rads, 1, true)
	else
		akActor.additem(Milk_Breast, 1, true)
	endif
	
	if INVB_Global_Notes.GetValue() == 1
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
	endif
	
EndEvent