mob/var/tmp
	list/ControlClients
	mob/Player/Fusion/FusionMob

mob/proc/GetFusionMob(/**/)
	if(src.FusionMob)	return src.FusionMob
	else	return src

mob/Player/Fusion
	New()
		while(istext(src.Character))
			for(var/obj/FusionCharacters/M in AllFusionCharacters)
				if(M.name==src.Character)	{src.Character=M;src.icon=src.Character.icon;break}
		return ..()
	Gogeta
		Character="Gogeta"
	GogetaSS4
		Character="GogetaSS4"
	GogetaSSBlue
		Character="GogetaSSBlue"
	Vegito
		Character="Vegito"
	Vegito2
		Character="Vegito DBS"
	Gotenks
		Character="Gotenks"
	ZamasuGattai
		Character="ZamasuGattai"
var/Time=0
mob/proc/EndFusion()
//	src.FusionMob.ExitCP()
	src.FusionMob.ClearHUDPopups()
	src.FusionMob.ForceCancelTraining()
	if(src.FusionMob.CurrentMission)
		src.FusionMob.ExitCP()
	if(src.FusionMob.Dueling)
		if(src.FusionMob.DuelFlag)
			src.FusionMob.TrackStat("[src.FusionMob.DuelFlag.DuelType] Duels DeFused",1)
			src.FusionMob.Dueling.TrackStat("[src.FusionMob.DuelFlag.DuelType] Duels DeFuse Canceled",1)
		src.FusionMob<<"Duel Canceled; You DeFused!"
		src.FusionMob.Dueling<<"Duel Canceled; [src.FusionMob] DeFused!"
		src.FusionMob.EndDuel()
	for(var/client/C in src.FusionMob.ControlClients)
		C.mob.density=src.FusionMob.density
		C.mob.name=C.mob.NomeReserva
		C.mob.loc=src.FusionMob.loc
		if(C.mob.icon=='BlackGokuRose.dmi')
			C.mob.pixel_x-=16
		if(C.eye==src.FusionMob)	C.eye=C.mob
		C.mob.InstanceLoc=src.FusionMob.InstanceLoc
		C.mob.InstanceObj=src.FusionMob.InstanceObj
		C.mob.PreInstanceLoc=src.FusionMob.PreInstanceLoc
		C.mob.invisibility=0;C.mob.ResetIS()
		C.mob.UpdateKiHUD();C.mob.UpdatePlHUD();C.mob.UpdateFaceHUD()
		C.mob.ClearTournamentRing()
		C.mob.DamageMultiplier=1
	src.FusionMob.Resign("DeFused")
	del src.FusionMob


mob/verb/Toggle_Fusions()
	set hidden=1
	src.IgnoreFusions=!src.IgnoreFusions
	if(src.IgnoreFusions)	src<<"Agora você está ignorando todo o pedido de fusão"
	else	src<<"Agora você está aceitando todo o pedido de fusão"

mob/var/IgnoreFusions
mob/var/list/FusionInvites
mob/var/tmp/list/FusionIgnores

