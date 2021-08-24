Scriptname INVB_Implant_Creatures_AIO extends ObjectReference

Actor target
int Property int_count Auto

Armor Property pArmor_Cuminjector Auto Const Mandatory
ActorBase Property encAlien Auto Const Mandatory 
ActorBase Property Dogmeat Auto Const Mandatory 
ActorBase Property encDeathclaw02 Auto Const Mandatory 
ActorBase Property encMolerat02 Auto Const Mandatory 
ActorBase Property encSuperMutant02Auto Auto Const Mandatory 
ActorBase Property encBrahminTemplate Auto Const Mandatory 
ActorBase Property encMirelurk02 Auto Const Mandatory 
ActorBase Property encBloatfly02 Auto Const Mandatory 
ActorBase Property encStingwing02 Auto Const Mandatory 
ActorBase Property encRadScorpion02 Auto Const Mandatory 
ActorBase Property encMirelurkHunter02 Auto Const Mandatory 
ActorBase Property encFeralGhoul02 Auto Const Mandatory 
ActorBase Property encRadStag02 Auto Const Mandatory 
ActorBase Property encMutantHound02 Auto Const Mandatory 
ActorBase Property encYaoGuai02 Auto Const Mandatory 
ActorBase Property encMirelurkKing02 Auto Const Mandatory
ActorBase Property encGorilla Auto Const Mandatory 
ActorBase Property encMirelurkQueen Auto Const Mandatory 
ActorBase Property encSynth03 Auto Const Mandatory 
ActorBase Property encViciousDog02 Auto Const Mandatory 
ActorBase Property encRaiderDog02 Auto Const Mandatory 

Potion Property Cum_Alien Auto Const
Potion Property Cum_Supermutant Auto Const
Potion Property Cum_Dogmeat Auto Const
Potion Property Cum_Molerat Auto Const
Potion Property Cum_Deathclaw Auto Const
Potion Property Cum_Brahmin Auto Const
Potion Property Cum_Mirelurk Auto Const
Potion Property Cum_Bloatfly Auto Const
Potion Property Cum_Stingwing Auto Const
Potion Property Cum_Radscorpion Auto Const
Potion Property Cum_Radstag Auto Const
Potion Property Cum_Mutant_Hound Auto Const
Potion Property Cum_Yao_Guai Auto Const
Potion Property Cum_Feral_Ghoul Auto Const
Potion Property Cum_Gorilla Auto Const
Potion Property Cum_Mirelurk_Queen Auto Const
Potion Property Cum_Synth Auto Const
Potion Property Cum_VicDog Auto Const
Potion Property Cum_Dog Auto Const

ActorBase Property DLC03_encAngler02 Auto Const Mandatory 
ActorBase Property DLC03_encFogCrawler02 Auto Const Mandatory 
ActorBase Property DLC03_encHermitCrab02 Auto Const Mandatory 
ActorBase Property DLC03_encGulper02 Auto Const Mandatory 
ActorBase Property DLC03_encWolf02 Auto Const Mandatory 
ActorBase Property DLC03_encRadRabbit Auto Const Mandatory 
ActorBase Property DLC03_encRadChicken Auto Const Mandatory 

Potion Property DLC03_Cum_Anglers Auto Const
Potion Property DLC03_Cum_Fog_Crawler Auto Const
Potion Property DLC03_Cum_Hermit_Crab Auto Const
Potion Property DLC03_Cum_Gulper Auto Const
Potion Property DLC03_Cum_Wolf Auto Const
Potion Property DLC03_Cum_Rabbit Auto Const
Potion Property DLC03_Cum_Chicken Auto Const

ActorBase Property DLC04_encBloodworm02 Auto Const Mandatory 
ActorBase Property DLC04_encCaveCricket02 Auto Const Mandatory 
ActorBase Property DLC04_encRadRat02_SmallMild Auto Const Mandatory 
ActorBase Property DLC04encBrahmiluff02 Auto Const Mandatory 
ActorBase Property DLC04_encGatorclaw Auto Const Mandatory 
ActorBase Property DLC04_encRadGorilla Auto Const Mandatory 
ActorBase Property DLC04_DONOTSPAWN_FPERadGazelle_T Auto Const Mandatory 

Potion Property DLC04_Cum_Bloodworm Auto Const
Potion Property DLC04_Cum_Cave_Cricket Auto Const
Potion Property DLC04_Cum_Rad_Rat Auto Const
Potion Property DLC04_Cum_Brahmiluff Auto Const
Potion Property DLC04_Cum_Gatorclaw Auto Const
Potion Property DLC04_Cum_Gorilla Auto Const
Potion Property DLC04_Cum_Rad_Gazelle Auto Const
GlobalVariable property INVB_Global_AllowedMales Auto Const Mandatory

