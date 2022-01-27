Scriptname INVB_Overlay_Instant extends ObjectReference

bool Property bool_Layered Auto
string[] Property Custom_strings_F auto
string[] Property Custom_strings_M auto
string[] Property Custom_strings_F_02 auto
string[] Property Custom_strings_M_02 auto
string[] Property Custom_strings_F_03 auto
string[] Property Custom_strings_M_03 auto
string[] Property Custom_strings_F_04 auto
string[] Property Custom_strings_M_04 auto
string[] Property Custom_strings_F_05 auto
string[] Property Custom_strings_M_05 auto
GlobalVariable property INVB_Global_Overlay_Boolean Auto Const Mandatory
bool Property bool_unequipable Auto
bool Property bool_SkinOverride Auto
bool Property bool_MalesAllowed Auto


state Action
	Event OnEquipped(Actor akActor)
		; ignore it
	EndEvent
endstate

Event OnEquipped(Actor akActor)
	if INVB_Global_Overlay_Boolean.GetValue() == 1
		GoToState("Action")
		Utility.Wait(0.5)    

		if bool_SkinOverride == true
			If akActor.GetLeveledActorBase().GetSex() == 0 && bool_MalesAllowed == true
				int random_seed_M = Utility.RandomInt(0, (Custom_strings_M.Length - 1))
				BodyGen.SetSkinOverride(akActor, Custom_strings_M[random_seed_M])
			elseIf akActor.GetLeveledActorBase().GetSex() == 1
				int random_seed_F = Utility.RandomInt(0, (Custom_strings_F.Length - 1))
				BodyGen.SetSkinOverride(akActor, Custom_strings_F[random_seed_F])
			endif
		elseif bool_Layered == true
			If akActor.GetLeveledActorBase().GetSex() == 0 && bool_MalesAllowed == true
				int random_seed_M = Utility.RandomInt(0, (Custom_strings_M.Length - 1))
				Overlays.AddEntry(akActor, false, 2, Custom_strings_M[random_seed_M])
					Utility.Wait(0.1)  
				if Custom_strings_M_02 != None
					Overlays.AddEntry(akActor, false, 3, Custom_strings_M_02[random_seed_M])
				EndIf
				Utility.Wait(0.1)  	
				if Custom_strings_M_03 != None
					Overlays.AddEntry(akActor, false, 4, Custom_strings_M_03[random_seed_M])
				EndIf
				Utility.Wait(0.1)  	
					
				if Custom_strings_M_04 != None
					Overlays.AddEntry(akActor, false, 5, Custom_strings_M_04[random_seed_M])
				EndIf	
				Utility.Wait(0.1)  

				if Custom_strings_M_05 != None
					Overlays.AddEntry(akActor, false, 6, Custom_strings_M_05[random_seed_M])
				EndIf	

					
			elseIf akActor.GetLeveledActorBase().GetSex() == 1
				int random_seed_F = Utility.RandomInt(0, (Custom_strings_F.Length - 1))
				Overlays.AddEntry(akActor, true, 2, Custom_strings_F[random_seed_F])
					Utility.Wait(0.1)  
				
				if Custom_strings_F_02 != None
					Overlays.AddEntry(akActor, true, 3, Custom_strings_F_02[random_seed_F])
				EndIf
					Utility.Wait(0.1)  	
				if Custom_strings_F_03 != None
					Overlays.AddEntry(akActor, true, 4, Custom_strings_F_03[random_seed_F])
				EndIf
					Utility.Wait(0.1)  	
				if Custom_strings_F_04 != None
					Overlays.AddEntry(akActor, true, 5, Custom_strings_F_04[random_seed_F])
				EndIf
					Utility.Wait(0.1)  	
				if Custom_strings_F_05 != None
					Overlays.AddEntry(akActor, true, 6, Custom_strings_F_05[random_seed_F])
				EndIf
			endif
			
			Overlays.Update(akActor)
		else
			If akActor.GetLeveledActorBase().GetSex() == 0 && bool_MalesAllowed == true
				int random_seed_M = Utility.RandomInt(0, (Custom_strings_M.Length - 1))
				Overlays.AddEntry(akActor, false, 7, Custom_strings_M[random_seed_M])
			elseIf akActor.GetLeveledActorBase().GetSex() == 1
				int random_seed_F = Utility.RandomInt(0, (Custom_strings_F.Length - 1))
				Overlays.AddEntry(akActor, true, 7, Custom_strings_F[random_seed_F])
			endif
			
			Overlays.Update(akActor)
			
		endif
			GoToState("")
	else
	
	endif	
	
	
	GlobalVariable Debug_DeleteTattoo = Game.GetFormFromFile(0x005252, "INVB_OverlayFramework.esp") as GlobalVariable
	if bool_unequipable == true && Debug_DeleteTattoo.GetValue() == 1
		Utility.Wait(5)
		akActor.removeitem(self, 1)
	endif
	
