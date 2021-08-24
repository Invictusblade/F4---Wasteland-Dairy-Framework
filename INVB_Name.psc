Scriptname INVB_Name extends activemagiceffect

Book Property NoteBaseObject Auto Const

Event OnEffectStart(Actor akTarget, Actor akCaster)

	debug.notification("Most of this is Rubbish")
	Utility.Wait(1.0)
	debug.notification("What is that on the ground?")
	ObjectReference myNote = akCaster.PlaceAtMe(NoteBaseObject)
	myNote.AddTextReplacementData("PlayerActor", akCaster.GetLeveledActorBase())

EndEvent
