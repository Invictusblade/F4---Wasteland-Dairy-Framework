ScriptName INVB_Cuminject_Preg_BB extends ObjectReference

Armor Property pArmor_Projector Auto Const Mandatory
Actor property PlayerRef Auto Const Mandatory
Keyword Property kw_Morph Auto
Keyword Property kw_noPreg Auto
GlobalVariable property INVB_Global_Power Auto Const Mandatory
GlobalVariable property INVB_Global_BodyType_CBBE Auto Const Mandatory
GlobalVariable property INVB_Global_BodyType_FG Auto Const Mandatory
GlobalVariable property INVB_Global_AllowedMales Auto Const Mandatory

Float Property OriginalThin Auto 
Float Property OriginalThicc Auto 
Float Property OriginalMuscular Auto 

String[] Property OrigMorphNames Auto
Float[] Property OrigMorphValues Auto

bool BabyBump_bool = false
Actor Ourself

Event OnEquipped(Actor akActor)
	Ourself = akActor
	If Ourself.HasKeyword(kw_noPreg) && BabyBump_bool == false
		Ourself.unequipitem(pArmor_Projector)
	else
		BabyBump_bool = true
		float power = (Utility.RandomFloat(5, 9) * INVB_Global_Power.getValue() * 0.015 * Utility.RandomFloat(0.8, 1.2))
		float maxMorphValue = INVB_Global_Power.getValue() / 5.0
		
		If (INVB_Global_BodyType_CBBE.GetValue() == 0) ; CBBE Original
			BodyGen.SetMorph(Ourself, true, "PregnancyBelly", kw_Morph, power + OrigValue("PregnancyBelly"))
			BodyGen.SetMorph(Ourself, true, "DoubleMelon", kw_Morph, (power/2) + OrigValue("DoubleMelon"))
			BodyGen.SetMorph(Ourself, true, "BigButt", kw_Morph, (power/2) + OrigValue("BigButt"))
		ElseIf (INVB_Global_BodyType_CBBE.GetValue() == 1) ; CBBE Redux
            BodyGen.SetMorph(Ourself, true, "Breasts", kw_Morph, power*0.9 + OrigValue("Breasts"))
            BodyGen.SetMorph(Ourself, true, "BreastsNewSH", kw_Morph, power*0.2 + OrigValue("BreastsNewSH"))
            BodyGen.SetMorph(Ourself, true, "BreastFantasy", kw_Morph, power*0.25 + OrigValue("BreastFantasy"))
            BodyGen.SetMorph(Ourself, true, "NippleLength", kw_Morph, power*0.58 + OrigValue("NippleLength"))
            BodyGen.SetMorph(Ourself, true, "NipplePerk2", kw_Morph, power*0.5 + OrigValue("NipplePerk2"))
            BodyGen.SetMorph(Ourself, true, "AppleCheeks", kw_Morph, power*0.4 + OrigValue("AppleCheeks"))
            BodyGen.SetMorph(Ourself, true, "Butt", kw_Morph, power*0.45 + OrigValue("Butt"))
            BodyGen.SetMorph(Ourself, true, "BreastWidth", kw_Morph, power*0.5 + OrigValue("BreastWidth"))
            BodyGen.SetMorph(Ourself, true, "ChubbyLegs", kw_Morph, power*0.23 + OrigValue("ChubbyLegs"))
            BodyGen.SetMorph(Ourself, true, "Giant belly (coldsteelj)", kw_Morph, power*0.8 + OrigValue("Giant belly (coldsteelj)"))
            BodyGen.SetMorph(Ourself, true, "PregnancyBelly", kw_Morph, power*0.35 + OrigValue("PregnancyBelly"))
            BodyGen.SetMorph(Ourself, true, "Giant belly up", kw_Morph, power*0.4 + OrigValue("Giant belly up"))
            BodyGen.SetMorph(Ourself, true, "ButtSmall", kw_Morph, power*-0.4 + OrigValue("ButtSmall"))
            BodyGen.SetMorph(Ourself, true, "BreastHeight", kw_Morph, power*0.55 + OrigValue("BreastHeight"))
            BodyGen.SetMorph(Ourself, true, "BreastGravity2", kw_Morph, power*-0.5 + OrigValue("BreastGravity2")) 
		endif
		If (INVB_Global_BodyType_FG.GetValue() == 0) ; Fusion Girl Original
			BodyGen.SetMorph(Ourself, true, "Belly Pregnant", kw_Morph, power + OrigValue("Belly Pregnant"))
			BodyGen.SetMorph(Ourself, true, "Boobs Yuge", kw_Morph, (power/2) + OrigValue("Boobs Yuge"))
			BodyGen.SetMorph(Ourself, true, "Bum Chubby", kw_Morph, Math.Min((power/2) + OrigValue("Bum Chubby"), maxMorphValue))
			BodyGen.SetMorph(Ourself, true, "Waist Size", kw_Morph, Math.Min((power/2) + OrigValue("Waist Size"), maxMorphValue))
			BodyGen.SetMorph(Ourself, true, "Waist Line", kw_Morph, Math.Min(power/2 + OrigValue("Waist Line"), maxMorphValue))
			BodyGen.SetMorph(Ourself, true, "Back Size", kw_Morph, Math.Min(power/2 + OrigValue("Back Size"), maxMorphValue))
			BodyGen.SetMorph(Ourself, true, "Back Arch", kw_Morph, Math.Min((power/2) + OrigValue("Back Arch"), maxMorphValue))
			BodyGen.SetMorph(Ourself, true, "Boobs Top Slope", kw_Morph, Math.Min((power/2) + OrigValue("Boobs Top Slope"), maxMorphValue))
			BodyGen.SetMorph(Ourself, true, "Hips Upper Width", kw_Morph, Math.Min((power/4) + OrigValue("Hips Upper Width"), maxMorphValue))
			BodyGen.SetMorph(Ourself, true, "Hips Size", kw_Morph, Math.Min((power/2) + OrigValue("Hips Size"), maxMorphValue))
			BodyGen.SetMorph(Ourself, true, "Legs Chubby", kw_Morph, Math.Min((power/2) + OrigValue("Legs Chubby"), maxMorphValue))
			BodyGen.SetMorph(Ourself, true, "Arms Chubby", kw_Morph, Math.Min((power/2) + OrigValue("Arms Chubby"), maxMorphValue))	
		ElseIf (INVB_Global_BodyType_FG.GetValue() == 1) ; Fusion Girl Redux
			bodygen.SetMorph(Ourself, True, "Belly Pregnant", kw_Morph, power + Self.OrigValue("Belly Pregnant"))
			bodygen.SetMorph(Ourself, True, "Boobs Yuge", kw_Morph, power / 2 as float + Self.OrigValue("Boobs Yuge"))
			bodygen.SetMorph(Ourself, True, "Boobs Tiny", kw_Morph, power / (-4) as float + Self.OrigValue("Boobs Tiny"))
			bodygen.SetMorph(Ourself, True, "Boobs Flat", kw_Morph, power / (-4) as float + Self.OrigValue("Boobs Flat"))
			BodyGen.SetMorph(Ourself, true, "Bum Chubby", kw_Morph, Math.Min((power/2) + OrigValue("Bum Chubby"), maxMorphValue))
			BodyGen.SetMorph(Ourself, true, "Waist Size", kw_Morph, Math.Min((power/4) + OrigValue("Waist Size"), maxMorphValue))
			BodyGen.SetMorph(Ourself, true, "Waist Line", kw_Morph, Math.Min(power/4 + OrigValue("Waist Line"), maxMorphValue))
			BodyGen.SetMorph(Ourself, true, "Back Size", kw_Morph, Math.Min(power/4 + OrigValue("Back Size"), maxMorphValue))
			BodyGen.SetMorph(Ourself, true, "Back Arch", kw_Morph, Math.Min((power/4) + OrigValue("Back Arch"), maxMorphValue))
			BodyGen.SetMorph(Ourself, true, "Boobs Top Slope", kw_Morph, Math.Min((power/4) + OrigValue("Boobs Top Slope"), maxMorphValue))
			BodyGen.SetMorph(Ourself, true, "Hips Upper Width", kw_Morph, Math.Min((power/4) + OrigValue("Hips Upper Width"), maxMorphValue))
			BodyGen.SetMorph(Ourself, true, "Hips Size", kw_Morph, Math.Min((power/4) + OrigValue("Hips Size"), maxMorphValue))
			BodyGen.SetMorph(Ourself, true, "Legs Chubby", kw_Morph, Math.Min((power/4) + OrigValue("Legs Chubby"), maxMorphValue))
			BodyGen.SetMorph(Ourself, true, "Arms Chubby", kw_Morph, Math.Min((power/4) + OrigValue("Arms Chubby"), maxMorphValue))	
		EndIf
		; JaneBod
			BodyGen.SetMorph(Ourself, true, "BreastsNaturalTypeSeven", kw_Morph, (power/2) + OrigValue("BreastsNaturalTypeSeven"))
			BodyGen.SetMorph(Ourself, true, "BreastSize",kw_Morph, (power/2) + OrigValue("BreastSize"))
			BodyGen.SetMorph(Ourself, true, "NippleShapeLargerSeven", kw_Morph, (power/2) + OrigValue("NippleShapeLargerSeven"))
			BodyGen.SetMorph(Ourself, true, "WaistWidth", kw_Morph, (power/2) + OrigValue("WaistWidth"))
			BodyGen.SetMorph(Ourself, true, "WaistDepthOut", kw_Morph, (power/2) + OrigValue("WaistDepthOut"))
			BodyGen.SetMorph(Ourself, true, "LoveHandles", kw_Morph, (power/2) + OrigValue("LoveHandles"))
			BodyGen.SetMorph(Ourself, true, "CheekWider", kw_Morph, (power/2) + OrigValue("CheekWider"))
			BodyGen.SetMorph(Ourself, true, "GluteLowerFatOut", kw_Morph, power/2 + OrigValue("GluteLowerFatOut"))
			BodyGen.SetMorph(Ourself, true, "GluteLowerHeightDown", kw_Morph, power/4 + OrigValue("GluteLowerHeightDown"))
			BodyGen.SetMorph(Ourself, true, "HipFatter", kw_Morph, (power/2) + OrigValue("HipFatter"))
			BodyGen.SetMorph(Ourself, true, "ThighSize", kw_Morph, (power/2) + OrigValue("ThighSize"))
			BodyGen.SetMorph(Ourself, true, "UpperArmSize", kw_Morph, (power/2) + OrigValue("UpperArmSize"))
			BodyGen.SetMorph(Ourself, true, "Pregnant", kw_Morph, (power) + OrigValue("Pregnant"))

			BodyGen.SetMorph(Ourself, false, "Mpreg", kw_Morph, power)
			BodyGen.UpdateMorphs(Ourself)
	endif
