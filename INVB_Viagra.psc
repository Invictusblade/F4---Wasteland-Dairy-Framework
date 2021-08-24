ScriptName INVB_Viagra extends activemagiceffect

Keyword Property kw_Viagia Auto
GlobalVariable property INVB_Global_Viagra_Time Auto Const Mandatory

Event OnEffectStart(Actor akActor, Actor akCaster)
	Float original_String_01_M = (BodyGen.GetMorph(akActor, false, "Erection", none)) as float
	float bloodflow
	int int_count
	
	Utility.Wait(5)
	if (original_String_01_M == 0.0)
		int_count = 0
		while (int_count < 10)
			BodyGen.SetMorph(akActor, false, "Erection", kw_Viagia, bloodflow)
			BodyGen.UpdateMorphs(akActor)
			Utility.Wait(0.1)
			bloodflow += 0.1
			int_count += 1
		endwhile
	
		Utility.Wait(INVB_Global_Viagra_Time.GetValue())
		int_count = 0
		
		while (int_count < 10)
			BodyGen.SetMorph(akActor, false, "Erection", kw_Viagia, bloodflow)
			BodyGen.UpdateMorphs(akActor)
			Utility.Wait(0.1)
			bloodflow -= 0.1
			int_count += 1
		endwhile
		
		BodyGen.SetMorph(akActor, false, "Erection", kw_Viagia, 0)
		BodyGen.UpdateMorphs(akActor)
	endif
EndEvent

