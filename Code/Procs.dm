proc
	PlaySound(var/Hearers,file,repeat=0,wait,channel,VolChannel="Effect")
		if(ismob(Hearers))	for(var/client/C in Hearers:ControlClients)
			var/mob/M=C.mob;if(M.vars["Volume[VolChannel]"] && !M.VolumeMuteAll)	M<<sound(file,repeat,wait,channel,M.vars["Volume[VolChannel]"])
		else	for(var/mob/H in Hearers)	for(var/client/C in H.ControlClients)
			var/mob/M=C.mob;if(M.vars["Volume[VolChannel]"] && !M.VolumeMuteAll)	M<<sound(file,repeat,wait,channel,M.vars["Volume[VolChannel]"])

	GetPercent(var/Percent,var/Total)
		return round(Total*(Percent/100))

	FullNum(var/eNum,var/ShowCommas=1)
		eNum=num2text(round(eNum),99)
		if(ShowCommas && length(eNum)>3)
			for(var/i=1;i<=round(length(eNum)/4);i++)
				var/CutLoc=length(eNum)+1-(i*3)-(i-1)
				eNum="[copytext(eNum,1,CutLoc)],[copytext(eNum,CutLoc)]"
		return eNum
atom/movable/var/atom/SmartFollowID
atom/movable/var/atom/SmartFollowTarget
atom/movable/proc/SmartFollow(var/atom/Target,var/FollowDist=0,var/Speed=0)
	walk_to(src,Target,FollowDist,Speed)
	src.SmartFollowTarget=Target
	src.SmartFollowID=rand(1,999999)
	var/ThisID=src.SmartFollowID
	spawn()	while(src.SmartFollowID==ThisID && Target)
		if((abs(src.x-Target.x>12) || abs(src.y-Target.y>7)))
			src.loc=Target.loc
			walk_to(src,Target,FollowDist,Speed)
		sleep(5)
atom/movable/proc/CancelSmartFollow()
	src.SmartFollowTarget=null
	src.SmartFollowID=null
	walk(src,0)

mob/proc/SetTeam(var/NewTeam)
	for(var/mob/M in src.Party)	if(M.Owner==src)	M.Team=NewTeam
	src.Team=NewTeam
mob/proc/ssg1()
		var/obj/O=new;O.icon='teste.dmi'
		O.icon_state="";src.overlays+=O
mob/proc/delssg1()
		var/obj/O=new;O.icon='teste.dmi'
		O.icon_state="";src.overlays-=O

mob/verb/ChangeScream()
	set hidden=1
	var/Choice=alert(usr,"Deseja habilitar a animação de certos personagens quando se transformam utilizando o atalho 'Ctrl+A'?","Transformação","Sim","Não")
	if(Choice=="Sim")	usr.Talked12=1
	else
		if(Choice=="Não")	usr.Talked12=0
obj/iconenatela2
	icon='teste2.dmi'
	screen_loc="SOUTHWEST to NORTHEAST"
	layer=1009

obj/gravidade
	icon='gravity.dmi'
	screen_loc="SOUTHWEST to NORTHEAST"
	layer=5


mob/proc
	DeleteEmblems()
		src.overlays-=global.Caveira
		src.overlays-=global.Caveira2
		src.overlays-=global.ZW
		src.overlays-=global.Fogo
		src.overlays-=global.Cruz
		src.overlays-=global.Raio
		src.overlays-=global.SSJ
		src.overlays-=global.Espada2
		src.overlays-=global.Templar
		src.overlays-=global.Morte
		src.overlays-=global.Foice
		src.overlays-=global.Esfera
		src.overlays-=global.Espada
		src.overlays-=global.Vitoria
		src.overlays-=global.SS
		src.overlays-=global.Wolf
		src.overlays-=global.Majin
		src.overlays-=global.DD
		src.overlays-=global.DS

obj/proc
	DeleteEmblems2()
		src.overlays-=global.Caveira22
		src.overlays-=global.Caveira222
		src.overlays-=global.ZW2
		src.overlays-=global.Fogo2
		src.overlays-=global.Cruz2
		src.overlays-=global.Raio2
		src.overlays-=global.SSJ2
		src.overlays-=global.Espada22
		src.overlays-=global.Templar2
		src.overlays-=global.Morte2
		src.overlays-=global.Foice2
		src.overlays-=global.Esfera2
		src.overlays-=global.Espada222
		src.overlays-=global.Vitoria2
		src.overlays-=global.Wolf2
		src.overlays-=global.SS2
		src.overlays-=global.Majin2
		src.overlays-=global.DD2
		src.overlays-=global.DS2

mob/proc/CombatTime()
	src.InCombat+=1
	spawn(50)	src.InCombat-=1

mob/proc/GuardRecharge(/**/)
	while(1)
		if(!src.GuardBroken && src.GuardLeft<100)
			if(src.icon_state!="Guard")
				if(!src.HitStun || src.HasPerk("Escudo do Guerreiro"))
					if(src.CanBeHit())
						src.GuardLeft=min(100,src.GuardLeft+1)
						src.UpdateGuardHUD()
		sleep(1)

mob/var/list/KeysHeld
mob/var/list/KeysTapped
mob/proc/PressKey(var/Key)
	if(!src.KeysHeld)	src.KeysHeld=list()
	if(!(Key in src.KeysHeld))	src.KeysHeld+=Key
	if(!src.KeysTapped)	src.KeysTapped=list()
	src.KeysTapped+=Key
	spawn(2)	src.KeysTapped-=Key
mob/proc/ReleaseKey(var/Key)
	if(!src.KeysHeld)	src.KeysHeld=list()
	src.KeysHeld-=Key
mob/proc/HoldingKey(var/Key)
	if(Key in src.KeysHeld)	return 1

mob/proc/PM(var/mob/M)
	src.CreatePrMsgWindow(M)
	winset(src,"PrMsg[M.key]","is-minimized=false;is-visible=true")
	winset(src,"PrMsg[M.key].PrMsgInput","focus=true")

proc/MyProb(var/Percent)
	if(rand(1,100)<=Percent)	return 1

proc/UpdateChatRoomWho(var/ThisRoom)
	if(ThisRoom in ChatRooms)
		var/list/PlayerList=ChatRooms[ThisRoom]
		var/HTML="<body bgcolor=[rgb(91,142,153)]><center><b><u>[PlayerList.len] Chatters</u><br>"
		for(var/mob/M in PlayerList)	HTML+="<body bgcolor=[rgb(1,1,1)]>[M]<br>"
		for(var/mob/M in PlayerList)	M<<browse(HTML,"window=[ThisRoom].ChattersBrowser")

mob/proc/UpdateLastOnline()
	src.LastOnline=time2text(world.timeofday,"YYMMDD")
	if(src.Clan)
		if(!(src.key in src.Clan.LastOnlineMembers))	src.Clan.LastOnlineMembers+=src.key
		src.Clan.LastOnlineMembers[src.key]=src.LastOnline

mob/proc/CreatePrMsgWindow(var/mob/M)
	if(!("PrMsg[M.key]" in src.OpenWindows))
		src.OpenedWindow("PrMsg[M.key]")
		winclone(src,"PrMsgWindow","PrMsg[M.key]")
		winset(src,"PrMsg[M.key].PrMsgInput","command='PrivateMessage [M.key], '")
		winset(src,"PrMsg[M.key]","title='PM: [M.key]';pos=100,100;size=400x300;on-close='ClosedWindow PrMsg[M.key]'")
		return 1
var/K1=0

mob/proc/SementedosDeuses()
	if(usr.PL<usr.MaxPL)
		usr.PL=usr.MaxPL
	if(usr.Ki<usr.MaxKi)
		usr.Ki=usr.MaxKi
	return 1
var/list/MonthDays=list(31,28,31,30,31,30,31,31,30,31,30,31)
proc/ReadableLastDate(var/BaseDate)
	if(!BaseDate)	return "Desconhecido"
	if(BaseDate==time2text(world.timeofday,"YYMMDD"))	return "Hoje"

	var/LastDay=text2num(copytext(BaseDate,5))
	var/ThisDay=text2num(time2text(world.timeofday,"DD"))
	var/DaysOffline=ThisDay-LastDay

	var/LastMonth=text2num(copytext(BaseDate,3,5))
	var/ThisMonth=text2num(time2text(world.timeofday,"MM"))
	var/MonthsOffline=ThisMonth-LastMonth

	var/LastYear=text2num(copytext(BaseDate,1,3))
	var/ThisYear=text2num(time2text(world.timeofday,"YY"))
	var/YearsOffline=ThisYear-LastYear

	if(YearsOffline>=1)
		if(LastMonth>ThisMonth)	{YearsOffline-=1;MonthsOffline=ThisMonth+12-LastMonth}
		if(LastMonth==ThisMonth)	if(LastDay>ThisDay)	{YearsOffline-=1;MonthsOffline=11;DaysOffline=ThisDay+MonthDays[LastMonth]-LastDay}
	if(MonthsOffline>=1)	if(LastDay>ThisDay)	{MonthsOffline-=1;DaysOffline=ThisDay+MonthDays[LastMonth]-LastDay}

	var/DateTag=""
	if(YearsOffline)	DateTag+="[YearsOffline] anos"
	if(MonthsOffline)
		if(DateTag)	DateTag+=", "
		DateTag+="[MonthsOffline] meses"
	if(DaysOffline)
		if(DateTag)	DateTag+=", "
		if(DateTag || DaysOffline>1)	DateTag+="[DaysOffline] dias"
		else	return "Ontem"
	return "[DateTag] atrás"
proc/DeleteBum()
	while(1)
		for(var/obj/O in world)
			if(O.icon=='Bum.dmi')
				del O
proc/DeleteCrater()
	while(1)
		sleep(600*3)
		world<<"<b><i><font color=[rgb(0,100,183)]>O mundo foi restaurado."
		for(var/obj/O in world)
			if(O.icon=='crater.dmi' || O.icon=='BigShockwave.dmi')
				del O
		for(var/obj/K in world)
			if(K.icon=='Poeira.dmi' || K.icon=='Poeira2.dmi' || K.icon=='Poeira3.dmi' || K.icon=='Poeira4.dmi')
				del K
		for(var/obj/J in world)
			if(J.icon=='HKL.dmi' || J.icon=='HKL2.dmi')
				del J
		for(var/obj/B in world)
			if(B.icon=='Bum.dmi')
				del B
var/list/Locations=list("Cidade do Norte","Cidade do Sul","Cidade Central","Torneio de Artes Marciais","Torre de Kamissama","Casa do Kame","Grande Patriarca")
obj/Cratera
	density=0
	layer=3
	Cratera
		icon='crater.dmi'
		icon_state="2,1"
		pixel_x=16
		pixel_y=-5

obj/Explosion
	density=0
	layer=6
	Explosion
		icon='Bum.dmi'
		icon_state="0,0"
		pixel_x=-16

obj/Poeira
	density=0
	layer=6
	Poeira
		icon='Poeira.dmi'
		pixel_x=-30

obj/Poeira2
	density=0
	layer=6
	Poeira2
		icon='Poeira2.dmi'
		pixel_x=30

obj/Poeira3
	density=0
	layer=6
	Poeira3
		icon='Poeira3.dmi'
		pixel_y=32
		pixel_x=-5

obj/Poeira4
	density=0
	layer=6
	Poeira4
		icon='Poeira4.dmi'
		pixel_y=-32
		pixel_x=5

obj/Minicrater
	density=0
	layer=3.5
	Minicrater
		icon='HKL2.dmi'

obj/GodAura
	density=0
	layer=3.5
	GodAura
		icon='SSGAura.dmi'
		icon_state="0,0"
		pixel_x=-16
obj/GodAura2
	density=0
	layer=5
	GodAura2
		icon='SSGAura.dmi'
		icon_state="0,1"
		pixel_x=-16
		pixel_y=32
obj/GodAura3
	density=0
	layer=3.5
	GodAura3
		icon='SSGAura.dmi'
		icon_state="1,0"
		pixel_x=16
obj/GodAura4
	density=0
	layer=5
	GodAura4
		icon='SSGAura.dmi'
		icon_state="1,1"
		pixel_x=16
		pixel_y=32
mob/KiBlaster
	density=1
	icon='NPCs.dmi'
	icon_state="machine"
	Team="Enemy"
	var/dono=""
	layer=5

	KiBlaster
/*var/obj/Chuva/C=new
					var/obj/Darkness/D=new
					src.client.screen+=C*/
obj/Chat
	icon='Whiteness.dmi'
	screen_loc="10,8:20 to 16,9:10"
	layer=2
obj/Chuva
	icon='rain.dmi'
	icon_state="storm"
	screen_loc="SOUTHWEST to NORTHEAST"
	layer=1007

obj/Darkness
	icon='escuro.dmi'
	screen_loc="SOUTHWEST to NORTHEAST"
	layer=1008
obj/Poca
	icon='rain.dmi'
	icon_state="puddle"
	density=0
	layer=3
proc/Puddle()
	for(var/i=1;i<=50;i++)
		var/obj/Poca/O=new
		O.loc=locate(rand(25,370),rand(27,270),1)
		sleep(1)
