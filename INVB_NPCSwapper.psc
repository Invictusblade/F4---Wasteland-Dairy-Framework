Scriptname INVB_NPCSwapper extends activemagiceffect

ActorBase[] Property normal_Pet Auto Const Mandatory 
ActorBase[] Property Loyal_Pet Auto Const Mandatory
GlobalVariable property INVB_Global_Notes Auto Const Mandatory
potion Property Potion_Loyal Auto Const Mandatory

Event OnEffectStart(Actor akTarget, Actor akCaster)
	NPCSwapper(akTarget)
EndEvent



Function NPCSwapper(Actor akActor)    
	int i
	int int_end = normal_Pet.Length
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
			Game.GetPlayer().additem(Potion_Loyal, 1, true)
			i = int_end	
		endIf
		i += 1
	endwhile
	
EndFunction