/*
mob/Player/verb/Fusion()
//	set hidden=1
	set category=null
	set src in view()
	if(usr.FusionMob)	{usr<<"Você já está fundido";return}
	if(src.IgnoreFusions)	{usr<<"[src] está ignorando todos os convites de fusão";return}
	if(src.key!="Hiukai")	if(usr==src)	{usr<<"Você não pode se fundir com você mesmo!";return}
	var/obj/FusionCharacters/C=list(AllFusionCharacters)
	if(src.Character.name!=C.name in AllFusionCharacters || usr.Character.name!=C.name in AllFusionCharacters )	{usr<<"Você não pode se fundir com esse personagem!";return}
	if(src.FusionMob || src.ControlClients.len>=2)	{usr<<"[src] já está fundido";return}
	if(usr in src.FusionInvites)	{usr<<"Você já enviou a [src] um pedido de fusão";return}
	if(usr.key in src.FusionIgnores)	{usr<<"[src] está ignorando seu pedido de fusão";return}
	usr<<"Pedido enviado à [src]"
	if(!src.FusionInvites)	src.FusionInvites=list()
	src.FusionInvites+=usr
	src.PopupHUD(new/obj/HUD/Popups/Fusion_Request(usr),"Pedido de fusão de [usr]")


mob/proc/AcceptFusionRequest(var/mob/Player/M)
	var/Choice=alert("Pedido de fusão de [M]","Convite","Aceitar","Aceitar Potara","Recusar","Ignorar")
	src.FusionInvites-=M
	if(!M)	{src<<"Jogador saiu...";return}
	if(Choice=="Recusar" || Choice=="Ignore")
		if(Choice=="Ignorar")
			if(!src.FusionIgnores)	src.FusionIgnores=list()
			src.FusionIgnores+=M.key
		M<<"[src] Recusou seu pedido";return
	if(M.icon_state=="GenkiDamaCharge" || src.icon_state=="GenkiDamaCharge")
		src<<"Um dos jogadores está realizando uma Genki-Dama ou Death Ball no momento!"
		return
	if(src.IsUltra==1 || M.IsUltra==1)	return
	if(M.Breaker==1 || src.Breaker==1)	return
	for(var/mob/Player/P in AmtP)
		if(P==src || P==M)
			src<<"<b>Acesso Negado! Você ou [M] está participando ou está registrado em outro Evento"
			src<<sound('No.ogg')
			return
	if(M.FusionMob)	{M<<"Você já está fundido";return}
	if(MyGetDist(M,src)>world.view)	{src<<"O jogador está muito distante";return}
	if(src.FusionMob || src.ControlClients.len>=2)	{M<<"[src] já está numa fusão!";return}
//	src.ExitCP();M.ExitCP()
	var/NewType=/mob/Player/Fusion/Gogeta	//Defaults to Gogeta
	if(src.FusionTime==1 || M.FusionTime==1)
		src<<"Aguarde o tempo necessário para voltar a se fundir!"
		M<<"Aguarde o tempo necessário para voltar a se fundir!"
		return
	if(Choice=="Aceitar Potara")
		if(src.Skill21!=1 || M.Skill21!=1)
			src<<"<b> Pelo menos um dos jogadores não possui a técnica da fusão."
			M<<"<b> Pelo menos um dos jogadores não possui a técnica da fusão."
			return
		if(src.icon=='GokuSuper.dmi' && M.icon=='SAVegeta1.dmi')
			src.loc=M.loc
			src.x-=1
			src.icon_state="Potara"
			M.icon_state="Potara"
			src.NomeReserva=src.name
			M.NomeReserva=M.name
			var/lead = copytext(src.name,1,3)
			var/load = copytext(M.name,4)
			M.name = "[lead][load]"
			src.name = "[lead][load]"
			PlaySound(view(),'Alright.ogg')
			sleep(25)
			PlaySound(view(),'EnergyStart.ogg')
			NewType=/mob/Player/Fusion/Vegito2
			var/mob/Player/Fusion/F=new NewType(src.loc)
			F.name="[AtName(M.name)]"
			F.SetupOverlays()
			F.ClearTournamentRing()
			F.InstanceLoc=src.InstanceLoc
			F.InstanceObj=src.InstanceObj
			F.PreInstanceLoc=src.PreInstanceLoc
			F.ControlClients=list(src.client,M.client)
			var/list/Stats2Match=list("MaxPL","MaxKi","Str","Def")
			for(var/client/C in F.ControlClients)
				C.mob.Resign("Fused")
				C.mob.density=0;C.mob.invisibility=101
				C.mob.LeaveParty();C.mob.ForceCancelTraining()
				C.mob.GiveMedal(new/obj/Medals/SplitPersonality)
				C.mob.CancelMovement();C.mob.SmartFollow(F)
				C.mob.ClearHUDPopups()
				C.mob.FusionMob=F;C.eye=F
				F.UpdateKiHUD();F.UpdatePlHUD();F.UpdateFaceHUD()
				for(var/v in Stats2Match)	Stats2Match[v]+=C.mob.vars[v]*5
			for(var/v in Stats2Match)	F.vars[v]=round(Stats2Match[v]/5)
			F.PL=F.MaxPL;F.Ki=F.MaxKi
			F.DamageMultiplier+=0.5
			F.AddWAura()
			F.icon_state="Alright"
			sleep(20)
			F.DeleteWAura()
			F.icon_state=""
			spawn(-1)	F.GuardRecharge()
			sleep(3200)
			M.EndFusion()
			PlaySound(view(),'FusionEnd.ogg')
			sleep(1)
			src.EndFusion()
			src.FusionTime=1
			M.FusionTime=1
			sleep(2000)
			M.FusionTime=0
			src.FusionTime=0
		if(M.icon=='GokuSuper.dmi' && src.icon=='SAVegeta1.dmi')
			src.loc=M.loc
			src.x+=1
			src.icon_state="Potara"
			M.icon_state="Potara"
			PlaySound(view(),'Alright.ogg')
			sleep(25)
			PlaySound(view(),'EnergyStart.ogg')
			src.NomeReserva=src.name
			M.NomeReserva=M.name
			var/lead = copytext(M.name,1,3)
			var/load = copytext(src.name,4)
			M.name = "[lead][load]"
			src.name = "[lead][load]"
			NewType=/mob/Player/Fusion/Vegito2
			var/mob/Player/Fusion/F=new NewType(src.loc)
			F.name="[AtName(M.name)]"
			F.SetupOverlays()
			F.ClearTournamentRing()
			F.InstanceLoc=src.InstanceLoc
			F.InstanceObj=src.InstanceObj
			F.PreInstanceLoc=src.PreInstanceLoc
			F.ControlClients=list(src.client,M.client)
			var/list/Stats2Match=list("MaxPL","MaxKi","Str","Def")
			for(var/client/C in F.ControlClients)
				C.mob.Resign("Fused")
				C.mob.density=0;C.mob.invisibility=101
				C.mob.LeaveParty();C.mob.ForceCancelTraining()
				C.mob.GiveMedal(new/obj/Medals/SplitPersonality)
				C.mob.CancelMovement();C.mob.SmartFollow(F)
				C.mob.ClearHUDPopups()
				C.mob.FusionMob=F;C.eye=F
				F.UpdateKiHUD();F.UpdatePlHUD();F.UpdateFaceHUD()
				for(var/v in Stats2Match)	Stats2Match[v]+=C.mob.vars[v]*5
			for(var/v in Stats2Match)	F.vars[v]=round(Stats2Match[v]/5)
			F.PL=F.MaxPL;F.Ki=F.MaxKi
			F.DamageMultiplier+=0.5
			F.AddWAura()
			F.icon_state="Alright"
			sleep(20)
			F.DeleteWAura()
			F.icon_state=""
			spawn(-1)	F.GuardRecharge()
			sleep(3200)
			M.EndFusion()
			PlaySound(view(),'FusionEnd.ogg')
			sleep(1)
			src.EndFusion()
			src.FusionTime=1
			M.FusionTime=1
			sleep(2000)
			M.FusionTime=0
			src.FusionTime=0
		if(src.icon=='BlackGokuRose.dmi' && M.Character.name=="Zamasu")
			src.loc=M.loc
			src.x-=1
			src.NomeReserva=src.name
			M.NomeReserva=M.name
			src.icon_state="Fusion0"
			M.icon_state="Fusion0"
			world<<sound('Zamasu.ogg')
			world<<"<b><i>[src] e [M] <font color=[rgb(213,13,183)]>estão se fundindo permanentemente!"
			src.ZamasuGattai=1
			M.ZamasuGattai=1
			sleep(160)
			src.icon_state="Fusion"
			M.icon_state="Fusion"
			sleep(30)
			src.icon_state="Fusion1"
			M.icon_state="Fusion1"
			src.pixel_x+=16
			var/lead = copytext(src.name,1,3)
			var/load = copytext(M.name,4)
			M.name = "[lead][load]"
			src.name = "[lead][load]"
			sleep(110)
			NewType=/mob/Player/Fusion/ZamasuGattai
			var/mob/Player/Fusion/F=new NewType(src.loc)
			F.name="[AtName(M.name)]"
			F.SetupOverlays()
			F.ClearTournamentRing()
			F.InstanceLoc=src.InstanceLoc
			F.InstanceObj=src.InstanceObj
			F.PreInstanceLoc=src.PreInstanceLoc
			F.ControlClients=list(src.client,M.client)
			var/list/Stats2Match=list("MaxPL","MaxKi","Str","Def")
			for(var/client/C in F.ControlClients)
				C.mob.Resign("Fused")
				C.mob.density=0;C.mob.invisibility=101
				C.mob.LeaveParty();C.mob.ForceCancelTraining()
				C.mob.GiveMedal(new/obj/Medals/SplitPersonality)
				C.mob.GiveMedal(new/obj/Medals/Supreme_God)
				C.mob.CancelMovement();C.mob.SmartFollow(F)
				C.mob.ClearHUDPopups()
				C.mob.FusionMob=F;C.eye=F
				F.UpdateKiHUD();F.UpdatePlHUD();F.UpdateFaceHUD()
				for(var/v in Stats2Match)	Stats2Match[v]+=C.mob.vars[v]*5
			for(var/v in Stats2Match)	F.vars[v]=round(Stats2Match[v]/5)
			F.PL=F.MaxPL;F.Ki=F.MaxKi
			F.DamageMultiplier=2.3
			F.AddWAura()
			F.icon_state="Fusion"
			sleep(280)
			F.icon_state=""
			F.DeleteWAura()
			for(var/client/K in F.ControlClients)
				K.mob.ZamasuGattai=0
			F.ZamasuGattai=0
			spawn(-1)	F.GuardRecharge()
		if(M.icon=='BlackGokuRose.dmi' && src.Character.name=="Zamasu")
			src.loc=M.loc
			src.x+=1
			src.NomeReserva=src.name
			M.NomeReserva=M.name
			src.icon_state="Fusion0"
			M.icon_state="Fusion0"
			world<<sound('Zamasu.ogg')
			world<<"<b><i>[src] e [M] <font color=[rgb(213,13,183)]>estão se fundindo permanentemente!"
			src.ZamasuGattai=1
			M.ZamasuGattai=1
			sleep(160)
			src.icon_state="Fusion"
			M.icon_state="Fusion"
			sleep(30)
			M.icon_state="Fusion1"
			src.icon_state="Fusion1"
			M.pixel_x+=16
			var/lead = copytext(M.name,1,3)
			var/load = copytext(src.name,4)
			M.name = "[lead][load]"
			src.name = "[lead][load]"
			sleep(110)
			NewType=/mob/Player/Fusion/ZamasuGattai
			var/mob/Player/Fusion/F=new NewType(src.loc)
			F.name="[AtName(M.name)]"
			F.SetupOverlays()
			F.ClearTournamentRing()
			F.InstanceLoc=src.InstanceLoc
			F.InstanceObj=src.InstanceObj
			F.PreInstanceLoc=src.PreInstanceLoc
			F.ControlClients=list(src.client,M.client)
			var/list/Stats2Match=list("MaxPL","MaxKi","Str","Def")
			for(var/client/C in F.ControlClients)
				C.mob.Resign("Fused")
				C.mob.density=0;C.mob.invisibility=101
				C.mob.LeaveParty();C.mob.ForceCancelTraining()
				C.mob.GiveMedal(new/obj/Medals/SplitPersonality)
				C.mob.GiveMedal(new/obj/Medals/Supreme_God)
				C.mob.CancelMovement();C.mob.SmartFollow(F)
				C.mob.ClearHUDPopups()
				C.mob.FusionMob=F;C.eye=F
				F.UpdateKiHUD();F.UpdatePlHUD();F.UpdateFaceHUD()
				for(var/v in Stats2Match)	Stats2Match[v]+=C.mob.vars[v]*5
			for(var/v in Stats2Match)	F.vars[v]=round(Stats2Match[v]/5)
			F.PL=F.MaxPL;F.Ki=F.MaxKi
			F.DamageMultiplier=2.3
			F.AddWAura()
			F.icon_state="Fusion"
			sleep(280)
			F.icon_state=""
			F.DeleteWAura()
			for(var/client/K in F.ControlClients)
				K.mob.ZamasuGattai=0
			F.ZamasuGattai=0
			spawn(-1)	F.GuardRecharge()
		if(src.Character.name=="Goku2" && M.Character.name=="Vegeta2")
			src.loc=M.loc
			src.x-=1
			src.icon_state="Potara"
			M.icon_state="Potara"
			PlaySound(view(),'Alright.ogg')
			sleep(25)
			src.NomeReserva=src.name
			M.NomeReserva=M.name
			var/lead = copytext(src.name,1,3)
			var/load = copytext(M.name,4)
			M.name = "[lead][load]"
			src.name = "[lead][load]"
			PlaySound(view(),'EnergyStart.ogg')
			NewType=/mob/Player/Fusion/Vegito
			var/mob/Player/Fusion/F=new NewType(src.loc)
			F.name="[AtName(M.name)]"
			F.SetupOverlays()
			F.ClearTournamentRing()
			F.InstanceLoc=src.InstanceLoc
			F.InstanceObj=src.InstanceObj
			F.PreInstanceLoc=src.PreInstanceLoc
			F.ControlClients=list(src.client,M.client)
			var/list/Stats2Match=list("MaxPL","MaxKi","Str","Def")
			for(var/client/C in F.ControlClients)
				C.mob.Resign("Fused")
				C.mob.density=0;C.mob.invisibility=101
				C.mob.LeaveParty();C.mob.ForceCancelTraining()
				C.mob.GiveMedal(new/obj/Medals/SplitPersonality)
				C.mob.CancelMovement();C.mob.SmartFollow(F)
				C.mob.ClearHUDPopups()
				C.mob.FusionMob=F;C.eye=F
				F.UpdateKiHUD();F.UpdatePlHUD();F.UpdateFaceHUD()
				for(var/v in Stats2Match)	Stats2Match[v]+=C.mob.vars[v]*5
			for(var/v in Stats2Match)	F.vars[v]=round(Stats2Match[v]/5)
			F.PL=F.MaxPL;F.Ki=F.MaxKi
			F.DamageMultiplier+=0.3
			F.AddWAura()
			F.icon_state="Alright"
			sleep(20)
			F.DeleteWAura()
			F.icon_state=""
			spawn(-1)	F.GuardRecharge()
			sleep(3200)
			M.EndFusion()
			PlaySound(view(),'FusionEnd.ogg')
			sleep(1)
			src.EndFusion()
			src.FusionTime=1
			M.FusionTime=1
			sleep(2000)
			M.FusionTime=0
			src.FusionTime=0
		if(M.Character.name=="Goku2" && src.Character.name=="Vegeta2")
			src.loc=M.loc
			src.x+=1
			src.icon_state="Potara"
			M.icon_state="Potara"
			PlaySound(view(),'Alright.ogg')
			sleep(25)
			src.NomeReserva=src.name
			M.NomeReserva=M.name
			var/lead = copytext(M.name,1,3)
			var/load = copytext(src.name,4)
			M.name = "[lead][load]"
			src.name = "[lead][load]"
			PlaySound(view(),'EnergyStart.ogg')
			NewType=/mob/Player/Fusion/Vegito
			var/mob/Player/Fusion/F=new NewType(src.loc)
			F.name="[AtName(M.name)]"
			F.SetupOverlays()
			F.ClearTournamentRing()
			F.InstanceLoc=src.InstanceLoc
			F.InstanceObj=src.InstanceObj
			F.PreInstanceLoc=src.PreInstanceLoc
			F.ControlClients=list(src.client,M.client)
			var/list/Stats2Match=list("MaxPL","MaxKi","Str","Def")
			for(var/client/C in F.ControlClients)
				C.mob.Resign("Fused")
				C.mob.density=0;C.mob.invisibility=101
				C.mob.LeaveParty();C.mob.ForceCancelTraining()
				C.mob.GiveMedal(new/obj/Medals/SplitPersonality)
				C.mob.CancelMovement();C.mob.SmartFollow(F)
				C.mob.ClearHUDPopups()
				C.mob.FusionMob=F;C.eye=F
				F.UpdateKiHUD();F.UpdatePlHUD();F.UpdateFaceHUD()
				for(var/v in Stats2Match)	Stats2Match[v]+=C.mob.vars[v]*5
			for(var/v in Stats2Match)	F.vars[v]=round(Stats2Match[v]/5)
			F.PL=F.MaxPL;F.Ki=F.MaxKi
			F.DamageMultiplier+=0.3
			F.AddWAura()
			F.icon_state="Alright"
			sleep(20)
			F.DeleteWAura()
			F.icon_state=""
			spawn(-1)	F.GuardRecharge()
			sleep(3200)
			M.EndFusion()
			PlaySound(view(),'FusionEnd.ogg')
			sleep(1)
			src.EndFusion()
			src.FusionTime=1
			M.FusionTime=1
			sleep(2000)
			M.FusionTime=0
			src.FusionTime=0
		return
	if(src.Character.name=="Goku2" && M.Character.name=="Vegeta2")
		if(src.Skill20!=1 || M.Skill20!=1)
			src<<"<b> Pelo menos um dos jogadores não possui a técnica da fusão."
			M<<"<b> Pelo menos um dos jogadores não possui a técnica da fusão."
			return
		src.loc=M.loc
		src.x-=1
		src.icon_state="Fusion"
		M.icon_state="Fusion"
		PlaySound(view(),'FusionGV.ogg')
		sleep(25)
		src.NomeReserva=src.name
		M.NomeReserva=M.name
		var/lead = copytext(src.name,1,3)
		var/load = copytext(M.name,4)
		M.name = "[lead][load]"
		src.name = "[lead][load]"
		PlaySound(view(),'EnergyStart.ogg')
		NewType=/mob/Player/Fusion/Gogeta
		var/mob/Player/Fusion/F=new NewType(src.loc)
		F.name="[AtName(M.name)]"
		F.SetupOverlays()
		F.ClearTournamentRing()
		F.InstanceLoc=src.InstanceLoc
		F.InstanceObj=src.InstanceObj
		F.PreInstanceLoc=src.PreInstanceLoc
		F.ControlClients=list(src.client,M.client)
		var/list/Stats2Match=list("MaxPL","MaxKi","Str","Def")
		for(var/client/C in F.ControlClients)
			C.mob.Resign("Fused")
			C.mob.density=0;C.mob.invisibility=101
			C.mob.LeaveParty();C.mob.ForceCancelTraining()
			C.mob.GiveMedal(new/obj/Medals/SplitPersonality)
			C.mob.CancelMovement();C.mob.SmartFollow(F)
			C.mob.ClearHUDPopups()
			C.mob.FusionMob=F;C.eye=F
			F.UpdateKiHUD();F.UpdatePlHUD();F.UpdateFaceHUD()
			for(var/v in Stats2Match)	Stats2Match[v]+=C.mob.vars[v]*5
		for(var/v in Stats2Match)	F.vars[v]=round(Stats2Match[v]/5)
		F.PL=F.MaxPL;F.Ki=F.MaxKi
		F.DamageMultiplier+=0.3
		F.AddWAura()
		sleep(20)
		F.DeleteWAura()
		PlaySound(view(),'Gogeta.ogg')
		spawn(-1)	F.GuardRecharge()
		sleep(3200)
		M.EndFusion()
		PlaySound(view(),'FusionEnd.ogg')
		sleep(1)
		src.EndFusion()
		src.FusionTime=1
		M.FusionTime=1
		sleep(2000)
		M.FusionTime=0
		src.FusionTime=0
	else
		if(src.Character.name=="Goten" && M.Character.name=="Kid Trunks")
			if(src.Skill20!=1 || M.Skill20!=1)
				src<<"<b> Pelo menos um dos jogadores não possui a técnica da fusão."
				M<<"<b> Pelo menos um dos jogadores não possui a técnica da fusão."
				return
			src.loc=M.loc
			src.x-=1
			src.icon_state="Fusion"
			M.icon_state="Fusion"
			PlaySound(view(),'FusionGT.ogg')
			sleep(30)
			src.NomeReserva=src.name
			M.NomeReserva=M.name
			var/lead = copytext(M.name,1,3)
			var/load = copytext(src.name,4)
			M.name = "[lead][load]"
			src.name = "[lead][load]"
			PlaySound(view(),'EnergyStart.ogg')
			PlaySound(view(),'Gotenks.ogg')
			NewType=/mob/Player/Fusion/Gotenks
			var/mob/Player/Fusion/F=new NewType(src.loc)
			F.name="[AtName(M.name)]"
			F.SetupOverlays()
			F.ClearTournamentRing()
			F.InstanceLoc=src.InstanceLoc
			F.InstanceObj=src.InstanceObj
			F.PreInstanceLoc=src.PreInstanceLoc
			F.ControlClients=list(src.client,M.client)
			var/list/Stats2Match=list("MaxPL","MaxKi","Str","Def")
			for(var/client/C in F.ControlClients)
				C.mob.Resign("Fused")
				C.mob.density=0;C.mob.invisibility=101
				C.mob.LeaveParty();C.mob.ForceCancelTraining()
				C.mob.GiveMedal(new/obj/Medals/SplitPersonality)
				C.mob.CancelMovement();C.mob.SmartFollow(F)
				C.mob.ClearHUDPopups()
				C.mob.FusionMob=F;C.eye=F
				F.UpdateKiHUD();F.UpdatePlHUD();F.UpdateFaceHUD()
				for(var/v in Stats2Match)	Stats2Match[v]+=C.mob.vars[v]*5
			for(var/v in Stats2Match)	F.vars[v]=round(Stats2Match[v]/5)
			F.PL=F.MaxPL;F.Ki=F.MaxKi
			F.DamageMultiplier+=0.1
			F.AddWAura()
			sleep(20)
			F.DeleteWAura()
			spawn(-1)	F.GuardRecharge()
			sleep(3200)
			M.EndFusion()
			PlaySound(view(),'FusionGTEnds.ogg')
			sleep(1)
			src.EndFusion()
			src.FusionTime=1
			M.FusionTime=1
			sleep(2000)
			M.FusionTime=0
			src.FusionTime=0
		if(M.Character.name=="Goten" && src.Character.name=="Kid Trunks")
			if(src.Skill20!=1 || M.Skill20!=1)
				src<<"<b> Pelo menos um dos jogadores não possui a técnica da fusão."
				M<<"<b> Pelo menos um dos jogadores não possui a técnica da fusão."
				return
			src.loc=M.loc
			src.x+=1
			src.icon_state="Fusion"
			M.icon_state="Fusion"
			PlaySound(view(),'FusionGT.ogg')
			sleep(30)
			src.NomeReserva=src.name
			M.NomeReserva=M.name
			var/lead = copytext(M.name,1,3)
			var/load = copytext(src.name,4)
			M.name = "[lead][load]"
			src.name = "[lead][load]"
			PlaySound(view(),'EnergyStart.ogg')
			PlaySound(view(),'Gotenks.ogg')
			NewType=/mob/Player/Fusion/Gotenks
			var/mob/Player/Fusion/F=new NewType(src.loc)
			F.name="[AtName(M.name)]"
			F.SetupOverlays()
			F.ClearTournamentRing()
			F.InstanceLoc=src.InstanceLoc
			F.InstanceObj=src.InstanceObj
			F.PreInstanceLoc=src.PreInstanceLoc
			F.ControlClients=list(src.client,M.client)
			var/list/Stats2Match=list("MaxPL","MaxKi","Str","Def")
			for(var/client/C in F.ControlClients)
				C.mob.Resign("Fused")
				C.mob.density=0;C.mob.invisibility=101
				C.mob.LeaveParty();C.mob.ForceCancelTraining()
				C.mob.GiveMedal(new/obj/Medals/SplitPersonality)
				C.mob.CancelMovement();C.mob.SmartFollow(F)
				C.mob.ClearHUDPopups()
				C.mob.FusionMob=F;C.eye=F
				F.UpdateKiHUD();F.UpdatePlHUD();F.UpdateFaceHUD()
				for(var/v in Stats2Match)	Stats2Match[v]+=C.mob.vars[v]*5
			for(var/v in Stats2Match)	F.vars[v]=round(Stats2Match[v]/5)
			F.PL=F.MaxPL;F.Ki=F.MaxKi
			F.DamageMultiplier+=0.1
			F.AddWAura()
			sleep(20)
			F.DeleteWAura()
			spawn(-1)	F.GuardRecharge()
			sleep(3200)
			M.EndFusion()
			PlaySound(view(),'FusionGTEnds.ogg')
			sleep(1)
			src.EndFusion()
			src.FusionTime=1
			M.FusionTime=1
			sleep(2000)
			M.FusionTime=0
			src.FusionTime=0
		if(M.Character.name=="Goku2" && src.Character.name=="Vegeta2")
			if(src.Skill20!=1 || M.Skill20!=1)
				src<<"<b> Pelo menos um dos jogadores não possui a técnica da fusão."
				M<<"<b> Pelo menos um dos jogadores não possui a técnica da fusão."
				return
			src.loc=M.loc
			src.x+=1
			src.icon_state="Fusion"
			M.icon_state="Fusion"
			PlaySound(view(),'FusionGV.ogg')
			sleep(25)
			src.NomeReserva=src.name
			M.NomeReserva=M.name
			var/lead = copytext(src.name,1,3)
			var/load = copytext(M.name,4)
			M.name = "[lead][load]"
			src.name = "[lead][load]"
			PlaySound(view(),'EnergyStart.ogg')
			NewType=/mob/Player/Fusion/Gogeta
			var/mob/Player/Fusion/F=new NewType(src.loc)
			F.name="[AtName(M.name)]"
			F.SetupOverlays()
			F.ClearTournamentRing()
			F.InstanceLoc=src.InstanceLoc
			F.InstanceObj=src.InstanceObj
			F.PreInstanceLoc=src.PreInstanceLoc
			F.ControlClients=list(src.client,M.client)
			var/list/Stats2Match=list("MaxPL","MaxKi","Str","Def")
			for(var/client/C in F.ControlClients)
				C.mob.Resign("Fused")
				C.mob.density=0;C.mob.invisibility=101
				C.mob.LeaveParty();C.mob.ForceCancelTraining()
				C.mob.GiveMedal(new/obj/Medals/SplitPersonality)
				C.mob.CancelMovement();C.mob.SmartFollow(F)
				C.mob.ClearHUDPopups()
				C.mob.FusionMob=F;C.eye=F
				F.UpdateKiHUD();F.UpdatePlHUD();F.UpdateFaceHUD()
				for(var/v in Stats2Match)	Stats2Match[v]+=C.mob.vars[v]*5
			for(var/v in Stats2Match)	F.vars[v]=round(Stats2Match[v]/5)
			F.PL=F.MaxPL;F.Ki=F.MaxKi
			F.DamageMultiplier+=0.3
			F.AddWAura()
			sleep(20)
			F.DeleteWAura()
			PlaySound(view(),'Gogeta.ogg')
			spawn(-1)	F.GuardRecharge()
			sleep(3200)
			M.EndFusion()
			PlaySound(view(),'FusionEnd.ogg')
			sleep(1)
			src.EndFusion()
			src.FusionTime=1
			M.FusionTime=1
			sleep(2000)
			M.FusionTime=0
			src.FusionTime=0
		if(M.icon=='AltGokuSS4.dmi' && src.icon=='VegetaSS4.dmi')
			if(src.Skill20!=1 || M.Skill20!=1)
				src<<"<b> Pelo menos um dos jogadores não possui a técnica da fusão."
				M<<"<b> Pelo menos um dos jogadores não possui a técnica da fusão."
				return
			src.loc=M.loc
			src.x-=1
			src.icon_state="Fusion"
			M.icon_state="Fusion"
			PlaySound(view(),'FusionGV.ogg')
			sleep(25)
			src.NomeReserva=src.name
			M.NomeReserva=M.name
			var/lead = copytext(src.name,1,3)
			var/load = copytext(M.name,4)
			M.name = "[lead][load]"
			src.name = "[lead][load]"
			PlaySound(view(),'EnergyStart.ogg')
			NewType=/mob/Player/Fusion/GogetaSS4
			var/mob/Player/Fusion/F=new NewType(src.loc)
			F.name="[AtName(M.name)]"
			F.SetupOverlays()
			F.ClearTournamentRing()
			F.InstanceLoc=src.InstanceLoc
			F.InstanceObj=src.InstanceObj
			F.PreInstanceLoc=src.PreInstanceLoc
			F.ControlClients=list(src.client,M.client)
			var/list/Stats2Match=list("MaxPL","MaxKi","Str","Def")
			for(var/client/C in F.ControlClients)
				C.mob.Resign("Fused")
				C.mob.density=0;C.mob.invisibility=101
				C.mob.LeaveParty();C.mob.ForceCancelTraining()
				C.mob.GiveMedal(new/obj/Medals/SplitPersonality)
				C.mob.CancelMovement();C.mob.SmartFollow(F)
				C.mob.ClearHUDPopups()
				C.mob.FusionMob=F;C.eye=F
				F.UpdateKiHUD();F.UpdatePlHUD();F.UpdateFaceHUD()
				for(var/v in Stats2Match)	Stats2Match[v]+=C.mob.vars[v]*5
			for(var/v in Stats2Match)	F.vars[v]=round(Stats2Match[v]/5)
			F.PL=F.MaxPL;F.Ki=F.MaxKi
			F.DamageMultiplier+=0.6
			F.AddSSAura()
			sleep(20)
			F.DeleteSSAura()
			PlaySound(view(),'Gogeta.ogg')
			spawn(-1)	F.GuardRecharge()
			sleep(3200)
			M.EndFusion()
			PlaySound(view(),'FusionEnd.ogg')
			sleep(1)
			src.EndFusion()
			src.FusionTime=1
			M.FusionTime=1
			sleep(2000)
			M.FusionTime=0
			src.FusionTime=0
		if(src.icon=='AltGokuSS4.dmi' && M.icon=='VegetaSS4.dmi')
			if(src.Skill20!=1 || M.Skill20!=1)
				src<<"<b> Pelo menos um dos jogadores não possui a técnica da fusão."
				M<<"<b> Pelo menos um dos jogadores não possui a técnica da fusão."
				return
			src.loc=M.loc
			src.x+=1
			src.icon_state="Fusion"
			M.icon_state="Fusion"
			PlaySound(view(),'FusionGV.ogg')
			sleep(20)
			src.NomeReserva=src.name
			M.NomeReserva=M.name
			var/lead = copytext(M.name,1,3)
			var/load = copytext(src.name,4)
			M.name = "[lead][load]"
			src.name = "[lead][load]"
			PlaySound(view(),'EnergyStart.ogg')
			NewType=/mob/Player/Fusion/GogetaSS4
			var/mob/Player/Fusion/F=new NewType(src.loc)
			F.name="[AtName(M.name)]"
			F.SetupOverlays()
			F.ClearTournamentRing()
			F.InstanceLoc=src.InstanceLoc
			F.InstanceObj=src.InstanceObj
			F.PreInstanceLoc=src.PreInstanceLoc
			F.ControlClients=list(src.client,M.client)
			var/list/Stats2Match=list("MaxPL","MaxKi","Str","Def")
			for(var/client/C in F.ControlClients)
				C.mob.Resign("Fused")
				C.mob.density=0;C.mob.invisibility=101
				C.mob.LeaveParty();C.mob.ForceCancelTraining()
				C.mob.GiveMedal(new/obj/Medals/SplitPersonality)
				C.mob.CancelMovement();C.mob.SmartFollow(F)
				C.mob.ClearHUDPopups()
				C.mob.FusionMob=F;C.eye=F
				F.UpdateKiHUD();F.UpdatePlHUD();F.UpdateFaceHUD()
				for(var/v in Stats2Match)	Stats2Match[v]+=C.mob.vars[v]*5
			for(var/v in Stats2Match)	F.vars[v]=round(Stats2Match[v]/5)
			F.PL=F.MaxPL;F.Ki=F.MaxKi
			F.DamageMultiplier+=0.6
			F.AddSSAura()
			sleep(20)
			F.DeleteSSAura()
			PlaySound(view(),'Gogeta.ogg')
			spawn(-1)	F.GuardRecharge()
			sleep(3200)
			M.EndFusion()
			PlaySound(view(),'FusionEnd.ogg')
			sleep(1)
			src.EndFusion()
			src.FusionTime=1
			M.FusionTime=1
			sleep(2000)
			M.FusionTime=0
			src.FusionTime=0
		return



//	if(findtext(usr.Character.name,"Goku") || findtext(usr.Character.name,"Vegeta"))
//	if(findtext(M.Character.name,"Goku") || findtext(M.Character.name,"Vegeta"))	NewType=/mob/Player/Fusion/Vegito ||		PlaySound(view(),'Vegitos Taunt.ogg')
//	if(findtext(M.Character.name,"Goten") || findtext(M.Character.name,"KidTrunks"))	NewType=/mob/Player/Fusion/Gotenks ||		PlaySound(view(),'Super Go Kamekaze Attack.ogg')
*/