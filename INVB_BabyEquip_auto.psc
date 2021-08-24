Scriptname INVB_BabyEquip_auto extends ObjectReference

GlobalVariable property INVB_Global_BabyOptions Auto Const Mandatory

Event OnContainerChanged(ObjectReference akNewContainer, ObjectReference akOldContainer)
	Utility.Wait(5)
	If (INVB_Global_BabyOptions.GetValue() == 0) ; None
	
		ElseIf (INVB_Global_BabyOptions.GetValue() == 1) ; Player
			If akNewContainer as Actor == Game.GetPlayer()
				Debug.Trace("AutoEquippingBaby: container changed to " + akNewContainer)
				(akNewContainer as Actor).EquipItem(Self.GetBaseObject(), false, true)
			EndIf
		ElseIf (INVB_Global_BabyOptions.GetValue() == 2) ; NPC
			If akNewContainer as Actor != Game.GetPlayer()
				Debug.Trace("AutoEquippingBaby: container changed to " + akNewContainer)
				(akNewContainer as Actor).EquipItem(Self.GetBaseObject(), false, true)
			EndIf
		Else ; Player & NPC
			If akNewContainer as Actor
				Debug.Trace("AutoEquippingBaby: container changed to " + akNewContainer)
				(akNewContainer as Actor).EquipItem(Self.GetBaseObject(), false, true)
			EndIf
		Endif
	
EndEvent