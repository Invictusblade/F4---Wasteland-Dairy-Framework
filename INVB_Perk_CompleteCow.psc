Scriptname INVB_Perk_CompleteCow extends activemagiceffect

GlobalVariable property INVB_Global_Notes Auto Const Mandatory
GlobalVariable property INVB_Global_Milking_Virus_WorkshopNPCOnly Auto Const Mandatory
Perk Property Perk_IUD Auto
potion Property Potion_IUD Auto Const Mandatory
string Property string_Success auto
string Property string_Failed auto
ActorBase Property WorkshopNPC Auto Const Mandatory
ActorBase Property encBrahminTemplate_Female Auto Const Mandatory 
ActorBase Property encBrahminTemplate_Male Auto Const Mandatory 

Event OnEffectStart(Actor akTarget, Actor akCaster)

if INVB_Global_Milking_Virus_WorkshopNPCOnly.GetValue() == 0
	if akTarget == Game.GetPlayer()
		debug.notification("I am not injecting that into myself!")
	elseif akTarget.HasPerk(Perk_IUD) && akTarget.GetLeveledActorBase().GetSex() == 0 && akTarget.GetActorBase() == WorkshopNPC
		akTarget.PlaceAtMe(encBrahminTemplate_Male)
		akTarget.Delete()
		if INVB_Global_Notes.GetValue() == 1
			debug.notification(string_Success)
		endIf
	elseif akTarget.HasPerk(Perk_IUD) && akTarget.GetLeveledActorBase().GetSex() == 1 && akTarget.GetActorBase() == WorkshopNPC
		akTarget.PlaceAtMe(encBrahminTemplate_Female)
		akTarget.Delete()
		if INVB_Global_Notes.GetValue() == 1
			debug.notification(string_Success)
		endIf
	else
		Game.GetPlayer().additem(Potion_IUD, 1, true)
		if INVB_Global_Notes.GetValue() == 1
			debug.notification(string_Failed)
		endIf
	endIf
elseif INVB_Global_Milking_Virus_WorkshopNPCOnly.GetValue() == 1
	if akTarget == Game.GetPlayer()
		debug.notification("I am not injecting that into myself!")
	elseif akTarget.HasPerk(Perk_IUD) && akTarget.GetLeveledActorBase().GetSex() == 0
		akTarget.PlaceAtMe(encBrahminTemplate_Male)
		akTarget.Delete()
		if INVB_Global_Notes.GetValue() == 1
			debug.notification(string_Success)
		endIf
	elseif akTarget.HasPerk(Perk_IUD) && akTarget.GetLeveledActorBase().GetSex() == 1
		akTarget.PlaceAtMe(encBrahminTemplate_Female)
		akTarget.Delete()
		if INVB_Global_Notes.GetValue() == 1
			debug.notification(string_Success)
		endIf
	else
		Game.GetPlayer().additem(Potion_IUD, 1, true)
		if INVB_Global_Notes.GetValue() == 1
			debug.notification(string_Failed)
		endIf
	endIf
endIf	
EndEvent