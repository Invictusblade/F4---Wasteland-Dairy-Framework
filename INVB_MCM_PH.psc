Scriptname INVB_MCM_PH extends Quest

Actor Property PlayerRef Auto Const

Group GlobalVariables 

GlobalVariable property INVB_MCMHasLoaded auto Const
GlobalVariable property INVB_Global_PH_01 Auto Mandatory
GlobalVariable property INVB_Global_PH_02 Auto Mandatory
GlobalVariable property INVB_Global_PH_03 Auto Mandatory
GlobalVariable property INVB_Global_PH_04 Auto Mandatory
GlobalVariable property INVB_Global_PH_05 Auto Mandatory
GlobalVariable property INVB_Global_PH_06 Auto Mandatory
GlobalVariable property INVB_Global_PH_07 Auto Mandatory
GlobalVariable property INVB_Global_PH_08 Auto Mandatory
GlobalVariable property INVB_Global_PH_09 Auto Mandatory
GlobalVariable property INVB_Global_PH_10 Auto Mandatory
GlobalVariable property INVB_Global_PH_Unique Auto Mandatory

GlobalVariable property INVB_Global_OverlayChance_BOS Auto Mandatory
GlobalVariable property INVB_Global_OverlayChance_COA Auto Mandatory
GlobalVariable property INVB_Global_OverlayChance_Custom Auto Mandatory
GlobalVariable property INVB_Global_OverlayChance_Gunner Auto Mandatory
GlobalVariable property INVB_Global_OverlayChance_Institute_Synth Auto Mandatory
GlobalVariable property INVB_Global_OverlayChance_Institute Auto Mandatory
GlobalVariable property INVB_Global_OverlayChance_MM Auto Mandatory
GlobalVariable property INVB_Global_OverlayChance_Raider Auto Mandatory
GlobalVariable property INVB_Global_OverlayChance_RR Auto Mandatory
GlobalVariable property INVB_Global_OverlayChance_Settler Auto Mandatory
GlobalVariable property INVB_Global_OverlayChance_Vault81 Auto Mandatory
GlobalVariable property INVB_Global_OverlayChance_DLC03_Female Auto Mandatory
GlobalVariable property INVB_Global_OverlayChance_DLC03_Male Auto Mandatory
GlobalVariable property INVB_Global_OverlayChance_DLC04_Pack Auto Mandatory
GlobalVariable property INVB_Global_OverlayChance_DLC04_Operators Auto Mandatory
GlobalVariable property INVB_Global_OverlayChance_DLC04_Disciples Auto Mandatory
GlobalVariable property INVB_Global_OverlayChance_DLC04_Slaves Auto Mandatory

GlobalVariable property INVB_Global_OverlayChance_BOS_Unique Auto Mandatory
GlobalVariable property INVB_Global_OverlayChance_COA_Unique Auto Mandatory
GlobalVariable property INVB_Global_OverlayChance_Custom_Unique Auto Mandatory
GlobalVariable property INVB_Global_OverlayChance_Gunner_Unique Auto Mandatory
GlobalVariable property INVB_Global_OverlayChance_Institute_Unique Auto Mandatory
GlobalVariable property INVB_Global_OverlayChance_Institute_Synth_Unique Auto Mandatory
GlobalVariable property INVB_Global_OverlayChance_MM_Unique Auto Mandatory
GlobalVariable property INVB_Global_OverlayChance_Raider_Unique Auto Mandatory
GlobalVariable property INVB_Global_OverlayChance_RR_Unique Auto Mandatory
GlobalVariable property INVB_Global_OverlayChance_Settler_Unique Auto Mandatory
GlobalVariable property INVB_Global_OverlayChance_Vault81_Unique Auto Mandatory
GlobalVariable property INVB_Global_OverlayChance_DLC03_Female_Unique Auto Mandatory
GlobalVariable property INVB_Global_OverlayChance_DLC03_Male_Unique Auto Mandatory
GlobalVariable property INVB_Global_OverlayChance_DLC04_Pack_Unique Auto Mandatory
GlobalVariable property INVB_Global_OverlayChance_DLC04_Operators_Unique Auto Mandatory
GlobalVariable property INVB_Global_OverlayChance_DLC04_Disciples_Unique Auto Mandatory
GlobalVariable property INVB_Global_OverlayChance_DLC04_Slaves_Unique Auto Mandatory