FPFP_Player_Script FPE

Bool Function LoadFPE()
	If Game.IsPluginInstalled("FP_FamilyPlanningEnhanced.esp")
		FPE = FPFP_Player_Script.GetAPI()
		Return True
	Else
		Return false
	EndIf
EndFunction

Function Setup()
    If LoadFPE() == true
		Debug.Trace("FPE Cum Inject: Family Planning Enhanced is loaded")
	Else
		Debug.Trace("FPE Cum Inject: Family Planning Enhanced not found")
	EndIf
EndFunction


;
; This function takes into account the MCM options like chance of pregnancy, etc
Function TryToMakePregnant(actor akFemale, actor akMale)
	FPFP_BasePregData tmpData = FPE.GetPregnancyInfo(akFemale)
	If (tmpData)
		If (tmpData.DeterminePotentialMan(akMale) != None) && (tmpData.IsValidWoman(akFemale) == true)
			tmpData.TrySpermFrom(akMale)
		EndIf
	EndIf
EndFunction	

;
; This function ignores most MCM settings and simply tries to make the female pregnant
Function MakePregnant(actor akFemale, actor akMale)
    FPFP_BasePregData tmpData = FPE.GetPregnancyInfo(akFemale)
    If (tmpData)
        If (tmpData.IsValidWoman(akFemale) == true)
            tmpData.Impregnate(akMale)
		elseif  INVB_Global_AllowedMales.GetValue() == 1
			tmpData.Impregnate(akMale)
        EndIf
    EndIf
EndFunction

Event OnEquipped(Actor akActor)

	string CreatureName = akActor.GetLeveledActorBase().GetName()

if (akActor.GetItemCount(Cum_Alien) >= 1)
		akActor.removeitem(Cum_Alien, 1)
		Actor tempActor = akActor.PlaceAtMe(encAlien, abInitiallyDisabled = true) as Actor
		Utility.Wait(5)
		MakePregnant(akActor, tempActor)
		tempActor.delete()
Elseif (akActor.GetItemCount(Cum_Supermutant) >= 1)
		akActor.removeitem(Cum_Supermutant, 1)
		Actor tempActor = akActor.PlaceAtMe(encSuperMutant02Auto, abInitiallyDisabled = true) as Actor
		Utility.Wait(5)
		MakePregnant(akActor, tempActor)
		tempActor.delete()
Elseif (akActor.GetItemCount(Cum_Dogmeat) >= 1)
		akActor.removeitem(Cum_Dogmeat, 1)
		Actor tempActor = akActor.PlaceAtMe(Dogmeat, abInitiallyDisabled = true) as Actor
		Utility.Wait(5)
		MakePregnant(akActor, tempActor)
		tempActor.delete()
Elseif (akActor.GetItemCount(Cum_Molerat) >= 1)
		akActor.removeitem(Cum_Molerat, 1)
		Actor tempActor = akActor.PlaceAtMe(encMolerat02, abInitiallyDisabled = true) as Actor
		Utility.Wait(5)
		MakePregnant(akActor, tempActor)
		tempActor.delete()
Elseif (akActor.GetItemCount(Cum_Deathclaw) >= 1)
		akActor.removeitem(Cum_Deathclaw, 1)
		Actor tempActor = akActor.PlaceAtMe(encDeathclaw02, abInitiallyDisabled = true) as Actor
		Utility.Wait(5)
		MakePregnant(akActor, tempActor)
		tempActor.delete()
Elseif (akActor.GetItemCount(Cum_Brahmin) >= 1)
		akActor.removeitem(Cum_Brahmin, 1)
		Actor tempActor = akActor.PlaceAtMe(encBrahminTemplate, abInitiallyDisabled = true) as Actor
		Utility.Wait(5)
		MakePregnant(akActor, tempActor)
		tempActor.delete()
Elseif (akActor.GetItemCount(Cum_Bloatfly) >= 1)
		akActor.removeitem(Cum_Bloatfly, 1)
		Actor tempActor = akActor.PlaceAtMe(encBloatfly02, abInitiallyDisabled = true) as Actor
		Utility.Wait(5)
		MakePregnant(akActor, tempActor)
		tempActor.delete()
Elseif (akActor.GetItemCount(Cum_Stingwing) >= 1)
		akActor.removeitem(Cum_Stingwing, 1)
		Actor tempActor = akActor.PlaceAtMe(encStingwing02, abInitiallyDisabled = true) as Actor
		Utility.Wait(5)
		MakePregnant(akActor, tempActor)
		tempActor.delete()
