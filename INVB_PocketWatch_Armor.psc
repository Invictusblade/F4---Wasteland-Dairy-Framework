Scriptname INVB_PocketWatch_Armor extends ObjectReference

Potion Property PocketWatch_0_Slowtime Auto Const
Potion Property PocketWatch_1_Sleep Auto Const
Potion Property PocketWatch_2_Undress  Auto Const
Potion Property PocketWatch_3_SoloAct Auto Const
Potion Property PocketWatch_4_SexAct  Auto Const
Potion Property PocketWatch_5_Invisible  Auto Const

Keyword Property kw_PocketWatch_0 Auto
Keyword Property kw_PocketWatch_1 Auto
Keyword Property kw_PocketWatch_2 Auto
Keyword Property kw_PocketWatch_3 Auto
Keyword Property kw_PocketWatch_4 Auto
Keyword Property kw_PocketWatch_5 Auto

Perk Property WLD_perk_25_hypnotist Auto


Event OnEquipped(Actor akActor)
	if akActor.HasPerk(WLD_perk_25_hypnotist)
		if akActor.wornHasKeyword(kw_PocketWatch_0)
			akActor.Additem(PocketWatch_0_Slowtime, 1, true)
		endif
		if akActor.wornHasKeyword(kw_PocketWatch_1)
			akActor.Additem(PocketWatch_1_Sleep, 1, true)
		endif
		if akActor.wornHasKeyword(kw_PocketWatch_2)
			akActor.Additem(PocketWatch_2_Undress, 1, true)
		endif
		if akActor.wornHasKeyword(kw_PocketWatch_3)
			akActor.Additem(PocketWatch_3_SoloAct, 1, true)
		endif
		if akActor.wornHasKeyword(kw_PocketWatch_4)
			akActor.Additem(PocketWatch_4_SexAct, 1, true)
		endif
		if akActor.wornHasKeyword(kw_PocketWatch_5)
			akActor.Additem(PocketWatch_5_Invisible, 1, true)
		endif
	endif
EndEvent

Event OnUnequipped(Actor akActor)
	if akActor.GetItemCount(PocketWatch_0_Slowtime)
		akActor.Removeitem(PocketWatch_0_Slowtime, 1, true)
	endif
	if akActor.GetItemCount(PocketWatch_1_Sleep)
		akActor.Removeitem(PocketWatch_1_Sleep, 1, true)
	endif
	if akActor.GetItemCount(PocketWatch_2_Undress)
		akActor.Removeitem(PocketWatch_2_Undress, 1, true)
	endif
	if akActor.GetItemCount(PocketWatch_3_SoloAct)
		akActor.Removeitem(PocketWatch_3_SoloAct, 1, true)
	endif
	if akActor.GetItemCount(PocketWatch_4_SexAct)
		akActor.Removeitem(PocketWatch_4_SexAct, 1, true)
	endif
	if akActor.GetItemCount(PocketWatch_5_Invisible)
		akActor.Removeitem(PocketWatch_5_Invisible, 1, true)
	endif
EndEvent