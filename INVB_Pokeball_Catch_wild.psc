Scriptname INVB_Pokeball_Catch_wild extends activemagiceffect

Actor target
int Property int_count Auto
Race[] Property CreatureRace Auto Const Mandatory 
Form[] Property Creature_Export Auto Const
GlobalVariable property INVB_Global_Notes Auto Const Mandatory
GlobalVariable property INVB_Global_Creature_TrapChance Auto Const Mandatory
GlobalVariable property INVB_Global_Enslave Auto Const Mandatory
GlobalVariable property INVB_Global_Death Auto Const Mandatory
string Property String_Worked auto
string Property String_Failed auto
string Property String_Enraged auto
Perk Property Perk_Enraged Auto
Perk Property WLD_perk_Enslaved Auto


int u

Event OnEffectStart(Actor akActor, Actor akCaster)
	string CreatureName = akActor.GetLeveledActorBase().GetName()
	
	if akActor.HasPerk(Perk_Enraged)
		Debug.notification(CreatureName +" is already Pissed off at you")
	elseif !akActor.IsDead()
		Enslavement(akActor, akCaster)
	elseif akActor.IsDead() && INVB_Global_Death.GetValue() == 1
		Enslavement(akActor, akCaster)
	elseif akActor.IsDead() && INVB_Global_Death.GetValue() == 0
		Debug.notification(CreatureName +" is Dead")
	EndIf
	
EndEvent

Function Enslavement(Actor akActor, Actor akCaster)
	string CreatureName = akActor.GetLeveledActorBase().GetName()
	int random_seed = Utility.RandomInt(1, 10)	
	int foundone = 0
	int int_end_u = CreatureRace.Length
	
if (random_seed >= INVB_Global_Creature_TrapChance.GetValue())	
	while (u <= CreatureRace.Length)
		If akActor.GetLeveledActorBase().GetRace() == CreatureRace[u]
			
			if INVB_Global_Enslave.GetValue() == 1	
				akActor.AddPerk(WLD_perk_Enslaved)
				akActor.Kill()
			elseif INVB_Global_Enslave.GetValue() == 2
				akActor.Delete()
			else
				akActor.AddPerk(WLD_perk_Enslaved)
			endif
			
			if akActor.HasPerk(WLD_perk_Enslaved)
			else
				akCaster.additem(Creature_Export[u], int_count)
			endif
			
			u = int_end_u
			
			if foundone == 0
				foundone = 1
			endif	
		EndIf
		u += 1
	endwhile	
elseIf (random_seed < INVB_Global_Creature_TrapChance.GetValue())
	akActor.AddPerk(Perk_Enraged)
	foundone = 2
endif


	if INVB_Global_Notes.GetValue() == 1		
		if foundone == 1	
			Debug.notification(CreatureName + String_Worked)
		elseif foundone == 0
			Debug.notification(CreatureName + String_Failed)
		elseif foundone == 2
			Debug.notification(CreatureName + String_Enraged)	
		EndIf
	EndIf

EndFunction