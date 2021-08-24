ScriptName INVB_Furn_Cuminject_Preg_FPE extends ObjectReference

Idle Property FurnitureExitToStand auto const mandatory
Keyword Property kw_Morph Auto
Keyword Property kw_noPreg Auto
GlobalVariable property INVB_Global_Power Auto Const Mandatory
GlobalVariable property INVB_Global_BodyType Auto Const Mandatory
Keyword Property AnimFaceArchetypeFatherDeath auto const mandatory
GlobalVariable property INVB_Global_AllowedMales Auto Const Mandatory
Actor skActor
Bool bOccupied = false

Float Property OriginalThin Auto 
Float Property OriginalThicc Auto 
Float Property OriginalMuscular Auto 

String[] Property OrigMorphNames Auto
Float[] Property OrigMorphValues Auto

Event OnActivate(ObjectReference akActionRef)
	int i
	bOccupied = true
	skActor = akActionRef as Actor
	
	if (skActor != Game.GetPlayer())
		If skActor.HasKeyword(kw_noPreg)
			Utility.Wait(5.0)
			skActor.PlayIdle(FurnitureExitToStand)
		else
			If skActor.GetLeveledActorBase().GetSex() == 0 && INVB_Global_AllowedMales.GetValue() == 0	
				Utility.Wait(5.0)
				skActor.PlayIdle(FurnitureExitToStand)
			else
				skActor.ChangeAnimFaceArchetype(AnimFaceArchetypeFatherDeath)
			while (i <= 9) && (bOccupied == true)
			
				; UpdateBody(skActor, i)
				UpdateBody(skActor, 9)
				i += 1
			
				Utility.Wait(5.0)
			
			endwhile
			EndIf
		endif	
	else
	endif
EndEvent


Event OnExitFurniture(ObjectReference akActionRef)
	bOccupied = false
	Utility.Wait(5.0)
	ReduceBelly(skActor)
	skActor.ChangeAnimFaceArchetype()
	skActor = none
	
EndEvent


