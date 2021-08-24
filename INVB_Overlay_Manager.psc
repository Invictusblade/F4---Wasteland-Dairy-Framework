Scriptname INVB_Overlay_Manager extends ObjectReference

Armor Property pArmor_Manager Auto Const Mandatory
GlobalVariable property INVB_Global_OverlayChance Auto Mandatory
GlobalVariable property INVB_Global_Choice Auto Mandatory
GlobalVariable property INVB_Global_Choice_Hair Auto Mandatory
LeveledItem Property ll_Overlay Auto Const Mandatory
LeveledItem Property ll_Overlay_Full Auto Const Mandatory
LeveledItem Property ll_Overlay_Tramp Auto Const Mandatory
LeveledItem Property ll_Overlay_Unique Auto Const Mandatory
LeveledItem Property ll_Overlay_PubicHair Auto Const Mandatory

LeveledItem Property ll_Overlay_Male Auto Const Mandatory
LeveledItem Property ll_Overlay_Male_Full Auto Const Mandatory
LeveledItem Property ll_Overlay_Male_Tramp Auto Const Mandatory
LeveledItem Property ll_Overlay_Male_PubicHair Auto Const Mandatory
Keyword Property kw_Overlay Auto

Event OnEquipped(Actor akActor)
	float random_time = Utility.Randomfloat(1.1, 2.2)
	Utility.Wait(random_time)

	int random_LList = Utility.RandomInt(1, 100)
	
	if akActor.HasKeyword(kw_Overlay)
		Utility.Wait(random_time)
		akActor.unequipitem(pArmor_Manager)
		akActor.removeitem(pArmor_Manager)
	else
		if (random_LList <= INVB_Global_OverlayChance.GetValue())		
			if (INVB_Global_Choice.GetValue() == 0) ; Random
				If akActor.GetLeveledActorBase().GetSex() == 0
					int random_Chance_M = Utility.RandomInt(1, 3)
					if (random_Chance_M == 1)
						akActor.additem(ll_Overlay_Male)
					elseif (random_Chance_M == 2)
						akActor.additem(ll_Overlay_Male_Full)
					else 
						akActor.additem(ll_Overlay_Male_Tramp)
					endif
				elseIf akActor.GetLeveledActorBase().GetSex() == 1
					int random_Chance_F = Utility.RandomInt(1, 3)
					if (random_Chance_F == 1)
						akActor.additem(ll_Overlay)
					elseif (random_Chance_F == 2)
						akActor.additem(ll_Overlay_Full)
					else 
						akActor.additem(ll_Overlay_Tramp)
					endif
				endif
				akActor.AddKeyword(kw_Overlay)
			elseif (INVB_Global_Choice.GetValue() == 1) ; All
				If akActor.GetLeveledActorBase().GetSex() == 0
					akActor.additem(ll_Overlay_Male)
				elseIf akActor.GetLeveledActorBase().GetSex() == 1
					akActor.additem(ll_Overlay)
				endif
				akActor.AddKeyword(kw_Overlay)
			elseif (INVB_Global_Choice.GetValue() == 2) ; Lower Back & Pelvis
				If akActor.GetLeveledActorBase().GetSex() == 0
					akActor.additem(ll_Overlay_Male_Tramp)
				elseIf akActor.GetLeveledActorBase().GetSex() == 1
					akActor.additem(ll_Overlay_Tramp)
				endif
				akActor.AddKeyword(kw_Overlay)
			elseif (INVB_Global_Choice.GetValue() == 3) ; Full Bodied
				If akActor.GetLeveledActorBase().GetSex() == 0
					akActor.additem(ll_Overlay_Male_Full)
				elseIf akActor.GetLeveledActorBase().GetSex() == 1
					akActor.additem(ll_Overlay_Full)
				endif
				akActor.AddKeyword(kw_Overlay)
			elseif (INVB_Global_Choice.GetValue() == 4) ; Unique
				akActor.additem(ll_Overlay_Unique)
				akActor.AddKeyword(kw_Overlay)
			elseif (INVB_Global_Choice.GetValue() == 5) ; Everything
				If akActor.GetLeveledActorBase().GetSex() == 0
					akActor.additem(ll_Overlay_Male)
					akActor.additem(ll_Overlay_Male_Tramp)
					akActor.additem(ll_Overlay_Unique)
				elseIf akActor.GetLeveledActorBase().GetSex() == 1
					akActor.additem(ll_Overlay)
					akActor.additem(ll_Overlay_Tramp)
					akActor.additem(ll_Overlay_Unique)
				endif
				akActor.AddKeyword(kw_Overlay)
			elseif (INVB_Global_Choice.GetValue() == 6) ; Nothing
				akActor.AddKeyword(kw_Overlay)
			endif
			
			if (INVB_Global_Choice_Hair.GetValue() == 0) ; Pubic Hair
				If akActor.GetLeveledActorBase().GetSex() == 0
					akActor.additem(ll_Overlay_Male_PubicHair)
				elseIf akActor.GetLeveledActorBase().GetSex() == 1
					akActor.additem(ll_Overlay_PubicHair)
				endif
			else
			endif
		endif
	endif
	
	Utility.Wait(random_time)
	akActor.unequipitem(pArmor_Manager)
	akActor.removeitem(pArmor_Manager)
EndEvent

