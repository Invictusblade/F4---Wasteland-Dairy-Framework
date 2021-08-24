ScriptName INVB_InstantBirth extends activemagiceffect

GlobalVariable property FPFP_Global_Power Auto Const Mandatory
GlobalVariable property FPFP_Global_BodyType Auto Const Mandatory
GlobalVariable property INVB_Global_Notes Auto Const Mandatory
GlobalVariable property INVB_Global_Birth_Time Auto Const Mandatory
Keyword Property kw_Morph Auto
FPFP_Player_Script FPE
Perk Property WLD_Perk_Pregnancy_Freezing Auto
Perk Property WLD_Perk_Month_1 Auto
Perk Property WLD_Perk_Month_2 Auto
Perk Property WLD_Perk_Month_3 Auto
Perk Property WLD_Perk_Month_4 Auto
Perk Property WLD_Perk_Month_5 Auto
Perk Property WLD_Perk_Month_6 Auto
Perk Property WLD_Perk_Month_7 Auto
Perk Property WLD_Perk_Month_8 Auto
Perk Property WLD_Perk_Month_9 Auto
Perk Property WLD_Perk_Month_10 Auto
Actor Property Ourself Auto

float currentMonth

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

Function Instant_Birth(actor akFemale)
    FPFP_BasePregData tmpData = FPE.GetPregnancyInfo(akFemale)
	
	if akFemale.HasPerk(WLD_Perk_Pregnancy_Freezing)
		if akFemale.HasPerk(WLD_Perk_Month_1)
			currentMonth = 1
		ElseIf akFemale.HasPerk(WLD_Perk_Month_2)
			currentMonth = 2
		ElseIf akFemale.HasPerk(WLD_Perk_Month_3)
			currentMonth = 3
		ElseIf akFemale.HasPerk(WLD_Perk_Month_4)
			currentMonth = 4
		ElseIf akFemale.HasPerk(WLD_Perk_Month_5)
			currentMonth = 5
		ElseIf akFemale.HasPerk(WLD_Perk_Month_6)
			currentMonth = 6
		ElseIf akFemale.HasPerk(WLD_Perk_Month_7)
			currentMonth = 7
		ElseIf akFemale.HasPerk(WLD_Perk_Month_8)
			currentMonth = 8
		ElseIf akFemale.HasPerk(WLD_Perk_Month_9)
			currentMonth = 9
		ElseIf akFemale.HasPerk(WLD_Perk_Month_10)
			currentMonth = 10 	
		endIf
		akFemale.RemovePerk(WLD_Perk_Pregnancy_Freezing)
	else
		currentMonth = tmpData.GetCurrentMonth()
	endIf
	
    If (tmpData)
		StartTimer(GetUpdateTime())
    EndIf
EndFunction

Event OnTimer(int aiTimerID)
    FPFP_BasePregData tmpData = FPE.GetPregnancyInfo(Ourself)
	if currentMonth < 10
		UpdateBody(Ourself, currentMonth)
			
		if INVB_Global_Notes.GetValue() == 1	
			Debug.notification("Simulated Month: "+ currentMonth as int)
		endIf
		currentMonth += 1
		StartTimer(GetUpdateTime())
	elseif currentMonth >= 10	
		tmpData.GiveBirth(true)
		ReduceBelly(Ourself)
	endIf
EndEvent


Float Function GetUpdateTime()
	
	float time_Pregnancy = INVB_Global_Birth_Time.getvalue()
	If time_Pregnancy > 0
		return time_Pregnancy
	Else
		return 24.0
	EndIf
	
EndFunction

