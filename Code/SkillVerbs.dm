mob/var/landing=0
var/obj/KO_Icon/koIcon=new
obj/KO_Icon
	layer=FLOAT_LAYER
	icon='aura.dmi'
mob/var/Countering=0
mob/var/KK=0
mob/var/mob/CounterBeamMob
mob/verb
	Resolution()
		set hidden=1
		var/list/Resolucoes=list("1280x1024","1360x768","1440x900","1600x900","1920x1080","3440x1440")
		var/Choice=input(src,"Em qual resolução você deseja jogar?","Resolução") as anything in Resolucoes
		if(Choice=="1600x900")
			winset(src, null, "reset=true")
			winset(src,"default.map1","zoom=2;zoom-mode=normal")
			winset(src,"window2","is-visible=true;pos=200,500")
			src.SetFocus("default.map1")
			src.Zoom=2
//			src.client.eye.step_y-=5
		else
			if(Choice=="1360x768")
				winset(src, null, "reset=true")
				winset(src,"default.map1","zoom=1.7;zoom-mode=normal")
				winset(src,"window2","is-visible=true;pos=200,500")
				src.SetFocus("default.map1")
				src.Zoom=1.7

			if(Choice=="1280x1024")
				winset(src, null, "reset=true")
				winset(src,"default.map1","zoom=1.6;zoom-mode=normal")
				winset(src,"window2","is-visible=true;pos=200,500")
				src.SetFocus("default.map1")
				src.Zoom=1.6

			if(Choice=="1440x900")
				winset(src, null, "reset=true")
				winset(src,"default.map1","zoom=1.8;zoom-mode=normal")
				winset(src,"window2","is-visible=true;pos=200,500")
				src.SetFocus("default.map1")
				src.Zoom=1.8

			if(Choice=="1920x1080")
				winset(src, null, "reset=true")
				winset(src,"default.map1","zoom=2.4;zoom-mode=normal")
				winset(src,"window2","is-visible=true;pos=200,500")
				src.SetFocus("default.map1")
				src.Zoom=2.4
			if(Choice=="3440x1440")
				winset(src, null, "reset=true")
				winset(src,"default.map1","zoom=3;zoom-mode=normal")
				winset(src,"window2","is-visible=true;pos=200,500")
				src.SetFocus("default.map1")
				src.Zoom=3
// 25 tiles da esquerda pra direita
// 13 tiles de cima para baixo
	AtivarAura()
		set hidden=1
		if(src.Shocking!=0)	return
		if(src.IsUltra==1)	return
		if(src.icon=='VegitoSSB.dmi')
			src.AddBlueAura(src)
		if(src.Quest11==1)	return
	//	if(src.FusionMob.KK==1)	return
		src=src.GetFusionMob()
		if(src.icon=='Alkaiser Dark-2.dmi')
			src.overlays+=global.RDWing
			src.overlays+=global.LDWing
			return
		if(src.icon=='Darker.dmi')
			src.overlays+=global.EWing
			src.overlays+=global.DWing
			src.overlays+=global.Coroa
			return
		if(src.Z1==0)
			if(src.key=="DraguunnoNeko")
				src.AddBlueAura3()
				src.Z1=1
				return
			if(findtext(src.Character.Race,"Human"))
				src.DeleteWAura()
				src.AddWAura()
				src<<sound('EnergyLoop.ogg',repeat=1,channel=2)
				src.Z1=1
				return
			if(src.icon=='MysticGohanMystic.dmi')
				src.DeleteWAura()
				src.AddWAura()
				src<<sound('EnergyLoop.ogg',repeat=1,channel=2)
				src.Z1=1
				return
			if(src.icon=='BlackGoku.dmi')
				src.DeleteBlackAura()
				src.AddBlackAura()
				src<<sound('EnergyLoop.ogg',repeat=1,channel=2)
				src.Z1=1
			if(src.icon=='BlackGokuRose.dmi')
				src.DeleteRoseAura()
				src.AddRoseAura()
				src<<sound('BlueAura.ogg',repeat=1,channel=2)
				src.Z1=1
			if(src.icon=='GoldenFreeza.dmi')
				src<<sound('BlueAura.ogg',repeat=1,channel=2)
				src.DeleteSSAura()
				src.AddSSAura()
				src.Z1=1
				return
			if(findtext(src.Character.Race,"Alien") || src.icon=='Bills.dmi' || findtext(src.Character.Race,"Assassin"))
				if(src.icon!='Pikkon.dmi' && src.icon!='GoldenFreeza.dmi')
					src.DeletePAura()
					src.AddPAura()
					src<<sound('EnergyLoop.ogg',repeat=1,channel=2)
					src.Z1=1
					return
			if(findtext(src.Character.Race,"Namekian"))
				src.DeleteWAura()
				src.AddWAura()
				src<<sound('EnergyLoop.ogg',repeat=1,channel=2)
				src.Z1=1
				return
			if(findtext(src.Character.Race,"BioAndroid"))
				if(src.icon!='CellJr.dmi')
					src.DeleteGAura()
					src.AddGAura()
					src<<sound('EnergyLoop.ogg',repeat=1,channel=2)
					src.Z1=1
					return
			if(findtext(src.Character.Race,"Creature"))
				src.DeleteGAura()
				src.AddGAura()
				src<<sound('EnergyLoop.ogg',repeat=1,channel=2)
				src.Z1=1
				return
			if(src.icon=='GokuKaioken.dmi')
				src.DeleteRAura(src)
				src.AddRAura(usr)
				src<<sound('EnergyLoop.ogg',repeat=1,channel=2)
				src.Z1=1
				return
			if(!src.CurTrans)
				if(findtext(src.Character.Race,"Saiyajin") && src.icon!='BlackGoku.dmi')
					src.DeleteWAura()
					src.AddWAura()
					src<<sound('EnergyLoop.ogg',repeat=1,channel=2)
					src.Z1=1
					return
			if(src.icon=='GTGoten.dmi')
				src<<sound(null,channel=2)
				src.DeleteSSAura()
				src.AddSSAura()
				src<<sound('EnergyLoop.ogg',repeat=1,channel=2)
				src.Z1=1
				return
			if(src.icon=='GokuJr.dmi')
				src<<sound(null,channel=2)
				src.DeleteSSAura()
				src.AddSSAura()
				src<<sound('EnergyLoop.ogg',repeat=1,channel=2)
				src.Z1=1
				return
			if(src.icon=='Pikkon.dmi')
				src<<sound(null,channel=2)
				src.DeleteWAura()
				src.AddWAura()
				src<<sound('EnergyLoop.ogg',repeat=1,channel=2)
				src.Z1=1
				return
			if(findtext(src.Character.Race,"Dragon"))
				usr.DeleteWAura()
				usr.AddWAura()
				usr<<sound('EnergyLoop.ogg',repeat=1,channel=2)
				usr.Z1=1
				return
			if(src.icon=='CellJr.dmi')
				src<<sound(null,channel=2)
				src.DeleteWAura()
				src.AddWAura()
				src<<sound('EnergyLoop.ogg',repeat=1,channel=2)
				src.Z1=1
				return
			if(src.CurTrans)
				if(findtext(src.Character.Race,"Saiyajin"))
					if(src.icon!='GokuKaioken.dmi')
						src<<sound(null,channel=2)
						if(findtext("[src.icon]","USSBlue"))
							src.Z1=1
							src.AddBlueAura2()
							src<<sound('BlueAura.ogg',repeat=1,channel=2)
							return
						if(src.icon=='BlackGokuRose.dmi')
							src.DeleteRoseAura()
							src.AddRoseAura()
							src<<sound('BlueAura.ogg',repeat=1,channel=2)
							src.Z1=1
							return
						if(findtext("[src.icon]","SSBlue"))
							src.Z1=1
							src.AddBlueAura(usr)
							src<<sound('BlueAura.ogg',repeat=1,channel=2)
							return
						if(findtext("[src.icon]","SSGod") || src.icon=='VegetaSuperGod.dmi' || src.icon=='VegetaSuperGodB.dmi')
							src.Z1=1
							src.AddGodAura(src)
							src<<sound('GodAura.ogg',repeat=1,channel=2)
							return
						src.DeleteSSAura()
						src.AddSSAura()
						if(findtext("[src.icon]","SS2") || findtext("[src.icon]","SS3"))
							src.Z1=1
							src.SS2Aura(src)
							return
						src<<sound('EnergyLoop.ogg',repeat=1,channel=2)
						src.Z1=1
						return
		/*	if(findtext(src.Character.Race,"Saiyajin"))
				src.DeleteGAura()
				src.AddGAura()
				src<<sound('EnergyLoop.ogg',repeat=1,channel=2)
				src.Z1=1
				return*/
			if(src.icon=='BardockSS1.dmi')
				src.DeleteSSAura()
				src.AddSSAura()
				src<<sound('EnergyLoop.ogg',repeat=1,channel=2)
				src.Z1=1
				return
			if(src.Character.Race=="Android")
				src.DeleteWAura()
				src.AddWAura()
				src<<sound('EnergyLoop.ogg',repeat=1,channel=2)
				src.Z1=1
				return
		else
			if(src.Kaioken==1 && src.icon!='GokuSSGodSS1K.dmi')
				return
			if(src.icon=='GogetaSSBK.dmi')
				return
			src.DeleteSSAura()
			src.DeleteWAura()
			src.DeleteRAura(src)
			src.DeleteGAura()
			src.DeletePAura()
			src.DeleteBlackAura()
			src.RemoveBlueAura(src)
			src.RemoveBlueAura()
			src.RemoveBlueAura2()
			src.RemoveBlueAura3()
			src.DeleteRoseAura()
			src.RemoveGodAura(src)
			src<<sound(null,channel=2)
			src.Z1=0
	CounterAttack(/**/)
		set hidden=1
		if(src.Shocking!=0)	return
		if(src.icon=='Candy.dmi')	return
		if(src.Frozen==1)	return
		src=src.GetFusionMob()
		if(src.HitStun)	for(var/mob/M in oview(1))
			if(M.Attacking && src.CanPVP(M))
				src.dir=get_dir(src,M)
				flick("punch2",src)
				M.HitStun(10,src);src.Throw(M,5,src.dir)
				PlaySound(view(),pick('HitHeavy.ogg','strongkick.ogg'))
		if(!src.CanAct())	return
		src.Countering=1
		spawn(6)	src.Countering=0
		if(src.CounterBeam())	return
		flick("punch2",src)
		PlaySound(view(),pick('atack1.ogg','atack2.ogg'))
