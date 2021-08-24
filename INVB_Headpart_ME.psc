Scriptname INVB_Headpart_ME extends activemagiceffect

headpart[] Property Custom_Headpart_Female Auto
headpart[] Property Custom_Headpart_Male Auto

Event OnEffectStart(Actor akActor, Actor akCaster)
	If akActor.GetLeveledActorBase().GetSex() == 0
	;	akActor.ChangeHeadPart(NONE, true, true)
		headpart kHeadPart = Custom_Headpart_Male[Utility.RandomInt(0, (Custom_Headpart_Male.Length - 1))]				
		akActor.ChangeHeadPart(kHeadPart, false, false)
	;	Debug.Trace("Male Hair Change")
	elseIf akActor.GetLeveledActorBase().GetSex() == 1
	;	akActor.ChangeHeadPart(NONE, true, true)
		headpart kHeadPart = Custom_Headpart_Female[Utility.RandomInt(0, (Custom_Headpart_Female.Length - 1))]
		akActor.ChangeHeadPart(kHeadPart, false, false)
	;	Debug.Trace("Female Hair Change")
	endif
EndEvent
