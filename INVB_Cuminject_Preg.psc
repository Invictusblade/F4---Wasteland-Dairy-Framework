ScriptName INVB_Cuminject_Preg extends ObjectReference

Armor Property pArmor_Projector Auto Const Mandatory
Actor property PlayerRef Auto Const Mandatory
Keyword Property kw_Morph Auto
Keyword Property kw_noPreg Auto
GlobalVariable property INVB_Global_Power Auto Const Mandatory
GlobalVariable property INVB_Global_BodyType Auto Const Mandatory
GlobalVariable property INVB_Global_AllowedMales Auto Const Mandatory

Float Property OriginalThin Auto 
Float Property OriginalThicc Auto 
Float Property OriginalMuscular Auto 

String[] Property OrigMorphNames Auto
Float[] Property OrigMorphValues Auto
Actor Ourself

Event OnEquipped(Actor akActor)
	Ourself = akActor
	int currentMonth = 0
	
	int before_random_time = Utility.RandomInt(10, 30)
	
	If akActor != Game.GetPlayer()
		while (currentMonth <= 10)
			UpdateBody(akActor, currentMonth)
			Utility.Wait(before_random_time)
			currentMonth += 1
		endwhile
			akActor.AddKeyword(kw_noPreg)
	endif
EndEvent

Event OnUnequipped(Actor akActor)
	int Afterbirth = 10

		int after_random_time = Utility.RandomInt(10, 30)
	If akActor != Game.GetPlayer()
		while (Afterbirth >= 0)
			UpdateBody(akActor, Afterbirth)
			Utility.Wait(after_random_time)
			Afterbirth -= 1
		endwhile
	

	akActor.RemoveKeyword(kw_noPreg)
	ReduceBelly(akActor)
	endif
EndEvent

Function UpdateBody(actor akFemale, Float akMonth)
	float power = (akMonth * INVB_Global_Power.getValue() * 0.015 * Utility.RandomFloat(0.8, 1.2))
		float maxMorphValue = INVB_Global_Power.getValue() / 5.0
		
		If (INVB_Global_BodyType.GetValue() == 0) ; CBBE Original
			BodyGen.SetMorph(Ourself, true, "PregnancyBelly", kw_Morph, power + OrigValue("PregnancyBelly"))
			BodyGen.SetMorph(Ourself, true, "DoubleMelon", kw_Morph, (power/2) + OrigValue("DoubleMelon"))
			BodyGen.SetMorph(Ourself, true, "BigButt", kw_Morph, (power/2) + OrigValue("BigButt"))
		ElseIf (INVB_Global_BodyType.GetValue() == 1) ; CBBE Redux
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
		ElseIf (INVB_Global_BodyType.GetValue() == 2) ; Fusion Girl Original
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
		ElseIf (INVB_Global_BodyType.GetValue() == 3) ; Fusion Girl Redux
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
		Else ; JaneBod
			BodyGen.SetMorph(akFemale, true, "BreastsNaturalTypeSeven", kw_Morph, (power/2) + OrigValue("BreastsNaturalTypeSeven"))
			BodyGen.SetMorph(akFemale, true, "BreastSize",kw_Morph, (power/2) + OrigValue("BreastSize"))
			BodyGen.SetMorph(akFemale, true, "NippleShapeLargerSeven", kw_Morph, (power/2) + OrigValue("NippleShapeLargerSeven"))
			BodyGen.SetMorph(akFemale, true, "WaistWidth", kw_Morph, (power/2) + OrigValue("WaistWidth"))
			BodyGen.SetMorph(akFemale, true, "WaistDepthOut", kw_Morph, (power/2) + OrigValue("WaistDepthOut"))
			BodyGen.SetMorph(akFemale, true, "LoveHandles", kw_Morph, (power/2) + OrigValue("LoveHandles"))
			BodyGen.SetMorph(akFemale, true, "CheekWider", kw_Morph, (power/2) + OrigValue("CheekWider"))
			BodyGen.SetMorph(akFemale, true, "GluteLowerFatOut", kw_Morph, power/2 + OrigValue("GluteLowerFatOut"))
			BodyGen.SetMorph(akFemale, true, "GluteLowerHeightDown", kw_Morph, power/4 + OrigValue("GluteLowerHeightDown"))
			BodyGen.SetMorph(akFemale, true, "HipFatter", kw_Morph, (power/2) + OrigValue("HipFatter"))
			BodyGen.SetMorph(akFemale, true, "ThighSize", kw_Morph, (power/2) + OrigValue("ThighSize"))
			BodyGen.SetMorph(akFemale, true, "UpperArmSize", kw_Morph, (power/2) + OrigValue("UpperArmSize"))
			BodyGen.SetMorph(akFemale, true, "Pregnant", kw_Morph, (power) + OrigValue("Pregnant"))
		EndIf
		if INVB_Global_AllowedMales.GetValue() == 1
			BodyGen.SetMorph(akFemale, false, "Mpreg", kw_Morph, power)
		endif
		BodyGen.UpdateMorphs(akFemale)
