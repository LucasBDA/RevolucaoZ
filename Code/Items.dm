mob/var/list/ItemsInventory
mob/var/list/ItemsInventory2
var/list/AllEspeciais=typesof(/obj/Items/Especiais)-/obj/Items/Especiais
proc/PopulateAllEspeciais()
	for(var/v in AllEspeciais)
		AllEspeciais+=new v
		AllEspeciais-=v


obj/Items/Especiais
	icon='Tecnicas.dmi'
	Collect(var/mob/M)
//		if(M.Y=)	return
		if(!EmLista(M.ItemsInventory2))	M.ItemsInventory2=list()
		for(var/obj/Items/Especiais/R in M.ItemsInventory2)	if(R.type==src.type)
			R.suffix="";return
		M.ItemsInventory2+=new src.type
	Super_Saiyajin
		icon_state="1"
		name="Transformacao"
	Super_Kamehameha
		icon_state="2"
		name="Super Kamehameha"
	Kamehameha
		icon_state="3"
		name="Kamehameha"
	Kaioken
		icon_state="5"
		name="Kaio-Ken"
		Click()
			if(usr.Breaker==1)	return
			if(usr.IsUltra==1)	return
			if(usr.icon_state=="GenkiDamaCharge")	return
			if(usr.icon=='GokuSSGodSS1.dmi' || usr.icon=='GokuSSGodSS1K.dmi')
				if(usr.CoolDown4==0 && usr.Kaioken==0)
					usr.DamageMultiplier+=0.2
					usr.icon_state="powerup"
					usr.AddKaiokenAura()
					usr.Z1=1
					usr<<sound('BlueAura.ogg',repeat=1,channel=2)
					usr.AddKaiokenEffect()
					usr.AddBlueAura(usr)
					usr.icon='GokuSSGodSS1K.dmi'
					usr.UpdateFaceHUD()
					PlaySound(view(),'Kaioken.ogg')
					usr.CoolDown4=1
					usr.Kaioken=1
					sleep(100)
					usr.CoolDown4=0
					return
				if(usr.CoolDown4==0 && usr.Kaioken==1)
					usr.DamageMultiplier-=0.2
					usr.Kaioken=0
					flick("Guard",usr)
					usr.icon='GokuSSGodSS1.dmi'
					PlaySound(view(),'Descend.ogg')
					usr.UpdateFaceHUD()
					usr.RemoveKaiokenAura()
					usr.RemoveKaiokenEffect()
					usr.CoolDown4=1
					sleep(100)
					usr.CoolDown4=0
					return
				if(usr.CoolDown4==1 && usr.Kaioken==0)
					usr<<"<b>Espere até poder usar o Kaio-Ken novamente!"
					return
				if(usr.CoolDown4==1 && usr.Kaioken==1)
					usr<<"<b>Espere até poder usar o Kaio-Ken novamente!"
					return
			if(usr.icon=='GokuBattleDamaged1.dmi' || usr.icon=='Goku Mid.dmi' || usr.icon=='GokuKaioken.dmi')
				if(usr.CoolDown4==0 && usr.Kaioken==0)
					usr.DamageMultiplier+=0.1
					flick("transform2",usr)
					usr.icon='GokuKaioken.dmi'
					usr.UpdateFaceHUD()
					usr.AddRAura(usr)
					PlaySound(view(),'Kaioken.ogg')
					usr.CoolDown4=1
					usr.Kaioken=1
					sleep(100)
					usr.CoolDown4=0
					return
				if(usr.CoolDown4==0 && usr.Kaioken==1)
					usr.DamageMultiplier-=0.1
					usr.Kaioken=0
					flick("revert",usr)
					PlaySound(view(),'Descend.ogg')
					usr.icon='Goku Mid.dmi'
					usr.UpdateFaceHUD()
					usr.DeleteRAura(usr)
					usr.CoolDown4=1
					sleep(100)
					usr.CoolDown4=0
					return
				if(usr.CoolDown4==1 && usr.Kaioken==0)
					usr<<"<b>Espere até poder usar o Kaio-Ken novamente!"
					return
				if(usr.CoolDown4==1 && usr.Kaioken==1)
					usr<<"<b>Espere até poder usar o Kaio-Ken novamente!"
					return
	Masenko
		icon_state="6"
		name="Masenko"
	Big_Bang
		icon_state="7"
		name="Big Bang"
	Final_Flash
		icon_state="8"
		name="Final Flash"
	Galick_Gun
		icon_state="9"
		name="Galick Ho"
	Makankosappo
		icon_state="10"
		name="Makankosappo"
	Kikoho
		icon_state="11"
		name="Kikoho"

	Death_Beam
		icon_state="13"
		name="Death Beam"
	Energy_Blast
		icon_state="14"
		name="Energy Blast"
	Burning_Attack
		icon_state="16"
		name="Burning Attack"
	Buster_Cannon
		icon_state="17"
		name="Buster Cannon"
	Finish_Buster
		icon_state="18"
		name="Finish Buster"
	Final_Shine
		icon_state="19"
		name="Final Shine"
	Fusion
		icon_state="20"
		name="Fusao Metamoru"
