ScriptName INVB_InstantBirth_arm extends ObjectReference

GlobalVariable property FPFP_Global_Power Auto Const Mandatory
GlobalVariable property FPFP_Global_BodyType_CBBE Auto Const Mandatory
GlobalVariable property FPFP_Global_BodyType_FG Auto Const Mandatory
GlobalVariable property INVB_Global_Notes Auto Const Mandatory
GlobalVariable property INVB_Global_Birth_Time Auto Const Mandatory
Keyword Property FPFP_Keyword Auto
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
Actor Ourself
Armor Property pArmor_Quick_Preggo Auto Const Mandatory

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
		StartTimerGameTime(GetUpdateTime())
    EndIf
EndFunction

Event OnTimerGameTime(int aiTimerID)
    FPFP_BasePregData tmpData = FPE.GetPregnancyInfo(Ourself)
	if currentMonth < 10
		UpdateBody(Ourself, currentMonth)
			
		if INVB_Global_Notes.GetValue() == 1	
			Debug.notification("Simulated Month: "+ currentMonth as int)
		endIf
		currentMonth += 1
		StartTimerGameTime(GetUpdateTime())
	elseif currentMonth >= 10	
		tmpData.GiveBirth(true)
		ReduceBelly(Ourself)
		Ourself.removeitem(pArmor_Quick_Preggo, 1, true)
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

Function GetOriginalMorphs()
	Bool isFemale = (Ourself.GetLeveledActorBase().GetSex() == 1)
	Trace("GetOriginalMorphs for " + Ourself.GetLeveledActorBase().GetName() + " isFemale " + isFemale + " fem body " + FPFP_Global_BodyType.GetValue() + " male body " + FPFP_Global_MaleBodyType.GetValue())
	OrigMorphNames = BodyGen.GetMorphs(Ourself, isFemale)
	If (OrigMorphNames.Length)
		OrigMorphValues = New Float[OrigMorphNames.Length]
		int i = 0
		While (i < OrigMorphNames.Length)
			Keyword[] MorphKeywords = BodyGen.GetKeywords(Ourself, isFemale, OrigMorphNames[i])
			Keyword MyKeyword = None
			If (MorphKeywords.Length)
				MyKeyword = MorphKeywords[MorphKeywords.Length - 1] ; always get the last keyword 
			EndIf
			
			OrigMorphValues[i] = BodyGen.GetMorph(Ourself, isFemale, OrigMorphNames[i], MyKeyword)
			;Trace(Ourself.GetLeveledActorBase().GetName() + " found morph " + OrigMorphNames[i] + " value " + OrigMorphValues[i] + " keyword " + MyKeyword)
			i += 1
		EndWhile
	EndIf
EndFunction

Float Function OrigValue(String MorphName)
	If (OrigMorphNames.Length)
		int idx = OrigMorphNames.Find(MorphName)
		If (idx > -1)
			;Trace(Ourself.GetLeveledActorBase().GetName() + " found morph " + MorphName + " value " + OrigMorphValues[idx])
			Return OrigMorphValues[idx]
		EndIf
	EndIf
	Return 0.0
EndFunction