mob/proc
	AddItem(var/mob/M,var/obj/items/Roupas/I)
		if(I=="KameGiShirt")
			var/obj/O=new;O.icon='KameGi_Shirt.dmi';O.layer=8
			if(I.Equipado==1)	M.overlays+=O
			else	M.overlays-=O
	CalculateTransformations()
		if(src.Character.Race=="Saiyajin")
			if(src.CurTrans==1)	src.Boost=1.3
			else
				if(src.CurTrans==2)	src.Boost=1.5
				else
					if(src.CurTrans==3)	src.Boost=1.7
					else	src.Boost=2
			src.Str=src.Boost*src.BaseStr
			src.Def=src.Boost*src.BaseDef
			src.MaxPL=src.Boost*src.BaseMaxPL
			src.PL=src.Boost*src.BasePL
			src.MaxKi=src.Boost*src.BaseMaxKi
			src.Ki=src.Boost*src.BaseKi

	GenerateMullets()
		var/obj/I=new(src.icon)
		I.icon='HairSS4(Mullet).dmi';I.layer=15
		I.pixel_y=8;src.overlays+=I
	GenerateHair1SS4()
		var/obj/I=new(src.icon)
		I.icon='Hair1SS4.dmi';I.layer=15
		I.pixel_y=8;src.overlays+=I
	TakeMullets()
		var/obj/I=new(src.icon)
		I.icon='HairSS4(Mullet).dmi';I.layer=15
		I.pixel_y=8;src.overlays-=I
	TakeHair1SS4()
		var/obj/I=new(src.icon)
		I.icon='Hair1SS4.dmi';I.layer=15
		I.pixel_y=8;src.overlays-=I
	CheckHairstyle()
		if(findtext(src.Character.Race,"Saiyajin") || findtext(src.Character.Race,"Humano"))
			if(src.CurTrans==0)
				if(src.HairStyle==1)
					src.TakeHair1()
					src.TakeHair1SS()
					src.TakeHair1SS2()
					src.TakeHairSS3()
					src.TakeHair1SS4()
					src.TakeMullets()
					src.TakeHair1SSBlue()
					src.GenerateHair1()
				if(src.HairStyle==2)
					src.TakeHair2()
					src.TakeHair2SS()
					src.TakeHair2SS2()
					src.TakeHairSS3()
					src.TakeHair2SSBlue()
					src.GenerateHair2()
				if(src.HairStyle==3)
					src.TakeHair3()
					src.TakeHair3SS()
					src.TakeHair3SS2()
					src.TakeHairSS3()
					src.TakeHair3SSBlue()
					src.GenerateHair3()
				if(src.HairStyle==4)
					src.TakeHair4()
					src.TakeHair4SS()
					src.TakeHair4SS2()
					src.TakeHairSS3()
					src.TakeHair4SSBlue()
					src.GenerateHair4()
			else
				if(src.HairStyle==1 && src.CurTrans==1) //Goku indo pro SSJ1
					src.TakeHair1()
					src.TakeHair1SS()
					src.TakeHair1SS2()
					src.TakeHairSS3()
					src.GenerateHair1SS()
				if(src.HairStyle==1 && src.CurTrans==2) //Goku indo pro SSJ2
					src.TakeHair1()
					src.TakeHair1SS()
					src.TakeHair1SS2()
					src.TakeHairSS3()
					src.GenerateHair1SS2()
				if(src.HairStyle==1 && src.CurTrans==4) //Goku indo pro SSJBlue
					if(!findtext(src.Character.name,"Cauda"))
						src.TakeHair1()
						src.TakeHair1SS()
						src.TakeHair1SS2()
						src.TakeHairSS3()
						src.GenerateHair1SSBlue()
					else
						src.TakeHair1()
						src.TakeHair1SS()
						src.TakeHair1SS2()
						src.TakeHairSS3()
						src.GenerateHair1SS4()
						src.GenerateMullets()
				if(src.HairStyle==2 && src.CurTrans==1) //Vegeta indo pro SSJ1
					src.TakeHair2()
					src.TakeHair2SS()
					src.TakeHair2SS2()
					src.TakeHairSS3()
					src.GenerateHair2SS()
				if(src.HairStyle==2 && src.CurTrans==2)	//Vegeta indo pro SSJ2
					src.TakeHair2()
					src.TakeHair2SS()
					src.TakeHair2SS2()
					src.TakeHairSS3()
					src.GenerateHair2SS2()
				if(src.HairStyle==2 && src.CurTrans==4) //Vegeta indo pro SSJBlue
					if(!findtext(src.Character.name,"Cauda"))
						src.TakeHair2()
						src.TakeHair2SS()
						src.TakeHair2SS2()
						src.TakeHairSS3()
						src.GenerateHair2SSBlue()
					else
						src.TakeHair1()
						src.TakeHair1SS()
						src.TakeHair1SS2()
						src.TakeHairSS3()
						src.GenerateHair2()
						src.GenerateMullets()
				if(src.HairStyle==3 && src.CurTrans==1)	//Gohan indo pro SSJ1
					src.TakeHair3()
					src.TakeHair3SS()
					src.TakeHair3SS2()
					src.TakeHairSS3()
					src.GenerateHair3SS()
				if(src.HairStyle==3 && src.CurTrans==2)	//Gohan indo pro SSJ2
					src.TakeHair3()
					src.TakeHair3SS()
					src.TakeHair3SS2()
					src.TakeHairSS3()
					src.GenerateHair3SS2()
				if(src.HairStyle==3 && src.CurTrans==4) //Gohan indo pro SSJBlue
					if(!findtext(src.Character.name,"Cauda"))
						src.TakeHair3()
						src.TakeHair3SS()
						src.TakeHair3SS2()
						src.TakeHairSS3()
						src.GenerateHair3SSBlue()
					else
						src.TakeHair1()
						src.TakeHair1SS()
						src.TakeHair1SS2()
						src.TakeHairSS3()
						src.GenerateHair3()
						src.GenerateMullets()
				if(src.HairStyle==4 && src.CurTrans==1)	//Gogeta indo pro SSJ1
					src.TakeHair4()
					src.TakeHair4SS()
					src.TakeHair4SS2()
					src.TakeHairSS3()
					src.GenerateHair4SS()
				if(src.HairStyle==4 && src.CurTrans==2)	//Gogeta indo pro SSJ2
					src.TakeHair4()
					src.TakeHair4SS()
					src.TakeHair4SS2()
					src.TakeHairSS3()
					src.GenerateHair4SS2()
				if(src.HairStyle==4 && src.CurTrans==4) //Gogeta indo pro SSJBlue
					if(!findtext(src.Character.name,"Cauda"))
						src.TakeHair4()
						src.TakeHair4SS()
						src.TakeHair4SS2()
						src.TakeHairSS3()
						src.GenerateHair4SSBlue()
					else
						src.TakeHair1()
						src.TakeHair1SS()
						src.TakeHair1SS2()
						src.TakeHairSS3()
						src.GenerateHair4()
						src.GenerateMullets()
				if(src.CurTrans==3)	src.GenerateHairSS3()
	BigDust(var/mob/M)
		var/obj/J=new(M.loc);J.icon='NewDust.dmi';J.icon_state="3,1";J.pixel_x=-16;J.pixel_y=-16;J.layer=3
		var/obj/I=new(J.loc);I.icon='NewDust.dmi';I.layer=3
		I.icon_state="4,1";I.pixel_x=32;I.pixel_y=0;J.overlays+=I
		I.icon_state="5,1";I.pixel_x=64;I.pixel_y=0;J.overlays+=I
		I.icon_state="6,1";I.pixel_x=96;I.pixel_y=0;J.overlays+=I
		I.icon_state="7,1";I.pixel_x=128;I.pixel_y=0;J.overlays+=I
		I.icon_state="2,1";I.pixel_x=-32;I.pixel_y=0;J.overlays+=I
		I.icon_state="1,1";I.pixel_x=-64;I.pixel_y=0;J.overlays+=I
		I.icon_state="0,1";I.pixel_x=-96;I.pixel_y=0;J.overlays+=I

		I.icon_state="3,0";I.pixel_x=0;I.pixel_y=-32;J.overlays+=I
		I.icon_state="4,0";I.pixel_x=32;I.pixel_y=-32;J.overlays+=I
		I.icon_state="5,0";I.pixel_x=64;I.pixel_y=-32;J.overlays+=I
		I.icon_state="6,0";I.pixel_x=96;I.pixel_y=-32;J.overlays+=I
		I.icon_state="7,0";I.pixel_x=128;I.pixel_y=-32;J.overlays+=I
		I.icon_state="2,0";I.pixel_x=-32;I.pixel_y=-32;J.overlays+=I
		I.icon_state="1,0";I.pixel_x=-64;I.pixel_y=-32;J.overlays+=I
		I.icon_state="0,0";I.pixel_x=-96;I.pixel_y=-32;J.overlays+=I

		I.icon_state="3,2";I.pixel_x=0;I.pixel_y=32;J.overlays+=I
		I.icon_state="4,2";I.pixel_x=32;I.pixel_y=32;J.overlays+=I
		I.icon_state="5,2";I.pixel_x=64;I.pixel_y=32;J.overlays+=I
		I.icon_state="6,2";I.pixel_x=96;I.pixel_y=32;J.overlays+=I
		I.icon_state="7,2";I.pixel_x=128;I.pixel_y=32;J.overlays+=I
		I.icon_state="2,2";I.pixel_x=-32;I.pixel_y=32;J.overlays+=I
		I.icon_state="1,2";I.pixel_x=-64;I.pixel_y=32;J.overlays+=I
		I.icon_state="0,2";I.pixel_x=-96;I.pixel_y=32;J.overlays+=I

	ShockWaveNew(var/mob/K, var/RangeX=0, var/RangeY=0)
//1
		var/obj/I=new;I.icon='BigShockwave.dmi';I.layer=16
		var/obj/J=new(K.loc);J.loc=K.loc;J.pixel_y=RangeY;J.pixel_x=RangeX;J.icon='BigShockwave.dmi';J.layer=6
		I.icon_state="Shockwave 9,4";I.pixel_x=160;I.pixel_y=0;J.overlays+=I
		I.icon_state="Shockwave 8,4";I.pixel_x=128;I.pixel_y=0;J.overlays+=I
		I.icon_state="Shockwave 7,4";I.pixel_x=96;I.pixel_y=0;J.overlays+=I
		I.icon_state="Shockwave 6,4";I.pixel_x=64;I.pixel_y=0;J.overlays+=I
		I.icon_state="Shockwave 5,4";I.pixel_x=32;I.pixel_y=0;J.overlays+=I
		I.icon_state="Shockwave 4,4";I.pixel_x=0;I.pixel_y=0;J.overlays+=I
		I.icon_state="Shockwave 3,4";I.pixel_x=-32;I.pixel_y=0;J.overlays+=I
		I.icon_state="Shockwave 2,4";I.pixel_x=-64;I.pixel_y=0;J.overlays+=I
		I.icon_state="Shockwave 1,4";I.pixel_x=-96;I.pixel_y=0;J.overlays+=I
		I.icon_state="Shockwave 0,4";I.pixel_x=-128;I.pixel_y=0;J.overlays+=I
//2
		I.icon_state="Shockwave 9,3";I.pixel_x=160;I.pixel_y=-32;J.overlays+=I
		I.icon_state="Shockwave 8,3";I.pixel_x=128;I.pixel_y=-32;J.overlays+=I
		I.icon_state="Shockwave 7,3";I.pixel_x=96;I.pixel_y=-32;J.overlays+=I
		I.icon_state="Shockwave 6,3";I.pixel_x=64;I.pixel_y=-32;J.overlays+=I
		I.icon_state="Shockwave 5,3";I.pixel_x=32;I.pixel_y=-32;J.overlays+=I
		I.icon_state="Shockwave 4,3";I.pixel_x=0;I.pixel_y=-32;J.overlays+=I
		I.icon_state="Shockwave 3,3";I.pixel_x=-32;I.pixel_y=-32;J.overlays+=I
		I.icon_state="Shockwave 2,3";I.pixel_x=-64;I.pixel_y=-32;J.overlays+=I
		I.icon_state="Shockwave 1,3";I.pixel_x=-96;I.pixel_y=-32;J.overlays+=I
		I.icon_state="Shockwave 0,3";I.pixel_x=-128;I.pixel_y=-32;J.overlays+=I
//3
		I.icon_state="Shockwave 9,2";I.pixel_x=160;I.pixel_y=-64;J.overlays+=I
		I.icon_state="Shockwave 8,2";I.pixel_x=128;I.pixel_y=-64;J.overlays+=I
		I.icon_state="Shockwave 7,2";I.pixel_x=96;I.pixel_y=-64;J.overlays+=I
		I.icon_state="Shockwave 6,2";I.pixel_x=64;I.pixel_y=-64;J.overlays+=I
		I.icon_state="Shockwave 5,2";I.pixel_x=32;I.pixel_y=-64;J.overlays+=I
		I.icon_state="Shockwave 4,2";I.pixel_x=0;I.pixel_y=-64;J.overlays+=I
		I.icon_state="Shockwave 3,2";I.pixel_x=-32;I.pixel_y=-64;J.overlays+=I
		I.icon_state="Shockwave 2,2";I.pixel_x=-64;I.pixel_y=-64;J.overlays+=I
		I.icon_state="Shockwave 1,2";I.pixel_x=-96;I.pixel_y=-64;J.overlays+=I
		I.icon_state="Shockwave 0,2";I.pixel_x=-128;I.pixel_y=-64;J.overlays+=I
//4
		I.icon_state="Shockwave 9,1";I.pixel_x=160;I.pixel_y=-96;J.overlays+=I
		I.icon_state="Shockwave 8,1";I.pixel_x=128;I.pixel_y=-96;J.overlays+=I
		I.icon_state="Shockwave 7,1";I.pixel_x=96;I.pixel_y=-96;J.overlays+=I
		I.icon_state="Shockwave 6,1";I.pixel_x=64;I.pixel_y=-96;J.overlays+=I
		I.icon_state="Shockwave 5,1";I.pixel_x=32;I.pixel_y=-96;J.overlays+=I
		I.icon_state="Shockwave 4,1";I.pixel_x=0;I.pixel_y=-96;J.overlays+=I
		I.icon_state="Shockwave 3,1";I.pixel_x=-32;I.pixel_y=-96;J.overlays+=I
		I.icon_state="Shockwave 2,1";I.pixel_x=-64;I.pixel_y=-96;J.overlays+=I
		I.icon_state="Shockwave 1,1";I.pixel_x=-96;I.pixel_y=-96;J.overlays+=I
		I.icon_state="Shockwave 0,1";I.pixel_x=-128;I.pixel_y=-96;J.overlays+=I
//5
		I.icon_state="Shockwave 9,0";I.pixel_x=160;I.pixel_y=-128;J.overlays+=I
		I.icon_state="Shockwave 8,0";I.pixel_x=128;I.pixel_y=-128;J.overlays+=I
		I.icon_state="Shockwave 7,0";I.pixel_x=96;I.pixel_y=-128;J.overlays+=I
		I.icon_state="Shockwave 6,0";I.pixel_x=64;I.pixel_y=-128;J.overlays+=I
		I.icon_state="Shockwave 5,0";I.pixel_x=32;I.pixel_y=-128;J.overlays+=I
		I.icon_state="Shockwave 4,0";I.pixel_x=0;I.pixel_y=-128;J.overlays+=I
		I.icon_state="Shockwave 3,0";I.pixel_x=-32;I.pixel_y=-128;J.overlays+=I
		I.icon_state="Shockwave 2,0";I.pixel_x=-64;I.pixel_y=-128;J.overlays+=I
		I.icon_state="Shockwave 1,0";I.pixel_x=-96;I.pixel_y=-128;J.overlays+=I
		I.icon_state="Shockwave 0,0";I.pixel_x=-128;I.pixel_y=-128;J.overlays+=I
