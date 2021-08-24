Scriptname INVB_Milking_FPE extends ObjectReference

Actor target
Armor Property pArmor_Milker Auto Const Mandatory
Armor Property pArmor_Milker_infected Auto Const Mandatory
Keyword Property kw_Morph_Milk Auto
Keyword Property kw_MilkOne Auto
Keyword Property kw_MilkTwo Auto
Keyword Property kw_HC Auto
Keyword Property kw_Repeat Auto
Keyword Property kw_repair Auto
Keyword Property kw_Milk Auto
Keyword Property kw_Cum Auto
Perk Property Perk_Virus Auto
Perk Property Perk_Virus_V81 Auto
Potion Property Milk_Breast Auto Const
MiscObject Property milk_Empty1 Auto Const
MiscObject Property milk_Empty2 Auto Const
Potion Property Milk_Clean Auto Const
ActorValue Property Rads Auto Const
Potion Property Milk_Rads Auto Const
GlobalVariable property INVB_Global_BodyType Auto Const Mandatory
GlobalVariable property INVB_Global_BodyType_Enable Auto Const Mandatory
GlobalVariable property INVB_Global_Milking_MaxSize Auto Const Mandatory
GlobalVariable property INVB_Global_Milking_Amount_1 Auto Const Mandatory
GlobalVariable property INVB_Global_Milking_Amount_2 Auto Const Mandatory
GlobalVariable property INVB_Global_Milking_Virus_Mod Auto Const Mandatory
GlobalVariable property INVB_Global_Milking_Virus_Morph Auto Const Mandatory
GlobalVariable property INVB_Global_Milking_Virus_Infection Auto Const Mandatory
GlobalVariable property INVB_Global_Milking_Virus_Infection_bool Auto Const Mandatory
GlobalVariable property INVB_Global_Milking_Virus_Infection_Creation Auto Const Mandatory
GlobalVariable property INVB_Global_Rads auto Const
GlobalVariable property INVB_Global_Notes Auto Const Mandatory
GlobalVariable property INVB_Global_Notes_Repeat Auto Const Mandatory
GlobalVariable property INVB_Global_Milking_Amount_Max Auto Const Mandatory
GlobalVariable property INVB_Global_Milking_Damage Auto Const Mandatory
GlobalVariable property INVB_Global_Milking_Resources Auto Const Mandatory
GlobalVariable property INVB_Global_Milking_Time Auto Const Mandatory
GlobalVariable property INVB_Global_Milking_Time_Type Auto Const Mandatory
GlobalVariable property INVB_Global_Milking_Time_modifier Auto Const Mandatory
SPELL Property SP_MilkExtract_ActionPoints Auto
SPELL Property SP_MilkExtract_SPECIAL Auto
Keyword Property kw_infect Auto
Bool Property NotInfectable Auto
Perk Property Perk_Lactation Auto
GlobalVariable property INVB_Global_Lactation Auto Const Mandatory
Bool Property bool_Slow Auto

SPELL Property SP_MilkOverlay Auto
SPELL Property SP_MilkOverlay_Green Auto
GlobalVariable property INVB_Global_Overlay_Boolean Auto Const Mandatory

Float original_String_01
Float original_String_01_M
Float adjusted_String_01
Float adjusted_String_01_M
Float MorphPower_String_01
Float MorphPower_String_01_M

Bool Cycle_Running = False
Bool Equipped = False
Bool FirstTime_start = true
Bool FirstTime_end = true

Bool Infect_Infect = False
Bool Infect_Cure = False
int int_milkcount

GlobalVariable property INVB_Global_Gender_Roles Auto Const Mandatory
bool Property Milk Auto Const

