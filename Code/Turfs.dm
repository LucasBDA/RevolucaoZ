var/list/nameslist=list()
turf/Overflow
	Tree
		density=1
		icon='Tree.png'

turf/DblClick()
	usr=usr.GetFusionMob()
	if(!usr.CanAct())	return ..()
	if(usr.Skill15==0)	return
	if(src.y>=150 && usr.x<222 && src.z==8)	return
	if(src.Enter(usr))
		usr.CompleteTutorial("Instant Transmission")
		PlaySound(view(),'InstantTransmission.ogg')
		usr.ITing=1;flick("IT",usr)
		sleep(5);if(usr)	usr.ITing=0
		if(usr.FlagCaptured)	return ..()
		if(usr.CounterBeamMob)	return ..()
		if(!usr || !src.Enter(usr) || usr.z!=src.z)	return ..()
		if(!("[src.z]" in MapsWithIT) && (abs(src.x-usr.x>12) || abs(src.y-usr.y>7)))	return ..()
		if(global.TournStatus=="Face-Off" || global.TournStatus=="Battle")
			if(usr.InTournament)
				if(global.TournStatus=="Face-Off")	return ..()
				if(!(src in GetWTBlock()))	usr.LoseTournRound("Saiu da Arena")
		usr.TrackStat("Instant Transmissions",1)
		usr.loc=src;src.Entered(usr)
		usr.DuelRangeCheck()
		usr.MMM.CalculateScreenLoc(usr)
	return ..()

turf/Entered(var/mob/M)
	if(ismob(M))	M.LoopMap()
	return ..()

turf
	OtherTurfs
		density=0
		layer=2
		icon='Turfs.dmi'
	BCharacter
		density=1
		icon='q.dmi'
		icon_state=""
		MouseEntered()
			src.desc="[initial(src.desc)]\nDesbloqueie esses personagens utilizando Zens!"
		Click()
			usr.CompleteTutorial("Changing Characters")
			var/obj/Choice=input("Escolha seu personagem","Personagens Desbloqueáveis") as null|anything in AllBlockedChar
			if(!Choice || !usr.CanAct())	return
			usr.dano=Choice.name
			if(usr.dano=="Bills")
				if(usr.Talked13==0)
					var/Choice2=alert("O personagem que você escolheu é Especial e só pode ser usado ao usar Zens. \nBills custa 200 Zens. \nVocê possui [usr.Zens] Zens. \nDeseja desbloquear o Bills?","Personagem Especial","Sim","Não")
					if(Choice2=="Sim")
						if(usr.Zens<200)
							usr<<sound('No.ogg')
							alert("Você não possui Zens o suficiente. Zens são ganhos ao vender Perks para certos NPCs.")
							return
						usr.Talked13=1
						usr.Zens-=200
						alert("Você desbloqueou o personagem Bills!")
						usr.Revert()
						usr.icon=usr.Character.icon
						usr.UpdatePartyIcon()
						usr.UpdateFaceHUD()
						usr.ResetSuffix()
						usr.RestrictChars()
					else
						return
			if(usr.dano=="Zamasu")
				if(usr.Talked14==0)
					var/Choice2=alert("O personagem que você escolheu é Especial e só pode ser usado ao usar Zens. \nZamasu custa 25 Zens. \nVocê possui [usr.Zens] Zens. \nDeseja desbloquear o Zamasu?","Personagem Especial","Sim","Não")
					if(Choice2=="Sim")
						if(usr.Zens<25)
							usr<<sound('No.ogg')
							alert("Você não possui Zens o suficiente. Zens são ganhos ao vender Perks para certos NPCs.")
							return
						usr.Talked14=1
						usr.Zens-=25
						alert("Você desbloqueou o personagem Zamasu!")
						usr.Revert()
						usr.icon=usr.Character.icon
						usr.UpdatePartyIcon()
						usr.UpdateFaceHUD()
						usr.ResetSuffix()
						usr.RestrictChars()
					else
						return
			if(usr.dano=="Goku Black")
				if(usr.Talked15==0)
					var/Choice2=alert("O personagem que você escolheu é Especial e só pode ser usado ao usar Zens. \nGoku Black custa 150 Zens. \nVocê possui [usr.Zens] Zens. \nDeseja desbloquear o Goku Black?","Personagem Especial","Sim","Não")
					if(Choice2=="Sim")
						if(usr.Zens<150)
							usr<<sound('No.ogg')
							alert("Você não possui Zens o suficiente. Zens são ganhos ao vender Perks para certos NPCs.")
							return
						usr.Talked15=1
						usr.Zens-=150
						alert("Você desbloqueou o personagem Goku Black!")
						usr.Revert()
						usr.icon=usr.Character.icon
						usr.UpdatePartyIcon()
						usr.UpdateFaceHUD()
						usr.ResetSuffix()
						usr.RestrictChars()
					else
						return
			if(usr.dano=="Hitto")
				if(usr.Talked16==0)
					var/Choice2=alert("O personagem que você escolheu é Especial e só pode ser usado ao usar Zens. \nHitto custa 75 Zens. \nVocê possui [usr.Zens] Zens. \nDeseja desbloquear o Hitto?","Personagem Especial","Sim","Não")
					if(Choice2=="Sim")
						if(usr.Zens<75)
							usr<<sound('No.ogg')
							alert("Você não possui Zens o suficiente. Zens são ganhos ao vender Perks para certos NPCs.")
							return
						usr.Talked16=1
						usr.Zens-=75
						alert("Você desbloqueou o personagem Hitto!")
						usr.Revert()
						usr.icon=usr.Character.icon
						usr.UpdatePartyIcon()
						usr.UpdateFaceHUD()
						usr.ResetSuffix()
						usr.RestrictChars()
					else
						return
			usr.Character=new Choice.type//src.icon=='Zamasu.dmi src.icon=='BlackGoku.dmi' src.icon=='TrunksDBS.dmi' src.icon=='Hito.dmi'
			usr.Revert()
