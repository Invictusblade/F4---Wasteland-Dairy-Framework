Scriptname INVB_SkillMagazineScript extends Quest

Actor Property PlayerRef Auto Const
Keyword Property kw_Morph_Milk Auto
Keyword Property kw_Morph Auto
Perk Property WLD_perk_SelfAware Auto
Perk Property WLD_perk_Breast_Size_S Auto
Perk Property WLD_perk_Breast_Size_M Auto
Perk Property WLD_perk_Breast_Size_L Auto
GlobalVariable property INVB_Global_BodyType Auto Const Mandatory
GlobalVariable property INVB_Global_Notes Auto Const Mandatory
GlobalVariable property INVB_Global_MilkMorph_Max Auto Const Mandatory
GlobalVariable property INVB_Global_MilkMorph_amount Auto Const Mandatory




Actor Function GetActorUnderCrosshairs()
	Actor ScannedActor = LL_FourPlay.LastCrossHairActor()
	
	If ScannedActor == NONE || ScannedActor.GetDistance(PlayerRef) > 256.000
		return None
	EndIf
	Return ScannedActor
EndFunction

Function GiveNPCUnderCrosshairs_Increase()
	Actor akActor = GetActorUnderCrosshairs()
	
	If (akActor)
		Do_Milk_Morphs(akActor, True)
	Else
		Debug.MessageBox("There is no Breasts Here to Increase.")
	EndIf
	
EndFunction


Function GiveMyselfStuff_Increase()
	Actor akActor = PlayerRef
	
	If (akActor)
		Do_Milk_Morphs(akActor, True)
	Else
		Debug.MessageBox("There is no Breasts Here to Increase.")
	EndIf
EndFunction


Function GiveNPCUnderCrosshairs_Decrease()
	Actor akActor = GetActorUnderCrosshairs()
	
	If (akActor)
		Do_Milk_Morphs(akActor, False)
	Else
		Debug.MessageBox("There is no Breasts Here to Decrease.")
	EndIf
	
EndFunction


Function GiveMyselfStuff_Decrease()
	Actor akActor = PlayerRef
	
	If (akActor)
		Do_Milk_Morphs(akActor, False)
	Else
		Debug.MessageBox("There is no Breasts Here to Decrease.")
	EndIf
EndFunction


Function GiveNPCUnderCrosshairs_Reset()
	Actor akActor = GetActorUnderCrosshairs()
	
	If (akActor)
		Do_Milk_Morphs_Reset(akActor)
	Else
		Debug.MessageBox("There is no Breasts Here to Reset.")
	EndIf
	
EndFunction


Function GiveMyselfStuff_Reset()
	Actor akActor = PlayerRef
	
	If (akActor)
		Do_Milk_Morphs_Reset(akActor)
	Else
		Debug.MessageBox("There is no Breasts Here to Reset.")
	EndIf
EndFunction

Function Do_Milk_Morphs(Actor akActor, Bool Increase)
		string M_string_01
		string string_02
		string string_03
		string string_04
		int int_count
	if PlayerRef.HasPerk(WLD_perk_SelfAware)	
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
	
		if Increase == true	
		
		if (adjusted_String_01 == 0.0)
			adjusted_String_01 = original_String_01
			adjusted_String_02 = original_String_02
			adjusted_String_03 = original_String_03
			adjusted_String_04 = original_String_04
			adjusted_String_01_M = original_String_01_M
		endif
		
		adjusted_String_01 = (INVB_Global_MilkMorph_amount.GetValue() + adjusted_String_01)
		adjusted_String_02 = (INVB_Global_MilkMorph_amount.GetValue() + adjusted_String_02)
		adjusted_String_03 = (INVB_Global_MilkMorph_amount.GetValue() + adjusted_String_03)
		adjusted_String_04 = (INVB_Global_MilkMorph_amount.GetValue() + adjusted_String_04)
		adjusted_String_01_M = (INVB_Global_MilkMorph_amount.GetValue() + adjusted_String_01_M)	
			
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
		
	elseif Increase == false	
		int_count = 0
		
		if (adjusted_String_01 == 0.0)
			adjusted_String_01 = original_String_01
			adjusted_String_02 = original_String_02
			adjusted_String_03 = original_String_03
			adjusted_String_04 = original_String_04
			adjusted_String_01_M = original_String_01_M
		endif
		
		while (int_count < 4)
		

		adjusted_String_01 = (adjusted_String_01 - INVB_Global_MilkMorph_amount.GetValue())
		adjusted_String_02 = (adjusted_String_02 - INVB_Global_MilkMorph_amount.GetValue())
		adjusted_String_03 = (adjusted_String_03 - INVB_Global_MilkMorph_amount.GetValue())
		adjusted_String_04 = (adjusted_String_04 - INVB_Global_MilkMorph_amount.GetValue())
		adjusted_String_01_M = (adjusted_String_01_M - INVB_Global_MilkMorph_amount.GetValue())	

		
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
	endif
	else
		Debug.MessageBox("You Need the Breast Control Perk to Use this")
	endif
EndFunction


Function Do_Milk_Morphs_Reset(Actor akActor)
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
	
		BodyGen.SetMorph(akActor, true, M_string_01, kw_Morph_Milk, 0)
		BodyGen.SetMorph(akActor, true, string_02, kw_Morph_Milk, 0)
		BodyGen.SetMorph(akActor, true, string_03, kw_Morph_Milk, 0)
		BodyGen.SetMorph(akActor, true, string_04, kw_Morph_Milk, 0)
		BodyGen.SetMorph(akActor, false, "BTBallSize", kw_Morph_Milk, 0)
		
		BodyGen.UpdateMorphs(akActor)

EndFunction




Function MeasureMyself()
	Float original_String_01
	Float adjusted_String_01
	Float adjusted_String_02
	Float MorphPower_String_01
	
	Actor akActor = PlayerRef
	
	if akActor.HasPerk(WLD_perk_SelfAware)
		if akActor.HasPerk(WLD_perk_Breast_Size_S)
			akActor.RemovePerk(WLD_perk_Breast_Size_S)
		elseif akActor.HasPerk(WLD_perk_Breast_Size_M)
			akActor.RemovePerk(WLD_perk_Breast_Size_M)
		elseif akActor.HasPerk(WLD_perk_Breast_Size_L)
			akActor.RemovePerk(WLD_perk_Breast_Size_L)
		endif
	
		string M_string_01
		string string_02
		string string_03
		string string_04
		
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
	
		original_String_01 = (BodyGen.GetMorph(akActor, true, M_string_01, none)) as float
		adjusted_String_01 = (BodyGen.GetMorph(akActor, true, M_string_01, kw_Morph)) as float
		adjusted_String_02 = (BodyGen.GetMorph(akActor, true, M_string_01, kw_Morph_Milk)) as float
		MorphPower_String_01 = (adjusted_String_01 + original_String_01 + adjusted_String_02)
		
		if MorphPower_String_01 <= 0.5
			akActor.AddPerk(WLD_perk_Breast_Size_S)
		elseif MorphPower_String_01 <= 1.0
			akActor.AddPerk(WLD_perk_Breast_Size_M)
		elseif MorphPower_String_01 > 1.0
			akActor.AddPerk(WLD_perk_Breast_Size_L)
		endif
	else
		Debug.MessageBox("You Need the Breast Control Perk to Use this")
	endif
EndFunction




