Scriptname INVB_Viagra_armor extends ObjectReference

Keyword Property kw_Viagia Auto

Event OnEquipped(Actor akActor)
    BodyGen.SetMorph(akActor, false, "Erection", kw_Viagia, 1.0)
	Utility.Wait(0.1)
	BodyGen.UpdateMorphs(akActor)
EndEvent

Event OnUnequipped(Actor akActor)
	BodyGen.SetMorph(akActor, false, "Erection", kw_Viagia, 0)
	Utility.Wait(0.1)
	BodyGen.UpdateMorphs(akActor)
EndEvent
