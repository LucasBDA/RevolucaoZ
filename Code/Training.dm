mob/var
	Training=0
	TrainingID=0
	TrainingExp=0
	TrainingCombo=0
	TrainingStrike=0
	GravityTraining=0
	StopFocusTraining=0

mob/Player/var/obj/HUD/TimedF/TimedF=new
obj/HUD
	QuitTraining
		icon='HUD.dmi'
		icon_state="Quit"
		screen_loc="13:22,10:-1"
		Click()
			usr=usr.GetFusionMob();usr.ForceCancelTraining()
			for(var/client/C in usr.ControlClients)	C.screen-=src
	TimedF
		icon='Other.dmi'
		icon_state="F"
		layer=12

mob/proc/GetMaxTrainingCombo(var/TrainingType)
	var/MaxTrainingCombo=100
	if(TrainingType=="Shadow Sparring")
		if("Shadow Spar Master" in src.Medals)	MaxTrainingCombo+=10
	if(TrainingType=="Punching Bags")
		if("P.Bag Master" in src.Medals)	MaxTrainingCombo+=10
	if(src.HasPerk("Training Focus"))	MaxTrainingCombo+=10
	if(src.Subscriber)	MaxTrainingCombo+=10
	return MaxTrainingCombo

mob/proc/UpdateHubScore()
	spawn()
		var/Medals2Reg=0;if(src.Medals)	Medals2Reg=src.Medals.len
		var/Perks2Reg=0;if(src.UnlockedPerks)	Perks2Reg=src.UnlockedPerks.len
		var/Params=list2params(list("Level"=FullNum(src.GetRebirthLevel(),0),"Zenie"=FullNum(src.GetTrackedStat("Zenie Collected",src.RecordedTracked),0),"Play Time"=src.DisplayPlayTime(),"Date"=time2text(world.timeofday,"YYYYMMDD"),"Perks"="[Perks2Reg]/[global.AllPerks.len-1]","Medals"="[Medals2Reg]/[global.AllMedals.len]"))
		world.SetScores(src.key,Params)

mob/proc/LevelCheck(var/Reason)
	if(src.client && src.Exp>=100)
//		if(src.Level>=3000000)	{src.Exp=99;return}
		var/PreLevel=src.Level
		var/LevelsGained=round(src.Exp/100)
//		LevelsGained=min(LevelsGained,3000000-src.Level)
		src.Exp-=LevelsGained*100;src.Level+=LevelsGained
//		if(src.Exp>99 && src.Level>=3000000)	src.Exp=99
		src.TraitPoints+=LevelsGained
		src.TrackStat("Levels Gained",LevelsGained)
		src.TrackStat("Levels from [Reason]",LevelsGained)
		src<<"<b><font color=blue>Você ganhou [FullNum(LevelsGained)] níveis. Agora você tem [FullNum(src.Level)]![Reason ? " ([Reason])" : ""]"
		if(PreLevel<2 && src.Level>=2)	src.GiveMedal(new/obj/Medals/Ding)
		if(PreLevel<100 && src.Level>=100)	src.GiveMedal(new/obj/Medals/Centennial)
		if(PreLevel<1000 && src.Level>=1000)	src.GiveMedal(new/obj/Medals/Millennial)
		if(src.Level>=3000000)	src.GiveMedal(new/obj/Medals/LevelCap)
		var/PerkPointsGained=round(src.Level/10000)-round(PreLevel/10000)
		if(PerkPointsGained)
			src.PerkPoints+=PerkPointsGained
			src.GiveMedal(new/obj/Medals/Perky)
			src<<"<b><font color=blue>Você ganhou [PerkPointsGained] Perk!"
		src.ShowTutorial(Tutorials["Stat Points"])
		src.ScoreBoardRecord()
		src.UpdateHubScore()
		src.ResetSuffix()

mob/var/list/SparCmds
mob/proc/ShadowSpar()
	src.AddHudProtection()
	src.Training="Shadow Sparring"
	src.SparCmds=list();src.AddTrainingBG()
	src.UpdateHUDText("TrainingDesc","Combe para ganhar EXP")
	for(var/i=1;i<=5;i++)	src.SparCmds+=pick(1,2,4,8)
	src.SparTextOffsetX=rand(-1,1)
	src.SparTextOffsetY=rand(-1,1)
	src.UpdateShadowSpar()

mob/proc/UpdateShadowSpar()
	var/String=""
	for(var/i=src.SparCmds.len;i<5;i++)	String+="  "
	for(var/v in src.SparCmds)	switch(v)
		if(1)	String+="ô "
		if(2)	String+="ö "
		if(4)	String+="ò "
		if(8)	String+="º "
	src.UpdateHUDText("TrainingCombo","[String] +[src.TrainingCombo]% EXP")

