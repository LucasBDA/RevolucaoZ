mob/proc/HitStun(var/StunTime,var/mob/Stunner)
	src.DropFlag("Atacado por [Stunner]")
	if(src.icon_state=="koed")	return
	if(src.Ki<src.MaxKi*20/100)	if(findtext(src.Character.Race,"Saiyan") || findtext(src.Character.Race,"Half Saiyan") || findtext(src.Character.Race,"Saiyajin"))
		if(!src.HasPerk("Canalizador de Poder") && src.MajinForm==0)
			if(src.icon=='MysticGohanMystic.dmi')
				goto IR
			src.Revert()
	IR
	if(src.HasPerk("Inabalavel"))	return
	src.HitStun+=1
	if(src.CounterBeamMob)
		var/mob/M=src.CounterBeamMob
		src.CounterBeamMob=null;M.HitStun(0,Stunner)
	flick("HitStun",src)
	src.PowerUpRelease()
	src.CancelBeamCharge()
	src.StrongAttackRelease()
	var/furia=pick(1,2,3,4,5,6)
	if(furia==1)
		if(src.Fury!=100)
			src.Fury++
	if(src.Ki<=0 && Stunner && Stunner.HasPerk("Esmagador de Ki"))	StunTime*=2
	spawn(StunTime)	src.HitStun-=1
	src.ResetIS()
	return 1

mob/proc/CancelBeamCharge(/**/)
	if(src.icon_state=="charge" || src.icon_state=="charge2")
		src.Charging=0;src.ResetIS()
		PlaySound(view(),null,channel=5)

mob/proc/CounterBeam(var/mob/TauntTarget)
	for(var/mob/M in oview(src))
		if(M.icon_state=="charge")	if(!TauntTarget || M==TauntTarget)
			if(get_dist(src,M)>=3 && (M.x==src.x || M.y==src.y) && src.CanPVP(M))
				src.Charging=1
				M.CounterBeamMob=src
				src.CounterBeamMob=M
				src.dir=get_dir(src,M)
				if(src.icon=='BlackGoku.dmi')
					src.icon_state="charge2"
				else
					src.icon_state="charge"
				return 1

mob/proc/CanAct(/**/)
	if(src.Frozen==1)	return
	if(src.HitStun)	return
	if(src.icon=='GogetaSSB.dmi' && (src.icon_state=="Kaioken" || src.icon_state=="Kaioken2"))	return
	if(src.ThrownBy)	return
	if(src.Charging)	return
	if(src.GhostMode)	return
	if(src.Quest11==1)	return
	if(src.Attacking)	return
	if(src.PoweringUp)	return
	if(src.Countering)	return
	if(src.ButtonComboing)	return
	if(src.StrongAttacking)	return
	if(src.TeleCounteringID)	return
	if(src.icon_state=="koed")	return
//	if(src.Shocking==1)	return
	if(src.Fighting==1) return
	if(src.icon_state=="Beam")	return
	if(src.icon_state=="ultra")	return
	if(src.icon_state=="Beam2")	return
	if(src.icon_state=="GenkiDamaCharge")	return
	if(src.icon_state=="Fusion")	return
	if(src.icon_state=="Potara")	return
	if(src.icon_state=="Guard")	return
	if(src.X1==1)	return
	if(src.icon_state=="charge" || src.icon_state=="charge2")	return
	if(src.SparCmds && src.SparCmds.len)	return
	if(global.TournStatus=="Face-Off" && src.InTournament)	return
	return 1

mob/proc/AddZenie(var/Zenie2Add)
	src.Zenie+=Zenie2Add;src.TrackStat("Zenie Collected",Zenie2Add)

mob/proc/AddExp(var/Exp2Add,var/Reason)
	return
	if(Exp2Add<=0)	return
	for(var/client/C in src.ControlClients)
		Exp2Add=Exp2Add/src.ControlClients.len
		if(C.mob.HasPerk("Jovem Aprendiz"))	Exp2Add*=1.1
		if(C.mob.HasPerk("Treinamento Intenso"))	Exp2Add*=1.1
		if(C.mob.HasClanUpgrade("Fast Track"))	Exp2Add+=Exp2Add*C.mob.HasClanUpgrade("Fast Track")*0.02

		C.mob.Exp+=round(Exp2Add)
		C.mob.LevelCheck(Reason)

mob/proc/AddPlPercent(var/Percent)
	src.PL+=round(src.MaxPL*Percent/100)
	src.PL=min(src.PL,src.MaxPL)
	src.UpdatePlHUD()
	if(round(src.PL/src.MaxPL*100)<=20)	src.ShowTutorial(Tutorials["Power Up"])

mob/proc/UsePlPercent(var/Percent)
	var/AmtNeeded=round(src.MaxPL*Percent/100)
	if(src.PL<AmtNeeded)	return
	src.PL-=AmtNeeded
	src.UpdatePlHUD()
	if(round(src.PL/src.MaxPL*100)<=20)	src.ShowTutorial(Tutorials["Power Up"])
	return AmtNeeded

mob/proc/TakePlPercent(var/Percent)
	src.PL-=round(src.MaxPL*Percent/100)
	src.PL=max(0,src.PL)
	src.UpdatePlHUD()

mob/proc/AddKiPercent(var/Percent)
	src.Ki+=round(src.MaxKi*Percent/100)
	src.Ki=min(src.Ki,src.MaxKi)
	src.UpdateKiHUD()
	if(round(src.Ki/src.MaxKi*100)<=20)	src.ShowTutorial(Tutorials["Power Up"])

mob/proc/HasKiPercent(var/Percent)
	var/KiNeeded=round(src.MaxKi*Percent/100)
	if(src.Ki<KiNeeded)	return
	else	return 1

mob/proc/HasPlPercent(var/Percent)
	var/KiNeeded=round(src.MaxPL*Percent/100)
	if(src.PL<KiNeeded)	return
	else	return 1

mob/proc/TakeKiPercent(var/Percent)
	src.Ki-=round(src.MaxKi*Percent/100)
	src.Ki=max(0,src.Ki)
	src.UpdateKiHUD()

mob/proc/UseKiPercent(var/Percent)
	var/KiNeeded=round(src.MaxKi*Percent/100)
	if(src.Ki<KiNeeded)	return
	src.Ki-=KiNeeded
	src.UpdateKiHUD()
	if(round(src.Ki/src.MaxKi*100)<=20)	src.ShowTutorial(Tutorials["Power Up"])
	return KiNeeded

mob/var/KoTime
mob/proc/KnockOut(var/mob/Killer,var/Cause)
	if(src.PL<=0)
		if(src.icon_state=="koed")	return
		if(src.HasPerk("Espirito de Lutador"))	return
		if(src.MajinForm==0)
			src.Revert()
		src.KoTime=10
		src.KoCount=0
		src.icon_state="koed"
		src.Ki=0;src.UpdateKiHUD()
		src.ShowTutorial(Tutorials["KO Recovery"])
		if(Killer)
			Killer.ShowTutorial(Tutorials["Finishers"])
			if(src.HasPerk("Espirito do Guerreiro"))	src.KoTime/=2
			if(Killer.HasPerk("Esmagador de Espirito"))	src.KoTime*=2
			if(Killer.HasPerk("Modo Adrenalina 2"))
				Killer.AddKiPercent(10)
				Killer.AddPlPercent(10)