//6
		I.icon_state="Shockwave 9,5";I.pixel_x=160;I.pixel_y=32;J.overlays+=I
		I.icon_state="Shockwave 8,5";I.pixel_x=128;I.pixel_y=32;J.overlays+=I
		I.icon_state="Shockwave 7,5";I.pixel_x=96;I.pixel_y=32;J.overlays+=I
		I.icon_state="Shockwave 6,5";I.pixel_x=64;I.pixel_y=32;J.overlays+=I
		I.icon_state="Shockwave 5,5";I.pixel_x=32;I.pixel_y=32;J.overlays+=I
		I.icon_state="Shockwave 4,5";I.pixel_x=0;I.pixel_y=32;J.overlays+=I
		I.icon_state="Shockwave 3,5";I.pixel_x=-32;I.pixel_y=32;J.overlays+=I
		I.icon_state="Shockwave 2,5";I.pixel_x=-64;I.pixel_y=32;J.overlays+=I
		I.icon_state="Shockwave 1,5";I.pixel_x=-96;I.pixel_y=32;J.overlays+=I
		I.icon_state="Shockwave 0,5";I.pixel_x=-128;I.pixel_y=32;J.overlays+=I
//7
		I.icon_state="Shockwave 9,6";I.pixel_x=160;I.pixel_y=64;J.overlays+=I
		I.icon_state="Shockwave 8,6";I.pixel_x=128;I.pixel_y=64;J.overlays+=I
		I.icon_state="Shockwave 7,6";I.pixel_x=96;I.pixel_y=64;J.overlays+=I
		I.icon_state="Shockwave 6,6";I.pixel_x=64;I.pixel_y=64;J.overlays+=I
		I.icon_state="Shockwave 5,6";I.pixel_x=32;I.pixel_y=64;J.overlays+=I
		I.icon_state="Shockwave 4,6";I.pixel_x=0;I.pixel_y=64;J.overlays+=I
		I.icon_state="Shockwave 3,6";I.pixel_x=-32;I.pixel_y=64;J.overlays+=I
		I.icon_state="Shockwave 2,6";I.pixel_x=-64;I.pixel_y=64;J.overlays+=I
		I.icon_state="Shockwave 1,6";I.pixel_x=-96;I.pixel_y=64;J.overlays+=I
		I.icon_state="Shockwave 0,6";I.pixel_x=-128;I.pixel_y=64;J.overlays+=I
//8
		I.icon_state="Shockwave 9,7";I.pixel_x=160;I.pixel_y=96;J.overlays+=I
		I.icon_state="Shockwave 8,7";I.pixel_x=128;I.pixel_y=96;J.overlays+=I
		I.icon_state="Shockwave 7,7";I.pixel_x=96;I.pixel_y=96;J.overlays+=I
		I.icon_state="Shockwave 6,7";I.pixel_x=64;I.pixel_y=96;J.overlays+=I
		I.icon_state="Shockwave 5,7";I.pixel_x=32;I.pixel_y=96;J.overlays+=I
		I.icon_state="Shockwave 4,7";I.pixel_x=0;I.pixel_y=96;J.overlays+=I
		I.icon_state="Shockwave 3,7";I.pixel_x=-32;I.pixel_y=96;J.overlays+=I
		I.icon_state="Shockwave 2,7";I.pixel_x=-64;I.pixel_y=96;J.overlays+=I
		I.icon_state="Shockwave 1,7";I.pixel_x=-96;I.pixel_y=96;J.overlays+=I
		I.icon_state="Shockwave 0,7";I.pixel_x=-128;I.pixel_y=96;J.overlays+=I
//9
		I.icon_state="Shockwave 9,8";I.pixel_x=160;I.pixel_y=128;J.overlays+=I
		I.icon_state="Shockwave 8,8";I.pixel_x=128;I.pixel_y=128;J.overlays+=I
		I.icon_state="Shockwave 7,8";I.pixel_x=96;I.pixel_y=128;J.overlays+=I
		I.icon_state="Shockwave 6,8";I.pixel_x=64;I.pixel_y=128;J.overlays+=I
		I.icon_state="Shockwave 5,8";I.pixel_x=32;I.pixel_y=128;J.overlays+=I
		I.icon_state="Shockwave 4,8";I.pixel_x=0;I.pixel_y=128;J.overlays+=I
		I.icon_state="Shockwave 3,8";I.pixel_x=-32;I.pixel_y=128;J.overlays+=I
		I.icon_state="Shockwave 2,8";I.pixel_x=-64;I.pixel_y=128;J.overlays+=I
		I.icon_state="Shockwave 1,8";I.pixel_x=-96;I.pixel_y=128;J.overlays+=I
		I.icon_state="Shockwave 0,8";I.pixel_x=-128;I.pixel_y=128;J.overlays+=I
//10
		I.icon_state="Shockwave 9,9";I.pixel_x=160;I.pixel_y=160;J.overlays+=I
		I.icon_state="Shockwave 8,9";I.pixel_x=128;I.pixel_y=160;J.overlays+=I
		I.icon_state="Shockwave 7,9";I.pixel_x=96;I.pixel_y=160;J.overlays+=I
		I.icon_state="Shockwave 6,9";I.pixel_x=64;I.pixel_y=160;J.overlays+=I
		I.icon_state="Shockwave 5,9";I.pixel_x=32;I.pixel_y=160;J.overlays+=I
		I.icon_state="Shockwave 4,9";I.pixel_x=0;I.pixel_y=160;J.overlays+=I
		I.icon_state="Shockwave 3,9";I.pixel_x=-32;I.pixel_y=160;J.overlays+=I
		I.icon_state="Shockwave 2,9";I.pixel_x=-64;I.pixel_y=160;J.overlays+=I
		I.icon_state="Shockwave 1,9";I.pixel_x=-96;I.pixel_y=160;J.overlays+=I
		I.icon_state="Shockwave 0,9";I.pixel_x=-128;I.pixel_y=160;J.overlays+=I
		for(var/mob/Player/P in world)
			if(K.z==P.z)
				if(abs(P.x-K.x)<=12 || abs(P.y-K.y)<=7)	P.PowerUpShake()
	AddCharge(var/mob/M)
		var/obj/I=new;I.icon='Charge.dmi';I.layer=6
		M.overlays+=I
	RemoveCharge(var/mob/M)
		var/obj/I=new;I.icon='Charge.dmi';I.layer=6
		M.overlays-=I
	AddAuraNew(var/mob/M)
	//	if(usr.Character.Race=="Saiyajin" && usr.CurTrans!=0)	return
		var/obj/I=new;I.icon='BaseAura.dmi';I.layer=3.5
		I.icon_state="0,0";I.pixel_x=-16;M.overlays+=I
		I.icon_state="1,0";I.pixel_x=16;M.overlays+=I
		I.icon_state="0,1";I.pixel_x=-16;I.pixel_y=32;M.overlays+=I
		I.icon_state="1,1";I.pixel_x=16;I.pixel_y=32;M.overlays+=I
		I.icon_state="0,2";I.pixel_x=-16;I.pixel_y=64;M.overlays+=I
		I.icon_state="1,2";I.pixel_x=16;I.pixel_y=64;M.overlays+=I
	AddAuraNewSS(var/mob/M)
	//	if(usr.Character.Race=="Saiyajin" && usr.CurTrans!=0)	return
		var/obj/I=new;I.icon='BaseAuraSS.dmi';I.layer=3.5
		I.icon_state="0,0";I.pixel_x=-16;M.overlays+=I
		I.icon_state="1,0";I.pixel_x=16;M.overlays+=I
		I.icon_state="0,1";I.pixel_x=-16;I.pixel_y=32;M.overlays+=I
		I.icon_state="1,1";I.pixel_x=16;I.pixel_y=32;M.overlays+=I
		I.icon_state="0,2";I.pixel_x=-16;I.pixel_y=64;M.overlays+=I
		I.icon_state="1,2";I.pixel_x=16;I.pixel_y=64;M.overlays+=I
	RemoveAuraNew(var/mob/M)
	//	if(usr.Character.Race=="Saiyajin" && usr.CurTrans!=0)	return
		var/obj/I=new;I.icon='BaseAura.dmi';I.layer=3.5
		I.icon_state="0,0";I.pixel_x=-16;M.overlays-=I
		I.icon_state="1,0";I.pixel_x=16;M.overlays-=I
		I.icon_state="0,1";I.pixel_x=-16;I.pixel_y=32;M.overlays-=I
		I.icon_state="1,1";I.pixel_x=16;I.pixel_y=32;M.overlays-=I
		I.icon_state="0,2";I.pixel_x=-16;I.pixel_y=64;M.overlays-=I
		I.icon_state="1,2";I.pixel_x=16;I.pixel_y=64;M.overlays-=I
	RemoveAuraNewSS(var/mob/M)
	//	if(usr.Character.Race=="Saiyajin" && usr.CurTrans!=0)	return
		var/obj/I=new;I.icon='BaseAuraSS.dmi';I.layer=3.5
		I.icon_state="0,0";I.pixel_x=-16;M.overlays-=I
		I.icon_state="1,0";I.pixel_x=16;M.overlays-=I
		I.icon_state="0,1";I.pixel_x=-16;I.pixel_y=32;M.overlays-=I
		I.icon_state="1,1";I.pixel_x=16;I.pixel_y=32;M.overlays-=I
		I.icon_state="0,2";I.pixel_x=-16;I.pixel_y=64;M.overlays-=I
		I.icon_state="1,2";I.pixel_x=16;I.pixel_y=64;M.overlays-=I
//ANTENA Nº1 (NORMAL)
	GenerateAntena1()
		usr.TakeAntena1()
		var/obj/I=new(usr.icon)
		if(usr.icon=='BaseNamek1.dmi')
			I.icon='HairNamek1.dmi';I.layer=15
			usr.overlays+=I
		if(usr.icon=='BaseNamek2.dmi')
			I.icon='HairNamek2.dmi';I.layer=15
			usr.overlays+=I
		if(usr.icon=='BaseNamek3.dmi')
			I.icon='HairNamek3.dmi';I.layer=15
			usr.overlays+=I
		if(usr.icon=='BaseNamek4.dmi')
			I.icon='HairNamek4.dmi';I.layer=15
			usr.overlays+=I
		if(usr.icon=='BaseNamek5.dmi')
			I.icon='HairNamek5.dmi';I.layer=15
			usr.overlays+=I
		if(usr.icon=='BaseNamek6.dmi')
			I.icon='HairNamek6.dmi';I.layer=15
			usr.overlays+=I
	TakeAntena1()
	//	var/obj/I=new(usr.icon)
		usr.overlays=null
//CAUDA SAIYAJIN
	GenerateTail()
		var/obj/I=new(src)
		I.icon='CaudaSaiyajin.dmi';I.layer=15
		src.overlays+=I
	TakeTail()
		var/obj/I=new(src.icon)
		I.icon='CaudaSaiyajin.dmi';I.layer=15
		src.overlays-=I
	GenerateTailSS()					//SS1,2 e 3
		var/obj/I=new(src.icon)
		I.icon='CaudaSaiyajinSS.dmi';I.layer=15
		src.overlays+=I
	TakeTailSS()
		var/obj/I=new(src.icon)
		I.icon='CaudaSaiyajinSS.dmi';I.layer=15
		src.overlays-=I
	GenerateTailSS4()					//SS4
		var/obj/I=new(src.icon)
		I.icon='CaudaSaiyajinSS4.dmi';I.layer=15
		src.overlays+=I
	TakeTailSS4()
		var/obj/I=new(src.icon)
		I.icon='CaudaSaiyajinSS4.dmi';I.layer=15
//CABELO DO GOKU
	GenerateHair1()
		var/obj/I=new(src.icon)
		I.icon='Hair1.dmi';I.layer=15
		I.pixel_y=8;src.overlays+=I
	TakeHair1()
		var/obj/I=new(src.icon)
		I.icon='Hair1.dmi';I.layer=15
		I.pixel_y=8;src.overlays-=I
//FORMAS SUPER SAIYAJINS DO HAIR1 (GOKU)
	GenerateHair1SS()
		var/obj/I=new(src.icon)
		I.icon='Hair1SS.dmi';I.layer=15
		I.pixel_y=8;src.overlays+=I
	TakeHair1SS()
		var/obj/I=new(src.icon)
		I.icon='Hair1SS.dmi';I.layer=15
		I.pixel_y=8;src.overlays-=I
	GenerateHair1SS2()
		var/obj/I=new(src.icon)
		I.icon='Hair1SS2.dmi';I.layer=15
		I.pixel_y=8;src.overlays+=I
	TakeHair1SS2()
		var/obj/I=new(src.icon)
		I.icon='Hair1SS2.dmi';I.layer=15
		I.pixel_y=8;src.overlays-=I
	GenerateHair1SSBlue()
		var/obj/I=new(src.icon)
		I.icon='Hair1SSBlue.dmi';I.layer=15
		I.pixel_y=8;src.overlays+=I
	TakeHair1SSBlue()
		var/obj/I=new(src.icon)
		I.icon='Hair1SSBlue.dmi';I.layer=15
		I.pixel_y=8;src.overlays-=I
//-----------------------------------
//CABELO DO VEGETA
	GenerateHair2()
		var/obj/I=new(src.icon)
		I.icon='Hair2.dmi';I.layer=15
		I.pixel_y=8;src.overlays+=I
	TakeHair2()
		var/obj/I=new(src.icon)
		I.icon='Hair2.dmi';I.layer=15
		I.pixel_y=8;src.overlays-=I
