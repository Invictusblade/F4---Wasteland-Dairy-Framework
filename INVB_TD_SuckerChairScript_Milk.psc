Scriptname INVB_TD_SuckerChairScript_Milk extends ObjectReference



Idle Property _td_SuckerChairStruggle Auto Const
Idle Property _td_SuckerChairFinishIdle Auto Const
Idle Property _TD_SuckerChairFast Auto Const
Idle Property _TD_SuckerChairTransitionFast Auto Const

Sound Property _TD_PumpFast_SD Auto Const
Sound Property _TD_PumpSlow_SD Auto Const
Sound Property _TD_CupsClose_SD Auto Const
Sound Property _TD_CuffsClose_SD Auto Const

Keyword Property kw_Morph_Milk Auto
MiscObject Property milk_Empty1 Auto Const
Perk Property Perk_Virus Auto
Potion Property Milk_Breast Auto Const
ActorValue Property Rads Auto Const
Potion Property Milk_Rads Auto Const
Race Property GhoulRace Auto Const Mandatory 
Race Property SynthGen1Race Auto Const Mandatory 
Potion Property Milk_Synth Auto Const
Race Property SynthGen2Race Auto Const Mandatory 
Race Property SynthGen2RaceValentine Auto Const Mandatory 
GlobalVariable property FPFP_Global_BodyType Auto Const Mandatory
GlobalVariable property INVB_Global_Milking_MaxSize Auto Const Mandatory
GlobalVariable property INVB_Global_Milking_Amount_1 Auto Const Mandatory
GlobalVariable property INVB_Global_Milking_Amount_2 Auto Const Mandatory
GlobalVariable property INVB_Global_Rads auto Const
GlobalVariable property INVB_Global_Notes Auto Const Mandatory



Group Durations
; The durations used for Stage01 and Stage 02
int property Dur1 = 10 auto
int property Dur2 = 30 auto

endGroup

Actor ScActor
InputEnableLayer CamSwitch
Int SoundID 

; Start Stage 01
Event OnActivate(ObjectReference akActionRef)
	

	utility.wait(1)
	ScActor = akActionRef as actor

if  ScActor != game.getplayer()
	ScActor.setrestrained()
else

	CamSwitch = InputEnableLayer.create()
	CamSwitch.EnableCamSwitch(false)
	CamSwitch.EnableMovement(false)
	CamSwitch.EnableMenu(false)
	game.ForceThirdPerson()

endIf


	stage1(ScActor, Dur1)

endEvent


; Trigger the next stage after Timer Expired
Event OnTimer(int aiTimerID)

	
		if aiTimerID == 665
			
		while (ScActor.GetItemCount(milk_Empty1) >= 2)
			Sound.StopInstance(SoundID)
			Stage2(ScActor,Dur2)
			If (ScActor.GetLeveledActorBase().GetSex() == 1) && (ScActor.GetItemCount(milk_Empty1) >= 2)	
	
				If ScActor.HasPerk(Perk_Virus)
					ScActor.removeitem(milk_Empty1, 4, true)
				Else
					ScActor.removeitem(milk_Empty1, 2, true)
				Endif
				Do_Milk_Morphs(ScActor)
				
			endif
			Debug.notification(ScActor.GetItemCount(milk_Empty1))
			utility.wait(1)
		endwhile
		
		
		ElseIf aiTimerID == 666
		
			Sound.StopInstance(SoundID)
			Stage3(ScActor)		
		EndIf
		
	
	
EndEvent


Event OnExitFurniture(ObjectReference akActionRef)

	

EndEvent

Function Stage1 (actor akActor, int Duration)
	

	CuffsLock()
	CupsClose()
	StartPump()
	akActor.playidle(_td_suckerchairstruggle)
	StartTimer(Duration,665)
	
EndFunction

Function Stage2 (actor akActor, int Duration)

	StartPump(Fast = true)


; The Transition is needed due to how Idles are Handled
;removing the transition causes that the anim loop of stage1 is played again.
	
	akActor.playidle(_TD_SuckerChairTransitionFast)
	utility.wait(0.5)
	akActor.PlayIdle(_TD_SuckerChairFast)

	
	if  (akActor.GetItemCount(milk_Empty1) <= 2)
		StartTimer(Duration,666)
	endIf
	
	