Elseif (akActor.GetItemCount(Cum_Radscorpion) >= 1)
		akActor.removeitem(Cum_Radscorpion, 1)
		Actor tempActor = akActor.PlaceAtMe(encRadScorpion02, abInitiallyDisabled = true) as Actor
		Utility.Wait(5)
		MakePregnant(akActor, tempActor)
		tempActor.delete()
Elseif (akActor.GetItemCount(Cum_Feral_Ghoul) >= 1)
		akActor.removeitem(Cum_Feral_Ghoul, 1)
		Actor tempActor = akActor.PlaceAtMe(encFeralGhoul02, abInitiallyDisabled = true) as Actor
		Utility.Wait(5)
		MakePregnant(akActor, tempActor)
		tempActor.delete()
Elseif (akActor.GetItemCount(Cum_Radstag) >= 1)
		akActor.removeitem(Cum_Radstag, 1)
		Actor tempActor = akActor.PlaceAtMe(encRadStag02, abInitiallyDisabled = true) as Actor
		Utility.Wait(5)
		MakePregnant(akActor, tempActor)
		tempActor.delete()
Elseif (akActor.GetItemCount(Cum_Mutant_Hound) >= 1)
		akActor.removeitem(Cum_Mutant_Hound, 1)
		Actor tempActor = akActor.PlaceAtMe(encMutantHound02, abInitiallyDisabled = true) as Actor
		Utility.Wait(5)
		MakePregnant(akActor, tempActor)
		tempActor.delete()
Elseif (akActor.GetItemCount(Cum_Yao_Guai) >= 1)
		akActor.removeitem(Cum_Yao_Guai, 1)
		Actor tempActor = akActor.PlaceAtMe(encYaoGuai02, abInitiallyDisabled = true) as Actor
		Utility.Wait(5)
		MakePregnant(akActor, tempActor)
		tempActor.delete()
Elseif (akActor.GetItemCount(Cum_Gorilla) >= 1)
		akActor.removeitem(Cum_Gorilla, 1)
		Actor tempActor = akActor.PlaceAtMe(encGorilla, abInitiallyDisabled = true) as Actor
		Utility.Wait(5)
		MakePregnant(akActor, tempActor)
		tempActor.delete()
Elseif (akActor.GetItemCount(Cum_Mirelurk_Queen) >= 1)
		akActor.removeitem(Cum_Mirelurk_Queen, 1)
		Actor tempActor = akActor.PlaceAtMe(encMirelurkQueen, abInitiallyDisabled = true) as Actor
		Utility.Wait(5)
		MakePregnant(akActor, tempActor)
		tempActor.delete()
Elseif (akActor.GetItemCount(Cum_Mirelurk) >= 1)
		akActor.removeitem(Cum_Mirelurk, 1)
		Actor tempActor = akActor.PlaceAtMe(encMirelurk02, abInitiallyDisabled = true) as Actor
		Utility.Wait(5)
		MakePregnant(akActor, tempActor)
		tempActor.delete()
Elseif (akActor.GetItemCount(Cum_Synth) >= 1)
		akActor.removeitem(Cum_Synth, 1)
		Actor tempActor = akActor.PlaceAtMe(encSynth03, abInitiallyDisabled = true) as Actor
		Utility.Wait(5)
		MakePregnant(akActor, tempActor)
		tempActor.delete()
Elseif (akActor.GetItemCount(Cum_VicDog) >= 1)
		akActor.removeitem(Cum_VicDog, 1)
		Actor tempActor = akActor.PlaceAtMe(encViciousDog02, abInitiallyDisabled = true) as Actor
		Utility.Wait(5)
		MakePregnant(akActor, tempActor)
		tempActor.delete()
Elseif (akActor.GetItemCount(Cum_Dog) >= 1)
		akActor.removeitem(Cum_Dog, 1)
		Actor tempActor = akActor.PlaceAtMe(encRaiderDog02, abInitiallyDisabled = true) as Actor
		Utility.Wait(5)
		MakePregnant(akActor, tempActor)
		tempActor.delete()
Elseif (akActor.GetItemCount(DLC03_Cum_Anglers) >= 1)
		akActor.removeitem(DLC03_Cum_Anglers, 1)
		Actor tempActor = akActor.PlaceAtMe(DLC03_encAngler02, abInitiallyDisabled = true) as Actor
		Utility.Wait(5)
		MakePregnant(akActor, tempActor)
		tempActor.delete()
Elseif (akActor.GetItemCount(DLC03_Cum_Fog_Crawler) >= 1)
		akActor.removeitem(DLC03_Cum_Fog_Crawler, 1)
		Actor tempActor = akActor.PlaceAtMe(DLC03_encFogCrawler02, abInitiallyDisabled = true) as Actor
		Utility.Wait(5)
		MakePregnant(akActor, tempActor)
		tempActor.delete()
