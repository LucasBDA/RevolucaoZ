mob/var/obj/Tutorials/CurTut
mob/var/list/TutsComplete

var/list/Tutorials=list()
proc/PopulateTutorails()
	var/list/TypesOf=typesof(/obj/Tutorials)
	for(var/v in TypesOf)
		var/obj/Tutorials/T=new v
		Tutorials+=T.name
		Tutorials[T.name]=T

obj/Tutorials
	proc/TutComplete(var/mob/M)
		if(!M.client)	return
		winset(M,"MainWindow.Tutorial+","is-visible=false")
		winset(M,"TutorialWindow","is-visible=false")
		if(!M.TutsComplete)	M.TutsComplete=list()
		M.TutsComplete+=src.name
		M.CurTut=null
		M.GeneralTutorials()
	Movemento
		desc="Use as setas para se mover."
	Voar
		desc="Pressione Shift+Cima para voar, e Shift+Baixo para pousar."
	Atacar
		desc="Aperte {F} para atacar."
	Super_Ataques
		desc="Pressione {S} para realizar um ataque forte. A defesa quebra caso defenda esse ataque."
	Esferas_de_Energia
		desc="Use os números de 1 à 6 na parte de cima do teclado para escolher o tipo de energia - {D}."
	Mini_Mapa
		desc="Caso você se perca, aperte {M} para aparecer um Mini Mapa."
	Teletransporte
		desc="Clique 2x em algum lugar no Mapa para se teletransportar para ele."
	Treino
		desc="Entre numa Capsula e ataque os Sacos de Pancada."
	Exp_de_Treino
		desc="Você ganhará Exp de Treino enquanto treina. Ela será distribuida no final da sessão."
	Treinos_Adicionais
		desc="Clique 2x na máquina central da Capsula para visualizar outros modos de Treinamento."
	Transformacoes
		desc="Pressione Shift+A ou Ctrl+A para se transformar! As transformações aumentam o seu Dano!"
	Reverter
		desc="Pressione Shift+Z para Reverter! Assim você retorna ao estado normal do seu personagem."
	Missoes
		desc="Fale com o Mestre Kame numa ilha ao lado do Torneio de Artes Marciais. Ele tem missões para você!"
	Capsulas
		desc="Você pode criar personagens por meio da aba 'Capsulas' logo ali em cima."
	Fazendo_Missoes
		desc="Siga o caminho nas missões para derrotar os inimigos e os chefes."
	Completando_Missoes
		desc="Derrote todos os inimigos e abra todos os baús para ganha Bônus de Missão que dá 1,000 níveis!"
	Trocando_de_Personagem
		desc="Selecione a opção lá em cima escrita 'Options', depois 'Change Character'."

	Finalizando
		desc="Você precisa usar algum ataque usando Ki para matar os inimigos! {D} ou Shift + {D}."
	Abrindo_Baus
		desc="Ataque um baú para abrí-lo. Para coletar os itens, basta passar por cima deles."
	Defendendo
		desc="Você tem que pressionar {G} numa luta para se defender. Aperte {G} 2x para dar Evasivas!"

	Voltando_do_Nocaute
		desc="Aperte {G} várias vezes para sair do Nocaute."
	Elevando_o_Poder
		desc="Quando seu Poder de Luta, ou Ki, estão baixos, aperta {A} para Elevá-los!"
//	Guard
//		desc="Hold G to Guard against incoming Attacks.  This will negate damage."
	Pontos_de_Estatus
		desc="A cada nível que você ganha, você ganha 1 Ponto de Estatus! Você pode gastá-los no que quiser!"
	Renascer
		desc="Corra pelo Caminho da Serpente para encontrar o Planeta do Sr.Kaio, e ele te reviverá!"

var/list/GeneralTuts=list("Movement","Flight","MiniMap","Instant Transmission","Attacking","Strong Attacks","Ki Blast Types","Training","Additional Training","Transformations","Reverting","Capsule Characters","Missions")
mob/proc/GeneralTutorials()
	for(var/client/C in src.ControlClients)
		for(var/v in GeneralTuts)	if(!(v in C.mob.TutsComplete))
			C.mob.ShowTutorial(Tutorials[v]);break
		if(src.z==2)	src.ShowTutorial(Tutorials["Alpha Revival"])
		if(src.z in MissionZs)
			src.ShowTutorial(Tutorials["Clearing Missions"])
			src.ShowTutorial(Tutorials["Mission Completion"])
		if(src.icon_state=="koed")	src.ShowTutorial(Tutorials["KO Recovery"])

mob/proc/CompleteTutorial(var/TutName)
	if(src.CurTut && src.CurTut.name==TutName)	src.CurTut.TutComplete(src)

mob/verb/CloseTutorial()
	set hidden=1
	winset(usr,"TutorialWindow","is-visible=false")
	winset(usr,"MainWindow.Tutorial+","is-visible=true")
	usr.SetFocus("MainWindow.MainMap")

mob/verb/RestoreTutorial()
	set hidden=1
	if(usr.CurTut)	usr.ShowTutorial(usr.CurTut)

mob/proc/ShowTutorial(var/obj/Tutorials/T)
	for(var/client/C in src.ControlClients)
		if(T.name in C.mob.TutsComplete)	return
		C.mob.CurTut=T
		winset(C.mob,"MainWindow.Tutorial+","is-visible=false")
		winset(C.mob,"TutorialWindow.NameLabel","text='[T.name] - Tutorial'")
		winset(C.mob,"TutorialWindow.DescLabel","text='[T.desc]'")
		winset(C.mob,"TutorialWindow","pos=236,466;is-visible=true")
		C.mob.SetFocus("MainWindow.MainMap")