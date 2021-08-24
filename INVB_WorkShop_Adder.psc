Scriptname INVB_WorkShop_Adder extends ObjectReference

INVB_QuestScript Property varTrigger Auto Const
GlobalVariable property INVB_Global_Gift_Amount Auto Mandatory
bool Property Got_Milk Auto

Event OnInit()
	RegisterForCustomEvent(varTrigger, "TriggerCollection")
;	Debug.Notification("Registered for event!")
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

Keyword Property varKeyword Auto Const


LeveledItem Property varItems Auto Const
{Sets what leveled list to roll from}
