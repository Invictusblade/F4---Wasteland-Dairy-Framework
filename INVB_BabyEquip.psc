Scriptname INVB_BabyEquip extends activemagiceffect

Armor[] Property Armor_Baby Auto Const Mandatory
int Property int_end Auto
GlobalVariable property INVB_Global_Notes Auto Const Mandatory

Event OnEffectStart(Actor akTarget, Actor akCaster)
	int i
	
	bool foundone = false
	while (i <= int_end)
		If (akTarget.GetItemCount(Armor_Baby[i]) >= 1)
		if INVB_Global_Notes.GetValue() == 1	
			Debug.notification("Person is holding the Baby")
		endIf
		akTarget.equipitem(Armor_Baby[i], false, true)
		foundone = true
		i = int_end
		endIf
		i += 1
	endwhile
	
	if (foundone == false)
		if INVB_Global_Notes.GetValue() == 1
			Debug.notification("There is no Baby here to hold")
		endIf
	endIf
	
EndEvent