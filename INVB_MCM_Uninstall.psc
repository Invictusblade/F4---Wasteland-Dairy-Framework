Scriptname INVB_MCM_Uninstall extends Quest

Quest property INVB_MCM_Quest auto const
Quest property INVB_01 auto const
Quest property INVB_02 auto const
Quest property INVB_03 auto const
Quest property INVB_04 auto const
Quest property INVB_05 auto const
Quest property INVB_06 auto const
Quest property INVB_07 auto const
Quest property INVB_08 auto const
Quest property INVB_09 auto const
Quest property INVB_10 auto const

string Property ThisMod auto

Function Stop_INVB_MCM()

	Debug.MessageBox("Please exit the MCM menu to begin the stopping process.")

	While Utility.IsInMenuMode()
		Utility.Wait(1.0)
	EndWhile
	
	Debug.Notification(ThisMod+ " Stop process initiated...")

	INVB_MCM_Quest.Stop()
	INVB_01.Stop()
	INVB_02.Stop()
	INVB_03.Stop()
	INVB_04.Stop()
	INVB_05.Stop()
	INVB_06.Stop()
	INVB_07.Stop()
	INVB_08.Stop()
	INVB_09.Stop()
	INVB_10.Stop()	
	
	Debug.MessageBox(ThisMod+ " stop process complete. It is now safe to uninstall.")

EndFunction

Function Restart_INVB_MCM()

	INVB_MCM_Quest.Stop()
	INVB_MCM_Quest.Start()
	
	Debug.Notification(ThisMod+ ": MCM Reset")

EndFunction