Scriptname INVB_MiscAdder extends activemagiceffect

MiscObject Property Misc_item Auto Const
int Property int_count Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
    akCaster.additem(Misc_item, int_count, true)
EndEvent