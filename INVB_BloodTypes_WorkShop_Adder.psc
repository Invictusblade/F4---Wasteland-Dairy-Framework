Scriptname INVB_BloodTypes_WorkShop_Adder extends ObjectReference

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


Bool FirstTime_end = true

Event OnEquipped(Actor akActor)

	target = akActor
	If akActor != Game.GetPlayer()
		RegisterForCustomEvent(varTrigger, "TriggerCollection")
;	Debug.Notification("Registered for event!")
	endif
EndEvent

Event INVB_QuestScript.TriggerCollection(INVB_QuestScript varSender, Var[] varArgs)
;	debug.notification("Event recieved!")

;	if canproduceforworkshop() == true
		Get_Blood(target)
;		debug.notification("produced")
;	endif

	RegisterForCustomEvent(varTrigger, "TriggerCollection")
EndEvent

Function Get_Blood(Actor akActor)
	Float RadLevel = akActor.GetValue(Rads) as float
	int GiftAmount = INVB_Global_Gift_Amount.getvalue() as int
	
	if bool_Slow == true && GiftAmount > 1
		GiftAmount = GiftAmount / 2
	endIf	

	If akActor.GetLeveledActorBase().GetRace() == GhoulRace
		akActor.additem(Milk_Rads, GiftAmount, true)
	elseIf akActor.GetLeveledActorBase().GetRace() == SynthGen1Race
		akActor.additem(Milk_Synth, GiftAmount, true)
	elseIf akActor.GetLeveledActorBase().GetRace() == SynthGen2Race
		akActor.additem(Milk_Synth, GiftAmount, true)
	elseIf akActor.GetLeveledActorBase().GetRace() == SynthGen2RaceValentine
		akActor.additem(Milk_Synth, GiftAmount, true)
	elseIf RadLevel > INVB_Global_Rads_Blood.GetValue()
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
endif
	if INVB_Global_Notes_Repeat.GetValue() == 1
		FirstTime_end = false
	endif
EndFunction