EndFunction

Function Stage3 (actor akActor)
	
		
		
	
	
	CupsClose(False)	
	akActor.playidle(_TD_SuckerChairFinishIdle)
	utility.wait(2)
	CuffsLock(false)
	utility.wait(1)
	
if akActor != game.getplayer()
	
	akActor.setrestrained(false)

Else

	CamSwitch.EnableCamSwitch(true)
	CamSwitch.EnableMovement(true)
	CamSwitch.EnableMenu(true)
	CamSwitch.delete()
	CamSwitch = none

EndIf
EndFunction


Function CuffsLock (bool Lock=true)

if Lock == true
	self.playanimation("CuffsLock")
	_TD_CuffsClose_SD.play(self)

else

	
	self.playanimation("CuffsUnLock")
	_TD_CuffsClose_SD.play(self)
EndIf	

	utility.wait(0.5)	
EndFunction


Function CupsClose ( bool close = true )

if close == true

	self.playanimation("CupsClose")
	_TD_CupsClose_SD.Play(self)
else
	self.playanimation("CupsOpen")
	_TD_CupsClose_SD.Play(self)

EndIf

	utility.wait(0.5)
EndFunction

Function StartPump (bool fast = false)

if fast == false

	self.playanimation("PumpSlow")
	SoundID = _TD_PumpSlow_SD.play(self)
Else

	self.playanimation("PumpFast")
	SoundID = _TD_PumpFast_SD.play(self)

EndIf

	utility.wait(0.5)
EndFunction

Function StopPump ()

	self.playanimation("PumpStop")
	Sound.StopInstance(SoundID)

EndFunction

Function StopScene ()

	CancelTimer(665)
	CancelTimer(666)

If ScActor != game.getplayer()

	ScActor.SetRestrained(false)

Else

	CamSwitch.EnableCamSwitch(true)
	CamSwitch.EnableMovement(true)
	CamSwitch.EnableMenu(true)
	CamSwitch.delete()
	CamSwitch = none

EndIf

	CuffsLock(False)
	CupsClose(false)
	StopPump()

EndFunction



