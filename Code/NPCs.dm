
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
			var/Choice=alert(usr,"Missões Paralelas são missões que servem apenas para dar XP e serem mais desafiadoras. Gostaria de ir em uma? \nElas são selecionadas aleatoriamente.","Missões Paralelas","Sim","Não")
			var/fon=rand(1,10)
			if(Choice=="Sim")
				if(fon==1)
					for(var/datum/Missions/A_Chegada_de_Raditz/M in AllMissions)
						if(!M || MyGetDist(usr,src)>8)	return
						usr<<"Gerando instância..."
						if(!GenerateConceptPieceMap(usr,M))	usr<<"Todas as instâncias atuais estão sendo usadas no momento!"
				if(fon==2)
					for(var/datum/Missions/O_Retorno_de_Goku/M in AllMissions)
						if(!M || MyGetDist(usr,src)>8)	return
						usr<<"Gerando instância..."
						if(!GenerateConceptPieceMap(usr,M))	usr<<"Todas as instâncias atuais estão sendo usadas no momento!"
				if(fon==3)
					for(var/datum/Missions/O_Grupo_de_Frieza/M in AllMissions)
						if(!M || MyGetDist(usr,src)>8)	return
						usr<<"Gerando instância..."
						if(!GenerateConceptPieceMap(usr,M))	usr<<"Todas as instâncias atuais estão sendo usadas no momento!"
				if(fon==4)
					for(var/datum/Missions/Uma_Vinganca_para_Frieza/M in AllMissions)
						if(!M || MyGetDist(usr,src)>8)	return
						usr<<"Gerando instância..."
						if(!GenerateConceptPieceMap(usr,M))	usr<<"Todas as instâncias atuais estão sendo usadas no momento!"
				if(fon==5)
					for(var/datum/Missions/Os_Androides/M in AllMissions)
						if(!M || MyGetDist(usr,src)>8)	return
						usr<<"Gerando instância..."
						if(!GenerateConceptPieceMap(usr,M))	usr<<"Todas as instâncias atuais estão sendo usadas no momento!"
				if(fon==6)
					for(var/datum/Missions/Me_Encontre_na_Arena/M in AllMissions)
						if(!M || MyGetDist(usr,src)>8)	return
						usr<<"Gerando instância..."
						if(!GenerateConceptPieceMap(usr,M))	usr<<"Todas as instâncias atuais estão sendo usadas no momento!"
				if(fon==7)
					for(var/datum/Missions/A_Aparicao_do_Mago/M in AllMissions)
						if(!M || MyGetDist(usr,src)>8)	return
						usr<<"Gerando instância..."
						if(!GenerateConceptPieceMap(usr,M))	usr<<"Todas as instâncias atuais estão sendo usadas no momento!"
				if(fon==8)
					for(var/datum/Missions/O_Surgimento_de_Buu/M in AllMissions)
						if(!M || MyGetDist(usr,src)>8)	return
						usr<<"Gerando instância..."
						if(!GenerateConceptPieceMap(usr,M))	usr<<"Todas as instâncias atuais estão sendo usadas no momento!"
				if(fon==9)
					for(var/datum/Missions/O_Terrivel_Tsufurujin/M in AllMissions)
						if(!M || MyGetDist(usr,src)>8)	return
						usr<<"Gerando instância..."
						if(!GenerateConceptPieceMap(usr,M))	usr<<"Todas as instâncias atuais estão sendo usadas no momento!"
				if(fon==10)
					for(var/datum/Missions/Uma_Estrela/M in AllMissions)
						if(!M || MyGetDist(usr,src)>8)	return
						usr<<"Gerando instância..."
						if(!GenerateConceptPieceMap(usr,M))	usr<<"Todas as instâncias atuais estão sendo usadas no momento!"
	Computador
		icon_state="computer"
		verb/Viajar()
			set src in oview()
			set category=null
			var/Choice=alert(usr,"Para onde desejar viajar?","Viagem","Namekuzei","Terra","Lugar nenhum")
			if(Choice=="Namekuzei")
				usr<<"Aguarde 1 minuto e chegará ao seu destino"
				usr.Traveling=1
				sleep(600)
				usr.loc=locate(256,332,7)
				usr.Traveling=0
				usr<<"Viagem realizada com sucesso"
			if(Choice=="Terra")
				usr<<"Aguarde 1 minuto e chegará ao seu destino"
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
			var/NewLoc=input("Onde você gostaria de reviver?","Local para Renascimento") as anything in Locations
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
				alert("Parabéns, [usr.name]! Você completou sua jornada, mas não se desanime, desafios são o que não faltam!")
				usr.GiveMedal(new/obj/Medals/Perfectionist)
				usr<<"<b>Você agora pode trocar de personagem livremente."
				usr.Zerado=2
				return
			alert("Olá, [usr]. Vejo que quer realizar suas missões, certo? Pois então, vamos começar.")
			var/obj/Items/Missoes/M=input("Qual missão você deseja fazer?","Missões") as null|anything in usr.MissionBag
			if(M.name=="Missão Raditz" && usr.Mission!=1)
				alert("Raditz... Ele é o suposto irmão do Goku. Ele é um Saiyajin bastante perigoso. Tenha cuidado, [usr.name]!")
				usr.Mission=1
			if(M.name=="Missão Saibaman" && usr.Mission!=2)
				alert("Cuidado com os Saibamans! São criaturas com um poder não muito grande, mas podem ser mortais... Eles foram plantados pelos Saiyajins assim que os mesmos chegaram na Terra!")
				usr.Mission=2
			if(M.name=="Missão Nappa" && usr.Mission!=3)
				alert("Nappa é um Saiyajin aliado do Vegeta. Não se precipite, [usr.name], ele pode ser muito perigoso.")
				usr.Mission=3
			if(M.name=="Missão Vegeta" && usr.Mission!=4)
				alert("Vegeta... Ele é um Saiyajin bastante poderoso. Tenha muita cautela, [usr.name]!")
				usr.Mission=4
			if(M.name=="Falar com o Nail" && usr.Mission!=5)
				alert("Vá para Namekuzei para falar com o Nail; ele quem vai te guiar nas missões de Namekuzei. Boa sorte!")
				usr.Mission=5
			if(M.name=="Missão Guldo" && usr.Mission!=7)
				alert("Essa missão só pode ser realizada em Namekuzei")
				PlaySound(view(),'no.ogg')
				return
			if(M.name=="Missão Recoome" && usr.Mission!=8)
				alert("Essa missão só pode ser realizada em Namekuzei")
				PlaySound(view(),'no.ogg')
				return
			if(M.name=="Missão Jeice" && usr.Mission!=9)
				alert("Essa missão só pode ser realizada em Namekuzei")
				PlaySound(view(),'no.ogg')
				return
			if(M.name=="Missão Burter" && usr.Mission!=10)
				alert("Essa missão só pode ser realizada em Namekuzei")
				PlaySound(view(),'no.ogg')
				return
			if(M.name=="Missão Capitão Ginyu" && usr.Mission!=11)
				alert("Essa missão só pode ser realizada em Namekuzei")
				PlaySound(view(),'no.ogg')
				return
			if(M.name=="Missão Freeza 1ª Forma" && usr.Mission!=12)
				alert("Essa missão só pode ser realizada em Namekuzei")
				PlaySound(view(),'no.ogg')
				return
			if(M.name=="Missão Freeza 2ª Forma" && usr.Mission!=13)
				alert("Essa missão só pode ser realizada em Namekuzei")
				PlaySound(view(),'no.ogg')
				return
			if(M.name=="Missão Freeza 3ª Forma" && usr.Mission!=14)
				alert("Essa missão só pode ser realizada em Namekuzei")
				PlaySound(view(),'no.ogg')
				return
			if(M.name=="Missão Freeza 4ª Forma" && usr.Mission!=15)
				alert("Essa missão só pode ser realizada em Namekuzei")
				PlaySound(view(),'no.ogg')
				return
			if(M.name=="Missão Mecha Freeza" && usr.Mission!=16)
				alert("Vejo que conseguiu completar as batalhas de Namekuzei. Parabéns, [usr.name], mas parece que Freeza veio a Terra para se vingar de Goku. Bem, creio que você deve dar conta dessa situação, certo?")
				usr.Mission=16
			if(M.name=="Missão Andróide Nº 19" && usr.Mission!=17)
				alert("Andróides criados pelo Dr. Gero para acabar com o Goku. Droga, eles são muito mais fortes do que você imagina. Boa sorte, [usr.name].")
				usr.Mission=17
			if(M.name=="Missão Andróide Nº 20" && usr.Mission!=18)
				alert("O Andróide Nº 20 é uma criação do próprio Dr. Gero para conseguir derrotar o Goku. Preste atenção.")
				usr.Mission=18
			if(M.name=="Missão Andróide Nº 17" && usr.Mission!=19)
				alert("Cuidado, [usr.name]. O Nº 17 juntamente com a Nº 18 foram capazes de derrotar todos os Guerreiros Z no futuro. Tome muito cuidado!")
				usr.Mission=19
			if(M.name=="Missão Andróide Nº 18" && usr.Mission!=20)
				alert("A Nº 18 é a irmã gêmea do Nº 17. Ambos são fortes, porém a 18 é levemente mais poderosa. Boa sorte.")
				usr.Mission=20
			if(M.name=="Missão Cell Imperfeito" && usr.Mission!=21)
				alert("Cell é um Andróide assim como os anteriores, porém ele fica mais poderoso quando absorve os Nº 17 e 18. Nessa forma atual ele está no seu estado imperfeito, mas ainda assim é bem forte.")
				usr.Mission=21
			if(M.name=="Missão Cell Semi-Perfeito" && usr.Mission!=22)
				alert("Nesse estágio Cell absorveu o Nº 17. Ele não está na sua forma perfeita, mas sua força aumenta de forma extraordinária.")
				usr.Mission=22
			if(M.name=="Missão Cell Perfeito" && usr.Mission!=23)
				alert("Cell conseguiu alcançar sua perfeição. Tenha cuidado, [usr.name]; apenas o Gohan enfurecido foi capaz de detê-lo.")
				usr.Mission=23
			if(M.name=="Missão Spopovitch" && usr.Mission!=24)
				alert("Spopovitch é um dos soldados do Mago Babidi. Ele participou do Torneio de Artes Marciais a procura de energia para liberar o temido Majin Boo.")
				usr.Mission=24
			if(M.name=="Missão Dabura" && usr.Mission!=25)
				alert("O Rei dos Demônios Dabura. Devido à grande maldade no coração de Dabura, Babidi conseguiu controlar sua mente e fazer com que ele trabalhasse para Babidi. Não se precipite, ele é bem poderoso.")
				usr.Mission=25
			if(M.name=="Missão Babidi" && usr.Mission!=26)
				alert("Cuidado, [usr.name]. Babidi é o mago mais poderoso do mundo, embora sua aparência não diga o mesmo.")
				usr.Mission=26
			if(M.name=="Missão Majin Vegeta" && usr.Mission!=50)
				alert("Esse é o estágio em que o Vegeta se deixa ser controlado pelo mago Babidi para poder liberar toda a maldade do seu coração para poder lutar contra Goku. Justamente por não ter piedade em seu coração, te peço pra ter muito cuidado!")
				usr.Mission=50
			if(M.name=="Missão Majin Boo" && usr.Mission!=27)
				alert("Majin Boo é a criatura mais forte e temida do Universo. Nem o Goku com toda sua força conseguiu detê-lo sozinho. Boa sorte, [usr.name].")
				usr.Mission=27
			if(M.name=="Missão Evil Boo" && usr.Mission!=28)
				alert("Essa é a parte malígna do Majin Boo. Seus poderes são incríveis além de não ter piedade de ninguém")
				usr.Mission=28
			if(M.name=="Missão Super Boo" && usr.Mission!=29)
				alert("Após absorver Majin Boo, Evil Boo se transformou no conhecido Super Boo, que foi capaz de aniquilar todos os seres humanos da Terra em frações de segundos!")
				usr.Mission=29
			if(M.name=="Missão Bootenks" && usr.Mission!=30)
				alert("A fusão de Goten e Trunks, Gotenks, foi capaz de se deixar ser levado pela provocação de Boo e foi absorvido por ele. Cuidado, [usr.name]; nesse estágio Majin Boo está muito mais poderoso!")
				usr.Mission=30
			if(M.name=="Missão Boohan" && usr.Mission!=31)
				alert("Boohan é o nome dado a Majin Boo após ter absorvido o Gohan. Essa é a forma mais poderosa do Majin Boo, portanto, não se descuide.")
				usr.Mission=31
			if(M.name=="Missão Kid Boo" && usr.Mission!=32)
				alert("Essa é a verdadeira forma de Majin Boo, o Kid Boo. Ele é maldade pura e não se contenta até ver tudo a sua frente destruído.")
				usr.Mission=32
			if(M.name=="Missão Baby Vegeta" && usr.Mission!=33)
				alert("Baby pertence a raça Tsufurujin que foi aniquilada pelos Saiyajins no passado. Em busca de vigança, Baby se instalou no corpo de Vegeta para saciar seus anseios. Ele é muito poderoso, [usr.name]; tenha cuidado.")
				usr.Mission=33
			if(M.name=="Missão Baby Vegeta Perfeito" && usr.Mission!=34)
				alert("A última forma do Baby Vegeta. Apenas transformado em Super Saiyajin 4 o Goku foi capaz de derrotá-lo. Boa sorte, [usr.name].")
				usr.Mission=34
			if(M.name=="Missão Super 17" && usr.Mission!=35)
				alert("Essa é a perfeição da criação do Dr. Gero, o Super 17. Ele obtém uma força escumunal e pode te derrotar em segundos. Cuidado, [usr.name].")
				usr.Mission=35
			if(M.name=="Missão Omega Shenron" && usr.Mission!=36)
				alert("Cuidado, [usr.name]. Esse é o inimigo mais forte que você irá enfrentar por ora. Não se precipite, pois o Omega Shenron é o Dragão que surgiu das Esferas do Dragão e absorveu todas as Esferas restantes, tendo um poder inimaginável. Somente o Gogeta foi capaz de detê-lo.")
				usr.Mission=36
