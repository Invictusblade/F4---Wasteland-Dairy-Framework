Scriptname INVB_BabyReset extends activemagiceffect

Event OnEffectStart(Actor akActor, Actor akCaster)
	Utility.Wait(0.5)
	akActor.ChangeAnimFlavor()
EndEvent

