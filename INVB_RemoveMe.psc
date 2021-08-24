Scriptname INVB_RemoveMe extends ObjectReference

Armor Property pArmor_Overlay Auto Const Mandatory

Event OnEquipped(Actor akActor)
	Utility.Wait(60)
    akActor.removeitem(pArmor_Overlay, 1, true)
EndEvent