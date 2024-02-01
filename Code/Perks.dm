var/list/AllPerks=list()
proc/PopulatePerks()
	AllPerks=typesof(/obj/Perks)-/obj/Perks
	for(var/v in AllPerks)
		AllPerks+=new v;AllPerks-=v
	AllPerks=SortDatumList(AllPerks,"name",High2Low=1)

mob/var/list/SlottedPerks
mob/var/list/UnlockedPerks

mob/proc/DisplayPerks()
	if(!src.SlottedPerks)	src.SlottedPerks=list("Empty","Locked Slot","Locked Slot")
	if(!src.UnlockedPerks || !src.UnlockedPerks.len)	src.UnlockedPerks=list("Empty")
	winset(src,"PerksTab.PerksGrid","cells=2x[AllPerks.len-1]")

	var/counter=0
	for(var/v in src.SlottedPerks)
		counter+=1
		for(var/obj/Perks/P in AllPerks)	if(P.name==v)
			src<<output(P,"PerksTab.Perk[counter]Grid:1,1")
			src<<output(P.desc,"PerksTab.Perk[counter]Grid:2,1")
			break

	counter=0
	for(var/obj/Perks/P in AllPerks)
		if(P.invisibility)	continue
		else	counter+=1
		if(P.name!="Empty" && (P.name in src.SlottedPerks))
			P.icon_state="Lock"
			P.mouse_drag_pointer=null
			if(P.name=="Poder Supremo" || P.name=="Instinto Superior")
				P.icon_state="SpecialLock"
		else
			if(P.name in src.UnlockedPerks)
				P.icon_state="UnLocked"
				P.mouse_drag_pointer="Lock"
				if(P.name=="Poder Supremo" || P.name=="Instinto Superior")
					P.icon_state="SpecialUnLocked"
					P.mouse_drag_pointer="SpecialLock"
			else
				P.icon_state="Locked"
				P.mouse_drag_pointer=null
				if(P.name=="Poder Supremo" || P.name=="Instinto Superior")
					P.icon_state="SpecialLocked"
					P.mouse_drag_pointer=null
		src<<output(P,"PerksTab.PerksGrid:1,[counter]")
		src<<output(P.desc,"PerksTab.PerksGrid:2,[counter]")
	winset(src,"LevelWindow","is-visible=true")

mob/proc/HasPerk(var/Perk2Have)
	if(src.InTournament && global.TournPerks=="Disabled")	return
	if(Perk2Have in src.SlottedPerks)	return 1

obj/Perks
	icon='Other.dmi'
	icon_state="Locked"
	mouse_drag_pointer="Lock"

	Click()
		var/PpMsg="\nVocê ganha um Perk a cada 10,000 níveis!"
		if(src.name in usr.UnlockedPerks)	return
		if(usr.PerkPoints>=1)
			if(alert(usr,"Quer gastar 1 de seus [usr.PerkPoints] Perks para desbloquear [src.name]?[PpMsg]","Purchase Perk","Unlock","Cancel")=="Unlock")
				if(usr.PerkPoints<1 || (src.name in usr.UnlockedPerks))	return
				if(src.name=="Poder Supremo" || src.name=="Instinto Superior")
					usr<<sound('No.ogg')
					alert(usr,"Esse Perk é Especial e não pode ser comprado. Há uma probabilidade de liberá-lo ao ir Missão Paralela Especial.")
					return
				if(src.name=="Locked Slot")
					if(!("Locked Slot" in usr.SlottedPerks))	return
					usr.SlottedPerks-="Locked Slot"
					usr.SlottedPerks+="Empty"
				else
					usr.UnlockedPerks+=src.name
					usr.TrackStat("Perk Desbloqueado!","[usr.UnlockedPerks.len]/[global.AllPerks.len]")
					if(usr.UnlockedPerks.len>=global.AllPerks.len-1)	usr.GiveMedal(new/obj/Medals/Perkfect)
				usr.PerkPoints-=1;usr.DisplayPerks()
		else	alert(usr,"Você não tem nenhum Perk![PpMsg]","Sem Pontos!")
	MouseDrop(over_object,src_location,over_location,src_control,over_control,params)
		var/DropSlot
		if(findtext(over_control,"Perk1Grid"))	DropSlot=1
		else if(findtext(over_control,"Perk2Grid"))	DropSlot=2
		else if(findtext(over_control,"Perk3Grid"))	DropSlot=3
		else if(findtext(over_control,"Perk4Grid"))	DropSlot=4
		else if(findtext(over_control,"Perk5Grid"))	DropSlot=5
		if(DropSlot)
			if(usr.SlottedPerks[DropSlot]=="Locked Slot")	return
			if(src.name!="Empty" && (src.name in usr.SlottedPerks))	return
			if(!(src.name in usr.UnlockedPerks))	return
			usr.SlottedPerks[DropSlot]=src.name
			usr.DisplayPerks()

	Locked_Slot
		invisibility=1
		mouse_drag_pointer=null
		desc="Compre esse espaço para ativar mais Perks!"

	Empty
		icon_state="UnLocked"
		desc="Espaço livre para 1 Perk"