//FORMAS SUPER SAIYAJINS DO HAIR2 (VEGETA)
	GenerateHair2SS()
		var/obj/I=new(src.icon)
		I.icon='Hair2SS.dmi';I.layer=15
		I.pixel_y=8;src.overlays+=I
	TakeHair2SS()
		var/obj/I=new(src.icon)
		I.icon='Hair2SS.dmi';I.layer=15
		I.pixel_y=8;src.overlays-=I
	GenerateHair2SS2()
		var/obj/I=new(src.icon)
		I.icon='Hair2SS2.dmi';I.layer=15
		I.pixel_y=8;src.overlays+=I
	TakeHair2SS2()
		var/obj/I=new(src.icon)
		I.icon='Hair2SS2.dmi';I.layer=15
		I.pixel_y=8;src.overlays-=I
	GenerateHair2SSBlue()
		var/obj/I=new(src.icon)
		I.icon='Hair2SSBlue.dmi';I.layer=15
		I.pixel_y=8;src.overlays+=I
	TakeHair2SSBlue()
		var/obj/I=new(src.icon)
		I.icon='Hair2SSBlue.dmi';I.layer=15
		I.pixel_y=8;src.overlays-=I
//-----------------------------------
//CABELO DO GOHAN
	GenerateHair3()
		var/obj/I=new(src.icon)
		I.icon='Hair3.dmi';I.layer=15
		I.pixel_y=8;src.overlays+=I
	TakeHair3()
		var/obj/I=new(src.icon)
		I.icon='Hair3.dmi';I.layer=15
		I.pixel_y=8;src.overlays-=I
//FORMAS SUPER SAIYAJINS DO HAIR3(GOHAN)
	GenerateHair3SS()
		var/obj/I=new(src.icon)
		I.icon='Hair3SS.dmi';I.layer=15
		I.pixel_y=8;src.overlays+=I
	TakeHair3SS()
		var/obj/I=new(src.icon)
		I.icon='Hair3SS.dmi';I.layer=15
		I.pixel_y=8;src.overlays-=I
	GenerateHair3SS2()
		var/obj/I=new(src.icon)
		I.icon='Hair3SS2.dmi';I.layer=15
		I.pixel_y=8;src.overlays+=I
	TakeHair3SS2()
		var/obj/I=new(src.icon)
		I.icon='Hair3SS2.dmi';I.layer=15
		I.pixel_y=8;src.overlays-=I
	GenerateHair3SSBlue()
		var/obj/I=new(src.icon)
		I.icon='Hair3SSBlue.dmi';I.layer=15
		I.pixel_y=8;src.overlays+=I
	TakeHair3SSBlue()
		var/obj/I=new(src.icon)
		I.icon='Hair3SSBlue.dmi';I.layer=15
		I.pixel_y=8;src.overlays-=I
//-----------------------------------
//CABELO DO GOGETA
	GenerateHair4()
		var/obj/I=new(src.icon)
		I.icon='Hair4.dmi';I.layer=15
		I.pixel_y=8;src.overlays+=I

	TakeHair4()
		var/obj/I=new(src.icon)
		I.icon='Hair4.dmi';I.layer=15
		I.pixel_y=8;src.overlays-=I
//FORMAS SUPER SAIYAJINS DO HAIR4 (GOGETA)
	GenerateHair4SS()
		var/obj/I=new(src.icon)
		I.icon='Hair4SS.dmi';I.layer=15
		I.pixel_y=8;src.overlays+=I
	TakeHair4SS()
		var/obj/I=new(src.icon)
		I.icon='Hair4SS.dmi';I.layer=15
		I.pixel_y=8;src.overlays-=I
	GenerateHair4SS2()
		var/obj/I=new(src.icon)
		I.icon='Hair4SS2.dmi';I.layer=15
		I.pixel_y=8;src.overlays+=I
	TakeHair4SS2()
		var/obj/I=new(src.icon)
		I.icon='Hair4SS2.dmi';I.layer=15
		I.pixel_y=8;src.overlays-=I
	GenerateHair4SSBlue()
		var/obj/I=new(src.icon)
		I.icon='Hair4SSBlue.dmi';I.layer=15
		I.pixel_y=8;src.overlays+=I
	TakeHair4SSBlue()
		var/obj/I=new(src.icon)
		I.icon='Hair4SSBlue.dmi';I.layer=15
		I.pixel_y=8;src.overlays-=I
//-----------------------------------
//CABELO SUPER SAIYAJIN 3 PARA TODOS OS ESTILOS DE CABELO
	GenerateHairSS3()
		src.TakeHair1()
		src.TakeHair1SS()
		src.TakeHair1SS2()
		src.TakeHair2()
		src.TakeHair2SS()
		src.TakeHair2SS2()
		src.TakeHair3()
		src.TakeHair3SS()
		src.TakeHair3SS2()
		src.TakeHair4()
		src.TakeHair4SS()
		src.TakeHair4SS2()
		var/obj/I=new(src.icon)	//CABELO SSJ3 DE FRENTE E COSTAS
		I.icon='HairSS3(Front&Back).dmi';I.layer=15
		I.pixel_y=8;src.overlays+=I
		var/obj/I2=new(src.icon)		//CABELO SSJ3 DE LADO (DIREITA --> )
		I2.icon='HairSS3(Sides).dmi';I2.layer=15
		I2.pixel_y=6;I2.pixel_x=-4;src.overlays+=I2
		var/obj/I3=new(src.icon)		//CABELO SSJ3 DE LADO (ESQUERDA <-- )
		I3.icon='HairSS3(Sides2).dmi';I3.layer=15
		I3.pixel_y=6;I3.pixel_x=4;src.overlays+=I3
	TakeHairSS3()
		var/obj/I=new(src.icon)
		I.icon='HairSS3(Front&Back).dmi';I.layer=15
		I.pixel_y=8;src.overlays-=I
		var/obj/I2=new(src.icon)
		I2.icon='HairSS3(Sides).dmi';I2.layer=15
		I2.pixel_y=6;I2.pixel_x=-4;src.overlays-=I2
		var/obj/I3=new(src.icon)
		I3.icon='HairSS3(Sides2).dmi';I3.layer=15
		I3.pixel_y=6;I3.pixel_x=4;src.overlays-=I3

//-----------------------------------
	Rain()
		while(1)
			if(src.Chovendo==0)
				if(src.z==1)
					var/obj/Chuva/C=new
					var/obj/Darkness/D=new
					src.client.screen+=C
					src.client.screen+=D
					src.Chovendo=1
					PlaySound(src,null,channel=13)
					PlaySound(src,'rain.ogg',repeat=1,channel=13)
					for(var/obj/Poca/P in world)
						del	P
					Puddle()
			if(src.z!=1)
				PlaySound(src,null,channel=13)
				src.Chovendo=0
				for(var/obj/Chuva/C in src.client.screen)
					del	C
				for(var/obj/Darkness/D in src.client.screen)
					del	D
			sleep(5)
	LimitBreaker(var/mob/M)
		if(M.icon=='ShirtlessGoku.dmi')
			M.TesteBreaker=0
			return
		if(M.HasPerk("Instinto Superior"))
			goto GOTO
		M.Revert()
		M.overlays=null
		M.Breaker=1
		M.icon='UltraInstinct.dmi'
		M.icon_state="none"
		M.Frozen=1
		M.Shocking=1
		sleep(190)
		world<<sound(null)//LimitBreaker
		world<<sound('Ultra.ogg')
		M.icon_state="spark"
		sleep(10)
		M.icon_state="ultra"
		world<<"<b><i>[M] <font color=[rgb(22,72,99)]>ressurge liberando uma energia gigantesca!"
		M.Coluna(M)
		M.Crater(M)
		sleep(400)
		M.AddName()
		M.AddClanName()
		M.icon_state=""
		M.dir=2
		sleep(100)
		GOTO
		M.Frozen=0
		M.Shocking=0
		M.DamageMultiplier+=1.7
		if(M.HasPerk("Instinto Superior"))
			M<<sound('Clash2.ogg')
			M.icon='UltraInstinct.dmi'
			M.icon_state="powerup"
		else
			world<<sound('LimitBreaker.ogg')
		M.NameColor="red"
		M.Character.BeamSpecial=new/CharSpecials/Hyper_Kame
		world<<"<b><i><font color=[rgb(22,72,99)]>O Ki de [M] está extremamente calmo e poderoso!"
		M.IsUltra=1
		M.GiveMedal(new/obj/Medals/Ultra_Instinct)
		M.Breaker=0
		M.DelColuna(M)
		sleep(600*3)
		M.IsUltra=0
		M<<"<b><font color=[rgb(22,72,99)]>Você sente seu corpo voltar ao normal!"
		M.DamageMultiplier-=1.7
		M.NameColor="red"
		M.Character=new/obj/EvolCharacters/Goku_Super
		M.Character.BeamSpecial=Character.BeamSpecial
		M.Revert()
		M.icon=M.Character.icon
		M.UpdatePartyIcon()
		M.UpdateFaceHUD()
		M.ResetSuffix()
		M.AddHUD()
		M.icon=Character.icon
		M.Probabilidade=0
	Coluna(var/mob/M)
		var/obj/A=new(M.loc);A.icon='coluna.dmi';A.layer=3.1;A.density=1
		A.icon_state="";M.overlays+=A;A.layer=3.1
		A.icon_state="top";A.pixel_y=32;M.overlays+=A;A.layer=3.1
		A.icon_state="top";A.pixel_y=64;M.overlays+=A;A.layer=3.1
		A.icon_state="top";A.pixel_y=96;M.overlays+=A;A.layer=3.1
		A.icon_state="top2";A.pixel_y=128;M.overlays+=A;A.layer=3.1
	DelColuna(var/mob/M)
		for(var/obj/A in world)
			if(A.icon=='coluna.dmi')
				del	A
		M.overlays=null
		M.AddName()
		M.AddClanName()
	GiveEnergy()
		for(var/mob/Player/P in world)
			if(src!=P)
				var/Choice=alert(P,"[src] está realizando uma Genki-Dama! Deseja dar sua energia para ajudar [src]?","Genki-Dama","Sim","Não")
				if(Choice=="Sim")
					src.Pessoas+=1
					src<<"[P.name] deu energia para você!"
					P.TakeKiPercent(100)
					P.UpdateKiHUD()
				else	return
	SB2(var/mob/M)
		var/obj/A=new;A.icon='SpiritBomb.dmi';A.layer=9
		A.icon_state="Sb1";A.pixel_y=32;M.overlays+=A
	SB3(var/mob/M)
		var/obj/A=new;A.icon='SpiritBomb.dmi';A.layer=9
		A.icon_state="Sb2";A.pixel_y=32;M.overlays+=A
	DelSB2(var/mob/M)
		var/obj/A=new;A.icon='SpiritBomb.dmi';A.layer=9
		A.icon_state="Sb1";A.pixel_y=32;M.overlays-=A
	DelSB3(var/mob/M)
		var/obj/A=new;A.icon='SpiritBomb.dmi';A.layer=9
		A.icon_state="Sb2";A.pixel_y=32;M.overlays-=A
	DB1(var/mob/M)
		var/obj/A=new;A.icon='DB.dmi';A.layer=9
		A.icon_state="";A.pixel_y=32;M.overlays+=A
	DelDB1(var/mob/M)
		var/obj/A=new;A.icon='DB.dmi';A.layer=9
		A.icon_state="";A.pixel_y=32;M.overlays-=A
	DB2(var/mob/M)
		var/obj/A=new;A.icon='DB.dmi';A.layer=9
		A.icon_state="0,0";A.pixel_y=32;A.pixel_x=-16;M.overlays+=A
		A.icon_state="0,1";A.pixel_y=64;A.pixel_x=-16;M.overlays+=A
		A.icon_state="1,1";A.pixel_y=64;A.pixel_x=16;M.overlays+=A
		A.icon_state="1,0";A.pixel_y=32;M.overlays+=A
	DelDB2(var/mob/M)
		var/obj/A=new;A.icon='DB.dmi';A.layer=9
		A.icon_state="0,0";A.pixel_y=32;A.pixel_x=-16;M.overlays-=A
		A.icon_state="0,1";A.pixel_y=64;A.pixel_x=-16;M.overlays-=A
		A.icon_state="1,1";A.pixel_y=64;A.pixel_x=16;M.overlays-=A
		A.icon_state="1,0";A.pixel_y=32;M.overlays-=A
	SB1(var/mob/M)
		var/obj/A=new;A.icon='SpiritBomb.dmi';A.layer=9
		A.icon_state="sb bottom 2";A.pixel_y=32;M.overlays+=A
		A.icon_state="sb bottom 3";A.pixel_y=32;A.pixel_x=32;M.overlays+=A
		A.icon_state="sb bottom 1";A.pixel_y=32;A.pixel_x=-32;M.overlays+=A
		A.icon_state="sb center";A.pixel_y=64;A.pixel_x=0;M.overlays+=A
		A.icon_state="sb side 1";A.pixel_y=64;A.pixel_x=-32;M.overlays+=A
		A.icon_state="sb side 2";A.pixel_y=64;A.pixel_x=32;M.overlays+=A
		A.icon_state="sb top 2";A.pixel_y=96;A.pixel_x=0;M.overlays+=A
		A.icon_state="sb top 3";A.pixel_y=96;A.pixel_x=32;M.overlays+=A
		A.icon_state="sb top 1";A.pixel_y=96;A.pixel_x=-32;M.overlays+=A
	DelSB1(var/mob/M)
		var/obj/A=new;A.icon='SpiritBomb.dmi';A.layer=9
		A.icon_state="sb bottom 2";A.pixel_y=32;M.overlays-=A
		A.icon_state="sb bottom 3";A.pixel_y=32;A.pixel_x=32;M.overlays-=A
		A.icon_state="sb bottom 1";A.pixel_y=32;A.pixel_x=-32;M.overlays-=A
		A.icon_state="sb center";A.pixel_y=64;A.pixel_x=0;M.overlays-=A
		A.icon_state="sb side 1";A.pixel_y=64;A.pixel_x=-32;M.overlays-=A
		A.icon_state="sb side 2";A.pixel_y=64;A.pixel_x=32;M.overlays-=A
		A.icon_state="sb top 2";A.pixel_y=96;A.pixel_x=0;M.overlays-=A
		A.icon_state="sb top 3";A.pixel_y=96;A.pixel_x=32;M.overlays-=A
		A.icon_state="sb top 1";A.pixel_y=96;A.pixel_x=-32;M.overlays-=A
	KiTraining(var/mob/M)
		var/mob/KiBlaster/KiBlaster/K=new()
		var/variation=pick(0,1,2,3)
		if(M.Alignment==55)
			K.loc=locate(278,206+variation,8)
		if(M.Alignment==56)
			K.loc=locate(300,206+variation,8)
		if(M.Alignment==57)
			K.loc=locate(322,206+variation,8)
		K.dono=M
		M.dir=8
		M.loc=K.loc
		M.x+=7
		M.Training="Ki Training"
		while(1)
			if(M.Training!="Ki Training" && K.dono==M)
				del	K
