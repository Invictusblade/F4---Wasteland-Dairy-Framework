Scriptname INVB_Headpart_Instant_Global extends ObjectReference

headpart[] Property Custom_Headpart_Female Auto
headpart[] Property Custom_Headpart_Male Auto

state Action
	Event OnEquipped(Actor akActor)
		; ignore it
	EndEvent
endstate


Event OnContainerChanged(ObjectReference akNewContainer, ObjectReference akOldContainer)
	If akNewContainer as Actor
		; Debug.Trace("AutoEquippingBaby: container changed to " + akNewContainer)
		(akNewContainer as Actor).EquipItem(Self.GetBaseObject(), false, true)
	EndIf
EndEvent


Event OnEquipped(Actor akActor)
	Utility.Wait(1.0)
	AddMyHeadpart(akActor)
	Utility.Wait(1.0)
	akActor.unequipitem(self)
	akActor.removeitem(self)
		
EndEvent
			
Function AddMyHeadpart(Actor akActor)    
	GoToState("Action")
		If akActor.GetLeveledActorBase().GetSex() == 0
			headpart kHeadPart = Custom_Headpart_Male[Utility.RandomInt(0, (Custom_Headpart_Male.Length - 1))]				
			akActor.ChangeHeadPart(kHeadPart, false, false)
			Debug.Trace("Male Hair Change")
		elseIf akActor.GetLeveledActorBase().GetSex() == 1
			headpart kHeadPart = Custom_Headpart_Female[Utility.RandomInt(0, (Custom_Headpart_Female.Length - 1))]
			akActor.ChangeHeadPart(kHeadPart, false, false)
			Debug.Trace("Female Hair Change")
		endif
		GoToState("")
EndFunction