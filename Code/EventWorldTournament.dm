var
	LastTournHost
	TournChamp="Mr.Satan"
	TournRound=0
	TournRounds=0
	TournStatus="Idle"
	TournPerks="Ativados"
	TournHost="Revolução - Z"
	TournRegMode="Individual"
	TournDamage="Standard"
	TournPowerMode="Ki, somente"
	TournPrizeZenie=50000
	list/TournEntrants=list()
	list/TournFighters=list()
	WorldTournTag="<b><font color=[rgb(0,0,255)]>Torneio de Artes Marciais:</font>"
	obj/HUD/World_Tournament/WorldTournHUD=new()

mob/var/InTournament

var/obj/Teams/Flags/BlueTeam/BlueTeamFlag=new
var/obj/Teams/Flags/RedTeam/RedTeamFlag=new
var/list/TeamFlags=list(BlueTeamFlag,RedTeamFlag)
obj/Teams/Flags
	icon='Flags.dmi'
	layer=FLOAT_LAYER
	pixel_x=4;pixel_y=16
	BlueTeam
		icon_state="BlueTeam"
	RedTeam
		icon_state="RedTeam"

obj/HUD
	World_Tournament
		icon_state="WT"
		screen_loc="8,1"
		desc="Clique para criar um Torneio de Artes Marciais"
		MouseEntered()
			src.desc="[initial(src.desc)]\nWT Status: [global.TournStatus]"
			return ..()
		Click()
			usr.UpdateWTEntrants()
			usr.OpenedWindow("WTWindow")
			winset(usr,"WTWindow","pos=100,100;size=432x432;is-visible=true")

mob/proc/UpdateWTEntrants()
	if(!src.client)	return
	if(global.TournStatus=="Idle")	winset(src,"WTWindow.RegBtn","text=Criar")
	else	winset(src,"WTWindow.RegBtn","text=Registro")
	winset(src,"WTWindow.StatusLabel","text=\"Torneio de Artes Marciais\"")
	winset(src,"WTWindow.ChampLabel","text=\"Último Vencedor: [global.TournChamp]\nVenceu após [global.TournRounds] Rounds\"")
	winset(src,"WTWindow.EntrantsLabel","text=\"[global.TournEntrants.len] Entrada(s) do Torneio de Artes Marciais ([global.TournRegMode])\"")
	winset(src,"WTWindow.PrizeHostLabel","text=\"[FullNum(global.TournPrizeZenie)] Zennie: Hospedado por [global.TournHost]\"")
	winset(src,"WTWindow.DamageLabel","text=\"Dano: [global.TournDamage]")
	winset(src,"WTWindow.PerksLabel","text=\"Perks: [global.TournPerks]\"")
	winset(src,"WTWindow.PowerUpLabel","text=\"Elevar Poder: [global.TournPowerMode]\"")
	var/HTML="<body bgcolor=[rgb(0,0,64)]><center><table width=100% border=1 bordercolor=[rgb(151,210,209)]>"
	if(global.TournRound)	HTML+="<tr><td NoWrap colspan=2><font color=[rgb(255,255,255)] face=comic><b><center>Round [global.TournRound] in Progress"
	var/counter=0
	for(var/v in global.TournEntrants)
		counter+=1
		if(counter%2)	HTML+="<tr><td rowspan=2 width=1% NoWrap><font color=[rgb(151,210,209)] face=comic><b>Round [global.TournRound+round(counter/2,1)]"
		else	HTML+="<tr>"
		HTML+="<td NoWrap><font color=[rgb(151,210,209)] face=comic><b>[v]"
	src<<browse(HTML,"window=WTWindow.EntrantsBrowser")

proc/UpdateWTEntrants()
	for(var/mob/M in Players)	if("WTWindow" in M.OpenWindows)	spawn(-1)	M.UpdateWTEntrants()

