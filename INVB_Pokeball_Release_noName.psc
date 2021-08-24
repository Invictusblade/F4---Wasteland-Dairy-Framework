Scriptname INVB_Pokeball_Release_noName extends activemagiceffect

Actorbase Property Creature_Donor Auto Const Mandatory 

Event OnEffectStart(Actor akActor, Actor akCaster)
	Game.FadeOutGame(true, true, 0, 1, true)
	Utility.Wait(1)
	Debug.notification("Ten Minutes Later.")
	Utility.Wait(1)
	akCaster.PlaceAtMe(Creature_Donor) as Actor
	Game.FadeOutGame(false, true, 0, 1)
EndEvent