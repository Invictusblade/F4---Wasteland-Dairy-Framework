ScriptName INVB_Cuminject_Preg_FPE extends ObjectReference

Armor Property pArmor_Projector Auto Const Mandatory
LeveledItem Property ll_both Auto Const Mandatory
LeveledItem Property ll_Babies Auto Const Mandatory
LeveledItem Property ll_creatures Auto Const Mandatory
LeveledItem Property ll_dead Auto Const Mandatory
MiscObject Property dead_baby Auto Const
Potion Property INVB_Biomass_Sack Auto Const
Keyword Property kw_Morph Auto
Keyword Property kw_noPreg Auto
Keyword Property kw_noPreg_Other Auto
GlobalVariable property INVB_Global_Power Auto Const Mandatory
GlobalVariable property INVB_Global_BodyType_CBBE Auto Const Mandatory
GlobalVariable property INVB_Global_BodyType_FG Auto Const Mandatory
GlobalVariable property INVB_Global_BabyChance Auto Const Mandatory
GlobalVariable property INVB_Global_ImpregnationChance Auto Const Mandatory
GlobalVariable property INVB_Global_AllowedMales Auto Const Mandatory
GlobalVariable property INVB_Global_Impregnation_Choice Auto Const Mandatory
GlobalVariable property INVB_Global_Impregnation_AllowedDead Auto Const Mandatory
Perk Property Perk_Babies Auto
Perk Property Perk_Eggs Auto
Actor Ourself

Float Property OriginalThin Auto 
Float Property OriginalThicc Auto 
Float Property OriginalMuscular Auto 

String[] Property OrigMorphNames Auto
Float[] Property OrigMorphValues Auto

Function Baby_collector()

	if Game.GetPlayer().HasPerk(Perk_Babies) && Game.GetPlayer().HasPerk(Perk_Eggs) && INVB_Global_Impregnation_Choice.GetValue() == 0
		Get_Baby(ll_both)
	elseif Game.GetPlayer().HasPerk(Perk_Babies) && INVB_Global_Impregnation_Choice.GetValue() == 1
		Get_Baby(ll_Babies)
	elseif Game.GetPlayer().HasPerk(Perk_Eggs) && INVB_Global_Impregnation_Choice.GetValue() == 2
		Get_Baby(ll_creatures)
	elseif INVB_Global_Impregnation_Choice.GetValue() == 3 && INVB_Global_Impregnation_AllowedDead.GetValue() == 1
		int random_deadseed = Utility.RandomInt(1, 2)
		if (random_deadseed == 1)
			Ourself.additem(INVB_Biomass_Sack)
		elseif (random_deadseed == 2)
			Ourself.additem(dead_baby)
		endif	
	elseif INVB_Global_Impregnation_AllowedDead.GetValue() == 1
		if INVB_Global_Impregnation_Choice.GetValue() == 0
			int random_deadseed = Utility.RandomInt(1, 2)
			if (random_deadseed == 1)
				Ourself.additem(INVB_Biomass_Sack)
			elseif (random_deadseed == 2)
				Ourself.additem(dead_baby)
			endif	
		elseif INVB_Global_Impregnation_Choice.GetValue() == 1
			Ourself.additem(dead_baby)
		elseif INVB_Global_Impregnation_Choice.GetValue() == 2
			Ourself.additem(INVB_Biomass_Sack)
		endif
	endif
EndFunction

Function Get_Baby(LeveledItem ll_Choice)
	int random_seed = Utility.RandomInt(1, 100)
	
	if (random_seed <= INVB_Global_BabyChance.GetValue())
		Ourself.additem(ll_Choice)
	elseif INVB_Global_Impregnation_AllowedDead.GetValue() == 1
		int random_deadseed = Utility.RandomInt(1, 2)
		if (random_deadseed == 1)
			Ourself.additem(INVB_Biomass_Sack)
		elseif (random_deadseed == 2)
			Ourself.additem(dead_baby)
		endif
	endif
EndFunction

Function Body_Morph()
	float power = (Utility.RandomFloat(5, 9) * INVB_Global_Power.getValue() * 0.015 * Utility.RandomFloat(0.8, 1.2))
	
	GetOriginalMorphs()
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
		EndIf
		BodyGen.UpdateMorphs(Ourself)
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

Event OnEquipped(Actor akActor)
	Ourself = akActor
	int random_LList = Utility.RandomInt(1, 100)

	If Ourself.HasKeyword(kw_noPreg) || Ourself.HasKeyword(kw_noPreg_Other)
		Ourself.unequipitem(pArmor_Projector)
		Ourself.removeitem(pArmor_Projector)
	else
	
		if (random_LList <= INVB_Global_ImpregnationChance.GetValue())
	
			If Ourself.GetLeveledActorBase().GetSex() == 0 && INVB_Global_AllowedMales.GetValue() == 0
				Ourself.unequipitem(pArmor_Projector)
				Ourself.removeitem(pArmor_Projector)
			elseIf Ourself.GetLeveledActorBase().GetSex() == 0 && INVB_Global_AllowedMales.GetValue() == 1
				Baby_collector()
			else
				Body_Morph()
				Baby_collector()
				Ourself.AddKeyword(kw_noPreg)
			EndIf
		else	
			Ourself.unequipitem(pArmor_Projector)
			Ourself.removeitem(pArmor_Projector)
		endif
	endif
EndEvent