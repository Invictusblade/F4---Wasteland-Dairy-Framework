Scriptname INVB_PocketWatch_4 extends activemagiceffect

Actor Property PlayerRef Auto Const
Perk Property WLD_perk_25_hypnotist Auto
aaf:aaf_api AAF_API 

Event OnEffectStart(Actor akActor, Actor akCaster)
	Actor akActor_Target = GetActorUnderCrosshairs()
	GlobalVariable INVB_Global_hypnotis_Command_Duration = Game.GetFormFromFile(0x005B5F, "INVB_WastelandDairy.esp") as GlobalVariable
	GlobalVariable INVB_Global_hypnotis_Command_Chance = Game.GetFormFromFile(0x005B78, "INVB_WastelandDairy.esp") as GlobalVariable
	
	int random_LList = Utility.RandomInt(1, 100)
	if (random_LList <= INVB_Global_hypnotis_Command_Chance.GetValue()) && PlayerREF.HasPerk(WLD_perk_25_hypnotist)
			Actor[] Actors = new Actor[2]
			Actors[0] = PlayerREF
			Actors[1] = akActor_Target
			AAF:AAF_API:SceneSettings settings = AAF_API.GetSceneSettings()
			settings.skipWalk = true
			settings.preventFurniture = true
			settings.isNPCControlled = true
			settings.locationObject = Actors[1]
			settings.duration = INVB_Global_hypnotis_Command_Duration.GetValue()
			settings.excludeTags = "Spanking,Jackoff,Pose,Utility,Tease,Foreplay,Finish,TitJob"
			aaf:aaf_api.GetAPI().StartScene(Actors, settings)
	else
		Debug.notification(akActor_Target.GetLeveledActorBase().GetName() +" looks at you like you are a fucking creep")
	endIf
	
EndEvent

Actor Function GetActorUnderCrosshairs()
	Actor ScannedActor = LL_FourPlay.LastCrossHairActor()
	
	If ScannedActor == NONE || ScannedActor.GetDistance(PlayerRef) > 256.000
		return None
	EndIf
	Return ScannedActor
EndFunction

Function LoadAAF()
	Quest Main = Game.GetFormFromFile(0x01000F99, "AAF.esm") as quest
	AAF_API = Game.GetFormFromFile(0x01000F99, "AAF.esm") as aaf:aaf_api
	If (!AAF_API)
		Debug.Notification("Can't find AAF API.")
		Utility.wait(0.1)
	Else
		AAF_API = Main as AAF:AAF_API
		RegisterForCustomEvent(AAF_API, "OnAnimationStop")
	EndIf
EndFunction

Event OnInit()
	Self.LoadAAF()
EndEvent

Event AAF:AAF_API.OnAnimationStop(AAF:AAF_API akSender, Var[] akArgs)

	Actor Actor0 = None
	Actor Actor1 = None
	Actor[] Actors = Utility.VarToVarArray(akArgs[1]) as Actor[]
	If (Actors.length > 0)
		If (Actors[0] != PlayerREF && Actors[1] != PlayerREF)
			Actor0 = Actors[0]
			Actor1 = Actors[1]
		EndIf
	EndIf
EndEvent