mob/var/AFK
var/obj/AfkIcon/AfkIcon=new
obj/AfkIcon
	pixel_x=8
	pixel_y=8
	icon='Other.dmi'
	icon_state="AFK"
	layer=FLOAT_LAYER

mob/Stat()
	if(statpanel("Estatus"))
		if(!src.AFK)
			var/mob/StatMob=src.GetFusionMob()
			if(StatMob.CurrentMission)
				stat("<u>Mission Goals</u>")
				stat("Chefes:","0/1")
				stat("Inimigos:","[round(StatMob.GetTrackedStat("NPCs Killed",StatMob.TempTracked))]/[StatMob.CurrentMission.EnemyCount]")
				stat("Baus:","[round(StatMob.GetTrackedStat("Chests Opened",StatMob.TempTracked))]/[StatMob.CurrentMission.ChestCount]")
				stat("Perigos:","0/0")
				stat("Obstaculos:","0/0")
				stat("Esferas do Dragao:","0/0")
				stat("Missoes de fora:","0/0")
				stat("<u>Estatus do Personagem</u>")
			stat("Nivel:","[FullNum(src.Level)]")
			stat("Nivel de Habilidade:","[src.Class]")
			stat("Fadiga:","[src.Fadiga]%")
			stat("Experiencia:","[src.Exp]%")
			stat("Exp de Treino:","[FullNum(src.TrainingExp)]%")
			stat("Dano:","x[StatMob.CalcDamMult()]")
			stat("Poder de Luta:","[FullNum(StatMob.PL)] ([round(StatMob.PL/StatMob.MaxPL*100)]%)")
			stat("Ki:","[FullNum(StatMob.Ki)] ([round(StatMob.Ki/StatMob.MaxKi*100)]%)")
			stat("Forca:","[FullNum(StatMob.Str)]")
			stat("Defesa:","[FullNum(StatMob.Def)]")
			stat("Zennie:","[FullNum(StatMob.Zenie)]")
			stat("Zens:","[FullNum(StatMob.Zens)]")
			stat("$ Points:","[FullNum(StatMob.CashPoints)]")
			stat("Desejos:","[src.WishesMade] Made Today")
			if(src.z)	stat("Localizacao:","[StatMob.x], [StatMob.y], [MapNames["[StatMob.z]"]]")
		else
			stat("Voce ficou inativo por +5 minutos")
			stat("Seu painel de Estatus foi reduzido para conservar o uso da CPU")
			stat("Nivel:","[src.Level]")
			stat("Experiencia:","[src.Exp]%")
			stat("Exp de Treino:","[src.TrainingExp]%")

	if(!src.AFK)
		if(statpanel("Inventario"))
			stat("<u>- --- Roupas --- -")
			stat(src.ClothesInventory)
			stat("<u>- --- Itens --- -")
			stat(src.ItemsInventory)
		if(statpanel("Tecnicas"))
			stat("<u>    Tecnicas Ativas")
			stat("<u>    Tecnicas Passivas")
		if(statpanel("Capsulas"))
			stat("Personagens ([src.CapsuleChars.len]/[global.AllCapsuleChars.len])")
			stat(global.CapsuleCharGuide)
			stat(src.CapsuleChars)
	//		stat("Aprimoracoes (0/0)")
	//		stat("Veiculos (0/0)")
	//		stat("Deployables (0/0)")

		if(statpanel("Medalhas"))
			stat(VMP)
			stat("<u>Voce tem [src.Medals.len] de [AllMedals.len] Medalhas")
			stat(src.MedalObjs)
			stat("")
			stat("<u>[AllMedals.len-src.Medals.len] Medalhas sobrando")
			stat(AllMedals-src.MedalObjs)

		if(statpanel("Controles"))
			stat("Setas:","Movimentam")
			stat("Duplo Toque:","Corrida/Voo Sonico")
			stat("1-6:","Muda o tipo de Esfera de Energia")
			stat("Shift+Cima:","Voa")
			stat("Shift+Baixo:","Pousa")
			stat("F:","Ataque")
			stat("R:","Descansar")
			stat("Q:","Aura")
			stat("S:","Super Ataque")
			stat("G:","Defesa/Tele Counter/Retorno do Nocaute")
			stat("D:","Esfera de Energia -1/2 da barra de Ki")
			stat("Shift+D:","Poder -1 barra de Ki")
			stat("Segurando Shift+D:","Carrega o Poder")
			stat("Segurando A:","Eleva o Poder")
			stat("Ctrl+A:","Transformacao (minimo de 3 barras de Ki)")
			stat("Shift+Z:","Reverte da forma transformada")
			stat("M:","Mini Mapa")
			stat("T:","Lista de Transformacoes")

		if(statpanel("Jogadores"))
			stat("[Players.len] jogadores Online:")
			stat(Players)
		if(statpanel("Amigos"))
			stat("<u>[src.OnlineFriends.len] amigos Online")
			stat(src.OnlineFriends)
			stat("<u>[src.Friends.len] amigos")
			stat(src.Friends)

	if(statpanel("Servidor"))
		stat("Hoster:","[world.host]")
		stat("Versao:","[GameVersion].0")
		stat("Uso da CPU:","[world.cpu]%")
		stat("Jogadores Online:","[Players.len]")
		stat("Tempo aberto:","[Hours]:[Minutes]:[Seconds]")
		stat("Zona de Tempo:","[time2text(world.timeofday,"hh:mm:ss")]")

/*var/obj/ClickableStatObj/ClickableStatObj=new
obj/ClickableStatObj
	name="Click Here to View Stats"
	Click()
		var/LabelText=""
		var/mob/StatMob=usr.GetFusionMob()
		if(StatMob.CurrentMission)
			LabelText+="Mission Goals\n"
			LabelText+="Bosses:    0/1\n"
			LabelText+="Enemies:    [round(StatMob.GetTrackedStat("NPCs Killed",StatMob.TempTracked))]/[StatMob.CurrentMission.EnemyCount]\n"
			LabelText+="Chests:    [round(StatMob.GetTrackedStat("Chests Opened",StatMob.TempTracked))]/[StatMob.CurrentMission.ChestCount]\n"
			LabelText+="Hazards:    0/0\n"
			LabelText+="Obstacles:    0/0\n"
			LabelText+="DragonBalls:    0/0\n"
			LabelText+="Side Quests:    0/0\n"
			LabelText+="\nCharacter Stats\n"
		LabelText+="Level:    [FullNum(usr.Level)]\n"
		LabelText+="Experience:    [usr.Exp]%\n"
		LabelText+="Damage:    x[StatMob.CalcDamMult()]\n"
		LabelText+="Power Level:    [FullNum(StatMob.PL)] ([round(StatMob.PL/StatMob.MaxPL*100)]%)\n"
		LabelText+="Ki Energy:    [FullNum(StatMob.Ki)] ([round(StatMob.Ki/StatMob.MaxKi*100)]%)\n"
		LabelText+="Strength:    [FullNum(StatMob.Str)]\n"
		LabelText+="Defense:    [FullNum(StatMob.Def)]\n"
		LabelText+="Zenie:    [FullNum(StatMob.Zenie)]\n"
		LabelText+="$ Points:    [FullNum(StatMob.CashPoints)]\n"
		if(StatMob.z)	LabelText+="Location:    [StatMob.x], [StatMob.y], [MapNames["[StatMob.z]"]]"
		winset(usr,"StatPanelWindow.StatLabel","text=\"[LabelText]\"")
		winset(usr,"StatPanelWindow","pos=100,100;size=488x488;is-visible=true")
		return ..()*/