//			if(src.Training=="Focus Training")	src.AddAura()
//			if(usr.icon=='Hito.dmi')
//				usr.DamageMultiplier-=0.5
			usr.icon=usr.Character.icon
			usr.UpdatePartyIcon()
			usr.UpdateFaceHUD()
			usr.ResetSuffix()
			usr.RestrictChars()
			usr.PerkCheck()
			usr.DeleteSSAura()
			usr.DeleteWAura()
			usr.DeleteRAura(usr)
			usr.DeleteGAura()
			usr.DeletePAura()
			usr.Time=0
			usr.client.eye=usr.client.mob
			usr<<sound(null)
			usr<<sound('button.ogg')
/*	NCharacter
		density=1
		icon='q.dmi'
		icon_state=""
		MouseEntered()
			src.desc="[initial(src.desc)]\nSelecione um entre todos os personagens liberados para jogar!"
		Click()
			usr.CompleteTutorial("Changing Characters")
			var/obj/Choice=input("Escolha seu personagem","Todos os Personagens") as null|anything in AllCharacters
			if(!Choice || !usr.CanAct())	return
			usr.Character=new Choice.type//src.icon=='Zamasu.dmi src.icon=='BlackGoku.dmi' src.icon=='TrunksDBS.dmi' src.icon=='Hito.dmi'
			usr.Revert()
			usr.dano=usr.Character.name
			usr.icon=usr.Character.icon
			usr.RestrictChars2()
			usr.UpdatePartyIcon()
			usr.UpdateFaceHUD()
			usr.ResetSuffix()
			usr.RestrictChars()
			usr.PerkCheck()
			usr.DeleteSSAura()
			usr.DeleteWAura()
			usr.DeleteRAura(usr)
			usr.DeleteGAura()
			usr.DeletePAura()
			usr.Time=0
			usr.client.eye=usr.client.mob
			usr<<sound(null)
			usr<<sound('Botão.ogg')
			if(usr.Character.name=="Gohan")
				if(usr.Gohan==0)
					usr.Character=new/obj/Characters/Gohan
					usr.Revert()
					usr.icon=usr.Character.icon
					usr.UpdatePartyIcon()
					usr.UpdateFaceHUD()
					usr.ResetSuffix()
					usr.AddHUD()
				if(usr.Gohan==1)
					usr.Character=new/obj/EvolCharacters/Teen_Gohan
					usr.Revert()
					usr.icon=usr.Character.icon
					usr.UpdatePartyIcon()
					usr.UpdateFaceHUD()
					usr.ResetSuffix()
					usr.AddHUD()
				if(usr.Gohan==2)
					usr.Character=new/obj/EvolCharacters/Adult_Piccolo_Gohan
					usr.Revert()
					usr.icon=usr.Character.icon
					usr.UpdatePartyIcon()
					usr.UpdateFaceHUD()
					usr.ResetSuffix()
					usr.AddHUD()
				if(usr.Gohan==5)
					usr.Character=new/obj/EvolCharacters/Future_Gohan
					usr.Revert()
					usr.icon=usr.Character.icon
					usr.UpdatePartyIcon()
					usr.UpdateFaceHUD()
					usr.ResetSuffix()
					usr.AddHUD()
			if(usr.Character.name=="Goku")
				if(usr.Goku==0)
					usr.Character=new/obj/Characters/Goku
					usr.Revert()
					usr.icon=usr.Character.icon
					usr.UpdatePartyIcon()
					usr.UpdateFaceHUD()
					usr.ResetSuffix()
					usr.AddHUD()
				if(usr.Goku==1)
					usr.Character=new/obj/EvolCharacters/Goku2
					usr.Revert()
					usr.icon=usr.Character.icon
					usr.UpdatePartyIcon()
					usr.UpdateFaceHUD()
					usr.ResetSuffix()
					usr.AddHUD()
				if(usr.Goku==2)
					usr.Character=new/obj/EvolCharacters/Goku_Super
					usr.Revert()
					usr.icon=usr.Character.icon
					usr.UpdatePartyIcon()
					usr.UpdateFaceHUD()
					usr.ResetSuffix()
					usr.AddHUD()
				if(usr.Goku==3)
					usr.Character=new/obj/EvolCharacters/GT_Goku
					usr.Revert()
					usr.icon=usr.Character.icon
					usr.UpdatePartyIcon()
					usr.UpdateFaceHUD()
					usr.ResetSuffix()
					usr.AddHUD()
			if(usr.Character.name=="Vegeta")
				if(usr.Vegeta==0)
					usr.Character=new/obj/Characters/Vegeta
					usr.Revert()
					usr.icon=usr.Character.icon
					usr.UpdatePartyIcon()
					usr.UpdateFaceHUD()
					usr.ResetSuffix()
					usr.AddHUD()
				if(usr.Vegeta==1)
					usr.Character=new/obj/EvolCharacters/Saiyan_Armor_Vegeta
					usr.Revert()
					usr.icon=usr.Character.icon
					usr.UpdatePartyIcon()
					usr.UpdateFaceHUD()
					usr.ResetSuffix()
					usr.AddHUD()
				if(usr.Vegeta==2)
					usr.Character=new/obj/EvolCharacters/Vegeta2
					usr.Revert()
					usr.icon=usr.Character.icon
					usr.UpdatePartyIcon()
					usr.UpdateFaceHUD()
					usr.ResetSuffix()
					usr.AddHUD()
				if(usr.Vegeta==3)
					usr.Character=new/obj/EvolCharacters/Vegeta_Super
					usr.Revert()
					usr.icon=usr.Character.icon
					usr.UpdatePartyIcon()
					usr.UpdateFaceHUD()
					usr.ResetSuffix()
					usr.AddHUD()
				if(usr.Vegeta==4)
					usr.Character=new/obj/EvolCharacters/Alternate_GT_Vegeta
					usr.Revert()
					usr.icon=usr.Character.icon
					usr.UpdatePartyIcon()
					usr.UpdateFaceHUD()
					usr.ResetSuffix()
					usr.AddHUD()
			if(usr.Character.name=="Future Trunks")
				if(usr.FutureTrunks==0)
					usr.Character=new/obj/Characters/Future_Trunks
					usr.Revert()
					usr.icon=usr.Character.icon
					usr.UpdatePartyIcon()
					usr.UpdateFaceHUD()
					usr.ResetSuffix()
					usr.AddHUD()
				if(usr.FutureTrunks==1)
					usr.Character=new/obj/EvolCharacters/Future_Trunks_Adulto
					usr.Revert()
					usr.icon=usr.Character.icon
					usr.UpdatePartyIcon()
					usr.UpdateFaceHUD()
					usr.ResetSuffix()
					usr.AddHUD()
				if(usr.FutureTrunks==2)
					usr.Character=new/obj/EvolCharacters/Saiyan_Armor_Trunks
					usr.Revert()
					usr.icon=usr.Character.icon
					usr.UpdatePartyIcon()
					usr.UpdateFaceHUD()
					usr.ResetSuffix()
					usr.AddHUD()
				if(usr.FutureTrunks==3)
					usr.Character=new/obj/EvolCharacters/Trunks_Super
					usr.Revert()
					usr.icon=usr.Character.icon
					usr.UpdatePartyIcon()
					usr.UpdateFaceHUD()
					usr.ResetSuffix()
					usr.AddHUD()*/
	Jogar
		density=1
		layer=200
		icon='q.dmi'
		icon_state=""
		Click()
			usr<<sound('button.ogg')
			usr.Logg=1
			usr<<sound(null)