//			if(M.name=="Falar com Nail em Namekuzei")
/*			var/datum/Missions/M=input("Selecione uma Missão:","Mission Select") as null|anything in AllMissions
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
		Frase="Tenho muitas roupas a venda por aqui! Dê uma olhada no meu estoque!!"


	Vendendor_de_Itens
		icon_state="Worker"
		Frase="Olá, estou dando técnicas gratuitas. Qual você quer??"


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
			alert("Olá, [usr.name]. Eu reconstruí um dos aparelhos daqueles Saiyajins. Vai querer comprar um? Custa 50,000 de Zennie.")
	//		var/Choice=alert("Comprar?","","Sim","Não")
//			O.Collect(usr)
/* IDEIA DE PERKS

1- IMUNIDADE A BEAM
2- DANO COM DEFESA CHEIA										<<<----------------
3- ENVENENAMENTO
4- RATE DE ZENNIE
5- MENOS QUANTIDADE KI PARA LARGAR PODERES COM DEFESA CHEIA
6- ROUBO DE KI
7- REDUÇÃO DE DANO A PARTIR DE UMA QUANTIDADE DE VIDA
*/
	Perker
		icon_state="bratkid"
		verb/Falar()
			set category=null
			set src in oview()
			var/Choice=alert("Olá, [usr.name]. Sou responsável em negociações com pontos Perks. Como deseja trocar seus Perks?","Perks","Zennie","Zens","Nada")
			if(Choice=="Zennie")
				Troca
				var/PerkP=input("Quantos Perks você deseja vender? Cada Perk custa 1,000 Zennies.\nVocê tem [usr.PerkPoints]","Perks",usr.PerkPoints) as num
				if(PerkP>usr.PerkPoints)
					alert("Você não possui essa quantidade de Perks!")
					goto Troca
				usr.PerkPoints-=PerkP
				usr.Clicked2+=PerkP //eliminar os perks gastos no respec
				usr.Zenie+=PerkP*1000
			else
				if(Choice=="Zens")
					Troca2
					var/ZenP=input("Quantos Perks você deseja vender? Cada Perk custa 1 Zen. Com Zens você pode desbloquear Personagens Especiais.\nVocê tem [usr.PerkPoints]","Perks",usr.PerkPoints) as num
					if(ZenP>usr.PerkPoints)
						usr<<sound('No.ogg')
						alert("Você não possui essa quantidade de Perks!")
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
			if(randomic==1)	usr<<"Dr. Briefs: Olá, [usr]. Não sei se chegou a ver, mas construí uma nave capaz de viajar entre planetas! Ela está do lado de fora da Corporação Capsula. Espero que o Vegeta não a destrua com o seu treinamento novamente."
			if(randomic==2)	usr<<"Dr. Briefs: Quando o Raditz chegou aqui na Terra, minha filha Bulma trabalhou em cima da tecnologia do Rastreador deles. Parece ser bastante útil."
			if(randomic==3)	usr<<"Dr. Briefs: Ei, [usr]! Nessa sala a sua direita contém livros científicos muito antigos que contam inclusive todos os Eventos que ocorrem no servidor."

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
				usr<<"<b>Você já está treinando!"
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
			usr<<"Vegeta: O que quer aqui, verme? Se veio com a intenção de usar a Sala de Treino, pode ir; acabei de sair de lá. Vê se não bagunça tudo."
		verb/Missoes_Extras()
			set category=null
			set src in oview()
			if(usr.Talked8==0 && usr.Quest8==0)
				alert(usr,"Vejo que quer realizar as missões extras, certo? Hmpf... Julgando pela sua força, você vai morrer facilmente, verme. Mas que seja, vamos começar.")
				usr<<"Vegeta: Seu primeiro objetivo é derrotar o Cooler. Ele é o irmão do inseto do Freeza. Vê se não morre..."
				usr.Talked8=1
				return
			if(usr.Talked8==1 && usr.Quest8==1)
				alert("Vejo que derrotou o Cooler, não? Apois, tente derrotá-lo com o máximo do poder dele.")
				usr.Talked8=2
				return
			if(usr.Talked8==2 && usr.Quest8==2)
				alert("Graças ao auxílio de uma Estrela, Cooler pôde voltar a vida, e muito mais poderoso. Quero ver se é realmente forte, seu verme.")
				usr.Talked8=3
				return
			if(usr.Talked8==3 && usr.Quest8==3)
				alert("Hmpf... Vejo que o derrotou. Vamos ver se consegue derrotar o Lendário Super Saiyajin, inseto.")
				usr.Talked8=4
				return
			if(usr.Talked8==4 && usr.Quest8==4)
				alert("Desejo boa sorte para você agora, [usr.name]. Enfrente o Broly em sua forma mais poderosa, Lendário Super Saiyajin. Vê se não morre. Suma daqui.")
				usr.Talked8=5
				return
			if(usr.Talked8==5 && usr.Quest8==5)
				alert("Vejo que acabou realmente com o Broly. Merece minhas congratulações. Por enquanto, não tenho mais missões extras para você. Vá embora!")
				usr.Talked8=6
				return
			if(usr.Talked8==6 && usr.Quest8==5)
				alert("Você é idiota por acaso? Já falei que não tenho mais missões extras pra você.")
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
			usr<<"Cientista: Olá, [usr.name]. Bem vindo à Corporação Capsula."
