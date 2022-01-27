Scriptname INVB_WorkShop_Adder extends ObjectReference

INVB_QuestScript Property varTrigger Auto Const
GlobalVariable property INVB_Global_Gift_Amount Auto Mandatory
bool Property Got_Milk Auto
GlobalVariable property INVB_Global_Milking_Time_Type Auto Const Mandatory
GlobalVariable property INVB_Global_Gift_GameHours Auto Mandatory




Event OnInit()
	if INVB_Global_Milking_Time_Type.GetValue() == 1
		RegisterForCustomEvent(varTrigger, "TriggerCollection")
	;	Debug.Notification("Registered for event!")
	else
		MilkingTime()
	endif

EndEvent

Event INVB_QuestScript.TriggerCollection(INVB_QuestScript varSender, Var[] varArgs)
;	debug.notification("Event recieved!")

	if canproduceforworkshop() == true
		if Got_Milk == true
			GetLinkedRef(varKeyword).AddItem(varItems, INVB_Global_Gift_Amount.getvalue() as int *2)
		else
			GetLinkedRef(varKeyword).AddItem(varItems, INVB_Global_Gift_Amount.getvalue() as int)
		endif
		
;		debug.notification("produced")
	endif

	RegisterForCustomEvent(varTrigger, "TriggerCollection")
EndEvent


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

Function MilkingAction()
		if canproduceforworkshop() == true
			if Got_Milk == true
				GetLinkedRef(varKeyword).AddItem(varItems, INVB_Global_Gift_Amount.getvalue() as int *2)
			else
				GetLinkedRef(varKeyword).AddItem(varItems, INVB_Global_Gift_Amount.getvalue() as int)
			endif
			
	;		debug.notification("produced")
		endif
EndFunction



Keyword Property varKeyword Auto Const


LeveledItem Property varItems Auto Const
{Sets what leveled list to roll from}
