Scriptname INVB_NPCSwapper_Armor extends ObjectReference

ActorBase[] Property normal_Pet Auto Const Mandatory 
ActorBase[] Property Loyal_Pet Auto Const Mandatory
GlobalVariable property INVB_Global_Notes Auto Const Mandatory

Event OnEquipped(Actor akTarget)
	NPCSwapper(akTarget)
EndEvent

Function NPCSwapper(Actor akActor)
	if INVB_Global_Notes.GetValue() == 1
		Debug.notification("Loyalty Chip Scanning")
	endIf	
	int i
	int int_end = normal_Pet.Length
	Utility.Wait(5)
	while (i <= normal_Pet.Length)
		If (akActor.GetActorBase() == normal_Pet[i])
			ObjectReference newAdult = akActor.PlaceAtMe(Loyal_Pet[i], 1, True, False, False)
			RenameAnything.SetRefName(newAdult, RenameAnything.GetRefName(akActor))
			if INVB_Global_Notes.GetValue() == 1
				Debug.notification("Activating Follower")
			endIf
			akActor.Delete()			
			i = int_end
		elseIf (akActor.GetActorBase() == Loyal_Pet[i])
	
			ObjectReference newAdult = akActor.PlaceAtMe(normal_Pet[i], 1, True, False, False)
			RenameAnything.SetRefName(newAdult, RenameAnything.GetRefName(akActor))
			akActor.SetPlayerTeammate(false)
			akActor.Delete()
			if INVB_Global_Notes.GetValue() == 1
				Debug.notification("Deactivating Follower")
			endIf
			i = int_end

		endIf
		i += 1
	endwhile
EndFunction