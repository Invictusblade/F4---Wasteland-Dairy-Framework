Scriptname INVB_MCM_PH_C extends Quest

Actor Property PlayerRef Auto Const

Group GlobalVariables 

GlobalVariable property INVB_MCMHasLoaded auto Const

GlobalVariable property INVB_Global_OverlayChance_Custom01 Auto Mandatory
GlobalVariable property INVB_Global_OverlayChance_Custom02 Auto Mandatory
GlobalVariable property INVB_Global_OverlayChance_Custom03 Auto Mandatory
GlobalVariable property INVB_Global_OverlayChance_Custom04 Auto Mandatory
GlobalVariable property INVB_Global_OverlayChance_Custom05 Auto Mandatory
GlobalVariable property INVB_Global_OverlayChance_Custom06 Auto Mandatory
GlobalVariable property INVB_Global_OverlayChance_Custom07 Auto Mandatory
GlobalVariable property INVB_Global_OverlayChance_Custom08 Auto Mandatory
GlobalVariable property INVB_Global_OverlayChance_Custom09 Auto Mandatory
GlobalVariable property INVB_Global_OverlayChance_Custom10 Auto Mandatory
GlobalVariable property INVB_Global_OverlayChance_Custom11 Auto Mandatory
GlobalVariable property INVB_Global_OverlayChance_Custom12 Auto Mandatory
GlobalVariable property INVB_Global_OverlayChance_Custom13 Auto Mandatory
GlobalVariable property INVB_Global_OverlayChance_Custom14 Auto Mandatory
GlobalVariable property INVB_Global_OverlayChance_Custom15 Auto Mandatory
GlobalVariable property INVB_Global_OverlayChance_Custom16 Auto Mandatory
GlobalVariable property INVB_Global_OverlayChance_Custom17 Auto Mandatory
GlobalVariable property INVB_Global_OverlayChance_Custom18 Auto Mandatory
GlobalVariable property INVB_Global_OverlayChance_Custom19 Auto Mandatory
GlobalVariable property INVB_Global_OverlayChance_Custom20 Auto Mandatory


GlobalVariable property INVB_Global_OverlayChance_Custom01_choice Auto Mandatory
GlobalVariable property INVB_Global_OverlayChance_Custom02_choice Auto Mandatory
GlobalVariable property INVB_Global_OverlayChance_Custom03_choice Auto Mandatory
GlobalVariable property INVB_Global_OverlayChance_Custom04_choice Auto Mandatory
GlobalVariable property INVB_Global_OverlayChance_Custom05_choice Auto Mandatory
GlobalVariable property INVB_Global_OverlayChance_Custom06_choice Auto Mandatory
GlobalVariable property INVB_Global_OverlayChance_Custom07_choice Auto Mandatory
GlobalVariable property INVB_Global_OverlayChance_Custom08_choice Auto Mandatory
GlobalVariable property INVB_Global_OverlayChance_Custom09_choice Auto Mandatory
GlobalVariable property INVB_Global_OverlayChance_Custom10_choice Auto Mandatory
GlobalVariable property INVB_Global_OverlayChance_Custom11_choice Auto Mandatory
GlobalVariable property INVB_Global_OverlayChance_Custom12_choice Auto Mandatory
GlobalVariable property INVB_Global_OverlayChance_Custom13_choice Auto Mandatory
GlobalVariable property INVB_Global_OverlayChance_Custom14_choice Auto Mandatory
GlobalVariable property INVB_Global_OverlayChance_Custom15_choice Auto Mandatory
GlobalVariable property INVB_Global_OverlayChance_Custom16_choice Auto Mandatory
GlobalVariable property INVB_Global_OverlayChance_Custom17_choice Auto Mandatory
GlobalVariable property INVB_Global_OverlayChance_Custom18_choice Auto Mandatory
GlobalVariable property INVB_Global_OverlayChance_Custom19_choice Auto Mandatory
GlobalVariable property INVB_Global_OverlayChance_Custom20_choice Auto Mandatory


