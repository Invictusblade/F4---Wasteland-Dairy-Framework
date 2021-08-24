ScriptName INVB_Cuminject_NoPreg_FPE extends ObjectReference

Armor Property pArmor_Projector Auto Const Mandatory
Armor Property pArmor_ThisProjector Auto Const Mandatory
Keyword Property kw_Morph Auto
Keyword Property kw_noPreg Auto
Armor Property pArmor_BadBaby Auto Const Mandatory
LeveledItem Property pArmor_baby Auto Const
GlobalVariable property INVB_Global_BodyType Auto Const Mandatory

Event OnEquipped(Actor akActor)
	If (INVB_Global_BodyType.GetValue() == 0) ; CBBE Original
			BodyGen.SetMorph(akActor, true, "PregnancyBelly", kw_Morph, 0)
			BodyGen.SetMorph(akActor, true, "DoubleMelon", kw_Morph, 0)
			BodyGen.SetMorph(akActor, true, "BigButt", kw_Morph, 0)
		ElseIf (INVB_Global_BodyType.GetValue() == 1) ; CBBE Redux
            BodyGen.SetMorph(akActor, true, "Breasts", kw_Morph, 0)
            BodyGen.SetMorph(akActor, true, "BreastsNewSH", kw_Morph, 0)
            BodyGen.SetMorph(akActor, true, "BreastFantasy", kw_Morph, 0)
            BodyGen.SetMorph(akActor, true, "NippleLength", kw_Morph, 0)
            BodyGen.SetMorph(akActor, true, "NipplePerk2", kw_Morph, 0)
            BodyGen.SetMorph(akActor, true, "AppleCheeks", kw_Morph, 0)
            BodyGen.SetMorph(akActor, true, "Butt", kw_Morph, 0)
            BodyGen.SetMorph(akActor, true, "BreastWidth", kw_Morph, 0)
            BodyGen.SetMorph(akActor, true, "ChubbyLegs", kw_Morph, 0)
            BodyGen.SetMorph(akActor, true, "Giant belly (coldsteelj)", kw_Morph, 0)
            BodyGen.SetMorph(akActor, true, "PregnancyBelly", kw_Morph, 0)
            BodyGen.SetMorph(akActor, true, "Giant belly up", kw_Morph, 0)
            BodyGen.SetMorph(akActor, true, "ButtSmall", kw_Morph, 0)
            BodyGen.SetMorph(akActor, true, "BreastHeight", kw_Morph, 0)
            BodyGen.SetMorph(akActor, true, "BreastGravity2", kw_Morph, 0)
		ElseIf (INVB_Global_BodyType.GetValue() == 2) ; Fusion Girl Original
			BodyGen.SetMorph(akActor, true, "Belly Pregnant", kw_Morph, 0)
			BodyGen.SetMorph(akActor, true, "Boobs Yuge", kw_Morph, 0)
			BodyGen.SetMorph(akActor, true, "Bum Chubby", kw_Morph, 0)
			BodyGen.SetMorph(akActor, true, "Waist Size", kw_Morph, 0)
			BodyGen.SetMorph(akActor, true, "Waist Line", kw_Morph, 0)
			BodyGen.SetMorph(akActor, true, "Back Size", kw_Morph, 0)
			BodyGen.SetMorph(akActor, true, "Back Arch", kw_Morph, 0)
			BodyGen.SetMorph(akActor, true, "Boobs Top Slope", kw_Morph, 0)
			BodyGen.SetMorph(akActor, true, "Hips Upper Width", kw_Morph, 0)
			BodyGen.SetMorph(akActor, true, "Hips Size", kw_Morph, 0)
			BodyGen.SetMorph(akActor, true, "Legs Chubby", kw_Morph, 0)
			BodyGen.SetMorph(akActor, true, "Arms Chubby", kw_Morph, 0)
		ElseIf (INVB_Global_BodyType.GetValue() == 3) ; Fusion Girl Redux
			bodygen.SetMorph(akActor, True, "Belly Pregnant", kw_Morph, 0)
			bodygen.SetMorph(akActor, True, "Boobs Yuge", kw_Morph, 0)
			bodygen.SetMorph(akActor, True, "Boobs Tiny", kw_Morph, 0)
			bodygen.SetMorph(akActor, True, "Boobs Flat", kw_Morph, 0)
			bodygen.SetMorph(akActor, True, "Bum Chubby", kw_Morph, 0)
			bodygen.SetMorph(akActor, True, "Waist Size", kw_Morph, 0)
			bodygen.SetMorph(akActor, True, "Waist Line", kw_Morph, 0)
			bodygen.SetMorph(akActor, True, "Back Size", kw_Morph, 0)
			bodygen.SetMorph(akActor, True, "Back Arch", kw_Morph, 0)
			bodygen.SetMorph(akActor, True, "Boobs Top Slope", kw_Morph, 0)
			bodygen.SetMorph(akActor, True, "Hips Upper Width", kw_Morph, 0)
			bodygen.SetMorph(akActor, True, "Hips Size", kw_Morph, 0)
			bodygen.SetMorph(akActor, True, "Legs Chubby", kw_Morph, 0)
			bodygen.SetMorph(akActor, True, "Arms Chubby", kw_Morph, 0)
		Else ; JaneBod
			BodyGen.SetMorph(akActor, true, "BreastsNaturalTypeSeven", kw_Morph, 0)
			BodyGen.SetMorph(akActor, true, "BreastSize",kw_Morph, 0)
			BodyGen.SetMorph(akActor, true, "NippleShapeLargerSeven", kw_Morph, 0)
			BodyGen.SetMorph(akActor, true, "WaistWidth", kw_Morph, 0)
			BodyGen.SetMorph(akActor, true, "WaistDepthOut", kw_Morph, 0)
			BodyGen.SetMorph(akActor, true, "LoveHandles", kw_Morph, 0)
			BodyGen.SetMorph(akActor, true, "CheekWider", kw_Morph, 0)
			BodyGen.SetMorph(akActor, true, "GluteLowerFatOut", kw_Morph, 0)
			BodyGen.SetMorph(akActor, true, "GluteLowerHeightDown", kw_Morph, 0)
			BodyGen.SetMorph(akActor, true, "HipFatter", kw_Morph, 0)
			BodyGen.SetMorph(akActor, true, "ThighSize", kw_Morph, 0)
			BodyGen.SetMorph(akActor, true, "UpperArmSize", kw_Morph, 0)
			BodyGen.SetMorph(akActor, true, "Pregnant", kw_Morph, 0)
		EndIf
		BodyGen.SetMorph(akActor, false, "Mpreg", kw_Morph, 0)
		BodyGen.UpdateMorphs(akActor)
		akActor.RemoveKeyword(kw_noPreg)
		

		akActor.removeitem(pArmor_BadBaby)
		akActor.additem(pArmor_baby)
		akActor.unequipitem(pArmor_Projector)
		akActor.removeitem(pArmor_Projector)
		akActor.unequipitem(pArmor_ThisProjector)
		akActor.removeitem(pArmor_ThisProjector)
		
	
	
EndEvent
