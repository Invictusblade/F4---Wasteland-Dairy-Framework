Scriptname INVB_Mixing_Drinks extends activemagiceffect

potion Property Potion_powder Auto Const Mandatory
potion Property Potion_1 Auto Const Mandatory
potion Property Potion_2 Auto Const Mandatory
potion Property Potion_Final1 Auto Const Mandatory
potion Property Potion_Final2 Auto Const Mandatory
int Property int_count_1 Auto
int Property int_count_1_End Auto
int Property int_count_2 Auto
int Property int_count_2_End Auto
GlobalVariable property INVB_Global_Notes Auto Const Mandatory

Event OnEffectStart(Actor akTarget, Actor akCaster)
	
	If (Game.GetPlayer().GetItemCount(Potion_1) >= int_count_1)
		akTarget.removeitem(Potion_1, int_count_1)
		akTarget.additem(Potion_Final1, int_count_1_End)
	elseIf (Game.GetPlayer().GetItemCount(Potion_2) >= int_count_2)
		akTarget.removeitem(Potion_2, int_count_2)
		akTarget.additem(Potion_Final2, int_count_2_End)
	else
		akTarget.additem(Potion_powder)
		
		if INVB_Global_Notes.GetValue() == 1
			debug.notification("Need "+ int_count_1 +" "+ Potion_1.GetName())
			Utility.Wait(2.5)
			debug.notification("Need "+ int_count_2 +" "+ Potion_2.GetName())
		endIf
	endIf
	
EndEvent