GlobalVariable property INVB_Global_OverlayChance_Custom01_Choice_Hair Auto Mandatory
GlobalVariable property INVB_Global_OverlayChance_Custom02_Choice_Hair Auto Mandatory
GlobalVariable property INVB_Global_OverlayChance_Custom03_Choice_Hair Auto Mandatory
GlobalVariable property INVB_Global_OverlayChance_Custom04_Choice_Hair Auto Mandatory
GlobalVariable property INVB_Global_OverlayChance_Custom05_Choice_Hair Auto Mandatory
GlobalVariable property INVB_Global_OverlayChance_Custom06_Choice_Hair Auto Mandatory
GlobalVariable property INVB_Global_OverlayChance_Custom07_Choice_Hair Auto Mandatory
GlobalVariable property INVB_Global_OverlayChance_Custom08_Choice_Hair Auto Mandatory
GlobalVariable property INVB_Global_OverlayChance_Custom09_Choice_Hair Auto Mandatory
GlobalVariable property INVB_Global_OverlayChance_Custom10_Choice_Hair Auto Mandatory
GlobalVariable property INVB_Global_OverlayChance_Custom11_Choice_Hair Auto Mandatory
GlobalVariable property INVB_Global_OverlayChance_Custom12_Choice_Hair Auto Mandatory
GlobalVariable property INVB_Global_OverlayChance_Custom13_Choice_Hair Auto Mandatory
GlobalVariable property INVB_Global_OverlayChance_Custom14_Choice_Hair Auto Mandatory
GlobalVariable property INVB_Global_OverlayChance_Custom15_Choice_Hair Auto Mandatory
GlobalVariable property INVB_Global_OverlayChance_Custom16_Choice_Hair Auto Mandatory
GlobalVariable property INVB_Global_OverlayChance_Custom17_Choice_Hair Auto Mandatory
GlobalVariable property INVB_Global_OverlayChance_Custom18_Choice_Hair Auto Mandatory
GlobalVariable property INVB_Global_OverlayChance_Custom19_Choice_Hair Auto Mandatory
GlobalVariable property INVB_Global_OverlayChance_Custom20_Choice_Hair Auto Mandatory


EndGroup
string Property ThisMod auto

Event OnQuestInit()

	INVB_MCMHasLoaded.SetValue(0)

	If CheckForMCM(true)
	
		UpdateSettings(true)
	
	EndIf
	
	RegisterForRemoteEvent(PlayerRef, "OnPlayerLoadGame")

	RegisterForExternalEvent("OnMCMSettingChange|"+ThisMod, "OnMCMSettingChange")
	
	INVB_MCMHasLoaded.SetValue(1)

EndEvent

Function OnMCMSettingChange(string modName, string id)
	UnregisterForExternalEvent("OnMCMSettingChange|"+ThisMod)
	If modName == ThisMod	
		UpdateSettings()
	EndIf
	RegisterForExternalEvent("OnMCMSettingChange|"+ThisMod, "OnMCMSettingChange")
EndFunction

