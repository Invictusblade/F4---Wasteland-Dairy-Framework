Scriptname INVB_Milking_Creatures_AIO_s_Preg extends activemagiceffect

Actor target
int Property int_count Auto
ActorBase[] Property Creature_Donor Auto Const Mandatory 
ActorBase[] Property Creature_Donor_NPC Auto Const Mandatory 
Form[] Property Creature_Import Auto Const
Form[] Property Creature_Import_NPC Auto Const
GlobalVariable property INVB_Global_Notes Auto Const Mandatory
string Property String_Worked auto
string Property String_Interrupted auto
string Property String_Failed auto
GlobalVariable property INVB_Global_AllowedMales Auto Const Mandatory

int i
int u

Event OnEffectStart(Actor akActor, Actor akCaster)
	string CreatureName = akActor.GetLeveledActorBase().GetName()
	int foundone = 0
	
	while (i <= Creature_Import_NPC.Length)
		If (akCaster.GetItemCount(Creature_Import_NPC[i]))
			Actor tempActor = akActor.PlaceAtMe(Creature_Donor_NPC[i], abInitiallyDisabled = true) as Actor
			akCaster.removeitem(Creature_Import_NPC[i], int_count)
			Utility.Wait(5)
			if akActor.GetLeveledActorBase().GetSex() == 0 && INVB_Global_AllowedMales.GetValue() == 1
				MakePregnant_Male(akActor, tempActor)
			else
				MakePregnant(akActor, tempActor)
			endif
			tempActor.delete()
			foundone = 1
		EndIf
		i += 1
	endwhile	
		
	while (u <= Creature_Import.Length)
		If (akCaster.GetItemCount(Creature_Import[u]))
			Actor tempActor = akActor.PlaceAtMe(Creature_Donor[u], abInitiallyDisabled = true) as Actor
			akCaster.removeitem(Creature_Import[u], int_count)
			Utility.Wait(5)
			if akActor.GetLeveledActorBase().GetSex() == 0 && INVB_Global_AllowedMales.GetValue() == 1
				MakePregnant_Male(akActor, tempActor)
			else
				MakePregnant(akActor, tempActor)
			endif
			tempActor.delete()
			foundone = 1
		EndIf
		u += 1
	endwhile	
		
		
	if INVB_Global_Notes.GetValue() == 1		
		if foundone == 1	
			Debug.notification(CreatureName + String_Worked)
		elseif foundone == 0
			Debug.notification(CreatureName + String_Failed)
		elseif foundone == 2
			Debug.notification(CreatureName + String_Interrupted)
		EndIf
	EndIf
	
EndEvent


FPFP_Player_Script FPE

Bool Function LoadFPE()
	If Game.IsPluginInstalled("FP_FamilyPlanningEnhanced.esp")
		FPE = FPFP_Player_Script.GetAPI()
		Return True
	Else
		Return false
	EndIf
EndFunction

Function Setup()
    If LoadFPE() == true
		Debug.Trace("FPE Cum Inject: Family Planning Enhanced is loaded")
	Else
		Debug.Trace("FPE Cum Inject: Family Planning Enhanced not found")
	EndIf
EndFunction


;
; This function takes into account the MCM options like chance of pregnancy, etc
Function TryToMakePregnant(actor akFemale, actor akMale)
	FPFP_BasePregData tmpData = FPE.GetPregnancyInfo(akFemale)
	If (tmpData)
		If (tmpData.DeterminePotentialMan(akMale) != None) && (tmpData.IsValidWoman(akFemale) == true)
			tmpData.TrySpermFrom(akMale)
		EndIf
	EndIf
EndFunction	

;
; This function ignores most MCM settings and simply tries to make the female pregnant
Function MakePregnant(actor akFemale, actor akMale)
    FPFP_BasePregData tmpData = FPE.GetPregnancyInfo(akFemale)
    If (tmpData)
        If (tmpData.IsValidWoman(akFemale) == true)
            tmpData.Impregnate(akMale)
        EndIf
    EndIf
EndFunction

Function MakePregnant_Male(actor akFemale, actor akMale)
    FPFP_BasePregData tmpData = FPE.GetPregnancyInfo(akFemale)
    If (tmpData)
        tmpData.Impregnate(akMale)
    EndIf
EndFunction