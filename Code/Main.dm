//project start date: 7-27-09
#define DEBUG
// 25 tiles da esquerda pra direita
// 13 tiles de cima para baixo
world
	hub="Shawn_EX.RevoluoZ" //YakumouJr.DragonBallOnlineBrasil
	hub_password="123rlks"
	status="Revolução Z"
	name="Revolução Z"
	map_format=TILED_ICON_MAP
	mob=/mob/Player
	icon_size=32
	fps=60
	view="25x15"
	IsBanned(key,address,computer_id)
		if(key=="")	return 0
		else 	return ..()
	New()
		world.log=file("LogFile.txt")
		spawn()	LogCPU()
		world.hub_password="Xx[183921]xX"
		LoadClans()
		LoadScoreBoard()
		if(fexists("Config.sav"))
			var/savefile/F=new("Config.sav")
			LogoutLink=F["LogoutLink"]
			MotD=F["MotD"]
		for(var/obj/TempCpHolder/H in world)	{H.x-=1;H.y-=1}
		spawn()	TickLoop()
		spawn()	SecondLoop()
		spawn()	HourLoop()
		spawn()	Loop()
		spawn()	GLoop()

		spawn()	PhaseWorld()
		spawn()	GenerateFlowers()

		spawn()
			PopulateDigMats()
			LoadMaterials()

/*		spawn()	LoadSubs()*/
		spawn()	LoadGlobalBans()
		spawn()	LoadGlobalMutes()
		spawn()	LoadOffensiveWords()
		spawn()	LoadRestrictedFonts()
		spawn()	LoadCashPointPurchases()

		spawn()	PopulatePerks()
		spawn()	PopulateStats()
		spawn()	PopulateEffects()
		spawn()	PopulateMissions()
		spawn()	PopulateAllChars()
		spawn() PopulateAllFusionChars()
		spawn() PopulateAllBlockedChar()
		spawn() PopulateAllEspeciais()
		spawn() PopulateAllMissoes()
		spawn()	PopulateMedalList()
		spawn()	PopulateTutorails()
		spawn()	PopulateDamageNums()
		spawn()	PopulateDragonBalls()
		spawn() PopulateNDragonBalls()
		spawn()	PopulateTerritories()
		spawn()	PopulateCapsuleChars()
		spawn()	BalanceNPCS()

		spawn(1)	ProfileDatums()

	//	spawn(300) LoopDeathMatch()
		spawn()	LoopClanWars()
		spawn()	DeleteCrater()
		spawn(10*600)	LoopWorldTourn()
		spawn(1)	StartMPE()
		spawn(10*600)	EventLoopTreasureHunter()
		for(var/mob/M)
			if(M.icon=='SuperBooBottom.dmi')
				M.overlays+=global.SB
			if(M.icon=='FatBooBottom.dmi')
				M.overlays+=global.FB
			if(M.icon=='EvilBooBottom.dmi')
				M.overlays+=global.EB
			if(M.icon=='BootenksBottom.dmi')
				M.overlays+=global.BT
			if(M.icon=='BoohanBottom.dmi')
				M.overlays+=global.BH
			if(M.icon=='BrolySS1.dmi')
				M.AddGAura()
			if(M.icon=='GokuSS2.dmi')
				M.AddSSAura()
			if(M.icon=='TeenGohanSS2.dmi')
				M.AddSSAura()
			if(M.icon=='AltVegetaMajinSS2.dmi')
				M.AddSSAura()
			if(M.icon=='Goku Mid.dmi')
				M.icon_state="ReadyToFight"
			if(M.icon=='CoolerForm2.dmi')
				M.icon_state="fly"
		return ..()
	Del()
		if(fexists("Config.sav"))	fdel("Config.sav")
		var/savefile/F=new("Config.sav")
		F["LogoutLink"]<<LogoutLink
		F["MotD"]<<MotD
		SaveClans()
		return ..()

datum/Del()
	return ..()

world/OpenPort(Port)
	if(..(Port))	world<<"Now hosting on Port [Port]"
	else	world<<"Port [Port] could not be opened"

var/list/PhasedIcons=list()
proc/BalanceNPCS()
	for(var/mob/Enemy/NPCS/N in world)
		N.MaxPL*=2
		N.MaxKi*=5
		N.Str*=5
		N.Def*=5
proc/PhaseWorld()
	set background=1
	for(var/obj/TurfType/T in world)	T.PhaseAtom()
	for(var/turf/T in world)
		var/list/EdgeMaps=list(1,2,9)	//Map Zs that you can shoot ki blasts to the edge of
		if(T.z in EdgeMaps)	if(T.x==1 || T.x==400 || T.y==1 || T.y==400)	{T.density=1;T.SuperDensity=1}
		T.PhaseAtom()

atom/var/Phase=0
atom/var/DontPhase=0
obj/Phase
	layer=5
	density=0
	invisibility=1
	mouse_opacity=0
atom/proc/PhaseAtom(/**/)
	if(src.Phase || (src.layer>=5 && !src.density))
		if(src.layer>=6 || src.contents.len || src.overlays.len || src.DontPhase)	return
		src.layer=2.2
		var/srcLoc=locate(src.x,src.y,src.z)
		for(var/obj/Phase/P in srcLoc)	return
		var/icon/I
		if("[src.icon]" in PhasedIcons)	I=PhasedIcons["[src.icon]"]
		else	{I=src.icon-rgb(0,0,0,150);PhasedIcons["[src.icon]"]=I}
		var/obj/Phase/O=new(srcLoc)
		O.icon=I;O.icon_state=src.icon_state
		O.pixel_x=src.pixel_x;O.pixel_y=src.pixel_y

var/Hours=0
var/Minutes=0
var/Seconds=0
proc/TickLoop()
	while(world)
		Hours=round(world.time/10/60/60)
		Minutes=round(world.time/10/60-(60*Hours))
		Seconds=round(world.time/10-(60*Minutes)-(60*Hours*60))
		sleep(1)
