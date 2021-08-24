ScriptName INVB_Morphs_Milk_FPE extends activemagiceffect

Keyword Property kw_Morph_Milk Auto
GlobalVariable property INVB_Global_BodyType Auto Const Mandatory
GlobalVariable property INVB_Global_BodyType_Enable Auto Const Mandatory
Keyword Property kw_MorphReset Auto
Keyword Property kw_MorphForward Auto
Keyword Property kw_MorphBackward Auto
MagicEffect Property ME_Morph Auto
GlobalVariable property INVB_Global_MilkMorph_Max Auto Const Mandatory
GlobalVariable property INVB_Global_MilkMorph_amount Auto Const Mandatory
bool Property Powerx10 Auto

Event OnEffectStart(Actor akActor, Actor akCaster)
	
	if INVB_Global_BodyType_Enable.GetValue() > 1 && akActor == Game.GetPlayer()
		Do_Milk_Morphs(akActor)
	elseif INVB_Global_BodyType_Enable.GetValue() == 2
		Do_Milk_Morphs(akActor)
	endif
	
EndEvent

Function Do_Milk_Morphs(Actor akActor)

		string M_string_01
		string string_02
		string string_03
		string string_04
		int int_count
		
		If (INVB_Global_BodyType.GetValue() == 0) ; CBBE
			M_string_01 = "DoubleMelon"
			string_02 = ""
			string_03 = ""
			string_04 = ""
		ElseIf (INVB_Global_BodyType.GetValue() == 1) ; CBBE Redux
			M_string_01 = "Breasts"
			string_02 = "BreastsNewSH"
			string_03 = "NippleLength"
			string_04 = "NipplePerk2"
		ElseIf (INVB_Global_BodyType.GetValue() == 2) ; Fusion Girl
			M_string_01 = "Boobs Yuge"
			string_02 = "Nipples Areola"
			string_03 = "Nipples Distance"
			string_04 = ""
		ElseIf (INVB_Global_BodyType.GetValue() == 3) ; Fusion Girl Redux
			M_string_01 = "Boobs Yuge"
			string_02 = "Nipples Areola"
			string_03 = "Nipples Distance"
			string_04 = ""
		ElseIf (INVB_Global_BodyType.GetValue() == 4) ; AtomicBeauty
			M_string_01 = "Breasts_Huge"
			string_02 = ""
			string_03 = ""
			string_04 = ""
		Else ; JaneBod
			M_string_01 = "BreastsNaturalTypeSeven"
			string_02 = "BreastSize"
			string_03 = "NippleShapeLargerSeven"
			string_04 = ""	
		Endif

	
		Float original_String_01 = (BodyGen.GetMorph(akActor, true, M_string_01, none)) as float
		Float original_String_02 = (BodyGen.GetMorph(akActor, true, string_02, none)) as float
		Float original_String_03 = (BodyGen.GetMorph(akActor, true, string_03, none)) as float
		Float original_String_04 = (BodyGen.GetMorph(akActor, true, string_04, none)) as float	
		Float original_String_01_M = (BodyGen.GetMorph(akActor, false, "BTBallSize", none)) as float
		
		Float adjusted_String_01 = (BodyGen.GetMorph(akActor, true, M_string_01, kw_Morph_Milk)) as float
		Float adjusted_String_02 = (BodyGen.GetMorph(akActor, true, string_02, kw_Morph_Milk)) as float
		Float adjusted_String_03 = (BodyGen.GetMorph(akActor, true, string_03, kw_Morph_Milk)) as float
		Float adjusted_String_04 = (BodyGen.GetMorph(akActor, true, string_04, kw_Morph_Milk)) as float	
		Float adjusted_String_01_M = (BodyGen.GetMorph(akActor, false, "BTBallSize", kw_Morph_Milk)) as float	
	
	

	if ME_Morph.HasKeyword(kw_MorphForward)	
		
		if (adjusted_String_01 == 0.0)
			adjusted_String_01 = original_String_01
			adjusted_String_02 = original_String_02
			adjusted_String_03 = original_String_03
			adjusted_String_04 = original_String_04
			adjusted_String_01_M = original_String_01_M
		endif
		
		if Powerx10 == true
			adjusted_String_01 = ((INVB_Global_MilkMorph_amount.GetValue() * 10) + adjusted_String_01)
			adjusted_String_02 = ((INVB_Global_MilkMorph_amount.GetValue() * 10) + adjusted_String_02)
			adjusted_String_03 = ((INVB_Global_MilkMorph_amount.GetValue() * 10) + adjusted_String_03)
			adjusted_String_04 = ((INVB_Global_MilkMorph_amount.GetValue() * 10) + adjusted_String_04)
			adjusted_String_01_M = ((INVB_Global_MilkMorph_amount.GetValue() * 10) + adjusted_String_01_M)
		elseif Powerx10 == false
			adjusted_String_01 = (INVB_Global_MilkMorph_amount.GetValue() + adjusted_String_01)
			adjusted_String_02 = (INVB_Global_MilkMorph_amount.GetValue() + adjusted_String_02)
			adjusted_String_03 = (INVB_Global_MilkMorph_amount.GetValue() + adjusted_String_03)
			adjusted_String_04 = (INVB_Global_MilkMorph_amount.GetValue() + adjusted_String_04)
			adjusted_String_01_M = (INVB_Global_MilkMorph_amount.GetValue() + adjusted_String_01_M)	
		endif
		
		
		if (adjusted_String_01 >= INVB_Global_MilkMorph_Max.GetValue())
			adjusted_String_01 = INVB_Global_MilkMorph_Max.GetValue()
			adjusted_String_02 = INVB_Global_MilkMorph_Max.GetValue()
			adjusted_String_03 = INVB_Global_MilkMorph_Max.GetValue()
			adjusted_String_04 = INVB_Global_MilkMorph_Max.GetValue()
			adjusted_String_01_M = INVB_Global_MilkMorph_Max.GetValue()
		endif
		
		BodyGen.SetMorph(akActor, true, M_string_01, kw_Morph_Milk, adjusted_String_01)
		BodyGen.SetMorph(akActor, true, string_02, kw_Morph_Milk, adjusted_String_02)
		BodyGen.SetMorph(akActor, true, string_03, kw_Morph_Milk, adjusted_String_03)
		BodyGen.SetMorph(akActor, true, string_04, kw_Morph_Milk, adjusted_String_04)
		BodyGen.SetMorph(akActor, false, "BTBallSize", kw_Morph_Milk, adjusted_String_01_M)
		
		BodyGen.UpdateMorphs(akActor)
		
	elseif ME_Morph.HasKeyword(kw_MorphBackward)
		int_count = 0
		
		if (adjusted_String_01 == 0.0)
			adjusted_String_01 = original_String_01
			adjusted_String_02 = original_String_02
			adjusted_String_03 = original_String_03
			adjusted_String_04 = original_String_04
			adjusted_String_01_M = original_String_01_M
		endif
		
		while (int_count < 4)
		

		if Powerx10 == true
			adjusted_String_01 = (adjusted_String_01 - (INVB_Global_MilkMorph_amount.GetValue() * 10))
			adjusted_String_02 = (adjusted_String_02 - (INVB_Global_MilkMorph_amount.GetValue() * 10))
			adjusted_String_03 = (adjusted_String_03 - (INVB_Global_MilkMorph_amount.GetValue() * 10))
			adjusted_String_04 = (adjusted_String_04 - (INVB_Global_MilkMorph_amount.GetValue() * 10))
			adjusted_String_01_M = (adjusted_String_01_M - (INVB_Global_MilkMorph_amount.GetValue() * 10))
		elseif Powerx10 == false
			adjusted_String_01 = (adjusted_String_01 - INVB_Global_MilkMorph_amount.GetValue())
			adjusted_String_02 = (adjusted_String_02 - INVB_Global_MilkMorph_amount.GetValue())
			adjusted_String_03 = (adjusted_String_03 - INVB_Global_MilkMorph_amount.GetValue())
			adjusted_String_04 = (adjusted_String_04 - INVB_Global_MilkMorph_amount.GetValue())
			adjusted_String_01_M = (adjusted_String_01_M - INVB_Global_MilkMorph_amount.GetValue())	
		endif
		
		if (adjusted_String_01 <= 0.0)
			adjusted_String_01 = 0.0
			adjusted_String_02 = 0.0
			adjusted_String_03 = 0.0
			adjusted_String_04 = 0.0
			adjusted_String_01_M = 0.0
		endif
	
			BodyGen.SetMorph(akActor, true, M_string_01, kw_Morph_Milk, adjusted_String_01)
			BodyGen.SetMorph(akActor, true, string_02, kw_Morph_Milk, adjusted_String_02)
			BodyGen.SetMorph(akActor, true, string_03, kw_Morph_Milk, adjusted_String_03)
			BodyGen.SetMorph(akActor, true, string_04, kw_Morph_Milk, adjusted_String_04)
			BodyGen.SetMorph(akActor, false, "BTBallSize", kw_Morph_Milk, adjusted_String_01_M)
		
			BodyGen.UpdateMorphs(akActor)
			Utility.Wait(0.25)
			int_count += 1
		endwhile
	elseif ME_Morph.HasKeyword(kw_MorphReset)
		adjusted_String_01 = 0.0
		adjusted_String_02 = 0.0
		adjusted_String_03 = 0.0
		adjusted_String_04 = 0.0
		adjusted_String_01_M = 0.0
	
	
		BodyGen.SetMorph(akActor, true, M_string_01, kw_Morph_Milk, adjusted_String_01)
		BodyGen.SetMorph(akActor, true, string_02, kw_Morph_Milk, adjusted_String_02)
		BodyGen.SetMorph(akActor, true, string_03, kw_Morph_Milk, adjusted_String_03)
		BodyGen.SetMorph(akActor, true, string_04, kw_Morph_Milk, adjusted_String_04)
		BodyGen.SetMorph(akActor, false, "BTBallSize", kw_Morph_Milk, adjusted_String_01_M)
		
		BodyGen.UpdateMorphs(akActor)
		Utility.Wait(0.25)
			
	endif
EndFunction