/*			if(M.x<K.x)
				K.dir=8
			if(M.x>K.x)
				K.dir=4
			if(M.y<K.y)
				K.dir=2
			if(M.y>K.y)
				K.dir=1*/
			K.dir=4
			K.icon_state="machine"
			K.KiBlast()
			K.Ki+=1000
			K.Def=100000
			K.PL=100000
			var/tempo=pick(5,10,15)
			sleep(tempo)
/*	Evolution(var/mob/M)
		if(M.icon=='PiccoloTrainedGohan.dmi' && RefuseGohan==0)
			if(M.Gohan==0 && M.MaxPL>=200000 && M.MaxKi>=200000 && M.Str>=2000 && M.Def>=1000)
				M.client.eye=locate(43,392,8)
				M<<sound(null)
				M<<sound('Char.ogg')
				M.RemoveHUD()
				M.Fighting=1
				RETORNO
				var/Choice=alert(M,"Você deseja transceder o seu personagem?","Transcedência","Sim","Não")
				if(Choice=="Sim")
					var/Choice1=alert(M,"O seu personagem possui duas diferentes evoluções. Qual você escolhe?","Transcedência","Gohan do Futuro","Gohan Adolescente")
					if(Choice1=="Gohan do Futuro")
						M.Gohan=5
						M.Character=new/obj/EvolCharacters/Future_Gohan
						M.Revert()
						M.icon=M.Character.icon
						M.UpdatePartyIcon()
						M.UpdateFaceHUD()
						M.ResetSuffix()
						M.AddHUD()
						M<<sound(null)
						M.Fighting=0
						M.client.eye=M.client.mob
					else
						M.Gohan=1
						M.Character=new/obj/EvolCharacters/Teen_Gohan
						M.Revert()
						M.icon=M.Character.icon
						M.UpdatePartyIcon()
						M.UpdateFaceHUD()
						M<<sound(null)
						M.Fighting=0
						M.ResetSuffix()
						M.AddHUD()
						M.client.eye=M.client.mob
				else
					var/Choice2=alert(M,"Uma vez que cancelada a transcedência, o seu personagem não poderá mais evoluir. Tem certeza?","Transcedência","Sim","Não")
					if(Choice2=="Não")
						goto RETORNO
					else
						M.AddHUD()
						M.client.eye=M.client.mob
						RefuseGohan=1
						M.Fighting=0
						M<<sound(null)
						return
		if(M.icon=='TeenGohan.dmi' && RefuseGohan==0)
			if(M.Gohan==1 && M.MaxPL>=400000 && M.MaxKi>=300000 && M.Str>=30000 && M.Def>=16000)
				M.client.eye=locate(60,392,8)
				M<<sound(null)
				M<<sound('Char.ogg')
				M.Fighting=1
				M.RemoveHUD()
				RETORNO
				var/Choice=alert(M,"Você deseja transceder o seu personagem?","Transcedência","Sim","Não")
				if(Choice=="Sim")
					M.Gohan=2
					M.Character=new/obj/EvolCharacters/Adult_Piccolo_Gohan
					M.Revert()
					M.icon=M.Character.icon
					M.UpdatePartyIcon()
					M.UpdateFaceHUD()
					M.ResetSuffix()
					M<<sound(null)
					M.Fighting=0
					M.AddHUD()
					M.client.eye=M.client.mob
				else
					var/Choice2=alert(M,"Uma vez que cancelada a transcedência, o seu personagem não poderá mais evoluir. Tem certeza?","Transcedência","Sim","Não")
					if(Choice2=="Não")
						goto RETORNO
					else
						M.AddHUD()
						M.client.eye=M.client.mob
						RefuseGohan=1
						M.Fighting=0
						M<<sound(null)
						return
		if(M.icon=='Goku Mid.dmi' && RefuseGoku==0)
			if(M.Goku==0 && M.MaxPL>=400000 && M.MaxKi>=300000 && M.Str>=30000 && M.Def>=16000)
				M.client.eye=locate(94,392,8)
				M<<sound(null)
				M<<sound('Char.ogg')
				M.RemoveHUD()
				M.Fighting=1
				RETORNO
				var/Choice=alert(M,"Você deseja transceder o seu personagem?","Transcedência","Sim","Não")
				if(Choice=="Sim")
					M.Goku=1
					M.Character=new/obj/EvolCharacters/Goku2
					M.Revert()
					M.icon=M.Character.icon
					M.UpdatePartyIcon()
					M.Fighting=0
					M<<sound(null)
					M.UpdateFaceHUD()
					M.ResetSuffix()
					M.AddHUD()
					M.client.eye=M.client.mob
				else
					var/Choice2=alert(M,"Uma vez que cancelada a transcedência, o seu personagem não poderá mais evoluir. Tem certeza?","Transcedência","Sim","Não")
					if(Choice2=="Não")
						goto RETORNO
					else
						M.AddHUD()
						M.client.eye=M.client.mob
						RefuseGoku=1
						M<<sound(null)
						M.Fighting=0
						return
		if(M.icon=='Goku2.dmi' && RefuseGoku==0)
			if(M.Goku==1 && M.MaxPL>=800000 && M.MaxKi>=500000 && M.Str>=90000 && M.Def>=48000)
				M.client.eye=locate(111,392,8)
				M<<sound(null)
				M<<sound('Char.ogg')
				M.RemoveHUD()
				M.Fighting=1
				RETORNO
				var/Choice=alert(M,"Você deseja transceder o seu personagem?","Transcedência","Sim","Não")
				if(Choice=="Sim")
					var/Choice1=alert(M,"O seu personagem possui duas diferentes evoluções. Qual você escolhe?","Transcedência","Goku Super","Goku GT")
					if(Choice1=="Goku Super")
						M.Goku=2
						M.Character=new/obj/EvolCharacters/Goku_Super
						M.Revert()
						M.icon=M.Character.icon
						M.UpdatePartyIcon()
						M.UpdateFaceHUD()
						M.ResetSuffix()
						M.AddHUD()
						M<<sound(null)
						M.Fighting=0
						M.client.eye=M.client.mob
					else
						M.Goku=3
						M.Character=new/obj/EvolCharacters/GT_Goku
						M.Revert()
						M.icon=M.Character.icon
						M.UpdatePartyIcon()
						M.UpdateFaceHUD()
						M<<sound(null)
						M.Fighting=0
						M.ResetSuffix()
						M.AddHUD()
						M.client.eye=M.client.mob
				else
					var/Choice2=alert(M,"Uma vez que cancelada a transcedência, o seu personagem não poderá mais evoluir. Tem certeza?","Transcedência","Sim","Não")
					if(Choice2=="Não")
						goto RETORNO
					else
						M.AddHUD()
						M.client.eye=M.client.mob
						RefuseGoku=1
						M<<sound(null)
						M.Fighting=0
						return
		if(M.icon=='ScouterVegeta.dmi' && RefuseVegeta==0)
			if(M.Vegeta==0  && M.MaxPL>=200000 && M.MaxKi>=200000 && M.Str>=10000 && M.Def>=4000)
				M.client.eye=locate(128,392,8)
				M<<sound(null)
				M<<sound('Char.ogg')
				M.RemoveHUD()
				M.Fighting=1
				RETORNO
				var/Choice=alert(M,"Você deseja transceder o seu personagem?","Transcedência","Sim","Não")
				if(Choice=="Sim")
					M.Vegeta=1
					M.Character=new/obj/EvolCharacters/Saiyan_Armor_Vegeta
					M.Revert()
					M.icon=M.Character.icon
					M.UpdatePartyIcon()
					M.UpdateFaceHUD()
					M<<sound(null)
					M.Fighting=0
					M.ResetSuffix()
					M.AddHUD()
					M.client.eye=M.client.mob
				else
					var/Choice2=alert(M,"Uma vez que cancelada a transcedência, o seu personagem não poderá mais evoluir. Tem certeza?","Transcedência","Sim","Não")
					if(Choice2=="Não")
						goto RETORNO
					else
						M.AddHUD()
						M.client.eye=M.client.mob
						RefuseVegeta=1
						M<<sound(null)
						M.Fighting=0
						return
		if(M.icon=='SAVegeta.dmi' && RefuseVegeta==0)
			if(M.Vegeta==1 && M.MaxPL>=400000 && M.MaxKi>=300000 && M.Str>=30000 && M.Def>=16000)
				M.client.eye=locate(145,392,8)
				M<<sound(null)
				M<<sound('Char.ogg')
				M.RemoveHUD()
				M.Fighting=1
				RETORNO
				var/Choice=alert(M,"Você deseja transceder o seu personagem?","Transcedência","Sim","Não")
				if(Choice=="Sim")
					M.Vegeta=2
					M.Character=new/obj/EvolCharacters/Vegeta2
					M.Revert()
					M.icon=M.Character.icon
					M.UpdatePartyIcon()
					M<<sound(null)
					M.UpdateFaceHUD()
					M.Fighting=0
					M.ResetSuffix()
					M.AddHUD()
					M.client.eye=M.client.mob
				else
					var/Choice2=alert(M,"Uma vez que cancelada a transcedência, o seu personagem não poderá mais evoluir. Tem certeza?","Transcedência","Sim","Não")
					if(Choice2=="Não")
						goto RETORNO
					else
						M.AddHUD()
						M.client.eye=M.client.mob
						RefuseVegeta=1
						M.Fighting=0
						M<<sound(null)
						return
		if(M.icon=='Vegeta.dmi' && RefuseVegeta==0)
			if(M.Vegeta==2 && M.MaxPL>=800000 && M.MaxKi>=500000 && M.Str>=90000 && M.Def>=48000)
				M.client.eye=locate(162,392,8)
				M<<sound(null)
				M<<sound('Char.ogg')
				M.RemoveHUD()
				M.Fighting=1
				RETORNO
				var/Choice=alert(M,"Você deseja transceder o seu personagem?","Transcedência","Sim","Não")
				if(Choice=="Sim")
					var/Choice1=alert(M,"O seu personagem possui duas diferentes evoluções. Qual você escolhe?","Transcedência","Vegeta Super","Vegeta GT")
					if(Choice1=="Vegeta Super")
						M.Vegeta=3
						M.Character=new/obj/EvolCharacters/Vegeta_Super
						M.Revert()
						M.icon=M.Character.icon
						M.UpdatePartyIcon()
						M.UpdateFaceHUD()
						M<<sound(null)
						M.Fighting=0
						M.ResetSuffix()
						M.AddHUD()
						M.client.eye=M.client.mob
					else
						M.Vegeta=4
						M.Character=new/obj/EvolCharacters/Alternate_GT_Vegeta
						M.Revert()
						M.icon=M.Character.icon
						M.UpdatePartyIcon()
						M.Fighting=0
						M.UpdateFaceHUD()
						M<<sound(null)
						M.ResetSuffix()
						M.AddHUD()
						M.client.eye=M.client.mob
				else
					var/Choice2=alert(M,"Uma vez que cancelada a transcedência, o seu personagem não poderá mais evoluir. Tem certeza?","Transcedência","Sim","Não")
					if(Choice2=="Não")
						goto RETORNO
					else
						M.AddHUD()
						M.client.eye=M.client.mob
						RefuseVegeta=1
						M<<sound(null)
						M.Fighting=0
						return
		if(M.icon=='FutureTrunks.dmi' && RefuseFutureTrunks==0)
			if(M.FutureTrunks==0 && M.MaxPL>=210000 && M.MaxKi>=210000 && M.Str>=12000 && M.Def>=4500)
				M.client.eye=locate(179,392,8)
				M<<sound(null)
				M<<sound('Char.ogg')
				M.RemoveHUD()
				M.Fighting=1
				RETORNO
				var/Choice=alert(M,"Você deseja transceder o seu personagem?","Transcedência","Sim","Não")
				if(Choice=="Sim")
					M.FutureTrunks=1
					M.Character=new/obj/EvolCharacters/Future_Trunks_Adulto
					M.Revert()
					M.icon=M.Character.icon
					M.UpdatePartyIcon()
					M.UpdateFaceHUD()
					M<<sound(null)
					M.Fighting=0
					M.ResetSuffix()
					M.AddHUD()
					M.client.eye=M.client.mob
				else
					var/Choice2=alert(M,"Uma vez que cancelada a transcedência, o seu personagem não poderá mais evoluir. Tem certeza?","Transcedência","Sim","Não")
					if(Choice2=="Não")
						goto RETORNO
					else
						M.AddHUD()
						M.client.eye=M.client.mob
						RefuseFutureTrunks=1
						M<<sound(null)
						M.Fighting=0
						return
		if(M.icon=='Trunks.dmi' && RefuseFutureTrunks==0)
			if(M.FutureTrunks==1 && M.MaxPL>=275000 && M.MaxKi>=250000 && M.Str>=20000 && M.Def>=8000)
				M.client.eye=locate(196,392,8)
				M<<sound(null)
				M<<sound('Char.ogg')
				M.RemoveHUD()
				M.Fighting=1
				RETORNO
				var/Choice=alert(M,"Você deseja transceder o seu personagem?","Transcedência","Sim","Não")
				if(Choice=="Sim")
					M.FutureTrunks=2
					M.Character=new/obj/EvolCharacters/Saiyan_Armor_Trunks
					M.Revert()
					M.icon=M.Character.icon
					M.UpdatePartyIcon()
					M<<sound(null)
					M.UpdateFaceHUD()
					M.ResetSuffix()
					M.Fighting=0
					M.AddHUD()
					M.client.eye=M.client.mob
				else
					var/Choice2=alert(M,"Uma vez que cancelada a transcedência, o seu personagem não poderá mais evoluir. Tem certeza?","Transcedência","Sim","Não")
					if(Choice2=="Não")
						goto RETORNO
					else
						M.AddHUD()
						M.client.eye=M.client.mob
						RefuseFutureTrunks=1
						M<<sound(null)
						M.Fighting=0
						return
		if(M.icon=='SATrunks.dmi' && RefuseFutureTrunks==0)
			if(M.FutureTrunks==2 && M.MaxPL>=400000 && M.MaxKi>=300000 && M.Str>=30000 && M.Def>=16000)
				M.client.eye=locate(213,392,8)
				M<<sound(null)
				M<<sound('Char.ogg')
				M.RemoveHUD()
				M.Fighting=1
				RETORNO
				var/Choice=alert(M,"Você deseja transceder o seu personagem?","Transcedência","Sim","Não")
				if(Choice=="Sim")
					M.FutureTrunks=3
					M.Character=new/obj/EvolCharacters/Trunks_Super
					M.Revert()
					M.icon=M.Character.icon
					M.UpdatePartyIcon()
					M<<sound(null)
					M.UpdateFaceHUD()
					M.ResetSuffix()
					M.Fighting=0
					M.AddHUD()
					M.client.eye=M.client.mob
				else
					var/Choice2=alert(M,"Uma vez que cancelada a transcedência, o seu personagem não poderá mais evoluir. Tem certeza?","Transcedência","Sim","Não")
					if(Choice2=="Não")
						goto RETORNO
					else
						M.AddHUD()
						M.client.eye=M.client.mob
						RefuseFutureTrunks=1
						M<<sound(null)
						M.Fighting=0
						return*/
	DeletePoeira(var/mob/M)
		for(var/obj/O in world)
			if(O.icon=='Poeira.dmi' || O.icon=='Poeira2.dmi' || O.icon=='Poeira3.dmi' || O.icon=='Poeira4.dmi')	del O
	RemoveKaiokenEffect()
		var/obj/O=new;O.icon='night.dmi';O.layer=6.1
		O.icon_state="1";src.overlays-=O
		O.icon_state="0";O.pixel_y=32;src.overlays-=O
	AddKaiokenEffect()
		var/obj/O=new;O.icon='night.dmi';O.layer=6.1
		O.icon_state="1";src.overlays+=O
		O.icon_state="0";O.pixel_y=32;src.overlays+=O
	SS2Menos(var/mob/M)
		var/obj/O=new;O.icon='ssjraio.dmi';O.layer=6.1
		M.overlays-=O
	SS2Mais(var/mob/M)
		var/obj/O=new;O.icon='ssjraio.dmi';O.layer=6.1
		M.overlays-=O
		M.overlays+=O
	AddKaiokenAura()
		var/obj/O=new;O.icon='KaiokenAura.dmi';O.layer=5
		O.icon_state="1,0";src.overlays+=O
		O.icon_state="1,1";O.pixel_y=32;src.overlays+=O
		O.icon_state="1,2";O.pixel_y=64;src.overlays+=O
		O.icon_state="0,0";O.pixel_x=-32;O.pixel_y=0;src.overlays+=O
		O.icon_state="0,1";O.pixel_x=-32;O.pixel_y=32;src.overlays+=O
		O.icon_state="0,2";O.pixel_x=-32;O.pixel_y=64;src.overlays+=O
		O.icon_state="2,0";O.pixel_x=32;O.pixel_y=0;src.overlays+=O
		O.icon_state="2,1";O.pixel_x=32;O.pixel_y=32;src.overlays+=O
		O.icon_state="2,2";O.pixel_x=32;O.pixel_y=64;src.overlays+=O
	RemoveKaiokenAura()
		var/obj/O=new;O.icon='KaiokenAura.dmi';O.layer=5
		O.icon_state="1,0";src.overlays-=O
		O.icon_state="1,1";O.pixel_y=32;src.overlays-=O
		O.icon_state="1,2";O.pixel_y=64;src.overlays-=O
		O.icon_state="0,0";O.pixel_x=-32;O.pixel_y=0;src.overlays-=O
		O.icon_state="0,1";O.pixel_x=-32;O.pixel_y=32;src.overlays-=O
		O.icon_state="0,2";O.pixel_x=-32;O.pixel_y=64;src.overlays-=O
		O.icon_state="2,0";O.pixel_x=32;O.pixel_y=0;src.overlays-=O
		O.icon_state="2,1";O.pixel_x=32;O.pixel_y=32;src.overlays-=O
		O.icon_state="2,2";O.pixel_x=32;O.pixel_y=64;src.overlays-=O
	AddRays()
		var/obj/O=new;O.icon='rays.dmi';O.layer=6.2
		O.icon_state="";src.overlays+=O
	RemoveRays()
		var/obj/O=new;O.icon='rays.dmi';O.layer=6.2
		O.icon_state="";src.overlays-=O
	DeleteHair()
		var/obj/O=new;O.icon='Magetta.dmi';O.layer=4.1
		O.pixel_y=32;src.overlays-=O
	AddHair()
		var/obj/O=new;O.icon='Magetta.dmi';O.layer=4.1
		O.pixel_y=32;src.overlays+=O
	AddBlueAura()
		var/obj/O=new;O.icon='SSJBlueAura.dmi';O.layer=3.5
		O.icon_state="0,0";O.pixel_x=-23;src.overlays+=O
		O.icon_state="1,0";O.pixel_x=9;src.overlays+=O
		O.icon_state="2,0";O.pixel_x=41;src.overlays+=O
		O.icon_state="0,1";O.pixel_x=-23;O.pixel_y=32;src.overlays+=O
		O.icon_state="1,1";O.pixel_x=9;O.pixel_y=32;src.overlays+=O
		O.icon_state="2,1";O.pixel_x=41;O.pixel_y=32;src.overlays+=O
		O.icon_state="0,2";O.pixel_x=-23;O.pixel_y=64;src.overlays+=O
		O.icon_state="1,2";O.pixel_x=9;O.pixel_y=64;src.overlays+=O
		O.icon_state="2,2";O.pixel_x=41;O.pixel_y=64;src.overlays+=O
	RemoveBlueAura()
		var/obj/O=new;O.icon='SSJBlueAura.dmi';O.layer=3.5
		O.icon_state="0,0";O.pixel_x=-23;src.overlays-=O
		O.icon_state="1,0";O.pixel_x=9;src.overlays-=O
		O.icon_state="2,0";O.pixel_x=41;src.overlays-=O
		O.icon_state="0,1";O.pixel_x=-23;O.pixel_y=32;src.overlays-=O
		O.icon_state="1,1";O.pixel_x=9;O.pixel_y=32;src.overlays-=O
		O.icon_state="2,1";O.pixel_x=41;O.pixel_y=32;src.overlays-=O
		O.icon_state="0,2";O.pixel_x=-23;O.pixel_y=64;src.overlays-=O
		O.icon_state="1,2";O.pixel_x=9;O.pixel_y=64;src.overlays-=O
		O.icon_state="2,2";O.pixel_x=41;O.pixel_y=64;src.overlays-=O
	AddBlueAura2()
		var/obj/O=new;O.icon='SSBAura2.dmi';O.layer=3.5
		O.icon_state="0,0";src.overlays+=O
		O.icon_state="0,1";O.pixel_y=32;src.overlays+=O
		src.Bolas()
	AddBlueAura3()
		var/obj/O=new;O.icon='SSBAura3.dmi';O.layer=3.5
		O.icon_state="0,0";src.overlays+=O
		O.icon_state="0,1";O.pixel_y=32;src.overlays+=O
	RemoveBlueAura3()
		var/obj/O=new;O.icon='SSBAura3.dmi';O.layer=3.5
		O.icon_state="0,0";src.overlays-=O
		O.icon_state="0,1";O.pixel_y=32;src.overlays-=O
	Bolas()
		var/obj/O=new;O.icon='bolas.dmi';O.layer=4.1
		src.overlays+=O
	NoBolas()
		var/obj/O=new;O.icon='bolas.dmi';O.layer=4.1
		src.overlays-=O
	RemoveBlueAura2()
		var/obj/O=new;O.icon='SSBAura2.dmi';O.layer=3.5
		O.icon_state="0,0";src.overlays-=O
		O.icon_state="0,1";O.pixel_y=32;src.overlays-=O
		src.NoBolas()

	AddGodAura(var/mob/M)
		var/obj/GodAura/GodAura/G=new();M.overlays+=G
		var/obj/GodAura2/GodAura2/G2=new();M.overlays+=G2
		var/obj/GodAura3/GodAura3/G3=new();M.overlays+=G3
		var/obj/GodAura4/GodAura4/G4=new();M.overlays+=G4
	RemoveGodAura(var/mob/M)
		var/obj/GodAura/GodAura/G=new();M.overlays-=G
		var/obj/GodAura2/GodAura2/G2=new();M.overlays-=G2
		var/obj/GodAura3/GodAura3/G3=new();M.overlays-=G3
		var/obj/GodAura4/GodAura4/G4=new();M.overlays-=G4
	SS2Aura(var/mob/M)
		while(1)
			if(M.Z1==0)
				M<<sound(null,channel=2)
				break
			if(findtext("[M.icon]","SS2") || findtext("[src.icon]","SS3"))
				M<<sound('SS2Aura.ogg',channel=2)
			if(M.Z1==0)
				M<<sound(null,channel=2)
				break
			sleep(133)
	Poeira(var/mob/M)
		var/obj/Poeira/Poeira/P=new(M.loc)
		P.density=0
		var/obj/Minicrater/Minicrater/C=new()
		if(M.Fighting==1)
			C.loc=M.loc
			if(M.dir==1)
				C.dir=1
			if(M.dir==2)
				C.dir=2
			if(M.dir==4)
				C.dir=4
				C.pixel_y=-16
			if(M.dir==8)
				C.dir=8
				C.pixel_y=-16
	Poeira2(var/mob/M)
		var/obj/Poeira2/Poeira2/P=new(M.loc)
		P.density=0
		var/obj/Minicrater/Minicrater/C=new()
		if(M.Fighting==1)
			C.loc=M.loc
			if(M.dir==1)
				C.dir=1
			if(M.dir==2)
				C.dir=2
			if(M.dir==4)
				C.dir=4
				C.pixel_y=-16
			if(M.dir==8)
				C.dir=8
				C.pixel_y=-16
	Poeira3(var/mob/M)
		var/obj/Poeira3/Poeira3/P=new(M.loc)
		P.density=0
		var/obj/Minicrater/Minicrater/C=new()
		if(M.Fighting==1)
			C.loc=M.loc
			if(M.dir==1)
				C.dir=1
			if(M.dir==2)
				C.dir=2
			if(M.dir==4)
				C.dir=4
				C.pixel_y=-16
			if(M.dir==8)
				C.dir=8
				C.pixel_y=-16
	Poeira4(var/mob/M)
		var/obj/Poeira4/Poeira4/P=new(M.loc)
		P.density=0
		var/obj/Minicrater/Minicrater/C=new()
		if(M.Fighting==1)
			C.loc=M.loc
			if(M.dir==1)
				C.dir=1
			if(M.dir==2)
				C.dir=2
			if(M.dir==4)
				C.dir=4
				C.pixel_y=-16
			if(M.dir==8)
				C.dir=8
				C.pixel_y=-16
	Trace(var/mob/M)
		var/obj/A=new(M.loc);A.icon='HKL.dmi';A.layer=M.layer-1
		var/obj/B=new(A.loc);B.icon='HKL2.dmi';B.layer=M.layer-2
		var/obj/C=new(M.loc);C.icon='HKL2.dmi';C.layer=M.layer-2
		if(M.dir==1)
			B.dir=2
			B.y+=1
			A.dir=1
			C.y-=1
			C.dir=1
		else
			if(M.dir==2)
				B.dir=1
				A.dir=1
				B.y-=1
				C.y+=1
				C.dir=2
			if(M.dir==4)
				B.dir=8
				A.dir=4
				B.x+=1
				A.pixel_y=-16
				B.pixel_y=-16
				C.pixel_y=-16
				C.x-=1
				C.dir=4
			if(M.dir==8)
				B.dir=4
				A.dir=4
				B.x-=1
				A.pixel_y=-16
				B.pixel_y=-16
				C.pixel_y=-16
				C.x+=1
				C.dir=8
	Explosion(var/mob/M)
		var/obj/Explosion/Explosion/C=new(M.loc)
		var/obj/A=new(C.loc);A.icon='Bum.dmi';A.layer=6
		A.icon_state="1,0";A.pixel_x=32;C.overlays+=A
		A.icon_state="0,1";A.pixel_x=0;A.pixel_y=32;C.overlays+=A
		A.icon_state="0,2";A.pixel_x=0;A.pixel_y=64;C.overlays+=A
		A.icon_state="0,3";A.pixel_x=0;A.pixel_y=96;C.overlays+=A
		A.icon_state="1,1";A.pixel_x=32;A.pixel_y=32;C.overlays+=A
		A.icon_state="1,2";A.pixel_x=32;A.pixel_y=64;C.overlays+=A
		A.icon_state="1,3";A.pixel_x=32;A.pixel_y=96;C.overlays+=A
	Crater(var/mob/M)
		var/obj/Cratera/Cratera/C=new(M.loc)
		var/obj/A=new(C.loc);A.icon='crater.dmi'
		A.icon_state="0,1";A.pixel_x=-64;A.pixel_y=0;C.overlays+=A
		A.icon_state="1,1";A.pixel_x=-32;A.pixel_y=0;C.overlays+=A
		A.icon_state="3,1";A.pixel_x=32;A.pixel_y=0;C.overlays+=A
		A.icon_state="0,0";A.pixel_x=-64;A.pixel_y=-32;C.overlays+=A
		A.icon_state="1,0";A.pixel_x=-32;A.pixel_y=-32;C.overlays+=A
		A.icon_state="2,0";A.pixel_x=0;A.pixel_y=-32;C.overlays+=A
		A.icon_state="3,0";A.pixel_x=32;A.pixel_y=-32;C.overlays+=A
		A.icon_state="0,2";A.pixel_x=-64;A.pixel_y=32;C.overlays+=A
		A.icon_state="1,2";A.pixel_x=-32;A.pixel_y=32;C.overlays+=A
		A.icon_state="2,2";A.pixel_x=0;A.pixel_y=32;C.overlays+=A
		A.icon_state="3,2";A.pixel_x=32;A.pixel_y=32;C.overlays+=A
		A.icon_state="1,3";A.pixel_x=-32;A.pixel_y=64;C.overlays+=A
		A.icon_state="2,3";A.pixel_x=0;A.pixel_y=64;C.overlays+=A

	CraterLoop(var/mob/M)
		if(M.Shocking!=0)
			M.Crater(M)
			sleep(10)
	GhostMode(var/RespawnTime=15)
		spawn(-1)
			if(src.MajinForm==0)
				src.Revert()
			src.DeleteRAura(src)
			src.DropFlag("Died")
			src.GhostMode=1
			src.icon='Ghost.dmi'
			src.TakeKiPercent(100)
			src.TakePlPercent(100)
			for(var/mob/CombatNPCs/M in oview(src))	if(M.Target==src)	M.TargetMob()
			src.CountDown("Respawn in",RespawnTime)
			if(src.GhostMode)	{src.GhostMode=2;src.UpdateHUDText("TrainingDesc","Aperte {E} para voltar!")}
	OnlineFriends()
		var/FriendsOnline=0
		var/WatchersOnline=0
		for(var/mob/M in Players)
			if(M.key in src.Friends)	{src.OnlineFriends+=M;FriendsOnline+=1}
			if(src.key in M.Friends)	{M.OnlineFriends+=src;WatchersOnline+=1}
		src<<"[FriendsOnline] Friends Online.  [WatchersOnline] Watchers."
	DisplayPlayTime(/**/)
		var/DisplayHours="[src.PlayTimeHours]";while(length(DisplayHours)<1)	DisplayHours="0[DisplayHours]"
		var/DisplayMinutes="[src.PlayTimeMinutes]";while(length(DisplayMinutes)<2)	DisplayMinutes="0[DisplayMinutes]"
		var/DisplaySeconds="[src.PlayTimeSeconds]";while(length(DisplaySeconds)<2)	DisplaySeconds="0[DisplaySeconds]"
		return "[DisplayHours]h [DisplayMinutes]m [DisplaySeconds]s"
	PerkCheck()
		if(usr.Character.Race!="Saiyan" || usr.Character.Race!="Half Saiyan" || usr.Character.Race!="Saiyajin")
			if(usr.HasPerk("Guerreiro Lendario"))
				usr.DamageMultiplier=1
				usr.overlays-=global.koIcon
	Locate(var/Location)
		switch(Location)
			if("Cidade do Mr.Satan")	src.loc=locate(181,232,1)
			if("Cidade do Sul")	src.loc=locate(74,62,1)
			if("Cidade do Norte")	src.loc=locate(261,279,1)
			if("Cidade Central") src.loc=locate(181,232,1)
			if("Cidade do Norte") src.loc=locate(294,351,1)
			if("Torneio de Artes Marciais")	src.loc=locate(256,60,1)
			if("Torre de Kamissama") 	src.loc=locate(71,331,3)
			if("Casa do Kame")	src.loc=locate(322,61,1)
			if("Grande Patriarca")	src.loc=locate(338,151,7)
	CountDown(var/Msg="Round Starts in",var/Timer=10)
		for(var/i=Timer;i>=1;i--)
			src.UpdateHUDText("TrainingDesc","[Msg] [i] segundos!")
			PlaySound(src,'Beep.ogg')
			sleep(10)
		src.UpdateHUDText("TrainingDesc")
	ForceCancelFlight()
		if(!src.density)
			src.icon_state=""
			src.RemoveAura("Fly")
			src.layer=4;src.density=1
			src.overlays-=FlightShadow
	FillStatsGrid()
		var/Column=0
		for(var/obj/O in AllStats)
			Column+=1
			src<<output(O,"StatsTab.StatsGrid:1,[Column]")
			src<<output(O.suffix,"StatsTab.StatsGrid:2,[Column]")
	ScreenShake()
		for(var/client/C in src.ControlClients)
			for(var/i=1;i<=5;i++)
				var/PickedAmt=rand(4,8)
				var/PickedDir=pick("pixel_x","pixel_y")
				C.vars[PickedDir]+=PickedAmt
				sleep(1);if(!src || !C)	return
				C.vars[PickedDir]-=PickedAmt
	ScreenShake2()
		while(1)
			for(var/client/C in src.ControlClients)
				for(var/i=1;i<=5;i++)
					var/PickedAmt=rand(4,8)
					var/PickedDir=pick("pixel_x","pixel_y")
					C.vars[PickedDir]+=PickedAmt
					sleep(1);if(!src || !C)	return
					C.vars[PickedDir]-=PickedAmt
	CombatShake()
		for(var/client/C in src.ControlClients)
			for(var/i=1;i<=3;i++)
				var/PickedAmt=rand(1,2)
				var/PickedDir=pick("pixel_x","pixel_y")
				C.vars[PickedDir]+=PickedAmt
				sleep(1);if(!src || !C)	return
				C.vars[PickedDir]-=PickedAmt
	PowerUpShake()
		for(var/client/C in src.ControlClients)
	//		for(var/i=1;i<=5;i++)
			var/PickedAmt=rand(1,2)
			var/PickedDir=pick("pixel_x","pixel_y")
			C.vars[PickedDir]+=PickedAmt
			sleep(1);if(!src || !C)	return
			C.vars[PickedDir]-=PickedAmt
	GetAuraType(/**/)
		if(findtext("[src.icon]","Kaioken"))	return "RedEnergy"
		if(src.icon=='KidGoku.dmi')	return "CloudEnergy"
		if(src.CurTrans)
			if(src.TransDatum && src.TransDatum.CustAura)	return "[src.TransDatum.CustAura]Energy"
			if(findtext("[src.icon]","SSGodSS1"))	return "BlueEnergy"
			if(findtext(src.Character.Race,"Saiyan") && src.icon!='GokuSSGodSS1.dmi' && src.icon!='VegetaSSGodSS1.dmi' && src.icon!='BVegetaSSGodSS1.dmi' && src.icon!='VegitoSSB.dmi' && src.icon!='VegetaSuperGod.dmi' && src.icon!='VegetaSuperGodB.dmi')	return "YellowEnergy"
		return "[src.Character.Aura]Energy"
	AddAura(var/AuraTag)
		src.overlays-=src.Aura
		if(!src.Aura)	src.Aura=new
		src.Aura.icon_state="[src.GetAuraType()][AuraTag]"
		src.Aura.layer=src.layer-0.1
		src.overlays+=src.Aura
	AddBlue(var/mob/M)
		var/obj/O=new;O.icon='troll.dmi';O.layer=6
		O.icon_state="1";M.overlays+=O
		O.icon_state="2";M.overlays+=O
		O.icon_state="3";M.overlays+=O
	DelBlue(var/mob/M)
		var/obj/O=new;O.icon='troll.dmi';O.layer=6
		O.icon_state="1";M.overlays-=O
		O.icon_state="2";M.overlays-=O
		O.icon_state="3";M.overlays-=O
	AddBlue2(var/mob/M)
		var/obj/O=new;O.icon='troll2.dmi';O.layer=6
		O.icon_state="1";M.overlays+=O
		O.icon_state="2";M.overlays+=O
		O.icon_state="3";M.overlays+=O
	DelBlue2(var/mob/M)
		var/obj/O=new;O.icon='troll2.dmi';O.layer=6
		O.icon_state="1";M.overlays-=O
		O.icon_state="2";M.overlays-=O
		O.icon_state="3";M.overlays-=O
	AddMajin()
		var/obj/O=new;O.icon='majin.dmi'
		O.icon_state="majin";src.overlays+=O
	AddSSAura()
		var/obj/O=new;O.icon='SuperAura.dmi';O.layer=3.5
		O.icon_state="SS2";O.pixel_y=32;src.overlays+=O
		O.icon_state="SS";O.pixel_y-=32;src.overlays+=O
	AddShock()
		var/obj/O=new(src.loc);O.icon='ShockWave.dmi';O.layer=6
		var/obj/J=new(O.loc);J.icon='ShockWave.dmi';J.layer=6
		O.icon_state="0";O.pixel_y=0;O.pixel_x=0
		J.icon_state="1";J.pixel_y+=32;O.overlays+=J
		J.icon_state="2";J.pixel_x+=32;O.overlays+=J
		J.icon_state="3";J.pixel_y-=32;O.overlays+=J
	RemoveShock(var/mob/M)
		for(var/obj/O in world)
			if(O.icon=='ShockWave.dmi')
				del O
	AddWAura()
		var/obj/O=new;O.icon='SuperAura2.dmi';O.layer=3.5
		O.icon_state="SS2";O.pixel_y=32;src.overlays+=O
		O.icon_state="SS";O.pixel_y-=32;src.overlays+=O
	AddRAura(var/mob/M)
		var/obj/O=new;O.icon='SuperAura3.dmi';O.layer=3.5
		O.icon_state="SS2";O.pixel_y=32;M.overlays+=O
		O.icon_state="SS";O.pixel_y-=32;M.overlays+=O
