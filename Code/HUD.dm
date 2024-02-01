
obj/HUD
	icon='HUD.dmi'
	layer=10
	MouseEntered()
		if(src.desc)
			var/list/SplitList=Split(src.screen_loc,",")
			for(var/v in SplitList)
				var/PreListSize=SplitList.len
				SplitList+=Split(v,":")
				if(SplitList.len==PreListSize+1)	SplitList+=0
			var/X=text2num(SplitList[3]);var/Xoff=text2num(SplitList[4])
			var/Y=text2num(SplitList[5]);var/Yoff=text2num(SplitList[6])
			X=(X+20)*32;Y=(5-Y)*32
			winset(usr,"SmallInfoWindow.NameLabel","text=\"[src.name]\"")
			winset(usr,"SmallInfoWindow.DescLabel","text=\"[src.desc]\"")
			winset(usr,"SmallInfoWindow","pos=[16+X+Xoff],[150+Y-Yoff];is-visible=true")
			winset(usr,"MainWindow.MainMap","focus=true")
	MouseExited()
		if(src.desc)	winset(usr,"SmallInfoWindow","is-visible=false")
	HudBG
		name="HUD do Jogador"
		icon='HudBG.png'
		desc="Informa sua Vida, Ki, KiBlasts e Barra de Defesa"
	HudProtection
		mouse_opacity=0
		layer=30;screen_loc="6:-7,10:-1 to 13,10"
		icon='HudProtection.dmi';icon_state="Color"
		New()
			var/list/RandomIcons=list()
			while(RandomIcons.len<100)
				var/icon/I=initial(src.icon)+rgb(rand(0,256),rand(0,256),rand(0,256))
				if(!(I in RandomIcons))	RandomIcons+=I
			spawn()	while(1)
				src.icon=pick(RandomIcons)
				sleep(10)
	TextBG
		icon='HudBG.dmi'
	FuryBall
		icon='FuryIcon.dmi'
		layer=20
		icon_state="Ball"