mob/proc/KoRecovery()
	src.CompleteTutorial("KO Recovery")
	var/RecoveryPercent=20;if(src.HasPerk("Instinto de Saiyajin"))	RecoveryPercent*=2
	src.AddPlPercent(RecoveryPercent)
	src.AddKiPercent(RecoveryPercent)
	src.ResetIS()

mob/proc/DeathCheck(var/mob/Killer,var/DeathTag="by an Unknown Force?",var/DamageType)
	if(src.PL<=0)
		Killer.CompleteTutorial("Finishers")
		if(Killer.HasPerk("Modo Adrenalina"))
			Killer.AddKiPercent(10)
			Killer.AddPlPercent(10)
		var/DeathMode="Morte"
		if(src.Dueling)
			if(src.DuelFlag)
				src.TrackStat("[src.DuelFlag.DuelType] Duels Lost",1)
				src.Dueling.TrackStat("[src.DuelFlag.DuelType] Duels Won",1)
			src<<"Fim do duelo! Você perdeu..."
			src.Dueling<<"Fim do duelo! Você ganhou!"
			src.Dueling.AddExp(50000,"PvP Kills")
			if(src.Quest2>1)
				src.Dueling.AddExp(100000*src.Quest2,"Recompensas por Cabeça")
				src.Dueling.Zenie+=2000*src.Quest2
				src.Dueling<<"<b>Você ganhou Níveis e Zennies pela morte de [src]!"
				world<<"<b><i><font color=red>[src.Dueling] acabou com a fama de Assassino de [src]!"
				Assassinos-=src
			src.Quest2=0
			src.Dueling.Quest2+=1
			if(src.DuelFlag)	DeathMode="Duelo no modo '[src.DuelFlag.DuelType]'"
			else	DeathMode="??? Duel"
			src.Dueling.GiveMedal(new/obj/Medals/Duelicious)
			src.EndDuel()
		if(src.ControlClients)
			if(!Killer)
				src.TrackStat("Deaths by Mysterious Strangers?",1)
				if(src.gender=="female")
					world<<"<b><font color=black>Morte:<font color=red> [src] foi morta por um estranho?"
				else	world<<"<b><font color=black>Morte:<font color=red> [src] foi morto por um estranho?"
			else
				if(src.InstanceObj && src.InstanceObj.PvpType)
					src.TrackStat("[initial(src.InstanceObj.name)] Deaths",1)
					Killer.TrackStat("[initial(src.InstanceObj.name)] Kills",1)
					DeathMode=initial(src.InstanceObj.name)
					if(istype(src.InstanceObj,/obj/TurfType/Instances/GenericInstance))	DeathMode=src.InstanceObj.name
					if(src.gender=="female")
						world<<"<b><font color=black>Morte:<font color=red> [src] foi morta por [Killer]"
					else	world<<"<b><font color=black>Morte:<font color=red> [src] foi morto por [Killer]"
					Killer.AddExp(50000,"PvP Kills")
					if(src.Quest2>1)
						Killer.AddExp(100000*src.Quest2,"Recompensas por Cabeça")
						world<<"<b><i><font color=red>[Killer] acabou com a fama de Assassino de [src]!"
						Killer.Zenie+=2000*src.Quest2
						Killer<<"<b>Você ganhou Níveis e Zennies pela morte de [src]!"
						Assassinos-=src
					src.Quest2=0
					Killer.Quest2+=1
					Killer.Talked7+=1
					src.Talked7-=1
				else
					if(Killer==src)
						src.TrackStat("Deaths [DeathTag]",1)
						if(src.gender=="female")
							world<<"<b><font color=black>Morte:<font color=red> [src] foi morta por [DeathTag]"
						else	world<<"<b><font color=black>Morte:<font color=red> [src] foi morto por [DeathTag]"
					else
						if(Killer.ControlClients)
							src.TrackStat("Deaths by PvP",1)
							src.Talked7-=1
							Killer.TrackStat("PvP Kills",1)
							Killer.Talked7+=1
							Killer.AddExp(50000,"PvP Kills")
							if(src.key in Killer.Friends)
								if(Killer.Talked4==1)
									Killer.Quest5+=1
						else	src.TrackStat("Deaths by NPC",1)
						if(src.InTournament)	DeathMode="Torneio de Artes Marciais:"
						if(Killer.name=="KiBlaster")
							if(src.gender=="female")
								world<<"<b><font color=black>Morte:<font color=red> [src] foi morta em um Treinamento de Ki!"
							else	world<<"<b><font color=black>Morte:<font color=red> [src] foi morto em um Treinamento de Ki!"
						else
							if(src.gender=="female")
								world<<"<b><font color=black>Morte:<font color=red> [src] foi morta por [Killer]"
							else	world<<"<b><font color=black>Morte:<font color=red> [src] foi morto por [Killer]"
						Killer.Talked7+=1
						src.Talked7-=1
			var/GoGhostMode
			if(src.CurrentMission)	GoGhostMode=1
			if(src.EmEvento==1)	GoGhostMode=1
			if(src.InstanceObj && src.InstanceObj.DeathMode=="Ghost")	GoGhostMode=1
			if(GoGhostMode)	src.GhostMode()
			else
				src.ExitCP()
				src.IsDead=1
				src.overlays=null
				src.icon_state=""
				src.Pessoas=0
				src.Skill25=0
				src.Charging=0
				src.overlays-=global.Halo
				src.overlays+=global.Halo
				src.CancelButtonCombo()
				src.loc=locate(14,14,3)
				src.LoseTournRound("Derrotado",Killer)
				src.ShowTutorial(Tutorials["Alpha Revival"])
				src.AddName()
				src.AddClanName()
		else
			if(Killer.Owner)	Killer.Owner.TrackStat("Companion Kills",1)
			Killer.TrackStat("NPCs Killed",1)
			if(src.Zens==666)
				if(Killer.EmEvento==1)
					Inimigos+=1
			if(src.name=="Raditz")
				if(Killer.Mission==1)
					Killer<<"<b><font color=[rgb(18,255,3)]>Parabéns, [Killer.name]! Você derrotou o [src.name]! Volte e fale com o Mestre Kame para dar prosseguimento às suas missões."
					Killer.Mission=0
					Killer.AddExp(round(15*100),"Missão")
					if(Killer.Character.name=="Goku" || Killer.Character.name=="Goku Super" || Killer.Character.name=="GT Goku" || Killer.Character.name=="Goku2")
						if(Killer.Skill3==0)
							Killer.Skill3=1
							world<<"<b><font color=[rgb(94,164,221)]>[Killer.name] desbloqueou a Técnica 'Kamehameha'!"
					if(Killer.Character.name=="Piccolo")
						if(Killer.Skill10==0)
							Killer.Skill10=1
							world<<"<b><font color=[rgb(94,164,221)]>[Killer.name] desbloqueou a Técnica 'Makankosappo'!"
					for(var/obj/Items/Missoes/Saibaman/R in AllMissoes)
						Killer.MissionBag+=new R.type
						R.Collect(Killer)
			if(src.name=="Saibaman")
				if(Killer.Mission==2)
					Killer.Saibaman+=1
					Killer<<"<b><font color=[rgb(18,160,200)]>Saibamans derrotados ([Killer.Saibaman]/5)"
					if(Killer.Saibaman==5)
						Killer.AddExp(round(15*100),"Missão")
						Killer<<"<b><font color=[rgb(18,255,3)]>Parabéns, [Killer.name]! Você derrotou os Saibamans! Volte e fale com o Mestre Kame para dar prosseguimento às suas missões."
						Killer.Mission=0
						for(var/obj/Items/Missoes/Nappa/R in AllMissoes)
							Killer.MissionBag+=new R.type
							R.Collect(Killer)
			if(src.name=="Nappa")
				if(Killer.Mission==3)
					Killer<<"<b><font color=[rgb(18,255,3)]>Parabéns, [Killer.name]! Você derrotou o [src.name]! Volte e fale com o Mestre Kame para dar prosseguimento às suas missões."
					Killer.Mission=0
					Killer.AddExp(round(25*100),"Missão")
					if(Killer.Character.name=="Teen Gohan" || Killer.Character.name=="Gohan" || Killer.Character.name=="Mystic Gohan" || Killer.Character.name=="Adult Piccolo Gohan")
						if(Killer.Skill6==0)
							Killer.Skill6=1
							world<<"<b><font color=[rgb(94,164,221)]>[Killer.name] desbloqueou a Técnica 'Masenko'!"
							//alert("Você aprendeu a Técninca 'Masenko'!","Técnica")
					for(var/obj/Items/Missoes/Vegeta/R in AllMissoes)
						Killer.MissionBag+=new R.type
						R.Collect(Killer)
			if(src.name=="Vegeta Rastreador")
				if(Killer.Mission==4)
					Killer<<"<b><font color=[rgb(18,255,3)]>Parabéns, [Killer.name]! Você derrotou o [src.name]! Volte e fale com o Mestre Kame para dar prosseguimento às suas missões."
					Killer.Mission=0
					Killer.AddExp(round(35*100),"Missão")
					if(Killer.Character.name=="Vegeta" || Killer.Character.name=="Vegeta2" || Killer.Character.name=="Alternate GT Vegeta" || Killer.Character.name=="Saiyan Armor Vegeta")
						if(Killer.Skill9==0)
							Killer.Skill9=1
							world<<"<b><font color=[rgb(94,164,221)]>[Killer.name] desbloqueou a Técnica 'Galick Ho'!"
							Killer<<sound('BleepBloop.ogg',channel=1)
					for(var/obj/Items/Missoes/Patriarca/R in AllMissoes)
						Killer.MissionBag+=new R.type
						R.Collect(Killer)
			if(src.name=="Guldo")
				if(Killer.Mission==7)
					Killer<<"<b><font color=[rgb(18,255,3)]>Parabéns, [Killer.name]! Você derrotou o [src.name]! Volte e fale com o Grande Patriarca para dar prosseguimento às suas missões."
					Killer.Mission=0
					Killer.AddExp(round(43*100),"Missão")
					for(var/obj/Items/Missoes/Recoome/R in AllMissoes)
						Killer.MissionBag+=new R.type
						R.Collect(Killer)
			if(src.name=="Recoome")
				if(Killer.Mission==8)
					Killer.AddExp(round(50*100),"Missão")
					Killer<<"<b><font color=[rgb(18,255,3)]>Parabéns, [Killer.name]! Você derrotou o [src.name]! Volte e fale com o Grande Patriarca para dar prosseguimento às suas missões."
					Killer.Mission=0
					for(var/obj/Items/Missoes/Jeice/R in AllMissoes)
						Killer.MissionBag+=new R.type
						R.Collect(Killer)
			if(src.name=="Jeice")
				if(Killer.Mission==9)
					Killer.AddExp(round(55*100),"Missão")
					Killer<<"<b><font color=[rgb(18,255,3)]>Parabéns, [Killer.name]! Você derrotou o [src.name]! Volte e fale com o Grande Patriarca para dar prosseguimento às suas missões."
					Killer.Mission=0
					for(var/obj/Items/Missoes/Burter/R in AllMissoes)
						Killer.MissionBag+=new R.type
						R.Collect(Killer)
			if(src.name=="Burter")
				if(Killer.Mission==10)
					Killer<<"<b><font color=[rgb(18,255,3)]>Parabéns, [Killer.name]! Você derrotou o [src.name]! Volte e fale com o Grande Patriarca para dar prosseguimento às suas missões."
					Killer.Mission=0
					Killer.AddExp(round(60*100),"Missão")
					for(var/obj/Items/Missoes/CG/R in AllMissoes)
						Killer.MissionBag+=new R.type
						R.Collect(Killer)
			if(src.name=="Capitão Ginyu")
				if(Killer.Mission==11)
					Killer<<"<b><font color=[rgb(18,255,3)]>Parabéns, [Killer.name]! Você derrotou o [src.name]! Volte e fale com o Grande Patriarca para dar prosseguimento às suas missões."
					Killer.Mission=0
					Killer.AddExp(round(65*100),"Missão")
					for(var/obj/Items/Missoes/F1/R in AllMissoes)
						Killer.MissionBag+=new R.type
						R.Collect(Killer)
			if(src.name=="Freeza")
				if(Killer.Mission==12)
					Killer<<"<b><font color=[rgb(18,255,3)]>Parabéns, [Killer.name]! Você derrotou o [src.name]! Volte e fale com o Grande Patriarca para dar prosseguimento às suas missões."
					Killer.Mission=0
					Killer.AddExp(round(70*100),"Missão")
					if(Killer.Character.name=="Bardock")
						if(Killer.Skill1==0)
							Killer.Skill1=1
							world<<"<b><font color=[rgb(94,164,221)]>[Killer.name] desbloqueou a Técnica 'Transformação'!"
						//	alert("Você aprendeu a Técninca 'Transformação'!","Técnica")
					if(Killer.Character.name=="Freeza")
						if(Killer.Skill13==0)
							Killer.Skill13=1
							world<<"<b><font color=[rgb(94,164,221)]>[Killer.name] desbloqueou a Técnica 'Death Beam'!"
						//	alert("Você aprendeu a Técninca 'Death Beam'!","Técnica")
					for(var/obj/Items/Missoes/F2/R in AllMissoes)
						Killer.MissionBag+=new R.type
						R.Collect(Killer)
			if(src.name=="Freeza 2ª Forma")
				if(Killer.Mission==13)
					Killer<<"<b><font color=[rgb(18,255,3)]>Parabéns, [Killer.name]! Você derrotou o [src.name]! Volte e fale com o Grande Patriarca para dar prosseguimento às suas missões."
					Killer.Mission=0
					Killer.AddExp(round(75*100),"Missão")
					if(Killer.Character.name=="Freeza")
						if(Killer.Skill1==0)
							Killer.Skill1=1
							world<<"<b><font color=[rgb(94,164,221)]>[Killer.name] desbloqueou a Técnica 'Transformação'!"
						//	alert("Você aprendeu a Técninca 'Transformação'!","Técnica")
					for(var/obj/Items/Missoes/F3/R in AllMissoes)
						Killer.MissionBag+=new R.type
						R.Collect(Killer)
			if(src.name=="Freeza 3ª Forma")
				if(Killer.Mission==14)
					Killer<<"<b><font color=[rgb(18,255,3)]>Parabéns, [Killer.name]! Você derrotou o [src.name]! Volte e fale com o Grande Patriarca para dar prosseguimento às suas missões."
					Killer.Mission=0
					Killer.AddExp(round(80*100),"Missão")
					for(var/obj/Items/Missoes/F4/R in AllMissoes)
						Killer.MissionBag+=new R.type
						R.Collect(Killer)
			if(src.name=="Freeza 4ª Forma")
				if(Killer.Mission==15)
					Killer<<"<b><font color=[rgb(18,255,3)]>Parabéns, [Killer.name]! Você derrotou o [src.name]! Volte e fale com o Grande Patriarca para dar prosseguimento às suas missões."
					Killer.Mission=0
					Killer.AddExp(round(85*100),"Missão")
					if(Killer.Character.name=="Goku" || Killer.Character.name=="Goku Super" || Killer.Character.name=="GT Goku" || Killer.Character.name=="Goku2")
						if(Killer.Skill1==0)
							Killer.Skill1=1
							world<<"<b><font color=[rgb(94,164,221)]>[Killer.name] desbloqueou a Técnica 'Transformação'!"
					for(var/obj/Items/Missoes/MF/R in AllMissoes)
						Killer.MissionBag+=new R.type
						R.Collect(Killer)
			if(src.name=="Mecha Freeza")
				if(Killer.Mission==16)
					Killer<<"<b><font color=[rgb(18,255,3)]>Parabéns, [Killer.name]! Você derrotou o [src.name]! Volte e fale com o Mestre Kame para dar prosseguimento às suas missões."
					Killer.Mission=0
					Killer.AddExp(round(90*100),"Missão")
					if(Killer.Character.name=="Future Trunks" || Killer.Character.name=="Future Trunks Adulto" || Killer.Character.name=="Saiyan Armor Trunks")
						if(Killer.Skill1==0)
							Killer.Skill1=1
							world<<"<b><font color=[rgb(94,164,221)]>[Killer.name] desbloqueou a Técnica 'Super Saiyajin'!"
						//	alert("Você aprendeu a Técninca 'Super Saiyajin'!","Técnica")

					if(Killer.Character.name=="Future Trunks" || Killer.Character.name=="Future Trunks Adulto" || Killer.Character.name=="Saiyan Armor Trunks")
						if(Killer.Skill17==0)
							Killer.Skill17=1
							world<<"<b><font color=[rgb(94,164,221)]>[Killer.name] desbloqueou a Técnica 'Buster Cannon'!"
					if(Killer.Character.name=="Future Trunks" || Killer.Character.name=="Future Trunks Adulto" || Killer.Character.name=="Saiyan Armor Trunks")
						if(Killer.Skill16==0)
							Killer.Skill16=1
							world<<"<b><font color=[rgb(94,164,221)]>[Killer.name] desbloqueou a Técnica 'Burning Attack'!"
					for(var/obj/Items/Missoes/Androide19/R in AllMissoes)
						Killer.MissionBag+=new R.type
						R.Collect(Killer)
			if(src.name=="Andróide 19")
				if(Killer.Mission==17)
					Killer<<"<b><font color=[rgb(18,255,3)]>Parabéns, [Killer.name]! Você derrotou o [src.name]! Volte e fale com o Mestre Kame para dar prosseguimento às suas missões."
					Killer.Mission=0
					Killer.AddExp(round(90*100),"Missão")
					if(Killer.Character.name=="Vegeta" || Killer.Character.name=="Vegeta2" || Killer.Character.name=="Alternate GT Vegeta" || Killer.Character.name=="Saiyan Armor Vegeta" || Killer.Character.name=="Vegeta Super")
						if(Killer.Skill1==0)
							Killer.Skill1=1
							world<<"<b><font color=[rgb(94,164,221)]>[Killer.name] desbloqueou a Técnica 'Transformação'!"
						//	alert("Você aprendeu a Técninca 'Transformação'!","Técnica")

					if(Killer.Character.name=="Vegeta" || Killer.Character.name=="Vegeta2" || Killer.Character.name=="Alternate GT Vegeta" || Killer.Character.name=="Saiyan Armor Vegeta" || Killer.Character.name=="Vegeta Super")
						if(Killer.Skill7==0)
							Killer.Skill7=1
							world<<"<b><font color=[rgb(94,164,221)]>[Killer.name] desbloqueou a Técnica 'Big Bang'!"
					//		alert("Você aprendeu a Técninca 'Big Bang'!","")
					for(var/obj/Items/Missoes/Androide20/R in AllMissoes)
						Killer.MissionBag+=new R.type
						R.Collect(Killer)
			if(src.name=="Andróide 20")
				if(Killer.Mission==18)
					Killer<<"<b><font color=[rgb(18,255,3)]>Parabéns, [Killer.name]! Você derrotou o [src.name]! Volte e fale com o Mestre Kame para dar prosseguimento às suas missões."
					Killer.Mission=0
					Killer.AddExp(round(95*100),"Missão")
					for(var/obj/Items/Missoes/Androide17/R in AllMissoes)
						Killer.MissionBag+=new R.type
						R.Collect(Killer)
			if(src.name=="Andróide 17")
				if(Killer.Mission==19)
					Killer<<"<b><font color=[rgb(18,255,3)]>Parabéns, [Killer.name]! Você derrotou o [src.name]! Volte e fale com o Mestre Kame para dar prosseguimento às suas missões."
					Killer.Mission=0
					Killer.AddExp(round(100*100),"Missão")
					if(Killer.Character.name=="Future Gohan")
						if(Killer.Skill3==0)
							Killer.Skill3=1
							world<<"<b><font color=[rgb(94,164,221)]>[Killer.name] desbloqueou a Técnica 'Kamehameha'!"
						//	alert("Você aprendeu a Técninca 'Kamehameha'!","")

						if(Killer.Skill1==0)
							Killer.Skill1=1
							world<<"<b><font color=[rgb(94,164,221)]>[Killer.name] desbloqueou a Técnica 'Transformação'!"
						//	alert("Você aprendeu a Técninca 'Transformação'!","Técnica")
						if(Killer.Skill6==0)
							Killer.Skill6=1
							world<<"<b><font color=[rgb(94,164,221)]>[Killer.name] desbloqueou a Técnica 'Masenko'!"
							//alert("Você aprendeu a Técninca 'Masenko'!","Técnica")
					for(var/obj/Items/Missoes/Androide18/R in AllMissoes)
						Killer.MissionBag+=new R.type
						R.Collect(Killer)
			if(src.name=="Andróide 18")
				if(Killer.Mission==20)
					Killer<<"<b><font color=[rgb(18,255,3)]>Parabéns, [Killer.name]! Você derrotou o [src.name]! Volte e fale com o Mestre Kame para dar prosseguimento às suas missões."
					Killer.Mission=0
					Killer.AddExp(round(105*100),"Missão")
					for(var/obj/Items/Missoes/C1/R in AllMissoes)
						Killer.MissionBag+=new R.type
						R.Collect(Killer)
			if(src.name=="Cell Imperfeito")
				if(Killer.Mission==21)
					Killer<<"<b><font color=[rgb(18,255,3)]>Parabéns, [Killer.name]! Você derrotou o [src.name]! Volte e fale com o Mestre Kame para dar prosseguimento às suas missões."
					Killer.Mission=0
					Killer.AddExp(round(110*100),"Missão")
					if(Killer.Character.name=="Cell")
						if(Killer.Skill3==0)
							Killer.Skill3=1
							world<<"<b><font color=[rgb(94,164,221)]>[Killer.name] desbloqueou a Técnica 'Kamehameha'!"
						//	alert("Você aprendeu a Técninca 'Kamehameha'!","")
					for(var/obj/Items/Missoes/C2/R in AllMissoes)
						Killer.MissionBag+=new R.type
						R.Collect(Killer)
			if(src.name=="Cell Semi-Perfeito")
				if(Killer.Mission==22)
					Killer<<"<b><font color=[rgb(18,255,3)]>Parabéns, [Killer.name]! Você derrotou o [src.name]! Volte e fale com o Mestre Kame para dar prosseguimento às suas missões."
					Killer.Mission=0
					Killer.AddExp(round(115*100),"Missão")
					if(Killer.icon=='Tien.dmi')
						if(Killer.Skill11==0)
							Killer.Skill11=1
							world<<"<b><font color=[rgb(94,164,221)]>[Killer.name] desbloqueou a Técnica 'Kikoho'!"
						//	alert("Você aprendeu a Técninca 'Kikoho'!","")
					if(Killer.Character.name=="Cell")
						if(Killer.Skill1==0)
							Killer.Skill1=1
							world<<"<b><font color=[rgb(94,164,221)]>[Killer.name] desbloqueou a Técnica 'Transformação'!"
						//	alert("Você aprendeu a Técninca 'Transformação'!","Técnica")
					for(var/obj/Items/Missoes/C3/R in AllMissoes)
						Killer.MissionBag+=new R.type
						R.Collect(Killer)
			if(src.name=="Cell Perfeito")
				if(Killer.Mission==23)
					Killer<<"<b><font color=[rgb(18,255,3)]>Parabéns, [Killer.name]! Você derrotou o [src.name]! Volte e fale com o Mestre Kame para dar prosseguimento às suas missões."
					Killer.Mission=0
					Killer.AddExp(round(120*100),"Missão")
					if(Killer.Character.name=="Teen Gohan" || Killer.Character.name=="Gohan" || Killer.Character.name=="Mystic Gohan" || Killer.Character.name=="Adult Piccolo Gohan")
						if(Killer.Skill3==0)
							Killer.Skill3=1
							world<<"<b><font color=[rgb(94,164,221)]>[Killer.name] desbloqueou a Técnica 'Kamehameha'!"
						//	alert("Você aprendeu a Técninca 'Kamehameha'!","")
						if(Killer.Skill1==0)
							Killer.Skill1=1
							world<<"<b><font color=[rgb(94,164,221)]>[Killer.name] desbloqueou a Técnica 'Transformação'!"
					//		alert("Você aprendeu a Técninca 'Transformação'!","")

					if(Killer.Character.name=="Future Trunks" || Killer.Character.name=="Future Trunks Adulto" || Killer.Character.name=="Saiyan Armor Trunks")
						if(Killer.Skill18==0)
							Killer.Skill18=1
							world<<"<b><font color=[rgb(94,164,221)]>[Killer.name] desbloqueou a Técnica 'Finish Buster'!"
					//		alert("Você aprendeu a Técninca 'Finish Buster'!","")
					if(Killer.Character.name=="Vegeta" || Killer.Character.name=="Vegeta2" || Killer.Character.name=="Alternate GT Vegeta" || Killer.Character.name=="Saiyan Armor Vegeta" || Killer.Character.name=="Vegeta Super")
						if(Killer.Skill8==0)
							Killer.Skill8=1
							world<<"<b><font color=[rgb(94,164,221)]>[Killer.name] desbloqueou a Técnica 'Final Flash'!"
					//		alert("Você aprendeu a Técninca 'Final Flash'!","")

					if(Killer.Character.name=="Teen Gohan" || Killer.Character.name=="Gohan" || Killer.Character.name=="Mystic Gohan" || Killer.Character.name=="Adult Piccolo Gohan")
						if(Killer.Skill1==0)
							Killer.Skill1=1
							world<<"<b><font color=[rgb(94,164,221)]>[Killer.name] desbloqueou a Técnica 'Transformação'!"
						//	alert("Você aprendeu a Técninca 'Transformação'!","")

					for(var/obj/Items/Missoes/Spopovitch/R in AllMissoes)
						Killer.MissionBag+=new R.type
						R.Collect(Killer)
			if(src.name=="Spopovitch")
				if(Killer.Mission==24)
					Killer<<"<b><font color=[rgb(18,255,3)]>Parabéns, [Killer.name]! Você derrotou o [src.name]! Volte e fale com o Mestre Kame para dar prosseguimento às suas missões."
					Killer.Mission=0
					Killer.AddExp(round(125*100),"Missão")
					for(var/obj/Items/Missoes/Dabura/R in AllMissoes)
						Killer.MissionBag+=new R.type
						R.Collect(Killer)
			if(src.name=="Dabura")
				if(Killer.Mission==25)
					Killer<<"<b><font color=[rgb(18,255,3)]>Parabéns, [Killer.name]! Você derrotou o [src.name]! Volte e fale com o Mestre Kame para dar prosseguimento às suas missões."
					Killer.Mission=0
					Killer.AddExp(round(130*100),"Missão")
					for(var/obj/Items/Missoes/Babidi/R in AllMissoes)
						Killer.MissionBag+=new R.type
						R.Collect(Killer)
			if(src.name=="Babidi")
				if(Killer.Mission==26)
					Killer<<"<b><font color=[rgb(18,255,3)]>Parabéns, [Killer.name]! Você derrotou o [src.name]! Volte e fale com o Mestre Kame para dar prosseguimento às suas missões."
					Killer.Mission=0
					Killer.AddExp(round(135*100),"Missão")
					for(var/obj/Items/Missoes/MV/R in AllMissoes)
						Killer.MissionBag+=new R.type
						R.Collect(Killer)
			if(src.name=="Majin Vegeta")
				if(Killer.Mission==50)
					Killer<<"<b><font color=[rgb(18,255,3)]>Parabéns, [Killer.name]! Você derrotou o [src.name]! Volte e fale com o Mestre Kame para dar prosseguimento às suas missões."
					Killer.Mission=0
					Killer.AddExp(round(140*100),"Missão")
					for(var/obj/Items/Missoes/MB/R in AllMissoes)
						Killer.MissionBag+=new R.type
						R.Collect(Killer)
			if(src.name=="Majin Boo")
				if(Killer.Mission==27)
					Killer<<"<b><font color=[rgb(18,255,3)]>Parabéns, [Killer.name]! Você derrotou o [src.name]! Volte e fale com o Mestre Kame para dar prosseguimento às suas missões."
					Killer.Mission=0
					Killer.AddExp(round(145*100),"Missão")
					if(Killer.Character.name=="Goten")
						if(Killer.Skill3==0)
							Killer.Skill3=1
							world<<"<b><font color=[rgb(94,164,221)]>[Killer.name] desbloqueou a Técnica 'Kamehameha'!"
						//	alert("Você aprendeu a Técninca 'Transformação'!","")
					for(var/obj/Items/Missoes/EB/R in AllMissoes)
						Killer.MissionBag+=new R.type
						R.Collect(Killer)
			if(src.name=="Evil Boo")
				if(Killer.Mission==28)
					Killer<<"<b><font color=[rgb(18,255,3)]>Parabéns, [Killer.name]! Você derrotou o [src.name]! Volte e fale com o Mestre Kame para dar prosseguimento às suas missões."
					Killer.Mission=0
					Killer.AddExp(round(150*100),"Missão")
					for(var/obj/Items/Missoes/SB/R in AllMissoes)
						Killer.MissionBag+=new R.type
						R.Collect(Killer)
			if(src.name=="Super Boo")
				if(Killer.Mission==29)
					Killer<<"<b><font color=[rgb(18,255,3)]>Parabéns, [Killer.name]! Você derrotou o [src.name]! Volte e fale com o Mestre Kame para dar prosseguimento às suas missões."
					Killer.Mission=0
					Killer.AddExp(round(155*100),"Missão")
					if(Killer.Character.name=="Goten")
						if(Killer.Skill1==0)
							Killer.Skill1=1
							world<<"<b><font color=[rgb(94,164,221)]>[Killer.name] desbloqueou a Técnica 'Transformação'!"
						//	alert("Você aprendeu a Técninca 'Transformação'!","")
					if(Killer.Character.name=="Kid Trunks")
						if(Killer.Skill1==0)
							Killer.Skill1=1
							world<<"<b><font color=[rgb(94,164,221)]>[Killer.name] desbloqueou a Técnica 'Transformação'!"
						//	alert("Você aprendeu a Técninca 'Transformação'!","")
					for(var/obj/Items/Missoes/Bootenks/R in AllMissoes)
						Killer.MissionBag+=new R.type
						R.Collect(Killer)
			if(src.name=="Bootenks")
				if(Killer.Mission==30)
					Killer<<"<b><font color=[rgb(18,255,3)]>Parabéns, [Killer.name]! Você derrotou o [src.name]! Volte e fale com o Mestre Kame para dar prosseguimento às suas missões."
					Killer.Mission=0
					Killer.AddExp(round(160*100),"Missão")
					for(var/obj/Items/Missoes/Boohan/R in AllMissoes)
						Killer.MissionBag+=new R.type
						R.Collect(Killer)
			if(src.name=="Boohan")
				if(Killer.Mission==31)
					Killer<<"<b><font color=[rgb(18,255,3)]>Parabéns, [Killer.name]! Você derrotou o [src.name]! Volte e fale com o Mestre Kame para dar prosseguimento às suas missões."
					Killer.Mission=0
					Killer.AddExp(round(165*100),"Missão")
					for(var/obj/Items/Missoes/KidBoo/R in AllMissoes)
						Killer.MissionBag+=new R.type
						R.Collect(Killer)
			if(src.name=="Kid Boo")
				if(Killer.Mission==32)
					Killer<<"<b><font color=[rgb(18,255,3)]>Parabéns, [Killer.name]! Você derrotou o [src.name]! Volte e fale com o Mestre Kame para dar prosseguimento às suas missões."
					Killer.Mission=0
					Killer.AddExp(round(170*100),"Missão")
					for(var/obj/Items/Missoes/BV/R in AllMissoes)
						Killer.MissionBag+=new R.type
						R.Collect(Killer)
			if(src.name=="Baby Vegeta")
				if(Killer.Mission==33)
					Killer<<"<b><font color=[rgb(18,255,3)]>Parabéns, [Killer.name]! Você derrotou o [src.name]! Volte e fale com o Mestre Kame para dar prosseguimento às suas missões."
					Killer.Mission=0
					Killer.AddExp(round(175*100),"Missão")
					for(var/obj/Items/Missoes/BV2/R in AllMissoes)
						Killer.MissionBag+=new R.type
						R.Collect(Killer)
			if(src.name=="Baby Vegeta Perfeito")
				if(Killer.Mission==34)
					Killer<<"<b><font color=[rgb(18,255,3)]>Parabéns, [Killer.name]! Você derrotou o [src.name]! Volte e fale com o Mestre Kame para dar prosseguimento às suas missões."
					Killer.Mission=0
					Killer.AddExp(round(180*100),"Missão")
					if(Killer.Character.name=="Baby")
						if(Killer.Skill1==0)
							Killer.Skill1=1
							world<<"<b><font color=[rgb(94,164,221)]>[Killer.name] desbloqueou a Técnica 'Transformação'!"
						//	alert("Você aprendeu a Técninca 'Transformação'!","")
					for(var/obj/Items/Missoes/S17/R in AllMissoes)
						Killer.MissionBag+=new R.type
						R.Collect(Killer)
			if(src.name=="Super 17")
				if(Killer.Mission==35)
					Killer<<"<b><font color=[rgb(18,255,3)]>Parabéns, [Killer.name]! Você derrotou o [src.name]! Volte e fale com o Mestre Kame para dar prosseguimento às suas missões."
					Killer.Mission=0
					Killer.AddExp(round(185*100),"Missão")
					if(Killer.Character.name=="Alternate GT Vegeta")
						if(Killer.Skill19==0)
							Killer.Skill19=1
							world<<"<b><font color=[rgb(94,164,221)]>[Killer.name] desbloqueou a Técnica 'Final Shine'!"
					//		alert("Você aprendeu a Técninca 'Final Shine'!","")
					if(Killer.Character.name=="GT Goku")
						if(Killer.Skill23==0)
							Killer.Skill23=1
							world<<"<b><font color=[rgb(94,164,221)]>[Killer.name] desbloqueou a Técnica '10x Kamehameha'!"
						//	alert("Você aprendeu a Técninca '10x Kamehameha'!","")
					if(Killer.Character.name=="Android 17")
						if(Killer.Skill1==0)
							Killer.Skill1=1
							world<<"<b><font color=[rgb(94,164,221)]>[Killer.name] desbloqueou a Técnica 'Transformação'!"
						//	alert("Você aprendeu a Técninca 'Transformação'!","")
					for(var/obj/Items/Missoes/OS/R in AllMissoes)
						Killer.MissionBag+=new R.type
						R.Collect(Killer)
			if(src.name=="Omega Shenron")
				if(Killer.Mission==36)
					Killer<<"<b><font color=[rgb(18,255,3)]>Parabéns, [Killer.name]! Você derrotou o [src.name]! Volte e fale com o Mestre Kame para finalizar o prosseguimento de suas missões."
					Killer.Mission=0
					Killer.AddExp(round(190*100),"Missão")
					Killer.Zerado=1
			if(Killer.Talked8==1 && Killer.Quest8==0)
				if(src.name=="Cooler")
					Killer<<"<b><font color=[rgb(18,255,3)]>Parabéns, [Killer.name]! Você derrotou o [src.name]! Volte e fale com o Vegeta para continuar suas missões."
					Killer.AddExp(round(500*100),"Missão Extra")
					Killer.Zenie+=1000
					Killer<<"<b>Zennie +1,000!"
					Killer.Quest8=1
			if(Killer.Talked8==2 && Killer.Quest8==1)
				if(src.name=="Cooler Forma 2")
					Killer<<"<b><font color=[rgb(18,255,3)]>Parabéns, [Killer.name]! Você derrotou o [src.name]! Volte e fale com o Vegeta para continuar suas missões."
					Killer.AddExp(round(500*100),"Missão Extra")
					Killer.Zenie+=1000
					Killer<<"<b>Zennie +1,000!"
					Killer.Quest8=2
			if(Killer.Talked8==3 && Killer.Quest8==2)
				if(src.name=="Metal Cooler")
					Killer<<"<b><font color=[rgb(18,255,3)]>Parabéns, [Killer.name]! Você derrotou o [src.name]! Volte e fale com o Vegeta para continuar suas missões."
					Killer.AddExp(round(1000*100),"Missão Extra")
					Killer.Zenie+=1000
					Killer<<"<b>Zennie +1,000!"
					Killer.Quest8=3
			if(Killer.Talked8==4 && Killer.Quest8==3)
				if(src.name=="Broly")
					Killer<<"<b><font color=[rgb(18,255,3)]>Parabéns, [Killer.name]! Você derrotou o [src.name]! Volte e fale com o Vegeta para continuar suas missões."
					Killer.AddExp(round(1000*100),"Missão Extra")
					Killer.Zenie+=1000
					Killer<<"<b>Zennie +1,000!"
					Killer.Quest8=4
			if(Killer.Talked8==5 && Killer.Quest8==4)
				if(src.name=="Broly Lendário Super Saiyajin")
					Killer<<"<b><font color=[rgb(18,255,3)]>Parabéns, [Killer.name]! Você derrotou o [src.name]! Volte e fale com o Vegeta para continuar suas missões."
					Killer.AddExp(round(1000*100),"Missão Extra")
					Killer.Zenie+=5000
					Killer<<"<b>Zennie +5,000!"
					Killer.Quest8=5
					if(Killer.Character.name=="Broly")
						if(Killer.Skill1==0)
							Killer.Skill1=1
							world<<"<b><font color=[rgb(94,164,221)]>[Killer.name] desbloqueou a Técnica 'Transformação'!"
						//	alert("Você aprendeu a Técninca 'Transformação'!","")
			if(src.name=="Janemba")
				Killer.Quest7=1
				Killer.Talked6=1
				Killer.loc=locate(14,14,3)
				Killer.AddExp(1000000,"Missão")
				Killer.Zenie+=100000
				Killer<<"<b>Você ganhou 100,000 Zennie!"
			if(src.name=="Dodoria" || src.name=="Zarbon")
				if(Killer.Talked3==3)
					Killer.Quest4+=1
					if(Killer.Quest4==2)
						PlaySound(Killer,'VictoryFanfare.ogg')
						Killer.AddExp(200000,"Missão")
						Killer.Zenie+=10000
						Killer<<"<b>Você ganhou 10,000 Zennie!"
						Killer.Talked3=3.5
			if(src.name=="Henchman" || src.name=="Doore")
				if(Killer.Talked3==1)
					Killer.Quest3+=1
					if(Killer.Quest3==9)
						Killer.AddExp(320000,"Missão")
						Killer.Zenie+=10000
						Killer<<"<b>Você ganhou 10,000 Zennie!"
						PlaySound(Killer,'VictoryFanfare.ogg')
						Killer.Talked3=1.5
			if(src.name=="Android 17" || src.name=="Android 18")
				if(Killer.Talked==1)
					Killer.Quest1+=1
					if(Killer.Quest1==2)
						PlaySound(Killer,'VictoryFanfare.ogg')
						Killer.AddExp(700000,"Missão")
						Killer.Zenie+=50000
						Killer<<"<b>Você ganhou 50,000 Zennie!"
						Killer.Talked=1.5
			if(!src.Owner)
