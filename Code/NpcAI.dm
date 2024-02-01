mob/proc/MatchFlight(var/mob/M)
	if(src.density!=M.density)
		if(src.density==1)	src.Fly()
		else
			var/CanLand=0;src.density=1
			var/turf/T=get_step(src,SOUTH)
			if(T.Enter(src))	CanLand=1
			src.density=0;if(CanLand)	src.Land()

mob/CombatNPCs
	var/GuardAI=1
	NPC=4
	var/turf/StartLoc
	var/HasForcedTarget
	proc/CombatAI()
		while(1)
			var/SleepTime=1
			if(src.CanAct() || src.StrongAttacking)
				if(src.HasForcedTarget && !src.StartTarget)	{del src;return}
				if(src.StartTarget && (abs(src.x-src.Target.x)>13 || abs(src.y-src.Target.y)>8))	{src.StartTarget.SparringPartner=null;del src;return}
				for(var/mob/Player/P)
					if(src.Clonagem2==1 && P.name==src.name && P.Clonagem==1)
						src.Target=P.Target
				if(!initial(src.z) || src.z==initial(src.z))
					if(src.StartTarget && (abs(src.x-src.Target.x)<=13 || abs(src.y-src.Target.y)<=8))	src.Target=src.StartTarget
					if(src.Target && (abs(src.x-src.Target.x)>13 || abs(src.y-src.Target.y)>8))	src.Target=null
					if(!src.Target)	for(var/mob/M in oview())
						if(M.GhostMode || M.Team==src.Team)	continue
						if(src.Owner && !src.Owner.CanPVP(M))	if(!src.InTournament || !M.InTournament)	continue
						for(var/mob/T in view(M)-src.Owner)	if(T.Team==src.Team && T.Target==M)	goto SKIPTARG
						src.Target=M;break
						SKIPTARG
					if(src.Target)
						src.CancelSmartFollow()
						var/mob/Player/M=src.Target
						if(abs(src.x-src.Target.x)>13 || abs(src.y-src.Target.y)>8)
							src.Target=null
							goto GOTO
						if(rand(1,100)<=10 && src.Target.TeleCountering==src)	{src.Guard();src.GuardRelease();goto GOTO}
						if(src.Ki<round(src.MaxKi*10/100) && (get_dist(src,M)>2 || M.PL<=0))	{spawn(-1)	src.PowerUp();goto GOTO}
						else	src.PowerUpRelease()
						src.MatchFlight(M)
						if(src.loc==M.loc)	step_rand(src)
						src.dir=get_dir(src,M)
						if((M.icon_state=="charge" || M.icon_state=="charge2") && (M.x==src.x || M.y==src.y) && get_dist(src,M)>=3 && rand(1,100)<=50)	{src.ChargeBeam();goto GOTO}
						if(M.PL<=0)
							if(!M.HasPerk("Fighting Spirit"))	sleep(20)
							src.KiBlast();goto GOTO
						if(M in get_step(src,src.dir))
							if(M.icon_state=="Guard")	if(rand(1,100)<=25)	{spawn(-1)	src.StrongAttack();goto GOTO}
							else	if(src.StrongAttacking)	{src.StrongAttackRelease();sleep(rand(1,3))}
							src.Attack();goto GOTO
						if(MyGetDist(src,M)>1)	{step_to(src,M);SleepTime=4;goto GOTO}
					else	if(src.Owner)
						if(src.InTournament || src.Owner.InTournament)
							if(global.TournRegMode!="Parties")	src.LeaveParty()
							goto NoFOLLOW
						src.MatchFlight(src.Owner)
						if(!src.SmartFollowTarget)	src.SmartFollow(src.Owner,rand(1,3))
						NoFOLLOW
					GOTO
				if(!src.Target)
					SleepTime=5
					src.ResetIS()
					src.AddPlPercent(100)
					src.AddKiPercent(100)
					for(var/mob/Player/P)
						if(src.Clonagem2==1 && P.name==src.name && P.Clonagem==1)
							src.Target=P.Target
							walk_towards(src,P,MovementSpeed)
					src.TargetMob()
					if(src.StartLoc  && src.z==src.StartLoc.z)	src.loc=src.StartLoc
			else	if(src.GuardAI)
				if(src.HitStun || src.JustBlocked || src.icon_state=="KnockBack")	if(rand(1,5)==1)	src.Guard()
				else	if(src.icon_state=="Guard")	src.GuardRelease(rand(1,100)<=50 ? 0 : 1)
			if(src.icon_state=="koed")	{src.GuardRelease();SleepTime=rand(3,5)}
			sleep(SleepTime)