/*	AddBooParado()
		var/obj/I=new(src.icon)
		I.icon='SuperBooTop.dmi'
		I.density=1
		I.pixel_y=32;src.overlays+=global.I*/
/*	AddBooAtacandoD()
		var/obj/I=new(src.icon)
		I.icon='SuperBooHandBottomE.dmi'
		I.density=1
		I.pixel_y=32;I.pixel_x=32;src.overlays+=I
	AddBooAtacandoE()
		var/obj/I=new(src.icon)
		I.icon='SuperBooHandBottom.dmi'
		I.density=1
		I.pixel_y=32;I.pixel_x-=32;src.overlays+=I
	AddBooAtacando2D()
		var/obj/I=new(src.icon)
		I.icon='SuperBooHandTopE.dmi'
		I.density=1
		I.pixel_x=32;src.overlays+=I
	AddBooAtacando2E()
		var/obj/I=new(src.icon)
		I.icon='SuperBooHandTop.dmi'
		I.density=1
		I.pixel_x-=32;src.overlays+=I*/
	SB()
		var/obj/O=new;O.icon='SuperBooTop.dmi'
		O.pixel_y=32;src.overlays+=O
	FB()
		var/obj/O=new;O.icon='FatBooTop.dmi'
		O.pixel_y=32;src.overlays+=O
	EB()
		var/obj/O=new;O.icon='EvilBooTop.dmi'
		O.pixel_y=32;src.overlays+=O
	Boohan()
		var/obj/O=new;O.icon='BoohanTop.dmi'
		O.pixel_y=32;src.overlays+=O
	Bootenks()
		var/obj/O=new;O.icon='BootenksTop.dmi'
		O.pixel_y=32;src.overlays+=O
	AddGAura()
		var/obj/O=new;O.icon='SuperAura4.dmi';O.layer=3.5
		O.icon_state="SS2";O.pixel_y=32;src.overlays+=O
		O.icon_state="SS";O.pixel_y-=32;src.overlays+=O
	AddBlackAura()
		var/obj/O=new;O.icon='SuperAura6.dmi';O.layer=3.5
		O.icon_state="SS2";O.pixel_y=32;src.overlays+=O
		O.icon_state="SS";O.pixel_y-=32;src.overlays+=O
	DeleteBlackAura()
		var/obj/O=new;O.icon='SuperAura6.dmi';O.layer=3.5
		O.icon_state="SS2";O.pixel_y=32;src.overlays-=O
		O.icon_state="SS";O.pixel_y-=32;src.overlays-=O
	AddPAura()
		var/obj/O=new;O.icon='SuperAura5.dmi';O.layer=3.5
		O.icon_state="SS2";O.pixel_y=32;src.overlays+=O
		O.icon_state="SS";O.pixel_y-=32;src.overlays+=O
	AddRoseAura()
		var/obj/O=new;O.icon='SSRAura.dmi';O.layer=3.5
		O.icon_state="0,1";O.pixel_y=32;src.overlays+=O
		O.icon_state="0,0";O.pixel_y-=32;src.overlays+=O
	DeleteRoseAura()
		var/obj/O=new;O.icon='SSRAura.dmi';O.layer=3.5
		O.icon_state="0,1";O.pixel_y=32;src.overlays-=O
		O.icon_state="0,0";O.pixel_y-=32;src.overlays-=O
	AddGoldenAura()
		var/obj/O=new;O.icon='SuperAura7.dmi'
		O.icon_state="FA";src.overlays+=O
	RemoveGoldenAura()
		var/obj/O=new;O.icon='SuperAura7.dmi'
		O.icon_state="FA";src.overlays-=O
	DeleteSSAura()
		var/obj/O=new;O.icon='SuperAura.dmi';O.layer=3.5
		O.icon_state="SS2";O.pixel_y=32;src.overlays-=O
		O.icon_state="SS";O.pixel_y-=32;src.overlays-=O
	DeleteWAura()
		var/obj/O=new;O.icon='SuperAura2.dmi';O.layer=3.5
		O.icon_state="SS2";O.pixel_y=32;src.overlays-=O
		O.icon_state="SS";O.pixel_y-=32;src.overlays-=O
	DeleteRAura(var/mob/M)
		var/obj/O=new;O.icon='SuperAura3.dmi';O.layer=3.5
		O.icon_state="SS2";O.pixel_y=32;M.overlays-=O
		O.icon_state="SS";O.pixel_y-=32;M.overlays-=O
	DeleteGAura()
		var/obj/O=new;O.icon='SuperAura4.dmi';O.layer=3.5
		O.icon_state="SS2";O.pixel_y=32;src.overlays-=O
		O.icon_state="SS";O.pixel_y-=32;src.overlays-=O
	DeletePAura()
		var/obj/O=new;O.icon='SuperAura5.dmi';O.layer=3.5
		O.icon_state="SS2";O.pixel_y=32;src.overlays-=O
		O.icon_state="SS";O.pixel_y-=32;src.overlays-=O
	BigBang(var/mob/M)
		while(1)
			var/obj/O=new;O.icon='Effects.dmi'
			if(M.dir==4)
				O.icon_state="SuperBigBang";O.pixel_x+=32;M.overlays+=O
			if(M.dir==8)
				O.icon_state="SuperBigBang";O.pixel_x-=32;M.overlays+=O
			sleep(1)
	RemoveAura(var/AuraTag)
		if(!src.Aura)	return
		if(!AuraTag)	src.overlays-=src.Aura
		else	if(findtext(src.Aura.icon_state,AuraTag))	src.overlays-=src.Aura
	RespecPerks()
		src.UnlockedPerks=list("Empty")
		src.PerkPoints=round(src.GetRebirthLevel()/10000)
		src.SlottedPerks=list("Empty","Locked Slot","Locked Slot")
		src<<"<b><font size=4 color=red>Resetado: Os Pontos Perks do seu personagem foram resetados!"
		if(src.Aviso==1)
			for(var/obj/Perks/Poder_Supremo/S)
				src.UnlockedPerks+=S.name
		if(src.OldLoc==1)
			for(var/obj/Perks/Instinto_Superior/S)
				src.UnlockedPerks+=S.name
	RespecStats(/**/)
		src.TraitPoints=src.GetRebirthLevel()-1
		src.MaxPL=initial(src.MaxPL)+src.Talked17
		src.PL=src.MaxPL
		src.MaxKi=initial(src.MaxKi)+src.Talked11
		src.Ki=src.MaxKi
		src.Str=initial(src.Str)+src.Talked18
		src.Def=initial(src.Def)+src.Talked19
		src.Traits=initial(src.Traits)
		src<<"<b><font size=4 color=red>Resetado: Os Pontos Estatus do seu personagem foram resetados!"
	FullRespec(/**/)
		src.RespecStats()
		src.RespecPerks()
	Boost(var/time=0)
		while(1)
			if(findtext("[usr.icon]","SS1"))
				if(time==0)
					usr.MaxPL*=1.5
					usr.MaxKi*=1.5
					usr.Str*=1.5
					usr.Def*=1.5
					time=1
			else
				usr.MaxPL/=1.5
				usr.MaxKi/=1.5
				usr.Str/=1.5
				usr.Def/=1.5
				break
			sleep(1)
	Boost2(var/time=0)
		while(1)
			if(findtext("[usr.icon]","SS2"))
				if(time==0)
					usr.MaxPL*=2
					usr.MaxKi*=2
					usr.Str*=2
					usr.Def*=2
					time=1
			else
				usr.MaxPL/=2
				usr.MaxKi/=2
				usr.Str/=2
				usr.Def/=2
				break
			sleep(1)
	Boost3(var/time=0)
		while(1)
			if(findtext("[usr.icon]","SS3"))
				if(time==0)
					usr.MaxPL*=2.5
					usr.MaxKi*=2.5
					usr.Str*=2.5
					usr.Def*=2.5
					time=1
			else
				usr.MaxPL/=2.5
				usr.MaxKi/=2.5
				usr.Str/=2.5
				usr.Def/=2.5
				break
			sleep(1)
	CanBeHit(/**/)
		if(src.GhostMode)	return
		if(src.TeleCountering)	return
		if(src.invisibility==101)	return
	//	if(src.icon=='Candy.dmi')	return
		if(src.Shocking==1)	return
		if(src.icon_state=="machine")	return
		if(src.Quest11==1)	return
		if(src.Fighting==1) return
		if(src.icon_state=="Beam2")	return
		if(src.icon_state=="ultra")	return
		if(src.icon_state=="Beam")	return
		if(src.icon_state=="Dragon")	return
		if(src.icon_state=="Fusion")	return
		if(src.icon=='GogetaSSB.dmi' && (src.icon_state=="Kaioken" || src.icon_state=="Kaioken2"))	return
		if(src.icon_state=="Potara")	return
		if(src.icon_state=="none")	return
		return 1
	CanPVP(var/mob/M)
		if(!src || !M)	return
		if(src.GhostMode || M.GhostMode)	return
		if(src.CounterBeamMob || M.CounterBeamMob)	return
		if(src.ButtonComboing || M.ButtonComboing)	return