proc/SecondLoop()
	while(world)
		for(var/mob/Civilians/C in world)
			if(C.NPC==144)
				step_rand(C,1)
		sleep(10)

proc/HourLoop()
	while(world)
		for(var/mob/M in Players)
			M.TrackStat("Days Played",time2text(world.timeofday,"YYYYMMMDD"),"List")
			if(M.LastWishDate!=time2text(world.timeofday,"YYYYMMDD"))	M.WishesMade=0
			if(M.Subscriber)	M.TrackStat("Days Subscribed",time2text(world.timeofday,"YYYYMMMDD"),"List")
		sleep(36000)
obj/blue
	icon='arrow.dmi'
	layer=20
	icon_state="0"
obj/blue2
	icon='arrow2.dmi'
	layer=20
	icon_state="0"
/*
proc/HouseLoop2()
	while(world)
		for(var/mob/Player/P in world)
			for(var/obj/Saidas/M in world)
				if(P.loc==M.loc)
					sleep(15)
					if(P.loc==M.loc)
						P.loc=P.OldLoc
		sleep(1)
proc/HouseLoop()
	while(world)
		for(var/mob/Player/P in world)
			for(var/obj/Entradas/M in world)
				if(P.loc==M.loc)
					sleep(20)
					if(P.loc==M.loc)
						P.OldLoc=P.loc
						P.loc=locate(M.NovoX,M.NovoY,8)
		sleep(1)*/

/*proc/CandyLoop()
	while(world)
		for(var/mob/K in world)
			for(var/obj/Doce/D in world)
				if(D.Chefe!=K)
					if(D.loc==K.loc)
						var/SalvarChar=K.icon
						K.icon='Candy.dmi'
						del	D
						sleep(100)
						K.icon=SalvarChar*/
proc/GLoop()
	while(world)
		for(var/mob/Player/K in world)
			var/OldFury=K.Fury
			sleep(10*10)
			if(K.Fury==OldFury && K.Fury!=100)
				K.Fury=0

proc/Loop()
	while(world)
		for(var/mob/M in world)
			if(M.Fury>8 && M.Fury!=100)	M.Fury=8
			if(M.CurTrans==0)
				M.BaseStr=M.Str
				M.BaseDef=M.Def
				M.BaseMaxPL=M.MaxPL
				M.BaseMaxKi=M.MaxKi
				M.BasePL=M.PL
				M.BaseKi=M.Ki
	//		if(M.Character.Race=="Namekuseijin")	M.Fury=0
			M.GenerateFuryBall()
//			M.GenerateSkillTab()
			M.PLGeral=(M.MaxPL+M.MaxKi+M.Str*10+M.Def*20)/4
			if(M.AFK && M.Party)
				M.LeaveParty()
			if(!M.ControlClients && M.Zens==666)
				if(M.z==8)	M.IsDead=0
		if(Saga=="Deus da Destruição") //MISSÃO PARALELA ESPECIAL É COMPLETADA
			if(Inimigos==7)
				for(var/mob/Player/P in AmtP)
					Inimigos=0
					P.EmEvento=0
					Contador=0
					P.loc=locate(322,61,1)
					P.Zens+=pick(3,4,5)
					P.AddExp(round(7500*100),"Missão Paralela Especial")
					P.Zenie+=20000
					P<<"<b>Você ganhou 20,000 Zennies!"
					P.chance=pick(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40)
					if(P.chance==14)
						for(var/obj/Perks/Poder_Supremo/S)
							P.UnlockedPerks+=S.name
							P.TrackStat("Perk Desbloqueado!","[P.UnlockedPerks.len]/[global.AllPerks.len]")
							P.Aviso=1
					if(P.chance==28)
						for(var/obj/Perks/Instinto_Superior/S)
							P.UnlockedPerks+=S.name
							P.TrackStat("Perk Desbloqueado!","[P.UnlockedPerks.len]/[global.AllPerks.len]")
							P.OldLoc=1
					AmtP-=P
				world<<"<b>Evento: <font color=[rgb(243,92,20)]>Missão Paralela Especial foi finalizada com sucesso! Parabéns aos participantes!"
		if(Saga=="Retorno de Freeza") //MISSÃO PARALELA ESPECIAL É COMPLETADA
			if(Inimigos==8)
				for(var/mob/Player/P in AmtP)
					Inimigos=0
					P.EmEvento=0
					Contador=0
					P.loc=locate(322,61,1)
					P.Zens+=pick(5,6,7)
					P.AddExp(round(10000*100),"Missão Paralela Especial")
					P.Zenie+=40000
					P<<"<b>Você ganhou 40,000 Zennies!"
					P.chance=pick(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40)
					if(P.chance==14)
						for(var/obj/Perks/Poder_Supremo/S)
							P.UnlockedPerks+=S.name
							P.TrackStat("Perk Desbloqueado!","[P.UnlockedPerks.len]/[global.AllPerks.len]")
							P.Aviso=1
					if(P.chance==28)
						for(var/obj/Perks/Instinto_Superior/S)
							P.UnlockedPerks+=S.name
							P.TrackStat("Perk Desbloqueado!","[P.UnlockedPerks.len]/[global.AllPerks.len]")
							P.OldLoc=1
					AmtP-=P
				world<<"<b>Evento: <font color=[rgb(243,92,20)]>Missão Paralela Especial foi finalizada com sucesso! Parabéns aos participantes!"
		if(Saga=="Goku Black") //MISSÃO PARALELA ESPECIAL É COMPLETADA
			if(Inimigos==11)
				for(var/mob/Player/P in AmtP)
					Inimigos=0
					P.EmEvento=0
					Contador=0
					P.loc=locate(322,61,1)
					P.Zens+=pick(7,8,9)
					P.AddExp(round(15000*100),"Missão Paralela Especial")
					P.Zenie+=60000
					P<<"<b>Você ganhou 60,000 Zennies!"
					P.chance=pick(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40)
					if(P.chance==14)
						for(var/obj/Perks/Poder_Supremo/S)
							P.UnlockedPerks+=S.name
							P.TrackStat("Perk Desbloqueado!","[P.UnlockedPerks.len]/[global.AllPerks.len]")
							P.Aviso=1
					if(P.chance==28)
						for(var/obj/Perks/Instinto_Superior/S)
							P.UnlockedPerks+=S.name
							P.TrackStat("Perk Desbloqueado!","[P.UnlockedPerks.len]/[global.AllPerks.len]")
							P.OldLoc=1
					AmtP-=P
				world<<"<b>Evento: <font color=[rgb(243,92,20)]>Missão Paralela Especial foi finalizada com sucesso! Parabéns aos participantes!"
		for(var/mob/Player/K in world)
			if(K.icon=='Excathedra.dmi' && K.icon_state=="powerup")
				K.AddHair()
			else	K.DeleteHair()
			if(K.HasPerk("Instinto Superior"))
				if(K.Character.name=="Goku Super" && K.icon_state=="koed" && K.UI==0)
					var/ui=pick(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40)
					if(ui==1)
						K.TesteBreaker=1
					else	K.UI=1
				if(K.icon_state!="koed")	K.UI=0
