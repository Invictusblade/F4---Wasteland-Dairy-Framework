Scriptname INVB_BabyHolding extends ObjectReference

Keyword Property animflavorholdingbaby Auto Const
Keyword Property kw_babyWorn Auto

Event OnEquipped(Actor akActor)
	Utility.Wait(0.5)
	debug.Trace(akActor.GetLeveledActorBase().GetName() + " is holding a baby")
	If akActor.wornHasKeyword(kw_babyWorn)
		akActor.ChangeAnimFlavor(animflavorholdingbaby)
	EndIf
EndEvent

Event OnUnequipped(Actor akActor)
	Utility.Wait(0.5)
	akActor.ChangeAnimFlavor(None)
EndEvent
