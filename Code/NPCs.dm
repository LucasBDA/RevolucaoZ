
obj/NPCs
	density=1
	icon='NPCs.dmi'
	var/Frase
	layer=MOB_LAYER
//	event_relay = TRUE
	New()
		src.AddName()
		return ..()
	Popo
		icon_state="popo"
		Frase="P3RD1 lixo"
		verb/Missoes_Paralelas()
			set category=null
			set src in oview()
			var/Choice=alert(usr,"Miss�es Paralelas s�o miss�es que servem apenas para dar XP e serem mais desafiadoras. Gostaria de ir em uma? \nElas s�o selecionadas aleatoriamente.","Miss�es Paralelas","Sim","N�o")
			var/fon=rand(1,10)
			if(Choice=="Sim")
				if(fon==1)
					for(var/datum/Missions/A_Chegada_de_Raditz/M in AllMissions)
						if(!M || MyGetDist(usr,src)>8)	return
						usr<<"Gerando inst�ncia..."
						if(!GenerateConceptPieceMap(usr,M))	usr<<"Todas as inst�ncias atuais est�o sendo usadas no momento!"
				if(fon==2)
					for(var/datum/Missions/O_Retorno_de_Goku/M in AllMissions)
						if(!M || MyGetDist(usr,src)>8)	return
						usr<<"Gerando inst�ncia..."
						if(!GenerateConceptPieceMap(usr,M))	usr<<"Todas as inst�ncias atuais est�o sendo usadas no momento!"
				if(fon==3)
					for(var/datum/Missions/O_Grupo_de_Frieza/M in AllMissions)
						if(!M || MyGetDist(usr,src)>8)	return
						usr<<"Gerando inst�ncia..."
						if(!GenerateConceptPieceMap(usr,M))	usr<<"Todas as inst�ncias atuais est�o sendo usadas no momento!"
				if(fon==4)
					for(var/datum/Missions/Uma_Vinganca_para_Frieza/M in AllMissions)
						if(!M || MyGetDist(usr,src)>8)	return
						usr<<"Gerando inst�ncia..."
						if(!GenerateConceptPieceMap(usr,M))	usr<<"Todas as inst�ncias atuais est�o sendo usadas no momento!"
				if(fon==5)
					for(var/datum/Missions/Os_Androides/M in AllMissions)
						if(!M || MyGetDist(usr,src)>8)	return
						usr<<"Gerando inst�ncia..."
						if(!GenerateConceptPieceMap(usr,M))	usr<<"Todas as inst�ncias atuais est�o sendo usadas no momento!"
				if(fon==6)
					for(var/datum/Missions/Me_Encontre_na_Arena/M in AllMissions)
						if(!M || MyGetDist(usr,src)>8)	return
						usr<<"Gerando inst�ncia..."
						if(!GenerateConceptPieceMap(usr,M))	usr<<"Todas as inst�ncias atuais est�o sendo usadas no momento!"
				if(fon==7)
					for(var/datum/Missions/A_Aparicao_do_Mago/M in AllMissions)
						if(!M || MyGetDist(usr,src)>8)	return
						usr<<"Gerando inst�ncia..."
						if(!GenerateConceptPieceMap(usr,M))	usr<<"Todas as inst�ncias atuais est�o sendo usadas no momento!"
				if(fon==8)
					for(var/datum/Missions/O_Surgimento_de_Buu/M in AllMissions)
						if(!M || MyGetDist(usr,src)>8)	return
						usr<<"Gerando inst�ncia..."
						if(!GenerateConceptPieceMap(usr,M))	usr<<"Todas as inst�ncias atuais est�o sendo usadas no momento!"
				if(fon==9)
					for(var/datum/Missions/O_Terrivel_Tsufurujin/M in AllMissions)
						if(!M || MyGetDist(usr,src)>8)	return
						usr<<"Gerando inst�ncia..."
						if(!GenerateConceptPieceMap(usr,M))	usr<<"Todas as inst�ncias atuais est�o sendo usadas no momento!"
				if(fon==10)
					for(var/datum/Missions/Uma_Estrela/M in AllMissions)
						if(!M || MyGetDist(usr,src)>8)	return
						usr<<"Gerando inst�ncia..."
						if(!GenerateConceptPieceMap(usr,M))	usr<<"Todas as inst�ncias atuais est�o sendo usadas no momento!"
	Computador
		icon_state="computer"
		verb/Viajar()
			set src in oview()
			set category=null
			var/Choice=alert(usr,"Para onde desejar viajar?","Viagem","Namekuzei","Terra","Lugar nenhum")
			if(Choice=="Namekuzei")
				usr<<"Aguarde 1 minuto e chegar� ao seu destino"
				usr.Traveling=1
				sleep(600)
				usr.loc=locate(256,332,7)
				usr.Traveling=0
				usr<<"Viagem realizada com sucesso"
			if(Choice=="Terra")
				usr<<"Aguarde 1 minuto e chegar� ao seu destino"
				usr.Traveling=1
				sleep(600)
				usr.loc=locate(167,245,1)
				usr.Traveling=0
				usr<<"Viagem realizada com sucesso"

	Sr_Kaio
		icon_state="kingkai"
		verb/Reviver()
			set category=null
			set src in oview()
			if(usr.JoinMissionCheck())	return
			var/NewLoc=input("Onde voc� gostaria de reviver?","Local para Renascimento") as anything in Locations
			if(!usr)	return
			usr=usr.GetFusionMob()
			if((abs(usr.x-src.x<=12) || abs(usr.y-src.y<=7)))
				usr.IsDead=0
				usr.Locate(NewLoc)
				usr.overlays-=global.Halo
				usr.CompleteTutorial("Alpha Revival")
	Master_Roshi
		icon_state="MasterRoshi"
		verb/Iniciar_uma_Missao()
			set category=null
			set src in oview()
			if(usr.x<src.x)
				src.dir=8
			if(usr.x>src.x)
				src.dir=4
			if(usr.y<src.y)
				src.dir=2
			if(usr.y>src.y)
				src.dir=1
			if(usr.MissionBag==null)
				for(var/obj/Items/Missoes/Raditz/R in AllMissoes)
					usr.MissionBag+=new R.type
					R.Collect(usr)
			if(usr.Zerado==1)
				PlaySound(usr,'VictoryFanfare.ogg')
				alert("Parab�ns, [usr.name]! Voc� completou sua jornada, mas n�o se desanime, desafios s�o o que n�o faltam!")
				usr.GiveMedal(new/obj/Medals/Perfectionist)
				usr<<"<b>Voc� agora pode trocar de personagem livremente."
				usr.Zerado=2
				return
			alert("Ol�, [usr]. Vejo que quer realizar suas miss�es, certo? Pois ent�o, vamos come�ar.")
			var/obj/Items/Missoes/M=input("Qual miss�o voc� deseja fazer?","Miss�es") as null|anything in usr.MissionBag
			if(M.name=="Miss�o Raditz" && usr.Mission!=1)
				alert("Raditz... Ele � o suposto irm�o do Goku. Ele � um Saiyajin bastante perigoso. Tenha cuidado, [usr.name]!")
				usr.Mission=1
			if(M.name=="Miss�o Saibaman" && usr.Mission!=2)
				alert("Cuidado com os Saibamans! S�o criaturas com um poder n�o muito grande, mas podem ser mortais... Eles foram plantados pelos Saiyajins assim que os mesmos chegaram na Terra!")
				usr.Mission=2
			if(M.name=="Miss�o Nappa" && usr.Mission!=3)
				alert("Nappa � um Saiyajin aliado do Vegeta. N�o se precipite, [usr.name], ele pode ser muito perigoso.")
				usr.Mission=3
			if(M.name=="Miss�o Vegeta" && usr.Mission!=4)
				alert("Vegeta... Ele � um Saiyajin bastante poderoso. Tenha muita cautela, [usr.name]!")
				usr.Mission=4
			if(M.name=="Falar com o Nail" && usr.Mission!=5)
				alert("V� para Namekuzei para falar com o Nail; ele quem vai te guiar nas miss�es de Namekuzei. Boa sorte!")
				usr.Mission=5
			if(M.name=="Miss�o Guldo" && usr.Mission!=7)
				alert("Essa miss�o s� pode ser realizada em Namekuzei")
				PlaySound(view(),'no.ogg')
				return
			if(M.name=="Miss�o Recoome" && usr.Mission!=8)
				alert("Essa miss�o s� pode ser realizada em Namekuzei")
				PlaySound(view(),'no.ogg')
				return
			if(M.name=="Miss�o Jeice" && usr.Mission!=9)
				alert("Essa miss�o s� pode ser realizada em Namekuzei")
				PlaySound(view(),'no.ogg')
				return
			if(M.name=="Miss�o Burter" && usr.Mission!=10)
				alert("Essa miss�o s� pode ser realizada em Namekuzei")
				PlaySound(view(),'no.ogg')
				return
			if(M.name=="Miss�o Capit�o Ginyu" && usr.Mission!=11)
				alert("Essa miss�o s� pode ser realizada em Namekuzei")
				PlaySound(view(),'no.ogg')
				return
			if(M.name=="Miss�o Freeza 1� Forma" && usr.Mission!=12)
				alert("Essa miss�o s� pode ser realizada em Namekuzei")
				PlaySound(view(),'no.ogg')
				return
			if(M.name=="Miss�o Freeza 2� Forma" && usr.Mission!=13)
				alert("Essa miss�o s� pode ser realizada em Namekuzei")
				PlaySound(view(),'no.ogg')
				return
			if(M.name=="Miss�o Freeza 3� Forma" && usr.Mission!=14)
				alert("Essa miss�o s� pode ser realizada em Namekuzei")
				PlaySound(view(),'no.ogg')
				return
			if(M.name=="Miss�o Freeza 4� Forma" && usr.Mission!=15)
				alert("Essa miss�o s� pode ser realizada em Namekuzei")
				PlaySound(view(),'no.ogg')
				return
			if(M.name=="Miss�o Mecha Freeza" && usr.Mission!=16)
				alert("Vejo que conseguiu completar as batalhas de Namekuzei. Parab�ns, [usr.name], mas parece que Freeza veio a Terra para se vingar de Goku. Bem, creio que voc� deve dar conta dessa situa��o, certo?")
				usr.Mission=16
			if(M.name=="Miss�o Andr�ide N� 19" && usr.Mission!=17)
				alert("Andr�ides criados pelo Dr. Gero para acabar com o Goku. Droga, eles s�o muito mais fortes do que voc� imagina. Boa sorte, [usr.name].")
				usr.Mission=17
			if(M.name=="Miss�o Andr�ide N� 20" && usr.Mission!=18)
				alert("O Andr�ide N� 20 � uma cria��o do pr�prio Dr. Gero para conseguir derrotar o Goku. Preste aten��o.")
				usr.Mission=18
			if(M.name=="Miss�o Andr�ide N� 17" && usr.Mission!=19)
				alert("Cuidado, [usr.name]. O N� 17 juntamente com a N� 18 foram capazes de derrotar todos os Guerreiros Z no futuro. Tome muito cuidado!")
				usr.Mission=19
			if(M.name=="Miss�o Andr�ide N� 18" && usr.Mission!=20)
				alert("A N� 18 � a irm� g�mea do N� 17. Ambos s�o fortes, por�m a 18 � levemente mais poderosa. Boa sorte.")
				usr.Mission=20
			if(M.name=="Miss�o Cell Imperfeito" && usr.Mission!=21)
				alert("Cell � um Andr�ide assim como os anteriores, por�m ele fica mais poderoso quando absorve os N� 17 e 18. Nessa forma atual ele est� no seu estado imperfeito, mas ainda assim � bem forte.")
				usr.Mission=21
			if(M.name=="Miss�o Cell Semi-Perfeito" && usr.Mission!=22)
				alert("Nesse est�gio Cell absorveu o N� 17. Ele n�o est� na sua forma perfeita, mas sua for�a aumenta de forma extraordin�ria.")
				usr.Mission=22
			if(M.name=="Miss�o Cell Perfeito" && usr.Mission!=23)
				alert("Cell conseguiu alcan�ar sua perfei��o. Tenha cuidado, [usr.name]; apenas o Gohan enfurecido foi capaz de det�-lo.")
				usr.Mission=23
			if(M.name=="Miss�o Spopovitch" && usr.Mission!=24)
				alert("Spopovitch � um dos soldados do Mago Babidi. Ele participou do Torneio de Artes Marciais a procura de energia para liberar o temido Majin Boo.")
				usr.Mission=24
			if(M.name=="Miss�o Dabura" && usr.Mission!=25)
				alert("O Rei dos Dem�nios Dabura. Devido � grande maldade no cora��o de Dabura, Babidi conseguiu controlar sua mente e fazer com que ele trabalhasse para Babidi. N�o se precipite, ele � bem poderoso.")
				usr.Mission=25
			if(M.name=="Miss�o Babidi" && usr.Mission!=26)
				alert("Cuidado, [usr.name]. Babidi � o mago mais poderoso do mundo, embora sua apar�ncia n�o diga o mesmo.")
				usr.Mission=26
			if(M.name=="Miss�o Majin Vegeta" && usr.Mission!=50)
				alert("Esse � o est�gio em que o Vegeta se deixa ser controlado pelo mago Babidi para poder liberar toda a maldade do seu cora��o para poder lutar contra Goku. Justamente por n�o ter piedade em seu cora��o, te pe�o pra ter muito cuidado!")
				usr.Mission=50
			if(M.name=="Miss�o Majin Boo" && usr.Mission!=27)
				alert("Majin Boo � a criatura mais forte e temida do Universo. Nem o Goku com toda sua for�a conseguiu det�-lo sozinho. Boa sorte, [usr.name].")
				usr.Mission=27
			if(M.name=="Miss�o Evil Boo" && usr.Mission!=28)
				alert("Essa � a parte mal�gna do Majin Boo. Seus poderes s�o incr�veis al�m de n�o ter piedade de ningu�m")
				usr.Mission=28
			if(M.name=="Miss�o Super Boo" && usr.Mission!=29)
				alert("Ap�s absorver Majin Boo, Evil Boo se transformou no conhecido Super Boo, que foi capaz de aniquilar todos os seres humanos da Terra em fra��es de segundos!")
				usr.Mission=29
			if(M.name=="Miss�o Bootenks" && usr.Mission!=30)
				alert("A fus�o de Goten e Trunks, Gotenks, foi capaz de se deixar ser levado pela provoca��o de Boo e foi absorvido por ele. Cuidado, [usr.name]; nesse est�gio Majin Boo est� muito mais poderoso!")
				usr.Mission=30
			if(M.name=="Miss�o Boohan" && usr.Mission!=31)
				alert("Boohan � o nome dado a Majin Boo ap�s ter absorvido o Gohan. Essa � a forma mais poderosa do Majin Boo, portanto, n�o se descuide.")
				usr.Mission=31
			if(M.name=="Miss�o Kid Boo" && usr.Mission!=32)
				alert("Essa � a verdadeira forma de Majin Boo, o Kid Boo. Ele � maldade pura e n�o se contenta at� ver tudo a sua frente destru�do.")
				usr.Mission=32
			if(M.name=="Miss�o Baby Vegeta" && usr.Mission!=33)
				alert("Baby pertence a ra�a Tsufurujin que foi aniquilada pelos Saiyajins no passado. Em busca de vigan�a, Baby se instalou no corpo de Vegeta para saciar seus anseios. Ele � muito poderoso, [usr.name]; tenha cuidado.")
				usr.Mission=33
			if(M.name=="Miss�o Baby Vegeta Perfeito" && usr.Mission!=34)
				alert("A �ltima forma do Baby Vegeta. Apenas transformado em Super Saiyajin 4 o Goku foi capaz de derrot�-lo. Boa sorte, [usr.name].")
				usr.Mission=34
			if(M.name=="Miss�o Super 17" && usr.Mission!=35)
				alert("Essa � a perfei��o da cria��o do Dr. Gero, o Super 17. Ele obt�m uma for�a escumunal e pode te derrotar em segundos. Cuidado, [usr.name].")
				usr.Mission=35
			if(M.name=="Miss�o Omega Shenron" && usr.Mission!=36)
				alert("Cuidado, [usr.name]. Esse � o inimigo mais forte que voc� ir� enfrentar por ora. N�o se precipite, pois o Omega Shenron � o Drag�o que surgiu das Esferas do Drag�o e absorveu todas as Esferas restantes, tendo um poder inimagin�vel. Somente o Gogeta foi capaz de det�-lo.")
				usr.Mission=36
