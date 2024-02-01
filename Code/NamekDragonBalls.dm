var/list/GlobalNDBs=list()
mob/var/list/NamekDragonBalls=list()
mob/var/list/DBMsCollected=list()

proc/PopulateNDragonBalls()
	for(var/i=1;i<=7;i++)
		var/obj/Items/NamekDragonBalls/N=new(RandomLoc(7))
		N.icon_state="DB[i]";N.name="[i] Star DragonBall"
		N.M=new(N.icon_state);global.DBMs+=N.M
		N.M.CalculateScreenLoc(N)

obj/Items/NamekDragonBalls
	icon='NamekDragonBalls.dmi'
	var/obj/HUD/MiniMapMarkers/DB/M
	New()
		GlobalNDBs+=src
		return ..()
	Collect(var/mob/U)
		if(!U.client)	return
		if(src.icon_state in U.NamekDragonBalls)	{U<<"Você já tem a [src.name]";return}
		U<<"Você coletou [U.NamekDragonBalls.len+1] Esferas do Dragão!"
		PlaySound(U,'Rupee.ogg',VolChannel="Menu")
		U.NamekDragonBalls+=src.icon_state
		U.DBMsCollected+=src.M
		U.client.screen-=src.M
		src.loc=RandomLoc(src.z)
		src.M.CalculateScreenLoc(src)
		if(U.NamekDragonBalls.len>=7)	U.ShowWishNamek()

mob/proc/ShowWishNamek()
	if(src.NamekDragonBalls.len>=7)
		winset(src,"WishNamek.TextLabel","text=\"Você coletou as 7 Esferas do Dragão!\nPosso lhe conceder 3 pedidos. Diga-me, o que você quer..?\"")
		for(var/i=1;i<=7;i++)	winset(src,"WishNamek.Btn[i]","is-disabled=false")
		if(src.Level<3000000)	winset(src,"WishNamek.Btn7","is-disabled=true")
		if(!src.Clan)	winset(src,"WishNamek.Btn6","is-disabled=true")
	else
		for(var/i=1;i<=7;i++)	winset(src,"WishNamek.Btn[i]","is-disabled=true")
	winset(src,"WishNamek","size=432x432;pos=100,100;is-visible=true")

mob/var/WishesNamekMade=0
mob/var/LastWishNamekDate
mob/verb/WishNamek(var/WishFor as null|text)
	if(src.LastWishNamekDate!=time2text(world.timeofday,"YYYYMMDD"))	src.WishesNamekMade=0
	var/WishesNamekAvailable=3
	if(src.WishesNamekMade>=WishesNamekAvailable)	{src<<"Você já fez [WishesNamekAvailable] desejos hoje...";return}
	if(src.NamekDragonBalls.len<7)	{src<<"Você precisa de mais [7-src.NamekDragonBalls.len] Esferas do Dragão...";return}
	src.WishesNamekMade+=1
	src.NamekDragonBalls=list()
	src.DBMsCollected=list()
	src.UpdateMiniMapDBs()
	src.TrackStat("Wishes",1)
	winset(src,"WishNamek","is-visible=false")
	src.GiveMedal(new/obj/Medals/EternalDragon)
	src.LastWishNamekDate=time2text(world.timeofday,"YYYYMMDD")
	var/WishedFor="1,000 Levels"
	var/WishTag="([src.WishesNamekMade]/[WishesNamekAvailable] Desejos hoje)"
	switch(WishFor)
		if("Levels")
			WishedFor="1,000 Levels";src.AddExp(1000*100,"Wish Granted");src.TrackStat("Level Wishes",1)
		if("Zenie")
			WishedFor="1,000 Zenie";src.AddZenie(1000);src.TrackStat("Zenie Wishes",1)
		if("Perks")
			WishedFor="Perk Respec";src.RespecPerks();src.TrackStat("Perk Wishes",1)
			src.PerkPoints-=Clicked2
		if("Stats")
			WishedFor="Stat Respec";src.RespecStats();src.TrackStat("Stat Wishes",1)
		if("Respec")
			WishedFor="Full Respec";src.RespecStats();src.RespecPerks();src.TrackStat("Respec Wishes",1)
		if("ClanExp")
			if(!src.Clan)	return
			WishedFor="5,000 Clan Exp";src.Clan.AddClanExp(5000,src);src.TrackStat("Clan Exp Wishes",1)
		if("Rebirth")
			if(src.Level<2000000)
				usr<<sound('No.ogg')
				alert("Você não tem Nível o suficiente!")
				return
			WishedFor="Character Rebirth"
			src.GiveMedal(new/obj/Medals/Ressurection)
			src.Level=initial(src.Level);src.TrackStat("Character Rebirths",1)
			src.PL=1000
			src.MaxPL=1000
			src.Ki=1000
			src.MaxKi=1000
			src.Str=100
			src.Def=50
			src.PerkPoints=0
			src.TraitPoints=0
			src.MajinForm=0
			src.Doing+=0.3
			src.DamageMultiplier+=0.3
	world<<"<b><i><font color=[rgb(255,128,0)]>[src] pediu [WishedFor] para Porunga [WishTag]"
