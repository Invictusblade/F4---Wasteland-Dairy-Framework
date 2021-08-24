ScriptName INVB_MadCow Extends Actor

INVB_QuestScript Property varTrigger Auto Const
GlobalVariable property INVB_Global_Gift_Amount Auto Mandatory

Event OnInit()
	RegisterForCustomEvent(varTrigger, "TriggerCollection")
;	Debug.Notification("Registered for event!")
EndEvent

Event INVB_QuestScript.TriggerCollection(INVB_QuestScript varSender, Var[] varArgs)
;	debug.notification("Event recieved!")

	if canproduceforworkshop() == true
		GetLinkedRef(varKeyword).AddItem(varItems, INVB_Global_Gift_Amount.getvalue() as int)

		
;		debug.notification("produced")
	endif

	RegisterForCustomEvent(varTrigger, "TriggerCollection")
EndEvent

Keyword Property varKeyword Auto Const


Form Property varItems Auto Const
{Sets what leveled list to roll from}
