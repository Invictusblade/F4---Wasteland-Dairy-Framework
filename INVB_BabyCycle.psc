Scriptname INVB_BabyCycle extends activemagiceffect

Form[] Property Armor_Baby Auto Const Mandatory
Form[] Property Baby_Frozen Auto Const Mandatory
potion Property Milk_Cold Auto Const Mandatory
potion Property Milk_Warm Auto Const Mandatory
string Property True_1 auto
string Property True_2 auto
string Property False_1 auto
string Property False_2 auto
bool Property Choice Auto
GlobalVariable property INVB_Global_Notes Auto Const Mandatory

MiscObject Property milk_Empty Auto Const

Event OnEffectStart(Actor akTarget, Actor akCaster)
	int i
	int int_end = Armor_Baby.Length
	if Choice == true
		bool foundone = false
		while (i <= Armor_Baby.Length)
			If (akTarget.GetItemCount(Armor_Baby[i]) >= 1)
				if INVB_Global_Notes.GetValue() == 1
					Debug.notification(True_1)
				endIf
				akTarget.removeitem(Armor_Baby[i], 1, true)
				akTarget.additem(Baby_Frozen[i], 1, true)
				akTarget.additem(milk_Empty, 1, true)
				foundone = true
				i = int_end
			endIf
			i += 1
		endwhile
	
		if (foundone == false)
			akTarget.additem(Milk_Cold, 1, true)
			if INVB_Global_Notes.GetValue() == 1
				Debug.notification(True_2)
			endIf	
		endIf
	elseif Choice == false
		bool foundone = false
		while (i <= Armor_Baby.Length)
		If (akTarget.GetItemCount(Baby_Frozen[i]) >= 1)
				akTarget.removeitem(Baby_Frozen[i], 1, true)
				akTarget.additem(Armor_Baby[i], 1, true)
				if INVB_Global_Notes.GetValue() == 1
					Debug.notification(False_1)
				endIf	
				akTarget.additem(milk_Empty, 1, true)
				foundone = true
				i = int_end
			endIf
			i += 1
		endwhile
	
		if (foundone == false)
			akTarget.additem(Milk_Warm, 1, true)
			if INVB_Global_Notes.GetValue() == 1
				Debug.notification(False_2)
			endIf	
		endIf
	endIf
EndEvent