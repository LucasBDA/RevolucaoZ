mob/var/list/Techniques
var/list/AllTechniques=list()
var/list/AllTecnicas=typesof(/obj/items/Tecnicas)-/obj/items/Tecnicas
proc/PopulateAllTechniques()
	for(var/v in AllTechniques)
		AllTechniques+=new v
		AllTechniques-=v

obj/Selecter
	icon='HUD.dmi'
	icon_state="SelectedSkill"
	layer=26
//M.Character.BeamSpecial=new/CharSpecials/Hyper_Kame


mob/verb/ComprarGG()
	for(var/obj/items/Tecnicas/Galickgun/G in AllTechniques)
		usr.Techniques+=new G.type
//		R.Collect(src)
//		usr.ShowSkill(G)
		Alert(usr,"Tá adicionado a skill na lista. Itens na lista: [usr.Techniques.len]",,1,1)
		alert(usr,"Missões Paralelas são missões que servem apenas para dar XP e serem mais desafiadoras. Gostaria de ir em uma? \nElas são selecionadas aleatoriamente.","Missões Paralelas","Sim","Não")


obj/items/Tecnicas
	icon='HUD.dmi'
	layer=25
	var/Special=""
/*	Collect(var/mob/M)
//		if(M.Y=)	return
		if(!EmLista(M.Techniques))	M.Techniques=list()
		for(var/obj/items/Tecnicas/R in M.Techniques)	if(R.type==src.type)
			R.suffix="";return
		M.Techniques+=new src.type

*/
	Kamehameha
		icon_state="Kamehameha"
		Special="KameHameHa"

	Galickgun
		icon_state="Galickgun"
		Special="Galick Gun"