Function UpdateBody(actor akFemale, Float akMonth)
	float power = (akMonth * INVB_Global_Power.getValue() * 0.015 * Utility.RandomFloat(0.8, 1.2))

	GetOriginalMorphs()
		
	If (INVB_Global_BodyType.GetValue() == 0) ; CBBE Original
			BodyGen.SetMorph(skActor, true, "PregnancyBelly", kw_Morph, power + OrigValue("PregnancyBelly"))
			BodyGen.SetMorph(skActor, true, "DoubleMelon", kw_Morph, (power/2) + OrigValue("DoubleMelon"))
			BodyGen.SetMorph(skActor, true, "BigButt", kw_Morph, (power/2) + OrigValue("BigButt"))
		ElseIf (INVB_Global_BodyType.GetValue() == 1) ; CBBE Redux
            BodyGen.SetMorph(skActor, true, "Breasts", kw_Morph, power*0.9 + OrigValue("Breasts"))
            BodyGen.SetMorph(skActor, true, "BreastsNewSH", kw_Morph, power*0.2 + OrigValue("BreastsNewSH"))
            BodyGen.SetMorph(skActor, true, "BreastFantasy", kw_Morph, power*0.25 + OrigValue("BreastFantasy"))
            BodyGen.SetMorph(skActor, true, "NippleLength", kw_Morph, power*0.58 + OrigValue("NippleLength"))
            BodyGen.SetMorph(skActor, true, "NipplePerk2", kw_Morph, power*0.5 + OrigValue("NipplePerk2"))
            BodyGen.SetMorph(skActor, true, "AppleCheeks", kw_Morph, power*0.4 + OrigValue("AppleCheeks"))
            BodyGen.SetMorph(skActor, true, "Butt", kw_Morph, power*0.45 + OrigValue("Butt"))
            BodyGen.SetMorph(skActor, true, "BreastWidth", kw_Morph, power*0.5 + OrigValue("BreastWidth"))
            BodyGen.SetMorph(skActor, true, "ChubbyLegs", kw_Morph, power*0.23 + OrigValue("ChubbyLegs"))
            BodyGen.SetMorph(skActor, true, "Giant belly (coldsteelj)", kw_Morph, power*0.8 + OrigValue("Giant belly (coldsteelj)"))
            BodyGen.SetMorph(skActor, true, "PregnancyBelly", kw_Morph, power*0.35 + OrigValue("PregnancyBelly"))
            BodyGen.SetMorph(skActor, true, "Giant belly up", kw_Morph, power*0.4 + OrigValue("Giant belly up"))
            BodyGen.SetMorph(skActor, true, "ButtSmall", kw_Morph, power*-0.4 + OrigValue("ButtSmall"))
            BodyGen.SetMorph(skActor, true, "BreastHeight", kw_Morph, power*0.55 + OrigValue("BreastHeight"))
            BodyGen.SetMorph(skActor, true, "BreastGravity2", kw_Morph, power*-0.5 + OrigValue("BreastGravity2")) 
		ElseIf (INVB_Global_BodyType.GetValue() == 2) ; Fusion Girl Original
			BodyGen.SetMorph(skActor, true, "Belly Pregnant", kw_Morph, power + OrigValue("Belly Pregnant"))
			BodyGen.SetMorph(skActor, true, "Boobs Yuge", kw_Morph, (power/2) + OrigValue("Boobs Yuge"))
			BodyGen.SetMorph(skActor, true, "Bum Chubby", kw_Morph, (power/2) + OrigValue("Bum Chubby"))
			BodyGen.SetMorph(skActor, true, "Waist Size", kw_Morph, (power/2) + OrigValue("Waist Size"))
			BodyGen.SetMorph(skActor, true, "Waist Line", kw_Morph, power + OrigValue("Waist Line"))
			BodyGen.SetMorph(skActor, true, "Back Size", kw_Morph, power + OrigValue("Back Size"))
			BodyGen.SetMorph(skActor, true, "Back Arch", kw_Morph, (power/2) + OrigValue("Back Arch"))
			BodyGen.SetMorph(skActor, true, "Boobs Top Slope", kw_Morph, (power/2) + OrigValue("Boobs Top Slope"))
			BodyGen.SetMorph(skActor, true, "Hips Upper Width", kw_Morph, (power/4) + OrigValue("Hips Upper Width"))
			BodyGen.SetMorph(skActor, true, "Hips Size", kw_Morph, (power/2) + OrigValue("Hips Size"))
			BodyGen.SetMorph(skActor, true, "Legs Chubby", kw_Morph, (power/2) + OrigValue("Legs Chubby"))
			BodyGen.SetMorph(skActor, true, "Arms Chubby", kw_Morph, (power/2) + OrigValue("Arms Chubby"))
		ElseIf (INVB_Global_BodyType.GetValue() == 3) ; Fusion Girl Redux
			bodygen.SetMorph(skActor, True, "Belly Pregnant", kw_Morph, power + Self.OrigValue("Belly Pregnant"))
			bodygen.SetMorph(skActor, True, "Boobs Yuge", kw_Morph, power / 2 as float + Self.OrigValue("Boobs Yuge"))
			bodygen.SetMorph(skActor, True, "Boobs Tiny", kw_Morph, power / (-4) as float + Self.OrigValue("Boobs Tiny"))
			bodygen.SetMorph(skActor, True, "Boobs Flat", kw_Morph, power / (-4) as float + Self.OrigValue("Boobs Flat"))
			bodygen.SetMorph(skActor, True, "Bum Chubby", kw_Morph, power / 2 as float + Self.OrigValue("Bum Chubby"))
			bodygen.SetMorph(skActor, True, "Waist Size", kw_Morph, power / 4 as float + Self.OrigValue("Waist Size"))
			bodygen.SetMorph(skActor, True, "Waist Line", kw_Morph, power / 4 as float + Self.OrigValue("Waist Line"))
			bodygen.SetMorph(skActor, True, "Back Size", kw_Morph, power / 4 as float + Self.OrigValue("Back Size"))
			bodygen.SetMorph(skActor, True, "Back Arch", kw_Morph, power / 4 as float + Self.OrigValue("Back Arch"))
			bodygen.SetMorph(skActor, True, "Boobs Top Slope", kw_Morph, power / 4 as float + Self.OrigValue("Boobs Top Slope"))
			bodygen.SetMorph(skActor, True, "Hips Upper Width", kw_Morph, power / 4 as float + Self.OrigValue("Hips Upper Width"))
			bodygen.SetMorph(skActor, True, "Hips Size", kw_Morph, power / 4 as float + Self.OrigValue("Hips Size"))
			bodygen.SetMorph(skActor, True, "Legs Chubby", kw_Morph, power / 4 as float + Self.OrigValue("Legs Chubby"))
			bodygen.SetMorph(skActor, True, "Arms Chubby", kw_Morph, power / 4 as float + Self.OrigValue("Arms Chubby"))
		Else ; JaneBod
			BodyGen.SetMorph(skActor, true, "BreastsNaturalTypeSeven", kw_Morph, (power/2) + OrigValue("BreastsNaturalTypeSeven"))
			BodyGen.SetMorph(skActor, true, "BreastSize",kw_Morph, (power/2) + OrigValue("BreastSize"))
			BodyGen.SetMorph(skActor, true, "NippleShapeLargerSeven", kw_Morph, (power/2) + OrigValue("NippleShapeLargerSeven"))
			BodyGen.SetMorph(skActor, true, "WaistWidth", kw_Morph, (power/2) + OrigValue("WaistWidth"))
			BodyGen.SetMorph(skActor, true, "WaistDepthOut", kw_Morph, (power/2) + OrigValue("WaistDepthOut"))
			BodyGen.SetMorph(skActor, true, "LoveHandles", kw_Morph, (power/2) + OrigValue("LoveHandles"))
			BodyGen.SetMorph(skActor, true, "CheekWider", kw_Morph, (power/2) + OrigValue("CheekWider"))
			BodyGen.SetMorph(skActor, true, "GluteLowerFatOut", kw_Morph, power/2 + OrigValue("GluteLowerFatOut"))
			BodyGen.SetMorph(skActor, true, "GluteLowerHeightDown", kw_Morph, power/4 + OrigValue("GluteLowerHeightDown"))
			BodyGen.SetMorph(skActor, true, "HipFatter", kw_Morph, (power/2) + OrigValue("HipFatter"))
			BodyGen.SetMorph(skActor, true, "ThighSize", kw_Morph, (power/2) + OrigValue("ThighSize"))
			BodyGen.SetMorph(skActor, true, "UpperArmSize", kw_Morph, (power/2) + OrigValue("UpperArmSize"))
			BodyGen.SetMorph(skActor, true, "Pregnant", kw_Morph, (power) + OrigValue("Pregnant"))
		EndIf
		BodyGen.UpdateMorphs(skActor)
