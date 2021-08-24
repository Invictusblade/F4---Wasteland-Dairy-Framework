Scriptname INVB_Milking_WorkShop_Adder extends ObjectReference

Actor target
Keyword Property kw_Morph_Milk Auto
Keyword Property kw_MilkOne Auto
Keyword Property kw_MilkTwo Auto
Perk Property Perk_Virus Auto
GlobalVariable property INVB_Global_BodyType Auto Const Mandatory
GlobalVariable property INVB_Global_BodyType_Enable Auto Const Mandatory
GlobalVariable property INVB_Global_Milking_MaxSize Auto Const Mandatory
INVB_QuestScript Property varTrigger Auto Const
GlobalVariable property INVB_Global_Gift_Amount Auto Const Mandatory
ActorValue Property Rads Auto Const
GlobalVariable property INVB_Global_Milking_Amount_1 Auto Const Mandatory
GlobalVariable property INVB_Global_Milking_Amount_2 Auto Const Mandatory
GlobalVariable property INVB_Global_Milking_Virus_Mod Auto Const Mandatory
GlobalVariable property INVB_Global_Milking_Virus_Morph Auto Const Mandatory
Potion Property Milk_Breast Auto Const
Potion Property Milk_Rads Auto Const
Race Property GhoulRace Auto Const Mandatory 
Race Property SynthGen1Race Auto Const Mandatory 
Potion Property Milk_Synth Auto Const
Race Property SynthGen2Race Auto Const Mandatory 
Race Property SynthGen2RaceValentine Auto Const Mandatory 
GlobalVariable property INVB_Global_Rads auto Const
Perk Property Perk_Lactation Auto
GlobalVariable property INVB_Global_Lactation Auto Const Mandatory
GlobalVariable property INVB_Global_Gender_Roles Auto Const Mandatory
bool Property Milk Auto Const
Bool Property bool_Slow Auto

Event OnEquipped(Actor akActor)

	target = akActor
	
	if Milk == true
		if INVB_Global_Gender_Roles.GetValue() == 0 && akActor != Game.GetPlayer() ; Enforced
			If akActor.GetLeveledActorBase().GetSex() == 1
				If INVB_Global_Lactation.GetValue() >= 1 && akActor != Game.GetPlayer()
					RegisterForCustomEvent(varTrigger, "TriggerCollection")
				elseif akActor.HasPerk(Perk_Lactation) && INVB_Global_Lactation.GetValue() >= 0
					RegisterForCustomEvent(varTrigger, "TriggerCollection")
				else
					akActor.unequipitem(self,true,true)
				endif
			elseIf akActor.GetLeveledActorBase().GetSex() == 0
				akActor.unequipitem(self,true,true)
			endif
		elseif INVB_Global_Gender_Roles.GetValue() == 1 && akActor != Game.GetPlayer() ; Disable
			RegisterForCustomEvent(varTrigger, "TriggerCollection")
		endif
	else
		if INVB_Global_Gender_Roles.GetValue() == 0 && akActor != Game.GetPlayer() ; Enforced
			if akActor.GetLeveledActorBase().GetSex() == 0 && akActor != Game.GetPlayer()
				RegisterForCustomEvent(varTrigger, "TriggerCollection")
			elseIf akActor.GetLeveledActorBase().GetSex() == 1 && akActor != Game.GetPlayer()
				akActor.unequipitem(self,true,true)
			endif
		elseif INVB_Global_Gender_Roles.GetValue() == 1 && akActor != Game.GetPlayer() ; Disable
			RegisterForCustomEvent(varTrigger, "TriggerCollection")
		endif
	endif
EndEvent

Event INVB_QuestScript.TriggerCollection(INVB_QuestScript varSender, Var[] varArgs)
	if canproduceforworkshop() == true
		Get_Milk(target)
		Do_Milk_Morphs(target)
	endif

	RegisterForCustomEvent(varTrigger, "TriggerCollection")
EndEvent

Function Get_Milk(Actor akActor)
	Float RadLevel = akActor.GetValue(Rads) as float
	int GiftAmount = INVB_Global_Gift_Amount.getvalue() as int
	
	if bool_Slow == true && GiftAmount > 1
		GiftAmount = GiftAmount / 2
	endIf	
	
	if akActor.wornHasKeyword(kw_MilkTwo)
		GiftAmount = GiftAmount * 2
	endIf		
	
	if akActor.HasPerk(Perk_Virus)
		GiftAmount = GiftAmount * (1 * INVB_Global_Milking_Virus_Mod.getvalue() as int)
	endIf	
		
		If akActor.GetLeveledActorBase().GetRace() == GhoulRace
			akActor.additem(Milk_Rads, GiftAmount, true)
		elseIf akActor.GetLeveledActorBase().GetRace() == SynthGen1Race
			akActor.additem(Milk_Synth, GiftAmount, true)
		elseIf akActor.GetLeveledActorBase().GetRace() == SynthGen2Race
			akActor.additem(Milk_Synth, GiftAmount, true)
		elseIf akActor.GetLeveledActorBase().GetRace() == SynthGen2RaceValentine
			akActor.additem(Milk_Synth, GiftAmount, true)
		elseIF (RadLevel > INVB_Global_Rads.GetValue())
			akActor.additem(Milk_Rads, GiftAmount, true)
		Else
			akActor.additem(Milk_Breast, GiftAmount, true)
		Endif