mob/var/tmp/SparTextOffsetX=0
mob/var/tmp/SparTextOffsetY=0
mob/var/tmp/ShadowSparInpt
mob/var/tmp/LastShadowSparTime
mob/var/tmp/list/ShadowSparTimes
mob/proc/LogShadowSparTimes()
	if(!src.ShadowSparTimes)	src.ShadowSparTimes=list()
	src.ShadowSparTimes+=world.time-src.LastShadowSparTime
	src.TrackStat("Fastest Spar Combo",world.time-src.LastShadowSparTime,"Lowest")
	src.LastShadowSparTime=world.time
	if(src.ShadowSparTimes.len>=6)
		src.ShadowSparTimes=src.ShadowSparTimes.Copy(2)
		var/Matches=0;var/TooFast=0
		for(var/v in src.ShadowSparTimes)
			if(v<5)	{TooFast=v;break}
			if(v==src.ShadowSparTimes[1])	Matches+=1
		if(TooFast || Matches==src.ShadowSparTimes.len)
			var/Msg2Log="Matching Shadow Spar Times of [src.ShadowSparTimes[1]]"
			if(TooFast)	Msg2Log="Too Fast at [TooFast]"
			world.log<<"* [Msg2Log] by [src.key]"
			src.ShadowSparTimes=list()
			BLOCKSPAR
			src.ShadowSparInpt=rand(1,999999)
			var/ThisInput=input("You have Triggered a Macro Block\nInput the Following # to Continue: [src.ShadowSparInpt]","Shadow Spar Block") as num
			if(ThisInput!=src.ShadowSparInpt)	goto BLOCKSPAR
			src.ShadowSparInpt=0

mob/proc/ShadowAttack(var/Dir)
	if(!src.SparCmds)
		sleep
	if(Dir==src.SparCmds[1])
		src.dir=Dir
		PlaySound(view(),pick('Swing1.ogg','Swing2.ogg','Swing3.ogg'))
		flick(pick("punch1","punch2","kick1"),src)
		src.SparCmds.Cut(1,2);src.UpdateShadowSpar()
		if(!src.SparCmds.len)
			if(!src.ShadowSparInpt)
				src.TrackStat("Button Combos Completed",1)
				src.TrainingExp+=src.TrainingCombo;src.LogShadowSparTimes()
				if(src.TrainingCombo==99 && !src.GravityTraining)	src.GiveMedal(new/obj/Medals/ShadowSparMaster)
				src.TrainingCombo=min(src.GetMaxTrainingCombo("Shadow Sparring"),src.TrainingCombo+1)
			src.ShadowSpar()
			if(src.Fadiga>=100)
				src.Fadiga=100
				src.Revert()
				src.icon_state="koed"
				src.ForceCancelTraining()
				return
//			src.Fadiga+=pick(1,2,3,4,5,6)
			var/chan=pick(1,2,3,4,5,6)
			if(chan==1)
				if(src.PLGeral<100000)
					src.MaxKi+=src.MaxKi*0.1
				else
					if(src.PLGeral>=100000 && src.PLGeral<1000000)
						src.MaxKi+=src.MaxKi*0.01
					else
						if(src.PLGeral>=1000000 && src.PLGeral<100000000)
							src.MaxKi+=src.MaxKi*0.001
						else	src.MaxKi+=src.MaxKi*0.0001
	else
		PlaySound(src,'NoBuzz.ogg')
		src.TrackStat("Button Combos Failed",1)
		if(!src.GravityTraining)	{src.AddTrainingExp();src.ForceCancelTraining()}
		else	src.Damage(src,round(src.MaxPL/10),0,"Gravidade")

mob/proc/ForceCancelTraining(/**/)
	if(src.Training)
		if(src.Training=="Focus Training")	src.StopFocusTraining=1
		else
			src.Training=0
			src.TrainingCombo=0
			src.TrainingStrike=0
			src.GravityTraining=0
			for(var/obj/gravidade/g in src.client.screen)
				src.client.screen-=g
			src.overlays+=global.Gravidade
			src.SparCmds=list()
			src.AddTrainingExp()
			for(var/client/C in src.ControlClients)
				C.screen-=src:TimedF	//TimedF : mob/Player/var
				C.mob.RemoveTrainingBG()
				C.mob.RemoveHudProtection()
				C.mob.UpdateHUDText("TrainingDesc")
				C.mob.UpdateHUDText("TrainingCombo")

mob/proc/AddTrainingExp()
	if(src.TrainingExp>=100000)	src.GiveMedal(new/obj/Medals/FocusedTrainer)
	src.AddExp(src.TrainingExp,"Training Exp");src.TrainingExp=0
	src.CompleteTutorial("Training Exp")

mob/proc
	GravityProc(var/atom/SourceAtom)
		var/Choice=alert("Gravidade:","Treino de Gravidade","Ligar","Desligar")