EndFunction

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

Function ReduceBelly(actor akFemale)
	If (INVB_Global_BodyType.GetValue() == 0) ; CBBE Original
			BodyGen.SetMorph(akFemale, true, "PregnancyBelly", kw_Morph, 0)
			BodyGen.SetMorph(akFemale, true, "DoubleMelon", kw_Morph, 0)
			BodyGen.SetMorph(akFemale, true, "BigButt", kw_Morph, 0)
		ElseIf (INVB_Global_BodyType.GetValue() == 1) ; CBBE Redux
            BodyGen.SetMorph(akFemale, true, "Breasts", kw_Morph, 0)
            BodyGen.SetMorph(akFemale, true, "BreastsNewSH", kw_Morph, 0)
            BodyGen.SetMorph(akFemale, true, "BreastFantasy", kw_Morph, 0)
            BodyGen.SetMorph(akFemale, true, "NippleLength", kw_Morph, 0)
            BodyGen.SetMorph(akFemale, true, "NipplePerk2", kw_Morph, 0)
            BodyGen.SetMorph(akFemale, true, "AppleCheeks", kw_Morph, 0)
            BodyGen.SetMorph(akFemale, true, "Butt", kw_Morph, 0)
            BodyGen.SetMorph(akFemale, true, "BreastWidth", kw_Morph, 0)
            BodyGen.SetMorph(akFemale, true, "ChubbyLegs", kw_Morph, 0)
            BodyGen.SetMorph(akFemale, true, "Giant belly (coldsteelj)", kw_Morph, 0)
            BodyGen.SetMorph(akFemale, true, "PregnancyBelly", kw_Morph, 0)
            BodyGen.SetMorph(akFemale, true, "Giant belly up", kw_Morph, 0)
            BodyGen.SetMorph(akFemale, true, "ButtSmall", kw_Morph, 0)
            BodyGen.SetMorph(akFemale, true, "BreastHeight", kw_Morph, 0)
            BodyGen.SetMorph(akFemale, true, "BreastGravity2", kw_Morph, 0)
		ElseIf (INVB_Global_BodyType.GetValue() == 2) ; Fusion Girl Original
			BodyGen.SetMorph(akFemale, true, "Belly Pregnant", kw_Morph, 0)
			BodyGen.SetMorph(akFemale, true, "Boobs Yuge", kw_Morph, 0)
			BodyGen.SetMorph(akFemale, true, "Bum Chubby", kw_Morph, 0)
			BodyGen.SetMorph(akFemale, true, "Waist Size", kw_Morph, 0)
			BodyGen.SetMorph(akFemale, true, "Waist Line", kw_Morph, 0)
			BodyGen.SetMorph(akFemale, true, "Back Size", kw_Morph, 0)
			BodyGen.SetMorph(akFemale, true, "Back Arch", kw_Morph, 0)
			BodyGen.SetMorph(akFemale, true, "Boobs Top Slope", kw_Morph, 0)
			BodyGen.SetMorph(akFemale, true, "Hips Upper Width", kw_Morph, 0)
			BodyGen.SetMorph(akFemale, true, "Hips Size", kw_Morph, 0)
			BodyGen.SetMorph(akFemale, true, "Legs Chubby", kw_Morph, 0)
			BodyGen.SetMorph(akFemale, true, "Arms Chubby", kw_Morph, 0)
		ElseIf (INVB_Global_BodyType.GetValue() == 3) ; Fusion Girl Redux
			bodygen.SetMorph(akFemale, True, "Belly Pregnant", kw_Morph, 0)
			bodygen.SetMorph(akFemale, True, "Boobs Yuge", kw_Morph, 0)
			bodygen.SetMorph(akFemale, True, "Boobs Tiny", kw_Morph, 0)
			bodygen.SetMorph(akFemale, True, "Boobs Flat", kw_Morph, 0)
			bodygen.SetMorph(akFemale, True, "Bum Chubby", kw_Morph, 0)
			bodygen.SetMorph(akFemale, True, "Waist Size", kw_Morph, 0)
			bodygen.SetMorph(akFemale, True, "Waist Line", kw_Morph, 0)
			bodygen.SetMorph(akFemale, True, "Back Size", kw_Morph, 0)
			bodygen.SetMorph(akFemale, True, "Back Arch", kw_Morph, 0)
			bodygen.SetMorph(akFemale, True, "Boobs Top Slope", kw_Morph, 0)
			bodygen.SetMorph(akFemale, True, "Hips Upper Width", kw_Morph, 0)
			bodygen.SetMorph(akFemale, True, "Hips Size", kw_Morph, 0)
			bodygen.SetMorph(akFemale, True, "Legs Chubby", kw_Morph, 0)
			bodygen.SetMorph(akFemale, True, "Arms Chubby", kw_Morph, 0)
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
		EndIf
		BodyGen.UpdateMorphs(akFemale)
EndFunction