//		screen_loc="1:22,18:8"
	FuryIcon
		icon='FuryIcon.dmi'
		name="Barra de Fúria"
		layer=19
		icon_state="Icon"
		screen_loc="1:6,18:8"
		desc="Aumenta conforme você luta"
	SkillTree
		icon='SkillsTab.dmi'
		name="Aba de Habilidades"
		layer=19
		icon_state=""
		desc="Aba onde fica suas habilidades"
	Perfil
		icon='HUD.dmi'
		name="Perfil do Jogador"
		layer=19
		icon_state="Perfil"
		screen_loc="25:-7,10:-105"
		desc="Clique para abrir o seu Perfil"
		Click()
			winset(usr, "PerfilUser", "is-visible=true")
			usr<<output(null,"PerfilUser.output4")
			usr<<output("[usr.PLGeral]","PerfilUser.output4")
			usr<<output(null,"PerfilUser.output5")
			usr<<output("[usr.Zenie]","PerfilUser.output5")
			usr<<output(null,"PerfilUser.output6")
			usr<<output("[usr.x], [usr.y]","PerfilUser.output6")
	Inventory
		icon='HUD.dmi'
		name="Inventário"
		layer=19
		icon_state="Inventario"
		screen_loc="25:-42,10:-105" //35 pixels_x pra esquerda
		desc="Clique para abrir o seu Inventário"
		Click()
			usr.Inventory()


	Config
		icon='HUD.dmi'
		name="Configurações"
		layer=19
		icon_state="Config"
		screen_loc="25:-77,10:-105" //35 pixels_x pra esquerda
		desc="Clique para abrir o menu de Configurações"
		Click()
			winset(usr, "Config", "is-visible=true")
	FuryBar2
		icon='FuryBar.dmi'
		layer=19
		screen_loc="1:54,18:8"
	FuryBar
		icon='FuryBar.dmi'
		layer=19
		screen_loc="1:22,18:8"
	HudBarBG
		icon='HudBarBG.png'
	GuardBar
		layer=11
		mouse_opacity=0
		icon='GuardBar.dmi'
	EnemyGuardBar
		layer=11
		mouse_opacity=0
		icon='EnemyGuardBar.dmi'
	GuardBarBG
		name="Guard Meter"
		icon='GuardBarBG.png'
		desc="Esta barra irá diminuir toda vez que você receber um ataque."
	EnemyGuardBarBG
		icon='EnemyGuardBarBG.png'
	KiBar
		layer=11
		mouse_opacity=0
		icon='KiBar1.dmi'
	PlBar
		layer=11
		mouse_opacity=0
		icon='PlBar1.dmi'
	FaceIcon
		layer=11
		mouse_opacity=0
		icon_state="none"
		screen_loc="1:11,17:-11"
	KiBlastType
		Click()
			if(src.desc)
				usr.SelectKbType(src.icon_state)
		New(var/IS,var/SL)
			src.icon_state="[IS]"
			screen_loc=SL
	SelectedKiBlastType
		layer=11
		mouse_opacity=0
		icon_state="SelectedKB"
		New(var/SL)
			screen_loc=SL
	Level_Up
		icon_state="LevelUp"
		screen_loc="9,1"
		desc="Clique para distribuir seus Pontos de Estatus!"
		MouseEntered()
			src.desc="[initial(src.desc)]\n[FullNum(usr.TraitPoints)] Estatus + [FullNum(usr.PerkPoints)] Perks"
			return ..()
		Click()
			winset(usr,"LevelWindow","pos=100,100;size=640x480")
			usr.DisplayPerks()
	Click2Instance
		var/Instance2
		MouseEntered()
			var/PlayerCount=0
			for(var/obj/TurfType/Instances/I in InstanceDatum.Instances[src.Instance2])
				for(var/mob/M in I.InstancePlayers)	PlayerCount+=1
			src.desc="[initial(src.desc)]\n[PlayerCount] Jogador(es)."
			return ..()
		Click()
/*			if(src.icon_state=="Labirinto")
				if(src.PlayerCount.len==1)
					var/Choice=alert("Há apenas 1 jogador no Evento esperando na fila. Deseja participar?","Evento Labirinto","Sim","Não")
					if(Choice=="Sim")
						usr.ChangeInstance(src.Instance2) */
			if(usr.Traveling==1)
				return
			if(usr.GravityTraining==1)
				usr<<"<b>Desligue a gravidade antes de ir para outra instância!"
				return
			usr.ChangeInstance(src.Instance2)
		Labirinto
			icon_state="Labirinto"
			screen_loc="6:19,17:-8"
			Instance2="Labirinto"
			desc="Evento ~ Labirinto"
		PvP_Arena
			name="Arena Vermelha"
			icon_state="none"
			screen_loc="6:2,100"
			Instance2="PvpArenas"
			desc="Arena PvP baseada em Estatus!"
		Clan_PvP_Arena
			name="Arena Azul"
			icon_state="none"
			screen_loc="6:18,100"
			Instance2="ClanPvpArenas"
			desc="Arena PvP de Clan!"
		Balanced_PvP_Arena
			name="Arena Verde"
			icon_state="none"
			screen_loc="7:2,100"
			Instance2="BalancedPvpArenas"
			desc="Arena PvP Balanceada!"
	Exit_Arena
		name="Sair de Instâncias"
		icon_state="SubHUD"
		screen_loc="11,1"
		desc="Retorna de Arenas PvP e de Missões Paralelas."
		Click()
			usr=usr.GetFusionMob()
			if(!usr.CanAct())	{usr<<"Não pode sair agora...";return}
			if(usr.z==10)	{usr<<"Use o painel do Guerra de Clan para sair";return}
			if(usr.InstanceObj && usr.InstanceObj.PvpType && usr.z!=1)	usr.ExitCP()
			if(usr.CurrentCP)	usr.ExitCP()	//Exit Missions

