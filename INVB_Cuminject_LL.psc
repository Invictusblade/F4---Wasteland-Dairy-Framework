ScriptName INVB_Cuminject_LL extends ObjectReference

ActorBase Property ac_FatherCum Auto					; changed from Actor
Keyword Property kw_noPreg Auto
Faction Property FPFP_Preggo Auto Const Mandatory
Keyword Property fpfp_noDaddy Auto
GlobalVariable property INVB_Global_Notes Auto Const Mandatory
GlobalVariable property INVB_Global_AllowedMales Auto Const Mandatory
int int_start
FPFP_Player_Script FPE

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

Bool Function LoadFPE()
	If Game.IsPluginInstalled("FP_FamilyPlanningEnhanced.esp")
		FPE = FPFP_Player_Script.GetAPI()
		Return True
	Else
		Return false
	EndIf
EndFunction

Function Setup()
    OpenLog()
	If LoadFPE() == true
;		Debug.Trace("FPE Cum Inject: Family Planning Enhanced is loaded")
	Else
;		Debug.Trace("FPE Cum Inject: Family Planning Enhanced not found")
	EndIf
EndFunction


;
; This function takes into account the MCM options like chance of pregnancy, etc
Function TryToMakePregnant(actor akFemale, actor akMale)
	FPFP_BasePregData tmpData = FPE.GetPregnancyInfo(akFemale)
	If (tmpData)
		If (tmpData.DeterminePotentialMan(akMale) != None) && (tmpData.IsValidWoman(akFemale) == true)
			tmpData.TrySpermFrom(akMale)
		EndIf
	EndIf
EndFunction	

;
; This function ignores most MCM settings and simply tries to make the female pregnant
Function MakePregnant(actor akFemale, actor akMale)
    FPFP_BasePregData tmpData = FPE.GetPregnancyInfo(akFemale)
    If (tmpData)
        If (tmpData.IsValidWoman(akFemale) == true)
            tmpData.Impregnate(akMale)
        EndIf
    EndIf
EndFunction

Function MakePregnant_Male(actor akFemale, actor akMale)
    FPFP_BasePregData tmpData = FPE.GetPregnancyInfo(akFemale)
    If (tmpData)
        tmpData.Impregnate(akMale)
    EndIf
EndFunction


;
; the original definition was for a remote event.  Since this is an alias script
; it natively receives events, so we need this definition:
Event OnEquipped(Actor akActor)

	Utility.Wait(Utility.RandomInt(1, 10))
	
	if int_start == 0
		int_start += 1
	endif
	if int_start == 1
		int_start += 1
	;	debug.Trace(akActor.GetLeveledActorBase().GetName() + " start of OnEquipped")
		ObjectImpregnate(akActor)
	;	debug.Trace(akActor.GetLeveledActorBase().GetName() + " middle of OnEquipped")		
		akActor.unequipitem(Self,true,false)
		akActor.removeitem(Self,1, true)
	;	debug.Trace(akActor.GetLeveledActorBase().GetName() + " is now removing object")
	endif
EndEvent

Function ObjectImpregnate(Actor akActor)
	;	debug.Trace(akActor.GetLeveledActorBase().GetName() + " is starting ObjectImpregnate")

	; We need an Actor Reference for TryToMakePregnant().  So we create a temporary actor to 
	; make our player pregnant
		
	If akActor.HasKeyword(kw_noPreg) || akActor.IsInFaction(FPFP_Preggo)

	;	debug.Trace(akActor.GetLeveledActorBase().GetName() + " is pregnant so removing object")
	else
		If akActor.GetLeveledActorBase().GetSex() == 0 && INVB_Global_AllowedMales.GetValue() == 0

	;	debug.Trace(akActor.GetLeveledActorBase().GetName() + " is not getting pregnant")
		else
			Actor tempActor = akActor.PlaceAtMe(ac_FatherCum, abInitiallyDisabled = true) as Actor

		;	Utility.Wait(5.0)
			tempActor.AddKeyword(fpfp_noDaddy)
			LogInfo("Equipped Cum Injector")
			if akActor.GetLeveledActorBase().GetSex() == 0 && INVB_Global_AllowedMales.GetValue() == 1
				MakePregnant_Male(akActor, tempActor)
			else
				MakePregnant(akActor, tempActor)
			endif
		;	Utility.Wait(1.0)
		
			if INVB_Global_Notes.GetValue() == 1
				debug.notification("Now, Have to wait and see if that worked.")
		;		debug.Trace(akActor.GetLeveledActorBase().GetName() + " Has been Impregnated")
			EndIf
		
			tempActor.delete()
		EndIf
	EndIf
EndFunction






Event OnInit()
	LogMessage("FPE_Cuminject OnInit")
	Setup()
EndEvent
;-- Debug/Logging Functions -------------------------

bool Function InDevelopmentMode() DebugOnly
    return False
EndFunction

Function OpenLog() DebugOnly
    Debug.OpenUserLog("Cum Injection")
EndFunction

Function DisplayDebugMessage(string asMessage) DebugOnly
    LogMessage(asMessage, 0)
    If (InDevelopmentMode())
        Debug.Notification(asMessage)
    EndIf
EndFunction

Function LogMessage(string asMessage, int aiSeverity = 0)
    If (InDevelopmentMode())
        Debug.Trace(self + ": " + asMessage, aiSeverity)
    EndIf
    Debug.TraceUser("Cum Injection", self + ": " + asMessage, aiSeverity);
EndFunction

Function LogInfo(string asMessage) DebugOnly
    LogMessage(asMessage, 0)
EndFunction

Function LogWarning(string asMessage) DebugOnly
    LogMessage(asMessage, 1)
EndFunction

Function LogError(string asMessage) DebugOnly
    LogMessage(asMessage, 2)
EndFunction
