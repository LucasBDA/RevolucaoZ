var
	TWTag="<b><font color=[rgb(128,64,0)]>Território de Clan:</font>"

obj/Supplemental/CapBar
	icon='CapBar.dmi'
	icon_state="0"
obj/RGBable/Border
	icon='RGBBorder.dmi'
obj/RGBable/Flag
	icon='RGBFlag.dmi'
	pixel_y=32
	layer=6

obj/TerritoryWars/Territory_Flag
	icon='Flags.dmi'
	icon_state="Black"
	layer=6
	var/ClanOwner
	var/ClanColor
	var/list/Borders=list()
	var/datum/Clan/ClanDatum
	var/obj/RGBable/Flag/FlagColor=new()
	var/obj/HUD/MiniMapMarkers/TW/MMM=new()
	proc/ColorClanFlag()
		var/icon/I=new(initial(src.MMM.icon))
		if(src.ClanColor)	I.Blend(src.ClanColor)
		src.MMM.icon=I
		var/icon/I2=new(initial(src.FlagColor.icon))
		if(src.ClanColor)	I2.Blend(src.ClanColor)
		src.FlagColor.icon=I2
		var/icon/I3=new('RGBBorder.dmi')
		if(src.ClanColor)	I3.Blend(src.ClanColor)
		for(var/obj/RGBable/Border/B in src.Borders)	B.icon=I3
	New(var/NewLoc)
		src.FlagColor.loc=src.loc
		src.MMM.CalculateScreenLoc(NewLoc)
		src.ColorClanFlag()
		global.TWMMMs+=src.MMM
		var/obj/Supplemental/CapBar/CapBar=new(src.loc)
		var/CapPercent=0
		for(var/turf/MineCraft/T in oview(20,src))
			if(get_dist(src,T)==20)	T.icon_state="Dirt"
			if(get_dist(src,T)<19)	T.TWFlag=src
			if(get_dist(src,T)==19)
				var/obj/RGBable/Border/B=new(T);src.Borders+=B
				if(B.x-src.x==19)	B.dir=EAST
				if(B.x-src.x==-19)	B.dir=WEST
				if(B.y-src.y==19)	B.dir=NORTH
				if(B.y-src.y==-19)	B.dir=SOUTH
				if(B.x-src.x==19 && B.y-src.y==19)	B.dir=NORTHEAST
				if(B.x-src.x==19 && B.y-src.y==-19)	B.dir=SOUTHEAST
				if(B.x-src.x==-19 && B.y-src.y==-19)	B.dir=SOUTHWEST
				if(B.x-src.x==-19 && B.y-src.y==19)	B.dir=NORTHWEST
		var/obj/O=new;O.icon='Flags.dmi'
		O.icon_state="Black2";O.pixel_y=32;src.overlays+=O;O.layer=6
		spawn()	while(1)
			if(src.ClanDatum)
				src.ClanDatum.AddClanExp(30)
				if(src.ClanDatum.HasUpgrade("Leech"))
					for(var/mob/M in src.ClanDatum.OnlineMembers)	M.AddExp(src.ClanDatum.HasUpgrade("Leech")*3,"Clan Leech")
			sleep(600)
		spawn()	while(1)
			for(var/mob/M in oview(1,src))
				if(M.GhostMode || !M.Clan)	continue
				if(M.Clan.name!=src.ClanOwner)
					CapPercent+=1
					if(CapPercent>=100)
						world<<"[TWTag] [M] capturou [src.x],[src.y] para <font color=[M.Clan.Color]>{[M.Clan]}"
						var/turf/GuardLoc
						while(!isturf(GuardLoc))	GuardLoc=pick(oview(5,src))
						var/mob/CombatNPCs/Enemies/TW_Guard/G=new(GuardLoc)
						G.SetCharacter("[pick(AllCharacters)]")
						G.AddName("TW Guard");G.name="TW Guard"
						G.Team=M.Clan.name;G.StartLoc=G.loc
						src.ClanDatum=M.Clan
						src.ClanOwner=M.Clan.name
						src.ClanColor=M.Clan.Color
						src.ColorClanFlag()
						src.AddName(src.ClanOwner)
						CapPercent=0
				else	CapPercent=0
				CapBar.icon_state="[round(CapPercent/100*31)]"
			sleep(1)
		return ..()

mob/verb/JoinTerritoryWars()
	for(var/mob/Player/P in AmtP)
		if(P==usr)
			usr<<"<b>Acesso Negado! Você está participando ou está registrado em outro Evento"
			usr<<sound('No.ogg')
			return
	if(src.z==10)
		winset(src,"TerritoryWarsPane.EnterButton","text='Enter Territory Wars'")
		src.SetTeam(null)
		src.ExitCP()
	else
		if(!src.Clan)	{src<<"Requer um Clan!";return}
		if(usr.Traveling==1)	return
		winset(src,"TerritoryWarsPane.EnterButton","text='Exit Territory Wars'")
		if(!src.CanInstance())	return
		var/Instances=InstanceDatum.Instances["Territory Wars"]
		src.SetInstance(Instances[1])
		src.client.screen+=global.TWMMMs
		src.SetTeam(src.Clan.name)
		if(src.Quest11!=2 && src.IsUltra!=1)
			src.GhostMode(1)

proc/PopulateTerritories()
	var/Size=40
	for(var/x=Size*1.5;x<=world.maxx-Size*1.5;x+=Size)
		for(var/y=Size*1.5;y<=world.maxy-Size*1.5;y+=Size)
			new/obj/TerritoryWars/Territory_Flag(locate(x,y,10))