EndEvent

Function GetOriginalMorphs()
	Bool isFemale = (Ourself.GetLeveledActorBase().GetSex() == 1)
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

Event OnUnequipped(Actor akActor)
	If Ourself.HasKeyword(kw_noPreg) && BabyBump_bool == false
		Ourself.unequipitem(pArmor_Projector)
	else
		If Ourself.GetLeveledActorBase().GetSex() == 0
			Ourself.unequipitem(pArmor_Projector)
		else
		BabyBump_bool = false
			BodyGen.SetMorph(Ourself, true, "PregnancyBelly", kw_Morph, 0)
			BodyGen.SetMorph(Ourself, true, "DoubleMelon", kw_Morph, 0)
			BodyGen.SetMorph(Ourself, true, "BigButt", kw_Morph, 0)
		    BodyGen.SetMorph(Ourself, true, "Breasts", kw_Morph, 0)
            BodyGen.SetMorph(Ourself, true, "BreastsNewSH", kw_Morph, 0)
            BodyGen.SetMorph(Ourself, true, "BreastFantasy", kw_Morph, 0)
            BodyGen.SetMorph(Ourself, true, "NippleLength", kw_Morph, 0)
            BodyGen.SetMorph(Ourself, true, "NipplePerk2", kw_Morph, 0)
            BodyGen.SetMorph(Ourself, true, "AppleCheeks", kw_Morph, 0)
            BodyGen.SetMorph(Ourself, true, "Butt", kw_Morph, 0)
            BodyGen.SetMorph(Ourself, true, "BreastWidth", kw_Morph, 0)
            BodyGen.SetMorph(Ourself, true, "ChubbyLegs", kw_Morph, 0)
            BodyGen.SetMorph(Ourself, true, "Giant belly (coldsteelj)", kw_Morph, 0)
            BodyGen.SetMorph(Ourself, true, "PregnancyBelly", kw_Morph, 0)
            BodyGen.SetMorph(Ourself, true, "Giant belly up", kw_Morph, 0)
            BodyGen.SetMorph(Ourself, true, "ButtSmall", kw_Morph, 0)
            BodyGen.SetMorph(Ourself, true, "BreastHeight", kw_Morph, 0)
            BodyGen.SetMorph(Ourself, true, "BreastGravity2", kw_Morph, 0)
			BodyGen.SetMorph(Ourself, true, "Belly Pregnant", kw_Morph, 0)
			BodyGen.SetMorph(Ourself, true, "Boobs Yuge", kw_Morph, 0)
			BodyGen.SetMorph(Ourself, true, "Bum Chubby", kw_Morph, 0)
			BodyGen.SetMorph(Ourself, true, "Waist Size", kw_Morph, 0)
			BodyGen.SetMorph(Ourself, true, "Waist Line", kw_Morph, 0)
			BodyGen.SetMorph(Ourself, true, "Back Size", kw_Morph, 0)
			BodyGen.SetMorph(Ourself, true, "Back Arch", kw_Morph, 0)
			BodyGen.SetMorph(Ourself, true, "Boobs Top Slope", kw_Morph, 0)
			BodyGen.SetMorph(Ourself, true, "Hips Upper Width", kw_Morph, 0)
			BodyGen.SetMorph(Ourself, true, "Hips Size", kw_Morph, 0)
			BodyGen.SetMorph(Ourself, true, "Legs Chubby", kw_Morph, 0)
			BodyGen.SetMorph(Ourself, true, "Arms Chubby", kw_Morph, 0)
			bodygen.SetMorph(Ourself, True, "Belly Pregnant", kw_Morph, 0)
			bodygen.SetMorph(Ourself, True, "Boobs Yuge", kw_Morph, 0)
			bodygen.SetMorph(Ourself, True, "Boobs Tiny", kw_Morph, 0)
			bodygen.SetMorph(Ourself, True, "Boobs Flat", kw_Morph, 0)
			bodygen.SetMorph(Ourself, True, "Bum Chubby", kw_Morph, 0)
			bodygen.SetMorph(Ourself, True, "Waist Size", kw_Morph, 0)
			bodygen.SetMorph(Ourself, True, "Waist Line", kw_Morph, 0)
			bodygen.SetMorph(Ourself, True, "Back Size", kw_Morph, 0)
			bodygen.SetMorph(Ourself, True, "Back Arch", kw_Morph, 0)
			bodygen.SetMorph(Ourself, True, "Boobs Top Slope", kw_Morph, 0)
			bodygen.SetMorph(Ourself, True, "Hips Upper Width", kw_Morph, 0)
			bodygen.SetMorph(Ourself, True, "Hips Size", kw_Morph, 0)
			bodygen.SetMorph(Ourself, True, "Legs Chubby", kw_Morph, 0)
			bodygen.SetMorph(Ourself, True, "Arms Chubby", kw_Morph, 0)
			BodyGen.SetMorph(Ourself, true, "BreastsNaturalTypeSeven", kw_Morph, 0)
			BodyGen.SetMorph(Ourself, true, "BreastSize",kw_Morph, 0)
			BodyGen.SetMorph(Ourself, true, "NippleShapeLargerSeven", kw_Morph, 0)
			BodyGen.SetMorph(Ourself, true, "WaistWidth", kw_Morph, 0)
			BodyGen.SetMorph(Ourself, true, "WaistDepthOut", kw_Morph, 0)
			BodyGen.SetMorph(Ourself, true, "LoveHandles", kw_Morph, 0)
			BodyGen.SetMorph(Ourself, true, "CheekWider", kw_Morph, 0)
			BodyGen.SetMorph(Ourself, true, "GluteLowerFatOut", kw_Morph, 0)
			BodyGen.SetMorph(Ourself, true, "GluteLowerHeightDown", kw_Morph, 0)
			BodyGen.SetMorph(Ourself, true, "HipFatter", kw_Morph, 0)
			BodyGen.SetMorph(Ourself, true, "ThighSize", kw_Morph, 0)
			BodyGen.SetMorph(Ourself, true, "UpperArmSize", kw_Morph, 0)
			BodyGen.SetMorph(Ourself, true, "Pregnant", kw_Morph, 0)
			BodyGen.SetMorph(Ourself, false, "Mpreg", kw_Morph, 0)
			BodyGen.UpdateMorphs(Ourself)
		EndIf
	endif
EndEvent