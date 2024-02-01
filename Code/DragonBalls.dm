var/list/GlobalDBs=list()
mob/var/list/DragonBalls=list()
mob/var/list/DBMMMsCollected=list()

proc/RandomLoc(var/Z)
	var/ViewSet=world.view*2
	return locate(rand(ViewSet,world.maxx-ViewSet),rand(ViewSet,world.maxy-ViewSet),Z)

proc/PopulateDragonBalls()
	for(var/i=1;i<=7;i++)
		var/obj/Items/DragonBalls/D=new(RandomLoc(1))
		D.icon_state="DB[i]";D.name="[i] Star DragonBall"
		D.MMM=new(D.icon_state);global.DBMMMs+=D.MMM
		D.MMM.CalculateScreenLoc(D)

obj/Items/DragonBalls
	icon='DragonBalls.dmi'
	var/obj/HUD/MiniMapMarkers/DB/MMM
	New()
		GlobalDBs+=src
		return ..()
	Collect(var/mob/M)
		if(!M.client)	return
		if(src.icon_state in M.DragonBalls)	{M<<"Você já tem a [src.name]";return}
		M<<"Você coletou [M.DragonBalls.len+1] Esferas do Dragão!"
		PlaySound(M,'Rupee.ogg',VolChannel="Menu")
		M.DragonBalls+=src.icon_state
		M.DBMMMsCollected+=src.MMM
		M.client.screen-=src.MMM
		src.loc=RandomLoc(src.z)
		src.MMM.CalculateScreenLoc(src)
		if(M.DragonBalls.len>=7)	M.ShowWishWindow()

var/obj/HUD/Wish/WishHUD=new()
obj/HUD
	Wish
		icon_state="Wish"
		screen_loc="10,1"
		name="DragonBall Wishes"
		desc="Colete as 7 Esferas do Dragão para fazer o seu pedido!"
		MouseEntered()
			src.desc="[initial(src.desc)]\nVocê tem [usr.DragonBalls.len] Esferas do Dragão..."
			return ..()
		Click()	usr.ShowWishWindow()

mob/proc/ShowWishWindow()
	if(src.DragonBalls.len>=7)
		PlaySound(view(),'DBG.ogg')
		winset(src,"WishWindow.TextLabel","text=\"Você coletou as 7 Esferas do Dragão! Você pode fazer 1 pedido.\nDiga-me, o que você quer?\"")
		for(var/i=1;i<=7;i++)	winset(src,"WishWindow.Btn[i]","is-disabled=false")
		if(src.Level<3000000)	winset(src,"WishWindow.Btn7","is-disabled=true")
		if(!src.Clan)	winset(src,"WishWindow.Btn6","is-disabled=true")
	else
		winset(src,"WishWindow.TextLabel","text=\"Você tem [usr.DragonBalls.len] Esferas do Dragão...\"")
		for(var/i=1;i<=7;i++)	winset(src,"WishWindow.Btn[i]","is-disabled=true")
	winset(src,"WishWindow","size=432x432;pos=100,100;is-visible=true")

mob/var/WishesMade=0
mob/var/LastWishDate
mob/verb/Wish(var/WishFor as null|text)
	set hidden=1
	if(src.LastWishDate!=time2text(world.timeofday,"YYYYMMDD"))	src.WishesMade=0
	var/WishesAvailable=1;if(src.Subscriber)	WishesAvailable+=0
	if(src.WishesMade>=WishesAvailable)	{src<<"Você já fez [WishesAvailable] desejo hoje...";return}
	if(src.DragonBalls.len<7)	{src<<"Você precisa de mais [7-src.DragonBalls.len] Esferas do Dragão...";return}
	src.WishesMade+=1
	src.DragonBalls=list()
	src.DBMMMsCollected=list()
	src.UpdateMiniMapDBs()
	src.TrackStat("Wishes",1)
	winset(src,"WishWindow","is-visible=false")
	src.GiveMedal(new/obj/Medals/EternalDragon)
	src.LastWishDate=time2text(world.timeofday,"YYYYMMDD")
	var/WishedFor="2,000 Levels"
	var/WishTag="([src.WishesMade]/[WishesAvailable] Desejos hoje)"
	switch(WishFor)
		if("Levels")
			WishedFor="2,000 Levels";src.AddExp(2000*100,"Wish Granted");src.TrackStat("Level Wishes",1)
		if("Zenie")
			WishedFor="2,000 Zenie";src.AddZenie(2000);src.TrackStat("Zenie Wishes",1)
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
	world<<"<b><i><font color=[rgb(255,128,0)]>[src] pediu [WishedFor] para Shenlong [WishTag]"
	PlaySound(view(),'DBF.ogg')