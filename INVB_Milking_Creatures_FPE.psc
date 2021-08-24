Scriptname INVB_Milking_Creatures_AIO_s extends activemagiceffect

Actor target
Race[] Property CreatureRace Auto Const Mandatory 
Form[] Property Creature_Import Auto Const
Form[] Property Creature_Export Auto Const
GlobalVariable property INVB_Global_Notes Auto Const Mandatory
GlobalVariable property INVB_Global_Creature_Gift Auto Const Mandatory
GlobalVariable property INVB_Global_Creature_Time Auto Const Mandatory
GlobalVariable property INVB_Global_Gift Auto Const Mandatory
string Property String_Worked auto

string Property String_Interrupted auto
string Property String_Failed auto
bool Property Impregnation Auto
int int_Impregnation

int i
int int_end_i
int int_Creature
int foundone
	
Function Search_Creature(Actor akActor)
	Debug.Trace("Search_Creature")
	int_end_i = CreatureRace.Length
	
	while (i <= CreatureRace.Length)
		If akActor.GetLeveledActorBase().GetRace() == CreatureRace[i]
			int_Creature = i
			i = int_end_i
		endif
		i += 1
	endwhile	
EndFunction

Function Extraction(Actor akActor)
	Debug.Trace("Extraction Started")
	if INVB_Global_Creature_Gift.GetValue() == 0
		Game.GetPlayer().additem(Creature_Export[int_Creature], INVB_Global_Gift.GetValue() as int)
	elseif INVB_Global_Creature_Gift.GetValue() == 1
		akActor.additem(Creature_Export[int_Creature], INVB_Global_Gift.GetValue() as int)
	endif
			
	if foundone == 0
		foundone = 1
	endif
EndFunction


Function Action()
	Debug.Trace("OnEffectFinish Started")
	string CreatureName = target.GetLeveledActorBase().GetName()
	Search_Creature(target)
	Extraction(target)
	
	if INVB_Global_Notes.GetValue() == 1		
		if foundone == 1	
			Debug.notification(CreatureName + String_Worked)
		elseif foundone == 0
			Debug.notification(CreatureName + String_Failed)
		elseif foundone == 2
			Debug.notification(CreatureName + String_Interrupted)
		EndIf
	EndIf
EndFunction



Function Impregnate(Actor akActor)
	
	if Impregnation == true && (Game.GetPlayer().GetItemCount(Creature_Import[int_Creature])) && int_Impregnation == 0
		Game.GetPlayer().removeitem(Creature_Import[int_Creature], INVB_Global_Gift.GetValue() as int)
		int_Impregnation = 1
	elseif Impregnation == true && int_Impregnation == 0
		foundone = 2
		int_Impregnation = 2
	endif		
EndFunction

Event OnEffectStart(Actor akActor, Actor akCaster)
	Debug.Trace("OnEffectStart Started")
	target = akActor
	if int_Impregnation == 0 && Impregnation == true
		Impregnate(target)
	endif
	
	int random_time_exit = Utility.RandomInt(1, 10)
	Utility.Wait(random_time_exit) 
;	StartTimer(GetUpdateTime())
	Action()
EndEvent


;Useless Stuff

Event OnTimer(int aiTimerID)
	Debug.Trace("OnEffectFinish Started")
	string CreatureName = target.GetLeveledActorBase().GetName()
	Search_Creature(target)
	Extraction(target)
	
	if INVB_Global_Notes.GetValue() == 1		
		if foundone == 1	
			Debug.notification(CreatureName + String_Worked)
		elseif foundone == 0
			Debug.notification(CreatureName + String_Failed)
		elseif foundone == 2
			Debug.notification(CreatureName + String_Interrupted)
		EndIf
	EndIf
EndEvent


Float Function GetUpdateTime()
	
	float time_Extract = INVB_Global_Creature_Time.getvalue()
	If time_Extract > 0
		return time_Extract
	Else
		return 24.0
	EndIf
	
EndFunction