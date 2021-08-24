Scriptname INVB_Pokeball_Release_wild extends activemagiceffect

Actorbase Property Creature_Donor Auto Const
Form Property Creature_Donor_Hostile Auto Const Mandatory
FPE_BabyNames Property FPFP_BabyNames Auto Const Mandatory
Race Property OtherRace Auto
Bool Property OtherRace_bool = false Auto
String SummonName
GlobalVariable property INVB_Global_Creature_TrapChance Auto Const Mandatory
Actor tempActor

Event OnEffectStart(Actor akActor, Actor akCaster)
	string CreatureName = Creature_Donor.GetName()
	string CreatureName_Hostile = Creature_Donor_Hostile.GetName()
	int random_seed = Utility.RandomInt(1, 10)	
	Game.FadeOutGame(true, true, 0, 1, true)
	Utility.Wait(1)
	Debug.notification("Ten Minutes Later.")
	Utility.Wait(1)
		
	if (random_seed >= INVB_Global_Creature_TrapChance.GetValue())
		tempActor = akCaster.PlaceAtMe(Creature_Donor) as Actor
	elseif (random_seed < INVB_Global_Creature_TrapChance.GetValue())
		tempActor = akCaster.PlaceAtMe(Creature_Donor_Hostile) as Actor
	endif

	if tempActor.GetLeveledActorBase().GetSex() == 0
		if OtherRace_bool == true
			SummonName = FPFP_BabyNames.BabyNames_Male(OtherRace)
		else	
			SummonName = FPFP_BabyNames.BabyNames_Male(tempActor.GetLeveledActorBase().GetRace())
		endif
	else
		if OtherRace_bool == true
			SummonName = FPFP_BabyNames.BabyNames_Female(OtherRace)
		else	
			SummonName = FPFP_BabyNames.BabyNames_Female(tempActor.GetLeveledActorBase().GetRace())
		endif
	endif
	
	if (random_seed >= INVB_Global_Creature_TrapChance.GetValue())
		Debug.notification(SummonName +" the "+ CreatureName +" seems to respect you")
	elseif (random_seed < INVB_Global_Creature_TrapChance.GetValue())
		Debug.notification(SummonName +" the "+ CreatureName_Hostile +" is Angry at you")
	endif
	SummonName = (SummonName +" the "+ CreatureName)
	RenameAnything.SetRefName(tempActor, SummonName)
	
	Game.FadeOutGame(false, true, 0, 1)	
EndEvent