Function UpdateBody(actor akFemale, Float akMonth)
	float power = (akMonth * FPFP_Global_Power.getValue() * 0.015 * Utility.RandomFloat(0.8, 1.2))
	If (FPFP_Global_BodyType_CBBE.GetValue() == 0) ; CBBE Original
			BodyGen.SetMorph(Ourself, true, "PregnancyBelly", FPFP_Keyword, power + OrigValue("PregnancyBelly"))
			BodyGen.SetMorph(Ourself, true, "DoubleMelon", FPFP_Keyword, (power/2) + OrigValue("DoubleMelon"))
			BodyGen.SetMorph(Ourself, true, "BigButt", FPFP_Keyword, Math.Min((power/2) + OrigValue("BigButt"), maxMorphValue))
		ElseIf (FPFP_Global_BodyType_CBBE.GetValue() == 1) ; CBBE Redux
            BodyGen.SetMorph(Ourself, true, "Breasts", FPFP_Keyword, power*0.9 + OrigValue("Breasts"))
            BodyGen.SetMorph(Ourself, true, "BreastsNewSH", FPFP_Keyword, power*0.2 + OrigValue("BreastsNewSH"))
            BodyGen.SetMorph(Ourself, true, "BreastFantasy", FPFP_Keyword, power*0.25 + OrigValue("BreastFantasy"))
            BodyGen.SetMorph(Ourself, true, "NippleLength", FPFP_Keyword, power*0.58 + OrigValue("NippleLength"))
            BodyGen.SetMorph(Ourself, true, "NipplePerk2", FPFP_Keyword, power*0.5 + OrigValue("NipplePerk2"))
            BodyGen.SetMorph(Ourself, true, "AppleCheeks", FPFP_Keyword, power*0.4 + OrigValue("AppleCheeks"))
            BodyGen.SetMorph(Ourself, true, "Butt", FPFP_Keyword, power*0.45 + OrigValue("Butt"))
            BodyGen.SetMorph(Ourself, true, "BreastWidth", FPFP_Keyword, power*0.5 + OrigValue("BreastWidth"))
            BodyGen.SetMorph(Ourself, true, "ChubbyLegs", FPFP_Keyword, power*0.23 + OrigValue("ChubbyLegs"))
            BodyGen.SetMorph(Ourself, true, "Giant belly (coldsteelj)", FPFP_Keyword, power*0.8 + OrigValue("Giant belly (coldsteelj)"))
            BodyGen.SetMorph(Ourself, true, "PregnancyBelly", FPFP_Keyword, power*0.35 + OrigValue("PregnancyBelly"))
            BodyGen.SetMorph(Ourself, true, "Giant belly up", FPFP_Keyword, power*0.4 + OrigValue("Giant belly up"))
            BodyGen.SetMorph(Ourself, true, "ButtSmall", FPFP_Keyword, power*-0.4 + OrigValue("ButtSmall"))
            BodyGen.SetMorph(Ourself, true, "BreastHeight", FPFP_Keyword, power*0.55 + OrigValue("BreastHeight"))
            BodyGen.SetMorph(Ourself, true, "BreastGravity2", FPFP_Keyword, power*-0.5 + OrigValue("BreastGravity2")) 
		endIf
		If (FPFP_Global_BodyType_FG.GetValue() == 0) ; Fusion Girl Original
			BodyGen.SetMorph(Ourself, true, "Belly Pregnant", FPFP_Keyword, power + OrigValue("Belly Pregnant"))
			BodyGen.SetMorph(Ourself, true, "Boobs Yuge", FPFP_Keyword, (power/2) + OrigValue("Boobs Yuge"))
			BodyGen.SetMorph(Ourself, true, "Bum Chubby", FPFP_Keyword, Math.Min((power/2) + OrigValue("Bum Chubby"), maxMorphValue))
			BodyGen.SetMorph(Ourself, true, "Waist Size", FPFP_Keyword, Math.Min((power/2) + OrigValue("Waist Size"), maxMorphValue))
			BodyGen.SetMorph(Ourself, true, "Waist Line", FPFP_Keyword, Math.Min(power/2 + OrigValue("Waist Line"), maxMorphValue))
			BodyGen.SetMorph(Ourself, true, "Back Size", FPFP_Keyword, Math.Min(power/2 + OrigValue("Back Size"), maxMorphValue))
			BodyGen.SetMorph(Ourself, true, "Back Arch", FPFP_Keyword, Math.Min((power/2) + OrigValue("Back Arch"), maxMorphValue))
			BodyGen.SetMorph(Ourself, true, "Boobs Top Slope", FPFP_Keyword, Math.Min((power/2) + OrigValue("Boobs Top Slope"), maxMorphValue))
			BodyGen.SetMorph(Ourself, true, "Hips Upper Width", FPFP_Keyword, Math.Min((power/4) + OrigValue("Hips Upper Width"), maxMorphValue))
			BodyGen.SetMorph(Ourself, true, "Hips Size", FPFP_Keyword, Math.Min((power/2) + OrigValue("Hips Size"), maxMorphValue))
			BodyGen.SetMorph(Ourself, true, "Legs Chubby", FPFP_Keyword, Math.Min((power/2) + OrigValue("Legs Chubby"), maxMorphValue))
			BodyGen.SetMorph(Ourself, true, "Arms Chubby", FPFP_Keyword, Math.Min((power/2) + OrigValue("Arms Chubby"), maxMorphValue))	
		ElseIf (FPFP_Global_BodyType_FG.GetValue() == 1) ; Fusion Girl Redux
			bodygen.SetMorph(Ourself, True, "Belly Pregnant", FPFP_Keyword, power + Self.OrigValue("Belly Pregnant"))
			bodygen.SetMorph(Ourself, True, "Boobs Yuge", FPFP_Keyword, power / 2 as float + Self.OrigValue("Boobs Yuge"))
			bodygen.SetMorph(Ourself, True, "Boobs Tiny", FPFP_Keyword, power / (-4) as float + Self.OrigValue("Boobs Tiny"))
			bodygen.SetMorph(Ourself, True, "Boobs Flat", FPFP_Keyword, power / (-4) as float + Self.OrigValue("Boobs Flat"))
			BodyGen.SetMorph(Ourself, true, "Bum Chubby", FPFP_Keyword, Math.Min((power/2) + OrigValue("Bum Chubby"), maxMorphValue))
			BodyGen.SetMorph(Ourself, true, "Waist Size", FPFP_Keyword, Math.Min((power/4) + OrigValue("Waist Size"), maxMorphValue))
			BodyGen.SetMorph(Ourself, true, "Waist Line", FPFP_Keyword, Math.Min(power/4 + OrigValue("Waist Line"), maxMorphValue))
			BodyGen.SetMorph(Ourself, true, "Back Size", FPFP_Keyword, Math.Min(power/4 + OrigValue("Back Size"), maxMorphValue))
			BodyGen.SetMorph(Ourself, true, "Back Arch", FPFP_Keyword, Math.Min((power/4) + OrigValue("Back Arch"), maxMorphValue))
			BodyGen.SetMorph(Ourself, true, "Boobs Top Slope", FPFP_Keyword, Math.Min((power/4) + OrigValue("Boobs Top Slope"), maxMorphValue))
			BodyGen.SetMorph(Ourself, true, "Hips Upper Width", FPFP_Keyword, Math.Min((power/4) + OrigValue("Hips Upper Width"), maxMorphValue))
			BodyGen.SetMorph(Ourself, true, "Hips Size", FPFP_Keyword, Math.Min((power/4) + OrigValue("Hips Size"), maxMorphValue))
			BodyGen.SetMorph(Ourself, true, "Legs Chubby", FPFP_Keyword, Math.Min((power/4) + OrigValue("Legs Chubby"), maxMorphValue))
			BodyGen.SetMorph(Ourself, true, "Arms Chubby", FPFP_Keyword, Math.Min((power/4) + OrigValue("Arms Chubby"), maxMorphValue))	
		endIf
		; JaneBod
			BodyGen.SetMorph(Ourself, true, "BreastsNaturalTypeSeven", FPFP_Keyword, (power/2) + OrigValue("BreastsNaturalTypeSeven"))
			BodyGen.SetMorph(Ourself, true, "BreastSize",FPFP_Keyword, (power/2) + OrigValue("BreastSize"))
			BodyGen.SetMorph(Ourself, true, "NippleShapeLargerSeven", FPFP_Keyword, (power/2) + OrigValue("NippleShapeLargerSeven"))
			BodyGen.SetMorph(Ourself, true, "WaistWidth", FPFP_Keyword, (power/2) + OrigValue("WaistWidth"))
			BodyGen.SetMorph(Ourself, true, "WaistDepthOut", FPFP_Keyword, (power/2) + OrigValue("WaistDepthOut"))
			BodyGen.SetMorph(Ourself, true, "LoveHandles", FPFP_Keyword, (power/2) + OrigValue("LoveHandles"))
			BodyGen.SetMorph(Ourself, true, "CheekWider", FPFP_Keyword, (power/2) + OrigValue("CheekWider"))
			BodyGen.SetMorph(Ourself, true, "GluteLowerFatOut", FPFP_Keyword, power/2 + OrigValue("GluteLowerFatOut"))
			BodyGen.SetMorph(Ourself, true, "GluteLowerHeightDown", FPFP_Keyword, power/4 + OrigValue("GluteLowerHeightDown"))
			BodyGen.SetMorph(Ourself, true, "HipFatter", FPFP_Keyword, (power/2) + OrigValue("HipFatter"))
			BodyGen.SetMorph(Ourself, true, "ThighSize", FPFP_Keyword, (power/2) + OrigValue("ThighSize"))
			BodyGen.SetMorph(Ourself, true, "UpperArmSize", FPFP_Keyword, (power/2) + OrigValue("UpperArmSize"))
			BodyGen.SetMorph(Ourself, true, "Pregnant", FPFP_Keyword, (power) + OrigValue("Pregnant"))
		EndIf
		BodyGen.UpdateMorphs(Ourself)