mob/verb/HostWT()
	set hidden=1
	if(global.LastTournHost==src.name)	{src<<"3 Minutos entre as criações!";return}
	if(global.TournStatus!="Idle")	{src<<"Um Torneio de Artes Marciais já está em andamento";return}
	var/ZenieInput=text2num(winget(src,"WTHostWindow.ZenieInput","text"))
	if(ZenieInput<50000)	{src<<"50,000 Zenie no mínimo";return}
	if(ZenieInput>src.Zenie)	{src<<"Você não possui essa quantidade";return}
	var/list/FirstModes=params2list(winget(src,"WTHostWindow.SingleReg;WTHostWindow.RoyaleReg;WTHostWindow.PerksEnabled;WTHostWindow.BalancedDamage","is-checked"))
	var/list/PowerUpModes=params2list(winget(src,"WTHostWindow.Ambos;WTHostWindow.Ki, somente;WTHostWindow.PL, somente;WTHostWindow.Ki, depois PL;WTHostWindow.PL, depois Ki","is-checked"))
	if(ZenieInput<50000)	{src<<"50,000 Zenie no mínimo";return}
	if(ZenieInput>src.Zenie)	{src<<"Você não possui essa quantidade!";return}
	if(global.TournStatus!="Idle")	{src<<"Um Torneio de Artes Marciais já está em andamento";return}
	src.Zenie-=ZenieInput
	global.TournHost=src.name
	global.TournPrizeZenie=ZenieInput
	if(FirstModes["WTHostWindow.SingleReg.is-checked"]=="true")	global.TournRegMode="Individual"
	else	if(FirstModes["WTHostWindow.RoyaleReg.is-checked"]=="true")	global.TournRegMode="Sobrevivência"
	else	global.TournRegMode="Grupo"
	if(FirstModes["WTHostWindow.PerksEnabled.is-checked"]=="true")	global.TournPerks="Ativados"
	else	global.TournPerks="Desativados"
	if(FirstModes["WTHostWindow.BalancedDamage.is-checked"]=="true")	global.TournDamage="Balanced"
	else	global.TournDamage="Standard"
	if(PowerUpModes["WTHostWindow.Ambos.is-checked"]=="true")	global.TournPowerMode="Ambos"
	else	if(PowerUpModes["WTHostWindow.Ki, somente.is-checked"]=="true")	global.TournPowerMode="Ki, somente"
	else	if(PowerUpModes["WTHostWindow.PL, somente.is-checked"]=="true")	global.TournPowerMode="PL, somente"
	else	if(PowerUpModes["WTHostWindow.Ki, depois PL.is-checked"]=="true")	global.TournPowerMode="Ki, depois PL"
	else	if(PowerUpModes["WTHostWindow.PL, depois Ki.is-checked"]=="true")	global.TournPowerMode="PL, depois Ki"
	else	global.TournPowerMode="Nada"
	winset(src,"WTHostWindow","is-visible=false")
	src.GiveMedal(new/obj/Medals/Sponsor)
	src.TrackStat("WTs Hosted",1)
	global.StartTournHosting()

mob/verb/WTRegister()
	set hidden=1
	if(usr.Traveling==1)	return
	if(usr.x>=209 && usr.z==3)	return
	for(var/mob/Player/P in AmtP)
		if(P==usr)
			usr<<"<b>Acesso Negado! Você está participando ou está registrado em outro Evento"
			usr<<sound('No.ogg')
			return
	if(global.TournStatus=="Idle")
		winset(usr,"WTHostWindow.ZenieInput","focus=true;text='50000'")
		winset(usr,"WTHostWindow.ZenieLabel","text='Você tem [FullNum(src.Zenie)] Zennie.'")
		winset(usr,"WTHostWindow","pos=100,100;size=432x432;is-visible=true");return
	else	if(global.TournStatus!="Registering")	{alert("Os registros acabaram","Torneio de Artes Marciais");return}
	usr=usr.GetFusionMob()
	for(var/mob/T in usr.GetTeamList())
		for(var/mob/M in global.TournEntrants)
			for(var/client/MC in M.ControlClients)
				for(var/client/TC in T.ControlClients)
					if(MC.computer_id==TC.computer_id)
						alert("Você já está registrado!","Torneio de Artes Marciais");return
	global.TournEntrants+=usr
	global.UpdateWTEntrants()
	world<<"[global.WorldTournTag] [usr] se registrou! ~ [global.TournEntrants.len] Entrada(s) ~"
	usr.Kaioshin=1

mob/verb/WTWatch()
	set hidden=1
	var/mob/FusionMob=usr.GetFusionMob()
	if(usr.x>=209 && usr.z==3)	return
	if(usr.client.eye==FusionMob)
		usr.client.eye=locate(226,62,1)
	else	usr.client.eye=FusionMob

var/list/TournSpawners=list()
obj/Supplemental/TournSpawner
	var/SpawnerID="1"
	New()
		global.TournSpawners+=src.SpawnerID
		TournSpawners[src.SpawnerID]=src
		return ..()

var/list/RingEdges=list()
turf/TournamentRing
	layer=10
	var/ResetDensity=0
	New()
		src.ResetDensity=src.density
		global.RingEdges+=src
		return ..()

proc/GetWTBlock()
	return block(locate(214,49,1),locate(237,73,1))