var/list/KbTypes=list("DeathKB"="2:3,19:7","StunKB"="2:16,19:7","GuardBreakKB"="2:29,19:7","ControlledKB"="2:42,19:7","HomingKB"="2:55,19:7","HealingKB"="2:68,19:7")
var/list/KbDescs=list(\
	"Mortal"="Tira vida. Permite que você mate um oponente.",\
	"Atordoador"="Não tira vida, apenas atordoa o inimigo.",\
	"Esmagador de Defesa"="Não tira vida. Diminui a defesa do inimigo 2x mais rápido.",\
	"Nocauteador"="Tira vida. Deixa o oponente apenas no KO.",\
	"Perseguidor"="Tira vida. Persegue o adversário. Consome 1 barra de Ki.",\
	"Curador"="Consome 10% do Poder de Luta. Permite curar outro jogador.",)

var/list/HudBgList=list()


/*

mob/proc/GenerateSkillTab()			//GERAR ABA DE SKILL
	var/obj/HUD/SkillTree/S=new
	if(*/

mob/proc/GenerateFuryBall()			//GERAR BARRA DE FÚRIA
	var/obj/HUD/FuryBall/F=new
	if(src.Fury==0)
		for(F in src.client.screen)
			src.client.screen-=F
			del F
	if(src.Fury==1)
		src.client.screen+=F
		F.screen_loc="1:18,18:8"
	if(src.Fury==2)
		src.client.screen+=F
		F.screen_loc="1:26,18:8"
	if(src.Fury==3)
		src.client.screen+=F
		F.screen_loc="1:34,18:8"
	if(src.Fury==4)
		src.client.screen+=F
		F.screen_loc="1:42,18:8"
	if(src.Fury==5)
		src.client.screen+=F
		F.screen_loc="1:50,18:8"
	if(src.Fury==6)
		src.client.screen+=F
		F.screen_loc="1:58,18:8"
	if(src.Fury==7)
		src.client.screen+=F
		F.screen_loc="1:66,18:8"
	if(src.Fury==8)
		src.client.screen+=F
		F.screen_loc="1:74,18:8"
proc/GenerateHudBgList()
	var/Width=5;var/HudY=17
	for(var/HudX=1;HudX<=Width;HudX++)
		var/obj/HUD/HudBG/H=new
		H.icon_state="[HudX-1],[HudY-16]";HudBgList+=H
		H.screen_loc="[HudX]:3,[HudY]:90"
		if(HudX>=Width && HudY>=17)	{HudX-=Width;HudY-=1}
	Width=5;HudY=17
	for(var/HudX=1;HudX<=Width;HudX++)
		var/obj/HUD/HudBG/H=new;H.icon='HudBGR.png'
		H.icon_state="[HudX-1],[HudY-16]";HudBgList+=H
		H.desc="";H.screen_loc="[HudX+20]:16,[HudY]:85" //PARTE PRA EDITAR A HUD DO ADVERSÁRIO (+8:+18,)
		if(HudX>=Width && HudY>=17)	{HudX-=Width;HudY-=1}

var/list/HudBarBgList=list()
proc/GenerateHudBarBgList()
	var/StartX=6
	for(var/HudX=StartX;HudX<=StartX+6;HudX++)
		var/obj/HUD/HudBarBG/H=new
		H.icon_state="[HudX-StartX],0"
		H.screen_loc="[HudX],1:2";HudBarBgList+=H

mob/var/list/GuardBarList=list()
mob/var/list/EnemyGuardBarList=list()
mob/proc/GenerateGuardBarList()
	var/StartX=1
	for(var/HudX=StartX;HudX<=StartX+3;HudX++)
		var/obj/HUD/GuardBar/H=new
		H.screen_loc="[HudX]:19,19:21" //PARTE PRA EDITAR A DEFESA
		src.GuardBarList+=H
		H.icon_state="32"
	StartX=14
	for(var/HudX=StartX;HudX<=StartX+3;HudX++)
		var/obj/HUD/EnemyGuardBar/H=new
		H.screen_loc="[HudX+8]:13,19:4" //PARTE PRA EDITAR A DEFESA DO ADVERSÁRIO
		src.EnemyGuardBarList+=H
		H.icon_state="32"