/*	GuardTapCooling
		icon_state="32"
		name="Defender"
		Click()
			usr.GuardTapCooling()*/
	Attack
		icon_state="31"
		name="Ataque"
		Click()
			usr.Attack()
	KiBlast
		icon_state="33"
		name="Blast"
		Click()
			usr.KiBlast()
	Mui
		icon_state="37"
		name="Instinto Superior"
		Click()
			if(usr.MajinForm==1 || usr.Quest11==2)
				usr<<sound('No.ogg',channel=1)
				alert(usr,"Você não pode utilizar essa técnica por enquanto!","Erro")
				return
			if(usr.Skill26==2)
				usr<<sound('No.ogg',channel=1)
				alert(usr,"Você não pode utilizar essa técnica por enquanto!","Erro")
				return
			if(usr.Skill26==0)
				if(usr.Character.name=="Goku Super")
					usr.Revert()
					var/mob/Player/M=usr
					M.Skill26=2
					M.Revert()
					M.overlays=null
					M.Breaker=1
					M.icon='ShirtlessGoku.dmi'
					M.icon_state="none"
					M.Frozen=1
					M.Shocking=1
					sleep(190)
					world<<sound(null)//LimitBreaker
					world<<sound('Ultra.ogg')
					M.icon_state="spark"
					sleep(10)
					M.icon_state="ultra"
					world<<"<b><i>[M] <font color=[rgb(22,72,99)]>ressurge liberando uma energia gigantesca!"
					M.Coluna(M)
					M.Crater(M)
					sleep(400)
					M.AddName()
					M.AddClanName()
					M.icon_state=""
					M.dir=2
					sleep(100)
					M.Frozen=0
					M.Shocking=0
					M.DamageMultiplier+=2.7
					world<<sound('LimitBreaker.ogg')
					M.NameColor="red"
					M.Character.BeamSpecial=new/CharSpecials/Hyper_Kame
					world<<"<b><i><font color=[rgb(22,72,99)]>O Ki de [M] está extremamente calmo e poderoso!"
					M.IsUltra=1
					M.GiveMedal(new/obj/Medals/Surpass_the_Gods)
					M.Breaker=0
					M.DelColuna(M)
					M.Skill26=1
					sleep(600*3)
					M.IsUltra=0
					M<<"<b><font color=[rgb(22,72,99)]>Você sente seu corpo voltar ao normal!"
					M.DamageMultiplier-=2.7
					M.NameColor="red"
					M.Character=new/obj/EvolCharacters/Goku_Super
					M.Character.BeamSpecial=new/CharSpecials/KameHameHa
					M.Revert()
					M.icon=M.Character.icon
					M.UpdatePartyIcon()
					M.UpdateFaceHUD()
					M.ResetSuffix()
					M.AddHUD()
					M.icon=M.Character.icon
					M.Probabilidade=0
					sleep(600*8)
					M.Skill26=0
			else
				usr<<sound('No.ogg',channel=1)
				alert(usr,"Você não pode utilizar essa técnica por enquanto!","Erro")
				return
//	StrongAttacking
//		icon_state="30"
//		name="Ataque"
//		Click()
//			usr.StrongAttacking()
	Rest
		icon_state="22"
		name="Descansar"
		Click()
			if(usr.Breaker==1)	return
			if(usr.icon_state=="koed")	return
			if(usr.IsUltra==1)	return
			if(usr.CoolDown3==1)	return
			usr.CoolDown3=1
			while(1)
				usr.icon_state="powerup"
				usr.X1=1
				usr.Fadiga-=pick(7,8,9,10,11,12)
				if(usr.Fadiga<=0)
					usr.Fadiga=0
					usr.CoolDown3=0
					usr.X1=0
					usr.icon_state=""
					break
				sleep(20)
	Kamehameha10
		icon_state="23"
		name="10x Kamehameha"
	Blaster
		icon_state="26"
		name="Blaster Shell"
	Aprimoramento
		icon_state="27"
		name="Aprimoramento"
	Kaioshin
		icon_state="31"
		Click()
			if(usr.Breaker==1)	return
			if(usr.IsUltra==1)	return
			if(usr.icon_state=="GenkiDamaCharge")	return
			var/Choice=alert("Para onde deseja ir?","Kaioshin","Terra","Namekuzei","Planeta dos Kaioshins","Planeta do Deus da Destruição")
			if(Choice=="Terra")
				for(var/mob/M in usr.loc)
					M.loc=locate(211,244,1)
			else
				if(Choice=="Namekuzei")
					for(var/mob/M in usr.loc)
						M.loc=locate(346,152,7)
				if(Choice=="Planeta dos Kaioshins")
					for(var/mob/M in usr.loc)
						M.loc=locate(284,168,3)
				if(Choice=="Planeta do Deus da Destruição")
					for(var/mob/M in usr.loc)
						M.loc=locate(211,244,1)