//				spawn(-1)	Killer.SpawnPart(src.loc)
				spawn(-1)	Killer.SpawnZenie(src.loc,1)
			if(src.NPC!=2)
				Killer.AddExp(round(2000),"NPC")
			if(src.NPC==2)
				Killer.AddExp(round(src.DamageMultiplier*7400),"Spar Bot")
		//	Killer.AddExp(5000,"NPC")
			if(Killer.CurrentCP)
				Killer.CheckMissionUnlocks(src,Killer.CurrentMission,DamageType)
				if(Killer.CurrentCP.Boss==src.name)	Killer.CompleteMission()
			if(src.Owner)
				src.LoseTournRound("Derrotado",Killer)
				src.LeaveParty()
			if(!initial(src.z))	del src
			src.loc=locate(1,1,0)
			src.Target=null
			src.Frozen=0
			src.IsDead=1
			sleep(10)
			Killer.CancelBeamBattle()
			Killer.ResetIS()
			Killer.ClearBeam()
			src.IsDead=0
			if(src.Zens==666)
				sleep(5*600)
				src.loc=locate(initial(src.x),initial(src.y),initial(src.z))
			else
				sleep(600)
				src.loc=locate(initial(src.x),initial(src.y),initial(src.z))
		if(src.MajinForm==0)
			src.Revert()
		src.ResetIS()
		src.IsDead=1
		src.AddPlPercent(100);src.AddKiPercent(100)
		if(src.CurTut && src.CurTut.name=="KO Recovery")	{src.PL=0;src.KnockOut(src,"Death")}
		else	src.KoRecovery()
	if(usr.Talked7<=20)
		usr.Class="Baixo"
		usr.ResetSuffix()
	if(usr.Talked7>20 && usr.Talked7<=45)
		usr.Class="Medio"
		usr.ResetSuffix()
	if(usr.Talked7>45 && usr.Talked7<=70)
		usr.Class="Alto"
		usr.ResetSuffix()
	if(usr.Talked7>70 && usr.Talked7<=100)
		usr.Class="Especial"
		usr.ResetSuffix()
	if(usr.Talked7>100)
		usr.Class="Elite"
		usr.ResetSuffix()