Function Try_for_Virus(Actor akActor)
	int random_LList_infect = Utility.RandomInt(1, 100)
	Utility.Wait(5)
	
	If akActor.HasPerk(Perk_Virus) && akActor.IsEquipped(pArmor_Milker)
		if (random_LList_infect <= INVB_Global_Milking_Virus_Infection.GetValue())
			if INVB_Global_Notes.GetValue() == 1
				debug.notification(pArmor_Milker.GetName() +" has been infected with Mad Cow Virus")
			endif
			Infect_Infect = True
		endif
	elseIf akActor.HasPerk(Perk_Virus_V81) && akActor.IsEquipped(pArmor_Milker)
		if (random_LList_infect <= INVB_Global_Milking_Virus_Infection.GetValue())
			if INVB_Global_Notes.GetValue() == 1
				debug.notification(pArmor_Milker.GetName() +" has been infected with Mad Cow Virus")
			endif
			Infect_Infect = True	
		endif		
	elseIf akActor.IsEquipped(pArmor_Milker_infected) && !akActor.HasPerk(Perk_Virus)
		if (random_LList_infect <= INVB_Global_Milking_Virus_Infection.GetValue())
			akActor.AddPerk(Perk_Virus)
			if INVB_Global_Notes.GetValue() == 1
				debug.notification(pArmor_Milker.GetName() +" has been infected "+ akActor.GetName() +" with Mad Cow Virus")
			endif	
		endif
	elseIf akActor.IsEquipped(pArmor_Milker) && !akActor.HasPerk(Perk_Virus)
		if (random_LList_infect <= INVB_Global_Milking_Virus_Infection_Creation.GetValue())
			akActor.AddPerk(Perk_Virus)
			if INVB_Global_Notes.GetValue() == 1
				debug.notification(pArmor_Milker.GetName() +" has created the Mad Cow Virus")
			endif
			Infect_Infect = True
		endif		
	endif	

	if Infect_Infect == True && akActor.IsEquipped(pArmor_Milker)
		akActor.removeitem(pArmor_Milker)
		akActor.additem(pArmor_Milker_infected)
		akActor.equipitem(pArmor_Milker_infected)
	endif
EndFunction

