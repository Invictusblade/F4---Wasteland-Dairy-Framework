Scriptname INVB_Baby_Container extends ObjectReference

MiscObject Property Misc_Baby Auto Const Mandatory
Armor Property Armor_Baby Auto Const Mandatory

Event OnEquipped(Actor akActor)
	Utility.Wait(0.5)
	if akActor.GetItemCount(Misc_Baby) == 0
		Utility.Wait(0.5)
		akActor.removeitem(Armor_Baby, 1, true)
	Endif
EndEvent

Event OnContainerChanged(ObjectReference akNewContainer, ObjectReference akOldContainer)
	Utility.Wait(0.5)
	If akNewContainer as Actor
		if ((akNewContainer as Actor).GetItemCount(Misc_Baby) == 0)
			Utility.Wait(0.5)
			(akNewContainer as Actor).unequipitem(Armor_Baby, 1, true)
			Utility.Wait(0.5)
			(akNewContainer as Actor).removeitem(Armor_Baby, 1, true)
		Endif
	elseif !akNewContainer
		Utility.Wait(0.5)
		Delete()
	elseif akNewContainer.GetItemCount(Misc_Baby) == 0
			Utility.Wait(0.5)
			akNewContainer.removeitem(Armor_Baby, 1, true)
			Delete()
	Endif
EndEvent

Event OnUnEquipped(Actor akActor)
	Utility.Wait(0.5)
	if akActor.GetItemCount(Misc_Baby) == 0
		Utility.Wait(0.5)
		akActor.removeitem(Armor_Baby, 1, true)
	Endif
EndEvent