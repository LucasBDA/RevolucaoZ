mob/var
	DuelOutID
	mob/Dueling
	list/DuelIgnores
	list/DuelRequests
	obj/Supplemental/DuelFlag/DuelFlag

obj/Supplemental/DuelFlag
	density=0
	var/DuelType="Balanced"
	icon='Other.dmi';icon_state="DuelFlag"
	DuelType="Standard"
	icon='Other.dmi';icon_state="DuelFlag"

mob/proc/DuelRangeCheck()
	if(src.DuelFlag)
		if((abs(src.x-src.DuelFlag.x>13) || abs(src.y-src.DuelFlag.y>8)))	if(!src.DuelOutID)	spawn()	src.DuelRangeCount(src.DuelFlag)
		else	src.DuelOutID=0

mob/proc/DuelRangeCount(var/obj/ThisDuelFlag)
	src<<"<b><font color=red>Você saiu da Área do Duelo!"
	src<<"<b><font color=red>Você tem 10 segundos para retornar a Área de Duelo!"
	var/ThisID=rand(1,999999)
	src.DuelOutID=ThisID
	sleep(100);if(!ThisDuelFlag || src.DuelOutID!=ThisID)	return
	if((abs(src.x-DuelFlag.x>13) || abs(src.y-DuelFlag.y>8)))
		src.TrackStat("[src.DuelFlag.DuelType] Duels Fled",1)
		src.Dueling.TrackStat("[src.DuelFlag.DuelType] Duels Canceled",1)
		src<<"Duelo cancelado; Você saiu da Área de Duelo!"
		src.Dueling<<"Duelo cancelado; [src] saiu da Área de Duelo!"
		src.EndDuel()

mob/proc/EndDuel()
	if(src.Dueling)	src.Dueling.Dueling=null
	if(src.DuelFlag)	del src.DuelFlag
	src.Dueling=null

mob/verb/Duel()
	set category=null
	set src in world
	for(var/mob/Player/P in AmtP)
		if(P==usr)
			usr<<"<b>Acesso Negado! Você está participando ou está registrado em outro Evento"
			usr<<sound('No.ogg')
			return
	var/DuelType=alert("Selecione o tipo de Duelo","Duelo","Balanced","Standard")
	if(src.FusionMob)	{usr<<"[src] has Fused!";return}
	if(!src.ControlClients)	{usr<<"Você não pode duelar NPC's!";return}
	if(src.IgnoreDuels)	{usr<<"[src] está ignorando convites de duelos.";return}
	if(usr.Dueling)	{usr<<"Você já está duelando com [usr.Dueling]";return}
	if(src.Dueling)	{usr<<"[src] está duelando com [src.Dueling]";return}
	if(usr in src.DuelRequests)	{usr<<"Você já enviou um convite de duelo para [src]!";return}
	if(usr.key in src.DuelIgnores)	{usr<<"[src] está ignorando seus convites de duelo!";return}
	usr<<"Convite de duelo para [src]"
	if(!src.DuelRequests)	src.DuelRequests=list()
	src.DuelRequests+=usr
	src.PopupHUD(new/obj/HUD/Popups/Duel_Request(usr,DuelType),"[DuelType] Convite de [usr]")

mob/proc/AcceptDuel(var/mob/M,var/DuelType)
	var/Choice=alert(src,"[M] Desafiou você para um Duelo do tipo: [DuelType]!","Duelo","Aceitar","Recusar","Ignorar")
	src=src.GetFusionMob()
	src.DuelRequests-=M;if(!M)	{src<<"O desafiador saiu do jogo!";return}
	M=M.GetFusionMob()
	if(Choice!="Aceitar")
		M<<"[src] Recusou seu convite!"
		return
		if(Choice=="Ignorar")
			if(!src.DuelIgnores)	src.DuelIgnores=list()
			src.DuelIgnores+=M.key
	if(M==src)	{src<<"Você não pode duelar consigo mesmo!";return}
	if(M.Dueling || src.Dueling)	{src<<"Já está duelando!";return}
	if((abs(src.x-M.x>12) || abs(src.y-M.y>7)))	{M<<"[src] está muito longe!";src<<"[M] está muito longe!";return}
	if(M.InTournament || src.InTournament)	{src<<"Não pode duelar enquanto estiver num Torneio de Artes Marciais!";return}
	M<<"[src] aceitou seu convite!"
	M.Dueling=src;src.Dueling=M
	M.DuelOutID=0;src.DuelOutID=0
	var/obj/Supplemental/DuelFlag/D=new(M.loc)
	D.DuelType=DuelType
	D.icon_state="[DuelType]DuelFlag"
	M.DuelFlag=D;src.DuelFlag=D
	D.name="[M] vs [src]";D.AddName()