mob/Enemy
	Team="Enemy"
	PowerMode="Ambos"
	NPC=1
	var/GuardAI=1
	var/turf/StartLoc
	var/HasForcedTarget
	proc/CombatAI()
		while(1)
			var/SleepTime=1
			if(src.CanAct() || src.StrongAttacking)
				for(var/mob/Player/P)
					if(src.icon=='Android17.dmi' || src.icon=='Android18.dmi')
						if(P.x==src.x || P.y==src.y)
							if(src.PL==src.MaxPL && src.z==2)
								src.Target=P
								src.PL-=1
					if(src.icon=='GoldenFreeza.dmi' || src.icon=='Janemba.dmi')
						if(P.x==src.x || P.y==src.y)
							if(src.PL==src.MaxPL)
								src.Target=P
								src.PL-=1
				if(src.icon=='TeenGohanSS2.dmi' && src.icon_state!="none")	src.AddSSAura()
				if(src.HasForcedTarget && !src.StartTarget)	{del src;return}
				if(src.StartTarget && (abs(src.x-src.Target.x)>13 || abs(src.y-src.Target.y)>8))	{src.StartTarget.SparringPartner=null;del src;return}
				if(!initial(src.z) || src.z==initial(src.z))
					if(src.StartTarget && (abs(src.x-src.Target.x)<=13 || abs(src.y-src.Target.y)<=8))	src.Target=src.StartTarget
					if(src.Target && (abs(src.x-src.Target.x)>13 || abs(src.y-src.Target.y)>8))	src.Target=null
					if(!src.Target)	for(var/mob/M in oview())
						if(M.GhostMode || M.Team==src.Team)	continue
						if(src.Owner && !src.Owner.CanPVP(M))	if(!src.InTournament || !M.InTournament)	continue
						for(var/mob/T in view(M)-src.Owner)	if(T.Team==src.Team && T.Target==M)	goto SKIPTARG
						src.Target=M;break
						SKIPTARG
					if(src.Target)
						if(src.PL<src.MaxPL)
							src.CancelSmartFollow()
							var/mob/Player/M=src.Target
							if(abs(src.x-src.Target.x)>13 || abs(src.y-src.Target.y)>8)
								src.Target=null
								goto GOTO
							if(rand(1,100)<=10 && src.Target.TeleCountering==src)	{src.Guard();src.GuardRelease();goto GOTO}
							if(src.Ki<round(src.MaxKi*10/100) && (get_dist(src,M)>2 || M.PL<=0))	{spawn(-1)	src.PowerUp();goto GOTO}
							else	src.PowerUpRelease()
							src.MatchFlight(M)
							if(src.loc==M.loc)	step_rand(src)
							src.dir=get_dir(src,M)
							if((M.icon_state=="charge" || M.icon_state=="charge2") && (M.x==src.x || M.y==src.y) && get_dist(src,M)>=3 && rand(1,100)<=50)
								if(src.icon!='GoldenFreeza.dmi')
									src.ChargeBeam()
									goto GOTO
								else	{flick("IT",src);PlaySound(view(),'InstantTransmission.ogg');src.loc=M.loc}
							if(M.icon_state=="powerup")
								if(src.icon=='GotenksSS3.dmi' || src.icon=='GTTrunksSS1.dmi' || src.icon=='GTGotenSS.dmi' || src.icon=='VegetaSS4.dmi' || src.icon=='AltGokuSS4.dmi' || src.icon=='SATrunksSS1.dmi' || src.icon=='SAVegetaUSS1.dmi' || src.icon=='GokuSS1.dmi' || src.icon=='GokuSS2.dmi' || src.icon=='GokuSS3.dmi' || src.icon=='TeenGohanCloakSS1.dmi' || src.icon=='AltVegetaMajinSS2.dmi' || src.icon=='GokuMidBattleDamageSS1.dmi')
									src.AddSSAura()
									src.PowerUp()
									if(src.MaxPL==src.PL)
										src.PL-=1
								if(src.icon=='Saibaman.dmi' || src.icon=='CellPerfectForm.dmi')
									src.AddGAura()
									src.PowerUp()
									if(src.MaxPL==src.PL)
										src.PL-=1
								if(src.icon=='MechaFreeza.dmi' || src.icon=='FriezaForm3.dmi' || src.icon=='FriezaForm2.dmi' || src.icon=='Frieza.dmi' || src.icon=='BootenksBottom.dmi' || src.icon=='BoohanBottom.dmi' || src.icon=='EvilBooBottom.dmi' || src.icon=='FatBooBottom.dmi' || src.icon=='SuperBooBottom.dmi' || src.icon=='KidBuu.dmi' || src.icon=='FriezaForm4.dmi' || src.icon=='Janemba.dmi')
									src.AddPAura()
									src.PowerUp()
									if(src.MaxPL==src.PL)
										src.PL-=1
								if(src.icon=='Super17.dmi' || src.icon=='Android17.dmi' || src.icon=='Android18.dmi')
									src.PowerUp()
									if(src.MaxPL==src.PL)
										src.PL-=1
								if(src.icon=='KidTrunks.dmi' || src.icon=='Goten.dmi' || src.icon=='Trunks.dmi' || src.icon=='Dodoria.dmi' || src.icon=='Zarbon.dmi' || src.icon=='Salza.dmi' || src.icon=='FriezaHenchman.dmi' || src.icon=='Doore.dmi' || src.icon=='ScouterVegeta.dmi' || src.icon=='Nappa.dmi' || src.icon=='OmegaShenron.dmi' || src.icon=='Baby2.dmi' || src.icon=='BabyVegeta.dmi' || src.icon=='CellJr.dmi' || src.icon=='Raditz.dmi' || src.icon=='SAVegeta.dmi' || src.icon=='SATrunks.dmi' || src.icon=='Yamcha.dmi' || src.icon=='Krillin.dmi' || src.icon=='Tien.dmi' || src.icon=='PiccoloForm3.dmi' || src.icon=='ScouterVegeta.dmi' || src.icon=='Goku Mid.dmi' || src.icon=='PiccoloTrainedGohan.dmi' || src.icon=='NamekGohan.dmi')
									src.AddWAura()
									src.PowerUp()
									if(src.MaxPL==src.PL)
										src.PL-=1
							if(src.icon_state!="powerup" && src.icon!='TeenGohanSS2.dmi')	{src.DeleteSSAura();src.DeleteWAura();src.DeleteRAura(src);src.DeleteGAura();src.DeletePAura()}
							if(M.PL<=0)
								if(!M.HasPerk("Fighting Spirit"))	sleep(1)
								src.KiBlast();goto GOTO
							if(M.icon_state=="koed")
								src.KiBlast()
							if(src.Fighting==1)
								src.Attack()
							if(M in get_step(src,src.dir))
								if(M.icon_state=="Guard" && src.icon!='robot.dmi')	if(rand(1,100)<=25)	{spawn(-1)	src.StrongAttackNPC();goto GOTO}
								if(M.icon_state=="Guard" && src.icon=='robot.dmi')	if(rand(1,100)<=25)	{spawn(-1)	src.KiBlast();goto GOTO}
								else	if(src.StrongAttacking)	{src.StrongAttackRelease();sleep(rand(1,3))}
								src.Attack();goto GOTO
							if(MyGetDist(src,M)>1)	{step_to(src,M);SleepTime=4;goto GOTO}
					else	if(src.Owner)
						if(src.InTournament || src.Owner.InTournament)
							if(global.TournRegMode!="Parties")	src.LeaveParty()
							goto NoFOLLOW
						src.MatchFlight(src.Owner)
						if(!src.SmartFollowTarget)	src.SmartFollow(src.Owner,rand(1,3))
						NoFOLLOW
					GOTO
				if(src.Target==null)
					SleepTime=5
					src.ResetIS()
					src.AddPlPercent(100)
					src.AddKiPercent(100)
					src.IsDead=0
					if(src.StartLoc  && src.z==src.StartLoc.z)	src.loc=src.StartLoc
			else	if(src.GuardAI)
				if(src.HitStun || src.JustBlocked || src.icon_state=="KnockBack")	if(rand(1,5)==1)	src.Guard()
				else	if(src.icon_state=="Guard")	src.GuardRelease(rand(1,100)<=50 ? 0 : 1)
			if(src.icon_state=="koed")	{src.GuardRelease();SleepTime=rand(1,2)}
			if(src.icon=='TeenGohanSS2.dmi')	src.AddSSAura()
			sleep(SleepTime)
