Scriptname INVB_Furn_Milking extends ObjectReference

Armor Property pArmor_Milker Auto Const Mandatory

GlobalVariable property INVB_Global_Gift_WSChoice Auto Const Mandatory
Actor skActor
Armor skArmor
Armor Property Pipboy Auto Const Mandatory
bool Property AllowPlayer Auto

Event OnActivate(ObjectReference akActionRef)
	skActor = akActionRef as Actor
	
	if (skActor == Game.GetPlayer()) && (AllowPlayer == True)
		MilkingAction(skActor)
		Utility.Wait(1)
		skActor.equipitem(Pipboy,false,true)
	
	elseif (skActor == Game.GetPlayer()) && (AllowPlayer == false)
	
	else
		MilkingAction(skActor)
	endif
EndEvent


Function MilkingAction(actor akActor)

		if (akActor != Game.GetPlayer())
			akActor.SetRestrained()
		endif
		; akActor.additem(pArmor_Milker, 1, true)	
		If (INVB_Global_Gift_WSChoice.GetValue() == 0) ; Nude & Milkers	
			akActor.unequipall()
			Utility.Wait(5)
			akActor.equipitem(pArmor_Milker,false,true)
		ElseIf (INVB_Global_Gift_WSChoice.GetValue() == 1) ; Nude
			akActor.unequipall()
		ElseIf (INVB_Global_Gift_WSChoice.GetValue() == 2) ; Milkers
			Utility.Wait(5)
			akActor.equipitem(pArmor_Milker,false,true)
		Else  ; Nothing
		
		endif
EndFunction

Event OnExitFurniture(ObjectReference akActionRef)
	if (skActor != Game.GetPlayer())
		skActor.SetRestrained(false)
	endif

	skActor.unequipitem(pArmor_Milker,false,true)
	; skActor.removeitem(pArmor_Milker, 1, true)
	skActor = none
EndEvent