proc/StartTournHosting()
	world<<"[global.WorldTournTag] [FullNum(global.TournPrizeZenie)] Zennie hospedado por [global.TournHost]!"
	world<<"[global.WorldTournTag] [global.TournRegMode], Dano: [global.TournDamage], Perks [global.TournPerks], Elevar Poder: [global.TournPowerMode]!"
	world<<"[global.WorldTournTag] Aceitando Registros!"
	global.TournStatus="Registering"
	global.UpdateWTEntrants()
	spawn(3*600)	if(global.TournStatus=="Registering")
		if(global.TournEntrants.len<=1)
			world<<"[global.WorldTournTag] Cancelado! ([global.TournEntrants.len] Entrada)"
			for(var/mob/M in Players)	if(M.name==global.TournHost)	M.Zenie+=global.TournPrizeZenie
			EndTournament()
		else
			world<<"[global.WorldTournTag] Os registros acabaram ([global.TournEntrants.len] Entradas)"
			for(var/turf/TournamentRing/R in global.RingEdges)	{R.density=1;R.SuperDensity=1}
			global.StartTournRound()

proc/LoopWorldTourn()
	while(world)
		if(global.TournStatus=="Idle")
			global.TournHost="Revolução - Z"
			global.TournPrizeZenie=50000
			global.TournPerks="Ativados"
			global.TournDamage="Standard"
			global.TournRegMode="Individual"
			global.TournPowerMode="Ki, somente"
			global.StartTournHosting()
		sleep(10*600)

mob/proc/QuitTournament(var/Reason="Forfeit?")
	if(src.InTournament)	src.LoseTournRound(Reason)
	if(src in global.TournEntrants)
		global.TournEntrants-=src;global.UpdateWTEntrants()
		world<<"[global.WorldTournTag] [src] Resignou ([Reason]) ([global.TournEntrants.len] Entradas Sobrando)"
		if(global.TournRegMode=="Grupo" && Reason!="Duplicate Party" && src.Party)	for(var/mob/M in src.Party-src)	if(M.ControlClients)
			global.TournEntrants+=M;global.UpdateWTEntrants()
			world<<"[global.WorldTournTag] [M] registrou (Recolocamento do Grupo) ([global.TournEntrants.len] Entradas)";break

mob/proc/TournTeamLeft()
	for(var/mob/M in global.TournFighters-src)	if(global.TournFighters[M]==global.TournFighters[src])	return 1

mob/proc/LoseTournRound(var/Reason="Forfeited?",var/mob/Winner)
	if(src.InTournament)
		var/SrcTeamLeft=src.TournTeamLeft()
		src.InTournament=0;src.overlays-=global.TeamFlags
		src.Team=null;src.PowerMode=src.PreferredPowerMode
		global.TournFighters-=src;global.UpdateWTEntrants()
		src.ClearTournamentRing();src.JoinMissionCheck()
		if(!SrcTeamLeft)
			for(var/mob/M in src.GetTeamList())
				global.TournEntrants-=M
				M.TrackStat("WT Rounds Lost",1)
			if(!Winner)	Winner=global.TournFighters[1]
			world<<"[global.WorldTournTag] [Winner] Avança! ([src] [Reason])"
			if(global.TournRegMode=="Royale")	{global.TournRound+=1;global.UpdateWTEntrants()}
			if(global.TournRegMode=="Parties")	if(!Winner.Party || Winner.Party.len<=1)	if(src.Party && src.Party.len>=2)	Winner.GiveMedal(new/obj/Medals/IStandAlone)
			for(var/mob/M in Winner.GetTeamList())
				M.AddExp(320*320,"Round")
				M.TrackStat("WT Rounds Won",1)
				M.overlays-=global.TeamFlags
				if(global.TournRegMode!="Sobrevivência")
					M.Team=null
					M.InTournament=0
					M.JoinMissionCheck()
					M.PowerMode=M.PreferredPowerMode
					M.AddPlPercent(100);M.AddKiPercent(100)
			if(global.TournRegMode!="Sobrevivência" || global.TournFighters.len==1)
				if(global.TournRegMode=="Sobrevivência")
					Winner.Team=null
					Winner.InTournament=0
					Winner.JoinMissionCheck()
					Winner.PowerMode=Winner.PreferredPowerMode
					Winner.AddPlPercent(100);Winner.AddKiPercent(100)
				global.TournFighters=list()
				global.StartTournRound()

mob/proc/ClearTournamentRing(/**/)
	if(src.z==1 && global.TournStatus!="Idle" && global.TournStatus!="Registering")
		if(src.x>=213 && src.x<=238)
			if(src.y>=48 && src.y<=74)
				if(!src.InTournament)
					src.loc=locate(225,45,1)

proc/EndTournament()
	global.TournRound=0
	global.TournStatus="Idle"
	global.TournEntrants=list()
	global.UpdateWTEntrants()
	for(var/turf/TournamentRing/R in global.RingEdges)	{R.density=R.ResetDensity;R.SuperDensity=0}

