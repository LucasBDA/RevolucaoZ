
mob/verb
	FreeScaleMode()
		set hidden=1
		set category="Options"
		winset(src,"MainWindow.MainMap","is-default=false;is-visible=false")
		winset(src,"MainWindow.InfoPane","is-default=false;is-visible=false")
		winset(src,"MainWindow.ChatPanes","is-default=false;is-visible=false")
		winset(src,"FreeScaleWindow.InfoPane","is-default=true;is-visible=true")
		winset(src,"FreeScaleWindow.ChatPanes","is-default=true;is-visible=true")
		winset(src,"FreeScaleWindow.ScaleMap","is-default=true;is-visible=true")
		winset(src,"FreeScaleWindow","pos=0,0;size=620x620;is-visible=true")
		winset(src,"FreeScaleWindow","is-maximized=false;is-visible=true")
		winset(src,"FreeScaleWindow","is-maximized=true;is-visible=true")
	Full_Screen()
		set hidden=1
		set category="Options"
		winset(src,"MainWindow.MainMap","is-default=false;is-visible=false")
		winset(src,"FreeScaleWindow.ScaleMap","is-default=false;is-visible=false")
		winset(src,"FreeScaleWindow","is-visible=false")
		winset(src,"FullMapWindow.FullMap","is-default=true;is-visible=true")
		winset(src,"FullMapWindow","pos=100,100;size=620x620;is-maximized=true;is-visible=true")
	Visualizar()
		set hidden=1
		set category="Options"
		var/obj/Items/Especiais/O=input("Técnicas") as null|anything in usr.ItemsInventory2
		if(O.suffix=="")
			usr<<""
	DelTec()
		set hidden=1
		set category="Options"
		var/obj/Items/Especiais/O=input("Qual técnica você deseja deletar?","Deletar Técnica") as null|anything in usr.ItemsInventory2
		if(O.icon_state=="1")
			usr.Skill1=0
			del	O
			return
		if(O.icon_state=="2")
			usr.Skill2=0
			del	O
			return
		if(O.icon_state=="3")
			usr.Skill3=0
			del	O
			return
		if(O.icon_state=="4")
			usr.Skill4=0
			del	O
			return
		if(O.icon_state=="5")
			usr.Skill5=0
			del	O
			return
		if(O.icon_state=="6")
			usr.Skill6=0
			del	O
			return
		if(O.icon_state=="7")
			usr.Skill7=0
			del	O
			return
		if(O.icon_state=="8")
			usr.Skill8=0
			del	O
			return
		if(O.icon_state=="9")
			usr.Skill9=0
			del	O
			return
		if(O.icon_state=="10")
			usr.Skill10=0
			del	O
			return
		if(O.icon_state=="11")
			usr.Skill11=0
			del	O
			return
		if(O.icon_state=="12")
			usr.Skill12=0
			del	O
			return
		if(O.icon_state=="13")
			usr.Skill13=0
			del	O
			return
		if(O.icon_state=="14")
			alert("Essa técnica não pode ser deletada!")
			PlaySound(view(),'no.ogg')
			return
		if(O.icon_state=="15")
			usr.Skill15=0
			del	O
			return
		if(O.icon_state=="16")
			usr.Skill16=0
			del	O
			return
		if(O.icon_state=="17")
			usr.Skill17=0
			del	O
			return
		if(O.icon_state=="18")
			usr.Skill18=0
			del	O
			return
		if(O.icon_state=="19")
			usr.Skill19=0
			del	O
			return
		if(O.icon_state=="20")
			usr.Skill20=0
			del	O
			return
		if(O.icon_state=="21")
			usr.Skill21=0
			del	O
			return
		if(O.icon_state=="22")
			alert("Essa técnica não pode ser deletada!")
			PlaySound(view(),'no.ogg')
			return
		if(O.icon_state=="23")
			usr.Skill23=0
			del	O
			return
	Ignore_Duels()
		set hidden=1
		set category="Options"
		usr.IgnoreDuels=!usr.IgnoreDuels
		if(usr.IgnoreDuels)	usr<<"You are now Ignoring all Duel Requests"
		else	usr<<"You are now Accepting Duel Requests"

	Reset_Tutorials()
		set hidden=1
		//set name="Tutorial: Reset"
		set category="Options"
		if(alert("Clear all Completed Tutorial Tips?","Reset Tutorials","Reset","Cancel")=="Reset")	usr.TutsComplete=list()
		usr.GeneralTutorials()
	Review_Tutorials()
		set hidden=1
		//set name="Tutorial: Review"
		set category="Options"
		var/Choice=input("Select the Tutorial Tip to Review","Review Tutorials") as null|anything in usr.TutsComplete
		if(!Choice)	return
		var/obj/Tutorials/T=Tutorials[Choice]
		alert(T.desc,T.name)
	Song()
		set hidden=1
		set category="Options"
		var/Choice=input("Escolha uma música ou desligue-a","") in list("Desligar","1","2","3","4","5","6","7","8","9")
		if(Choice=="Desligar")
			usr<<sound(null,channel=1)
		if(Choice=="1")
			usr<<sound(null,channel=1)
			usr<<sound('Dragon Ball Z Theme 8.ogg',channel=1)
		if(Choice=="2")
			usr<<sound(null,channel=1)
			usr<<sound('Dragon Ball Z Theme 9.ogg',channel=1)
		if(Choice=="3")
			usr<<sound(null,channel=1)
			usr<<sound('Dragon Ball Z Theme 10.ogg',channel=1)
		if(Choice=="4")
			usr<<sound(null,channel=1)
			usr<<sound('Dragon Ball Z Theme 13.ogg',channel=1)
		if(Choice=="5")
			usr<<sound(null,channel=1)
			usr<<sound('Dragon Ball Z Theme 17.ogg',channel=1)
		if(Choice=="6")
			usr<<sound(null,channel=1)
			usr<<sound('Dragon Ball Z Theme 28.ogg',channel=1)
		if(Choice=="7")
			usr<<sound(null,channel=1)
			usr<<sound('Dragon Ball Z Theme 30.ogg',channel=1)
		if(Choice=="8")
			usr<<sound(null,channel=1)
			usr<<sound('Dragon Ball Z Theme 40.ogg',channel=1)
		if(Choice=="9")
			usr<<sound(null,channel=1)
			usr<<sound('Dragon Ball Z Theme 45.ogg',channel=1)