//	Sem_Folego
//		desc="Você pode sob/ indefinidamente sem um suprimento de ar."
	Ultimo_Suspiro
		desc="Impede que o seu Poder de Luta caia para 0 quando tomar dano excessivo."
	Canalizador_de_Poder
		desc="Impede que você se destransforme perante uma batalha (Saiyajins e Meio-Saiyajins)."
//	Inabalavel
//		desc="Você não é atordoado quando recebe um ataque, mas seus golpes tem metade da velocidade."
	Espirito_de_Lutador
		desc="Você não pode ser Nocauteado, mas pode ser destruído. Sua barra de defesa é desabilitada quando seu Poder de Luta chegar a 0."
	Carga_da_Vida
		desc="Carrega seu Poder de Luta 2x mais rápido, porém, carrega seu Ki 2x mais lento."
	Carga_do_Ki
		desc="Carrega seu Ki 2x mais rápido, porém, carrega seu Poder de Luta 2x mais lento."
//	Guerreiro_Lendario
//		desc="Aumenta seu dano ao utilizar todo o seu poder quando se transforma em Super Saiyajin (Saiyajins e Meio-Saiyajins)."
//	Evasiva_Eficiente
//		desc="Suas evasivas consomem metade de uma barra de Ki."
	Resistencia
		desc="Você não é lançado para longe com evasivas ou outros ataques especiais."
	Modo_Adrenalina
		desc="Recupera 10% de seu Poder de Luta e Ki quando destrói um inimigo."
	Modo_Adrenalina_2
		desc="Recupera 10% de seu Poder de Luta e Ki quando nocautea um inimigo."
	Guerreiro
		desc="Seus ataques físicos tem um dano de 110%, porém, seus ataques de Ki tem um dano de 50%."
	//Flash_Finish
	//	desc="Instantly Launch Special Attacks at 50% Damage"
	A_Prova_de_Balas
		desc="Esferas de Energia não te dão Dano, entretando ataques físicos tem o Dano dobrado. (PvP somente)"
	Escudo_de_Energia
		desc="Recebe 10% menos dano, mas consome 10% de seu Ki a cada soco recebido."
	Poder_Supremo
		desc="O Dano se estabiliza ao máximo, não importando a transformação. (Exceto Saiyajins, Meio-Saiyajins e Hitto)"
		icon_state="SpecialLocked"
	Instinto_Superior
		desc="Há uma chance muito pequena de liberar seu potencial dormente caso seja nocauteado. (Goku Super somente)"
		icon_state="SpecialLocked"
	Destruidor_Regenerativo
		desc="Impede que o alvo inimigo que possua regeneração recupere Poder de Luta passivamente."
	Forca_de_Vontade
		desc="Ao ficar com o Poder de Luta inferior a 25%, todo dano recebido será reduzido em 35%."
	Sentidos_Agucados
		desc="Retarda a velocidade de seus ataques de Ki."
	//Beam_BreakThrough
	//	desc="Your Beams will BreakThrough Opponents Guard"
	Impulso
		desc="Recebe +0.1 de Dano."
