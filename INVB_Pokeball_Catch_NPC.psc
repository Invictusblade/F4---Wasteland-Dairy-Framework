Scriptname INVB_Pokeball_Catch_NPC extends activemagiceffect

ActorBase[] Property Creature_Donor Auto Const Mandatory
ActorBase[] Property Creature_Donor_Settler Auto Const Mandatory
ActorBase[] Property Creature_Donor_Follower Auto Const Mandatory
Form[] Property Creature_Export Auto Const
GlobalVariable property INVB_Global_Notes Auto Const Mandatory
GlobalVariable property INVB_Global_Enslave Auto Const Mandatory
GlobalVariable property INVB_Global_Death Auto Const Mandatory
string Property String_Worked auto
string Property String_Failed auto
string Property String_Caged auto
Perk Property WLD_perk_Enslaved Auto
int u
int i
int o

Event OnEffectStart(Actor akActor, Actor akCaster)
	
	if !akActor.IsDead()
		Enslavement(akActor, akCaster)
	elseif akActor.IsDead() && INVB_Global_Death.GetValue() == 1
		Enslavement(akActor, akCaster)
	elseif akActor.IsDead() && INVB_Global_Death.GetValue() == 0
		string CreatureName = akActor.GetActorBase().GetName()
		Debug.notification(CreatureName +" is Dead")
	EndIf
	
EndEvent

Function Enslavement(Actor akActor, Actor akCaster)
	string CreatureName = akActor.GetActorBase().GetName()
	
	int foundone = 0
	while (u < Creature_Donor.Length)
		If akActor.GetActorBase() == Creature_Donor[u]
			if akActor.HasPerk(WLD_perk_Enslaved)
				Debug.notification(CreatureName + " has already been Enslaved")
			else
				akCaster.additem(Creature_Export[u], 1)				
			endif
			
			if INVB_Global_Enslave.GetValue() == 1
				akActor.AddPerk(WLD_perk_Enslaved)
				akActor.Kill()
			elseif INVB_Global_Enslave.GetValue() == 2
				akActor.Delete()
			else
				akActor.AddPerk(WLD_perk_Enslaved)
			endif
			
			if foundone == 0
				foundone = 1
			endif	
		EndIf
		u += 1
	endwhile	
	
	while (i < Creature_Donor_Settler.Length)
	
		If akActor.GetActorBase() == Creature_Donor_Settler[i]
			if akCaster.GetItemCount(Creature_Export[i]) == 0
				akCaster.additem(Creature_Export[i], 1)
			else
				Debug.notification(CreatureName + " has already been Enslaved")
			endif
			
			akActor.Delete()
			
			if foundone == 0
				foundone = 2
			endif	
		EndIf
		i += 1
	endwhile	


	while (o < Creature_Donor_Follower.Length)
	
		If akActor.GetActorBase() == Creature_Donor_Follower[o]
			if akCaster.GetItemCount(Creature_Export[o]) == 0
				akCaster.additem(Creature_Export[o], 1)
			else
				Debug.notification(CreatureName + " has already been Enslaved")
			endif
			
			akActor.Delete()
			
			if foundone == 0
				foundone = 2
			endif	
		EndIf
		o += 1
	endwhile	


	if INVB_Global_Notes.GetValue() == 1		
		if foundone == 1	
			Debug.notification(CreatureName + String_Worked)
		elseif foundone == 0
			Debug.notification(CreatureName + String_Failed)
		elseif foundone == 2
			Debug.notification(CreatureName + String_Caged)
		EndIf
	EndIf
EndFunction