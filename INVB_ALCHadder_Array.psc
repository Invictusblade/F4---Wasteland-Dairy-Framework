Scriptname INVB_ALCHadder_Array extends activemagiceffect

Potion[] Property Potion_item Auto Const
bool Property bool_Display = True Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
	int random_Gift = Utility.RandomInt(0, Potion_item.Length)
	akCaster.additem(Potion_item[random_Gift], 1, bool_Display)
EndEvent