/*	StepRevert(/**/)
		set hidden=1
		src=src.GetFusionMob()
		src.CompleteTutorial("Reverting")
		if(src.CurTrans>=1)
			src.CurTrans-=1
			flick("revert",src)
			src.TakeKiPercent(20)
			if(src.FusionMob.icon=='GogetaSSBK.dmi')
			src.FusionMob.DeleteRAura(src.FusionMob)
			src.FusionMob.DelBlue2(src.FusionMob)
			src.ApplyTransDatum()
			src.UpdatePartyIcon()
			src.UpdateFaceHUD()
			PlaySound(view(),'Descend.ogg') */
	Revert()
		set hidden=1
		if(src.Quest11==2)	return
		if(src.icon=='Candy.dmi')	return
		if(src.Shocking!=0)	return
		if(src.Frozen==1)	return
		if(src.Fighting==1)	return
		if(src.MajinForm==1)	return
		if(src.Kaioken==1)
			src<<"Clique na técnica de Kaioken para poder desativá-lo."
			return
		src=src.GetFusionMob()
		if(src.Transformed==1)
			src<<"Espere você estabilizar sua transformação antes de revertê-la."
			return
		src.CompleteTutorial("Reverting")
		if(src.CurTrans>=1)
			src.Str/=src.Boost
			src.Def/=src.Boost
			src.MaxPL/=src.Boost
			src.PL/=src.Boost
			src.MaxKi/=src.Boost
			src.Ki/=src.Boost
			src.Boost=1
			src.CurTrans=0
			src.TransDatum=null
			flick("Guard",src)
			src.icon=src.Character.icon
			src.TakeKiPercent(0)
			src.UpdatePartyIcon()
			src.UpdateFaceHUD()
			PlaySound(view(),'Descend.ogg')
			src.CheckHairstyle()
		src.CoolDown5=0
		src.DeleteSSAura()
		src.DeleteWAura()
		src.DeleteRAura(src)
		src.DeleteGAura()
		src.DeletePAura()
		src.DeleteBlackAura()
		src.RemoveBlueAura(src)
		src.RemoveBlueAura()
		src.RemoveBlueAura2()
		src.DeleteRoseAura()
		src.RemoveGodAura(src)
		usr<<sound(null,channel=2)
		src.Transform=0
		src.Normal=1
		if(findtext(src.Character.name,"Cauda"))
			src.TakeTailSS()
			src.TakeTailSS4()
			src.TakeMullets()
			src.GenerateTail()
		if(src.Perk==1)
			if(findtext(src.Character.Race,"Saiyan") || findtext(src.Character.Race,"Half Saiyan") || findtext(src.Character.Race,"Saiyajin"))
				if(src.HasPerk("Guerreiro Lendario") && src.icon!='GokuKaioken.dmi')
					src.DamageMultiplier-=0.05
					src.Perk=0
					src.overlays-=global.koIcon
	//	if(src.Training=="Focus Training")	src.AddAura()
	FullTransform()
		set hidden=1
		if(src.Shocking!=0)	return
		if(src.Breaker==1)	return
		if(src.IsUltra==1)	return
		if(src.icon=='Candy.dmi')	return
		if(src.Quest11==2)	return
		if(src.key!="Ccaroto7" && src.Character.name=="Yamcha")
			return
		if(src.Frozen==1)	return
		var/NewLevel=0
		if(src.MajinForm==1)	return
		if(src.y>=360 && usr.x<222 && src.z==8)	return
		if(src.Kaioken==1)
			usr<<"<b>Você não pode se transformar em Super Saiyajin enquanto está no estágio de Kaio-Ken!"
			return
		if(src.Skill1==0)
			return
		src=src.GetFusionMob()
		if(!src.CanAct())	return
		var/datum/TransDatum/NewTrans
		var/datum/TransDatum/NextTrans
		src.CompleteTutorial("Transformations")
		for(var/datum/TransDatum/D in src.Character.Transes)	if(src.MaxPL>=D.ReqPL && src.MaxKi>=D.ReqKi && src.Str>=D.ReqStr && src.Def>=D.ReqDef && src.HasKiPercent(60))
			NewLevel+=1;NewTrans=D
			if(src.Character.Transes.len>NewLevel)	NextTrans=src.Character.Transes[NewLevel+1]
			else	NextTrans=null
		if(NewTrans && src.CurTrans<NewLevel)
			src.CurTrans=NewLevel-1
			src.CoolDown5=1
			src.Transform()
			usr.DeleteSSAura()
			usr.DeleteWAura()
			usr.DeleteRAura(src)
			usr.DeleteGAura()
			usr.DeletePAura()
			usr<<sound(null,channel=2)
			if(src.Transform==0)
				if(src.icon=='GogetaSS0.dmi')
					PlaySound(view(),'Gogeta.ogg')
				if(src.icon=='VegitoSS0.dmi')
					PlaySound(view(),'SuperVegito.ogg')
				if(src.icon=='GotenksSS01.dmi')
					PlaySound(view(),'GotenksTransform.ogg')
			else
				if(src.icon=='GotenksSS03.dmi')
					src<<sound(null)
					PlaySound(view(),'GotenksTransform.ogg')
		else	if(NextTrans)
			PlaySound(src,'no.ogg')
			alert("Poder de Luta: [FullNum(NextTrans.ReqPL)] \nKi: [FullNum(NextTrans.ReqKi)] \nForça: [FullNum(NextTrans.ReqStr)] \nDefesa: [FullNum(NextTrans.ReqDef)]","Transformação")
			return
		if(src.Perk==0)
			if(findtext(src.Character.Race,"Saiyan") || findtext(src.Character.Race,"Half Saiyan") || findtext(src.Character.Race,"Saiyajin"))
				if(src.HasPerk("Guerreiro Lendario") && src.icon!='GokuKaioken.dmi' && src.MajinForm==0 && src.Accept==0)
					src.DamageMultiplier+=0.05
					src.Perk=1
					src.overlays+=global.koIcon
		src.Transformed=1
		src.Transform=1
		src.Normal=0
		sleep(10)
		src.Transformed=0