/*			if(K.Chovendo==0)
				if(K.z==1)
					var/obj/Chuva/C=new
					var/obj/Darkness/D=new
					K.client.screen+=C
					K.client.screen+=D
					K.Chovendo=1
					PlaySound(K,null,channel=13)
					PlaySound(K,'rain.ogg',repeat=1,channel=13)
					Puddle()
			if(K.z!=1)
				PlaySound(K,null,channel=13)
				K.Chovendo=0
				for(var/obj/Chuva/C in K.client.screen)
					del	C
				for(var/obj/Darkness/D in K.client.screen)
					del	D*/
			if(K.TesteBreaker==1)
				K.TesteBreaker=2
				K.LimitBreaker(K)//<<<<<<<------------------------------------------
			if(K.Skill25==1)
				K.icon_state="GenkiDamaCharge"
			if(K.icon=='Candy.dmi')
				K.MovementSpeed=0.1
			if(K.loc==locate(173,173,3))
				K.Traveling=1
				K<<"Viajando no Tempo..."
				sleep(50)
				K.Traveling=0
				K.loc=locate(276,136,2)
			if(K.loc==locate(174,173,3))
				K.Traveling=1
				K<<"Viajando no Tempo..."
				sleep(50)
				K.Traveling=0
				K.loc=locate(136,194,1)
			if(K.GravityTraining==0)
				K.overlays-=global.Gravidade
			if(K.loc==locate(66,95,3))
				sleep(10)
				if(K.loc==locate(66,95,3))
					var/Choice=alert(K,"Qual sala de treino você gostaria de ir? \nEscolha entre a Sala:.","Escolha de Sala","1","2","3")
					if(Choice=="1")
						K.loc=locate(281,204,8)
						K.Alignment=55
					if(Choice=="2")
						K.loc=locate(303,204,8)
						K.Alignment=56
					if(Choice=="3")
						K.loc=locate(325,204,8)
						K.Alignment=57
			for(var/mob/Player/J in world)
				if(K.icon=='Candy.dmi')
					if(K.TransformadoPor==J)
						if(J.loc==K.loc)
							var/Verify=(J.Level)*2
							if(K.Level<=Verify)
								K.ExitCP()
								K.IsDead=1
								K.overlays-=global.Halo
								K.overlays+=global.Halo
								world<<"<b><font color=black>Morte:<i><font color=[rgb(213,13,183)]> [J] comeu [K]!"
								J.Quest2+=1
								if(K.Quest2>1)
									J.AddExp(100000*K.Quest2,"Recompensas por Cabeça")
									world<<"<b><i><font color=red>[J] acabou com a fama de Assassino de [K]!"
									J.Zenie+=2000*K.Quest2
									J<<"<b>Você ganhou Níveis e Zennies pela morte de [K]!"
									Assassinos-=K
								K.CancelButtonCombo()
								K.loc=locate(14,14,3)
								K.LoseTournRound("Derrotado",J)
								K.TrackStat("Vezes Absorvido",1)
								J.TrackStat("Jogadores Absorvidos",1)
								K.ShowTutorial(Tutorials["Alpha Revival"])
								J.Def+=((K.Def)/20)
								J.Str+=((K.Str)/20)
								J.MaxPL+=((K.MaxPL)/20)
								J.MaxKi+=((K.MaxKi)/20)
							else
								J<<"<b>[K] é forte demais para que você possa absorvê-lo!"
		for(var/mob/Player/P in world)
			if(findtext("[P.icon]","SS2") || findtext("[P.icon]","SS3"))
				if(P.icon!='BrolySS2.dmi')
					P.SS2Mais(P)
			else	P.SS2Menos(P)
		for(var/mob/Player/P in world)
			if(P.Kuririn>=1800)
				var/PIN=rand(1,999999)
				var/Number=input(P,"Você ficou muito tempo no Saco de Pancadas e/ou Gravidade, o que pode ser suspeita de Macro.\nDigite o seguinte PIN para continuar jogando: [PIN]","BLOQUEADOR DE MACRO","[0]") as num
				if(Number!=PIN)
					P.loc=locate(323,62,1)
					P<<"<b>Você foi removido das capsulas de treino por errar o PIN e por estar com suspeitas de utilizar Macro."
				P.Kuririn=0
		ChecarAssassinos()
		for(var/mob/M in world)
			if(M.PoweringUp==1)
				if(M.CurTrans>0)
					if(findtext(M.Character.Race,"Saiyan") && M.icon!='VegetaUSSBlue.dmi' && M.icon!='VegetaUSSBlueB.dmi' && M.icon!='VegetaSuperGod.dmi' && M.icon!='VegetaSuperGodB.dmi' && M.icon!='BVegetaSSGodSS1.dmi' && M.icon!='GokuSSGodSS1K.dmi' && M.icon!='GokuSSGodSS1.dmi' && M.icon!='VegetaSSGodSS1.dmi' && M.icon!='BlackGokuRose.dmi' && M.icon!='MysticGohanMystic.dmi' && M.icon!='GokuSSGod.dmi')
						M.DeleteSSAura()
						M.AddSSAura()
					else
						if(findtext("[M.icon]","USSBlue"))
							M.RemoveBlueAura2()
							M.AddBlueAura2()
						if(M.icon=='GokuSSGodSS1.dmi' || M.icon=='VegetaSSGodSS1.dmi' || M.icon=='BVegetaSSGodSS1.dmi')
							M.RemoveBlueAura()
							M.AddBlueAura()
						if(M.icon=='BlackGokuRose.dmi')
							M.DeleteRoseAura()
							M.AddRoseAura()
		/*			M.DeleteSSAura()
					M.DeleteWAura()
					M.DeleteRAura(M)
					M.DeleteGAura()
					M.DeletePAura()
					M.DeleteBlackAura()
					M.RemoveBlueAura(src)
					M.RemoveBlueAura()
					M.DeleteRoseAura()
					M.RemoveGodAura(M)*/
		for(var/mob/M in world)
			if(!M.ControlClients)
				if(M.z==5 || M.z==6)
					if(M.Character.name=="Vegeta")
						M.icon='ScouterVegeta.dmi'
					if(M.Character.name=="Videl")
						M.icon='AltVegetaMajinSS2.dmi'
						M.name="Majin Vegeta"
						M.AddName()
					if(M.Character.name=="Yamcha")
						M.icon='MysticGohan.dmi'
						M.name="GT Gohan"
						M.AddName()
					if(M.Character.name=="Krillin")
						M.icon='GTGoten.dmi'
						M.name="GT Goten"
						M.AddName()
					if(M.Character.name=="Bardock")
						M.icon='GTTrunks.dmi'
						M.name="GT Trunks"
						M.AddName()
					if(M.Character.name=="Master Roshi")
						M.icon='MysticGohan.dmi'
						M.name="GT Gohan"
						M.AddName()
					if(M.Character.name=="Goten")
						M.icon='GTGoku.dmi'
						M.name="GT Goku"
						M.AddName()
					if(M.Character.name=="Olibu")
						M.icon='AltGTVegeta.dmi'
						M.name="GT Vegeta"
						M.AddName()
	/*	if(usr.name=="Draguno" || usr.key=="Ssjmestregoku" || usr.name=="Shawn")
			if(usr.x>=232 && usr.x<=309 && usr.y>=104 && usr.y<=169 && usr.z==3)// planeta dos kaioshins
				usr.AddExp(20,"Buff Kaioshin")
			if(usr.Talked18==0)
				for(var/obj/Items/Especiais/Kaioshin/R)
					usr.Y31+=R
					usr<<sound('BleepBloop.ogg',channel=1)
					usr<<"<b>Você ganhou os benefícios de Kaioshin!"
					usr.Talked18=1
		if(usr.key=="Daxus_EX")
			if(usr.x>=260 && usr.x<=333 && usr.y>=277 && usr.y<=365 && usr.z==3)// planeta do hakaishin
				usr.AddExp(25,"Buff Hakaishin")*/
		sleep(1)

