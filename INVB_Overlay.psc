Scriptname INVB_Overlay extends ObjectReference

string[] Property Custom_strings auto
int Property int_count Auto
GlobalVariable property INVB_Global_Overlay_Boolean Auto Const Mandatory

state Action
	Event OnEquipped(Actor akActor)
		; ignore it
	EndEvent
endstate

Event OnEquipped(Actor akActor)
	If akActor == Game.GetPlayer()
		if INVB_Global_Overlay_Boolean.GetValue() == 1
			GoToState("Action")
			int random_seed = Utility.RandomInt(0, int_count)
			int random_time = Utility.RandomInt(5, 15)
			Utility.Wait(random_time)    

			Overlays.AddEntry(akActor, true, 7, Custom_strings[random_seed])
	
			Overlays.Update(akActor)
			random_time = Utility.RandomInt(10, 30)
			Utility.Wait(random_time)    
			RemoveMyOverlays_int(akActor)
			RemoveMyOverlays_string(akActor)
			GoToState("")
		else
	
		endif	
	endif		
EndEvent

Function RemoveMyOverlays_string(Actor akActor)    
    Bool isFemale = akActor.GetLeveledActorBase().GetSex() as Bool
    Overlays:Entry[] ActorOverlays = Overlays.GetAll(akActor, isFemale)
    If (ActorOverlays.Length > 0)
        Int i = 0
        While (i < ActorOverlays.Length)
            If (Custom_strings.Find(ActorOverlays[i].template as String) > -1)
                Overlays.Remove(akActor, isFemale, ActorOverlays[i].uid as Int)
            EndIf
            i += 1
        EndWhile
        Overlays.Update(akActor)
    EndIf
EndFunction

Function RemoveMyOverlays_int(Actor akActor)    
    Bool isFemale = akActor.GetLeveledActorBase().GetSex() as Bool
    Overlays:Entry[] ActorOverlays = Overlays.GetAll(akActor, isFemale)
    If (ActorOverlays.Length > 0)
        Int i = 0
        While (i < ActorOverlays.Length)
            If (ActorOverlays[i].priority as int == 7)
                Overlays.Remove(akActor, isFemale, ActorOverlays[i].uid as Int)
            EndIf
            i += 1
        EndWhile
        Overlays.Update(akActor)
    EndIf
EndFunction