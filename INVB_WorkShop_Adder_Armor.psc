Scriptname INVB_WorkShop_Adder_Armor extends ObjectReference

Actor target
INVB_QuestScript Property varTrigger Auto Const
GlobalVariable property INVB_Global_Gift_Amount Auto Mandatory
GlobalVariable property INVB_Global_Milking_Time_Type Auto Const Mandatory
GlobalVariable property INVB_Global_Gift_GameHours Auto Mandatory




Event OnEquipped(Actor akActor)

	target = akActor
	If akActor != Game.GetPlayer()
		if INVB_Global_Milking_Time_Type.GetValue() == 1
			RegisterForCustomEvent(varTrigger, "TriggerCollection")
		;	Debug.Notification("Registered for event!")
		else
			MilkingTime()
		endif
	endif
EndEvent



Event INVB_QuestScript.TriggerCollection(INVB_QuestScript varSender, Var[] varArgs)
;	debug.notification("Event recieved!")

	target.AddItem(varItems, INVB_Global_Gift_Amount.getvalue() as int)

	RegisterForCustomEvent(varTrigger, "TriggerCollection")
EndEvent



Function MilkingAction()
	target.AddItem(varItems, INVB_Global_Gift_Amount.getvalue() as int)
EndFunction

Function MilkingTime()
	Utility.WaitGameTime(GetUpdateTime())
	MilkingAction()
EndFunction


Float Function GetUpdateTime()
	float time_milking = INVB_Global_Gift_GameHours.getvalue()
	
	If time_milking > 0
		return time_milking
	Else
		return 24.0
	EndIf
	
EndFunction

LeveledItem Property varItems Auto Const
{Sets what leveled list to roll from}