Function Do_Milk_Resources(Actor akActor)
	if (akActor.GetItemCount(Milk_Clean) >= 1)
		If akActor.wornHasKeyword(kw_MilkOne) && akActor.HasPerk(Perk_Virus)
			akActor.removeitem(Milk_Clean, (1 * INVB_Global_Milking_Virus_Mod.getvalue() as int), true)
		ElseIf akActor.wornHasKeyword(kw_MilkTwo) && akActor.HasPerk(Perk_Virus)
			akActor.removeitem(Milk_Clean, (2 * INVB_Global_Milking_Virus_Mod.getvalue() as int), true)
		ElseIf akActor.wornHasKeyword(kw_MilkOne) && akActor.HasPerk(Perk_Virus_V81)
			akActor.removeitem(Milk_Clean, (1 * INVB_Global_Milking_Virus_Mod.getvalue() as int), true)
		ElseIf akActor.wornHasKeyword(kw_MilkTwo) && akActor.HasPerk(Perk_Virus_V81)
			akActor.removeitem(Milk_Clean, (2 * INVB_Global_Milking_Virus_Mod.getvalue() as int), true)
		ElseIf akActor.wornHasKeyword(kw_MilkOne)
			akActor.removeitem(Milk_Clean, 1, true)
		ElseIf akActor.wornHasKeyword(kw_MilkTwo)
			akActor.removeitem(Milk_Clean, 2, true)
		Endif
		Utility.Wait(5)		
	elseif (akActor.GetItemCount(milk_Empty1) >= 1)
		if INVB_Global_Notes.GetValue() == 1
			if FirstTime_start == true
				debug.notification(milk_Empty1.GetName() +" is Dirty, Cleaning Now")
			endif
			if INVB_Global_Notes_Repeat.GetValue() == 1
				FirstTime_start = false
				FirstTime_end = false
			endif
		endif	
		
	
		If akActor.wornHasKeyword(kw_MilkOne) && akActor.HasPerk(Perk_Virus)
			akActor.removeitem(milk_Empty1, (1 * INVB_Global_Milking_Virus_Mod.getvalue() as int), true)
		ElseIf akActor.wornHasKeyword(kw_MilkTwo) && akActor.HasPerk(Perk_Virus)
			akActor.removeitem(milk_Empty1, (2 * INVB_Global_Milking_Virus_Mod.getvalue() as int), true)
		ElseIf akActor.wornHasKeyword(kw_MilkOne) && akActor.HasPerk(Perk_Virus_V81)
			akActor.removeitem(milk_Empty1, (1 * INVB_Global_Milking_Virus_Mod.getvalue() as int), true)
		ElseIf akActor.wornHasKeyword(kw_MilkTwo) && akActor.HasPerk(Perk_Virus_V81)
			akActor.removeitem(milk_Empty1, (2 * INVB_Global_Milking_Virus_Mod.getvalue() as int), true)
		ElseIf akActor.wornHasKeyword(kw_MilkOne)
			akActor.removeitem(milk_Empty1,1, true)
		ElseIf akActor.wornHasKeyword(kw_MilkTwo)
			akActor.removeitem(milk_Empty1,2, true)
		Endif
		Utility.Wait(10)	
	elseif (akActor.GetItemCount(milk_Empty2) >= 1)
		if INVB_Global_Notes.GetValue() == 1
			if FirstTime_start == true
				debug.notification(milk_Empty2.GetName() +" is Dirty, Cleaning Now")	
			endif
			if INVB_Global_Notes_Repeat.GetValue() == 1
				FirstTime_start = false
			endif					
		endif
			
		If akActor.wornHasKeyword(kw_MilkOne) && akActor.HasPerk(Perk_Virus)
			akActor.removeitem(milk_Empty2, (1 * INVB_Global_Milking_Virus_Mod.getvalue() as int), true)
		ElseIf akActor.wornHasKeyword(kw_MilkTwo) && akActor.HasPerk(Perk_Virus)
			akActor.removeitem(milk_Empty2, (2 * INVB_Global_Milking_Virus_Mod.getvalue() as int), true)
		ElseIf akActor.wornHasKeyword(kw_MilkOne) && akActor.HasPerk(Perk_Virus_V81)
			akActor.removeitem(milk_Empty2, (1 * INVB_Global_Milking_Virus_Mod.getvalue() as int), true)
		ElseIf akActor.wornHasKeyword(kw_MilkTwo) && akActor.HasPerk(Perk_Virus_V81)
			akActor.removeitem(milk_Empty2, (2 * INVB_Global_Milking_Virus_Mod.getvalue() as int), true)
		ElseIf akActor.wornHasKeyword(kw_MilkOne)
			akActor.removeitem(milk_Empty2, 1, true)
		ElseIf akActor.wornHasKeyword(kw_MilkTwo)
			akActor.removeitem(milk_Empty2, 2, true)
		Endif
			
		Utility.Wait(10)
	else
		akActor.unequipitem(pArmor_Milker,true,true)
		if INVB_Global_Notes.GetValue() == 1
			Debug.MessageBox("You don't have any "+ Milk_Clean.GetName() +" or "+ milk_Empty1.GetName() +" or "+ milk_Empty2.GetName())	
			debug.notification("Unequipping "+ pArmor_Milker.GetName())
		endif
	endif

EndFunction

Function Do_Milk_Morphs(Actor akActor)
	;Debug.Trace("Do_Milk_Morphs")
