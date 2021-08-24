Scriptname INVB_Milking_Overlay extends ObjectReference

string[] Property Custom_strings auto
string[] Property Custom_strings_M auto
string[] Property Custom_strings_Rads auto
int Property int_count Auto
ActorValue Property Rads Auto Const
GlobalVariable property INVB_Global_Overlay_Boolean Auto Const Mandatory
GlobalVariable property INVB_Global_Milking_Time Auto Const Mandatory

Event OnEquipped(Actor akActor)
	Utility.Wait(5.0)
	StartTimerGameTime(GetUpdateTime())
EndEvent

Event OnTimerGameTime(int aiTID)
	OverlayAction(Game.GetPlayer())
EndEvent

Float Function GetUpdateTime()
	
	float time_milking = INVB_Global_Milking_Time.getvalue()
	If time_milking > 0
		return time_milking
	Else
		return 24.0
	EndIf
	
EndFunction

Event OnUnequipped(Actor akActor)
	if INVB_Global_Overlay_Boolean.GetValue() == 1
		int random_time_exit = Utility.RandomInt(10, 30)
		Utility.Wait(random_time_exit)    
		RemoveMyOverlays_int(akActor)
		RemoveMyOverlays_string(akActor)
	else
	
	endif
EndEvent

Function OverlayAction(Actor akActor)
	if INVB_Global_Overlay_Boolean.GetValue() == 1
		Float RadLevel = akActor.GetValue(Rads) as float
		int random_seed = Utility.RandomInt(0, int_count)

		if (RadLevel > 500)
			If akActor.GetLeveledActorBase().GetSex() == 1
				Overlays.AddEntry(akActor, true, 7, Custom_strings_Rads[random_seed])
			elseIf akActor.GetLeveledActorBase().GetSex() == 0
				Overlays.AddEntry(akActor, false, 7, Custom_strings_M[random_seed])
			endif
		else
			If akActor.GetLeveledActorBase().GetSex() == 1
				Overlays.AddEntry(akActor, true, 7, Custom_strings[random_seed])
			elseIf akActor.GetLeveledActorBase().GetSex() == 0
				Overlays.AddEntry(akActor, false, 7, Custom_strings_M[random_seed])
			endif
		endif
		Overlays.Update(akActor)
	endif
EndFunction

Function RemoveMyOverlays_string(Actor akActor)    
    Bool isFemale = akActor.GetLeveledActorBase().GetSex() as Bool
    Overlays:Entry[] ActorOverlays = Overlays.GetAll(akActor, isFemale)
    If (ActorOverlays.Length > 0)
        Int i = 0
        While (i < ActorOverlays.Length)
            If (Custom_strings.Find(ActorOverlays[i].template as String) > -1)
                Overlays.Remove(akActor, isFemale, ActorOverlays[i].uid as Int)
            EndIf
			If (Custom_strings_M.Find(ActorOverlays[i].template as String) > -1)
                Overlays.Remove(akActor, false, ActorOverlays[i].uid as Int)
            EndIf
			If (Custom_strings_Rads.Find(ActorOverlays[i].template as String) > -1)
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