Scriptname INVB_MCM_Hotkeys extends Quest

Actor Property PlayerRef Auto Const
Armor Property arm_Armor Auto Const
form Property obj_Object Auto Const
bool Property bool_GiveKeyword auto
bool Property bool_GivePerk auto
bool Property bool_GiveArmor auto
bool Property bool_NeedItem auto
Keyword Property kw_Keyword Auto
Keyword Property kw_Added Auto
Perk Property Pk_Perk Auto

Actor Function GetActorUnderCrosshairs()
	Actor ScannedActor = LL_FourPlay.LastCrossHairActor()
	
	If ScannedActor == NONE || ScannedActor.GetDistance(PlayerRef) > 256.000
		return None
	EndIf
	Return ScannedActor
EndFunction




Function GiveNPCUnderCrosshairs()
	Actor akActor = GetActorUnderCrosshairs()
	
	If (akActor)
		
		if bool_NeedItem == false
			if akActor.HasKeyword(kw_Keyword) == true
				if akActor.HasPerk(Pk_Perk) == true
					akActor.RemovePerk(Pk_Perk)
				endIf
		
				if akActor.HasKeyword(kw_Keyword) == true
					akActor.RemoveKeyword(kw_Keyword)
				endIf	
	
				if akActor.isEquipped(arm_Armor)
					akActor.unequipitem(arm_Armor, 1)
					akActor.removeitem(arm_Armor, 1)
				endIf	
				akActor.RemoveKeyword(kw_Added)
			else
				if bool_GiveArmor == true
					akActor.additem(arm_Armor, 1)
					akActor.equipitem(arm_Armor, 1)
				endIf	
		
				if bool_GivePerk == true
					akActor.AddPerk(Pk_Perk)
				endIf
		
				if bool_GiveKeyword == true
					akActor.AddKeyword(kw_Keyword)
				endIf
				akActor.AddKeyword(kw_Added)
			endIf
			
		elseif bool_NeedItem == true && (Game.GetPlayer().GetItemCount(obj_Object) >= 1)
			Game.GetPlayer().RemoveItem(obj_Object)
			
			if akActor.HasKeyword(kw_Keyword) == true
				if akActor.HasPerk(Pk_Perk) == true
					akActor.RemovePerk(Pk_Perk)
				endIf
		
				if akActor.HasKeyword(kw_Keyword) == true
					akActor.RemoveKeyword(kw_Keyword)
				endIf	
	
				if akActor.isEquipped(arm_Armor)
					akActor.unequipitem(arm_Armor, 1)
					akActor.removeitem(arm_Armor, 1)
				endIf	
				akActor.RemoveKeyword(kw_Added)
			else
				if bool_GiveArmor == true
					akActor.additem(arm_Armor, 1)
					akActor.equipitem(arm_Armor, 1)
				endIf	
		
				if bool_GivePerk == true
					akActor.AddPerk(Pk_Perk)
				endIf
		
				if bool_GiveKeyword == true
					akActor.AddKeyword(kw_Keyword)
				endIf
				akActor.AddKeyword(kw_Added)
			endIf	
			
		elseif bool_NeedItem == true && (Game.GetPlayer().GetItemCount(obj_Object) == 0)
			Debug.MessageBox("You Don't have the " + obj_Object + " to use")
		endIf		
		
		
	Else
		Debug.MessageBox("There is no NPC to give stuff to.")
	EndIf
	
EndFunction

Function GiveMyselfStuff()
	Actor akActor = PlayerRef
	
	If (akActor)
		
		if bool_NeedItem == false
			if akActor.HasKeyword(kw_Keyword) == true
				if akActor.HasPerk(Pk_Perk) == true
					akActor.RemovePerk(Pk_Perk)
				endIf
		
				if akActor.HasKeyword(kw_Keyword) == true
					akActor.RemoveKeyword(kw_Keyword)
				endIf	
	
				if akActor.isEquipped(arm_Armor)
					akActor.unequipitem(arm_Armor, 1)
					akActor.removeitem(arm_Armor, 1)
				endIf	
				akActor.RemoveKeyword(kw_Added)
			else
				if bool_GiveArmor == true
					akActor.additem(arm_Armor, 1)
					akActor.equipitem(arm_Armor, 1)
				endIf	
		
				if bool_GivePerk == true
					akActor.AddPerk(Pk_Perk)
				endIf
		
				if bool_GiveKeyword == true
					akActor.AddKeyword(kw_Keyword)
				endIf
				akActor.AddKeyword(kw_Added)
			endIf	
			
		elseif bool_NeedItem == true && (Game.GetPlayer().GetItemCount(obj_Object) >= 1)
			Game.GetPlayer().RemoveItem(obj_Object)
			
			if akActor.HasKeyword(kw_Keyword) == true
				if akActor.HasPerk(Pk_Perk) == true
					akActor.RemovePerk(Pk_Perk)
				endIf
		
				if akActor.HasKeyword(kw_Keyword) == true
					akActor.RemoveKeyword(kw_Keyword)
				endIf	
	
				if akActor.isEquipped(arm_Armor)
					akActor.unequipitem(arm_Armor, 1)
					akActor.removeitem(arm_Armor, 1)
				endIf
				akActor.RemoveKeyword(kw_Added)
				
			else
				if bool_GiveArmor == true
					akActor.additem(arm_Armor, 1)
					akActor.equipitem(arm_Armor, 1)
				endIf	
		
				if bool_GivePerk == true
					akActor.AddPerk(Pk_Perk)
				endIf
		
				if bool_GiveKeyword == true
					akActor.AddKeyword(kw_Keyword)
				endIf
				akActor.AddKeyword(kw_Added)
			endIf
		
		elseif bool_NeedItem == true && (Game.GetPlayer().GetItemCount(obj_Object) == 0)
			Debug.MessageBox("You Don't have the " + obj_Object + " to use")
		endIf		
		
			
	Else
		Debug.MessageBox("There is nothing to use.")
	EndIf
	
EndFunction