//		if(src.Training=="Focus Training")	src.AddAura()

	Clones()
		set hidden=1
		if(src.Shocking!=0)	return
		if(src.icon=='Candy.dmi')	return
		if(src.Frozen==1)	return
		flick("Guard",usr)
		usr.TakeKiPercent(50)
		var/mob/CombatNPCs/Enemies/Clone/G=new()
		var/mob/CombatNPCs/Enemies/Clone/G2=new()
		G.loc=usr.loc
		G.dir=usr.dir
		if(G.dir==1 || G.dir==2)
			G.x-=1
		else	G.y-=1
		G.Character=usr.Character
		G.icon=usr.icon
		G.AddName("[usr.name]");G.name="[usr.name]"
		G.Team=usr.Team
		usr.Clonagem=1
		G.MaxPL=usr.MaxPL
		G.MaxKi=usr.MaxKi
		G.Str=usr.Str
		G.Def=usr.Def
		G.MaxPL=G.PL
		G.MaxKi=G.Ki
		G.MaxPL/=3
		G.PL/=3
		G.MaxKi/=3
		G.Ki/=3
		G.Str/=3
		G.Def/=3
		G.DamageMultiplier*=0.1
		G.Clonagem=1
		G.Clonagem2=1
		G.Team=usr.Team
		PlaySound(view(),'FusionGTEnds.ogg')
		G.Target=usr.Target
		G.Party=list()
		G.JoinParty(usr)
		G.TargetMob()
		flick("Guard",G)
		walk_towards(G,usr,MovementSpeed)
		G2.loc=usr.loc
		G2.dir=usr.dir
		if(G2.dir==1 || G2.dir==2)
			G2.x+=1
		else	G2.y+=1
		G2.Character=usr.Character
		G2.icon=usr.icon
		G2.AddName("[usr.name]");G2.name="[usr.name]"
		G2.Team=usr.Team
		usr.Clonagem=1
		G2.MaxPL=usr.MaxPL
		G2.MaxKi=usr.MaxKi
		G2.Str=usr.Str
		G2.Def=usr.Def
		G2.MaxPL=G2.PL
		G2.MaxKi=G2.Ki
		G2.MaxPL/=3
		G2.PL/=3
		G2.MaxKi/=3
		G2.Ki/=3
		G2.Str/=3
		G2.Def/=3
		G2.DamageMultiplier*=0.1
		G2.Clonagem2=1
		G2.Clonagem=1
		G2.Team=usr.Team
		PlaySound(view(),'FusionGTEnds.ogg')
		G2.Target=usr.Target
		flick("Guard",G2)
		walk_towards(G2,usr,MovementSpeed)
		usr.Clonagem=1
		usr.CoolDown=1
		usr.DamageMultiplier=0
		sleep(300)
		usr.Clonagem=0
		usr.DamageMultiplier=1
		usr.Party-=G
		usr.Party-=G2
		G.ExitCP();G.LeaveParty()
		G2.ExitCP();G2.LeaveParty()
		del	G
		del	G2
		sleep(900)
		usr.CoolDown=0
	Taiyoken()
		set hidden=1
		if(src.Shocking!=0)	return
		if(src.Frozen==1)	return
		if(src.icon=='Candy.dmi')	return
		if(usr.Target)
			if((abs(usr.x-usr.Target.x<=12) || abs(usr.y-usr.Target.y<=7)))
				var/mob/M=usr.Target
				usr.TakeKiPercent(25)
				flick("Guard",usr)
				M.client.eye=locate(140,255,3)
				PlaySound(view(usr),'recovery.ogg')
				usr.CoolDown2=1
				M<<"<b>[usr.name] utilizou o Taiyo-Ken em você!"
				sleep(50)
				M.client.eye=M.client.mob
				sleep(750)
				usr.CoolDown2=0
	Transform()
		set hidden=1
		if(src.Shocking!=0)	return
		if(src.Breaker==1)	return
		if(src.IsUltra==1)	return
		if(src.icon=='Candy.dmi')	return
		if(src.KK==1)	return
		if(src.icon=='GogetaSSB.dmi')
			src.KK=1
		if(src.key!="Ccaroto7" && src.Character.name=="Yamcha")
			return
		if(src.Quest11==2)	return
		if(src.Frozen==1)	return
		if(src.MajinForm==1)	return
		if(src.Fighting==1)	return
		if(src.y>=360 && usr.x<222 && src.z==8)	return
		if(src.Kaioken==1)
			usr<<"<b>Você não pode se transformar em Super Saiyajin enquanto está no estágio de Kaio-Ken!"
			return
		if(src.Skill1==0 && src.Character.name!="Zamasu" && src.Character.name!="Bills" && src.Character.name!="Omega Shenron" && src.Character.name!="Buu" && src.Character.name!="Videl" && src.Character.name!="Piccolo" && src.Character.name!="Janemba")
			return
		src=src.GetFusionMob()
		if(!src.CanAct())	return
		sleep(5)
		src.CompleteTutorial("Transformations")
		if(src.Character.Transes.len>src.CurTrans)
			if(!src.HasKiPercent(60))
				PlaySound(view(),'PowerUpEnd.ogg')
				return
			var/datum/TransDatum/NextTrans=src.Character.Transes[src.CurTrans+1]
			if(src.MaxPL<NextTrans.ReqPL)
				return
			if(src.MaxKi<NextTrans.ReqKi)
				return
			if(src.Str<NextTrans.ReqStr)
				return
			if(src.Def<NextTrans.ReqDef)
				return
			if(src.CurTrans!=0)
				src.Str/=src.Boost
				src.Def/=src.Boost
				src.MaxPL/=src.Boost
				src.PL/=src.Boost
				src.MaxKi/=src.Boost
				src.Ki/=src.Boost
				src.Boost=1
			src.CurTrans+=1
			src.CalculateTransformations()
			if(src.CurTrans==3)				//QUANDO O JOGADOR TIVER NA SEGUNDA FORMA (SSJ2 INDO PRO 3) E FOR PARA A TERCEIRA, VAI MUDAR O ICONSTATE PRA "transform3"
				flick("transform3",src)
			else
				flick("transform2",src)
			src.CheckHairstyle()
			if(src.CurTrans!=4)
				src.Poeira(src)
				src.Poeira2(src)
			src.ApplyTransDatum()
			if(findtext("[src.icon]","SS1") && src.Character.name=="Goku Mid")	src.GiveMedal(new/obj/Medals/HopeOfTheUniverse)
			else	if(findtext("[src.icon]","SS2"))	src.GiveMedal(new/obj/Medals/Ascended)
			else	if(findtext("[src.icon]","SS3"))	src.GiveMedal(new/obj/Medals/EvenFurtherBeyond)
			else	if(findtext("[src.icon]","SS4"))	src.GiveMedal(new/obj/Medals/SuperSaiyan4)
			else	if(findtext("[src.icon]","SSGodSS1"))	src.GiveMedal(new/obj/Medals/Divine_Blue)
			sleep(8)
			src.UpdateFaceHUD()
			//PlaySound(view(),'ActivateSpecial.ogg')
			for(var/mob/M in oview(1))	if(M.icon_state!="koed")
				if(src.CanPVP(M))
					M.HitStun(5,src)
					src.KnockBack(M,src)
					PlaySound(view(),pick('HitLight1.ogg','HitLight2.ogg'))
		if(src.CurTrans==0)
			return
		src.Transformed=1
		src.DeletePoeira(src)
		DeleteWAura()
		src.RemoveGodAura(src)
		src.RemoveBlueAura(src)
		src.RemoveBlueAura()
		src.RemoveBlueAura2()
		DeleteRAura()
		src.DeleteBlackAura()
		DeleteGAura()
		DeletePAura()
		src.DeleteSSAura()
		if(findtext(usr.Character.name,"Cauda") && src.CurTrans!=4)
			src.TakeTail()
			src.GenerateTailSS()
		else
			if(findtext(usr.Character.name,"Cauda") && src.CurTrans==4)
				src.TakeTail()
				src.TakeTailSS()
				src.GenerateTailSS4()
				src.icon='BaseSaiyaijnSS4.dmi'
		src.BigDust(src)
		if(usr.First>=5)
			usr<<sound(null,channel=2)
		src.Transformed=1
		src.Transform=1
		src.Normal=0
		src.CoolDown5=0
		sleep(3)
		spawn()	src.ScreenShake()
		if(findtext("[src.icon]","SSBlue"))
			src.AddBlueAura()
		else	if(src.Character.Race=="Saiyajin")	src.AddAuraNewSS(src)
		PlaySound(view(),'EnergyStart.ogg')
		src.Transformed=0
		sleep(15)
		src.RemoveAuraNewSS(src)
		src.RemoveBlueAura()
