Scriptname INVB_Implant_Single extends activemagiceffect

Actor target

ActorBase Property ac_FatherCum Auto Const Mandatory
Keyword Property kw_noPreg Auto
Keyword Property fpfp_noDaddy Auto
Faction Property FPFP_Preggo Auto Const Mandatory
GlobalVariable property INVB_Global_Notes Auto Const Mandatory
GlobalVariable property INVB_Global_AllowedMales Auto Const Mandatory
SPELL Property SP_Cumshot Auto
Actor Property PlayerREF Auto Const Mandatory
GlobalVariable property INVB_Global_Syringer Auto Const Mandatory

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

Function MakePregnant_Male(actor akFemale, actor akMale)
    FPFP_BasePregData tmpData = FPE.GetPregnancyInfo(akFemale)
    If (tmpData)
        tmpData.Impregnate(akMale)
    EndIf
EndFunction

Event OnEffectStart(Actor akActor, Actor akCaster)
	if INVB_Global_Syringer.GetValue() == 0
		akActor = GetActorUnderCrosshairs()
		if akActor == None
			akActor = akCaster
		endif
	endif
	
	SP_Cumshot.Cast(akActor, akActor)
	
	If akActor.HasKeyword(kw_noPreg) || akActor.IsInFaction(FPFP_Preggo)
		if INVB_Global_Notes.GetValue() == 1
			Debug.notification(akActor.GetLeveledActorBase().GetName() +" is already Pregnant")
		EndIf	
	else
		Actor tempActor = akActor.PlaceAtMe(ac_FatherCum, abInitiallyDisabled = true) as Actor
		Utility.Wait(5)
		tempActor.AddKeyword(fpfp_noDaddy)
		
		if akActor.GetLeveledActorBase().GetSex() == 0 && INVB_Global_AllowedMales.GetValue() == 1
			MakePregnant_Male(akActor, tempActor)
		else
			MakePregnant(akActor, tempActor)
		endif
		
		if INVB_Global_Notes.GetValue() == 1
			Debug.notification(akActor.GetLeveledActorBase().GetName() +" has been impregnated by "+ tempActor.GetLeveledActorBase().GetName())
		EndIf
		tempActor.delete()
	EndIf
EndEvent

Actor Function GetActorUnderCrosshairs()
	Actor ScannedActor = LL_FourPlay.LastCrossHairActor()
	
	If ScannedActor == NONE || ScannedActor.GetDistance(PlayerRef) > 256.000
		return NONE
	EndIf
	Return ScannedActor
EndFunction

Event OnInit()
	Setup()
EndEvent