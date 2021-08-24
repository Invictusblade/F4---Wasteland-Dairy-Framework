Scriptname INVB_Overlay_Armor_ME extends activemagiceffect

Armor Property Overlay_Manager Auto Const Mandatory

Event OnEffectStart(Actor akTarget, Actor akCaster)
    akTarget.additem(Overlay_Manager, 1)
    akTarget.equipitem(Overlay_Manager, 1)
EndEvent