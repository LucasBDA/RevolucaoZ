mob/verb/ViewUpdates()
		set hidden=1
		set category="Ver"
		winset(usr,"TransformationsWindow","size=677x472;pos=100,100;is-visible=true")
var/list/Assassinos=list()
proc/ChecarAssassinos()
	for(var/mob/Player/P in world)
		if(P.Quest2>1)
			Assassinos+=P
		else	Assassinos-=P
mob/verb/NoHair()
	set hidden=1
	usr.TakeHair1()
	usr.TakeHair2()
	usr.TakeHair3()
	usr.TakeHair4()
	usr.TakeAntena1()
	usr.HairStyle=0
	usr.AntenaStyle=0
	winset(usr,"Hair","is-visible=false")
	winset(usr,"Antena","is-visible=false")
mob/verb/Hair1()
	set hidden=1
	usr.TakeHair1()
	usr.TakeHair2()
	usr.TakeHair3()
	usr.TakeHair4()
	usr.HairStyle=1
	usr.GenerateHair1()
	winset(usr,"Hair","is-visible=false")
mob/verb/Hair2()
	set hidden=1
	usr.TakeHair1()
	usr.TakeHair2()
	usr.TakeHair3()
	usr.TakeHair4()
	usr.HairStyle=2
	usr.GenerateHair2()
	winset(usr,"Hair","is-visible=false")
mob/verb/Hair3()
	set hidden=1
	usr.TakeHair1()
	usr.TakeHair2()
	usr.TakeHair3()
	usr.TakeHair4()
	usr.HairStyle=3
	usr.GenerateHair3()
	winset(usr,"Hair","is-visible=false")
mob/verb/Hair4()
	set hidden=1
	usr.TakeHair1()
	usr.TakeHair2()
	usr.TakeHair3()
	usr.TakeHair4()
	usr.HairStyle=4
	usr.GenerateHair4()
	winset(usr,"Hair","is-visible=false")

mob/verb/Skin3()
	set hidden=1
	for(var/obj/Characters/Saiyajin3/G in AllCharacters)
		usr.Character=new G.type
		usr.icon=usr.Character.icon
	winset(usr,"SaiyanSkin","is-visible=false")

mob/verb/Skin2()
	set hidden=1
	for(var/obj/Characters/Saiyajin2/G in AllCharacters)
		usr.Character=new G.type
		usr.icon=usr.Character.icon
	winset(usr,"SaiyanSkin","is-visible=false")

mob/verb/Skin1()
	set hidden=1
	for(var/obj/Characters/Saiyajin/G in AllCharacters)
		usr.Character=new G.type
		usr.icon=usr.Character.icon
	winset(usr,"SaiyanSkin","is-visible=false")

mob/verb/HSkin4()
	set hidden=1
	for(var/obj/Characters/Humano4/G in AllCharacters)
		usr.Character=new G.type
		usr.icon=usr.Character.icon
	winset(usr,"HumanSkin","is-visible=false")

mob/verb/HSkin3()
	set hidden=1
	for(var/obj/Characters/Humano3/G in AllCharacters)
		usr.Character=new G.type
		usr.icon=usr.Character.icon
	winset(usr,"HumanSkin","is-visible=false")

mob/verb/HSkin2()
	set hidden=1
	for(var/obj/Characters/Humano2/G in AllCharacters)
		usr.Character=new G.type
		usr.icon=usr.Character.icon
	winset(usr,"HumanSkin","is-visible=false")

mob/verb/HSkin1()
	set hidden=1
	for(var/obj/Characters/Humano1/G in AllCharacters)
		usr.Character=new G.type
		usr.icon=usr.Character.icon
	winset(usr,"HumanSkin","is-visible=false")


mob/verb/NamekSkin6()
	set hidden=1
	for(var/obj/Characters/Namek6/G in AllCharacters)
		usr.Character=new G.type
		usr.icon=usr.Character.icon
	if(usr.AntenaStyle==1)
		usr.TakeAntena1()
		usr.GenerateAntena1()
	winset(usr,"NamekSkin","is-visible=false")

mob/verb/NamekSkin5()
	set hidden=1
	for(var/obj/Characters/Namek5/G in AllCharacters)
		usr.Character=new G.type
		usr.icon=usr.Character.icon
	if(usr.AntenaStyle==1)
		usr.TakeAntena1()
		usr.GenerateAntena1()
	winset(usr,"NamekSkin","is-visible=false")

mob/verb/NamekSkin4()
	set hidden=1
	for(var/obj/Characters/Namek4/G in AllCharacters)
		usr.Character=new G.type
		usr.icon=usr.Character.icon
	if(usr.AntenaStyle==1)
		usr.TakeAntena1()
		usr.GenerateAntena1()
	winset(usr,"NamekSkin","is-visible=false")

mob/verb/NamekSkin3()
	set hidden=1
	for(var/obj/Characters/Namek3/G in AllCharacters)
		usr.Character=new G.type
		usr.icon=usr.Character.icon
	if(usr.AntenaStyle==1)
		usr.TakeAntena1()
		usr.GenerateAntena1()
	winset(usr,"NamekSkin","is-visible=false")

mob/verb/NamekSkin2()
	set hidden=1
	for(var/obj/Characters/Namek2/G in AllCharacters)
		usr.Character=new G.type
		usr.icon=usr.Character.icon
	if(usr.AntenaStyle==1)
		usr.TakeAntena1()
		usr.GenerateAntena1()
	winset(usr,"NamekSkin","is-visible=false")

mob/verb/NamekSkin1()
	set hidden=1
	for(var/obj/Characters/Namek1/G in AllCharacters)
		usr.Character=new G.type
		usr.icon=usr.Character.icon
	if(usr.AntenaStyle==1)
		usr.TakeAntena1()
		usr.GenerateAntena1()
	winset(usr,"NamekSkin","is-visible=false")

mob/verb/Antena1()
	set hidden=1
	usr.AntenaStyle=1
	usr.GenerateAntena1()
	winset(usr,"Antena","is-visible=false")

mob/verb/Event1()
	set hidden=1
	winset(usr,"window57","is-visible=true")
mob/verb/Event2()
	set hidden=1
	winset(usr,"window58","is-visible=true")
mob/verb/Event3()
	set hidden=1
	winset(usr,"window59","is-visible=true")
mob/verb/Event4()
	set hidden=1
	winset(usr,"window61","is-visible=true")
mob/verb/Regras()
	set hidden=1
	winset(usr,"window62","is-visible=true")
mob/verb/See()
	winset(usr,"Updates","is-visible=true")
mob/verb/Jgr()
	usr.Logg=1
	usr<<sound(null)
//			PlaySound(view(),'button.ogg')
	usr<<sound('button.ogg')

mob/verb/Outras()
	set hidden=1
	winset(usr,"Outros","size=669x544;pos=100,100;is-visible=true")
mob/verb/Assassinos()
		set hidden=1
		set category="Assassinos"
		var/mob/Assassino=input("Qual assassino você gostaria de checar?","Lista de Assassinos") in Assassinos
		usr<<"<b><font color=[rgb(213,13,183)]>[Assassino] \nRecompensas: \n[1000*Assassino.Quest2] Níveis \n[2000*Assassino.Quest2] Zennies"