Function UpdateSettings(bool firstLoad = false)
	LoadSetting(INVB_Global_OverlayChance_Custom01, "fOverlay_Custom01:Overlay", 0.0, 100.0)
	LoadSetting(INVB_Global_OverlayChance_Custom02, "fOverlay_Custom02:Overlay", 0.0, 100.0)
	LoadSetting(INVB_Global_OverlayChance_Custom03, "fOverlay_Custom03:Overlay", 0.0, 100.0)
	LoadSetting(INVB_Global_OverlayChance_Custom04, "fOverlay_Custom04:Overlay", 0.0, 100.0)
	LoadSetting(INVB_Global_OverlayChance_Custom05, "fOverlay_Custom05:Overlay", 0.0, 100.0)
	LoadSetting(INVB_Global_OverlayChance_Custom06, "fOverlay_Custom06:Overlay", 0.0, 100.0)
	LoadSetting(INVB_Global_OverlayChance_Custom07, "fOverlay_Custom07:Overlay", 0.0, 100.0)
	LoadSetting(INVB_Global_OverlayChance_Custom08, "fOverlay_Custom08:Overlay", 0.0, 100.0)
	LoadSetting(INVB_Global_OverlayChance_Custom09, "fOverlay_Custom09:Overlay", 0.0, 100.0)
	LoadSetting(INVB_Global_OverlayChance_Custom10, "fOverlay_Custom10:Overlay", 0.0, 100.0)
	LoadSetting(INVB_Global_OverlayChance_Custom11, "fOverlay_Custom11:Overlay", 0.0, 100.0)
	LoadSetting(INVB_Global_OverlayChance_Custom12, "fOverlay_Custom12:Overlay", 0.0, 100.0)
	LoadSetting(INVB_Global_OverlayChance_Custom13, "fOverlay_Custom13:Overlay", 0.0, 100.0)
	LoadSetting(INVB_Global_OverlayChance_Custom14, "fOverlay_Custom14:Overlay", 0.0, 100.0)
	LoadSetting(INVB_Global_OverlayChance_Custom15, "fOverlay_Custom15:Overlay", 0.0, 100.0)
	LoadSetting(INVB_Global_OverlayChance_Custom16, "fOverlay_Custom16:Overlay", 0.0, 100.0)
	LoadSetting(INVB_Global_OverlayChance_Custom17, "fOverlay_Custom17:Overlay", 0.0, 100.0)
	LoadSetting(INVB_Global_OverlayChance_Custom18, "fOverlay_Custom18:Overlay", 0.0, 100.0)
	LoadSetting(INVB_Global_OverlayChance_Custom19, "fOverlay_Custom19:Overlay", 0.0, 100.0)
	LoadSetting(INVB_Global_OverlayChance_Custom20, "fOverlay_Custom20:Overlay", 0.0, 100.0)
	
	LoadSetting(INVB_Global_OverlayChance_Custom01_Choice, "fOverlay_Custom01_Choice:Overlay", 0.0, 6.0)
	LoadSetting(INVB_Global_OverlayChance_Custom02_Choice, "fOverlay_Custom02_Choice:Overlay", 0.0, 6.0)
	LoadSetting(INVB_Global_OverlayChance_Custom03_Choice, "fOverlay_Custom03_Choice:Overlay", 0.0, 6.0)
	LoadSetting(INVB_Global_OverlayChance_Custom04_Choice, "fOverlay_Custom04_Choice:Overlay", 0.0, 6.0)
	LoadSetting(INVB_Global_OverlayChance_Custom05_Choice, "fOverlay_Custom05_Choice:Overlay", 0.0, 6.0)
	LoadSetting(INVB_Global_OverlayChance_Custom06_Choice, "fOverlay_Custom06_Choice:Overlay", 0.0, 6.0)
	LoadSetting(INVB_Global_OverlayChance_Custom07_Choice, "fOverlay_Custom07_Choice:Overlay", 0.0, 6.0)
	LoadSetting(INVB_Global_OverlayChance_Custom08_Choice, "fOverlay_Custom08_Choice:Overlay", 0.0, 6.0)
	LoadSetting(INVB_Global_OverlayChance_Custom09_Choice, "fOverlay_Custom09_Choice:Overlay", 0.0, 6.0)
	LoadSetting(INVB_Global_OverlayChance_Custom10_Choice, "fOverlay_Custom10_Choice:Overlay", 0.0, 6.0)
	LoadSetting(INVB_Global_OverlayChance_Custom11_Choice, "fOverlay_Custom11_Choice:Overlay", 0.0, 6.0)
	LoadSetting(INVB_Global_OverlayChance_Custom12_Choice, "fOverlay_Custom12_Choice:Overlay", 0.0, 6.0)
	LoadSetting(INVB_Global_OverlayChance_Custom13_Choice, "fOverlay_Custom13_Choice:Overlay", 0.0, 6.0)
	LoadSetting(INVB_Global_OverlayChance_Custom14_Choice, "fOverlay_Custom14_Choice:Overlay", 0.0, 6.0)
	LoadSetting(INVB_Global_OverlayChance_Custom15_Choice, "fOverlay_Custom15_Choice:Overlay", 0.0, 6.0)
	LoadSetting(INVB_Global_OverlayChance_Custom16_Choice, "fOverlay_Custom16_Choice:Overlay", 0.0, 6.0)
	LoadSetting(INVB_Global_OverlayChance_Custom17_Choice, "fOverlay_Custom17_Choice:Overlay", 0.0, 6.0)
	LoadSetting(INVB_Global_OverlayChance_Custom18_Choice, "fOverlay_Custom18_Choice:Overlay", 0.0, 6.0)
	LoadSetting(INVB_Global_OverlayChance_Custom19_Choice, "fOverlay_Custom19_Choice:Overlay", 0.0, 6.0)
	LoadSetting(INVB_Global_OverlayChance_Custom20_Choice, "fOverlay_Custom20_Choice:Overlay", 0.0, 6.0)
	
	LoadSetting(INVB_Global_OverlayChance_Custom01_Choice_Hair, "fOverlay_Custom01_Hair:Overlay", 0.0, 1.0)
	LoadSetting(INVB_Global_OverlayChance_Custom02_Choice_Hair, "fOverlay_Custom02_Hair:Overlay", 0.0, 1.0)
	LoadSetting(INVB_Global_OverlayChance_Custom03_Choice_Hair, "fOverlay_Custom03_Hair:Overlay", 0.0, 1.0)
	LoadSetting(INVB_Global_OverlayChance_Custom04_Choice_Hair, "fOverlay_Custom04_Hair:Overlay", 0.0, 1.0)
	LoadSetting(INVB_Global_OverlayChance_Custom05_Choice_Hair, "fOverlay_Custom05_Hair:Overlay", 0.0, 1.0)
	LoadSetting(INVB_Global_OverlayChance_Custom06_Choice_Hair, "fOverlay_Custom06_Hair:Overlay", 0.0, 1.0)
	LoadSetting(INVB_Global_OverlayChance_Custom07_Choice_Hair, "fOverlay_Custom07_Hair:Overlay", 0.0, 1.0)
	LoadSetting(INVB_Global_OverlayChance_Custom08_Choice_Hair, "fOverlay_Custom08_Hair:Overlay", 0.0, 1.0)
	LoadSetting(INVB_Global_OverlayChance_Custom09_Choice_Hair, "fOverlay_Custom09_Hair:Overlay", 0.0, 1.0)
	LoadSetting(INVB_Global_OverlayChance_Custom10_Choice_Hair, "fOverlay_Custom10_Hair:Overlay", 0.0, 1.0)
	LoadSetting(INVB_Global_OverlayChance_Custom11_Choice_Hair, "fOverlay_Custom11_Hair:Overlay", 0.0, 1.0)
	LoadSetting(INVB_Global_OverlayChance_Custom12_Choice_Hair, "fOverlay_Custom12_Hair:Overlay", 0.0, 1.0)
	LoadSetting(INVB_Global_OverlayChance_Custom13_Choice_Hair, "fOverlay_Custom13_Hair:Overlay", 0.0, 1.0)
	LoadSetting(INVB_Global_OverlayChance_Custom14_Choice_Hair, "fOverlay_Custom14_Hair:Overlay", 0.0, 1.0)
	LoadSetting(INVB_Global_OverlayChance_Custom15_Choice_Hair, "fOverlay_Custom15_Hair:Overlay", 0.0, 1.0)
	LoadSetting(INVB_Global_OverlayChance_Custom16_Choice_Hair, "fOverlay_Custom16_Hair:Overlay", 0.0, 1.0)
	LoadSetting(INVB_Global_OverlayChance_Custom17_Choice_Hair, "fOverlay_Custom17_Hair:Overlay", 0.0, 1.0)
	LoadSetting(INVB_Global_OverlayChance_Custom18_Choice_Hair, "fOverlay_Custom18_Hair:Overlay", 0.0, 1.0)
	LoadSetting(INVB_Global_OverlayChance_Custom19_Choice_Hair, "fOverlay_Custom19_Hair:Overlay", 0.0, 1.0)
	LoadSetting(INVB_Global_OverlayChance_Custom20_Choice_Hair, "fOverlay_Custom20_Hair:Overlay", 0.0, 1.0)
	
