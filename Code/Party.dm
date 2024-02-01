var/PHTop=15
var/MaxParty=4

mob/var/tmp/PartyID
mob/var/tmp/list/Party
mob/var/tmp/list/PartyPics
mob/var/tmp/list/PartyPlBars
mob/var/tmp/list/PartyKiBars

obj/HUD/Party
	PlayerPic
		icon='HUD.dmi'
		name="Party Options"
		icon_state="PlayerBG"
		var/mob/Mob2Display
		Click()
			usr.TargetMob(src.Mob2Display)
		verb/Sair_do_Grupo()
			set src in world
			set category=null
			usr.LeaveParty()
		verb/Retirar()
			set src in world
			set category=null
			if(!src.Mob2Display || src.Mob2Display.Owner!=usr)	{usr<<"Essa Capsula não é sua!";return}
			src.Mob2Display.DismissNPC()
		proc/UpdateIcon(var/mob/M)
			var/icon/I=new('HUD.dmi',"PlayerBG",SOUTH,1)
			var/icon/O=new(M.icon,"",SOUTH,1)
			I.Blend(O,ICON_OVERLAY)
			src.Mob2Display=M
			src.icon=I
		New(var/SL)	src.screen_loc=SL
	Bar
		layer=11
		icon='Bars.dmi'
		icon_state="o31"
		New(var/SL)
			src.screen_loc=SL
			src.underlays+=new/obj/HUD/Party/BarBG
	BarBG
		icon='Bars.dmi'
		icon_state="r31"

mob/proc/DismissNPC(/**/)
	if(src.ControlClients)	{world.log<<"* DismissNPC Called on [src]?";return}
	src.ExitCP();src.LeaveParty()
	del src

mob/proc/AddPartyHUD()
	if(!src.Party)
		src.Party=list()
		src.PartyPics=list()
		src.PartyPlBars=list()
		src.PartyKiBars=list()
		for(var/i=1;i<=global.MaxParty;i++)
			src.WriteHUDText(2,1,global.PHTop-i,19,"Party[i]","Player Name")
			src.UpdateHUDText("Party[i]","Player Name")
			src.PartyPics+=new/obj/HUD/Party/PlayerPic("1,[global.PHTop-i]")
			src.client.screen+=src.PartyPics[i]
			src.PartyPlBars+=new/obj/HUD/Party/Bar("2:1,[global.PHTop-i]:11")
			src.PartyKiBars+=new/obj/HUD/Party/Bar("2:1,[global.PHTop-i]:4")
			src.client.screen+=src.PartyPlBars[i]
			src.client.screen+=src.PartyKiBars[i]
	src.ClearPartyHUD()

mob/proc/UpdatePartyIcon()
	for(var/mob/M in src.Party)	for(var/client/C in M.ControlClients)
		for(var/obj/HUD/Party/PlayerPic/P in C.screen)	if(P.Mob2Display==src)	P.UpdateIcon(src)

mob/proc/UpdatePartyPL(var/mob/M)
	if(!src.ControlClients)	return
	var/obj/HUD/Party/Bar/B=src.PartyPlBars[M.PartyID]
	B.icon_state="g[round(M.PL/M.MaxPL*31)]"

mob/proc/UpdatePartyKi(var/mob/M)
	if(!src.ControlClients)	return
	var/obj/HUD/Party/Bar/B=src.PartyKiBars[M.PartyID]
	B.icon_state="b[round(M.Ki/M.MaxKi*31)]"

mob/proc/ClearPartyHUD()
	for(var/client/C in src.ControlClients)
		for(var/i=src.Party.len+1;i<=global.MaxParty;i++)
			src.UpdateHUDText("Party[i]")
			C.screen-=src.PartyPics[i]
			C.screen-=src.PartyPlBars[i]
			C.screen-=src.PartyKiBars[i]

mob/proc/UpdatePartyHUD(var/mob/M)
	if(!src.client)	return
	src.UpdateHUDText("Party[M.PartyID]",AtName(M.name))
	var/obj/HUD/Party/PlayerPic/P=src.PartyPics[M.PartyID]
	P.UpdateIcon(M)
	src.UpdatePartyPL(M)
	src.UpdatePartyKi(M)
	src.client.screen+=src.PartyPics[M.PartyID]
	src.client.screen+=src.PartyPlBars[M.PartyID]
	src.client.screen+=src.PartyKiBars[M.PartyID]

mob/var/IgnoreParties
mob/verb/Ignore_Parties()
	set hidden=1
	usr.IgnoreParties=!usr.IgnoreParties
	if(usr.IgnoreParties)	usr<<"Agora você está ignorando todos os convites para Grupo."
	else	usr<<"Agora você está aceitando todos os convites para Grupo."

