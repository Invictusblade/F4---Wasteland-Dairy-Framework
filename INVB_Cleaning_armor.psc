Scriptname INVB_Cleaning_armor extends activemagiceffect

potion Property Potion_Feed Auto Const Mandatory
Armor Property old_object Auto Const
Armor Property new_object Auto Const Mandatory


Event OnEffectStart(Actor akTarget, Actor akCaster)
	
	If (Game.GetPlayer().GetItemCount(old_object) >= 1)
		akTarget.removeitem(old_object, 1)
		akTarget.additem(new_object)
	else
		akTarget.additem(Potion_Feed)
	endIf
	
EndEvent