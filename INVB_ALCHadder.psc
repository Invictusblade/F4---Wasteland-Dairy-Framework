;This adds a item to the caster with a selected amount
Scriptname INVB_ALCHadder extends activemagiceffect

form Property Potion_item Auto Const
int Property int_count Auto
bool Property bool_Display = True Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
    akCaster.additem(Potion_item, int_count, bool_Display)
EndEvent
