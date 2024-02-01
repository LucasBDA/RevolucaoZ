obj/HUD
	layer=10
	EnemyPlBar
		layer=11
		icon='EnemyPlBar1.dmi'
		screen_loc="13:14,17:2"
	EnemyKiBar
		layer=11
		icon='EnemyKiBar1.dmi'
		screen_loc="13:13,17:-1"
	EnemyFaceIcon
		layer=11
		icon_state="none"
		screen_loc="17:-10,17:-7"

mob/proc/UpdateEnemyHUD()
	src.UpdateEnemyKiHUD()
	src.UpdateEnemyPlHUD()
	src.UpdateEnemyFaceHUD()
	src.UpdateEnemyGuardHUD()

mob/proc/UpdateEnemyFaceHUD()
	for(var/client/C in src.ControlClients)
		for(var/obj/HUD/EnemyFaceIcon/I in C.screen)
			if(src.Target)	I.icon=src.Target.icon
			else	I.icon=null
			return

mob/proc/UpdateEnemyGuardHUD()
	for(var/client/C in src.ControlClients)
		if(!ismob(C.mob.Target))
			for(var/obj/O in C.mob.EnemyGuardBarList)	O.icon_state=""
			return
		var/counter
		for(var/obj/HUD/EnemyGuardBar/G in C.mob.EnemyGuardBarList)
			G.icon_state="[min(32,100-C.mob.Target.GuardLeft-counter*32)]"
			counter+=1

mob/var/list/EnemyPlBars[4]
mob/proc/UpdateEnemyPlHUD()
	for(var/client/C in src.ControlClients)
		if(!ismob(src.Target))
			for(var/obj/O in C.mob.EnemyPlBars)	O.icon_state="invis"
			return
		var/ThisPercent=round(src.Target.PL/src.Target.MaxPL*100)
		for(var/i=1;i<=4;i++)
			if(!C.mob.EnemyPlBars[i])
				var/obj/HUD/EnemyPlBar/PLB=new
				PLB.screen_loc="23:[29-(32*(i-1))],18:32" //PARTE PRA EDITAR PL
				if(i==2 || i==3)	PLB.icon='EnemyPlBar2.dmi'
				if(i==4)	PLB.icon='EnemyPlBar3.dmi'
				C.screen+=PLB
				C.mob.EnemyPlBars[i]=PLB
			var/obj/HUD/PlBar/PLB=C.mob.EnemyPlBars[i]
			PLB.icon_state="[max(0,ThisPercent-(32*(i-1)))]"

mob/var/list/EnemyKiBars[4]
mob/proc/UpdateEnemyKiHUD()
	for(var/client/C in src.ControlClients)
		if(!ismob(src.Target))
			for(var/obj/O in C.mob.EnemyKiBars)	O.icon_state="invis"
			return
		var/ThisPercent=round(src.Target.Ki/src.Target.MaxKi*100)
		for(var/i=1;i<=4;i++)
			if(!C.mob.EnemyKiBars[i])
				var/obj/HUD/EnemyKiBar/PLB=new
				PLB.screen_loc="23:[32-(32*(i-1))],18:21" //PARTE PRA EDITAR KI
				if(i==2 || i==3)	PLB.icon='EnemyKiBar2.dmi'
				if(i==4)	PLB.icon='EnemyKiBar3.dmi'
				C.screen+=PLB
				C.mob.EnemyKiBars[i]=PLB
			var/obj/HUD/KiBar/PLB=C.mob.EnemyKiBars[i]
			PLB.icon_state="[max(0,ThisPercent-(32*(i-1)))]"