//	Instinto_de_Androide
//		desc="Absorve 5% dos ataques de Ki, transformando-os em energia."
	Esmagador_de_Ki
		desc="O tempo de atordoamento dos seus golpes são dobrados em inimigos que estejam com seu Ki zerado."
	Ilusao
		desc="Automaticamente se esquiva de golpes. Consome 25% do seu Ki."
	Canalizador_de_Ki
		desc="Automaticamente recupera 1% de seu Ki a cada segundo."
	//Regeneration
	//	desc="Automatically Recover 1% PL per Second"
	Experiencia_Automatica
		desc="Automaticamente ganha 1% de Experiência a cada segundo."
	Instinto_de_Saiyajin
		desc="Após voltar de um nocaute, seu Poder de Luta e Ki retornam em dobro."
	Treino_de_Energia
		desc="Sua Experiência de Treino oriunda do Treino de Reflexos é multiplicada por 10."
//	Objetivo_Final
//		desc="O golpe final de seu combo irá enfrentar o seu alvo."
	Repulsao
		desc="Com 4 golpes seu inimigo já é lançado para longe, ao invés de 5."
//	Controle_de_Ki
//		desc="Controla o Ki do adversário, forçando-o a fazer Batalha de Poderes."
	//Taunt
	//	desc="Force Opponents into Beam Battles when Launching a Beam"
	//Beam_Reflex
	//	desc="Automatically Trigger Beam Battles against Attackers"
	//Weakling
	//	desc="Teleport Counters won't Knock Back your Opponents"
	Esmagador_de_Espirito
		desc="Caso nocauteie um inimigo, ele demorará 2x mais para voltar ao normal."
	Espirito_do_Guerreiro
		desc="Você volta do nocaute 2x mais rápido."
	Jovem_Aprendiz
		desc="Toda a Experiência ganha aumenta em 10%."
	Absorvedor
		desc="Seus ataques físicos irão drenar 1% do Ki do adversário."
	Controle_Vingativo
		desc="Quando recebe algum ataque, seu Ki aumenta em dobro."
	Treinamento_Intenso
		desc="Ganha adicionalmente 10% de Experiência, porém, perde 0.1 de Dano."
	Supressao_do_Ki
		desc="Quando carregar seu Poder ao máximo, não irá lançá-lo; apenas irá segurá-lo. Poderá lançá-lo quando bem quiser."
	KaMeHaMeHa_Evasivo
		desc="Quando carregar seu Poder ao máximo, não irá lançá-lo, porém, caso algum inimigo te ataque, irá atacá-lo com toda sua energia. Gasta todo o seu Ki."
//	Ganancia
//		desc="Automaticamente pega Zennie vindo de baús e de inimigos em missões."
	Recompensa
		desc="Toda vez que atacar um inimigo, irá ganhar 10 de Zennie."
	Escudo_do_Guerreiro
		desc="Sua barra de defesa irá carregar quando receber um golpe."
	Ataques_Sonicos
		desc="Seus ataques são rápidos, porém, tem o dobro de tempo entre os combos."
	Vou_ate_o_Fim
		desc="Há a uma chance de 5% de não receber dano durante uma batalha."
	Vontade_do_Guerreiro_Z
		desc="Desfere mais 25% de dano em ataques físicos enquanto a defesa estiver cheia."
	Lutador_Marcial
		desc="Reduz o dano recebido em 30% enquanto tiver o Poder de Luta acima de 50%."
	Ambicioso
		desc="Dobra o valor de Zennies adquiridos em baús, torneios e na maioria de outros eventos."