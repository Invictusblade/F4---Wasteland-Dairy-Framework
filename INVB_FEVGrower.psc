Scriptname INVB_FEVGrower extends activemagiceffect

Form[] Property Armor_Baby Auto Const Mandatory

Event OnEffectStart(Actor akTarget, Actor akCaster)
	ChildGrower(akTarget)
	BabyGrower(akTarget)
	
EndEvent

Function BabyGrower(Actor akActor)    
	int i
	int int_end = Armor_Baby.Length
	while (i <= Armor_Baby.Length)
		If (akActor.GetItemCount(Armor_Baby[i]) >= 1)
			Utility.Wait(2.5)
			akActor.unequipitem(Armor_Baby[i], 1, true)
			Utility.Wait(2.5)
			DropAndGrowIntoChild(akActor, Armor_Baby[i])
			i = int_end
		endIf
		i += 1
	endwhile
	 
EndFunction

Function ChildGrower(Actor akActor)    
	If (akActor as FPFP_GrowingChildScript)
		(akActor as FPFP_GrowingChildScript).GrowUp()
	endIf
EndFunction

Function DropAndGrowIntoChild(Actor akActor, Form BabyType)
	; Drop one baby
	akActor.DropObject(BabyType)
    Utility.Wait(0.5)
	; Find the dropped baby
	ObjectReference TheBaby = Game.FindClosestReferenceOfTypeFromRef(BabyType, akActor, 100)
      
	; Grow up the dropped baby
	(TheBaby as FPFP_BabyScript).GrowIntoChild()
EndFunction