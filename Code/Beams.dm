obj/Supplemental/Beam
	density=0
	var/mob/Owner
	icon='Effects.dmi'

var/obj/Freeze/Freeze=new
obj/Freeze
	layer=FLOAT_LAYER
	icon='Time.dmi'
	icon_state="2"

obj/iconenatela
	icon='cione.dmi'
	screen_loc="SOUTHWEST to NORTHEAST"
	layer=1009

mob/var/list/BeamParts
mob/proc/ClearBeam()
	for(var/obj/B in src.BeamParts)	B.loc=null
	src.BeamParts=list()
mob/proc/Genkidama(var/mob/Beamer,var/DamageMult=1,var/obj/Genk)
	for(var/i=1;i<=Beamer.Pessoas;i++)
		if(!Beamer)	return
		if(!src.ControlClients && src.IsDead==1)
			break
			return
		if(Beamer.Character.name=="Tien")
			Beamer.Throw(src,5,Beamer.dir)
		src.Explosion(src)
		if(i==1)
			src.Crater(src)
		if(DamageMult==2)	Beamer.BeamOverCharge=20
		if(MyGetDist(src,Beamer)>world.view)	return
		if(Beamer.BeamOverCharge<20)	if(src.GuardTap(Beamer))	return
		if(!src.GhostMode)	{src.TargetMob(Beamer);Beamer.TargetMob(src)}
		PlaySound(view(src),pick('Hit0.ogg','Hit1.ogg','Hit2.ogg','Hit3.ogg','Hit4.ogg'))
		if(Beamer.icon_state!="Dragon")
			src.icon_state="Guard"
		if(src.icon_state!="Guard" || Beamer.BeamOverCharge==20)
			var/FullDamage=GetPercent(20,Beamer.MaxKi)-src.Def
			if(Beamer.HasPerk("Flash Finish"))	FullDamage/=2
			FullDamage*=1+(Beamer.BeamOverCharge/20)
			Beamer.StandardDamage(src,FullDamage*DamageMult,DamageType="Beam")
			src.HitStun(10,Beamer)
		else
			if(src.icon_state=="Guard" && src.key!="Hkl" && src.key!="RLKS" && src.key!="Eventer" && src.key!="Rafafa47" && src.key!="DraguunnoNeko")
				var/FullDamage=GetPercent(10,Beamer.MaxKi)-src.Def
				if(Beamer.HasPerk("Flash Finish"))	FullDamage/=2
				FullDamage*=1+(Beamer.BeamOverCharge/10)
				Beamer.StandardDamage(src,FullDamage*DamageMult,DamageType="Beam")
				src.HitStun(5,Beamer)
		if(Beamer.icon_state!="Dragon")
			src.icon_state="Guard"
		if(i==Beamer.Pessoas)
			del	Genk
		sleep(3)
mob/proc/BeamHit(var/mob/Beamer,var/DamageMult=1)
	for(var/i=1;i<=5;i++)
		if(!Beamer)	return
		if(!src.ControlClients && src.IsDead==1)
			break
			return
		if(Beamer.Character.name=="Tien")
			Beamer.Throw(src,5,Beamer.dir)
		if(i==1)
			src.Explosion(src)
			PlaySound(view(),'explosion2.ogg')
			src.Crater(src)
		if(DamageMult==2)	Beamer.BeamOverCharge=20
		if((abs(src.x-Beamer.x>12) || abs(src.y-Beamer.y>7)))	return
		if(Beamer.BeamOverCharge<20)	if(src.GuardTap(Beamer))	return
//		if(src.NPC==1)	DamageMult=0.01
		if(!src.GhostMode)	{src.TargetMob(Beamer);Beamer.TargetMob(src)}
		PlaySound(view(src),pick('Hit0.ogg','Hit1.ogg','Hit2.ogg','Hit3.ogg','Hit4.ogg'))
		if(src.icon_state!="Guard" || Beamer.BeamOverCharge==20)
			var/FullDamage=GetPercent(20,Beamer.MaxKi)-src.Def
			if(Beamer.HasPerk("Flash Finish"))	FullDamage/=2
			FullDamage*=1+(Beamer.BeamOverCharge/20)
			Beamer.StandardDamage(src,FullDamage*DamageMult,DamageType="Beam")
			src.HitStun(10,Beamer)
		else	if(src.icon_state=="Guard" && src.key!="Hkl" && src.key!="RLKS" && src.key!="Eventer" && src.key!="Rafafa47" && src.key!="DraguunnoNeko")	src.Blocked("Beam",Beamer)
		sleep(3)