//			winset(usr,"ChatPaneChat","is-visible=false")
//			PlaySound(view(),'button.ogg')
	Hair
		density=1
		layer=200
		icon='q.dmi'
		icon_state=""
		Click()
			winset(usr,"Hair","size=520x199;is-visible=true")
	Antena
		density=1
		layer=200
		icon='q.dmi'
		icon_state=""
		Click()
			winset(usr,"Antena","size=192x199;is-visible=true")
	HairHumano
		density=1
		layer=200
		icon='q.dmi'
		icon_state=""
		Click()
			winset(usr,"Hair","size=520x199;is-visible=true")
	PeleHumano
		density=1
		layer=200
		icon='q.dmi'
		icon_state=""
		Click()
			winset(usr,"HumanSkin","is-visible=true")
	PeleSaiyajin
		density=1
		layer=200
		icon='q.dmi'
		icon_state=""
		Click()
			winset(usr,"SaiyanSkin","is-visible=true")
	PeleNamek
		density=1
		layer=200
		icon='q.dmi'
		icon_state=""
		Click()
			winset(usr,"NamekSkin","is-visible=true")
	Saiyajin
		density=1
		layer=200
		icon='q.dmi'
		icon_state=""
		Click()
//			PlaySound(view(),'button.ogg')
			usr<<sound('Join.ogg')
			for(var/obj/Characters/Saiyajin/G in AllCharacters)
				usr.Character=new G.type
			usr.loc=locate(160,362,8)
			usr.pixel_x=14