EndFunction

Function GetOriginalMorphs()
	Bool isFemale = (skActor.GetLeveledActorBase().GetSex() == 1)
	OrigMorphNames = BodyGen.GetMorphs(skActor, isFemale)
	If (OrigMorphNames.Length)
		OrigMorphValues = New Float[OrigMorphNames.Length]
		int i = 0
		While (i < OrigMorphNames.Length)
			Keyword[] MorphKeywords = BodyGen.GetKeywords(skActor, isFemale, OrigMorphNames[i])
			Keyword MyKeyword = None
			If (MorphKeywords.Length)
				MyKeyword = MorphKeywords[MorphKeywords.Length - 1] ; always get the last keyword 
			EndIf
			
			OrigMorphValues[i] = BodyGen.GetMorph(skActor, isFemale, OrigMorphNames[i], MyKeyword)
			i += 1
		EndWhile
	EndIf
EndFunction

Float Function OrigValue(String MorphName)
	If (OrigMorphNames.Length)
		int idx = OrigMorphNames.Find(MorphName)
		If (idx > -1)
			;Trace(skActor.GetLeveledActorBase().GetName() + " found morph " + MorphName + " value " + OrigMorphValues[idx])
			Return OrigMorphValues[idx]
		EndIf
	EndIf
	Return 0.0
EndFunction