EndFunction

Function ReduceBelly(actor akFemale)
	If (Ourself.GetLeveledActorBase().GetSex() != 1)
		If (FPFP_Global_MaleBodyType.GetValue() == 0)
			If OriginalThin != 0.0 || OriginalThicc != 0.0 || OriginalMuscular != 0.0 ; if we have values for preggo return to normalcy
				ActorBase:BodyWeight newWeight = new ActorBase:BodyWeight
				newWeight.large = OriginalThicc
				newWeight.thin = OriginalThin
				newWeight.muscular = OriginalMuscular
				Ourself.GetLeveledActorBase().SetBodyWeight(newWeight)
				Ourself.QueueUpdate(flags = 0xC)
			EndIf
		Else
			BodyGen.RemoveMorphsByKeyword(Ourself, false, FPFP_Keyword)
			BodyGen.UpdateMorphs(Ourself)
		EndIf
	Else
		BodyGen.RemoveMorphsByKeyword(Ourself, true, FPFP_Keyword)
		BodyGen.UpdateMorphs(Ourself)
	EndIf
	
	AffectedByMorphs = False
	
EndFunction
EndFunction

Event OnEquipped(Actor akActor)
	Ourself = akActor
	if INVB_Global_Notes.GetValue() == 1	
		Debug.notification("Quick Preggo has been injected")
	endIf
	Instant_Birth(akActor)
EndEvent

Event OnInit()
	Setup()
EndEvent