EndFunction


Function Do_Milk_Morphs(Actor akActor)
	if INVB_Global_BodyType_Enable.GetValue() == 2
		string M_string_01
		string string_02
		string string_03
		string string_04
		Float RadLevel = akActor.GetValue(Rads) as float
		
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
		
		Float MorphPower_String_01 = (adjusted_String_01 + original_String_01)
		Float MorphPower_String_02 = (adjusted_String_02 + original_String_02)
		Float MorphPower_String_03 = (adjusted_String_03 + original_String_03)
		Float MorphPower_String_04 = (adjusted_String_04 + original_String_04)
		Float MorphPower_String_01_M = (adjusted_String_01_M + original_String_01_M)
		
		Float Milked_Breasts
        Float Milked_BTBallSize
		
	If (akActor.GetLeveledActorBase().GetSex() == 1)
			
		If (MorphPower_String_01 >= INVB_Global_Milking_MaxSize.GetValue())
			Milked_Breasts = INVB_Global_Milking_MaxSize.GetValue()
			BodyGen.SetMorph(akActor, true, M_string_01, kw_Morph_Milk, Milked_Breasts)
			BodyGen.SetMorph(akActor, true, string_02, kw_Morph_Milk, Milked_Breasts)
			BodyGen.SetMorph(akActor, true, string_03, kw_Morph_Milk, Milked_Breasts)
			BodyGen.SetMorph(akActor, true, string_04, kw_Morph_Milk, Milked_Breasts)
					
		else
			If akActor.wornHasKeyword(kw_MilkOne) && akActor.HasPerk(Perk_Virus)
				Milked_Breasts = (MorphPower_String_01 + (INVB_Global_Milking_Amount_1.GetValue() * INVB_Global_Milking_Virus_Morph.getvalue()))
			ElseIf akActor.wornHasKeyword(kw_MilkTwo) && akActor.HasPerk(Perk_Virus)
				Milked_Breasts = (MorphPower_String_01 + (INVB_Global_Milking_Amount_2.GetValue() * INVB_Global_Milking_Virus_Morph.getvalue()))
			ElseIf akActor.wornHasKeyword(kw_MilkOne)
				Milked_Breasts = (MorphPower_String_01 + INVB_Global_Milking_Amount_1.GetValue())
			ElseIf akActor.wornHasKeyword(kw_MilkTwo)
				Milked_Breasts = (MorphPower_String_01 + INVB_Global_Milking_Amount_2.GetValue())
			Endif
			
			BodyGen.SetMorph(akActor, true, M_string_01, kw_Morph_Milk, Milked_Breasts)		
			BodyGen.SetMorph(akActor, true, string_02, kw_Morph_Milk, Milked_Breasts)
			BodyGen.SetMorph(akActor, true, string_03, kw_Morph_Milk, Milked_Breasts)
			BodyGen.SetMorph(akActor, true, string_04, kw_Morph_Milk, Milked_Breasts)
				
		Endif
		BodyGen.UpdateMorphs(akActor)		
				
	ElseIf (akActor.GetLeveledActorBase().GetSex() == 0)
		
			If (adjusted_String_01_M >= INVB_Global_Milking_MaxSize.GetValue())
				Milked_BTBallSize = INVB_Global_Milking_MaxSize.GetValue()
				BodyGen.SetMorph(akActor, false, "BTBallSize", kw_Morph_Milk, Milked_BTBallSize)

			else
				
				If akActor.wornHasKeyword(kw_MilkOne) && akActor.HasPerk(Perk_Virus)
					Milked_BTBallSize = (adjusted_String_01_M + (INVB_Global_Milking_Amount_1.GetValue() * INVB_Global_Milking_Virus_Morph.getvalue()))
				ElseIf akActor.wornHasKeyword(kw_MilkTwo) && akActor.HasPerk(Perk_Virus)
					Milked_BTBallSize = (adjusted_String_01_M + (INVB_Global_Milking_Amount_2.GetValue() * INVB_Global_Milking_Virus_Morph.getvalue()))
				ElseIf akActor.wornHasKeyword(kw_MilkOne)
					Milked_BTBallSize = (adjusted_String_01_M + INVB_Global_Milking_Amount_1.GetValue())
				ElseIf akActor.wornHasKeyword(kw_MilkTwo)
					Milked_BTBallSize = (adjusted_String_01_M + INVB_Global_Milking_Amount_2.GetValue())
				Endif
		
				BodyGen.SetMorph(akActor, false, "BTBallSize", kw_Morph_Milk, Milked_BTBallSize)
					
			Endif
		BodyGen.UpdateMorphs(akActor)
	endif
endif
EndFunction