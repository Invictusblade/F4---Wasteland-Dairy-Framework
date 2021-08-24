Scriptname INVB_Feeding extends activemagiceffect

potion Property Potion_Feed Auto Const Mandatory
MiscObject Property Misc_Baby_01 Auto Const Mandatory
form Property Misc_Baby_02 Auto Const Mandatory
LeveledItem Property LL_Baby Auto Const Mandatory

Event OnEffectStart(Actor akTarget, Actor akCaster)
	
	If (Game.GetPlayer().GetItemCount(Misc_Baby_02) >= 1)
		akTarget.removeitem(Misc_Baby_02, 1)
		akTarget.additem(LL_Baby)
	elseIf (Game.GetPlayer().GetItemCount(Misc_Baby_01) >= 1)
		akTarget.removeitem(Misc_Baby_01, 1)
		akTarget.additem(LL_Baby)
	else
		akTarget.additem(Potion_Feed)
	endIf
	
EndEvent