//			usr.client.eye=locate(159,362,8)
			usr.icon=usr.Character.icon
			usr.Fighting=1

	Humano
		density=1
		layer=200
		icon='q.dmi'
		icon_state=""
		Click()
//			PlaySound(view(),'button.ogg')
			usr<<sound('Join.ogg')
			for(var/obj/Characters/Humano3/G in AllCharacters)
				usr.Character=new G.type
			usr.loc=locate(200,346,8)
			usr.pixel_x=14
//			usr.client.eye=locate(199,346,8)
			usr.icon=usr.Character.icon
			usr.Fighting=1

	Namekuseijin
		density=1
		layer=200
		icon='q.dmi'
		icon_state=""
		Click()
//			PlaySound(view(),'button.ogg')
			usr<<sound('Join.ogg')
			for(var/obj/Characters/Namek1/G in AllCharacters)
				usr.Character=new G.type
			usr.loc=locate(188,362,8)
			usr.pixel_x=14
//			usr.client.eye=locate(187,362,8)
			usr.icon=usr.Character.icon
			usr.Fighting=1

	Sair
		density=1
		layer=200
		icon='q.dmi'
		icon_state=""
		Click()
			del usr
	GoBack
		density=1
		layer=200
		icon='q.dmi'
		icon_state=""
		Click()
			usr<<sound('Cancel.ogg')
			usr.loc=locate(131,362,8)