//		if((src.z==1 || src.z==7) && global.K1==0)	return
		if((src.z==3 && src.x>316 && src.y<70) || (M.z==3 && M.x>316 && M.y<70))	return 1
		if(!src.ControlClients || !M.ControlClients)
			if(src.Clonagem2==1 || M.Clonagem2==1)
				if(global.K1==1 || global.K1==2)
					if(src.z==1 || src.z==7 || M.z==1 || M.z==7)
						return	1
			if(src.StartTarget && src.StartTarget!=M)	return
			if(M.StartTarget && M.StartTarget!=src)	return
			if(src.Team==M.Team)	return
			return 1
		if(global.K1==1 || global.K1==2)
			if(src.z==1 || src.z==7 || M.z==1 || M.z==7)
				return 1
		if(src.InTournament && M.InTournament && global.TournStatus=="Battle" && global.TournFighters[src]!=global.TournFighters[M])	return 1
		if(src.InstanceObj)
			if(src.InstanceObj.IsPvpType("Clan Only"))	if(src.Clan!=M.Clan)	return 1
			else	if(src.InstanceObj.IsPvpType("Standard") || src.InstanceObj.IsPvpType("Balanced"))	return 1
			if(src.Clonagem2==1)	return 1
		if(src.Dueling==M || M.Dueling==src)	return 1
	LoopMap()
		if(src.x<=1)	src.loc=locate(400,src.y,src.z)
		if(src.y<=1)	src.loc=locate(src.x,400,src.z)
		if(src.x>=400)	src.loc=locate(1,src.y,src.z)
		if(src.y>=400)	src.loc=locate(src.x,1,src.z)
	ResetSuffix(/**/)
		src.suffix="<font size=1>Level [FullNum(src.Level)] [src.Character.Race]"
		if(src.Clan)	src.suffix+="<br>Lvl.[src.ClanRank.Level] [src.ClanRank] de {[src.Clan]}"
		if(src.Title)	src.suffix+="<br>[src.Title]"
		if(src.Class)	src.suffix+="<br>Nivel de Habilidade: [src.Class]"
	ResetTeleCounters(var/ThisID)
		if(!ThisID || ThisID==src.TeleCounteringID)
			src.ITing=0;src.TeleCountering=null;src.TeleCounteringID=null
	GuardTap(var/mob/Attacker)
		var/GoAhead
		if(src.TeleCounteringID)	return
		if(src.BeamOverCharge==20 && src.icon_state=="charge" && !src.CounterBeamMob && src.HasPerk("KaMeHaMeHa Evasivo"))
			flick("IT",src);PlaySound(view(),'InstantTransmission.ogg')
			var/turf/T=get_step(Attacker,get_dir(src,Attacker))
			if(T && T.Enter(src))	src.loc=T
			src.dir=get_dir(src,Attacker)
			src.BeamOverCharge=0;src.Beam()
			src.TakeKiPercent(100)
			return 2
		if(src.GuardTapping)
			var/KiRequired=10