GlobalVariable property INVB_Global_OverlayChance_BOS_Choice_Hair Auto Mandatory
GlobalVariable property INVB_Global_OverlayChance_COA_Choice_Hair Auto Mandatory
GlobalVariable property INVB_Global_OverlayChance_Custom_Choice_Hair Auto Mandatory
GlobalVariable property INVB_Global_OverlayChance_Gunner_Choice_Hair Auto Mandatory
GlobalVariable property INVB_Global_OverlayChance_Institute_Choice_Hair Auto Mandatory
GlobalVariable property INVB_Global_OverlayChance_Institute_Synth_Choice_Hair Auto Mandatory
GlobalVariable property INVB_Global_OverlayChance_MM_Choice_Hair Auto Mandatory
GlobalVariable property INVB_Global_OverlayChance_Raider_Choice_Hair Auto Mandatory
GlobalVariable property INVB_Global_OverlayChance_RR_Choice_Hair Auto Mandatory
GlobalVariable property INVB_Global_OverlayChance_Settler_Choice_Hair Auto Mandatory
GlobalVariable property INVB_Global_OverlayChance_Vault81_Choice_Hair Auto Mandatory
GlobalVariable property INVB_Global_OverlayChance_DLC03_Female_Choice_Hair Auto Mandatory
GlobalVariable property INVB_Global_OverlayChance_DLC03_Male_Choice_Hair Auto Mandatory
GlobalVariable property INVB_Global_OverlayChance_DLC04_Pack_Choice_Hair Auto Mandatory
GlobalVariable property INVB_Global_OverlayChance_DLC04_Operators_Choice_Hair Auto Mandatory
GlobalVariable property INVB_Global_OverlayChance_DLC04_Disciples_Choice_Hair Auto Mandatory
GlobalVariable property INVB_Global_OverlayChance_DLC04_Slaves_Choice_Hair Auto Mandatory


