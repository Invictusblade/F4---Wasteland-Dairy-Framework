Scriptname INVB_ME_Armor_Giver extends activemagiceffect

Armor Property Armor_ME Auto Const Mandatory


Event OnEffectStart(Actor akTarget, Actor akCaster)
	akTarget.equipitem(Armor_ME, true, true)	
EndEvent