Elseif (akActor.GetItemCount(DLC03_Cum_Hermit_Crab) >= 1)
		akActor.removeitem(DLC03_Cum_Hermit_Crab, 1)
		Actor tempActor = akActor.PlaceAtMe(DLC03_encHermitCrab02, abInitiallyDisabled = true) as Actor
		Utility.Wait(5)
		MakePregnant(akActor, tempActor)
		tempActor.delete()
Elseif (akActor.GetItemCount(DLC03_Cum_Gulper) >= 1)
		akActor.removeitem(DLC03_Cum_Gulper, 1)
		Actor tempActor = akActor.PlaceAtMe(DLC03_encGulper02, abInitiallyDisabled = true) as Actor
		Utility.Wait(5)
		MakePregnant(akActor, tempActor)
		tempActor.delete()
Elseif (akActor.GetItemCount(DLC03_Cum_Wolf) >= 1)
		akActor.removeitem(DLC03_Cum_Wolf, 1)
		Actor tempActor = akActor.PlaceAtMe(DLC03_encWolf02, abInitiallyDisabled = true) as Actor
		Utility.Wait(5)
		MakePregnant(akActor, tempActor)
		tempActor.delete()
Elseif (akActor.GetItemCount(DLC03_Cum_Rabbit) >= 1)
		akActor.removeitem(DLC03_Cum_Rabbit, 1)
		Actor tempActor = akActor.PlaceAtMe(DLC03_encRadRabbit, abInitiallyDisabled = true) as Actor
		Utility.Wait(5)
		MakePregnant(akActor, tempActor)
		tempActor.delete()
Elseif (akActor.GetItemCount(DLC03_Cum_Chicken) >= 1)
		akActor.removeitem(DLC03_Cum_Chicken, 1)
		Actor tempActor = akActor.PlaceAtMe(DLC03_encRadChicken, abInitiallyDisabled = true) as Actor
		Utility.Wait(5)
		MakePregnant(akActor, tempActor)
		tempActor.delete()
Elseif (akActor.GetItemCount(DLC04_Cum_Bloodworm) >= 1)
		akActor.removeitem(DLC04_Cum_Bloodworm, 1)
		Actor tempActor = akActor.PlaceAtMe(DLC04_encBloodworm02, abInitiallyDisabled = true) as Actor
		Utility.Wait(5)
		MakePregnant(akActor, tempActor)
		tempActor.delete()
Elseif (akActor.GetItemCount(DLC04_Cum_Cave_Cricket) >= 1)
		akActor.removeitem(DLC04_Cum_Cave_Cricket, 1)
		Actor tempActor = akActor.PlaceAtMe(DLC04_encCaveCricket02, abInitiallyDisabled = true) as Actor
		Utility.Wait(5)
		MakePregnant(akActor, tempActor)
		tempActor.delete()
Elseif (akActor.GetItemCount(DLC04_Cum_Rad_Rat) >= 1)
		akActor.removeitem(DLC04_Cum_Rad_Rat, 1)
		Actor tempActor = akActor.PlaceAtMe(DLC04_encRadRat02_SmallMild, abInitiallyDisabled = true) as Actor
		Utility.Wait(5)
		MakePregnant(akActor, tempActor)
		tempActor.delete()
Elseif (akActor.GetItemCount(DLC04_Cum_Brahmiluff) >= 1)
		akActor.removeitem(DLC04_Cum_Brahmiluff, 1)
		Actor tempActor = akActor.PlaceAtMe(DLC04encBrahmiluff02, abInitiallyDisabled = true) as Actor
		Utility.Wait(5)
		MakePregnant(akActor, tempActor)
		tempActor.delete()
Elseif (akActor.GetItemCount(DLC04_Cum_Gatorclaw) >= 1)
		akActor.removeitem(DLC04_Cum_Gatorclaw, 1)
		Actor tempActor = akActor.PlaceAtMe(DLC04_encGatorclaw, abInitiallyDisabled = true) as Actor
		Utility.Wait(5)
		MakePregnant(akActor, tempActor)
		tempActor.delete()
Elseif (akActor.GetItemCount(DLC04_Cum_Rad_Gazelle) >= 1)
		akActor.removeitem(DLC04_Cum_Rad_Gazelle, 1)
		Actor tempActor = akActor.PlaceAtMe(DLC04_DONOTSPAWN_FPERadGazelle_T, abInitiallyDisabled = true) as Actor
		Utility.Wait(5)
		MakePregnant(akActor, tempActor)
		tempActor.delete()
Else
		Debug.notification(CreatureName +" has Rejected The Injection")
EndIf	
	
		Debug.notification(CreatureName +" has been impregnated")
	
	
EndEvent

Event OnInit()
	Setup()
EndEvent