Scriptname INVB_Pokeball_Catch extends activemagiceffect

ActorBase[] Property Creature_Donor Auto Const Mandatory 
ActorBase[] Property Creature_Donor_Follower Auto Const Mandatory 
ActorBase[] Property Creature_Donor_Baby Auto Const Mandatory 
Form[] Property Creature_Export Auto Const
Form[] Property Creature_Export_Baby Auto Const
GlobalVariable property INVB_Global_Notes Auto Const Mandatory
GlobalVariable property INVB_Global_Death Auto Const Mandatory
string Property String_Worked auto
string Property String_Failed auto

int i
int u
int o

Event OnEffectStart(Actor akActor, Actor akCaster)
	string CreatureName = akActor.GetLeveledActorBase().GetName()
	
	if !akActor.IsDead()
		Enslavement(akActor, akCaster)
	elseif akActor.IsDead() && INVB_Global_Death.GetValue() == 1
		Enslavement(akActor, akCaster)
	elseif akActor.IsDead() && INVB_Global_Death.GetValue() == 0
		Debug.notification(CreatureName +" is Dead")
	EndIf
EndEvent

Function Enslavement(Actor akActor, Actor akCaster)
	string CreatureName = akActor.GetActorBase().GetName()
	
	int foundone = 0
	
	while (i < Creature_Donor_Baby.Length)
		If akActor.GetActorBase() == Creature_Donor_Baby[i]
			akCaster.additem(Creature_Export_Baby[i], 1)
			akActor.Delete()
			if foundone == 0
				foundone = 1
			endif	
		EndIf
		i += 1
	endwhile	
		
	while (u < Creature_Donor.Length)
		If akActor.GetActorBase() == Creature_Donor[u]
			akCaster.additem(Creature_Export[u], 1)
			akActor.Delete()
			
			if foundone == 0
				foundone = 1
			endif	
		EndIf
		u += 1
	endwhile	

	while (o < Creature_Donor_Follower.Length)
		If akActor.GetActorBase() == Creature_Donor_Follower[o]
			akCaster.additem(Creature_Export[o], 1)
			akActor.Delete()
			
			if foundone == 0
				foundone = 1
			endif	
		EndIf
		o += 1
	endwhile	

	if INVB_Global_Notes.GetValue() == 1		
		if foundone == 1	
			Debug.notification(CreatureName + String_Worked)
		elseif foundone == 0
			Debug.notification(CreatureName + String_Failed)
		EndIf
	EndIf
EndFunction