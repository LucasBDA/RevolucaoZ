var/list/AllStats=list()
proc/PopulateStats()
	AllStats=typesof(/obj/Stats)-/obj/Stats
	for(var/v in AllStats)
		AllStats+=new v
		AllStats-=v

mob/verb/AdvanceStat(var/Tag as null|text)
	set hidden=1
	var/obj/Stats/S=locate(Tag)
	if(!S.Advances)	alert("Due to Pending Updates:  This Stat Cannot be Advanced Yet.","Error")
	else
		if(usr.TraitPoints>=1)
			var/Points2Add=round(input("Você tem [usr.TraitPoints] Pontos Estatus \nQuantos você gostaria de colocar?","Avançar Estatus",usr.TraitPoints) as num)
			if(Points2Add<=0 || usr.TraitPoints<Points2Add)	return
			if(!usr.Traits)	usr.Traits=list()
			if(!(S.name in usr.Traits))	usr.Traits+=S.name
			if(usr.vars["[S.Advances]"]+(S.Amt*Points2Add)>3000000000000000000000000000000)
				var/Difference=2999999-usr.vars["[S.Advances]"]
				Points2Add=round(Difference/S.Amt)+1
			usr.Traits[S.name]=text2num(usr.Traits[S.name])
			usr.Traits[S.name]+=Points2Add
			usr.TraitPoints-=Points2Add
			usr.vars["[S.Advances]"]+=S.Amt*Points2Add
			usr.vars["[S.Advances]"]=min(3000000000000000000000000000000000,usr.vars["[S.Advances]"])
			if(usr.vars["[S.Advances]"]>=3000000)	usr.GiveMedal(new/obj/Medals/StatCap)
			if(S.Advances=="MaxPL" && usr.MaxPL>9000)	usr.GiveMedal(new/obj/Medals/ItsOver9000)
			if(usr.MaxPL>=1000000 && usr.MaxKi>=1000000 && usr.Str>=1000000 && usr.Def>=1000000)	usr.GiveMedal(new/obj/Medals/PerfectWarrior)
			usr.UpdatePlHUD();usr.UpdateKiHUD()
			usr.CompleteTutorial("Stat Points")
			S.Click()
		else	alert("Você não possui pontos suficientes","Error")

obj/Stats
	var/Advances
	var/Amt=1
	icon='HUD.dmi'
	icon_state="Stats+"
	New()
		src.tag="Tag:[src.name]"
		return ..()
	Click()
		if(!src.suffix)	return
		winset(usr,"StatWindow.NameLabel","text=\"[src.name]\"")
		winset(usr,"StatWindow.SuffixLabel","text=\"[src.suffix]\n[src.desc]\"")
		winset(usr,"StatWindow.AdvanceStatBtn","command=\"AdvanceStat [src.tag]\"")
		var/NextText="No Advancement Data Available"
		if(src.Advances)
			var/Numby=usr.vars[src.Advances]
			if(isnum(Numby))	Numby=FullNum(Numby)
			NextText="[src.name]: [Numby]"
		winset(usr,"StatWindow.NextLabel","text=\"[NextText]\"")
		winset(usr,"StatWindow","size=440x184;pos=50,75;is-visible=true")

	Poder_de_Luta
		Amt=10
		Advances="MaxPL"
		suffix="Multiplica seu Poder de Luta máximo por 10."
		desc="Aumenta o total de dano que você tem que tomar para ficar nocauteado."
	Ki
		Amt=20
		Advances="MaxKi"
		suffix="Multiplica seu Ki máximo por 20."
		desc="Aumenta o dano de seus ataques mágicos."
	Forca
		Amt=2
		Advances="Str"
		suffix="Multiplica sua Força total por 2."
		desc="Aumenta o seu dano."
	Defesa
		Amt=1
		Advances="Def"
		suffix="Multiplica sua Defesa total por 1."
		desc="Reduz o dano recebido."