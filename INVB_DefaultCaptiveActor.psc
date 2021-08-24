Scriptname INVB_DefaultCaptiveActor extends Actor

;This script pops a message box when activating the prisoner
;if player frees, adds captors, himself, and prisoner to factions to make people hate each other
;You should make sure elsewhere that the captors have aggression high enough to attack their enemies


Group MainProperties
	bool Property DisableOnUnload = false Auto Const
	{after being freed, this actor will disable when unloaded}
	bool Property AlsoRemoveFromCaptiveFaction = false Auto Const
	{after being freed, this actor will also be removed from the CaptiveFaction
		Use this for actors that will be attacked while fleeing}
	int Property AggressionAfterFreed = -1 Auto Const
	{freed actor will be set with this aggression}
EndGroup

Group SetStageProperties
	Quest Property myQuest Auto
	{ If this is set, set the stage on this quest if StageToSetWhenFreed is not -1
		If myQuest is NOT set, it will try to set the stage on the owning quest}
	int Property StageToSetWhenFreed = -1 auto const
	{ this stage will be set when the prisoner is freed }
	int Property StageToSetOnCleanUp = -1 Auto Const
	{ this stage will be set when we try to clean up the actor }
	bool Property bSetStageOnlyIfPlayerFreed = true auto const
	{ false is always set stage when prisoner is freed }

EndGroup

Group CleanUpProperties
	Float Property CleanUpTime = 180.0 Auto
	{ Timer is started after freeing this prisoner, then once it has expired, clean up is viable when possible}
EndGroup

Group AutoFillProperties
	Keyword Property RESharedDialoguePrisonerSetFree Auto const

	Message Property REPrisonerMessageBox Auto const
	Faction Property BoundCaptiveFaction Auto const
	Faction Property CaptiveFaction Auto Const

	RefCollectionAlias Property Captors Auto const
	{ Try to get this from quest script REScript }
EndGroup



bool bound = True

int iDoNothing = 0
int iSetFree = 1
int iSetFreeShareItems = 2
int CleanupTimerID = 999
bool ReadyToCleanup = false

Event OnInit()
	AddToFaction(BoundCaptiveFaction)
EndEvent

Event OnLoad()
	if bound
		; TODO when we have it
		;playIdle(OffsetBoundStandingStart)

		;DL added this for short term use
		SetRestrained()
		SetFactionRank(BoundCaptiveFaction, 0)
	EndIf
	RegisterForHitEvent(self, Game.GetPlayer())
EndEvent

Event OnUnload()
	if DisableOnUnload && ReadyToCleanup
		ClearFactions()
		Disable()
		DeleteWhenAble()
	endif
EndEvent

Event OnTimer(int aiTimerID)
	if aiTimerID == CleanupTimerID
		ReadyToCleanup = true
	endif
EndEvent

Event OnActivate(ObjectReference akActionRef)

	if IsDead() || IsinCombat()
 		debug.trace(self + "OnActivate() IsDead() or IsInCombat() so not showing message box")	
	
	Elseif Bound == true	
 		debug.trace(self + "OnActivate() will call show message box")	
		Actor ActorRef = self

		int result = REPrisonerMessageBox.show()

		if result == iDoNothing
			debug.Notification("DO NOTHING")
			
		elseif result == iSetFree
			debug.Notification("SET FREE")	
			FreePrisoner(ActorRef, OpenPrisonerInventory = False)
			
		elseif result == iSetFreeShareItems
			debug.Notification("SET FREE SHARE ITEMS")	
			FreePrisoner(ActorRef, OpenPrisonerInventory = True)		
			
		EndIf
	
	EndIf
EndEvent

Event OnHit(ObjectReference akTarget, ObjectReference akAggressor, Form akSource, Projectile akProjectile, bool abPowerAttack, bool abSneakAttack, bool abBashAttack, bool abHitBlocked, string asMaterialName)
  	if AkAggressor == game.getPlayer()
		;Game.GetPlayer().AddToFaction(REPrisonerFreedCombatPrisonerFaction)
		;AddRemoveCaptorFaction(REPrisonerFreedCombatCaptorFaction)
	endif
	RegisterForHitEvent(self, Game.GetPlayer())
endEvent


Function FreePrisoner(Actor ActorRef, bool playerIsLiberator= true, bool OpenPrisonerInventory = False)
 	debug.trace(self + "FreePrisoner(" + ActorRef + "," + playerIsLiberator + ", " + OpenPrisonerInventory +")")	
	ActorRef.SetFactionRank(BoundCaptiveFaction, 1)

	if AlsoRemoveFromCaptiveFaction
		ActorRef.RemoveFromFaction(CaptiveFaction)
	endif

	;DL added this for short term use
	SetRestrained(false)

	ActorRef.EvaluatePackage()
	if playerIsLiberator
		;Game.GetPlayer().AddToFaction(REPrisonerFreedCombatPrisonerFaction)
	EndIf
	
	if OpenPrisonerInventory
		ActorRef.openInventory(True)
	EndIf
	
	ActorRef.SayCustom(RESharedDialoguePrisonerSetFree)
	bound = False

	;AddRemoveCaptorFaction(REPrisonerFreedCombatCaptorFaction)
	
	if StageToSetWhenFreed > -1
		if playerIsLiberator || bSetStageOnlyIfPlayerFreed == false
			if myQuest
				myQuest.SetStage(StageToSetWhenFreed)
			else
				;GetOwningQuest().SetStage(StageToSetWhenFreed)
			endif
		endif
	endif
	ActorRef.EvaluatePackage()

	;Start The clean up timer, actor will not be clean up till after this
	StartTimer(CleanUpTime, CleanupTimerID)
EndFunction

;call when quest shuts down
Function ClearFactions()

	;Game.GetPlayer().RemoveFromFaction(REPrisonerFreedCombatPrisonerFaction)
	RemoveFromFaction(BoundCaptiveFaction)
	;TryToRemoveFromFaction(REPrisonerFreedCombatCaptorFaction)
	
	;AddRemoveCaptorFaction(REPrisonerFreedCombatCaptorFaction, false)

	if StageToSetOnCleanUp > -1
		if bSetStageOnlyIfPlayerFreed == false
			if myQuest
				myQuest.SetStage(StageToSetOnCleanUp)
			else
				;GetOwningQuest().SetStage(StageToSetOnCleanUp)
			endif
		endif
	endif
EndFunction