Function UpdateBody(actor akFemale, Float akMonth)
	float power = (akMonth * FPFP_Global_Power.getValue() * 0.015 * Utility.RandomFloat(0.8, 1.2))
		
		If (FPFP_Global_BodyType.GetValue() == 0) ; CBBE
			BodyGen.SetMorph(akFemale, true, "PregnancyBelly", kw_Morph, power)
			BodyGen.SetMorph(akFemale, true, "DoubleMelon", kw_Morph, (power/2))
			BodyGen.SetMorph(akFemale, true, "BigButt", kw_Morph, (power/2))
		ElseIf (FPFP_Global_BodyType.GetValue() == 1) ; Fusion Girl
			BodyGen.SetMorph(akFemale, true, "Belly Pregnant", kw_Morph, power)
			BodyGen.SetMorph(akFemale, true, "Boobs Yuge", kw_Morph, (power/2))
			BodyGen.SetMorph(akFemale, true, "Bum Chubby", kw_Morph, (power/2))
			BodyGen.SetMorph(akFemale, true, "Waist Size", kw_Morph, (power/2))
			BodyGen.SetMorph(akFemale, true, "Waist Line", kw_Morph, power)
			BodyGen.SetMorph(akFemale, true, "Back Size", kw_Morph, power)
			BodyGen.SetMorph(akFemale, true, "Back Arch", kw_Morph, (power/2))
			BodyGen.SetMorph(akFemale, true, "Boobs Top Slope", kw_Morph, (power/2))
			BodyGen.SetMorph(akFemale, true, "Back Arch", kw_Morph, (power/2))
			BodyGen.SetMorph(akFemale, true, "Hips Upper Width", kw_Morph, (power/4))
			BodyGen.SetMorph(akFemale, true, "Hips Size", kw_Morph, (power/2))
			BodyGen.SetMorph(akFemale, true, "Legs Chubby", kw_Morph, (power/2))
			BodyGen.SetMorph(akFemale, true, "Arms Chubby", kw_Morph, (power/2))
		Else ; JaneBod
			BodyGen.SetMorph(akFemale, true, "BreastsNaturalTypeSeven", kw_Morph, (power/2))
			BodyGen.SetMorph(akFemale, true, "BreastSize",kw_Morph, (power/2))
			BodyGen.SetMorph(akFemale, true, "NippleShapeLargerSeven", kw_Morph, (power/2))
			BodyGen.SetMorph(akFemale, true, "WaistWidth", kw_Morph, (power/2))
			BodyGen.SetMorph(akFemale, true, "WaistDepthOut", kw_Morph, (power/2))
			BodyGen.SetMorph(akFemale, true, "LoveHandles", kw_Morph, (power/2))
			BodyGen.SetMorph(akFemale, true, "CheekWider", kw_Morph, (power/2))
			BodyGen.SetMorph(akFemale, true, "GluteLowerFatOut", kw_Morph, power/2)
			BodyGen.SetMorph(akFemale, true, "GluteLowerHeightDown", kw_Morph, power/4)
			BodyGen.SetMorph(akFemale, true, "HipFatter", kw_Morph, (power/2))
			BodyGen.SetMorph(akFemale, true, "ThighSize", kw_Morph, (power/2))
			BodyGen.SetMorph(akFemale, true, "UpperArmSize", kw_Morph, (power/2))
			BodyGen.SetMorph(akFemale, true, "Pregnant", kw_Morph, (power))
		Endif
		
			BodyGen.UpdateMorphs(akFemale)
EndFunction

Function ReduceBelly(actor akFemale)
	If (FPFP_Global_BodyType.GetValue() == 0) ; CBBE
			BodyGen.SetMorph(akFemale, true, "PregnancyBelly", kw_Morph, 0)
			BodyGen.SetMorph(akFemale, true, "DoubleMelon", kw_Morph, 0)
			BodyGen.SetMorph(akFemale, true, "BigButt", kw_Morph, 0)
		ElseIf (FPFP_Global_BodyType.GetValue() == 1) ; Fusion Girl
			BodyGen.SetMorph(akFemale, true, "Belly Pregnant", kw_Morph, 0)
			BodyGen.SetMorph(akFemale, true, "Boobs Yuge", kw_Morph, 0)
			BodyGen.SetMorph(akFemale, true, "Bum Chubby", kw_Morph, 0)
			BodyGen.SetMorph(akFemale, true, "Waist Size", kw_Morph, 0)
			BodyGen.SetMorph(akFemale, true, "Waist Line", kw_Morph, 0)
			BodyGen.SetMorph(akFemale, true, "Back Size", kw_Morph, 0)
			BodyGen.SetMorph(akFemale, true, "Back Arch", kw_Morph, 0)
			BodyGen.SetMorph(akFemale, true, "Boobs Top Slope", kw_Morph, 0)
			BodyGen.SetMorph(akFemale, true, "Back Arch", kw_Morph, 0)
			BodyGen.SetMorph(akFemale, true, "Hips Upper Width", kw_Morph, 0)
			BodyGen.SetMorph(akFemale, true, "Hips Size", kw_Morph, 0)
			BodyGen.SetMorph(akFemale, true, "Legs Chubby", kw_Morph, 0)
			BodyGen.SetMorph(akFemale, true, "Arms Chubby", kw_Morph, 0)
		Else ; JaneBod
			BodyGen.SetMorph(akFemale, true, "BreastsNaturalTypeSeven", kw_Morph, 0)
			BodyGen.SetMorph(akFemale, true, "BreastSize",kw_Morph, 0)
			BodyGen.SetMorph(akFemale, true, "NippleShapeLargerSeven", kw_Morph, 0)
			BodyGen.SetMorph(akFemale, true, "WaistWidth", kw_Morph, 0)
			BodyGen.SetMorph(akFemale, true, "WaistDepthOut", kw_Morph, 0)
			BodyGen.SetMorph(akFemale, true, "LoveHandles", kw_Morph, 0)
			BodyGen.SetMorph(akFemale, true, "CheekWider", kw_Morph, 0)
			BodyGen.SetMorph(akFemale, true, "GluteLowerFatOut", kw_Morph, 0)
			BodyGen.SetMorph(akFemale, true, "GluteLowerHeightDown", kw_Morph, 0)
			BodyGen.SetMorph(akFemale, true, "HipFatter", kw_Morph, 0)
			BodyGen.SetMorph(akFemale, true, "ThighSize", kw_Morph, 0)
			BodyGen.SetMorph(akFemale, true, "UpperArmSize", kw_Morph, 0)
			BodyGen.SetMorph(akFemale, true, "Pregnant", kw_Morph, 0)
		Endif
		
			BodyGen.UpdateMorphs(akFemale)
EndFunction

Event OnEffectStart(Actor akActor, Actor akCaster)
	Ourself = akActor
	Instant_Birth(akActor)
EndEvent

Event OnInit()
	Setup()
EndEvent