Function ReduceBelly(actor akFemale)
	If (INVB_Global_BodyType.GetValue() == 0) ; CBBE Original
			BodyGen.SetMorph(skActor, true, "PregnancyBelly", kw_Morph, 0)
			BodyGen.SetMorph(skActor, true, "DoubleMelon", kw_Morph, 0)
			BodyGen.SetMorph(skActor, true, "BigButt", kw_Morph, 0)
		ElseIf (INVB_Global_BodyType.GetValue() == 1) ; CBBE Redux
            BodyGen.SetMorph(skActor, true, "Breasts", kw_Morph, 0)
            BodyGen.SetMorph(skActor, true, "BreastsNewSH", kw_Morph, 0)
            BodyGen.SetMorph(skActor, true, "BreastFantasy", kw_Morph, 0)
            BodyGen.SetMorph(skActor, true, "NippleLength", kw_Morph, 0)
            BodyGen.SetMorph(skActor, true, "NipplePerk2", kw_Morph, 0)
            BodyGen.SetMorph(skActor, true, "AppleCheeks", kw_Morph, 0)
            BodyGen.SetMorph(skActor, true, "Butt", kw_Morph, 0)
            BodyGen.SetMorph(skActor, true, "BreastWidth", kw_Morph, 0)
            BodyGen.SetMorph(skActor, true, "ChubbyLegs", kw_Morph, 0)
            BodyGen.SetMorph(skActor, true, "Giant belly (coldsteelj)", kw_Morph, 0)
            BodyGen.SetMorph(skActor, true, "PregnancyBelly", kw_Morph, 0)
            BodyGen.SetMorph(skActor, true, "Giant belly up", kw_Morph, 0)
            BodyGen.SetMorph(skActor, true, "ButtSmall", kw_Morph, 0)
            BodyGen.SetMorph(skActor, true, "BreastHeight", kw_Morph, 0)
            BodyGen.SetMorph(skActor, true, "BreastGravity2", kw_Morph, 0)
		ElseIf (INVB_Global_BodyType.GetValue() == 2) ; Fusion Girl Original
			BodyGen.SetMorph(skActor, true, "Belly Pregnant", kw_Morph, 0)
			BodyGen.SetMorph(skActor, true, "Boobs Yuge", kw_Morph, 0)
			BodyGen.SetMorph(skActor, true, "Bum Chubby", kw_Morph, 0)
			BodyGen.SetMorph(skActor, true, "Waist Size", kw_Morph, 0)
			BodyGen.SetMorph(skActor, true, "Waist Line", kw_Morph, 0)
			BodyGen.SetMorph(skActor, true, "Back Size", kw_Morph, 0)
			BodyGen.SetMorph(skActor, true, "Back Arch", kw_Morph, 0)
			BodyGen.SetMorph(skActor, true, "Boobs Top Slope", kw_Morph, 0)
			BodyGen.SetMorph(skActor, true, "Hips Upper Width", kw_Morph, 0)
			BodyGen.SetMorph(skActor, true, "Hips Size", kw_Morph, 0)
			BodyGen.SetMorph(skActor, true, "Legs Chubby", kw_Morph, 0)
			BodyGen.SetMorph(skActor, true, "Arms Chubby", kw_Morph, 0)
		ElseIf (INVB_Global_BodyType.GetValue() == 3) ; Fusion Girl Redux
			bodygen.SetMorph(skActor, True, "Belly Pregnant", kw_Morph, 0)
			bodygen.SetMorph(skActor, True, "Boobs Yuge", kw_Morph, 0)
			bodygen.SetMorph(skActor, True, "Boobs Tiny", kw_Morph, 0)
			bodygen.SetMorph(skActor, True, "Boobs Flat", kw_Morph, 0)
			bodygen.SetMorph(skActor, True, "Bum Chubby", kw_Morph, 0)
			bodygen.SetMorph(skActor, True, "Waist Size", kw_Morph, 0)
			bodygen.SetMorph(skActor, True, "Waist Line", kw_Morph, 0)
			bodygen.SetMorph(skActor, True, "Back Size", kw_Morph, 0)
			bodygen.SetMorph(skActor, True, "Back Arch", kw_Morph, 0)
			bodygen.SetMorph(skActor, True, "Boobs Top Slope", kw_Morph, 0)
			bodygen.SetMorph(skActor, True, "Hips Upper Width", kw_Morph, 0)
			bodygen.SetMorph(skActor, True, "Hips Size", kw_Morph, 0)
			bodygen.SetMorph(skActor, True, "Legs Chubby", kw_Morph, 0)
			bodygen.SetMorph(skActor, True, "Arms Chubby", kw_Morph, 0)
		Else ; JaneBod
			BodyGen.SetMorph(skActor, true, "BreastsNaturalTypeSeven", kw_Morph, 0)
			BodyGen.SetMorph(skActor, true, "BreastSize",kw_Morph, 0)
			BodyGen.SetMorph(skActor, true, "NippleShapeLargerSeven", kw_Morph, 0)
			BodyGen.SetMorph(skActor, true, "WaistWidth", kw_Morph, 0)
			BodyGen.SetMorph(skActor, true, "WaistDepthOut", kw_Morph, 0)
			BodyGen.SetMorph(skActor, true, "LoveHandles", kw_Morph, 0)
			BodyGen.SetMorph(skActor, true, "CheekWider", kw_Morph, 0)
			BodyGen.SetMorph(skActor, true, "GluteLowerFatOut", kw_Morph, 0)
			BodyGen.SetMorph(skActor, true, "GluteLowerHeightDown", kw_Morph, 0)
			BodyGen.SetMorph(skActor, true, "HipFatter", kw_Morph, 0)
			BodyGen.SetMorph(skActor, true, "ThighSize", kw_Morph, 0)
			BodyGen.SetMorph(skActor, true, "UpperArmSize", kw_Morph, 0)
			BodyGen.SetMorph(skActor, true, "Pregnant", kw_Morph, 0)
		EndIf
		
		BodyGen.SetMorph(akFemale, false, "Mpreg", kw_Morph, 0)
			BodyGen.UpdateMorphs(akFemale)
EndFunction