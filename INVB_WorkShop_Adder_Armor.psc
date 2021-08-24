Scriptname INVB_WorkShop_Adder_Armor extends ObjectReference

Actor target
INVB_QuestScript Property varTrigger Auto Const
GlobalVariable property INVB_Global_Gift_Amount Auto Mandatory

Event OnEquipped(Actor akActor)

	target = akActor
	If akActor != Game.GetPlayer()
		RegisterForCustomEvent(varTrigger, "TriggerCollection")
;	Debug.Notification("Registered for event!")
	endif
EndEvent

Event INVB_QuestScript.TriggerCollection(INVB_QuestScript varSender, Var[] varArgs)
;	debug.notification("Event recieved!")

	target.AddItem(varItems, INVB_Global_Gift_Amount.getvalue() as int)

	RegisterForCustomEvent(varTrigger, "TriggerCollection")
EndEvent

LeveledItem Property varItems Auto Const
{Sets what leveled list to roll from}
