ScriptName INVB_Morphs_Reset extends activemagiceffect

Keyword Property kw_Morph_Milk Auto

Event OnEffectStart(Actor akActor, Actor akCaster)
	BodyGen.RemoveMorphsByKeyword(akActor, false, kw_Morph_Milk)
	BodyGen.RemoveMorphsByKeyword(akActor, true, kw_Morph_Milk)
	BodyGen.UpdateMorphs(akActor)
EndEvent