EndEvent

Event OnUnequipped(Actor akActor)
if bool_unequipable == false
	if INVB_Global_Overlay_Boolean.GetValue() == 1
		Utility.Wait(0.5)    
	if bool_SkinOverride == true
			BodyGen.RemoveSkinOverride(akActor)
		elseif bool_Layered == true
			RemoveMyOverlays_int(akActor)
			RemoveMyOverlays_string_Layered(akActor)
		else
			RemoveMyOverlays_int(akActor)
			RemoveMyOverlays_string(akActor)
		endif
	else
	endif
endif	
EndEvent


Function RemoveMyOverlays_string_Layered(Actor akActor)    
    Bool isFemale = akActor.GetLeveledActorBase().GetSex() as Bool
    Overlays:Entry[] ActorOverlays = Overlays.GetAll(akActor, isFemale)
    If (ActorOverlays.Length > 0)
        Int i = 0
        While (i < ActorOverlays.Length)
			if akActor.GetLeveledActorBase().GetSex() == 1        
				If (Custom_strings_F.Find(ActorOverlays[i].template as String) > -1)
					Overlays.Remove(akActor, isFemale, ActorOverlays[i].uid as Int)
				EndIf
					Utility.Wait(0.1)
				if Custom_strings_F_02 != None && (Custom_strings_F_02.Find(ActorOverlays[i].template as String) > -1)
					Overlays.Remove(akActor, isFemale, ActorOverlays[i].uid as Int)
				EndIf
					Utility.Wait(0.1)  	
				if Custom_strings_F_03 != None && (Custom_strings_F_03.Find(ActorOverlays[i].template as String) > -1)
					Overlays.Remove(akActor, isFemale, ActorOverlays[i].uid as Int)
				EndIf
					Utility.Wait(0.1)  	
				if Custom_strings_F_04 != None && (Custom_strings_F_04.Find(ActorOverlays[i].template as String) > -1)
					Overlays.Remove(akActor, isFemale, ActorOverlays[i].uid as Int)
				EndIf	
					Utility.Wait(0.1)  
				if Custom_strings_F_05 != None && (Custom_strings_F_05.Find(ActorOverlays[i].template as String) > -1)
					Overlays.Remove(akActor, isFemale, ActorOverlays[i].uid as Int)
				EndIf
			elseIf akActor.GetLeveledActorBase().GetSex() == 0	
				If (Custom_strings_M.Find(ActorOverlays[i].template as String) > -1)
					Overlays.Remove(akActor, false, ActorOverlays[i].uid as Int)
				EndIf
					Utility.Wait(0.1) 
				if Custom_strings_M_02 != None && (Custom_strings_M_02.Find(ActorOverlays[i].template as String) > -1)
					Overlays.Remove(akActor, false, ActorOverlays[i].uid as Int)
				EndIf
					Utility.Wait(0.1)  	
				if Custom_strings_M_03 != None && (Custom_strings_M_03.Find(ActorOverlays[i].template as String) > -1)
					Overlays.Remove(akActor, false, ActorOverlays[i].uid as Int)
				EndIf
					Utility.Wait(0.1)  	
				if Custom_strings_M_04 != None && (Custom_strings_M_04.Find(ActorOverlays[i].template as String) > -1)
					Overlays.Remove(akActor, false, ActorOverlays[i].uid as Int)
				EndIf	
					Utility.Wait(0.1)  
				if Custom_strings_M_05 != None && (Custom_strings_M_05.Find(ActorOverlays[i].template as String) > -1)
					Overlays.Remove(akActor, false, ActorOverlays[i].uid as Int)
				EndIf
			endif
            i += 1
        EndWhile
        Overlays.Update(akActor)
    EndIf
EndFunction

Function RemoveMyOverlays_string(Actor akActor)    
    Bool isFemale = akActor.GetLeveledActorBase().GetSex() as Bool
    Overlays:Entry[] ActorOverlays = Overlays.GetAll(akActor, isFemale)
    If (ActorOverlays.Length > 0)
        Int i = 0
        While (i < ActorOverlays.Length)
            If (Custom_strings_F.Find(ActorOverlays[i].template as String) > -1)
                Overlays.Remove(akActor, isFemale, ActorOverlays[i].uid as Int)
            EndIf
            If (Custom_strings_M.Find(ActorOverlays[i].template as String) > -1)
                Overlays.Remove(akActor, false, ActorOverlays[i].uid as Int)
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
				Overlays.Remove(akActor, false, ActorOverlays[i].uid as Int)
            EndIf
            i += 1
        EndWhile
        Overlays.Update(akActor)
    EndIf
EndFunction