mob/proc/SecondLoop()
	while(1)
//		var/Percent=src.PL/src.MaxPL
//		Percent*=100
		var/PraticaStr=pick(3,5,7)
		var/PraticaDef=pick(3,5)
		var/PraticaPL=pick(5,10,13)
		var/PraticaKi=pick(5,10,13)
		var/c=pick(1,2,3,4,5,6)
		for(var/mob/Player/P in world)
			if(c==6 && P.Fighting==1 && P.Shocking==1)
				var/mob/Attacker=P.Target
				if((P.PLGeral/Attacker.PLGeral)*100<50) //------------------ P GANHANDO ATRIBUTOS NA LUTA -----------------------
					if(P.PLGeral<100000)
						var/valor=pick(0.2,0.3,0.4,0.5)
						P.MaxPL+=P.MaxPL*valor
						P.MaxKi+=P.MaxKi*valor
						P.Str+=P.Str*valor
						P.Def+=P.Def*valor
					else
						if(P.PLGeral>=100000 && P.PLGeral<1000000)
							var/valor=pick(0.02,0.03,0.04,0.05)
							P.MaxPL+=P.MaxPL*valor
							P.MaxKi+=P.MaxKi*valor
							P.Str+=src.Str*valor
							P.Def+=P.Def*valor
						else
							if(P.PLGeral>=1000000 && P.PLGeral<100000000)
								var/valor=pick(0.002,0.003,0.004,0.005)
								P.MaxPL+=P.MaxPL*valor
								P.MaxKi+=P.MaxKi*valor
								P.Str+=src.Str*valor
								P.Def+=P.Def*valor
							else
								var/valor=pick(0.0002,0.0003,0.0004,0.0005)
								P.MaxPL+=P.MaxPL*valor
								P.MaxKi+=P.MaxKi*valor
								P.Str+=P.Str*valor
								P.Def+=P.Def*valor
				else
					if(P.PLGeral<100000)
						var/valor=pick(0.1,0.2)
						P.MaxPL+=P.MaxPL*valor
						P.MaxKi+=P.MaxKi*valor
						P.Str+=P.Str*valor
						P.Def+=P.Def*valor
					else
						if(P.PLGeral>=100000 && P.PLGeral<1000000)
							var/valor=pick(0.01,0.02)
							P.MaxPL+=P.MaxPL*valor
							P.MaxKi+=P.MaxKi*valor
							P.Str+=P.Str*valor
							P.Def+=P.Def*valor
						else
							if(P.PLGeral>=1000000 && P.PLGeral<100000000)
								var/valor=pick(0.001,0.002)
								P.MaxPL+=P.MaxPL*valor
								P.MaxKi+=P.MaxKi*valor
								P.Str+=P.Str*valor
								P.Def+=P.Def*valor
							else
								var/valor=pick(0.0001,0.0002)
								P.MaxPL+=P.MaxPL*valor
								P.MaxKi+=P.MaxKi*valor
								P.Str+=P.Str*valor
								P.Def+=P.Def*valor
			if(P.GravityTraining==1 && P.icon_state!="koed" && P.PL!=0 && P.X1==0)
				P.Def+=PraticaDef
				P.Str+=PraticaStr
				P.Talked18+=PraticaStr
				P.Talked17+=PraticaPL
				P.Talked19+=PraticaDef
				P.MaxPL+=PraticaPL
				P.MaxKi+=PraticaKi
				P.Talked9+=0.1
				P.Kuririn+=1
				if(P.Talked9>=500)
					P.Fadiga+=0.1
				else	P.Fadiga+=1
				if(P.Fadiga>100)
					P.Fadiga=100
					P.icon_state="koed"
					P.PL=0
					P.UpdatePlHUD()
				P.Talked10+=PraticaDef
				P.Talked11+=PraticaKi
			if(P.GravityTraining==1 && P.z!=4)
				for(var/obj/gravidade/g in P.client.screen)
					if(P.z==8 && P.x>=271 && P.y<=237 && P.y>=196)
						goto GOTO
					P.client.screen-=g
					P.GravityTraining=0
					P.overlays-=global.Gravidade
		GOTO