var/list/GuardBarBGsList=list()
proc/GenerateGuardBarBGsList()
	var/StartX=1
	for(var/HudX=StartX;HudX<=StartX+3;HudX++)
		var/obj/HUD/GuardBarBG/H=new
		H.icon_state="[HudX-StartX],0"
		H.screen_loc="[HudX]:3,16:4";GuardBarBGsList+=H
	StartX=13
	for(var/HudX=StartX;HudX<=StartX+3;HudX++)
		var/obj/HUD/EnemyGuardBarBG/H=new
		H.icon_state="[HudX-StartX],0"
		H.screen_loc="[HudX]:29,16:6";GuardBarBGsList+=H

var/list/TrainingBgList=list()
proc/GenerateTrainingBgList()
	var/Start=6;var/End=13
	for(var/HudX=Start;HudX<=End;HudX++)
		var/obj/HUD/TextBG/H=new
		if(HudX==Start)	H.icon_state="FullL"
		else	if(HudX==End)		H.icon_state="FullR"
		else	H.icon_state="FullM"
		H.screen_loc="[HudX]:-10,10:-1"
		TrainingBgList+=H
	TrainingBgList+=new/obj/HUD/QuitTraining

mob/proc/AddTrainingBG(var/CanQuit=1)
	if(!TrainingBgList.len)	GenerateTrainingBgList()
	for(var/client/C in src.ControlClients)
		C.screen-=TrainingBgList
		C.screen+=TrainingBgList
		if(!CanQuit)	C.screen-=TrainingBgList[TrainingBgList.len]

mob/proc/RemoveTrainingBG()
	for(var/client/C in src.ControlClients)	C.screen-=TrainingBgList

var/obj/HUD/HudProtection/HudProtection=new
mob/proc/AddHudProtection(/**/)
	for(var/client/C in src.ControlClients)	C.screen+=HudProtection
mob/proc/RemoveHudProtection(/**/)
	for(var/client/C in src.ControlClients)	C.screen-=HudProtection

var/obj/HUD/FuryIcon/FuryIcon=new
var/obj/HUD/FuryBar/FuryBar=new
var/obj/HUD/FuryBar2/FuryBar2=new
mob/proc/RemoveHUD()
	for(var/client/C in src.ControlClients)
		C.screen-=HudBgList
		C.screen-=FuryIcon
		C.screen-=FuryBar
		C.screen-=FuryBar2
		C.screen-=HudBarBgList
		C.screen-=GuardBarBGsList
		C.screen-=C.mob.GuardBarList
		C.screen-=C.mob.EnemyGuardBarList
		C.screen-=new/obj/HUD/FaceIcon
		C.screen-=new/obj/HUD/EnemyFaceIcon
		C.mob.WriteReverseHUDText(14,19,17,12,"EnemyName",null)
		C.mob.UpdateReverseHUDText("EnemyName",null)
		for(var/v in KbTypes)
			var/obj/HUD/KiBlastType/KBH=new(v,KbTypes[v])
			KBH.name=KbDescs[KbTypes.Find(v)]
			KBH.desc=KbDescs[KBH.name]
			C.screen-=KBH
		C.screen-=new/obj/HUD/SelectedKiBlastType(KbTypes[C.mob.KbType])
		C.screen-=new/obj/HUD/Level_Up
	/*	C.screen+=new/obj/HUD/Click2Instance/PvP_Arena
		C.screen+=new/obj/HUD/Click2Instance/Clan_PvP_Arena
		C.screen+=new/obj/HUD/Click2Instance/Balanced_PvP_Arena*/
		C.screen-=new/obj/HUD/Player_vs_Player
		C.screen-=new/obj/HUD/Clan_Management
		C.screen-=new/obj/HUD/Exit_Arena
		C.screen-=new/obj/HUD/Clan_Wars
		C.screen-=new/obj/HUD/Perfil
		C.screen-=new/obj/HUD/Inventory
		C.screen-=new/obj/HUD/Config
		C.screen-=new/obj/HUD/SkillTree
		C.screen-=global.WorldTournHUD
		C.screen-=global.WishHUD
		//Training HUD