proc/VaryDamage(var/Damage,var/Percent)
	Percent=round(Damage*(Percent/100))
	return Damage+rand(-Percent,Percent)

proc/KiPercentDifference(var/mob/A,var/mob/D)
	var/MaxVariant=0.7	//A=Attacker, D=Defender
	return min(MaxVariant,max(-MaxVariant,((A.Ki/A.MaxKi)-(D.Ki/D.MaxKi))))
mob/proc/CalcDamMult()
	var/TransBoost=0
	if(src.MajinForm==1)
		TransBoost=0.7
		if(src.ControlClients && src.ControlClients.len>=2)	TransBoost+=0.3
		return	src.DamageMultiplier+TransBoost-TransBoost
	if(src.HasPerk("Poder Supremo") && src.Character.Race!="Assassin" && src.Character.Race!="Saiyan" && src.Character.Race!="Half Saiyan" && src.Character.Race!="Saiyajin")
		if(src.MaxPL>=3275000 || src.MaxKi>=3275000 || src.Str>=2000000 || src.Def>=700000)	TransBoost=1.1
		else	if(src.MaxPL>=3000000 || src.MaxKi>=3000000 || src.Str>=1500000 || src.Def>=500000)	TransBoost=0.9
		else	if(src.MaxPL>=1500000 || src.MaxKi>=1500000 || src.Str>=800000 || src.Def>=250000)	TransBoost=0.7
		else	if(src.MaxPL>=800000 || src.MaxKi>=500000 || src.Str>=400000 || src.Def>=96000)	TransBoost=0.5
		else	if(src.MaxPL>=600000 || src.MaxKi>=400000 || src.Str>=200000 || src.Def>=64000)	TransBoost=0.4
		else	if(src.MaxPL>=400000 || src.MaxKi>=300000 || src.Str>=100000 || src.Def>=32000)	TransBoost=0.3
		else	if(src.MaxPL>=275000 || src.MaxKi>=275000 || src.Str>=70000 || src.Def>=16000)	TransBoost=0.25
		else	if(src.MaxPL>=200000 || src.MaxKi>=200000 || src.Str>=50000 || src.Def>=8000)	TransBoost=0.2
		else	if(src.MaxPL>=150000 || src.MaxKi>=150000 || src.Str>=10000 || src.Def>=4000)	TransBoost=0.15
		else	if(src.MaxPL>=100000 || src.MaxKi>=100000 || src.Str>=4000 || src.Def>=2000)	TransBoost=0.1
	else	if(src.TransDatum)
		if(src.TransDatum.ReqPL>=3275000 || src.TransDatum.ReqKi>=3275000 || src.TransDatum.ReqStr>=2000000 || src.TransDatum.ReqDef>=700000)	TransBoost=1.1
		else	if(src.TransDatum.ReqPL>=3000000 || src.TransDatum.ReqKi>=3000000 || src.TransDatum.ReqStr>=1500000 || src.TransDatum.ReqDef>=500000)	TransBoost=0.9
		else	if(src.TransDatum.ReqPL>=1500000 || src.TransDatum.ReqKi>=1500000 || src.TransDatum.ReqStr>=800000 || src.TransDatum.ReqDef>=250000)	TransBoost=0.7
		else	if(src.TransDatum.ReqPL>=800000 || src.TransDatum.ReqKi>=500000 || src.TransDatum.ReqStr>=400000 || src.TransDatum.ReqDef>=120000)	TransBoost=0.5
		else	if(src.TransDatum.ReqPL>=600000 || src.TransDatum.ReqKi>=400000 || src.TransDatum.ReqStr>=200000 || src.TransDatum.ReqDef>=64000)	TransBoost=0.4
		else	if(src.TransDatum.ReqPL>=400000 || src.TransDatum.ReqKi>=300000 || src.TransDatum.ReqStr>=100000 || src.TransDatum.ReqDef>=32000)	TransBoost=0.3
		else	if(src.TransDatum.ReqPL>=275000 || src.TransDatum.ReqKi>=275000 || src.TransDatum.ReqStr>=70000 || src.TransDatum.ReqDef>=20000)	TransBoost=0.25
		else	if(src.TransDatum.ReqPL>=200000 || src.TransDatum.ReqKi>=200000 || src.TransDatum.ReqStr>=50000 || src.TransDatum.ReqDef>=16000)	TransBoost=0.2
		else	if(src.TransDatum.ReqPL>=150000 || src.TransDatum.ReqKi>=150000 || src.TransDatum.ReqStr>=10000 || src.TransDatum.ReqDef>=4000)	TransBoost=0.15
		else	if(src.TransDatum.ReqPL>=100000 || src.TransDatum.ReqKi>=100000 || src.TransDatum.ReqStr>=4000 || src.TransDatum.ReqDef>=2000)	TransBoost=0.1
	if(src.ControlClients && src.ControlClients.len>=2)	TransBoost+=0.3
	return	src.DamageMultiplier+TransBoost-TransBoost