//			usr.client.eye=locate(130,362,8)
			usr.icon=null
			usr.pixel_x=0
			usr.HairStyle=0
			usr.AntenaStyle=0
			usr.overlays=null
	Sair2
		density=1
		layer=200
		icon='q.dmi'
		icon_state=""
		Click()
			usr.client.eye=usr.client.mob
	Hub
		density=1
		layer=200
		icon='q.dmi'
		icon_state=""
		Click()
//			PlaySound(view(),'button.ogg')
			usr<<link("http://www.byond.com/games/Shawn_EX/RevoluoZ")
//			usr<<sound('Botão.ogg')
	Nome
		density=1
		layer=200
		icon='q.dmi'
		icon_state=""
		Click()
//			PlaySound(view(),'button.ogg')
//			usr<<sound('Botão.ogg')
			var/NewName="Digite o seu nome"
			Input(usr,NewName,,1,1)
			if(NewName in nameslist)
				Alert(usr,"Este nome já está em uso. Por favor, escolha outro.",,1,1)
				return
			usr.name=NewName
			usr.Creating=1
			return
	Personagem
		density=1
		layer=200
		icon='q.dmi'
		icon_state=""
		Click()
//			PlaySound(view(),'button.ogg')
			var/obj/Choice=input("Escolha seu personagem","Personagem") as null|anything in AllCharacters
//			usr<<sound('Botão.ogg')
			if(!Choice || !usr.CanAct())	return
			usr.Character=new Choice.type
			usr.icon=usr.Character.icon
			usr.Spin+=1
			usr.Creating2=1
			if(usr.Spin>1)
				return
			if(usr.Spin==1)
				while(1)
					if(usr.z!=8)
						break
					usr.dir=8
					sleep(10)
					if(usr.z!=8)
						break
					usr.dir=1
					sleep(10)
					if(usr.z!=8)
						break
					usr.dir=4
					sleep(10)
					if(usr.z!=8)
						break
					usr.dir=2
					sleep(10)
			return
	Passar
		density=1
		layer=200
		icon='q.dmi'
		icon_state=""
		Click()
//			PlaySound(view(),'button.ogg')
			usr<<sound('button.ogg')
			var/NewName=Input(usr,"Digite o seu nome",,1,1)
			if(NewName in nameslist)
				Alert(usr,"Este nome já está em uso. Por favor, escolha outro.",,1,1)
				return
			usr.name=NewName
			usr.NomeReserva=usr.name
			usr.Creating=1
			switch(Switch(usr,"Tem certeza que quer essas características?",list("Sim","Não"),1,1))
				if("Sim")
					if(usr.TipoEscolhido==0)
						switch(Switch2(usr,,list(" Quero nascer COM cauda"," Quero nascer SEM cauda"),1,1))
							if(" Quero nascer COM cauda")
								if(usr.icon=='BaseSaiyaijn.dmi')
									for(var/obj/Characters/SaiyajinCauda/G in AllCharacters)
										usr.Character=new G.type
										usr.loc=locate(160,362,8)
//										usr.client.eye=locate(159,362,8)
										usr.icon=usr.Character.icon
								if(usr.icon=='BaseSaiyaijn2.dmi')
									for(var/obj/Characters/Saiyajin2Cauda/G in AllCharacters)
										usr.Character=new G.type
										usr.loc=locate(160,362,8)
//										usr.client.eye=locate(159,362,8)
										usr.icon=usr.Character.icon
								if(usr.icon=='BaseSaiyaijn3.dmi')
									for(var/obj/Characters/Saiyajin3Cauda/G in AllCharacters)
										usr.Character=new G.type
										usr.loc=locate(160,362,8)