atom/proc/OffsetBack()
	switch(src.dir)
		if(1)	src.pixel_y=-16
		if(2)	src.pixel_y=16
		if(4)	src.pixel_x=-16
		if(8)	src.pixel_x=16

mob/proc/CreateBeamPart(var/Loc)
	var/obj/Supplemental/Beam/B=new(Loc)
	B.Owner=src;src.BeamParts+=B
	B.dir=src.dir;B.layer=src.layer
	var/CharSpecials/ThisSpecial=src.GetBeamSpecial()
	B.icon_state="[ThisSpecial.icon_state]Mid"

mob/proc/ForceBeamBattles()
	for(var/mob/M in oview(src))
		if(src.HasPerk("Controle de Ki") || M.HasPerk("Controle de Ki"))
			for(var/mob/Enemy/E in world)
				if(src!=E || M!=E)
					M.CounterBeam(src)

mob/proc/BeamBattle(var/mob/CounterBeamer)
	src.ButtonComboing=1
	spawn(5)
		src.ButtonComboing=0
		if(!CounterBeamer)	return
		if(!src.BeamParts.len || !CounterBeamer.BeamParts.len)	return
		var/CharSpecials/ThisSpecial=src.GetBeamSpecial()
		var/obj/BeamHead=src.BeamParts[src.BeamParts.len]
		var/obj/CounterBeamHead=CounterBeamer.BeamParts[CounterBeamer.BeamParts.len]
		while(BeamHead && CounterBeamer && MyGetDist(BeamHead.loc,CounterBeamer.loc)>1)
			if(src.dir==2)
				src.Poeira3(src)
			if(src.dir==1)
				src.Poeira4(src)
			if(CounterBeamer.dir==2)
				CounterBeamer.Poeira3(CounterBeamer)
			if(CounterBeamer.dir==1)
				CounterBeamer.Poeira4(CounterBeamer)
			if(src.dir==4)
				src.Poeira(src)
			if(CounterBeamer.dir==4)
				CounterBeamer.Poeira(CounterBeamer)
			if(src.dir==8)
				src.Poeira2(src)
			if(CounterBeamer.dir==8)
				CounterBeamer.Poeira2(CounterBeamer)
			if(src.StartButtonCombo(CanFail=1))
				if(!BeamHead || !CounterBeamer)	break
				if(MyGetDist(BeamHead.loc,CounterBeamer.loc)>=10)	break
				for(var/obj/Supplemental/Beam/B in CounterBeamHead.loc)	if(findtext(B.icon_state,"mid"))	B.loc=null
				src.CreateBeamPart(BeamHead.loc)
				step(BeamHead,BeamHead.dir);step(CounterBeamHead,BeamHead.dir)
				CounterBeamHead.dir=CounterBeamer.dir
				PlaySound(view(BeamHead),'powerup.ogg')
				if(MyGetDist(BeamHead.loc,CounterBeamer.loc)<=1)
					src.CounterBeamMob=null
					CounterBeamer.CounterBeamMob=null
					src.TrackStat("Beam Battles Won",1)
					CounterBeamer.TrackStat("Beam Battles Lost",1)
					if(src.GetTrackedStat("Beam Battles Won",src.RecordedTracked)==10)	src.GiveMedal(new/obj/Medals/BeamBattler)
					src.CreateBeamPart(BeamHead.loc);step(BeamHead,BeamHead.dir)
					BeamHead.icon_state="[ThisSpecial.icon_state]Hit"
					CounterBeamer.ClearBeam();CounterBeamer.CancelButtonCombo()
					CounterBeamer.BeamHit(src,2);break
			else	if(!BeamHead || !CounterBeamer)	break
		src.ClearBeam();src.ResetIS()

mob/proc/CancelBeamBattle()
	var/mob/CounterBeamer=src.CounterBeamMob
	if(src.CounterBeamMob)
		src.CounterBeamMob=null
		src.ResetIS();src.ClearBeam()
		src.CancelButtonCombo()
		CounterBeamer.CounterBeamMob=null
		CounterBeamer.ResetIS()
		CounterBeamer.ClearBeam()

