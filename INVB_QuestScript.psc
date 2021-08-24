Scriptname INVB_QuestScript extends Quest

CustomEvent TriggerCollection
GlobalVariable property INVB_Global_Gift_GameHours Auto Mandatory
int Property int_aiTimerID auto

Event onInit()
	StartTimerGameTime(0.1, int_aiTimerID)
EndEvent

Event OnTimerGameTime(int aiTimerID)
	
	StartTimerGameTime(INVB_Global_Gift_GameHours.getvalue(), int_aiTimerID)
	SendCustomEvent("TriggerCollection")
	if valTesting == 1
		debug.notification("Quest - fired collection and looping")
	endIf
EndEvent
Int Property valTesting = 0 Auto Const
{set 1 for debug messages.}