EndFunction

Function LoadSetting(GlobalVariable akGlobal, string asSetting, float afMin, float afMax)

	float settingBuffer = MCM.GetModSettingFloat(ThisMod, asSetting)
	
	If settingBuffer != akGlobal.GetValue() ;1.15 - If the value changed

		If settingBuffer <= afMax && settingBuffer >= afMin ; The setting is within the range of values 
	
			akGlobal.SetValue(settingBuffer)
	
		ElseIf settingBuffer < afMin ; The setting is improperly less than the minimum
	
			akGlobal.SetValue(afMin)
		
			MCM.SetModSettingFloat(ThisMod, asSetting, afMin)
	
		ElseIf settingBuffer > afMax ; The setting is improperly greater than the max
	
			akGlobal.SetValue(afMax)
		
			MCM.SetModSettingFloat(ThisMod, asSetting, afMax)
	
		EndIf
		
	EndIf

EndFunction

Event Actor.OnPlayerLoadGame(Actor akSender)

	If CheckForMCM()
		UpdateSettings()
	EndIf

EndEvent

bool Function CheckForMCM(bool FirstLoad = false)

	If !MCM.IsInstalled()
	
		If FirstLoad
			
			Utility.Wait(1.0)
			DEBUG.Notification("Invictusblade Tattoo_krisser143: Please install Mod Configuration Menu.")

			
		Else
		
			DEBUG.MessageBox("Invictusblade Tattoo_krisser143: Please re-install Mod Configuration Menu.")
		
		EndIf
		
		Return False
	
	EndIf
	
	Return True

EndFunction