//			if(src.HasPerk("Evasiva Eficiente"))	KiRequired=10
			if(src.UseKiPercent(KiRequired))	GoAhead=1
		else
			if(src.HasPerk("Ilusao") && src.UseKiPercent(20))	GoAhead=1
			if(src.IsUltra==1)	GoAhead=1
		if(GoAhead)
			src.PowerUpRelease();src.ITing=1
			src.ThrownDamage=null;src.EndKnockBack()
			flick("IT",src);PlaySound(view(),'InstantTransmission.ogg')
			src.TeleCounteringID=rand(1,999999)
			var/ThisID=src.TeleCounteringID
			src.TeleCountering=Attacker
			spawn(5)
				if(!Attacker)	{src.ResetTeleCounters(ThisID);return}
				if((abs(src.x-Attacker.x>12) || abs(src.y-Attacker.y>7)) || !src.CanPVP(Attacker))	{src.ResetTeleCounters(ThisID);return}
				var/turf/T=get_step(Attacker,get_dir(src,Attacker))
				Attacker.ThrownDamage=null;Attacker.EndKnockBack()
				if(T && T.Enter(src))	src.loc=T
				src.dir=get_dir(src,Attacker)
				src.loc.Entered(src)
			spawn(10)
				if(!Attacker)	{src.ResetTeleCounters(ThisID);return}
				if((abs(src.x-Attacker.x>12) || abs(src.y-Attacker.y>7)) || !src.CanPVP(Attacker))	{src.ResetTeleCounters(ThisID);return}
				if(!src.TeleCountering || src.TeleCounteringID!=ThisID)	return
				flick("kick1",src);		PlaySound(view(),pick('meleeflash.ogg','strongkick.ogg','HitHeavy.ogg'))
				if(Attacker.icon_state!="Guard")
					ShowEffect(Attacker,"HyperCombat",16,16)
					Attacker.Blocked("Tele Counter",src,20)
					Attacker.AddKiPercent(10)
					src.StandardDamage(Attacker,src.Str,1)
					Attacker.HitStun(0,src)
					if(!src.HasPerk("Weakling"))	src.Throw(Attacker,7,src.dir)
					var/furia=pick(1,2,3,4,5,6)
					if(furia==1)
						if(src.Fury!=100)
							src.Fury++
					var/chan=pick(1,2,3,4,5,6,7,8,9,10,11,12)
					if(chan==1)
						if((src.PLGeral/Attacker.PLGeral)*100<50)
							if(src.PLGeral<100000)
								var/valor=pick(0.2,0.3,0.4,0.5)
								var/valor2=pick(0.1,0.2)
								src.MaxPL+=src.MaxPL*valor
								src.MaxKi+=src.MaxKi*valor
								src.Str+=src.Str*valor
								src.Def+=src.Def*valor
								Attacker.MaxPL+=Attacker.MaxPL*valor2
								Attacker.MaxKi+=Attacker.MaxKi*valor2
								Attacker.Str+=Attacker.Str*valor2
								Attacker.Def+=Attacker.Def*valor2
							else
								if(src.PLGeral>=100000 && src.PLGeral<1000000)
									var/valor=pick(0.02,0.03,0.04,0.05)
									var/valor2=pick(0.01,0.02)
									src.MaxPL+=src.MaxPL*valor
									src.MaxKi+=src.MaxKi*valor
									src.Str+=src.Str*valor
									src.Def+=src.Def*valor
									Attacker.MaxPL+=Attacker.MaxPL*valor2
									Attacker.MaxKi+=Attacker.MaxKi*valor2
									Attacker.Str+=Attacker.Str*valor2
									Attacker.Def+=Attacker.Def*valor2
								else
									if(src.PLGeral>=1000000 && src.PLGeral<100000000)
										var/valor=pick(0.002,0.003,0.004,0.005)
										var/valor2=pick(0.001,0.002)
										src.MaxPL+=src.MaxPL*valor
										src.MaxKi+=src.MaxKi*valor
										src.Str+=src.Str*valor
										src.Def+=src.Def*valor
										Attacker.MaxPL+=Attacker.MaxPL*valor2
										Attacker.MaxKi+=Attacker.MaxKi*valor2
										Attacker.Str+=Attacker.Str*valor2
										Attacker.Def+=Attacker.Def*valor2
									else
										var/valor=pick(0.0002,0.0003,0.0004,0.0005)
										var/valor2=pick(0.0001,0.0002)
										src.MaxPL+=src.MaxPL*valor
										src.MaxKi+=src.MaxKi*valor
										src.Str+=src.Str*valor
										src.Def+=src.Def*valor
										Attacker.MaxPL+=Attacker.MaxPL*valor2
										Attacker.MaxKi+=Attacker.MaxKi*valor2
										Attacker.Str+=Attacker.Str*valor2
										Attacker.Def+=Attacker.Def*valor2
						else
							if(src.PLGeral<100000)
								var/valor=pick(0.2,0.3,0.4,0.5)
								var/valor2=pick(0.1,0.2)
								src.MaxPL+=src.MaxPL*valor2
								src.MaxKi+=src.MaxKi*valor2
								src.Str+=src.Str*valor2
								src.Def+=src.Def*valor2
								Attacker.MaxPL+=Attacker.MaxPL*valor
								Attacker.MaxKi+=Attacker.MaxKi*valor
								Attacker.Str+=Attacker.Str*valor
								Attacker.Def+=Attacker.Def*valor
							else
								if(src.PLGeral>=100000 && src.PLGeral<1000000)
									var/valor=pick(0.02,0.03,0.04,0.05)
									var/valor2=pick(0.01,0.02)
									src.MaxPL+=src.MaxPL*valor2
									src.MaxKi+=src.MaxKi*valor2
									src.Str+=src.Str*valor2
									src.Def+=src.Def*valor2
									Attacker.MaxPL+=Attacker.MaxPL*valor
									Attacker.MaxKi+=Attacker.MaxKi*valor
									Attacker.Str+=Attacker.Str*valor
									Attacker.Def+=Attacker.Def*valor
								else
									if(src.PLGeral>=1000000 && src.PLGeral<100000000)
										var/valor=pick(0.002,0.003,0.004,0.005)
										var/valor2=pick(0.001,0.002)
										src.MaxPL+=src.MaxPL*valor2
										src.MaxKi+=src.MaxKi*valor2
										src.Str+=src.Str*valor2
										src.Def+=src.Def*valor2
										Attacker.MaxPL+=Attacker.MaxPL*valor
										Attacker.MaxKi+=Attacker.MaxKi*valor
										Attacker.Str+=Attacker.Str*valor
										Attacker.Def+=Attacker.Def*valor
									else
										var/valor=pick(0.0002,0.0003,0.0004,0.0005)
										var/valor2=pick(0.0001,0.0002)
										src.MaxPL+=src.MaxPL*valor2
										src.MaxKi+=src.MaxKi*valor2
										src.Str+=src.Str*valor2
										src.Def+=src.Def*valor2
										Attacker.MaxPL+=Attacker.MaxPL*valor
										Attacker.MaxKi+=Attacker.MaxKi*valor
										Attacker.Str+=Attacker.Str*valor
										Attacker.Def+=Attacker.Def*valor
				src.ResetTeleCounters()
				for(var/mob/Player/P in world)
					if(src.z==P.z)
						if(abs(P.x-src.x)<=12 || abs(P.y-src.y)<=7)	P.PowerUpShake()
			return 1
	TargetMob(var/mob/M)
		if(src.Target==M)	return
		if(ismob(src.Target))	src.Target.Targeters-=src
		if(M)
			if(!src.ControlClients && src.Team==M.Team)	return
			if(!M.ControlClients && !src.ControlClients)	if(M.Team==src.Team)	return
			if(!src.ControlClients && src.Target && src.Target.icon_state=="koed")	M.GiveMedal(new/obj/Medals/Savior)
			if(src.Clonagem2==1 && src.name==M.name)	src.Target=M.Target
		src.Target=M
		if(ismob(M))
			M.Targeters+=src
			src.UpdateEnemyHUD()
			src.UpdateReverseHUDText("EnemyName",AtName(M.name))
		else
			src.UpdateEnemyHUD()
			src.UpdateReverseHUDText("EnemyName","Sem Alvo")
