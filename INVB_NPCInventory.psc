Scriptname INVB_NPCInventory extends activemagiceffect

potion Property Syringe_Inventory Auto Const Mandatory

Event OnEffectStart(Actor akTarget, Actor akCaster)
	akTarget.OpenInventory()
	Utility.Wait(1)
	Game.GetPlayer().additem(Syringe_Inventory, 1, true)
EndEvent