mob/proc/AddHUD()
	for(var/client/C in src.ControlClients)
		if(!HudBgList.len)	GenerateHudBgList()
		if(!HudBarBgList.len)	GenerateHudBarBgList()
		if(!GuardBarBGsList.len)	GenerateGuardBarBGsList()
		if(!C.mob.GuardBarList.len)	C.mob.GenerateGuardBarList()
		C.screen+=HudBgList
		if(C.mob.Character.Race=="Saiyajin" || C.mob.Character.Race=="Humano")
			C.screen+=FuryIcon
			C.screen+=FuryBar
			C.screen+=FuryBar2
		C.screen+=HudBarBgList
		C.screen+=GuardBarBGsList
		C.screen+=C.mob.GuardBarList
		C.screen+=C.mob.EnemyGuardBarList
		C.screen+=new/obj/HUD/FaceIcon
		C.screen+=new/obj/HUD/EnemyFaceIcon
		C.mob.WriteReverseHUDText(23,64,19,25,"EnemyName","Sem Alvo") //PARTE PRA EDITAR O NOME QUE APARECE DO ADVERSÁRIO NA HUD
		C.mob.UpdateReverseHUDText("EnemyName","Sem Alvo")
		for(var/v in KbTypes)
			var/obj/HUD/KiBlastType/KBH=new(v,KbTypes[v])
			KBH.name=KbDescs[KbTypes.Find(v)]
			KBH.desc=KbDescs[KBH.name]
			C.screen+=KBH
		C.screen+=new/obj/HUD/SelectedKiBlastType(KbTypes[C.mob.KbType])
		C.screen+=new/obj/HUD/Level_Up
		C.screen+=new/obj/HUD/Perfil
		C.screen+=new/obj/HUD/Inventory
		C.screen+=new/obj/HUD/Config
		C.screen+=new/obj/HUD/SkillTree
	/*	C.screen+=new/obj/HUD/Click2Instance/PvP_Arena
		C.screen+=new/obj/HUD/Click2Instance/Clan_PvP_Arena
		C.screen+=new/obj/HUD/Click2Instance/Balanced_PvP_Arena*/
		C.screen+=new/obj/HUD/Player_vs_Player
		C.screen+=new/obj/HUD/Clan_Management
		C.screen+=new/obj/HUD/Exit_Arena
		C.screen+=new/obj/HUD/Clan_Wars
		C.screen+=global.WorldTournHUD
		C.screen+=global.WishHUD
		C.mob.UpdateKiHUD()
		C.mob.UpdatePlHUD()
		C.mob.UpdateFaceHUD()
		C.mob.UpdateGuardHUD()
		C.mob.UpdateEnemyGuardHUD()
//		C.mob.GenerateSkillTab()
		//Training HUD
		C.mob.WriteHUDText(6,0,10,16,"TrainingDesc","Ataque quando {F} aparecer!")
		C.mob.WriteHUDText(8,0,10,4,"TrainingCombo","+999% EXP por ataque!")
		C.mob.UpdateHUDText("TrainingDesc");C.mob.UpdateHUDText("TrainingCombo")

mob/proc/KiBlastHUD()
	for(var/client/C in src.ControlClients)
		PlaySound(C.mob,'Click.ogg',VolChannel="Menu")
		for(var/obj/HUD/SelectedKiBlastType/O in C.screen)	O.screen_loc=KbTypes[src.KbType]

