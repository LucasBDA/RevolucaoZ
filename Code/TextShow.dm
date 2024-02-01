

proc/Text(mob/M,var/Text="")
	var/Blank = " " // This is going to start as blank...and gradually have new letters added one by one.
	winset(M, "TextNPC", "is-visible=true;pos=580,100")
	M.Frozen=1
	M.Chat=1
	while(length(Blank)<length(Text)) //While we still did not show all letters...
		sleep(0.5) //Speed
		Blank = addtext(Blank,"[getCharacter(Text,length(Blank))]")// Add in the next letter.
		M <<output(null,"TextNPC.output3") //Clean up our output from the previous text.
		M <<output("<font size=3>[Blank]","TextNPC.output3") //Output the new text with the new letter.
		M.SetFocus("default.map1")
		if(length(Blank)>=length(Text)) //If this was the last letter.
			return // That's it! We're done.

proc
	getCharacter(string, pos=1)
		return ascii2text(text2ascii(string, pos)) //This proc is used to retrieve the next character in text string.
		/*
mob/Login()
	Text(src,"This is some text. Do you see it? Of course you do! Now press Z to speed up. Release Z to slow it down! Cool huh? ")*/

mob/verb/Falar()
	set hidden=1
	for(var/obj/NPCs/N in world)
		if(get_dist(N.loc,src.loc)<2 && src.Chat==0)

			if(N.name=="Vendendor de Itens")
				Text(src, "[N.Frase]")
				winset(usr,"Roupas","is-visible=true")

			if(N.name=="Vendendor de Roupas")
				Text(src, "Olá, [src.name]! [N.Frase]")
				switch(Switch(src,"Basta escolher qual roupa você quer!",list("Camisa do Kame","Armadura Superior Yardrat","Nenhuma"),1,1))
					if("Camisa do Kame")
						var/obj/items/Roupas/KameGiShirt/K=new(src.loc)
						K.x-=1
						K.Dono=usr
						Alert(usr,"Ótimo! Aqui está a sua roupa! Basta clicar duas vezes para pegá-la.",,1,1)
					if("Armadura Superior Yardrat")
						var/obj/items/Roupas/YardratShirt/K=new(src.loc)
						K.x-=1
						Alert(usr,"Ótimo! Aqui está a sua roupa! Basta clicar duas vezes para pegá-la.",,1,1)
					if("Nenhuma")	return



mob/verb/Spd()
	set hidden = 1
	src.Frozen=0
	src.Chat=0
	src <<output(null,"TextNPC.output3")
	winset(src, "TextNPC", "is-visible=false")