//			if(M.name=="Falar com Nail em Namekuzei")
/*			var/datum/Missions/M=input("Selecione uma Miss�o:","Mission Select") as null|anything in AllMissions
			if(!M || MyGetDist(usr,src)>8)	return
			usr<<"Generating instance..."
			if(!GenerateConceptPieceMap(usr,M))	usr<<"All Mission Instances are being Used!"
			else
				usr.CompleteTutorial("Missions")
				usr.TrackStat("Missions Attempted",1)
				usr.ShowTutorial(Tutorials["Clearing Missions"])
				usr.ShowTutorial(Tutorials["Mission Completion"])*/
	Vendendor_de_Roupas
		icon_state="item shop"
		Frase="Tenho muitas roupas a venda por aqui! D� uma olhada no meu estoque!!"


	Vendendor_de_Itens
		icon_state="Worker"
		Frase="Ol�, estou dando t�cnicas gratuitas. Qual voc� quer??"


	Machine
		icon=null
		name=" "
		density=1
		verb/Gravidade()
			set src in oview()
			set category=null
			usr.GravityProc(src)
		verb/Treinamento_de_Reflexos()
			set src in oview()
			set category=null
			usr.ShadowSparProc(src)
		verb/Treinamento_de_Luta()
			set src in oview()
			set category=null
			usr.SparringPartnerProc(src)
		verb/Treinamento_de_Energia()
			set src in oview()
			set category=null
			usr.FocusTrainingProc(src)

	Emmadayo
		icon_state="None"
		verb/Falar()
			set category=null
			set src in oview()

	Bulma
		icon_state="bulma"
		verb/Falar()
			set category=null
			set src in oview()
			alert("Ol�, [usr.name]. Eu reconstru� um dos aparelhos daqueles Saiyajins. Vai querer comprar um? Custa 50,000 de Zennie.")
	//		var/Choice=alert("Comprar?","","Sim","N�o")