if INVB_Global_BodyType_Enable.GetValue() > 1 && akActor == Game.GetPlayer()
		string M_string_01
		string string_02
		string string_03
		string string_04
		Float RadLevel = akActor.GetValue(Rads) as float
		
		Float Milked_Breasts
        Float Milked_BTBallSize
		
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
		original_String_01_M = (BodyGen.GetMorph(akActor, false, "BTBallSize", none)) as float
		adjusted_String_01 = (BodyGen.GetMorph(akActor, true, M_string_01, kw_Morph_Milk)) as float
		adjusted_String_01_M = (BodyGen.GetMorph(akActor, false, "BTBallSize", kw_Morph_Milk)) as float		
		
		MorphPower_String_01 = adjusted_String_01
		MorphPower_String_01_M = adjusted_String_01_M

		
		if MorphPower_String_01 == 0
			MorphPower_String_01 = (adjusted_String_01 + original_String_01)
		elseIf MorphPower_String_01_M == 0
			MorphPower_String_01_M = (adjusted_String_01_M + original_String_01_M)
		endif
		
		
		
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
			elseIf akActor.wornHasKeyword(kw_MilkOne) && akActor.HasPerk(Perk_Virus_V81)
				Milked_Breasts = (MorphPower_String_01 + (INVB_Global_Milking_Amount_1.GetValue() * INVB_Global_Milking_Virus_Morph.getvalue()))
			ElseIf akActor.wornHasKeyword(kw_MilkTwo) && akActor.HasPerk(Perk_Virus_V81)
				Milked_Breasts = (MorphPower_String_01 + (INVB_Global_Milking_Amount_2.GetValue() * INVB_Global_Milking_Virus_Morph.getvalue()))	
			ElseIf akActor.wornHasKeyword(kw_MilkOne)
				Milked_Breasts = (MorphPower_String_01 + INVB_Global_Milking_Amount_1.GetValue())
			ElseIf akActor.wornHasKeyword(kw_MilkTwo)
				Milked_Breasts = (MorphPower_String_01 + INVB_Global_Milking_Amount_2.GetValue())
			Endif
	

	
			If (MorphPower_String_01 >= INVB_Global_Milking_MaxSize.GetValue())
				Milked_Breasts = INVB_Global_Milking_MaxSize.GetValue()
				BodyGen.SetMorph(akActor, true, M_string_01, kw_Morph_Milk, Milked_Breasts)
				BodyGen.SetMorph(akActor, true, string_02, kw_Morph_Milk, Milked_Breasts)
				BodyGen.SetMorph(akActor, true, string_03, kw_Morph_Milk, Milked_Breasts)
				BodyGen.SetMorph(akActor, true, string_04, kw_Morph_Milk, Milked_Breasts)		
			endif
		
	
	
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
				elseIf akActor.wornHasKeyword(kw_MilkOne) && akActor.HasPerk(Perk_Virus_V81)
					Milked_BTBallSize = (adjusted_String_01_M + (INVB_Global_Milking_Amount_1.GetValue() * INVB_Global_Milking_Virus_Morph.getvalue()))
				ElseIf akActor.wornHasKeyword(kw_MilkTwo) && akActor.HasPerk(Perk_Virus_V81)
					Milked_BTBallSize = (adjusted_String_01_M + (INVB_Global_Milking_Amount_2.GetValue() * INVB_Global_Milking_Virus_Morph.getvalue()))	
				ElseIf akActor.wornHasKeyword(kw_MilkOne)
					Milked_BTBallSize = (adjusted_String_01_M + INVB_Global_Milking_Amount_1.GetValue())
				ElseIf akActor.wornHasKeyword(kw_MilkTwo)
					Milked_BTBallSize = (adjusted_String_01_M + INVB_Global_Milking_Amount_2.GetValue())
				Endif
	
				If (adjusted_String_01_M >= INVB_Global_Milking_MaxSize.GetValue())
					Milked_BTBallSize = INVB_Global_Milking_MaxSize.GetValue()
					BodyGen.SetMorph(akActor, false, "BTBallSize", kw_Morph_Milk, Milked_BTBallSize)
				Endif
	
				BodyGen.SetMorph(akActor, false, "BTBallSize", kw_Morph_Milk, Milked_BTBallSize)
					
			Endif
			BodyGen.UpdateMorphs(akActor)
	endif
endif
EndFunction