GlobalVariable property INVB_Global_Debug_DeleteTattoo Auto Const Mandatory
EndGroup
String ThisMod = "INVB_OverlayFramework"

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

	LoadSetting(INVB_Global_PH_01, "fOverlay01:Misc", 0.0, 100.0)
	LoadSetting(INVB_Global_PH_02, "fOverlay02:Misc", 0.0, 100.0)
	LoadSetting(INVB_Global_PH_03, "fOverlay03:Misc", 0.0, 100.0)
	LoadSetting(INVB_Global_PH_04, "fOverlay04:Misc", 0.0, 100.0)
	LoadSetting(INVB_Global_PH_05, "fOverlay05:Misc", 0.0, 100.0)
	LoadSetting(INVB_Global_PH_06, "fOverlay06:Misc", 0.0, 100.0)
	LoadSetting(INVB_Global_PH_07, "fOverlay07:Misc", 0.0, 100.0)
	LoadSetting(INVB_Global_PH_08, "fOverlay08:Misc", 0.0, 100.0)
	LoadSetting(INVB_Global_PH_09, "fOverlay09:Misc", 0.0, 100.0)
	LoadSetting(INVB_Global_PH_10, "fOverlay10:Misc", 0.0, 100.0)
	LoadSetting(INVB_Global_PH_Unique, "fOverlayUnique:Misc", 0.0, 100.0)
	
	LoadSetting(INVB_Global_OverlayChance_BOS, "fOverlay_BOS:Overlay", 0.0, 100.0)
	LoadSetting(INVB_Global_OverlayChance_COA, "fOverlay_COA:Overlay", 0.0, 100.0)
	LoadSetting(INVB_Global_OverlayChance_Custom, "fOverlay_Custom:Overlay", 0.0, 100.0)
	LoadSetting(INVB_Global_OverlayChance_Gunner, "fOverlay_Gunner:Overlay", 0.0, 100.0)
	LoadSetting(INVB_Global_OverlayChance_Institute, "fOverlay_Institute:Overlay", 0.0, 100.0)
	LoadSetting(INVB_Global_OverlayChance_Institute_Synth, "fOverlay_Institute_Synth:Overlay", 0.0, 100.0)
	LoadSetting(INVB_Global_OverlayChance_MM, "fOverlay_MM:Overlay", 0.0, 100.0)
	LoadSetting(INVB_Global_OverlayChance_Raider, "fOverlay_Raider:Overlay", 0.0, 100.0)
	LoadSetting(INVB_Global_OverlayChance_RR, "fOverlay_RR:Overlay", 0.0, 100.0)
	LoadSetting(INVB_Global_OverlayChance_Settler, "fOverlay_Settler:Overlay", 0.0, 100.0)
	LoadSetting(INVB_Global_OverlayChance_Vault81, "fOverlay_Vault81:Overlay", 0.0, 100.0)
	LoadSetting(INVB_Global_OverlayChance_DLC03_Female, "fOverlay_DLC03_Female:Overlay", 0.0, 100.0)
	LoadSetting(INVB_Global_OverlayChance_DLC03_Male, "fOverlay_DLC03_Male:Overlay", 0.0, 100.0)
	LoadSetting(INVB_Global_OverlayChance_DLC04_Pack, "fOverlay_DLC04_Pack:Overlay", 0.0, 100.0)
	LoadSetting(INVB_Global_OverlayChance_DLC04_Operators, "fOverlay_DLC04_Operators:Overlay", 0.0, 100.0)
	LoadSetting(INVB_Global_OverlayChance_DLC04_Disciples, "fOverlay_DLC04_Disciples:Overlay", 0.0, 100.0)
	LoadSetting(INVB_Global_OverlayChance_DLC04_Slaves, "fOverlay_DLC04_Slaves:Overlay", 0.0, 100.0)
	
	
	LoadSetting(INVB_Global_OverlayChance_BOS_Unique, "fOverlay_BOS_Unique:Overlay", 0.0, 6.0)
	LoadSetting(INVB_Global_OverlayChance_COA_Unique, "fOverlay_COA_Unique:Overlay", 0.0, 6.0)
	LoadSetting(INVB_Global_OverlayChance_Custom_Unique, "fOverlay_Custom_Unique:Overlay", 0.0, 6.0)
	LoadSetting(INVB_Global_OverlayChance_Gunner_Unique, "fOverlay_Gunner_Unique:Overlay", 0.0, 6.0)
	LoadSetting(INVB_Global_OverlayChance_Institute_Unique, "fOverlay_Institute_Unique:Overlay", 0.0, 6.0)
	LoadSetting(INVB_Global_OverlayChance_Institute_Synth_Unique, "fOverlay_Institute_Synth_Unique:Overlay", 0.0, 6.0)
	LoadSetting(INVB_Global_OverlayChance_MM_Unique, "fOverlay_MM_Unique:Overlay", 0.0, 6.0)
	LoadSetting(INVB_Global_OverlayChance_Raider_Unique, "fOverlay_Raider_Unique:Overlay", 0.0, 6.0)
	LoadSetting(INVB_Global_OverlayChance_RR_Unique, "fOverlay_RR_Unique:Overlay", 0.0, 6.0)
	LoadSetting(INVB_Global_OverlayChance_Settler_Unique, "fOverlay_Settler_Unique:Overlay", 0.0, 6.0)
	LoadSetting(INVB_Global_OverlayChance_Vault81_Unique, "fOverlay_Vault81_Unique:Overlay", 0.0, 6.0)
	LoadSetting(INVB_Global_OverlayChance_DLC03_Female_Unique, "fOverlay_DLC03_Female_Unique:Overlay", 0.0, 6.0)
	LoadSetting(INVB_Global_OverlayChance_DLC03_Male_Unique, "fOverlay_DLC03_Male_Unique:Overlay", 0.0, 6.0)
	LoadSetting(INVB_Global_OverlayChance_DLC04_Pack_Unique, "fOverlay_DLC04_Pack_Unique:Overlay", 0.0, 6.0)
	LoadSetting(INVB_Global_OverlayChance_DLC04_Operators_Unique, "fOverlay_DLC04_Operators_Unique:Overlay", 0.0, 6.0)
	LoadSetting(INVB_Global_OverlayChance_DLC04_Disciples_Unique, "fOverlay_DLC04_Disciples_Unique:Overlay", 0.0, 6.0)
	LoadSetting(INVB_Global_OverlayChance_DLC04_Slaves_Unique, "fOverlay_DLC04_Slaves_Unique:Overlay", 0.0, 6.0)

	LoadSetting(INVB_Global_OverlayChance_BOS_Choice_Hair, "fOverlay_BOS_Hair:Overlay", 0.0, 1.0)
	LoadSetting(INVB_Global_OverlayChance_COA_Choice_Hair, "fOverlay_COA_Hair:Overlay", 0.0, 1.0)
	LoadSetting(INVB_Global_OverlayChance_Custom_Choice_Hair, "fOverlay_Custom_Hair:Overlay", 0.0, 1.0)
	LoadSetting(INVB_Global_OverlayChance_Gunner_Choice_Hair, "fOverlay_Gunner_Hair:Overlay", 0.0, 1.0)
	LoadSetting(INVB_Global_OverlayChance_Institute_Choice_Hair, "fOverlay_Institute_Hair:Overlay", 0.0, 1.0)
	LoadSetting(INVB_Global_OverlayChance_Institute_Synth_Choice_Hair, "fOverlay_Institute_Synth_Hair:Overlay", 0.0, 1.0)
	LoadSetting(INVB_Global_OverlayChance_MM_Choice_Hair, "fOverlay_MM_Hair:Overlay", 0.0, 1.0)
	LoadSetting(INVB_Global_OverlayChance_Raider_Choice_Hair, "fOverlay_Raider_Hair:Overlay", 0.0, 1.0)
	LoadSetting(INVB_Global_OverlayChance_RR_Choice_Hair, "fOverlay_RR_Hair:Overlay", 0.0, 1.0)
	LoadSetting(INVB_Global_OverlayChance_Settler_Choice_Hair, "fOverlay_Settler_Hair:Overlay", 0.0, 1.0)
	LoadSetting(INVB_Global_OverlayChance_Vault81_Choice_Hair, "fOverlay_Vault81_Hair:Overlay", 0.0, 1.0)
	LoadSetting(INVB_Global_OverlayChance_DLC03_Female_Choice_Hair, "fOverlay_DLC03_Female_Hair:Overlay", 0.0, 1.0)
	LoadSetting(INVB_Global_OverlayChance_DLC03_Male_Choice_Hair, "fOverlay_DLC03_Male_Hair:Overlay", 0.0, 1.0)
	LoadSetting(INVB_Global_OverlayChance_DLC04_Pack_Choice_Hair, "fOverlay_DLC04_Pack_Hair:Overlay", 0.0, 1.0)
	LoadSetting(INVB_Global_OverlayChance_DLC04_Operators_Choice_Hair, "fOverlay_DLC04_Operators_Hair:Overlay", 0.0, 1.0)
	LoadSetting(INVB_Global_OverlayChance_DLC04_Disciples_Choice_Hair, "fOverlay_DLC04_Disciples_Hair:Overlay", 0.0, 1.0)
	LoadSetting(INVB_Global_OverlayChance_DLC04_Slaves_Choice_Hair, "fOverlay_DLC04_Slaves_Hair:Overlay", 0.0, 1.0)	
	
	LoadSetting(INVB_Global_Debug_DeleteTattoo, "fOverlay_Debug_DeleteTattoo:Misc", 0.0, 1.0)	
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