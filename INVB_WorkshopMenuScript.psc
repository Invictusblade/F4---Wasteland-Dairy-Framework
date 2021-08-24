Scriptname INVB_WorkshopMenuScript extends Quest Const

FormList Property WorkshopMainMenu Auto Const

FormList Property INVB_WorkshopMenu Auto Const


Event OnQuestInit()
	RegisterForRemoteEvent(Game.GetPlayer(), "OnPlayerLoadGame")
	WorkshopMainMenu.AddForm(INVB_WorkshopMenu)
	Debug.notification("INVB_Workshop Menu installed!")
EndEvent

Event Actor.OnPlayerLoadGame(Actor actorref)
	WorkshopMainMenu.AddForm(INVB_WorkshopMenu)
EndEvent