mob/proc/UpdateFaceHUD()
	for(var/mob/M in src.Targeters)	M.UpdateEnemyFaceHUD()
	for(var/client/C in src.ControlClients)
		for(var/obj/HUD/FaceIcon/I in C.screen)
			I.icon=src.icon;return

mob/var/list/PlBars[4]
mob/proc/UpdatePlHUD()
	for(var/mob/M in src.Targeters)	M.UpdateEnemyPlHUD()
	for(var/mob/M in src.Party)	M.UpdatePartyPL(src)
	for(var/client/C in src.ControlClients)
		var/ThisPercent=round(src.PL/src.MaxPL*100)
		for(var/i=1;i<=4;i++)
			if(!C.mob.PlBars[i])
				var/obj/HUD/PlBar/PLB=new
				PLB.screen_loc="2:[7+(32*(i-1))],20:-16" //PARTE PRA EDITAR PL
				if(i==2 || i==3)	PLB.icon='PlBar2.dmi'
				if(i==4)	PLB.icon='PlBar3.dmi'
				C.screen+=PLB
				C.mob.PlBars[i]=PLB
			var/obj/HUD/PlBar/PLB=C.mob.PlBars[i]
			PLB.icon_state="[max(0,ThisPercent-(32*(i-1)))]"

mob/proc/UpdateGuardHUD()
	for(var/mob/M in src.Targeters)	M.UpdateEnemyGuardHUD()
	for(var/client/C in src.ControlClients)
		for(var/i=0;i<=3;i++)
			var/obj/HUD/GuardBar/G=C.mob.GuardBarList[i+1]
			G.icon_state="[min(32,src.GuardLeft-i*32)]"

mob/var/list/KiBars[4]
mob/proc/UpdateKiHUD()
	for(var/mob/M in src.Party)	M.UpdatePartyKi(src)
	for(var/client/C in src.ControlClients)
		var/ThisPercent=round(src.Ki/src.MaxKi*100)
		for(var/i=1;i<=4;i++)
			if(!C.mob.KiBars[i])
				var/obj/HUD/KiBar/PLB=new
				PLB.screen_loc="1:[6+(32*(i-1))],19:-6" //PARTE PRA EDITAR KI
				if(i==2 || i==3)	PLB.icon='KiBar2.dmi'
				if(i==4)	PLB.icon='KiBar3.dmi'
				C.screen+=PLB
				C.mob.KiBars[i]=PLB
			var/obj/HUD/KiBar/PLB=C.mob.KiBars[i]
			PLB.icon_state="[max(0,ThisPercent-(32*(i-1)))]"

/*mob/var/obj/HUD/ExpBar/ExpBar
mob/proc/UpdateExpBar()
	for(var/mob/M in src.Targeters)	M.UpdateEnemyKiHUD()
	for(var/client/C in src.ControlClients)
		if(!C.mob.ExpBar)
			C.mob.ExpBar=new/obj/HUD/ExpBar
			C.screen+=C.mob.ExpBar
		var/NewIS="[round(src.Exp/100*32)]"
		if(C.mob.ExpBar.icon_state!=NewIS)
			C.mob.ExpBar.icon_state=NewIS

mob/var/obj/HUD/AlignmentBar/AlignmentBar
mob/proc/UpdateAlignmentBar()
	for(var/mob/M in src.Targeters)	M.UpdateEnemyKiHUD()
	for(var/client/C in src.ControlClients)
		if(!C.mob.AlignmentBar)
			C.mob.AlignmentBar=new/obj/HUD/AlignmentBar
			C.screen+=C.mob.AlignmentBar
		var/NewIS="[round(src.Alignment/100*32)]"
		if(C.mob.AlignmentBar.icon_state!=NewIS)
			C.mob.AlignmentBar.icon_state=NewIS*/