mob/Gods
	var/GuardAI=1
	var/turf/StartLoc
	var/HasForcedTarget
	proc/CombatAI()
		while(1)
			var/SleepTime=1
			if(src.CanAct() || src.StrongAttacking)
				if(src.HasForcedTarget && !src.StartTarget)	{del src;return}
				if(src.StartTarget && (abs(src.x-src.Target.x>13) || abs(src.y-src.Target.y>8)))	{src.StartTarget.SparringPartner=null;del src;return}
				if(!initial(src.z) || src.z==initial(src.z))
					if(src.StartTarget)	src.Target=src.StartTarget
					if(src.Target && (abs(src.x-src.Target.x>13) || abs(src.y-src.Target.y>8)))	src.Target=null
					if(!src.Target)	for(var/mob/M in oview())
						if(M.GhostMode || M.Team==src.Team)	continue
						if(src.Owner && !src.Owner.CanPVP(M))	if(!src.InTournament || !M.InTournament)	continue
						for(var/mob/T in view(M)-src.Owner)	if(T.Team==src.Team && T.Target==M)	goto SKIPTARG
						src.Target=M;break
						SKIPTARG
					if(src.Target)
						src.CancelSmartFollow()
						var/mob/Player/M=src.Target
						if(abs(src.x-src.Target.x)>13 || abs(src.y-src.Target.y)>8)
							src.Target=null
							goto GOTO
						if(rand(1,100)<=10 && src.Target.TeleCountering==src)	{src.Guard();src.GuardRelease();goto GOTO}
						if(src.Ki<round(src.MaxKi*10/100) && (get_dist(src,M)>2 || M.PL<=0))	{spawn(-1)	src.PowerUp();goto GOTO}
						else	src.PowerUpRelease()
						src.MatchFlight(M)
						if(src.loc==M.loc)	step_rand(src)
						src.dir=get_dir(src,M)
						if(M.icon_state=="charge" && (M.x==src.x || M.y==src.y) && get_dist(src,M)>=3 && rand(1,100)<=50)	{flick("IT",src);PlaySound(view(),'InstantTransmission.ogg');src.loc=M.loc;goto GOTO}
						if(M.icon_state=="powerup")	{src.PowerUp()}
						if(M.icon_state=="kiblast" || M.icon_state=="KiBlast2")
							src.Attack()
						if(M.PL<=0)
							if(!M.HasPerk("Espirito de Lutador"))
								src.AddKiPercent(50)
								src.ChargeBeam()
								src.KiBlast()
								goto GOTO
							else
								src.KiBlast()
						if(M in get_step(src,src.dir))
							if(M.icon_state=="Guard")
								src.KiBlast()
								if(rand(1,100)<=25)	{spawn(-1)	goto GOTO}
							else	if(src.StrongAttacking)	{src.StrongAttackRelease();sleep(rand(1,3))}
							src.Attack();goto GOTO
						if(MyGetDist(src,M)>1)	{step_to(src,M);SleepTime=4;goto GOTO}
					else	if(src.Owner)
						if(src.InTournament || src.Owner.InTournament)
							if(global.TournRegMode!="Parties")	src.LeaveParty()
							goto NoFOLLOW
						src.MatchFlight(src.Owner)
						if(!src.SmartFollowTarget)	src.SmartFollow(src.Owner,rand(1,3))
						NoFOLLOW
					GOTO
				if(!src.Target)
					SleepTime=5
					src.ResetIS()
					src.AddPlPercent(100)
					src.AddKiPercent(100)
					if(src.StartLoc  && src.z==src.StartLoc.z)	src.loc=src.StartLoc
			else	if(src.GuardAI)
				if(src.HitStun || src.JustBlocked || src.icon_state=="KnockBack")	if(rand(1,5)==1)	src.Guard()
				else	if(src.icon_state=="Guard")	src.GuardRelease(rand(1,100)<=50 ? 0 : 1)
			if(src.icon_state=="koed")	{src.GuardRelease();SleepTime=rand(3,5)}
			sleep(SleepTime)