/*		if(usr.key=="DraguunnoNeko")
			usr.icon='ZamasuRecolor.dmi'
			usr.Character.BeamSpecial=new/CharSpecials/Yellow*/
		for(var/mob/M in world)
			if(M.Frozen==1)
				M.Time+=1
				if(M.Time>=16)
					M.Frozen=0
					M.Time=0
					M.overlays-=global.Freeze
			if(M.CooldownGenk==1)
				M.CanUse+=1
			if(M.CanUse>=600)
				M.CooldownGenk=0
				M.CanUse=0
		usr.Aprimoramento()
/*		for(var/mob/Civilians/C in world)
			if(C.NPC==144)
				del	C*/
		src.CheckAFK()
		src.PlayTimeSeconds+=1
		if(src.PlayTimeSeconds>=60)
			src.PlayTimeSeconds=0
			src.PlayTimeMinutes+=1
			if(src.PlayTimeMinutes>=60)
				src.PlayTimeMinutes=0
				src.PlayTimeHours+=1
		if(src.icon_state!="koed" && (src.IsUltra==1 || src.Character.Race=="Namekian" || src.Character.name=="Buu" || src.Character.name=="Cell"))
			if(src.Target.HasPerk("Destruidor Regenerativo"))
				src.AddPlPercent(0)
			else	src.AddPlPercent(1)
		if(src.HasPerk("Canalizador de Ki"))	src.AddKiPercent(1)
		if(src.HasPerk("Experiencia Automatica"))
			if(src.Exp==99)	src.GiveMedal(new/obj/Medals/EvenLazier)
			src.AddExp(1,"Experiencia Automatica")


