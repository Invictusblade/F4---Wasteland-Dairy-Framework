Scriptname INVB_MCM_Cheat extends Quest

Actor Property PlayerRef Auto Const
GlobalVariable property INVB_Global_Notes Auto Const Mandatory

Potion Property Potion_MilkCratex24 Auto Const
Potion Property Potion_IVStoragex50 Auto Const
Potion Property Potion_PowderMilk Auto Const
Potion Property Potion_PowderMilkV81 Auto Const
Perk Property Perk_Virus Auto
Perk Property Perk_Virus_V81 Auto
Perk Property Perk_Lactation Auto
Book[] Property Mag_Perk Auto
Perk[] Property Perk_fromMag Auto
Perk[] Property Perk_Blood Auto
Perk Property Perk_TypeO Auto
Perk Property Perk_TypeA Auto
Perk Property Perk_TypeB Auto
Perk Property Perk_TypeAB Auto

Actor Function GetActorUnderCrosshairs()
	Actor ScannedActor = LL_FourPlay.LastCrossHairActor()
	
	If ScannedActor == NONE || ScannedActor.GetDistance(PlayerRef) > 256.000
		return None
	EndIf
	Return ScannedActor
EndFunction

Function GiveNPCUnderCrosshairs_Virus()
	Actor akActor = GetActorUnderCrosshairs()
	
	if akActor.hasPerk(Perk_Virus)
		akActor.removePerk(Perk_Virus)
	else
		akActor.hasPerk(Perk_Virus)
	endif
	
EndFunction

Function GiveMyself_Virus()
	Actor akActor = PlayerREF
	if akActor.hasPerk(Perk_Virus)
		akActor.removePerk(Perk_Virus)
	else
		akActor.hasPerk(Perk_Virus)
	endif
EndFunction

Function GiveNPCUnderCrosshairs_Virus_V81()
	Actor akActor = GetActorUnderCrosshairs()
	
	if akActor.hasPerk(Perk_Virus_V81)
		akActor.removePerk(Perk_Virus_V81)
	else
		akActor.hasPerk(Perk_Virus_V81)
	endif
	
EndFunction

Function GiveMyself_Virus_V81()
	Actor akActor = PlayerREF
	if akActor.hasPerk(Perk_Virus_V81)
		akActor.removePerk(Perk_Virus_V81)
	else
		akActor.hasPerk(Perk_Virus_V81)
	endif
EndFunction

Function GiveNPCUnderCrosshairs_Lactation()
	Actor akActor = GetActorUnderCrosshairs()
	
	if akActor.hasPerk(Perk_Lactation)
		akActor.removePerk(Perk_Lactation)
	else
		akActor.hasPerk(Perk_Lactation)
	endif
	
EndFunction

Function GiveMyself_Lactation()
	Actor akActor = PlayerREF
	if akActor.hasPerk(Perk_Lactation)
		akActor.removePerk(Perk_Lactation)
	else
		akActor.hasPerk(Perk_Lactation)
	endif
EndFunction

Function GiveMyself_BookAllRemainder()
	Actor akActor = PlayerREF
	int i
	while (i <= Perk_fromMag.Length)
		If !akActor.HasPerk(Perk_fromMag[i])
			akActor.additem(Mag_Perk[i])
		endif
		i += 1
	endwhile
	
EndFunction

Function GiveMyself_MilkCratex24()
	Actor akActor = PlayerREF
	akActor.additem(Potion_MilkCratex24, 1)
EndFunction

Function GiveMyself_IVStoragex50()
	Actor akActor = PlayerREF
	akActor.additem(Potion_IVStoragex50, 1)
EndFunction

Function GiveMyself_PowderMilk()
	Actor akActor = PlayerREF
	akActor.additem(Potion_PowderMilk, 1)
EndFunction

Function GiveMyself_PowderMilkV81()
	Actor akActor = PlayerREF
	akActor.additem(Potion_PowderMilkV81, 1)
EndFunction


Function Remove_BloodPerk(Actor akActor)
	int i
	while (i <= Perk_Blood.Length)
		akActor.removePerk(Perk_Blood[i])
		i += 1
	endwhile
EndFunction

Function GiveNPCUnderCrosshairs_TypeA()
	Actor akActor = GetActorUnderCrosshairs()
	Remove_BloodPerk(akActor)
	akActor.AddPerk(Perk_TypeA)
EndFunction

Function GiveMyself_TypeA()
	Actor akActor = PlayerREF
	Remove_BloodPerk(akActor)
	akActor.AddPerk(Perk_TypeA)
EndFunction

Function GiveNPCUnderCrosshairs_TypeAB()
	Actor akActor = GetActorUnderCrosshairs()
	Remove_BloodPerk(akActor)
	akActor.AddPerk(Perk_TypeAB)
EndFunction

Function GiveMyself_TypeAB()
	Actor akActor = PlayerREF
	Remove_BloodPerk(akActor)
	akActor.AddPerk(Perk_TypeAB)
EndFunction

Function GiveNPCUnderCrosshairs_TypeB()
	Actor akActor = GetActorUnderCrosshairs()
	Remove_BloodPerk(akActor)
	akActor.AddPerk(Perk_TypeB)
EndFunction

Function GiveMyself_TypeB()
	Actor akActor = PlayerREF
	Remove_BloodPerk(akActor)
	akActor.AddPerk(Perk_TypeB)
EndFunction

Function GiveNPCUnderCrosshairs_TypeO()
	Actor akActor = GetActorUnderCrosshairs()
	Remove_BloodPerk(akActor)
	akActor.AddPerk(Perk_TypeO)
EndFunction

Function GiveMyself_TypeO()
	Actor akActor = PlayerREF
	Remove_BloodPerk(akActor)
	akActor.AddPerk(Perk_TypeO)
EndFunction