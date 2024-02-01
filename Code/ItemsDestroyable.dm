obj/Items
	proc/Collect()	return
//	proc/Delete()	return
	proc/Name()	return
	proc/Destroy()	return
obj/BigBlasts
	proc/Touch()	return
mob/proc/DestroyCheck(var/turf/Loc)
	if(!src.ControlClients)	return
	for(var/obj/Items/Destroyable/D in Loc)
		spawn(-1)	if(D.Destroy(src))	src.TrackStat("Chests Opened",1)
		src.CompleteTutorial("Opening Chests")
		break

obj/Items/Destroyable
	density=1
	Chests
		icon='Chests.dmi'
		var/ItemsOut=0
		var/Tempo=0
		var/list/LootTypes=list()
		var/list/ZenieRates=list(400,200,100,50)
		Chest
			icon_state="Chest"
		Golden_Chest
			ItemsOut=0
			icon_state="GoldenChest"
			ZenieRates=list(0,0,0,400)
		Destroy(var/mob/DestroyedBy)
			if(src.icon_state!=initial(src.icon_state))	return
			var/list/PartyList2=DestroyedBy.Party
			if(src==TreasureHunterChest)
				world<<"[TreasureHunterTag] [DestroyedBy] Achou o Baú Dourado!"
				DestroyedBy.GiveMedal(new/obj/Medals/TreasureHunter)
			src.icon_state="[src.icon_state]Open"
			spawn(-1)	DestroyedBy.SpawnZenie(Loc=src.loc,Times=30,Min=3,Max=5,DropRates=src.ZenieRates)
			src.loc=null;return 1