/*		if(src.HasPerk("Furia") && src.Quest19==0)
			if(Percent<=25)
				src.Str+=Boost
				src.DamageMultiplier+=0.05
				src.Quest19=1
		if(Percent>25 && src.Quest19==1)
			src.Str-=Boost
			src.DamageMultiplier-=0.05
			src.Quest19=0
		if(!src.HasPerk("Furia") && src.Quest19==1)
			src.Str-=Boost
			src.DamageMultiplier-=0.05
			src.Quest19=0*/
		if(src.Clan)
			if(src.Clan.Emblem==1)
				src.DeleteEmblems()
				src.overlays+=global.Vitoria
				src.GiveMedal(new/obj/Medals/Registered_Mark)
			if(src.Clan.Emblem==2)
				src.DeleteEmblems()
				src.overlays+=global.Caveira
				src.GiveMedal(new/obj/Medals/Registered_Mark)
			if(src.Clan.Emblem==3)
				src.DeleteEmblems()
				src.overlays+=global.Espada
				src.GiveMedal(new/obj/Medals/Registered_Mark)
			if(src.Clan.Emblem==4)
				src.DeleteEmblems()
				src.overlays+=global.Esfera
				src.GiveMedal(new/obj/Medals/Registered_Mark)
			if(src.Clan.Emblem==5)
				src.DeleteEmblems()
				src.overlays+=global.Foice
				src.GiveMedal(new/obj/Medals/Registered_Mark)
			if(src.Clan.Emblem==6)
				src.DeleteEmblems()
				src.overlays+=global.Morte
				src.GiveMedal(new/obj/Medals/Registered_Mark)
			if(src.Clan.Emblem==7)
				src.DeleteEmblems()
				src.overlays+=global.Templar
				src.GiveMedal(new/obj/Medals/Registered_Mark)
			if(src.Clan.Emblem==8)
				src.DeleteEmblems()
				src.overlays+=global.Espada2
				src.GiveMedal(new/obj/Medals/Registered_Mark)
			if(src.Clan.Emblem==9)
				src.DeleteEmblems()
				src.overlays+=global.SSJ
				src.GiveMedal(new/obj/Medals/Registered_Mark)
			if(src.Clan.Emblem==10)
				src.DeleteEmblems()
				src.overlays+=global.Raio
				src.GiveMedal(new/obj/Medals/Registered_Mark)
			if(src.Clan.Emblem==11)
				src.DeleteEmblems()
				src.overlays+=global.Cruz
				src.GiveMedal(new/obj/Medals/Registered_Mark)
			if(src.Clan.Emblem==12)
				src.DeleteEmblems()
				src.overlays+=global.Fogo
				src.GiveMedal(new/obj/Medals/Registered_Mark)
			if(src.Clan.Emblem==13)
				src.DeleteEmblems()
				src.overlays+=global.Caveira2
				src.GiveMedal(new/obj/Medals/Registered_Mark)
			if(src.Clan.Emblem==14)
				src.DeleteEmblems()
				src.overlays+=global.ZW
				src.GiveMedal(new/obj/Medals/Registered_Mark)
			if(src.Clan.Emblem==15)
				src.DeleteEmblems()
				src.overlays+=global.Wolf
				src.GiveMedal(new/obj/Medals/Registered_Mark)
			if(src.Clan.Emblem==16)
				src.DeleteEmblems()
				src.overlays+=global.Majin
				src.GiveMedal(new/obj/Medals/Registered_Mark)
			if(src.Clan.Emblem==17)
				src.DeleteEmblems()
				src.overlays+=global.SS
				src.GiveMedal(new/obj/Medals/Registered_Mark)
			if(src.Clan.Emblem==18)
				src.DeleteEmblems()
				src.overlays+=global.DD
				src.GiveMedal(new/obj/Medals/Registered_Mark)
			if(src.Clan.Emblem==19)
				src.DeleteEmblems()
				src.overlays+=global.DS
				src.GiveMedal(new/obj/Medals/Registered_Mark)
		if(usr.z==10)
			for(var/obj/TerritoryWars/Territory_Flag/T)
				if(T.ClanOwner==usr.Clan.name)
					T.DeleteEmblems2()
					if(usr.Clan.Emblem==1)
						T.overlays+=global.Vitoria2
					if(usr.Clan.Emblem==2)
						T.overlays+=global.Caveira22
					if(usr.Clan.Emblem==3)
						T.overlays+=global.Espada22
					if(usr.Clan.Emblem==4)
						T.overlays+=global.Esfera2
					if(usr.Clan.Emblem==5)
						T.overlays+=global.Foice2
					if(usr.Clan.Emblem==6)
						T.overlays+=global.Morte2
					if(usr.Clan.Emblem==7)
						T.overlays+=global.Templar2
					if(usr.Clan.Emblem==8)
						T.overlays+=global.Espada222
					if(usr.Clan.Emblem==9)
						T.overlays+=global.SSJ2
					if(usr.Clan.Emblem==10)
						T.overlays+=global.Raio2
					if(usr.Clan.Emblem==11)
						T.overlays+=global.Cruz2
					if(usr.Clan.Emblem==12)
						T.overlays+=global.Fogo2
					if(usr.Clan.Emblem==13)
						T.overlays+=global.Caveira222
					if(usr.Clan.Emblem==14)
						T.overlays+=global.ZW2
					if(usr.Clan.Emblem==15)
						T.overlays+=global.Wolf2
					if(usr.Clan.Emblem==16)
						T.overlays+=global.Majin2
					if(usr.Clan.Emblem==17)
						T.overlays+=global.SS2
					if(usr.Clan.Emblem==18)
						T.overlays+=global.DD2
					if(usr.Clan.Emblem==19)
						T.overlays+=global.DS2
		if(src.PlayTimeHours==100)	src.GiveMedal(new/obj/Medals/TimeInABottle)
		if(src.PlayTimeHours==720)	src.GiveMedal(new/obj/Medals/OneMonth)
		sleep(10)
obj/Supplemental/Flower
	icon='Flowers.dmi';layer=TURF_LAYER;mouse_opacity=0
proc/GenerateFlowers()
	set background=1
	for(var/turf/Generic/Grass/G in world)
		if(rand(1,5)==1)
			var/counter=0
			if(G.contents.len || G.overlays.len)	continue
			while(rand(1,3)!=3 && counter<=2)
				counter+=1
				var/obj/Supplemental/Flower/NF=new(G)
				NF.pixel_x=rand(-12,12)
				NF.pixel_y=rand(-12,12)
				NF.icon_state="flower[rand(1,13)]"

client
	view=12
	fps=60
	control_freak=1
	default_verb_category=null
	mouse_pointer_icon='MousePointer.dmi'
	perspective=EDGE_PERSPECTIVE|EYE_PERSPECTIVE

mob/see_invisible=1

mob/Bump()
	if(src.ThrownBy)
		PlaySound(view(),'wallhit.ogg')
		src.EndKnockBack()
	return ..()
mob/proc/CanMove()
	if(usr.GetTrackedStat("NPCs Killed",usr.TempTracked)==1 && usr.x>=240 && usr.x<=258 && usr.z==3)	{usr.loc=locate(274,231,3)}
	if(src.Frozen==1)	return
	if(!src.CanAct())
		if(src.GhostMode)	return 1
		return
	return 1

mob/proc/Aprimoramento()
	var/mob/StatMob=src.GetFusionMob()
	var/mob/M=usr.Target
	if(round(StatMob.PL/StatMob.MaxPL*100)<=50 && usr.Character.name=="Hitto" && usr.Quest19==1)
		usr.DamageMultiplier=M.DamageMultiplier
		usr.Mds=1
	else
		if(round(StatMob.PL/StatMob.MaxPL*100)>50 && usr.Character.name=="Hitto" && usr.Quest19==1)
			usr.DamageMultiplier=1
			usr.Mds=0