mob/var/tmp/PartyInvites=list()
mob/var/tmp/PartyIgnores=list()
mob/Player/verb/Party()
	set src in world
	set category=null
	if(!src.Party || !usr.Party)	return
	if(usr.Party.len>=4)	{usr<<"Seu Grupo já está cheio...";return}
	if(src.Party.len)	{usr<<"[src] já está num Grupo...";return}
	if(src.IgnoreParties)	{usr<<"[src] está ignorando convites para Grupo...";return}
	if(usr.key in src.PartyInvites)	{usr<<"[src] já está pendente de um convite...";return}
	if(usr.key in src.PartyIgnores)	{usr<<"[src] está ignorando seu convite para Grupo...";return}
	if(usr.client.computer_id==src.client.computer_id)	if(src.key!="Falacy")	{usr<<"Você não pode convidar você mesmo...";return}
	if(!(usr in usr.Party))
		usr.Party+=usr;usr.PartyID=1
		usr.UpdatePartyHUD(usr)
	src.PopupHUD(new/obj/HUD/Popups/Party(usr),"Convite para Grupo vindo de [usr]")
	usr<<"Convite para Grupo enviado para [src]"
	src<<"Convite para Grupo de [usr]"
	src.PartyInvites+=usr.key

mob/proc/AcceptPartyInvite(var/mob/Inviter)
	var/Choice=alert("Gostaria de entrar para o Grupo de [Inviter]?","Party Invite","Aceitar","Recusar","Ignorar")
	if(Choice=="Recusar" || Choice=="Ignorar")
		if(Choice=="Ignorar" && Inviter)	src:PartyIgnores+=Inviter.key
		Inviter<<"[src] Recusou seu convite...";return
	var/FailMsg=""
	if(src.FusionMob || usr.FusionMob)	FailMsg="Se fundir num Grupo está desabilitado!"
	if(src.Party.len)	FailMsg="Já está num Grupo!"
	if(!Inviter)	FailMsg="Quem mandou esse convite já saiu do jogo..."
	else
		if(!Inviter.Party.len)	FailMsg="[Inviter] saiu do Grupo!"
		if(Inviter.Party.len>=global.MaxParty)	FailMsg="Grupo está cheio!"
	if(src.InTournament || Inviter.InTournament)	if(global.TournRegMode=="Parties")
		FailMsg="Involved in Party Tournament"
	if(FailMsg)
		FailMsg="[src] couldn't Join the Party: [FailMsg]"
		Inviter<<FailMsg
		src<<FailMsg
		return
	src.JoinParty(Inviter)

mob/proc/JoinParty(var/mob/Inviter)
	for(var/mob/M in Inviter.Party)
		M.Party+=src
		src.PartyID=M.Party.len
		M.UpdatePartyHUD(src)
		M<<"[src] Entrou no Grupo! (Convidado por [Inviter])"
	src.Party+=Inviter.Party
	for(var/mob/M in src.Party)	src.UpdatePartyHUD(M)
	if(global.TournRegMode=="Parties" && global.TournStatus!="Idle")
		for(var/mob/M in src.Party-src)	if(M in global.TournEntrants)
			src.Resign("Duplicate Party");break
	src.JoinMissionCheck()

mob/proc/JoinMissionCheck()
	if(src.JoinClanWarsCheck())	return
	if(src.Party && src.Party.len)
		for(var/mob/M in src.Party-src)
			if(M.CurrentCP && M.CurrentMission)
				src<<"Seu grupo está numa missão!"
				src.JoinMission(M.CurrentCP,M.CurrentMission)
				return 1

mob/proc/DismissNPCs()
	for(var/mob/M in src.Party)	if(M.Owner==src)	M.DismissNPC()

mob/proc/LeaveParty()
	src.DismissNPCs()
	if(global.TournRegMode=="Parties")	src.QuitTournament("Left Party")
	var/list/AllMembers=list()
	AllMembers+=src.Party
	for(var/mob/M in src.Party)
		M.Party-=src
		if(M.Party.len<=1)	M.Party=list()
		else	M.PartyID=M.Party.Find(M)
		M<<"[src] saiu do Grupo!"
	src.Party=list()
	for(var/mob/M in AllMembers)
		for(var/mob/M2 in AllMembers)	if(M in M2.Party)	M2.UpdatePartyHUD(M)
		M.ClearPartyHUD()
	if(src.CurrentCP && src.CurrentMission)	src.ExitCP()