Function Do_Milk_Morphs(Actor akActor)
		string M_string_01
		string string_02
		string string_03
		string string_04
		Float RadLevel = akActor.GetValue(Rads) as float
		
		If (FPFP_Global_BodyType.GetValue() == 0) ; CBBE
			M_string_01 = "Breasts"
			string_02 = ""
			string_03 = ""
			string_04 = ""
		ElseIf (FPFP_Global_BodyType.GetValue() == 1) ; Fusion Girl
			M_string_01 = "Boobs Yuge"
			string_02 = "Nipples Areola"
			string_03 = "Nipples Distance"
			string_04 = ""
		ElseIf (FPFP_Global_BodyType.GetValue() == 2) ; AtomicBeauty
			M_string_01 = "Breasts_Huge"
			string_02 = ""
			string_03 = ""
			string_04 = ""
		Else ; JaneBod
			M_string_01 = "BreastsNaturalTypeSeven"
			string_02 = "BreastSize"
			string_03 = "NippleShapeLargerSeven"
			string_04 = ""
		Endif


		Float original_String_01 = (BodyGen.GetMorph(akActor, true, M_string_01, none)) as float
		Float original_String_02 = (BodyGen.GetMorph(akActor, true, string_02, none)) as float
		Float original_String_03 = (BodyGen.GetMorph(akActor, true, string_03, none)) as float
		Float original_String_04 = (BodyGen.GetMorph(akActor, true, string_04, none)) as float
		
		Float adjusted_String_01 = (BodyGen.GetMorph(akActor, true, M_string_01, kw_Morph_Milk)) as float
		Float adjusted_String_02 = (BodyGen.GetMorph(akActor, true, string_02, kw_Morph_Milk)) as float
		Float adjusted_String_03 = (BodyGen.GetMorph(akActor, true, string_03, kw_Morph_Milk)) as float
		Float adjusted_String_04 = (BodyGen.GetMorph(akActor, true, string_04, kw_Morph_Milk)) as float		
		
		Float MorphPower_String_01 = (adjusted_String_01 + original_String_01)
		Float MorphPower_String_02 = (adjusted_String_02 + original_String_02)
		Float MorphPower_String_03 = (adjusted_String_03 + original_String_03)
		Float MorphPower_String_04 = (adjusted_String_04 + original_String_04)
		
		Float Milked_Breasts
		
	If (akActor.GetLeveledActorBase().GetSex() == 1)
			
				If (MorphPower_String_01 >= INVB_Global_Milking_MaxSize.GetValue())
					Milked_Breasts = INVB_Global_Milking_MaxSize.GetValue()
					BodyGen.SetMorph(akActor, true, M_string_01, kw_Morph_Milk, Milked_Breasts)
					BodyGen.SetMorph(akActor, true, string_02, kw_Morph_Milk, Milked_Breasts)
					BodyGen.SetMorph(akActor, true, string_03, kw_Morph_Milk, Milked_Breasts)
					BodyGen.SetMorph(akActor, true, string_04, kw_Morph_Milk, Milked_Breasts)
					
				else
					Milked_Breasts = (MorphPower_String_01 + INVB_Global_Milking_Amount_2.GetValue())
									
					If akActor.HasPerk(Perk_Virus)
						Milked_Breasts = (Milked_Breasts * 2)
					endif
			
					BodyGen.SetMorph(akActor, true, M_string_01, kw_Morph_Milk, Milked_Breasts)		
					BodyGen.SetMorph(akActor, true, string_02, kw_Morph_Milk, Milked_Breasts)
					BodyGen.SetMorph(akActor, true, string_03, kw_Morph_Milk, Milked_Breasts)
					BodyGen.SetMorph(akActor, true, string_04, kw_Morph_Milk, Milked_Breasts)
					
				Endif
		
			
			BodyGen.UpdateMorphs(akActor)	
		
		if INVB_Global_Notes.GetValue() == 1	
			Debug.notification(akActor.GetLeveledActorBase().GetName() +" Has Been Milked")
		endif	
		
				
		If akActor.GetLeveledActorBase().GetRace() == GhoulRace
			akActor.additem(Milk_Rads, 2, true)
		ElseIf akActor.GetLeveledActorBase().GetRace() == SynthGen1Race
			akActor.additem(Milk_Synth, 2, true)
		ElseIf akActor.GetLeveledActorBase().GetRace() == SynthGen2Race
			akActor.additem(Milk_Synth, 2, true)
		ElseIf akActor.GetLeveledActorBase().GetRace() == SynthGen2RaceValentine
			akActor.additem(Milk_Synth, 2, true)
		ElseIf (RadLevel > INVB_Global_Rads.GetValue())
			akActor.additem(Milk_Rads, 2, true)
		ElseIf akActor.HasPerk(Perk_Virus)
			akActor.additem(Milk_Breast, 4, true)
		else
			akActor.additem(Milk_Breast, 2, true)	
		Endif
			
			
		
	
	Else
	
		if INVB_Global_Notes.GetValue() == 1
			Debug.notification(akActor.GetLeveledActorBase().GetName() +" Has Been Milked")
		endif	
				
		If akActor.GetLeveledActorBase().GetRace() == GhoulRace
			akActor.additem(Milk_Rads, 2, true)
		ElseIf akActor.GetLeveledActorBase().GetRace() == SynthGen1Race
			akActor.additem(Milk_Synth, 2, true)
		ElseIf akActor.GetLeveledActorBase().GetRace() == SynthGen2Race
			akActor.additem(Milk_Synth, 2, true)
		ElseIf akActor.GetLeveledActorBase().GetRace() == SynthGen2RaceValentine
			akActor.additem(Milk_Synth, 2, true)
		ElseIf (RadLevel > INVB_Global_Rads.GetValue())
			akActor.additem(Milk_Rads, 2, true)
		ElseIf akActor.HasPerk(Perk_Virus)
			akActor.additem(Milk_Breast, 4, true)
		else
			akActor.additem(Milk_Breast, 2, true)	
		Endif
		
	Endif
EndFunction