mob/Player/Move(var/turf/NewTurf,NewDir)
	if(src.y>=358 && usr.x<222 && src.z==8)
		return
	if(src.Training=="Ki Training")
		src.Training=null
	if(src.Breaker==1)	return
	if(src.Frozen==1)	return
	if(src.Skill3==0)
		if(src.Character.name=="Yamcha" || src.Character.name=="Krillin" || src.Character.name=="Master Roshi")
			src.Skill3=1
			world<<"<b><font color=[rgb(94,164,221)]>[src.name] desbloqueou a Técnica 'Kamehameha'!"
	if(src.Skill13==0)
		if(src.Character.name=="Frieza")
			src.Skill13=1
			world<<"<b><font color=[rgb(94,164,221)]>[src.name] desbloqueou a Técnica 'Death Beam'!"
	if(src.Character.name=="Hitto" && src.Level>=350000 && src.Quest19==0)
		usr.Quest19=1
		world<<"<b><font color=[rgb(94,164,221)]>[usr.name] desbloqueou a Técnica 'Aprimoramento'!"
	src.DuelRangeCheck()
	src.LoadMiniMapBG();src.MMM.CalculateScreenLoc(src)
	if(src.icon_state=="Guard" || src.icon_state=="charge" || src.icon_state=="charge2" || src.icon_state=="GenkiDamaCharge")	src.dir=NewDir
	if(src.Training=="Focus Training")	src.StopFocusTraining=1
	if(!src.ThrownBy)	if(!src.CanMove() || src.icon_state=="powerup")	return
	if(!src.density)	for(var/mob/M in NewTurf)	if(!M.density && src.CanPVP(M))	{src.dir=NewDir;return}
	.=..();if(.)	src.LogDistanceTraveled()
	if(usr.GetTrackedStat("NPCs Killed",usr.TempTracked)==1 && usr.x>=240 && usr.x<=258 && usr.y>=209 && usr.z==3)	{usr.loc=locate(274,231,3)}

proc/Seconds2Time(var/Seconds)
	var/hours=round(Seconds/60/60)
	var/minutes=round(Seconds/60-(60*hours))
	var/seconds=round(Seconds-(60*minutes)-(60*hours*60))
	return "[hours]h [minutes]m [seconds]s"

proc/Ticks2Time(var/Ticks)
	var/hours=round(Ticks/10/60/60)
	var/minutes=round(Ticks/10/60-(60*hours))
	var/seconds=round(Ticks/10-(60*minutes)-(60*hours*60))
	return "[hours]h [minutes]m [seconds]s"

mob/proc/CheckAFK()
	if(src.client.inactivity>=3000)	if(!src.AFK)
		src.AFK=1
		src.DismissNPCs()
		src.overlays-=AfkIcon
		src.overlays+=AfkIcon
	else	if(src.AFK)
		src.AFK=0
		src.overlays-=AfkIcon

proc/SetWorldStatus()
	world.status="(v[GameVersion]) [Players.len] Online</font size>"

mob/Login()
	winset(src,"default.map1","zoom=[src.Zoom]")
	winset(src, "TextNPC", "is-visible=false")
	if(src.MyIsBanned())
		src << "Você está banido!"
		del src
		return
	usr<<"<b> Para falar, basta apertar a tecla 'Enter'."
	src.ControlClients=list(src.client)
	usr.Logg=0
	usr<<sound('Loggin.ogg')
	src.Chat=0
	if(usr.Logg==0)
		while(1)
			usr.loc=locate(101,362,8)
			if(usr.Logg==1)
				break
			sleep(1)
	if(src.CheckGlobalBan())	{del src;return}
	if(src.key=="Guest" || copytext(src.key,1,min(7,length(src.key)))=="Guest-")
		src<<"<b>Contas de visitantes estão desabilitadas!"
		src<<"Crie sua própria conta no site: http://www.BYOND.com"
		del src;return
	if(global.Players.len>=global.PlayerLimit && !(src.key in global.SubList))
		src<<"<b><font color=red>O servidor alcançou o seu limite máximo de jogadores: [global.PlayerLimit]!"
		del src;return
	src.Friends=list()
	src.OnlineFriends=list()
	src.LoadMedals();src.MedalCorrection()
	src.CapsuleChars=list(new/obj/CapsuleChars/Piccolo)
	if(src.LoadProc())
		for(var/mob/M in Players)
			M<<output("<b>[src]<font color=[rgb(0,0,255)]> entrou no jogo!</font>","window2.output1")
	else
		usr.loc=locate(131,362,8)
		usr.Resolution()
		usr<<sound(null)
		usr<<sound('Chala.ogg')
		usr.Traveling=1
	//	alert("Para falar com NPCs, basta clicar neles com o botão direito")
		return
	//	if(src.gender=="female")	src.Character=new/obj/Characters/Videl
	//	else	src.Character=new/obj/Characters/Goku_Mid
	//	src.ResetSuffix()
	//	src.icon=src.Character.icon
	//	world<<"<b>[src]<font color=[rgb(14,100,77)]> entrou no jogo pela primeira vez!</font>"
	//	src.loc=locate(223,231,3)
	//	alert("Para falar com NPCs, basta clicar neles com o botão direito")
	//	src.CanSave=1
	//	if(usr.GetTrackedStat("NPCs Killed",usr.TempTracked)==1 && usr.x>=240 && usr.x<=258 && usr.z==3)	{usr.loc=locate(274,231,3)}
	src.SubCheck()
	src.AddHUD()
	src.AddPartyHUD()
	src.UpdateLastOnline()
	spawn()	src.SecondLoop()
	spawn()	src.GuardRecharge()
//	winset(src,"FullMapWindow","pos=0,0;is-maximized=true")
//	winset(src,"LevelWindow","pos=100,100;size=640x480;is-visible=false")
	Players+=src
//	src.ViewMotD()
	SetWorldStatus()
	src.AssignClan()
	src.SetupOverlays()
	src.OnlineFriends()
	src.FillStatsGrid()
	winset(src,"window2","is-visible=true;pos=180,600")
	if(usr.HairStyle==1)	usr.GenerateHair1()
	if(usr.HairStyle==2)	usr.GenerateHair2()
	if(usr.HairStyle==3)	usr.GenerateHair3()
	if(usr.HairStyle==4)	usr.GenerateHair4()
	src.CanGetCashPoints=1;src.CashPointPurchaseInfo()
	src.GiveMedal(new/obj/Medals/Player);src.UpdateHubScore()