//		if(MyGetDist(src,SourceAtom)>world.view)	return
		src.CompleteTutorial("Additional Training")
		src=src.GetFusionMob()
		var/obj/gravidade/f=new
		if(Choice=="Ligar")
			if(src.GravityTraining==1)
				usr<<"A gravidade já está ligada!"
				usr<<sound('no.ogg')
				return
			src.GravityTraining=1
			src.client.screen+=f
			src.overlays+=global.Gravidade
		else
			src.GravityTraining=0
			for(var/obj/gravidade/g in src.client.screen)
				src.client.screen-=g
				src.overlays-=global.Gravidade
			if(src.Training=="Punching Bags" || src.Training=="Shadow Sparring")	src.ForceCancelTraining()
	ShadowSparProc(var/atom/SourceAtom)
		src=src.GetFusionMob()
		if(src.Training)	{src<<"Você já está treinando!";return}
		if(!src.CanAct())	{src<<"Você aparenta estar meio ocupado...";return}
	//	if(MyGetDist(src,SourceAtom)>world.view)	return
		src.ShowTutorial(Tutorials["Training Exp"])
		src.CompleteTutorial("Additional Training")
		src.TrainingCombo=0
		src.ShadowSpar()
	SparringPartnerProc(var/atom/SourceAtom)
		src=src.GetFusionMob()
		var/list/DamageMults=list("Fraco"=0.5,"Médio"=1,"Forte"=2)
		var/Difficulty=alert("Selecione a dificuldade","Spar Bot","Fraco","Médio","Forte")
		var/LevelModifier=DamageMults[Difficulty]
//		if(MyGetDist(src,SourceAtom)>world.view)	return
		if(src.Training)	{src<<"Você já está treinando!";return}
		if(!src.CanAct())	{src<<"Você aparenta estar meio ocupado...";return}
		if(src.SparringPartner)		{src<<"Você já está lutando!";return}
		src.CompleteTutorial("Additional Training")
		var/mob/CombatNPCs/Enemies/Sparring_Partner/P=new(src.loc)
		P.SetCharacter("[pick(AllCharacters)]")
		P.AddName("Spar Bot")
		P.name="[P.name] [Difficulty]"
		P.HasForcedTarget=1;P.StartTarget=src
		P.DamageMultiplier=LevelModifier
		P.LevelScale(round(src.Level*LevelModifier))
		P.NPC=2
		src.Guard(1);src.SparringPartner=P
		src.ShowTutorial(Tutorials["Start Sparring"])
	FocusTrainingProc(var/atom/SourceAtom)
		src=src.GetFusionMob()
		if(src.Training)	{src<<"Você já está treinando!";return}
		if(!src.CanAct())	{src<<"Você aparenta estar meio ocupado...";return}
//		if(MyGetDist(src,SourceAtom)>world.view)	return
		src.ShowTutorial(Tutorials["Training Exp"])
		ShowEffect(src.loc,"recovery")
		PlaySound(view(src),'recovery.ogg')
		src.CompleteTutorial("Additional Training")
		src.Training="Focus Training"
		src.icon_state="powerup"
//		src.AddAura()
		while(1)
			if(src.StopFocusTraining && src.Training=="Focus Training")
				src.StopFocusTraining=0
				src.Training=0;break
			if(src.Subscriber)	src.TrainingExp+=22
			src.TrainingExp+=22
			sleep(10)
		if(!src)	return
		if(src.Exp+src.TrainingExp>=100)	src.GiveMedal(new/obj/Medals/Lazy)
		src.AddTrainingExp()
		src.ResetIS();src.RemoveAura()

obj/Training
	icon='Other.dmi'
	TimedAttacks
		density=1
		proc/Attacked(var/mob/Player/M)
			if(!M.ControlClients)	return
			flick("[src.icon_state]Hit",src);PlaySound(view(),pick('HitLight1.ogg','HitLight2.ogg'))
			if(!M.Training)
				if(M.Fadiga>=100)
					M.Fadiga=100
					M.Revert()
					M.icon_state="koed"
					M.ForceCancelTraining()
					return
				M.Fadiga+=pick(1,2,3,4,5,6)
				var/furia=pick(1,2,3,4,5,6)
				if(furia==2)
					if(M.PLGeral<100000)
						var/valor=pick(0.2,0.3,0.4,0.5)
						M.Str+=M.Str*valor
					else
						if(M.PLGeral>=100000 && M.PLGeral<1000000)
							var/valor=pick(0.02,0.03,0.04,0.05)
							M.Str+=M.Str*valor
						else
							if(M.PLGeral>=1000000 && M.PLGeral<100000000)
								var/valor=pick(0.002,0.003,0.004,0.005)
								M.Str+=M.Str*valor
							else
								var/valor=pick(0.0002,0.0003,0.0004,0.0005)
								M.Str+=M.Str*valor
				return
			else
				PlaySound(view(),pick('Hit0.ogg','Hit1.ogg','Hit2.ogg','Hit3.ogg','Hit4.ogg'))
		Speed_Bag
			icon_state="SpeedBag"
		Punching_Bag
			icon_state="PunchingBag"