//										usr.client.eye=locate(159,362,8)
										usr.icon=usr.Character.icon
								usr.TipoEscolhido=1
						winset(usr, "window74", "is-visible=false")
				//	winset(usr, "window74", "is-visible=false")
					winset(usr,"window2","is-visible=true")
					usr.Creating=0
			//		usr.TipoEscolhido=0
			//		winset(usr,"MainMap.Map","pos=100,100;zoom=1;is-default=true;focus=true")
					world<<output("<b>[usr]<font color=[rgb(34,177,76)]> entrou no jogo!</font>","window2.output1")
					usr.loc=locate(322,61,1)
					usr.pixel_x=0
					nameslist+=usr.name
					usr.Traveling=0
					usr<<sound(null)
					usr.Fighting=0
//					usr.icon=usr.Character.icon
					usr.SubCheck()
					usr.AddHUD()
					usr.AddPartyHUD()
					usr.UpdateLastOnline()
					spawn()	usr.SecondLoop()
					spawn()	usr.GuardRecharge()
	//				winset(usr,"MainWindow","pos=0,0;size=800x600;is-maximized=true")
	//				winset(usr,"LevelWindow","pos=100,100;size=640x480;is-visible=false")
					Players+=usr
				//	usr.ViewMotD()
					SetWorldStatus()
					usr.AssignClan()
					usr.SetupOverlays()
					usr.OnlineFriends()
					usr.FillStatsGrid()
					usr.CanGetCashPoints=1;usr.CashPointPurchaseInfo()
					usr.GiveMedal(new/obj/Medals/Player);usr.UpdateHubScore()
//					PlaySound(view(),pick('DBGTOP.ogg','DBZEND.ogg','DBZKAIEND.ogg','DBZKAIOP.ogg','DBZOP.ogg','DBZOP2.ogg','FlowHero.ogg'))
					usr.TrackStat("Days Played",time2text(world.timeofday,"YYYYMMMDD"),"List")
					usr.GeneralTutorials()
					usr.CanSave=1
					if(findtext(usr.Character.Race,"Saiyajin") || findtext(usr.Character.Race,"Humano"))
						if(usr.HairStyle==1)	usr.GenerateHair1()
						if(usr.HairStyle==2)	usr.GenerateHair2()
						if(usr.HairStyle==3)	usr.GenerateHair3()
						if(usr.HairStyle==4)	usr.GenerateHair4()
					else
						if(findtext(usr.Character.Race,"Namekuseijin"))
							if(usr.AntenaStyle==1)
								usr.GenerateAntena1()
					winset(usr,"window2.output1","is-visible=true")
					if(usr.TipoEscolhido==1)
						usr.GenerateTail()
//					PlaySound(view(usr),pick('Dragon Ball Z Theme 9.ogg','Dragon Ball Z Theme 45.ogg','Dragon Ball Z Theme 13.ogg','Dragon Ball Z Theme 30.ogg','Dragon Ball Z Theme 17.ogg','Dragon Ball Z Theme 40.ogg','Dragon Ball Z Theme 28.ogg','Dragon Ball Z Theme 8.ogg'))
					if(usr.key=="Rafafa47")	usr.verbs+=typesof(/mob/GM/verb)
					if(usr.key=="Hiukai")	usr.verbs+=typesof(/mob/GM/verb)
					if(usr.key=="Xalabaias")	usr.verbs+=typesof(/mob/Test/verb)
					if(usr.key=="Rafafa47")	usr.verbs+=typesof(/mob/Test/verb)
					if(usr.key=="Egy Arab")	usr.verbs+=typesof(/mob/GM/verb)
					if(usr.key=="Hkl")	usr.verbs+=typesof(/mob/GM/verb)
					if(usr.key=="Xalabaias")	usr.verbs+=typesof(/mob/GM/verb)
					if(usr.key=="Eventer")	usr.verbs+=typesof(/mob/GM/verb)
					if(usr.key=="Hkl")	usr.verbs+=typesof(/mob/Test/verb)
					if(usr.key=="Hiukai")	usr.verbs+=typesof(/mob/Test/verb)
					if(usr.key=="RLKS")	usr.verbs+=typesof(/mob/Test/verb)
					if(usr.key=="Egy Arab")	usr.verbs+=typesof(/mob/Test/verb)
					if(usr.key=="Shawn_EX")	usr.verbs+=typesof(/mob/Test/verb)
					if(usr.key=="RLKS")	usr.verbs+=typesof(/mob/GM/verb)
					if(usr.key=="Shawn_EX")	usr.verbs+=typesof(/mob/GM/verb)
					if(usr.key=="Hkl")	usr.verbs+=typesof(/mob/Subscriber/verb)
					if(usr.key=="Shawn_EX")	usr.verbs+=typesof(/mob/Subscriber/verb)
					return
				if("Não")
					nameslist-=usr.name

