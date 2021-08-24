Scriptname INVB_Feeding_Armor_ll extends ObjectReference

Actor property PlayerRef Auto Const Mandatory
Armor Property pArmor_BadBaby Auto Const Mandatory
potion Property Breast_Milk Auto Const Mandatory
potion Property Stimpak Auto Const Mandatory
LeveledItem Property pArmor_baby Auto Const
MiscObject Property milk_Empty Auto Const
GlobalVariable property INVB_Global_Notes Auto Const Mandatory

Event OnEquipped(Actor akActor)
	if (akActor == PlayerRef)
	
		if INVB_Global_Notes.GetValue() == 1
			if (Game.GetPlayer().GetItemCount(Breast_Milk) == 0)
				Debug.notification("No breast milk, Needs Two")
			elseIf (Game.GetPlayer().GetItemCount(Breast_Milk) == 1)
				Debug.notification("Only One breast milk, Needs Two")
			elseIf (Game.GetPlayer().GetItemCount(Stimpak) == 0)
				Debug.notification("No stimpaks, Needs One")
			elseIf (Game.GetPlayer().GetItemCount(Breast_Milk) >= 2) && (Game.GetPlayer().GetItemCount(Stimpak) >= 1)
				Debug.notification("Baby Changing is ready, unequip for change Baby")
			endIf
		endIf
	
	elseIf (akActor.GetLeveledActorBase().GetSex() == 0) && (akActor != PlayerRef)
		akActor.unequipitem(pArmor_BadBaby)
		akActor.removeitem(pArmor_BadBaby)
	elseIf (akActor.GetLeveledActorBase().GetSex() == 1) && (akActor != PlayerRef)
		akActor.unequipitem(pArmor_BadBaby)
	endif
	
EndEvent


Event OnUnequipped(Actor akActor)
	if (akActor == PlayerRef)
		if (Game.GetPlayer().GetItemCount(Breast_Milk) >= 2) && (Game.GetPlayer().GetItemCount(Stimpak) >= 1)
			akActor.removeitem(Breast_Milk, 2)
			akActor.additem(milk_Empty, 2)
			akActor.removeitem(Stimpak, 1)
			akActor.removeitem(pArmor_BadBaby)
			akActor.additem(pArmor_baby)
		endIf
	endIf
EndEvent