Function Get_Milk(Actor akActor)
	;Debug.Trace("Getting Milk")
	Float RadLevel = akActor.GetValue(Rads) as float
	
		If akActor.wornHasKeyword(kw_MilkOne) && (RadLevel > INVB_Global_Rads.GetValue())
			akActor.additem(Milk_Rads, 1, true)
		ElseIf akActor.wornHasKeyword(kw_MilkTwo) && (RadLevel > INVB_Global_Rads.GetValue())
			akActor.additem(Milk_Rads, 2, true)
		elseIf akActor.wornHasKeyword(kw_MilkOne) && akActor.HasPerk(Perk_Virus)
			akActor.additem(Milk_Breast, (1 * INVB_Global_Milking_Virus_Mod.getvalue() as int), true)
		ElseIf akActor.wornHasKeyword(kw_MilkTwo) && akActor.HasPerk(Perk_Virus)
			akActor.additem(Milk_Breast, (2 * INVB_Global_Milking_Virus_Mod.getvalue() as int), true)
		elseIf akActor.wornHasKeyword(kw_MilkOne) && akActor.HasPerk(Perk_Virus_V81)
			akActor.additem(Milk_Breast, (1 * INVB_Global_Milking_Virus_Mod.getvalue() as int), true)
		ElseIf akActor.wornHasKeyword(kw_MilkTwo) && akActor.HasPerk(Perk_Virus_V81)
			akActor.additem(Milk_Breast, (2 * INVB_Global_Milking_Virus_Mod.getvalue() as int), true)
		ElseIf akActor.wornHasKeyword(kw_MilkOne)
			akActor.additem(Milk_Breast, 1, true)
		ElseIf akActor.wornHasKeyword(kw_MilkTwo)
			akActor.additem(Milk_Breast, 2, true)	
		Endif
	
	if (akActor == Game.GetPlayer()) && (INVB_Global_Milking_Damage.GetValue() == 1)
		SP_MilkExtract_ActionPoints.Cast(akActor, akActor)
	elseIf (INVB_Global_Milking_Damage.GetValue() == 2)
		SP_MilkExtract_ActionPoints.Cast(akActor, akActor)
	elseIf (akActor == Game.GetPlayer()) && (INVB_Global_Milking_Damage.GetValue() == 3)
		SP_MilkExtract_SPECIAL.Cast(akActor, akActor)
	elseIf (INVB_Global_Milking_Damage.GetValue() == 4)
		SP_MilkExtract_SPECIAL.Cast(akActor, akActor)
	endif
	
	
	
	
	
	if INVB_Global_Notes.GetValue() == 1
		if INVB_Global_Notes_Repeat.GetValue() == 0
			FirstTime_end = true
		endif

		if FirstTime_end == true
			If akActor.wornHasKeyword(kw_Milk)
				Debug.notification(akActor.GetLeveledActorBase().GetName() +" Has Been Milked")
			ElseIf akActor.wornHasKeyword(kw_Cum)
				Debug.notification(akActor.GetLeveledActorBase().GetName() +" Has Donated Semen")
			Endif
		endif
		
		if INVB_Global_Notes_Repeat.GetValue() == 1
			FirstTime_end = false
		endif
	endif
EndFunction

