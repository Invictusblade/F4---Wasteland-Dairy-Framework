Scriptname INVB_Baby_handle extends ObjectReference

MiscObject Property Misc_Baby Auto Const Mandatory
Armor Property Armor_Baby Auto Const Mandatory
GlobalVariable property INVB_Global_Baby_Hold Auto Const Mandatory

Event OnContainerChanged(ObjectReference akNewContainer, ObjectReference akOldContainer)
		Utility.Wait(1)
	If akNewContainer as Actor
		Utility.Wait(1)
		If (INVB_Global_Baby_Hold.GetValue() == 0) && ((akNewContainer as Actor).GetItemCount(Misc_Baby) >= 1) ; None
	
		ElseIf (INVB_Global_Baby_Hold.GetValue() == 1) && ((akNewContainer as Actor).GetItemCount(Misc_Baby) >= 1) ; Player
			If akNewContainer as Actor
				(akNewContainer as Actor).addItem(Armor_Baby, 1, true)
			EndIf
		ElseIf (INVB_Global_Baby_Hold.GetValue() == 2) && ((akNewContainer as Actor).GetItemCount(Misc_Baby) >= 1) ; starts Carrying it
			If akNewContainer as Actor && (akNewContainer as Actor) != Game.GetPlayer()
				(akNewContainer as Actor).addItem(Armor_Baby, 1, true)
				(akNewContainer as Actor).equipitem(Armor_Baby, false, true)
			elseIf akNewContainer as Actor == Game.GetPlayer()
				Game.GetPlayer().addItem(Armor_Baby, 1, true)
			EndIf
		ElseIf (INVB_Global_Baby_Hold.GetValue() == 3) && ((akNewContainer as Actor).GetItemCount(Misc_Baby) >= 1) ; starts Carrying it Includes Player
			If akNewContainer as Actor
				(akNewContainer as Actor).addItem(Armor_Baby, 1, true)
				(akNewContainer as Actor).equipitem(Armor_Baby, false, true)
			EndIf	
		Endif
	else
		Utility.Wait(0.5)
		If akOldContainer as Actor
			(akOldContainer as Actor).unequipitem(Armor_Baby,False,true)
			Utility.Wait(0.5)
			(akOldContainer as Actor).removeitem(Armor_Baby, 1, true)
		EndIf
	Endif
EndEvent
