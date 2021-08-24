Scriptname INVB_Condom_overlay extends ObjectReference

string[] Property Custom_strings_Male auto
string[] Property Custom_strings_Female auto
int Property int_count Auto

Event OnEquipped(Actor akActor)
	if akActor.GetLeveledActorBase().GetSex() == 0
		int random_seed = Utility.RandomInt(0, int_count)
		Overlays.AddEntry(akActor, False, 6, Custom_strings_Male[random_seed])
		Overlays.Update(akActor)
	elseif akActor.GetLeveledActorBase().GetSex() == 1
		int random_seed = Utility.RandomInt(0, int_count)
		Overlays.AddEntry(akActor, true, 6, Custom_strings_Female[random_seed])
		Overlays.Update(akActor)
	endif
	
    
EndEvent

Event OnUnequipped(Actor akActor)
    if akActor.GetLeveledActorBase().GetSex() == 0
		RemoveMyOverlays_int(akActor)
		RemoveMyOverlays_string(akActor)
	elseif akActor.GetLeveledActorBase().GetSex() == 1
		RemoveMyOverlays_int_Female(akActor)
		RemoveMyOverlays_string_Female(akActor)
	endif
EndEvent

Function RemoveMyOverlays_string(Actor akActor)    
    Overlays:Entry[] ActorOverlays = Overlays.GetAll(akActor, false)
    If (ActorOverlays.Length > 0)
        Int i = 0
        While (i < ActorOverlays.Length)
            If (Custom_strings_Male.Find(ActorOverlays[i].template as String) > -1)
                Overlays.Remove(akActor, false, ActorOverlays[i].uid as Int)
            EndIf
            i += 1
        EndWhile
        Overlays.Update(akActor)
    EndIf
EndFunction

Function RemoveMyOverlays_int(Actor akActor)    
    Overlays:Entry[] ActorOverlays = Overlays.GetAll(akActor, false)
    If (ActorOverlays.Length > 0)
        Int i = 0
        While (i < ActorOverlays.Length)
            If (ActorOverlays[i].priority as int == 7)
                Overlays.Remove(akActor, false, ActorOverlays[i].uid as Int)
            EndIf
            i += 1
        EndWhile
        Overlays.Update(akActor)
    EndIf
EndFunction

Function RemoveMyOverlays_string_Female(Actor akActor)    
    Bool isFemale = akActor.GetLeveledActorBase().GetSex() as Bool
    Overlays:Entry[] ActorOverlays = Overlays.GetAll(akActor, isFemale)
    If (ActorOverlays.Length > 0)
        Int i = 0
        While (i < ActorOverlays.Length)
            If (Custom_strings_Female.Find(ActorOverlays[i].template as String) > -1)
                Overlays.Remove(akActor, isFemale, ActorOverlays[i].uid as Int)
            EndIf
            i += 1
        EndWhile
        Overlays.Update(akActor)
    EndIf
EndFunction

Function RemoveMyOverlays_int_Female(Actor akActor)    
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