//			O.Collect(usr)
/* IDEIA DE PERKS

1- IMUNIDADE A BEAM
2- DANO COM DEFESA CHEIA										<<<----------------
3- ENVENENAMENTO
4- RATE DE ZENNIE
5- MENOS QUANTIDADE KI PARA LARGAR PODERES COM DEFESA CHEIA
6- ROUBO DE KI
7- REDU��O DE DANO A PARTIR DE UMA QUANTIDADE DE VIDA
*/
	Perker
		icon_state="bratkid"
		verb/Falar()
			set category=null
			set src in oview()
			var/Choice=alert("Ol�, [usr.name]. Sou respons�vel em negocia��es com pontos Perks. Como deseja trocar seus Perks?","Perks","Zennie","Zens","Nada")
			if(Choice=="Zennie")
				Troca
				var/PerkP=input("Quantos Perks voc� deseja vender? Cada Perk custa 1,000 Zennies.\nVoc� tem [usr.PerkPoints]","Perks",usr.PerkPoints) as num
				if(PerkP>usr.PerkPoints)
					alert("Voc� n�o possui essa quantidade de Perks!")
					goto Troca
				usr.PerkPoints-=PerkP
				usr.Clicked2+=PerkP //eliminar os perks gastos no respec
				usr.Zenie+=PerkP*1000
			else
				if(Choice=="Zens")
					Troca2
					var/ZenP=input("Quantos Perks voc� deseja vender? Cada Perk custa 1 Zen. Com Zens voc� pode desbloquear Personagens Especiais.\nVoc� tem [usr.PerkPoints]","Perks",usr.PerkPoints) as num
					if(ZenP>usr.PerkPoints)
						usr<<sound('No.ogg')
						alert("Voc� n�o possui essa quantidade de Perks!")
						goto Troca2
					usr.PerkPoints-=ZenP
					usr.Clicked2+=ZenP
					usr.Zens+=ZenP
				else	{alert("Obrigado e volte sempre!");return}
	Dr_Briefs
		icon_state="DrBriefs"
		verb/Falar()
			set category=null
			set src in oview()
			var/randomic=pick(1,2,3)
			if(randomic==1)	usr<<"Dr. Briefs: Ol�, [usr]. N�o sei se chegou a ver, mas constru� uma nave capaz de viajar entre planetas! Ela est� do lado de fora da Corpora��o Capsula. Espero que o Vegeta n�o a destrua com o seu treinamento novamente."
			if(randomic==2)	usr<<"Dr. Briefs: Quando o Raditz chegou aqui na Terra, minha filha Bulma trabalhou em cima da tecnologia do Rastreador deles. Parece ser bastante �til."
			if(randomic==3)	usr<<"Dr. Briefs: Ei, [usr]! Nessa sala a sua direita cont�m livros cient�ficos muito antigos que contam inclusive todos os Eventos que ocorrem no servidor."

	Maquina
		icon_state=""
		verb/Gravidade()
			set src in oview()
			set category=null
			usr.GravityProc(usr)
		verb/Treinamento_de_Ki()
			set src in oview()
			set category=null
			if(usr.Training=="Ki Training")
				usr<<"<b>Voc� j� est� treinando!"
				return
			usr.KiTraining(usr)
		verb/Treinamento_de_Energia()
			set src in oview()
			set category=null
			if(usr.Training=="Ki Training")
				usr<<"<b>Saia do Treinamento de Ki antes!"
				return
			usr.FocusTrainingProc(src)
	Vegeta
		icon_state="Vegeta"
		verb/Falar()
			set category=null
			set src in oview()
			usr<<"Vegeta: O que quer aqui, verme? Se veio com a inten��o de usar a Sala de Treino, pode ir; acabei de sair de l�. V� se n�o bagun�a tudo."
		verb/Missoes_Extras()
			set category=null
			set src in oview()
			if(usr.Talked8==0 && usr.Quest8==0)
				alert(usr,"Vejo que quer realizar as miss�es extras, certo? Hmpf... Julgando pela sua for�a, voc� vai morrer facilmente, verme. Mas que seja, vamos come�ar.")
				usr<<"Vegeta: Seu primeiro objetivo � derrotar o Cooler. Ele � o irm�o do inseto do Freeza. V� se n�o morre..."
				usr.Talked8=1
				return
			if(usr.Talked8==1 && usr.Quest8==1)
				alert("Vejo que derrotou o Cooler, n�o? Apois, tente derrot�-lo com o m�ximo do poder dele.")
				usr.Talked8=2
				return
			if(usr.Talked8==2 && usr.Quest8==2)
				alert("Gra�as ao aux�lio de uma Estrela, Cooler p�de voltar a vida, e muito mais poderoso. Quero ver se � realmente forte, seu verme.")
				usr.Talked8=3
				return
			if(usr.Talked8==3 && usr.Quest8==3)
				alert("Hmpf... Vejo que o derrotou. Vamos ver se consegue derrotar o Lend�rio Super Saiyajin, inseto.")
				usr.Talked8=4
				return
			if(usr.Talked8==4 && usr.Quest8==4)
				alert("Desejo boa sorte para voc� agora, [usr.name]. Enfrente o Broly em sua forma mais poderosa, Lend�rio Super Saiyajin. V� se n�o morre. Suma daqui.")
				usr.Talked8=5
				return
			if(usr.Talked8==5 && usr.Quest8==5)
				alert("Vejo que acabou realmente com o Broly. Merece minhas congratula��es. Por enquanto, n�o tenho mais miss�es extras para voc�. V� embora!")
				usr.Talked8=6
				return
			if(usr.Talked8==6 && usr.Quest8==5)
				alert("Voc� � idiota por acaso? J� falei que n�o tenho mais miss�es extras pra voc�.")
				return
	Livros
		icon_state=null
		density=0
		name=" "
		verb/Ler()
			set category=null
			set src in oview()
			winset(usr,"window1","is-visible=true")
	Cientista
		icon_state="scientist"
		verb/Falar()
			set category=null
			set src in oview()
			usr<<"Cientista: Ol�, [usr.name]. Bem vindo � Corpora��o Capsula."
