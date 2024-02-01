mob/var/list/ClothesInventory
var/list/AllClothes=list()
var/list/AllRoupas=typesof(/obj/items/Roupas)-/obj/items/Roupas
proc/PopulateAllRoupas()
	for(var/v in AllRoupas)
		AllRoupas+=new v
		AllRoupas-=v

obj/items/Roupas
//VARIÁVEIS PARA TODOS OS OBJETOS DO TIPO ITEMS/ROUPAS
	var/Equipado=0
	var/Descricao=""
	var/Tipo=""
	var/mob/Player/Dono
	layer=10
//-------------------------------

	verb/Equipar_ou_Desequipar()
		set src in world
		if(src in usr.contents)
			if(src.Equipado==0)
				for(var/obj/items/Roupas/I in usr.contents)
					if(I==src)	continue
					if(I.Tipo==src.Tipo && I.Equipado==1)
						usr.overlays-=I
						I.Equipado=0
						for(var/Grid/G in usr.client.screen)
							if(G.screen_loc==I.screen_loc)
								G.icon_state="Grid"
				src.Equipado=1
				src.icon_state=""
				usr.overlays+=src
				for(var/Grid/G in usr.client.screen)
					if(G.screen_loc==src.screen_loc)
						G.icon_state="GridEquiped"
			else
				usr.overlays-=src
				src.Equipado=0
				for(var/Grid/G in usr.client.screen)
					if(G.screen_loc==src.screen_loc)
						G.icon_state="Grid"
		else	Alert(usr,"Este item não está no seu inventário. Você não pode equipá-lo!",,1,1)

//CRIAÇÃO DOS OBJETOS

	KameGiShirt
		icon='KameGi_Shirt.dmi'
		icon_state=""
		name=""
		Descricao="Parte superior usada pelos alunos da escola da Tartaruga do Mestre Kame"
		Tipo="Torso Superior"

	YardratShirt
		icon='Yardrat_Shirt.dmi'
		name=""
		icon_state=""
		Descricao="Parte superior nativa dos habitantes do planeta Yardrat"
		Tipo="Torso Superior"

	MouseEntered()
		usr.Description(src)
		return ..()

	MouseExited()
		usr.CloseDescription()

	DblClick() //When you double click
		if(src in usr.contents) //If the item is inside my inventory
			if(src.Equipado==0)
				for(var/obj/items/Roupas/I in usr.contents)
					if(I==src)	continue
					if(I.Tipo==src.Tipo && I.Equipado==1)
						usr.overlays-=I
						I.Equipado=0
						for(var/Grid/G in usr.client.screen)
							if(G.screen_loc==I.screen_loc)
								G.icon_state="Grid"
				src.Equipado=1
				src.icon_state=""
				usr.overlays+=src
				for(var/Grid/G in usr.client.screen)
					if(G.screen_loc==src.screen_loc)
						G.icon_state="GridEquiped"
			else
				usr.overlays-=src
				src.Equipado=0
				for(var/Grid/G in usr.client.screen)
					if(G.screen_loc==src.screen_loc)
						G.icon_state="Grid"
		/*	usr.Description(src)//Give the USER, the description of the item -> src  (GO TO "Item Description.dm" for more info)
			return*/
		else   // If not...
			if(src.Dono == usr)
				usr.contents.Add(src) //Add the item to my inventory
			else
				Alert(usr,"Este item não é seu!",,1,1)
			return