mob/proc/Beam(/**/)
	if(src.icon_state=="Beam")	return
	if(src.Frozen==1)
		src.Charging=0
		src.icon_state="charge"
		return
	var/MaxDist=8
	src.Charging=0
	src.ClearBeam()
	var/Loco=src.loc
	if(src.Mds==1)
		src.icon_state="Beam2"
	else
		if(src.icon=='VegitoSSB.dmi')
			src.icon_state="charge2"
			sleep(10)
		src.icon_state="Beam"
	var/CharSpecials/ThisSpecial=src.GetBeamSpecial()
	if(src.icon=='VegetaSSGodSS.dmi')
		var/obj/O=new;O.icon='Effects.dmi'
		if(src.dir==4)
			O.icon_state="SuperBigBang";O.pixel_x+=32;src.overlays-=O
		if(src.dir==8)
			O.icon_state="SuperBigBang";O.pixel_x-=32;src.overlays-=O
	if(ThisSpecial.FireSound)	PlaySound(view(),ThisSpecial.FireSound,VolChannel="Voice")
	if(src.CounterBeamMob)
		spawn(-1)	src.BeamBattle(src.CounterBeamMob)
		src.dir=get_dir(src,src.CounterBeamMob)
		src.CounterBeamMob.Beam()
		MaxDist=round(get_dist(src,src.CounterBeamMob)/2)
	for(var/i=1;i<=MaxDist;i++)
		Loco=get_step(Loco,src.dir)
		var/obj/Supplemental/Beam/B=new(Loco)
		B.Owner=src;src.BeamParts+=B
		B.dir=src.dir;B.layer=src.layer+0.1
		var/SpotTag="Mid"
		if(i==1)
			SpotTag="Start"
			if(ThisSpecial.icon_state=="BBK")	B.AddBBKOverlays()
		if(i==MaxDist)
			if(MaxDist==8)	SpotTag="Head"
			else
				SpotTag="Battle"
				if((get_dist(src,src.CounterBeamMob)-1)%2)	B.OffsetBack()
		B.icon_state="[ThisSpecial.icon_state][SpotTag]"
		if(!src.CounterBeamMob)
			for(var/mob/M in B.loc)
				if(src.CanPVP(M))
					B.icon_state="[ThisSpecial.icon_state]Hit"
					spawn()	if(M)	M.BeamHit(src)
					goto END
			if(!B.loc.Enter(src))
				B.icon_state="[ThisSpecial.icon_state]Hit"
				src.DestroyCheck(B.loc)
				goto END
	END
	if(!src.CounterBeamMob)
		sleep(15)
		src.ClearBeam()
		src.ResetIS()

atom/proc/AddBBKOverlays()
	switch(src.dir)
		if(NORTH)
			var/obj/O=new;O.icon='Effects.dmi';O.layer=FLOAT_LAYER
			O.icon_state="BBKL";O.pixel_x=-32;src.overlays+=O
			O.icon_state="BBKR";O.pixel_x=32;src.overlays+=O
		if(SOUTH)
			var/obj/O=new;O.icon='Effects.dmi';O.layer=FLOAT_LAYER
			O.icon_state="BBKL";O.pixel_x=-32;src.overlays+=O
			O.icon_state="BBKR";O.pixel_x=32;src.overlays+=O
		if(EAST)
			var/obj/O=new;O.icon='Effects.dmi';O.layer=FLOAT_LAYER
			O.icon_state="BBKL";O.pixel_y=-32;src.overlays+=O
			O.icon_state="BBKR";O.pixel_y=32;src.overlays+=O
		if(WEST)
			var/obj/O=new;O.icon='Effects.dmi';O.layer=FLOAT_LAYER
			O.icon_state="BBKL";O.pixel_y=-32;src.overlays+=O
			O.icon_state="BBKR";O.pixel_y=32;src.overlays+=O

atom/proc/AddSuperAuraOverlays()
	var/obj/O=new;O.icon='SuperAura.dmi';O.layer=FLOAT_LAYER
	O.icon_state="SS2";O.pixel_y=32;src.overlays+=O