mob/proc/StandardDamage(var/mob/M,var/Damage,var/Controlled=0,var/DamageType)
	Damage-=M.Def
	Damage=src.GetDamageOffsets(M,Damage)
	src.Damage(M,Damage,Controlled,DamageType=DamageType)
	return Damage

mob/proc/GetDamageOffsets(var/mob/M,var/Damage)
	Damage+=Damage*(KiPercentDifference(src,M)/10)
	var/Dif=max(0.7,1+src.CalcDamMult()-M.CalcDamMult())
	Damage=VaryDamage(Damage*Dif,7)
	return Damage

mob/proc/DoBalancedDamage(var/mob/M)
	if(src.DuelFlag && src.DuelFlag==M.DuelFlag && M.DuelFlag.DuelType=="Balanced")	return 1
	if(src.InTournament && M.InTournament && global.TournDamage=="Balanced")	return 1
	if(M.InstanceObj && M.InstanceObj.IsPvpType("Balanced"))	return 1
	if(M.ControlClients || src.ControlClients)
		if(M.icon_state=="machine")	return 1
		if(global.K1==2)
			return 1
		if((src.z==3 && src.x>316 && src.y<70) || (M.z==3 && M.x>316 && M.y<70))	return 1
	if(!M.ControlClients || !src.ControlClients)
		if(src.InTournament || M.InTournament)
			return 1
		if(src.x>8 && src.x<69 && src.y>166 && src.y<193 && src.z==3)
			return
		if(src.z!=1 && src.z!=7 && M.z!=1 && M.z!=7)
			return 1