//		if(src.Training=="Focus Training")	src.AddAura()
	Attack(/**/)
		set hidden=1;set instant=1
		if(src.Shocking!=0)	return
		if(src.Frozen==1)	return
		if(src.icon=='Candy.dmi')	return
		if(src.y>=360 && usr.x<222 && src.z==8)	return
		if(src.Fighting==1)
			src.Attack+=1
			return
		src=src.GetFusionMob()
		if(src.GuardTapping)
			src.GuardTapping=0
			src.GuardTapCooling=1
			spawn(6)	src.GuardTapCooling=0
		if(!src.CanAct())	return
		//if("G" in src.KeysTapped)	return
		var/MaxCombo=5;if(src.HasPerk("Repulsao"))	MaxCombo=4
		//if(src.PL/src.MaxPL*100<25 && src.HasPerk("Anger Unleashed"))	MaxCombo=999999
		if(src.ComboCount>=MaxCombo)	return
		src.CompleteTutorial("Attacking")
		PlaySound(view(),pick('Swing1.ogg','Swing2.ogg','Swing3.ogg'))
		var/AttackTime=3
		if(src.HasPerk("Inabalavel"))	AttackTime=6
		if(src.HasPerk("Ataques Sonicos"))	AttackTime=2
		src.Attacking=1;spawn(AttackTime)	src.Attacking=0
		var/list/L=list("punch1","punch2","kick1")-src.LastAttack
		var/ThisAttack=pick(L);src.LastAttack=ThisAttack
		flick(ThisAttack,src)
		src.ComboCount+=1;var/ThisCombo=src.ComboCount
		var/ComboCoolDown=5
		if(src.HasPerk("Ataques Sonicos"))	ComboCoolDown=10
		if(src.ComboCount>=MaxCombo)	spawn(10)	src.ComboCount=0
		else	spawn(ComboCoolDown)	if(src.ComboCount==ThisCombo)	src.ComboCount=0
		if(src.ComboCount==1 && src.Target && MyGetDist(src,src.Target)==1)	src.dir=get_dir(src,src.Target)
		if(src.ComboCount==MaxCombo && src.Target && MyGetDist(src,src.Target==1) && src.HasPerk("Objetivo Final"))	src.dir=get_dir(src,src.Target)
		var/turf/GetStep=get_step(src,src.dir);src.DestroyCheck(GetStep)
		for(var/obj/Training/TimedAttacks/T in GetStep)	T.Attacked(src)
		for(var/mob/M in GetStep)	if(M.density==src.density)
			if(M.icon_state=="koed")	continue
			if(!src.CanPVP(M))	continue
			if(!M.CanBeHit())	continue
			src.TargetMob(M);M.TargetMob(src)
			M.dir=get_dir(M,src)
			var/Sound2Play='Hit3.ogg'
			switch(src.ComboCount)
				if(1)	Sound2Play='Hit3.ogg'
				if(2,4)	Sound2Play='Hit0.ogg'
				if(3)	Sound2Play='Hit4.ogg'
				else	Sound2Play=pick('Hit3.ogg','Hit0.ogg','Hit4.ogg')
			if(src.ComboCount>=MaxCombo)	Sound2Play=pick('strongkick.ogg','HitHeavy.ogg')
			PlaySound(view(),Sound2Play)
			if(M.GuardTap(src))	continue
			if(!M)	return
			if(src.HasPerk("Controle Vingativo"))
				src.AddKiPercent(10)
			else	src.AddKiPercent(5)
			if(src.HasPerk("Canalizador de Ki"))	src.AddKiPercent(1)
			if(M.icon_state=="Guard" && M.key!="Hkl" && M.key!="RLKS" && M.key!="Eventer" && M.key!="Rafafa47" && M.key!="DraguunnoNeko")
				ShowEffect(M,"HyperCombat",16,16)
				M.Blocked("Melee",src)
				M.AddKiPercent(1)
				continue
			if(M.icon_state=="Guard" && (M.key=="Hkl" || M.key=="RLKS" || M.key=="Eventer" || M.key=="Rafafa47" || M.key=="DraguunnoNeko"))
				ShowEffect(M,"HyperCombat",16,16)
				M.Blocked("Melee",src,2)
				M.AddKiPercent(1)
				continue
			var/furia=pick(1,2,3,4,5,6)
			if(furia==1)
				if(src.Fury!=100)
					src.Fury++
			if(M.Attacking)
				ShowEffect(M,"HyperCombat",16,16)
			else
				if(M.HasPerk("Vou ate o Fim"))
					var/Rand=pick(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20)
					if(Rand==1)
						M.AddShock()
						PlaySound(view(),'HitHeavy.ogg')
						sleep(10)
						M.RemoveShock(M)
						return
				if(M.icon=='Candy.dmi')
					return
				var/BaseDmg=src.Str
				if(src.HasPerk("Guerreiro"))	BaseDmg*=1.1
				if(src.HasPerk("Vontade do Guerreiro Z"))
					if(src.GuardLeft==100)
						BaseDmg*=1.25
				src.StandardDamage(M,BaseDmg,1)
				if(src.HasPerk("Recompensa"))
					if(M.Attacking)		usr.Zenie+=10
					PlaySound(view(M),'Rupee.ogg')
					M.Zenie-=10;src.Zenie+=10;src.TrackStat("Zenie Stolen",10)
					if(src.GetTrackedStat("Zenie Stolen",src.RecordedTracked)==1000)	src.GiveMedal(new/obj/Medals/Thief)
				if(src.HasPerk("Absorvedor"))
					if(M.UseKiPercent(1))
						src.AddKiPercent(1)
						M.TakeKiPercent(1)
				if(src.ComboCount==MaxCombo)	src.Throw(M,5,src.dir)
			if(src.ComboCount==4 && M.ComboCount==4)
				src.Fighting=1
				M.Fighting=1
				var/zap=pick(1,2)
				if(zap==1)
					PlaySound(view(),'Fighting.ogg')
				else	PlaySound(view(),'Battle.ogg')
				while(1)
					if(src.Fighting==1 && M.Fighting==1)
						ShowEffect(src,"HyperCombat",16,16)
						ShowEffect(M,"HyperCombat",16,16)
					src.Ballon+=1
					M.Ballon+=1
					src.icon_state="punch1"
					M.icon_state="punch2"
					if(src.dir==2)
						src.Poeira3(src)
						src.ShockWaveNew(src, 0, -16)
					if(src.dir==1)
						src.Poeira4(src)
						src.ShockWaveNew(src, 0, 16)
					if(M.dir==2)
						M.Poeira3(M)
					if(M.dir==1)
						M.Poeira4(M)
					if(src.dir==4)
						src.Poeira(src)
						src.ShockWaveNew(src, 16)
					if(M.dir==4)
						M.Poeira(M)
					if(src.dir==8)
						src.Poeira2(src)
						src.ShockWaveNew(src, -16)
					if(M.dir==8)
						M.Poeira2(M)
					sleep(7)
					if(src.Fighting==1 && M.Fighting==1)
						ShowEffect(src,"HyperCombat",16,16)
						ShowEffect(M,"HyperCombat",16,16)
					src.icon_state="punch2"
					M.icon_state="kick1"
					if(src.dir==2)
						src.Poeira3(src)
					if(src.dir==1)
						src.Poeira4(src)
					if(M.dir==2)
						M.Poeira3(M)
					if(M.dir==1)
						M.Poeira4(M)
					if(src.dir==4)
						src.Poeira(src)
					if(M.dir==4)
						M.Poeira(M)
					if(src.dir==8)
						src.Poeira2(src)
					if(M.dir==8)
						M.Poeira2(M)
					sleep(7)
					if(src.Fighting==1 && M.Fighting==1)
						ShowEffect(src,"HyperCombat",16,16)
						ShowEffect(M,"HyperCombat",16,16)
					src.icon_state="kick1"
					M.icon_state="punch1"
					if(src.dir==2)
						src.Poeira3(src)
					if(src.dir==1)
						src.Poeira4(src)
					if(M.dir==2)
						M.Poeira3(M)
					if(M.dir==1)
						M.Poeira4(M)
					if(src.dir==4)
						src.Poeira(src)
					if(M.dir==4)
						M.Poeira(M)
					if(src.dir==8)
						src.Poeira2(src)
					if(M.dir==8)
						M.Poeira2(M)
					sleep(7)
					if(src.Fighting==1 && M.Fighting==1)
						ShowEffect(src,"HyperCombat",16,16)
						ShowEffect(M,"HyperCombat",16,16)
					src.icon_state="punch1"
					M.icon_state="punch2"
					if(src.dir==2)
						src.Poeira3(src)
					if(src.dir==1)
						src.Poeira4(src)
					if(M.dir==2)
						M.Poeira3(M)
					if(M.dir==1)
						M.Poeira4(M)
					if(src.dir==4)
						src.Poeira(src)
					if(M.dir==4)
						M.Poeira(M)
					if(src.dir==8)
						src.Poeira2(src)
					if(M.dir==8)
						M.Poeira2(M)
					sleep(7)
					if(src.Fighting==1 && M.Fighting==1)
						ShowEffect(src,"HyperCombat",16,16)
						ShowEffect(M,"HyperCombat",16,16)
					src.icon_state="punch2"
					M.icon_state="kick1"
					if(src.dir==2)
						src.Poeira3(src)
					if(src.dir==1)
						src.Poeira4(src)
					if(M.dir==2)
						M.Poeira3(M)
					if(M.dir==1)
						M.Poeira4(M)
					if(src.dir==4)
						src.Poeira(src)
					if(M.dir==4)
						M.Poeira(M)
					if(src.dir==8)
						src.Poeira2(src)
					if(M.dir==8)
						M.Poeira2(M)
					sleep(7)
					if(src.Fighting==1 && M.Fighting==1)
						ShowEffect(src,"HyperCombat",16,16)
						ShowEffect(M,"HyperCombat",16,16)
					src.icon_state="kick1"
					M.icon_state="punch1"
					if(src.dir==2)
						src.Poeira3(src)
					if(src.dir==1)
						src.Poeira4(src)
					if(M.dir==2)
						M.Poeira3(M)
					if(M.dir==1)
						M.Poeira4(M)
					if(src.dir==4)
						src.Poeira(src)
					if(M.dir==4)
						M.Poeira(M)
					if(src.dir==8)
						src.Poeira2(src)
					if(M.dir==8)
						M.Poeira2(M)
					sleep(7)
					if(src.Ballon==2 && M.Ballon==2)
						break
				src.Ballon=0
				M.Ballon=0
				M.Fighting=0
				src.Fighting=0
				M.icon_state=""
				src.icon_state=""
				PlaySound(view(),'HitHeavy.ogg')
				if(src.Attack>M.Attack)
					src.StandardDamage(M,src.Str,1)
					src.Throw(M,5,src.dir)
					src.AddKiPercent(5)
					if(src.Fury!=100)
						src.Fury++
				if(M.Attack>src.Attack)
					M.StandardDamage(src,M.Str,1)
					M.Throw(src,5,M.dir)
					M.AddKiPercent(5)
					if(M.Fury!=100)
						M.Fury++
				src.Attack=0
				M.Attack=0
	StrongAttackNPC(/**/)
		set hidden=1;set instant=1
		if(src.Frozen==1)	return
		if(src.icon=='Candy.dmi')	return
		if(src.Fighting==1)	return
		if(src.y>=360 && usr.x<222 && src.z==8)	return
		src=src.GetFusionMob()
		src.PressKey("S")
		while(!src.CanAct())
			if("S" in src.KeysHeld)	sleep(1)
			else	return
		if(!src.HoldingKey("S"))	return
		src.StrongAttacking=1
		ShowEffect(src,"MeleeCharge",0,0)
		PlaySound(view(),'ActivateSpecial.ogg')
		src.StrongAttackCharge=0
		src.StrongAttacking=rand(1,999999)
		var/ThisAttack=src.StrongAttacking
		while(src.StrongAttackCharge<1 && src.StrongAttacking==ThisAttack)
			src.StrongAttackCharge+=1;sleep(1)
		if(src.StrongAttackCharge>=1)	src.StrongAttackReleaseNPC()
	StrongAttackReleaseNPC()
		set hidden=1;set instant=1
		if(src.Frozen==1)	return
		if(src.icon=='Candy.dmi')	return
		if(src.Fighting==1)	return
		src=src.GetFusionMob();src.StrongAttacking=0;src.ReleaseKey("S")
		for(var/obj/Effect/E in src.loc.contents)	if(E.name=="Effect: MeleeCharge")	{E.loc=null;break}
		if(src.StrongAttackCharge<1)	{src.StrongAttackCharge=0;return}
		else	src.StrongAttackCharge=0
		src.CompleteTutorial("Strong Attacks")
		flick("punch1",src);PlaySound(view(),pick('Swing1.ogg','Swing2.ogg','Swing3.ogg'))
		if(src.Target && MyGetDist(src,src.Target)==1)	src.dir=get_dir(src,src.Target)
		var/turf/GetStep=get_step(src,src.dir);src.DestroyCheck(GetStep)
		for(var/mob/M in GetStep)	if(M.density==src.density)
			if(M.icon_state=="koed")	continue
			if(!src.CanPVP(M))	continue
			if(!M.CanBeHit())	continue
			src.TargetMob(M);M.TargetMob(src)
			M.dir=get_dir(M,src)
			if(M.GuardTap(src))	continue
			PlaySound(view(),pick('HitHeavy.ogg','strongkick.ogg'))
			if(M.icon_state=="Guard")
				if(M.z==3)
					src.StandardDamage(M,src.Str,3)
					src.Throw(M,5,src.dir)
					src.AddKiPercent(10)
					return
				if(src.Shocking==1)
					return
				M.Shocking=1
				src.Shocking=1
				if(M.TeleCountering)
					M.ResetTeleCounters()
				if(M.FusionMob || src.FusionMob)
					src.FusionMob.icon_state="none"
					M.FusionMob.icon_state="none"
				M.DeleteSSAura()
				M.DeleteWAura()
				M.DeleteRAura(M)
				M.DeleteGAura()
				M.DeletePAura()
				src.ShockWaveNew(src)
				M.DeleteBlackAura()
				M.RemoveBlueAura(src)
				M.RemoveBlueAura()
				M.DeleteRoseAura()
				M.RemoveGodAura(src)
				src.DeleteSSAura()
				src.DeleteWAura()
				src.DeleteRAura(src)
				src.DeleteGAura()
				src.DeleteBlackAura()
				src.RemoveBlueAura(src)
				src.RemoveBlueAura()
				src.DeleteRoseAura()
				src.RemoveGodAura(src)
				src.DeletePAura()
				M<<sound(null,channel=2)
				src<<sound(null,channel=2)
				for(var/mob/Player/P in world)
					if(P.z==src.z)
						if((abs(src.x-P.x)<=13 || abs(src.y-P.y)<=8))
							P.CombatShake()
				M.BigDust(M)
				M.RemoveShock(M)
				M.Shocking=1
				src.Shocking=1
				flick("IT",M)
				flick("IT",src)
				PlaySound(view(),'InstantTransmission.ogg')
				src.icon_state="none"
				M.icon_state="none"
				src.AddKiPercent(2)
				PlaySound(view(),'ShockWave.ogg')
				src.name=null
				M.name=null
				M.AddName()
				src.AddName()
				M.TakeHair1()
				M.TakeHair2()
				M.TakeHair3()
				M.TakeHair4()
				M.TakeHairSS3()
				M.TakeMullets()
				if(M.HairStyle==1 && M.CurTrans!=0)
					M.TakeHair1SS()
					M.TakeHair1SS2()
					M.TakeHair1SSBlue()
					M.TakeHair1SS4()
				if(M.HairStyle==2 && M.CurTrans!=0)
					M.TakeHair2SS()
					M.TakeHair2SS2()
					M.TakeHair2SSBlue()
				if(M.HairStyle==3 && M.CurTrans!=0)
					M.TakeHair3SS()
					M.TakeHair3SS2()
					M.TakeHair3SSBlue()
				if(M.HairStyle==4 && M.CurTrans!=0)
					M.TakeHair4SS()
					M.TakeHair4SS2()
					M.TakeHair4SSBlue()
				M.AddShock()
		//		M.Crater(M)
				PlaySound(view(),'explosion.ogg')
				while(1)
					if(M.Shocking%10==0)
						M.AddShock()
						M.Crater(M)
						PlaySound(view(),'Shockwave3.ogg')
					if(M.Shocking%15==0)
						src.ShockWaveNew(src)
						PlaySound(view(),'Shockwave2.ogg')
					M.density=0
					src.icon_state="none"
					M.icon_state="none"
					src.loc=M.loc
					step(M,M.dir,1)
					walk_towards(src,M,0,0.1)
					M.Shocking+=1
					src.Shocking+=1
					if(M.Shocking>=50 || src.Shocking>=50)
						step(M,0,0)
						walk_towards(src,0)
						src.icon_state=""
						M.icon_state=""
						M.Shocking=0
						src.Shocking=0
						M.RemoveShock(M)
						src.name=src.NomeReserva
						M.name=M.NomeReserva
						M.AddName()
						src.AddName()
						if(M.ControlClients && M!=src && M.NPC==0)
				//			M.overlays=null
							M.CheckHairstyle()
							M.RemoveShock(M)
							M.AddName()
							if(findtext(M.Character.name,"Cauda"))
								if(M.CurTrans==0)	M.GenerateTail()
								else
									if(M.CurTrans==4)	M.GenerateTailSS4()
									else	M.GenerateTailSS()
						M.density=1
						src.density=1
						M.PowerUpShake()
						M.ShockWaveNew(M)
						break
					sleep(1)
				M.RemoveShock(M)
				if(M.icon=='GokuSSGodSS1K.dmi')
					M.AddKaiokenEffect()
					M.AddKaiokenAura()
				if(src.icon=='GokuSSGodSS1K.dmi')
					src.AddKaiokenEffect()
					src.AddKaiokenAura()

	StrongAttack(/**/)
		set hidden=1;set instant=1
		if(src.Frozen==1)	return
		if(src.Fighting==1)	return
		if(src.icon=='Candy.dmi')	return
		if(src.y>=360 && usr.x<222 && src.z==8)	return
		if(src.Shocking!=0)	return
		src=src.GetFusionMob()
		src.PressKey("S")
		while(!src.CanAct())
			if("S" in src.KeysHeld)	sleep(1)
			else	return
		if(!src.HoldingKey("S"))	return
		src.StrongAttacking=1
		ShowEffect(src,"MeleeCharge",0,0)
		PlaySound(view(),'ActivateSpecial.ogg')
		src.StrongAttackCharge=0
		src.StrongAttacking=rand(1,999999)
		var/ThisAttack=src.StrongAttacking
		while(src.StrongAttackCharge<10 && src.StrongAttacking==ThisAttack)
			src.StrongAttackCharge+=1;sleep(1)
		if(src.StrongAttackCharge>=10)	src.StrongAttackRelease()
	StrongAttackRelease()
		set hidden=1;set instant=1
		if(src.Frozen==1)	return
		if(src.Fighting==1)	return
		if(src.icon=='Candy.dmi')	return
		if(src.y>=360 && usr.x<222 && src.z==8)	return
		src=src.GetFusionMob();src.StrongAttacking=0;src.ReleaseKey("S")
		for(var/obj/Effect/E in src.loc.contents)	if(E.name=="Effect: MeleeCharge")	{E.loc=null;break}
		if(src.StrongAttackCharge<10)	{src.StrongAttackCharge=0;return}
		else	src.StrongAttackCharge=0
		src.CompleteTutorial("Strong Attacks")
		flick("punch1",src);PlaySound(view(),pick('Swing1.ogg','Swing2.ogg','Swing3.ogg'))
		if(src.Target && MyGetDist(src,src.Target)==1)	src.dir=get_dir(src,src.Target)
		var/turf/GetStep=get_step(src,src.dir);src.DestroyCheck(GetStep)
		for(var/mob/M in GetStep)	if(M.density==src.density)
			if(M.icon_state=="koed")	continue
			if(!src.CanPVP(M))	continue
			if(!M.CanBeHit())	continue
			src.TargetMob(M);M.TargetMob(src)
			M.dir=get_dir(M,src)
			if(M.GuardTap(src))	continue
			PlaySound(view(),pick('HitHeavy.ogg','strongkick.ogg'))
			if(M.icon_state=="Guard")
				if(M.z==3)
					src.StandardDamage(M,src.Str,3)
					src.Throw(M,5,src.dir)
					src.AddKiPercent(10)
					return
				if(src.Shocking==1)	return
				if(M.TeleCountering)
					M.ResetTeleCounters()
				if(M.FusionMob || src.FusionMob)
					src.FusionMob.icon_state="none"
					M.FusionMob.icon_state="none"
				if(src.Shocking==1)
					return
				M.Shocking=1
				src.Shocking=1
				M.DeleteSSAura()
				M.DeleteWAura()
				M.DeleteRAura(M)
				M.DeleteGAura()
				M.DeletePAura()
				src.ShockWaveNew(src)
				src.DeleteSSAura()
				src.DeleteWAura()
				src.DeleteRAura(src)
				src.DeleteGAura()
				src.DeletePAura()
				M<<sound(null,channel=2)
				src<<sound(null,channel=2)
				for(var/mob/Player/P in world)
					if(P.z==src.z)
						if((abs(src.x-P.x)<=13 || abs(src.y-P.y)<=8))
							P.CombatShake()
				M.BigDust(M)
				M.RemoveShock(M)
				flick("IT",M)
				flick("IT",src)
				PlaySound(view(),'InstantTransmission.ogg')
				src.icon_state="none"
				M.icon_state="none"
				src.AddKiPercent(2)
				PlaySound(view(),'ShockWave.ogg')
				src.name=null
				M.name=null
				M.AddName()
				src.AddName()
				M.TakeHair1()
				M.TakeHair2()
				M.TakeHair3()
				M.TakeHair4()
				M.TakeHairSS3()
				M.TakeHair1SS4()
				src.TakeHair1()
				src.TakeHair2()
				src.TakeHair3()
				src.TakeHair4()
				src.TakeHairSS3()
				src.TakeHair1SS4()
				if(M.HairStyle==1 && M.CurTrans!=0)
					M.TakeHair1SS()
					M.TakeHair1SS2()
					M.TakeHair1SSBlue()
				if(M.HairStyle==2 && M.CurTrans!=0)
					M.TakeHair2SS()
					M.TakeHair2SS2()
					M.TakeHair2SSBlue()
				if(M.HairStyle==3 && M.CurTrans!=0)
					M.TakeHair3SS()
					M.TakeHair3SS2()
					M.TakeHair3SSBlue()
				if(M.HairStyle==4 && M.CurTrans!=0)
					M.TakeHair4SS()
					M.TakeHair4SS2()
					M.TakeHair4SSBlue()
				if(src.HairStyle==1 && src.CurTrans!=0)
					src.TakeHair1SS()
					src.TakeHair1SS2()
					src.TakeHair1SSBlue()
				if(src.HairStyle==2 && src.CurTrans!=0)
					src.TakeHair2SS()
					src.TakeHair2SS2()
					src.TakeHair2SSBlue()
				if(src.HairStyle==3 && src.CurTrans!=0)
					src.TakeHair3SS()
					src.TakeHair3SS2()
					src.TakeHair3SSBlue()
				if(src.HairStyle==4 && src.CurTrans!=0)
					src.TakeHair4SS()
					src.TakeHair4SS2()
					src.TakeHair4SSBlue()
				M.AddShock()