Function Do_Milk_Repair(Actor akActor)
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

		original_String_01 = (BodyGen.GetMorph(akActor, true, M_string_01, none)) as float
		original_String_01_M = (BodyGen.GetMorph(akActor, false, "BTBallSize", none)) as float

		adjusted_String_01 = (BodyGen.GetMorph(akActor, true, M_string_01, kw_Morph_Milk)) as float
		adjusted_String_01_M = (BodyGen.GetMorph(akActor, false, "BTBallSize", kw_Morph_Milk)) as float		
		
		MorphPower_String_01 = (adjusted_String_01 + original_String_01)
		MorphPower_String_01_M = (adjusted_String_01_M + original_String_01_M)


		If (MorphPower_String_01 >= INVB_Global_Milking_MaxSize.GetValue())

			if INVB_Global_Notes.GetValue() == 1
				if FirstTime_end == true
					debug.notification(akActor.GetLeveledActorBase().GetName() +" has been Milked Out")	
				endif
			endif	
				
			if INVB_Global_Notes_Repeat.GetValue() == 1
				FirstTime_end = false
			endif
			
		If akActor.wornHasKeyword(kw_MilkOne) && (RadLevel > INVB_Global_Rads.GetValue())
			akActor.additem(Milk_Rads, 2, true)
		ElseIf akActor.wornHasKeyword(kw_MilkTwo) && (RadLevel > INVB_Global_Rads.GetValue())
			akActor.additem(Milk_Rads, 4, true)
		elseIf akActor.wornHasKeyword(kw_MilkOne) && akActor.HasPerk(Perk_Virus)
			akActor.additem(Milk_Breast, (2 * INVB_Global_Milking_Virus_Mod.getvalue() as int), true)
		ElseIf akActor.wornHasKeyword(kw_MilkTwo) && akActor.HasPerk(Perk_Virus)
			akActor.additem(Milk_Breast, (4 * INVB_Global_Milking_Virus_Mod.getvalue() as int), true)
		elseIf akActor.wornHasKeyword(kw_MilkOne) && akActor.HasPerk(Perk_Virus_V81)
			akActor.additem(Milk_Breast, (2 * INVB_Global_Milking_Virus_Mod.getvalue() as int), true)
		ElseIf akActor.wornHasKeyword(kw_MilkTwo) && akActor.HasPerk(Perk_Virus_V81)
			akActor.additem(Milk_Breast, (4 * INVB_Global_Milking_Virus_Mod.getvalue() as int), true)
		ElseIf akActor.wornHasKeyword(kw_MilkOne)
			akActor.additem(Milk_Breast, 2, true)
		ElseIf akActor.wornHasKeyword(kw_MilkTwo)
			akActor.additem(Milk_Breast, 4, true)	
		Endif	
		
		elseif (MorphPower_String_01_M >= INVB_Global_Milking_MaxSize.GetValue())
						
			if INVB_Global_Notes.GetValue() == 1
				if FirstTime_end == true
					debug.notification(akActor.GetLeveledActorBase().GetName() +" has been Milked Out")	
				endif
			endif	
				
			if INVB_Global_Notes_Repeat.GetValue() == 1
				FirstTime_end = false
			endif	
			
		If akActor.wornHasKeyword(kw_MilkOne) && (RadLevel > INVB_Global_Rads.GetValue())
			akActor.additem(Milk_Rads, 2, true)
		ElseIf akActor.wornHasKeyword(kw_MilkTwo) && (RadLevel > INVB_Global_Rads.GetValue())
			akActor.additem(Milk_Rads, 4, true)
		elseIf akActor.wornHasKeyword(kw_MilkOne) && akActor.HasPerk(Perk_Virus)
			akActor.additem(Milk_Breast, (2 * INVB_Global_Milking_Virus_Mod.getvalue() as int), true)
		ElseIf akActor.wornHasKeyword(kw_MilkTwo) && akActor.HasPerk(Perk_Virus)
			akActor.additem(Milk_Breast, (4 * INVB_Global_Milking_Virus_Mod.getvalue() as int), true)
		elseIf akActor.wornHasKeyword(kw_MilkOne) && akActor.HasPerk(Perk_Virus_V81)
			akActor.additem(Milk_Breast, (2 * INVB_Global_Milking_Virus_Mod.getvalue() as int), true)
		ElseIf akActor.wornHasKeyword(kw_MilkTwo) && akActor.HasPerk(Perk_Virus_V81)
			akActor.additem(Milk_Breast, (4 * INVB_Global_Milking_Virus_Mod.getvalue() as int), true)
		ElseIf akActor.wornHasKeyword(kw_MilkOne)
			akActor.additem(Milk_Breast, 2, true)
		ElseIf akActor.wornHasKeyword(kw_MilkTwo)
			akActor.additem(Milk_Breast, 4, true)	
		Endif			
			
		Else
			
			if INVB_Global_Notes.GetValue() == 1
				if FirstTime_end == true
					debug.notification(akActor.GetLeveledActorBase().GetName() +" has been Milked Out")	
				endif
			endif
			
			if INVB_Global_Notes_Repeat.GetValue() == 1
				FirstTime_end = false
			endif
	
		If akActor.wornHasKeyword(kw_MilkOne) && (RadLevel > INVB_Global_Rads.GetValue())
			akActor.additem(Milk_Rads, 1, true)
		ElseIf akActor.wornHasKeyword(kw_MilkTwo) && (RadLevel > INVB_Global_Rads.GetValue())
			akActor.additem(Milk_Rads, 2, true)
		elseIf akActor.wornHasKeyword(kw_MilkOne) && akActor.HasPerk(Perk_Virus)
			akActor.additem(Milk_Breast, (1 * INVB_Global_Milking_Virus_Mod.getvalue() as int), true)
		ElseIf akActor.wornHasKeyword(kw_MilkTwo) && akActor.HasPerk(Perk_Virus)
			akActor.additem(Milk_Breast, (2 * INVB_Global_Milking_Virus_Mod.getvalue() as int), true)
		elseIf akActor.wornHasKeyword(kw_MilkOne) && akActor.HasPerk(Perk_Virus_V81)
			akActor.additem(Milk_Breast, (1 * INVB_Global_Milking_Virus_Mod.getvalue() as int), true)
		ElseIf akActor.wornHasKeyword(kw_MilkTwo) && akActor.HasPerk(Perk_Virus_V81)
			akActor.additem(Milk_Breast, (2 * INVB_Global_Milking_Virus_Mod.getvalue() as int), true)
		ElseIf akActor.wornHasKeyword(kw_MilkOne)
			akActor.additem(Milk_Breast, 1, true)
		ElseIf akActor.wornHasKeyword(kw_MilkTwo)
			akActor.additem(Milk_Breast, 2, true)	
		Endif
		
		Endif
		
		
		if INVB_Global_BodyType_Enable.GetValue() > 1 && akActor == Game.GetPlayer()
			BodyGen.SetMorph(akActor, true, M_string_01, kw_Morph_Milk, 0)		
			BodyGen.SetMorph(akActor, true, string_02, kw_Morph_Milk, 0)
			BodyGen.SetMorph(akActor, true, string_03, kw_Morph_Milk, 0)
			BodyGen.SetMorph(akActor, true, string_04, kw_Morph_Milk, 0)
			BodyGen.SetMorph(akActor, false, "BTBallSize", kw_Morph_Milk, 0)
			
			BodyGen.UpdateMorphs(akActor)
		endIf	