//src tá dando
mob/proc/Damage(var/mob/M,var/Damage,var/Controlled=0,var/DeathTag="Mysteriously?",var/DamageType)
	if(!M.CanBeHit())	return
	if(src.DoBalancedDamage(M))
		Damage=round(M.MaxPL/20)	//Balanced Damage - 20 Hits to Kill
		if(!M.ControlClients)	Damage*=2	//Doubled PvE Damage due to Blocking
		if(DamageType=="Beam")	Damage*=1+(src.BeamOverCharge/20)	//Over Charged Beam Damage
		Damage=src.GetDamageOffsets(M,Damage)
	if(src.ControlClients && M.HasPerk("A Prova de Balas"))	Damage*=2
	if(!src.ControlClients && src.Clonagem==1)	Damage*=2
	if(M.HasPerk("Escudo de Energia") && M.UseKiPercent(10))	Damage*=0.9
	if(src.HasPerk("Forca de Vontade"))
		if(src.HasPlPercent(25))	Damage*=0.65
	Damage=round(max(0,Damage))
	DamageShow(M,Damage)
	M.CombatTime();M.AddKiPercent(1)
	if(M.HasPerk("Sem Folego"))	M.AddKiPercent(1)
	var/LastGaspDmg=0;if(M.PL>1 && M.HasPerk("Ultimo Suspiro"))	LastGaspDmg=1
	M.PL=max(LastGaspDmg,M.PL-Damage)
	M.TrackStat("Damage Taken",Damage)
	src.TrackStat("Damage Dealt",Damage)
	if(Controlled)	M.KnockOut(src,"Damage")
	else	M.DeathCheck(src,DeathTag,DamageType)
	if(M && Damage>0)	M.HitStun(5,src)
	if(M && round(M.PL/M.MaxPL*100)<=20)	M.ShowTutorial(Tutorials["Power Up"])
	if(M)	{M.UpdatePlHUD();M.ShowTutorial(Tutorials["Guard"])}
	return Damage