turf/Doorway
	layer=5
	var/NewX
	var/NewY
	var/NewZ
	Entered(var/mob/M)
		if(ismob(M))
			spawn(8)
			if(M && M.loc==src)
				if(src.NewZ)	M.loc=locate(src.NewX,src.NewY,src.NewZ)
				else	M<<""
				M.DuelRangeCheck()
				M.LoadMiniMapBG()
		return ..()


turf
	icon='NewTurfs.dmi'
	var/SuperDensity=0
	Enter(var/atom/A)
		if(src.SuperDensity)	return
		else	return ..()
	Images
		BankInterior
			icon='BankInterior.png'
		KameHouse
			icon='KameHouse.png'
		billsf
			icon='Imagem1.png'
		bills2
			icon='Imagem2.png'
		Capsula
			icon='Capsula.png'
		GiantTree
			icon='bigtree.png'
		CC
			icon='CapsuleCorp.png'
		CC1
			icon='CC1.png'
		CC2
			icon='CC2.png'
		CC3
			icon='CC3.png'
		CC4
			icon='CC4.png'
		CC5
			icon='CC5.png'
		CC6
			icon='CC6.png'
		CC7
			icon='CC7.png'
		CC8
			icon='CC8.png'
		ZMart
			icon='ZMart.png'
		Crater
			icon='Crater2.png'
		Mountain
			icon='Mountain.png'
		Store
			icon='Store.png'
		Saiyajin
			icon='Saiyajin.png'
		Humano
			icon='Humano.png'
		Namekuseijin
			icon='Namekuseijin.png'
		Loggin
			icon='Loggin.jpg'
		First
			icon='First.png'
		Loggin2
			icon='Loggin.jpg'
		Entrand
			icon='Entrance.jpg'
		Selection
			icon='Selection.jpg'
		Entrand2
			icon='Entrand2.png'
		Nave
			icon='SaiyanSpacePodGohan.png'
		Sky
			icon='Sky.png'
		Sky4
			icon='skyT.png'
			layer=6
		Sky3
			icon='Sky.jpg'
		Sky2
			density=1
			icon='Sky2.png'
		Cabin
			icon='cabin.png'
		Cabin2
			icon='cabin2.png'
		Cloud2
			icon='cloud2.png'
		Cloud3
			icon='cloud3.png'
		Cloud4
			icon='cloud4.png'
		CapsuleSign
			layer=5
			icon='capsule2.png'
		GokuEvol1
			layer=5
			icon='GokuEvol1.png'
		GokuEvol2
			layer=5
			icon='GokuEvol2.png'
		GohanEvol0
			layer=5
			icon='GohanEvol0.jpg'
		GohanEvol1
			layer=5
			icon='GohanEvol1.png'
		GohanEvol2
			layer=5
			icon='GohanEvol2.png'
		FutureTrunksEvol0
			layer=5
			icon='FutureTrunksEvol0.png'
		FutureTrunksEvol1
			layer=5
			icon='FutureTrunksEvol1.png'
		FutureTrunksEvol2
			layer=5
			icon='FutureTrunksEvol2.png'
		VegetaEvol0
			layer=5
			icon='VegetaEvol0.png'
		VegetaEvol1
			layer=5
			icon='VegetaEvol1.png'
		VegetaEvol2
			layer=5
			icon='VegetaEvol2.png'

	Other
		Density
			layer=10
			density=1
		SuperDensity
			layer=10
			density=1;SuperDensity=1
		White
			icon_state="White"
			DblClick()	return
		Blackness
			opacity=1
			density=1;SuperDensity=1
			icon_state="Black"
		HbtcClouds
			name="HBTC"
			icon='HbtcClouds.dmi'
			verb/Treinamento_de_Reflexos()
				set src in oview()
				set category=null
				usr.ShadowSparProc(src)
			verb/Treinamento_de_Luta()
				set src in oview()
				set category=null
				usr.SparringPartnerProc(src)
			verb/Treinamento_de_Energia()
				set src in oview()
				set category=null
				usr.FocusTrainingProc(src)
	Apartment_Interiors
		icon='ApartmentInts.dmi'
		Wall
			density=1
			icon_state="BaseWall"
		Floor
			icon_state="BaseTile"
	OtherWorld
		density=1
		icon='OtherWorld.dmi'
		Clouds
			icon='Clouds.dmi'
		CloudTop
			icon='CloudTop.png'
		UnderTongue
			density=0
			icon='UnderTongue.png'
		YemmaEntranceL
			icon='YemmaEntL.png'
		YemmaEntranceR
			icon='YemmaEntR.png'
		YemmaEntranceDoor
			icon='YemmaEntDoor.png'
		Tile
			icon_state="Tile"
			density=0
		Wall
			icon_state="WallB"
		WallTop
			density=1;SuperDensity=1
			icon_state="WallTopR"
		WallPeg
			density=1;SuperDensity=1
			icon_state="WallPegBR"
		YemmaRoof
			icon_state="YemmaRoof"
	Tournament
		density=1
		icon='TournamentTurfs.dmi'
		BrickWall
			icon_state="BrickWall"
		Fans
			FansL
				icon='FansL.png'
			FansR
				icon='FansR.png'
			FansTL
				icon='FansTL.png'
			FansTR
				icon='FansTR.png'
			FansB
				icon='FansB.png'
	HighwayCliffs
		icon='HighwayCliffs.dmi'
		Dirt
			icon_state="Dirt1"
			New()
				src.icon_state="Dirt[rand(1,4)]"
				return ..()
		Path
			icon_state="Path1"
			New()
				src.icon_state="Path[rand(1,3)]"
				return ..()
		GuardRail
			layer=5
			icon_state="GuardRailB"
		CliffEdge
			icon_state="CliffL"
		Cliff
			density=1
			icon_state="B"
	Buildings
		density=1
		HerculeCityBank
			icon='HerculeCityBank.png'
		SquareBuilding
			icon_state="BL"
			icon='SquareBuilding.dmi'
		RectBuilding
			icon_state="BL"
			icon='RectBuilding.dmi'
		RoundBuilding
			icon_state="BL"
			icon='RoundTower.dmi'
		RedHut
			icon_state="7"
			icon='RedHut.dmi'
		PurpleHut
			icon_state="7"
			icon='PurpleHut.dmi'
	City
		icon='CityTurfs.dmi'
		Tile
			icon_state="Tile"
		Stairs
			icon='CityStairs.dmi'
			icon_state="Stairs"
		Road
			icon_state="Road"
		CrossWalk
			icon_state="CrossWalkH"
		Plant
			density=1
			icon_state="PlantM"
		CityWall
			density=1
			icon='CityWall.dmi'
			icon_state="B"
		Bench
			icon_state="BenchL"
		Portal
			icon_state="PortalTL"
	HerculeCity
		HerculeCityWall
			density=1
			icon='HerculeCityWall.dmi'
			icon_state="Wall"
	DbzTurfs
		icon='DbzTurfs.dmi'
		GrayTile
			icon_state="GrayTile"
		WallTop
			density=1;SuperDensity=1
			icon_state="WallTopB"
		FullTop
			opacity=1
			density=1;SuperDensity=1
			icon_state="FullTopV"
		KamisBar
			layer=5
			icon_state="KamisBarB"
	Generic
		Grass
			icon_state="DarkGrass1"
			New()
				src.icon_state="DarkGrass[rand(1,4)]"
				return ..()
		Water
			Phase=1
			density=1
			icon_state="Water"