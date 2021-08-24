Scriptname INVB_Test extends activemagiceffect

Form Property Black Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
	ColorForm colorBlack = Black as ColorForm
	akCaster.SetHairColor(colorBlack)
EndEvent