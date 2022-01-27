ScriptName INVB_DNATransfer extends activemagiceffect

Perk Property WLD_Perk_Replace_DNA Auto
Perk[] Property WLD_Perk_Old_DNA Auto
String Property Creature_DNA Auto Const
Keyword Property fpfp_DNATransfer Auto

Event OnEffectStart(Actor akActor, Actor akCaster)
	
	Int i = 0
    
	While (i < WLD_Perk_Old_DNA.Length)
		if akActor.HasPerk(WLD_Perk_Old_DNA[i])
			akActor.RemovePerk(WLD_Perk_Old_DNA[i])
		endif
		i += 1
	endwhile
	
	akActor.AddPerk(WLD_Perk_Replace_DNA)
	akActor.addkeyword(fpfp_DNATransfer)
	
	Debug.notification("Reproductive DNA was been replaced by a " + Creature_DNA)
EndEvent