//	PlaySound(view(),pick('DBGTOP.ogg','DBZEND.ogg','DBZKAIEND.ogg','DBZKAIOP.ogg','DBZOP.ogg','DBZOP2.ogg','FlowHero.ogg'))
	src.TrackStat("Days Played",time2text(world.timeofday,"YYYYMMMDD"),"List")
	src.GeneralTutorials()
	if(usr.GetTrackedStat("NPCs Killed",usr.TempTracked)==1)	{usr.loc=locate(274,231,3)}
//	PlaySound(view(usr),pick('Dragon Ball Z Theme 9.ogg','Dragon Ball Z Theme 45.ogg','Dragon Ball Z Theme 13.ogg','Dragon Ball Z Theme 30.ogg','Dragon Ball Z Theme 17.ogg','Dragon Ball Z Theme 40.ogg','Dragon Ball Z Theme 28.ogg','Dragon Ball Z Theme 8.ogg'))
	if(src.key=="Rafafa47")	src.verbs+=typesof(/mob/GM/verb)
	if(src.key=="Hiukai")	src.verbs+=typesof(/mob/GM/verb)
	if(src.key=="Xalabaias")	src.verbs+=typesof(/mob/Test/verb)
	if(src.key=="Rafafa47")	src.verbs+=typesof(/mob/Test/verb)
	if(src.key=="Egy Arab")	src.verbs+=typesof(/mob/GM/verb)
	if(src.key=="Ccaroto7")	src.verbs+=typesof(/mob/GM/verb)
	if(src.key=="Hkl")	src.verbs+=typesof(/mob/GM/verb)
	if(src.key=="Hkl")	src.verbs+=typesof(/mob/Test/verb)
	if(src.key=="Hiukai")	src.verbs+=typesof(/mob/Test/verb)
	if(src.key=="RLKS")	src.verbs+=typesof(/mob/Test/verb)
	if(src.key=="Egy Arab")	src.verbs+=typesof(/mob/Test/verb)
	if(src.key=="Shawn_EX")	src.verbs+=typesof(/mob/Test/verb)
	if(src.key=="RLKS")	src.verbs+=typesof(/mob/GM/verb)
	if(src.key=="Shawn_EX")	src.verbs+=typesof(/mob/GM/verb)
	if(src.key=="Hkl")	src.verbs+=typesof(/mob/Subscriber/verb)
	if(src.key=="Shawn_EX")	src.verbs+=typesof(/mob/Subscriber/verb)
	if(src.key=="Xalabaias")	src.verbs+=typesof(/mob/GM/verb)
	if(src.key=="Eventer")	src.verbs+=typesof(/mob/GM/verb)
	if(src.key=="DraguunnoNeko")	src.verbs+=typesof(/mob/GM/verb)
	if(src.key=="Eventer")	src.verbs+=typesof(/mob/Test/verb)
	if(src.key=="")	src.verbs+=typesof(/mob/Icon/verb)
	if(src.key=="")	src.verbs+=typesof(/mob/Subscriber/verb)
	if(src.key=="")	src.verbs+=typesof(/mob/Subscriber/verb)
	if(src.key=="")	src.verbs+=typesof(/mob/Subscriber/verb)
	if(src.key=="")	src.verbs+=typesof(/mob/Subscriber/verb)
	if(src.key=="")	src.verbs+=typesof(/mob/Subscriber/verb)
	if(src.Character.name=="Master Roshi" || src.Character.name=="Krillin" || src.Character.name=="Yamcha")
		if(src.Skill3==0)
			src.Skill3=1
			world<<"<b><font color=[rgb(94,164,221)]>[src.name] desbloqueou a Técnica 'Kamehameha'!"
		//	alert("Você aprendeu a Técninca 'Kamehameha'!","")



	if(src.key=="Hkl")
		src.Character.BeamSpecial=new/CharSpecials/Yellow
		src.icon='Super Zamasu.dmi'
		src.UpdateFaceHUD()
		src.Character.Aura="Black"
	if(src.MajinForm==1)
		src.AddMajin()
	if(src.MajinForm==0)
		src.Revert()
		if(src.icon=='GokuKaioken.dmi')
			flick("revert",src)
			PlaySound(view(),'Descend.ogg')
			src.icon='Goku Mid.dmi'
			src.UpdateFaceHUD()
	if(usr.Subscriber==1)
		usr.DamageMultiplier+=0.3
		src.verbs+=typesof(/mob/Subscriber/verb)
	if(usr.Skill26==2)
		sleep(600*8)
		usr.Skill26=0
	usr.DamageMultiplier+=usr.Doing
	usr.NomeReserva=usr.name
	usr.SetFocus("default.map1")

mob/Del()
	src.ClearBeam()
	for(var/mob/M in src.Targeters)	M.TargetMob(null)
	return ..()

mob/Logout()
	world<<"<b>[src]<font color=[rgb(255,0,0)]> saiu do jogo!</font>"
	src.name=src.NomeReserva
	if(src.EmEvento==1)
		AmtP-=src
		src.loc=locate(322,61,1)
	for(var/mob/M in Players)	M.OnlineFriends-=src
	if(src.Clan)	src.Clan.OnlineMembers-=src
	if(src.Dueling)	src.EndDuel()
	if(src.IsUltra==1)
		src.NameColor="red"
	for(var/mob/M)
		if(src.Clonagem==1 && M.Clonagem2==1 && src.name==M.name)
			del	M
	if(src.ChatPane in ChatRooms)
		ChatRooms[src.ChatPane]-=src
		global.UpdateChatRoomWho(src.ChatPane)
	src.DropFlag("Saiu do jogo!");src.ExitCP()
	src.Resign("Saiu do jogo!")
	src.LeaveParty()
	Players-=src
	SetWorldStatus()
	var/Media=src.PL/src.MaxPL
	var/Percent=Media*100
	if(src.Character.name=="Hitto" && src.Quest19==1 && Percent<=30)	src.DamageMultiplier=1
	del src

mob/Click()
	usr.TargetMob(src)
	return ..()