mob/proc/KnockBack(var/mob/M,var/SrcLoc)
	if(M.Fighting==1)	return
//	if(MyGetDist(src,M)>world.view-1)	return
	var/turf/T=get_step(M,get_dir(SrcLoc,M))
	if(T.Enter(M))
		M.loc=T;T.Entered(M)

mob/proc/EndKnockBack(/**/)
	if(src.ThrownDamage!=null)	src.ThrownBy.StandardDamage(src,src.ThrownDamage,1)
	src.dir=BackDir(src.dir)
	src.ThrownBy=null
	src.ResetIS()

mob/proc/Throw(var/mob/M,var/ThrowDist,var/ThrowDir)
	if(M.Fighting==1)	return
	if(M.HasPerk("Resistencia"))	return
	spawn(-1)
		var/Dist=1
		M.ThrownBy=src
		M.ThrownDamage=src.Str-M.Def
		while(M && Dist<=ThrowDist && M.ThrownBy)
			flick("KnockBack",M)
			M.icon_state="KnockBack"
			step(M,ThrowDir);Dist+=1
			sleep(1)
		if(M)
			M.ThrownBy=null
			if(M.icon_state=="KnockBack")
				M.dir=BackDir(M.dir)
				M.ResetIS()

mob/proc
	ResetIS(/**/)
		if(src.density)
			if(src.Sprinting)	src.icon_state="Sprint"
			else	src.icon_state=""
		else
			if(src.icon_state!="Dragon")
				src.icon_state="fly"
		if(!src.GhostMode && src.PL<=0)	src.KnockOut(src,"Reset")

	GetBlastOffX()	//Used for which hand a ki blast comes from
		var/OffX=0
		if(src.dir==NORTH)
			if(src.LastBlast)	OffX=8
			else	OffX=-8
		if(src.dir==SOUTH)
			if(src.LastBlast)	OffX=-8
			else	OffX=8
		return OffX
	GetBlastOffY()
		var/OffY=0
		if(src.dir==EAST || src.dir==WEST)
			if(src.LastBlast)	OffY=4
			else	OffY=-4
		return OffY