mob/Tutorial
	var/GuardAI=1
	var/turf/StartLoc
	var/HasForcedTarget
	proc/CombatAI()
		while(1)
			var/SleepTime=1
			if(src.CanAct() || src.StrongAttacking)
				if(src.HasForcedTarget && !src.StartTarget)	{del src;return}
				if(src.StartTarget && (abs(src.x-src.Target.x>12) || abs(src.y-src.Target.y>7)))	{src.StartTarget.SparringPartner=null;del src;return}
				if(!initial(src.z) || src.z==initial(src.z))
					if(src.StartTarget)	src.Target=src.StartTarget
					if(src.Target && (abs(src.x-src.Target.x>12) || abs(src.y-src.Target.y>7)))	src.Target=null
					if(!src.Target)	for(var/mob/M in oview())
						if(M.GhostMode || M.Team==src.Team)	continue
						if(src.Owner && !src.Owner.CanPVP(M))	if(!src.InTournament || !M.InTournament)	continue
						for(var/mob/T in view(M)-src.Owner)	if(T.Team==src.Team && T.Target==M)	goto SKIPTARG
						src.Target=M;break
						SKIPTARG
					if(src.Target)
						src.CancelSmartFollow()
						var/mob/Player/M=src.Target
						if(abs(src.x-src.Target.x>12) || abs(src.y-src.Target.y>7))
							src.Target=null
							goto GOTO
						if(rand(1,100)<=10 && src.Target.TeleCountering==src)	{src.Guard();src.GuardRelease();goto GOTO}
						if(src.Ki<round(src.MaxKi*10/100) && (get_dist(src,M)>2 || M.PL<=0))	{spawn(-1)	src.PowerUp();goto GOTO}
						else	src.PowerUpRelease()
						src.MatchFlight(M)
						if(src.loc==M.loc)	step_rand(src)
						src.dir=get_dir(src,M)
						if(M.icon_state=="charge" && (M.x==src.x || M.y==src.y) && get_dist(src,M)>=3 && rand(1,100)<=50)	{flick("IT",src);PlaySound(view(),'InstantTransmission.ogg');src.loc=M.loc;goto GOTO}
						if(M.icon_state=="powerup")	{src.PowerUp()}
						if(M.PL<=0)
							if(!M.HasPerk("Fighting Spirit"))	sleep(20)
							src.Guard();goto GOTO
						if(M in get_step(src,src.dir))
							if(M.icon_state=="Guard")	if(rand(1,100)<=25)	{spawn(-1)	goto GOTO}
							else	if(src.StrongAttacking)	{src.StrongAttackRelease();sleep(rand(1,3))}
							src.Attack();goto GOTO
						if(MyGetDist(src,M)>1)	{step_to(src,M);SleepTime=4;goto GOTO}
					else	if(src.Owner)
						if(src.InTournament || src.Owner.InTournament)
							if(global.TournRegMode!="Parties")	src.LeaveParty()
							goto NoFOLLOW
						src.MatchFlight(src.Owner)
						if(!src.SmartFollowTarget)	src.SmartFollow(src.Owner,rand(1,3))
						NoFOLLOW
					GOTO
				if(!src.Target)
					SleepTime=5
					src.ResetIS()
					src.AddPlPercent(100)
					src.AddKiPercent(100)
					if(src.StartLoc  && src.z==src.StartLoc.z)	src.loc=src.StartLoc
			else	if(src.GuardAI)
				if(src.HitStun || src.JustBlocked || src.icon_state=="KnockBack")	if(rand(1,5)==1)	src.Guard()
				else	if(src.icon_state=="Guard")	src.GuardRelease(rand(1,100)<=50 ? 0 : 1)
			if(src.icon_state=="koed")	{src.GuardRelease();SleepTime=rand(3,5)}
			sleep(SleepTime)
