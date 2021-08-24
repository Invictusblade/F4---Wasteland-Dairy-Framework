ScriptName INVB_Furn_Cuminject extends ObjectReference

Idle Property IdleExtractionChair auto const mandatory
Idle Property FurnitureExitToStand auto const mandatory
Keyword Property AnimFaceArchetypeInPain auto const mandatory
ActorBase Property ac_FatherCum Auto					; changed from Actor
Actor property PlayerRef Auto Const Mandatory
Keyword Property kw_noPreg Auto
Keyword Property fpfp_noDaddy Auto
GlobalVariable property INVB_Global_Notes Auto Const Mandatory
Keyword Property AnimFaceArchetypeFatherDeath auto const mandatory
Actor skActor

Bool bOccupied = false

FPFP_Player_Script FPE

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
		Debug.Trace("FPE Cum Inject: Family Planning Enhanced is loaded")
	Else
		Debug.Trace("FPE Cum Inject: Family Planning Enhanced not found")
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

;
; the original definition was for a remote event.  Since this is an alias script
; it natively receives events, so we need this definition:


Event OnActivate(ObjectReference akActionRef)
	int i
	bOccupied = true
	skActor = akActionRef as Actor
	
	If skActor.HasKeyword(kw_noPreg)
		Utility.Wait(5.0)
		skActor.PlayIdle(FurnitureExitToStand)
	else
		If skActor.GetLeveledActorBase().GetSex() == 0	
			Utility.Wait(5.0)
			skActor.PlayIdle(FurnitureExitToStand)
		else
			skActor.ChangeAnimFaceArchetype(AnimFaceArchetypeFatherDeath)
			Actor tempActor = skActor.PlaceAtMe(ac_FatherCum, abInitiallyDisabled = true) as Actor

			Utility.Wait(8.0)
			tempActor.AddKeyword(fpfp_noDaddy)
	
			skActor.PlayIdle(IdleExtractionChair)
			
			Utility.Wait(1.5)
			if INVB_Global_Notes.GetValue() == 1
				debug.notification("Injecting Fertility Drugs.")
			EndIf
			skActor.ChangeAnimFaceArchetype(AnimFaceArchetypeInPain)
			Utility.Wait(13.5)
			MakePregnant(skActor, tempActor)
			Utility.Wait(1.0)
		
			if INVB_Global_Notes.GetValue() == 1
				debug.notification("Now, Have to wait and see if that worked.")
			EndIf
			
			tempActor.delete()
			Utility.Wait(2.5)
			skActor.PlayIdle(FurnitureExitToStand)
		EndIf	
	endif
EndEvent


Event OnExitFurniture(ObjectReference akActionRef)
	
	bOccupied = false
	Utility.Wait(5.0)
	skActor.ChangeAnimFaceArchetype()
	skActor = none
	
EndEvent




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