EndFunction

Function Action(Actor akActor)
	If Game.GetPlayer().wornHasKeyword(kw_HC) && Equipped && INVB_Global_Milking_Resources.GetValue() == 0
		Do_Milk_Resources(Game.GetPlayer())
	endIf

	if NotInfectable == False
		Try_for_Virus(Game.GetPlayer())
	endIf
	
	while Equipped
		if INVB_Global_Milking_Time_Type.GetValue() == 1
			If Equipped
				StartTimerGameTime(GetUpdateTime())
			endif
		else
			If Equipped
				if bool_Slow == true
					Utility.Wait(INVB_Global_Milking_Time_modifier.getvalue() * 2)
				else
					Utility.Wait(INVB_Global_Milking_Time_modifier.getvalue())
				endIf
				
				WaitandMilk()
			endif
		endIf
	EndWhile

EndFunction

Event OnEquipped(Actor akActor)
	if akActor == Game.GetPlayer()
		int_milkcount = 0
		Equipped = True
		
		if Milk == true
			if INVB_Global_Gender_Roles.GetValue() == 0 ;Enforced
				if akActor.GetLeveledActorBase().GetSex() == 1 && akActor.HasPerk(Perk_Lactation) && INVB_Global_Lactation.GetValue() <= 1
					Action(akActor)
				elseIf akActor.GetLeveledActorBase().GetSex() == 1 && !akActor.HasPerk(Perk_Lactation) && INVB_Global_Lactation.GetValue() <= 1
					if INVB_Global_Notes.GetValue() == 1
						Debug.notification(akActor.GetLeveledActorBase().GetName() +" is not Lactating")
					endif
					akActor.unequipitem(pArmor_Milker,true,true)
				elseif akActor.GetLeveledActorBase().GetSex() == 1 && INVB_Global_Lactation.GetValue() == 2
					Action(akActor)
				elseif akActor.GetLeveledActorBase().GetSex() == 0
					if INVB_Global_Notes.GetValue() == 1
						Debug.notification(akActor.GetLeveledActorBase().GetName() +" is a Male")
					endif
					akActor.unequipitem(pArmor_Milker,true,true)
				endIf
				
			elseif INVB_Global_Gender_Roles.GetValue() == 1 ;Disabled
				if akActor.GetLeveledActorBase().GetSex() == 1 && akActor.HasPerk(Perk_Lactation) && INVB_Global_Lactation.GetValue() <= 1
					Action(akActor)
				elseIf akActor.GetLeveledActorBase().GetSex() == 1 && !akActor.HasPerk(Perk_Lactation) && INVB_Global_Lactation.GetValue() <= 1
					if INVB_Global_Notes.GetValue() == 1
						Debug.notification(akActor.GetLeveledActorBase().GetName() +" is not Lactating")
					endif
					akActor.unequipitem(pArmor_Milker,true,true)
				elseif akActor.GetLeveledActorBase().GetSex() == 1 && INVB_Global_Lactation.GetValue() == 2
					Action(akActor)
				elseif akActor.GetLeveledActorBase().GetSex() == 0
					Action(akActor)
				endIf
			endIf
		else 		
			if INVB_Global_Gender_Roles.GetValue() == 0 ;Enforced
				if akActor.GetLeveledActorBase().GetSex() == 0
					Action(akActor)
				elseif akActor.GetLeveledActorBase().GetSex() == 1
					if INVB_Global_Notes.GetValue() == 1
						Debug.notification(akActor.GetLeveledActorBase().GetName() +" is a Female")
					endif
					akActor.unequipitem(pArmor_Milker,true,true)
				endIf
				
			elseif INVB_Global_Gender_Roles.GetValue() == 1 ;Disabled
				Action(akActor)
			endIf	
		endIf
	endIf