mob/proc/GetTeamList()
	var/list/TeamList=list(src)
	if(global.TournRegMode=="Grupo" && src.Party && src.Party.len)	TeamList=src.Party
	return TeamList

proc/StartTournRound()
	if(global.TournEntrants.len==1)
		var/mob/Winner=global.TournEntrants[1]
		global.LastTournHost=global.TournHost
		spawn(3*320)	global.LastTournHost=null
		world<<"[global.WorldTournTag] [Winner] venceu o Torneio de Artes Marciais!"
		world<<"[global.WorldTournTag] [Winner] ganhou [FullNum(global.TournPrizeZenie)] Zennie e [FullNum(1000*global.TournRound)] níveis!"
		for(var/mob/M in Winner.GetTeamList())
			M.InTournament=0
			M.TrackStat("World Tournaments Won",1)
			M.GiveMedal(new/obj/Medals/WorldChampion)
			if(global.TournRegMode=="Sobrevivência")	M.GiveMedal(new/obj/Medals/RoyaleRoyalty)
			if(global.TournHost==M.name)	M.GiveMedal(new/obj/Medals/Refunded)
			if(M.name==global.TournChamp)	M.GiveMedal(new/obj/Medals/TitleDefender)
			if(global.TournRegMode=="Grupo" && M.Party)	M.AddZenie(round(global.TournPrizeZenie/max(1,M.Party.len)))
			else	M.AddZenie(global.TournPrizeZenie)
			M.AddExp(320*global.TournRound*320,"Parabéns!")
		global.TournRounds=global.TournRound;global.TournChamp=Winner.name
		EndTournament()
		return
	global.TournRound+=1
	global.TournStatus="Face-Off"
	for(var/mob/M in world)
		M.InTournament=0;M.ClearTournamentRing()
	global.TournFighters=list()
	var/TotalTeams=2
	if(global.TournRegMode=="Sobrevivência")	TotalTeams=global.TournEntrants.len
	for(var/i=1;i<=TotalTeams;i++)
		for(var/mob/E in global.TournEntrants)
			global.TournEntrants-=E
			global.TournEntrants+=E
			var/TeamMember=0
			for(var/mob/M in E.GetTeamList())
				TeamMember+=1
				M.InTournament=1
				M.Team="Team [i]"
				global.TournFighters+=M
				global.TournFighters[M]="Team [i]"
				M.ExitCP();M.PowerMode=global.TournPowerMode
				M.overlays=null
				M.icon_state=""
				M.Pessoas=0
				M.Skill25=0
				M.Charging=0
				M.AddName()
				M.AddClanName()
				M.ForceCancelFlight();M.ForceCancelTraining()
				if(global.TournRegMode!="Grupo")	M.DismissNPCs()
				if(global.TournRegMode=="Sobrevivência")	M.loc=locate(rand(217,235),rand(54,69),1)
				else
					var/obj/Supplemental/TournSpawner=global.TournSpawners["P[i]S[TeamMember]"]
					M.CancelSmartFollow();M.loc=TournSpawner.loc;M.dir=TournSpawner.dir
				M.AddTeamFlag()
				M.AddPlPercent(100);M.AddKiPercent(100)
				if(M.icon_state=="koed")	M.ResetIS()
				spawn()	if(M)	M.CountDown("Iniciando em:",10)
				if(M.Dueling)
					if(M.DuelFlag)
						M.TrackStat("[M.DuelFlag.DuelType] Duels Exited (WT)",1)
						M.Dueling.TrackStat("[M.DuelFlag.DuelType] Duels Canceled",1)
					M<<"Duelo cancelado! Você está registrado em um Torneio de Artes Marciais!"
					M.Dueling<<"Duelo cancelado! [src] está registrado em um Torneio de Artes Marciais!"
					M.EndDuel()
			break
	world<<"[WorldTournTag] Round [global.TournRound]: [global.TournFighters[1]] vs [global.TournFighters[2]] ([global.TournEntrants.len] Entradas Sobrando)"
	global.UpdateWTEntrants()
	var/ThisRound=global.TournRound
	spawn(100)
		if(ThisRound==global.TournRound)	global.TournStatus="Battle"
		else	if(global.TournRegMode=="Sobrevivência" && global.TournStatus=="Face-Off")	global.TournStatus="Battle"
	spawn(3*600)	if(ThisRound==global.TournRound)
		var/mob/Loser=pick(global.TournFighters)
		for(var/mob/L in global.TournFighters)	if(L.PL/L.MaxPL<Loser.PL/Loser.MaxPL)	Loser=L
		Loser.LoseTournRound("Tempo Acabou")