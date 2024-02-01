var/ClanWarsMode="Idle Mode"
var/ClanWarsStatus="Idle"
var/list/ClanWarsEntrants=list()
var/datum/Clan/ClanWarsWinner

obj/HUD
	Clan_Wars
		icon_state="CW"
		screen_loc="6,1"
		desc="Clan Wars"
		MouseEntered()
			src.desc="Modo do Guerra de Clan: [global.ClanWarsMode]\nEstatus do Guerra de Clan: [global.ClanWarsStatus]\n[global.ClanWarsEntrants.len] Entradas"
			return ..()
		Click()
			usr.UpdateCWEntrants()
			usr.OpenedWindow("ClanWarsWindow")
			winset(usr,"ClanWarsWindow","pos=100,100;size=432x432;is-visible=true")

mob/proc/UpdateCWEntrants()
	if(!src.client)	return
	winset(src,"ClanWarsPane","title='Clan Wars - [global.ClanWarsMode]'")
	winset(src,"ClanWarsPane.ChampLabel","text=\"Clan Wars - [global.ClanWarsMode]\nDefending Clan: [global.ClanWarsWinner]\"")
	winset(src,"ClanWarsPane.EntrantsLabel","text=\"[global.ClanWarsEntrants.len] Clan Wars Entrants ([global.ClanWarsMode])\"")
	winset(src,"ClanWarsPane.StatusLabel","text=\"Clan Wars Status: [global.ClanWarsStatus]\"")
	var/HTML="<body bgcolor=[rgb(0,0,64)]><center><table width=100% border=1 bordercolor=[rgb(151,210,209)]>"
	var/FMT="<font face=comic color=[rgb(151,210,209)]><b>"
	var/counter=0
	for(var/mob/M in global.ClanWarsEntrants)
		counter+=1
		HTML+="<tr><td>[FMT]{[M.Clan]} [M]"
	src<<browse(HTML,"window=ClanWarsPane.EntrantsBrowser")

proc/UpdateCWEntrants()
	for(var/mob/M in Players)	if("ClanWarsWindow" in M.OpenWindows)	spawn(-1)	M.UpdateCWEntrants()

mob/verb/CWRegister()
	set hidden=1
	if(usr.Traveling==1)	return
	for(var/mob/Player/P in AmtP)
		if(P==usr)
			usr<<"<b>Acesso Negado! Você está participando ou está registrado em outro Evento"
			usr<<sound('No.ogg')
			return
//	if(global.ClanWarsStatus!="Registro")	{alert("Tempo de registro está terminado!","Guerra de Clan");return}
	usr=usr.GetFusionMob()
	if(!usr.Clan)	{alert("Você tem que ter um Clan para entrar no Guerra de Clan!","Guerra de Clan");return}
	for(var/mob/M in global.ClanWarsEntrants)
		if(usr.client.computer_id==M.client.computer_id)
			alert("Você já está registrado","Guerra de Clan");return
	global.ClanWarsEntrants+=usr
	global.ClanWarsEntrants=SortDatumList(global.ClanWarsEntrants,"Clan")
	global.UpdateCWEntrants()
	world<<"[FlagWarsTag] <b><font color=[usr.Clan.Color]>{[usr.Clan]}</font color> [usr] se registrou ([global.ClanWarsEntrants.len] Entradas)"

mob/proc/Resign(var/Reason="Forfeit")
	src.QuitTournament(Reason)
	src.QuitClanWars(Reason)

mob/proc/QuitClanWars(var/Reason="Forfeit?")
	if(src in global.ClanWarsEntrants)
		if(global.ClanWarsStatus=="Battle")	src.ExitCP()
		global.ClanWarsEntrants-=src
		global.ClanWarsEntrants=SortDatumList(global.ClanWarsEntrants,"Clan")
		global.UpdateCWEntrants()
		var/ClanTag;if(src.Clan)	ClanTag="<font color=[src.Clan.Color]>{[src.Clan]}</font color> "
		world<<"[global.FlagWarsTag] <b>[ClanTag][src] resignado ([Reason]) ([global.ClanWarsEntrants.len] Sobras de entradas)"

mob/proc/JoinClanWars(/**/)
	if(global.ClanWarsStatus=="Battle")
		if(usr.Traveling==1)	return
		if(src.InTournament)	return
		for(var/mob/Player/P in AmtP)
			if(P==usr)
				usr<<"<b>Acesso Negado! Você está participando ou está registrado em outro Evento"
				usr<<sound('No.ogg')
				return
		if(!src.client || !src.Clan)	return
		var/Instances=InstanceDatum.Instances["Flag Wars"]
		src.SetInstance(Instances[1])
		src.ShowForcedMiniMap()
		src.client.screen+=global.FWMMMs
		src.DismissNPCs();src.GhostMode()
		spawn()	alert(src,"- Tem 2 bandeiras Vermelhas, Azuis, Pretas e Brancas pelo mapa.\n- Apenas um grupo de bandeiras irá surgir a cada 6 entradas.\n- Você pontua quando junta duas bandeiras de mesma cor.\n- Vá para uma bandeira caída para pegá-la.\n- Você também pode combinar bandeiras que estão largadas no chão ou então com membros do mesmo Clan que carregam uma bandeira de mesma cor!\n- Se alguém te golpear enquanto carrega uma bandeira, você irá derrubá-la.\n- Você ganha 500 níveis e 100 Clan Exp a cada vez que pontuar.\n- A batalha dura 10 minutos.","Flag Wars")

mob/proc/JoinClanWarsCheck()
	if(src in global.ClanWarsEntrants)
		src.JoinClanWars()
		return 1

proc/StartCW()
	global.ClanWarsStatus="Battle"
	world<<"[FlagWarsTag] <b>Guerra de Clan está começando! ([global.ClanWarsEntrants.len] Entradas)"
	for(var/mob/M in global.ClanWarsEntrants)	M.JoinClanWars()

proc/LoopClanWars()
	while(world)
		for(var/mob/M in global.ClanWarsEntrants)	M.ExitCP()
		world<<"[FlagWarsTag] <b>Agora está aceitando registros!"
		global.ClanWarsStatus="Registro"
		global.ClanWarsMode="Flag Wars"
		global.ClanWarsEntrants=list()
		global.UpdateCWEntrants()
		spawn(5*600)
			global.StartCW()
		sleep(15*600)