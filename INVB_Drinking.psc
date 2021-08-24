Scriptname INVB_Drinking extends activemagiceffect

string[] Property Custom_strings auto
int Property int_count Auto
GlobalVariable Property Overlayed Auto Const
GlobalVariable property INVB_Global_Overlay_Boolean Auto Const Mandatory

state drinking
	Event OnEffectStart(Actor akActor, Actor akCaster)
		; ignore it
	EndEvent
endstate

Event OnEffectStart(Actor akActor, Actor akCaster)
if INVB_Global_Overlay_Boolean.GetValue() == 1.0
	GoToState("drinking")
	If Overlayed.GetValueInt() == 0
		Overlayed.Setvalue(1)
		int i
		
		Bool isFemale = akActor.GetLeveledActorBase().GetSex() as Bool
		int[] UID = new int[0]
		int random_seed = Utility.RandomInt(0, int_count)
		Overlays:Entry overlay = new Overlays:Entry
		overlay.priority = 7
		overlay.template = Custom_strings[random_seed]
		overlay.red = 0
		overlay.green = 0
		overlay.blue = 0
		overlay.alpha = 0
		overlay.offset_u = 0
		overlay.offset_v = 0
		overlay.scale_u = 1
		overlay.scale_v = 1
		UID.Add(Overlays.Add(akActor, isFemale, overlay))	
	
		Overlays.Update(akActor)
		int random_time = Utility.RandomInt(5, 20)
		Utility.Wait(random_time)
    
		Overlays.Remove(akActor, isFemale, UID[i] as int)
		Overlays.Update(akActor)
		RemoveMyOverlays_int(akActor)
		RemoveMyOverlays_string(akActor)
		Overlayed.Setvalue(0)
	else
	
	endif
	GoToState("")
	else
	
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