//				M.Crater(M)
				PlaySound(view(),'explosion.ogg')
				while(1)
					if(M.Shocking%10==0)
						M.AddShock()
						M.Crater(M)
						PlaySound(view(),'Shockwave3.ogg')
					if(M.Shocking%15==0)
						src.ShockWaveNew(src)
						PlaySound(view(),'Shockwave2.ogg')
					M.density=0
					src.icon_state="none"
					M.icon_state="none"
					src.loc=M.loc
					step(M,M.dir,1)
					walk_towards(src,M,0,0.1)
					M.Shocking+=1
					src.Shocking+=1
					if(M.Shocking>=50 || src.Shocking>=50)
						step(M,0,0)
						walk_towards(src,0)
						src.icon_state=""
						M.icon_state=""
						M.Shocking=0
						src.Shocking=0
						src.name=src.NomeReserva
						M.name=M.NomeReserva
						M.AddName()
						src.AddName()
						src.CheckHairstyle()
						M.CheckHairstyle()
						M.RemoveShock(M)
						if(findtext(M.Character.name,"Cauda"))
							if(M.CurTrans==0)	M.GenerateTail()
							else
								if(M.CurTrans==4)	M.GenerateTailSS4()
								else	M.GenerateTailSS()
						if(findtext(src.Character.name,"Cauda"))
							if(src.CurTrans==0)	src.GenerateTail()
							else
								if(src.CurTrans==4)	src.GenerateTailSS4()
								else	src.GenerateTailSS()
						M.density=1
						src.density=1
						src.PowerUpShake()
						M.PowerUpShake()
						src.ShockWaveNew(src)
						break
					sleep(1)
				if(M.icon=='GokuSSGodSS1K.dmi')
					M.AddKaiokenEffect()
					M.AddKaiokenAura()
				if(src.icon=='GokuSSGodSS1K.dmi')
					src.AddKaiokenEffect()
					src.AddKaiokenAura()
			else
				src.StandardDamage(M,src.Str,1)
				src.Throw(M,5,src.dir)
				src.AddKiPercent(5)
	PowerUp(/**/)
		set hidden=1
		if(src.Frozen==1)	return
		if(src.icon=='Candy.dmi')	return
		if(src.y>=360 && usr.x<222 && src.z==8)	return
		if(src.Shocking!=0)	return
		if(src.Fighting==1)	return
		if(src.Fadiga>=100)
			src<<"Sua fadiga está muito elevada para elevar seu poder! Aperte 'R' para descansar."
			return
		src=src.GetFusionMob()
		if(!src.CanAct())	return
		if(src.PL>=src.MaxPL && src.Ki>=src.MaxKi)	return
		if(src.PoweringUp || src.Training || src.ITing)	return
		src.CompleteTutorial("Power Up")
		src.PoweringUp=1
		if(src.Character.Race=="Saiyajin" && (src.CurTrans>0 && !findtext("[src.icon]","SSBlue")))
			src.AddAuraNewSS(src)
		else
			if(findtext("[src.icon]","SSBlue"))
				src.AddBlueAura()
			else	src.AddAuraNew(src)
		src.AddCharge(src)
		while(src.PoweringUp)
			if(src.Ki>=src.MaxKi && src.PL>=src.MaxPL)
				PlaySound(view(),null,channel=7)
				PlaySound(view(),null,channel=8)
				PlaySound(src,'PowerUpEnd.ogg')
				flick("powerup",src)
				src.RemoveGoldenAura()
				src.DeleteSSAura()
				src.DeleteRoseAura()
				src.RemoveBlueAura()
				src.RemoveCharge(src)
				src.RemoveAuraNew(src)
				src.RemoveAuraNewSS(src)
				src.RemoveBlueAura()
				break
			if(src.icon_state!="powerup")
			//	if(src.icon!='VegetaUSSBlue.dmi' && src.icon!='VegetaUSSBlueB.dmi' && src.icon!='GokuSSGodSS1K.dmi' && src.icon!='VegetaSSGodSS1.dmi' && src.icon!='BVegetaSSGodSS1.dmi' && src.icon!='GokuSSGodSS1.dmi' && src.icon!='GokuKaioken.dmi' && src.icon!='Reaper2.dmi' && src.icon!='Alkaiser Dark-2.dmi' && src.icon!='Darker.dmi' && src.icon!='Darkness Goku.dmi')
			//		src.AddAura()
				src.icon_state="powerup"
				PlaySound(view(),'EnergyStart.ogg',channel=7)
				PlaySound(view(),'EnergyLoop.ogg',repeat=1,channel=8)
			var/PlAmt=1;var/KiAmt=1
			if(src.HasPerk("Carga da Vida"))	{PlAmt*=2;KiAmt/=2}
			if(src.HasPerk("Carga do Ki"))	{PlAmt/=2;KiAmt*=2}
			if(src.NPC==1 || src.key=="Hkl" || src.key=="RLKS" || src.key=="Eventer" || src.key=="Rafafa47" || src.key=="DraguunnoNeko")
				if(src.icon_state=="powerup")	{PlAmt*=2;KiAmt*=2}
			var/PowerPL=0;var/PowerKi=0
			switch(src.PowerMode)
				if("Ambos")	{PowerPL=1;PowerKi=1}
				if("PL, somente")	PowerPL=1
				if("Ki, somente")	PowerKi=1
				if("PL, depois Ki")
					PowerPL=1;if(src.PL>=src.MaxPL)	PowerKi=1
				if("Ki, depois PL")
					PowerKi=1;if(src.Ki>=src.MaxKi)	PowerPL=1
			if(PowerPL)	src.AddPlPercent(PlAmt)
			if(PowerKi)	src.AddKiPercent(KiAmt)
			src.PowerUpShake()
			sleep(1)
		PlaySound(view(),null,channel=7)
		PlaySound(view(),null,channel=8)
		src.DeleteSSAura()
		src.DeleteRoseAura()
		src.RemoveBlueAura()
		src.RemoveCharge(src)
		src.RemoveAuraNew(src)
		src.RemoveAuraNewSS(src)
		src.RemoveAura();src.PowerUpRelease()
		if(src.icon_state=="powerup")	src.ResetIS()
	PowerUpRelease()
		set hidden=1
		if(src.Shocking!=0)	return
		if(src.icon=='Candy.dmi')	return
		if(src.Frozen==1)	return
		if(src.Fighting==1)	return
		if(src.y>=360 && usr.x<222 && src.z==8)	return
		src=src.GetFusionMob()
		src.PoweringUp=0
		src.RemoveCharge(src)
		src.RemoveAuraNew(src)
		src.RemoveAuraNewSS(src)
	Guard(var/ShiftKey as null|num)
		set hidden=1;set instant=1
		if(src.Shocking!=0)	return
		if(src.Frozen==1)	return
		if(src.icon=='Candy.dmi')	return
		if(src.Fighting==1)	return
		if(src.y>=360 && usr.x<222 && src.z==8)	return
		if(usr.Shocking==1)	return
		src=src.GetFusionMob()
		src.PressKey("G")
		if(!src.GuardLeft)	return
		if(src.CounterBeamMob)	return
		if(src.StrongAttacking)	return
		if(src.icon_state=="Guard")	return
		if(src.ButtonComboing || src.Training)	return
		if(src.icon_state=="koed" || src.icon_state=="Beam")	return
		if(src.icon_state=="KnockBack")
			src.TrackStat("Throw Cancels",1)
			if(src.GetTrackedStat("Throw Cancels",src.RecordedTracked)==10)	src.GiveMedal(new/obj/Medals/eBrake)
			src.ThrownDamage=null;src.EndKnockBack()
			PlaySound(view(),'ThrowStop.ogg')
		src.CancelBeamCharge()
		src.CompleteTutorial("Guard")
		src.CompleteTutorial("Start Sparring")
		if(src.PL>0)	src.icon_state="Guard"
	GuardRelease(var/ShiftKey as null|num)
		set hidden=1;set instant=1
		if(src.Frozen==1)	return
		if(src.Fighting==1)	return
		if(src.icon=='Candy.dmi')	return
		if(src.y>=360 && usr.x<222 && src.z==8)	return
		src=src.GetFusionMob()
		if(src.icon_state=="koed" && src.CanRecover)
			src.KoCount+=1
			src.CanRecover=0
			spawn(1)	src.CanRecover=1
			if(src.KoCount>=src.KoTime)	src.KoRecovery()
		else
			if(src.icon_state=="Guard")	src.ResetIS()
			if(!ShiftKey && !src.GuardTapCooling && src.Clonagem2==0)
				src.GuardTapping+=1
				spawn(2)	if(src.GuardTapping>0)	src.GuardTapping-=1
				if(src.Target && src.Target.TeleCountering==src && src.GuardTap(src.Target))	src.Target.ResetTeleCounters()
	KiBlast()
		set hidden=1;set instant=1
		if(src.Fighting==1)	return
		if(src.Frozen==1)	return
		if(src.icon=='Candy.dmi')	return
		if(src.Shocking!=0)	return
		if(src.y>=360 && usr.x<222 && src.z==8)	return
		src=src.GetFusionMob()
		if(!src.CanAct())	return
		var/Damage
		if(src.KbType=="HealingKB")
			Damage=src.UsePlPercent(10)
			src.PL=max(1,src.PL)
		else
			var/KiReq=10
			if(src.KbType=="HomingKB")	KiReq=20
			Damage=src.UseKiPercent(KiReq)
		if(!Damage)	{PlaySound(src,'PowerUpEnd.ogg');return}
		src.Charging=1
		spawn(2)	src.Charging=0
		if(src.icon!='Android16.dmi')	PlaySound(view(),pick('KiBlast1.ogg','KiBlast2.ogg'))
		if(src.icon=='Android16.dmi')	PlaySound(view(),pick('Fire1.ogg','Fire2.ogg'))
		var/BlastHand=(src.LastBlast ? "KiBlast2" : "kiblast")
		src.LastBlast=!src.LastBlast
		flick("[BlastHand]",src)
		var/obj/Blasts/KiBlast/K=new(src,Damage,src.KbType)
		K.pixel_x=src.GetBlastOffX()
		K.pixel_y=src.GetBlastOffY()
	ChargeBeam()
		set hidden=1
		if(src.Fighting==1)	return
		if(src.Shocking!=0)	return
		if(src.icon=='Candy.dmi')	return
		if(src.Frozen==1)	return
		if(src.y>=360 && usr.x<222 && src.z==8)	return
		src=src.GetFusionMob()
		if(src.icon=='BlackGoku.dmi')
			src.Character.BeamSpecial=new/CharSpecials/Dark
		if(src.icon=='BlackGokuRose.dmi')
			src.Character.BeamSpecial=new/CharSpecials/Rose
		//KAMEHAMEHA
		if(usr.NPC==0)
			if(usr.Character.name=="Goku" || usr.Character.name=="Goku2" || usr.Character.name=="Goku Super" || usr.Character.name=="GT Goku" || usr.Character.name=="Adult Piccolo Gohan" || usr.Character.name=="Mystic Gohan" || usr.icon=='TeenGohanSS2.dmi' || usr.Character.name=="Yamcha" || usr.Character.name=="Master Roshi" || usr.Character.name=="Krillin" || usr.Character.name=="Goten" || usr.Character.name=="Pan" || usr.Character.name=="Uub" || usr.icon=='Cell.dmi' || usr.Character.name=="Cell Jr")
				if(usr.Skill3==0)
					return
		//MASENKO
			if(usr.Character.name=="Gohan" || usr.icon=='FutureGohanAftermatchSS.dmi' || usr.icon=='TeenGohan.dmi' || usr.icon=='TeenGohanSS1.dmi')
				if(usr.Skill6==0)
					return
		//BIG BANG ATTACK
			if(usr.icon=='SAVegeta.dmi' || usr.icon=='SAVegetaSS1.dmi' || usr.icon=='AltVegetaSS2.dmi' || usr.icon=='AltVegeta.dmi' || usr.icon=='GTVegeta.dmi' || usr.icon=='GTVegetaSS1.dmi' || usr.icon=='AltGTVegeta.dmi' || usr.icon=='AltGTVegetaSS1.dmi' || usr.icon=='Vegito.dmi' || usr.icon=='VegetaSSGodSS1.dmi')
				if(usr.Skill7==0)
					return
		//FINAL FLASH
			if(usr.icon=='SAVegetaUSS1.dmi' || usr.icon=='VegetaSS1.dmi' || usr.icon=='VegetaMajinSS1.dmi' || usr.icon=='AltVegetaMajinSS2.dmi')
				if(usr.Skill8==0)
					return
		//GARLIC GUN
			if(usr.icon=="Scouter Vegeta" || usr.icon=='Vegeta.dmi' || usr.icon=="King Vegeta")
				if(usr.Skill9==0)
					return
		//SPECIAL BEAM CANNON
			if(usr.icon=="Piccolo" || usr.icon=='CellForm2.dmi' || usr.icon=='CellPerfectForm.dmi' || usr.icon=="King Piccolo")
				if(usr.Skill10==0)
					return
		//KIKOHO
			if(usr.icon=="Tien")
				if(usr.Skill11==0)
					return
		//DEATH BEAM
			if(usr.Character.name=="Chiaotzu" || usr.Character.name=="Nail" || usr.Character.name=="Lord Slug" || usr.Character.name=="Saibaman" || usr.Character.name=="Burter" || usr.Character.name=="Jeice" || usr.Character.name=="Henchman" || usr.Character.name=="Zarbon" || usr.Character.name=="Dodoria" || usr.Character.name=="Freeza" || usr.Character.name=="Cooler" || usr.Character.name=="Android 18" || usr.Character.name=="Android 17" || usr.Character.name=="Dabura" || usr.Character.name=="Babidi" || usr.Character.name=="Buu" || usr.Character.name=="Salza")
				if(usr.Skill13==0)
					return
		//BURNING ATTACK
			if(usr.icon=='TrunksSS1.dmi' || usr.icon=='LTrunksSS1.dmi')
				if(usr.Skill16==0)
					return
		//BUSTER CANNON
			if(usr.Character.name=="Future Trunks" || usr.Character.name=="GT Trunks" || usr.icon=='Trunks.dmi' || usr.icon=='Trunks Editado.dmi' || usr.icon=='SATrunks.dmi' || usr.icon=='SATrunksSS1.dmi' || usr.icon=='BojackTrunks.dmi')
				if(usr.Skill17==0)
					return
		//FINISH BUSTER
			if(usr.icon=='SATrunksUSS1.dmi' || usr.icon=='BojackTrunksSS1.dmi')
				if(usr.Skill18==0)
					return
		//FINAL SHINE
			if(usr.icon=='VegetaSS4.dmi')
				if(usr.Skill19==0)
					return
		//10X KAMEHAMEHA
			if(usr.icon=='AltGokuSS4.dmi' || usr.icon=='GokuSS4.dmi')
				if(usr.Skill23==0)
					return
		if(!src.CanAct())	return
		if(src.CounterBeam())	return
		if(!src.UseKiPercent(20))	{PlaySound(src,'PowerUpEnd.ogg');return}
		if(src.HasPerk("Flash Finish"))	src.icon_state="charge"
		else
			src.Charging=1;src.icon_state="charge"
			if(src.icon=='VegetaSSGodSS.dmi')
				src.overlays+=BBD
				src.overlays+=BBE
			else
				src.overlays-=BBD
				src.overlays-=BBE
			src.ForceBeamBattles()
			var/CharSpecials/ThisSpecial=src.GetBeamSpecial()
			PlaySound(view(),ThisSpecial.ChargeSound,channel=5,VolChannel="Voice")
			PlaySound(view(),'EnergyLoop.ogg',repeat=1,channel=8,VolChannel="Effect")
			src.BeamOverCharge=0
			for(var/i=1;i<=ThisSpecial.ChargeTime+20;i++)
				if(src.icon_state!="charge")
					break
				if(i>ThisSpecial.ChargeTime)
					if(!src.Charging)	break
					else
						if(!src.UseKiPercent(1))	break
						else	src.BeamOverCharge+=1
				sleep(1)
			while(src.Charging && (src.HasPerk("Supressao do Ki") || src.HasPerk("KaMeHaMeHa Evasivo")))
				if(src.BeamOverCharge!=20)	break
				if(src.CounterBeamMob)	break
				sleep(1)
			if(ThisSpecial.ChargeTime+src.BeamOverCharge<10)
			//	PlaySound(view(),'ActivateSpecial.ogg')
				sleep(10-(ThisSpecial.ChargeTime+src.BeamOverCharge))
			PlaySound(view(),null,channel=8)
		if(!src.HitStun && src.icon_state=="charge")
			src.ForceBeamBattles()
			src.Beam()
			if(src.icon=='VegetaSSGodSS.dmi')
				src.overlays-=BBD
				src.overlays-=BBE

	ChargeBeamRelease()
		set hidden=1
		if(src.Frozen==1)	return
		if(src.Fighting==1)	return
		if(src.icon=='Candy.dmi')	return
		if(src.y>=360 && usr.x<222 && src.z==8)	return
		src=src.GetFusionMob()
		src.Charging=0
	Fly()
		set hidden=1
		if(src.Fighting==1)	return
		if(src.Shocking!=0)	return
		if(src.Frozen==1)	return
		if(src.y>=360 && usr.x<222 && src.z==8)	return
		src=src.GetFusionMob()
		if(src.icon_state=="Guard" || src.icon_state=="charge")	src.dir=NORTH
		if(src.icon_state=="powerup" || src.Training)	return
		if(src.InTournament)	return
		if(!src.CanAct())	return
		if(src.density)
			src.density=0;src.layer=6
			step(src,NORTH)
			src.icon_state="fly"
			src.overlays+=FlightShadow
			PlaySound(view(),'Jump.ogg')
	Land()
		set hidden=1
		if(src.Fighting==1)	return
		if(src.Frozen==1)	return
		if(src.Shocking!=0)	return
		if(src.y>=360 && usr.x<222 && src.z==8)	return
		src=src.GetFusionMob()
		if(src.icon_state=="Guard" || src.icon_state=="charge")	src.dir=SOUTH
		if(src.icon_state=="powerup" || src.Training)	return
		if(!src.CanAct())	return
		if(!src.density)
			step(src,SOUTH)
			flick("land",src)
			ForceCancelFlight()
			src.CompleteTutorial("Flight")
			if(src.Character.name!="Broly" && src.Character.name!="Cell" && src.Character.name!="Janemba" && src.Character.name!="Cell Jr")
				PlaySound(view(),'GroundHit.ogg')
			else	PlaySound(view(),'CellStep.ogg')
	Rest()
		set hidden=1
		if(src.Fighting==1)	return
		if(src.Frozen==1)	return
		if(src.icon=='Candy.dmi')	return
		if(src.Shocking!=0)	return
		if(src.CoolDown3==1)	return
		if(src.PoweringUp==1)	return
		if(src.icon_state=="koed")	return
		else
			src.CoolDown3=1
			while(1)
				src.icon_state="powerup"
				src.X1=1
				src.Fadiga-=pick(10,20,30)
				if(src.Fadiga<=0)
					src.Fadiga=0
					src.CoolDown3=0
					src.X1=0
					src.icon_state=""
					break
				sleep(20)

