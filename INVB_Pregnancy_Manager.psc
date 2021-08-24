Scriptname INVB_Pregnancy_Manager extends ObjectReference

GlobalVariable property INVB_Global_ImpregnationChance Auto Const Mandatory
Keyword Property kw_noPreg Auto
Keyword Property FPFP_Preg Auto
Faction Property FPFP_Preggo Auto Const Mandatory
GlobalVariable property INVB_Global_Impregnation_Choice Auto Const Mandatory
GlobalVariable property INVB_Global_AllowedMales Auto Const Mandatory
LeveledItem Property ll_Babies Auto Const Mandatory
LeveledItem Property ll_Creatures Auto Const Mandatory
LeveledItem Property ll_Alive Auto Const Mandatory
Perk Property Perk_Lactation Auto
Armor Property Armor_Manager Auto Const Mandatory

Function Pregancy_Giver(Actor akActor)
	int random_LList = Utility.RandomInt(1, 100)
	if (random_LList <= INVB_Global_ImpregnationChance.GetValue())
		if (INVB_Global_Impregnation_Choice.GetValue() == 0) ; Both
			If akActor.GetLeveledActorBase().GetSex() == 0
				int random_Chance_M = Utility.RandomInt(1, 3)
				if (random_Chance_M == 1) && INVB_Global_AllowedMales.GetValue() == 2
					akActor.additem(ll_Babies)
				elseif (random_Chance_M == 2) && INVB_Global_AllowedMales.GetValue() == 2
					akActor.additem(ll_Creatures)
				elseif (random_Chance_M == 3) && INVB_Global_AllowedMales.GetValue() >= 1
					akActor.additem(ll_Alive)
					akActor.equipitem(ll_Alive)
				endif
			elseIf akActor.GetLeveledActorBase().GetSex() == 1
				int random_Chance_F = Utility.RandomInt(1, 3)
				if (random_Chance_F == 1)
					akActor.additem(ll_Babies)
				elseif (random_Chance_F == 2)
					akActor.additem(ll_Creatures)
				elseif (random_Chance_F == 3)
					akActor.AddPerk(Perk_Lactation)
					akActor.additem(ll_Alive)
					akActor.equipitem(ll_Alive)
				endif
			endif
		elseif (INVB_Global_Impregnation_Choice.GetValue() == 1) ; Baby Only
			If akActor.GetLeveledActorBase().GetSex() == 0 && INVB_Global_AllowedMales.GetValue() == 2
				akActor.additem(ll_Babies)
			elseIf akActor.GetLeveledActorBase().GetSex() == 1
				akActor.additem(ll_Babies)
			endif
		elseif (INVB_Global_Impregnation_Choice.GetValue() == 2) ; Creatures Only
			If akActor.GetLeveledActorBase().GetSex() == 0 && INVB_Global_AllowedMales.GetValue() == 2
				akActor.additem(ll_Creatures)
			elseIf akActor.GetLeveledActorBase().GetSex() == 1
				akActor.additem(ll_Creatures)
			endif
		elseif (INVB_Global_Impregnation_Choice.GetValue() == 3) ; Alive Only
			If akActor.GetLeveledActorBase().GetSex() == 0 && INVB_Global_AllowedMales.GetValue() >= 1
				akActor.additem(ll_Alive)
				akActor.equipitem(ll_Alive)
			elseIf akActor.GetLeveledActorBase().GetSex() == 1
				akActor.AddPerk(Perk_Lactation)
				akActor.additem(ll_Alive)
				akActor.equipitem(ll_Alive)
			endif
		endif
		akActor.unequipitem(Armor_Manager)
		akActor.removeitem(Armor_Manager)
	else
		akActor.unequipitem(Armor_Manager)
		akActor.removeitem(Armor_Manager)
	endif
EndFunction

Event OnEquipped(Actor akActor)
	if akActor.HasKeyword(kw_noPreg) || akActor.IsInFaction(FPFP_Preggo) || akActor.HasKeyword(FPFP_Preg)
		akActor.unequipitem(Armor_Manager)
		akActor.removeitem(Armor_Manager)
	else
		Pregancy_Giver(akActor)
	endif
EndEvent
