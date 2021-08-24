Scriptname INVB_Cleaning extends activemagiceffect

potion Property Potion_Feed Auto Const Mandatory
MiscObject Property old_object Auto Const
LeveledItem Property ll_object Auto Const Mandatory


Event OnEffectStart(Actor akTarget, Actor akCaster)
	
	If (Game.GetPlayer().GetItemCount(old_object) >= 1)
		akTarget.removeitem(old_object, 1)
		akTarget.additem(ll_object)
	else
		akTarget.additem(Potion_Feed)
	endIf
	
EndEvent