EndEvent

Float Function GetUpdateTime()
	float time_milking = INVB_Global_Milking_Time.getvalue()
	
	if bool_Slow == true
		time_milking = time_milking * 2
	endIf
	
	If time_milking > 0
		return time_milking
	Else
		return 24.0
	EndIf
EndFunction

Function WaitandMilk()
	If Game.GetPlayer().wornHasKeyword(kw_Repair)
		Do_Milk_Repair(Game.GetPlayer())
		Game.GetPlayer().unequipitem(pArmor_Milker, true, true)
	Else
		Do_Milk_Morphs(Game.GetPlayer())
		Get_Milk(Game.GetPlayer())
	endif
	
	int_milkcount += 1
	
	if int_milkcount < INVB_Global_Milking_Amount_Max.getvalue() && Equipped
		If Game.GetPlayer().wornHasKeyword(kw_HC) && Equipped && INVB_Global_Milking_Resources.GetValue() == 0
			Do_Milk_Resources(Game.GetPlayer())
		endIf
	elseif int_milkcount >= INVB_Global_Milking_Amount_Max.getvalue() && Equipped
		Game.GetPlayer().unequipitem(pArmor_Milker, true, true)
		if INVB_Global_Notes.GetValue() == 1
			debug.notification(Game.GetPlayer().GetLeveledActorBase().GetName() +" has been Milked Out")	
		endif
	endIf
EndFunction


Event OnTimerGameTime(int aiTID)
	If Game.GetPlayer().wornHasKeyword(kw_Repair)
		Do_Milk_Repair(Game.GetPlayer())
		Game.GetPlayer().unequipitem(pArmor_Milker, true, true)
	Else
		
		Do_Milk_Morphs(Game.GetPlayer())
		Get_Milk(Game.GetPlayer())
	endif
	
	int_milkcount += 1
	
	if int_milkcount < INVB_Global_Milking_Amount_Max.getvalue() && Equipped
		If Game.GetPlayer().wornHasKeyword(kw_HC) && Equipped && INVB_Global_Milking_Resources.GetValue() == 0
			Do_Milk_Resources(Game.GetPlayer())
		endIf
		StartTimerGameTime(GetUpdateTime())
	elseif int_milkcount >= INVB_Global_Milking_Amount_Max.getvalue() && Equipped
		Game.GetPlayer().unequipitem(pArmor_Milker, true, true)
		if INVB_Global_Notes.GetValue() == 1
			debug.notification(Game.GetPlayer().GetLeveledActorBase().GetName() +" has been Milked Out")	
		endif
	endIf	
EndEvent

Event OnUnequipped(Actor akActor)
    Equipped = False
	Float RadLevel = akActor.GetValue(Rads) as float
	
	if INVB_Global_Overlay_Boolean.GetValue() == 1 && int_milkcount > 0
		If RadLevel > INVB_Global_Rads.GetValue()
			SP_MilkOverlay_Green.Cast(akActor, akActor)
		else
			SP_MilkOverlay.Cast(akActor, akActor)
		endIf	
	endIf
EndEvent