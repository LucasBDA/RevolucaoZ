mob/var/tmp/datum/Missions/CurrentMission

var/list/AllMissions
proc/PopulateMissions()
	AllMissions=typesof(/datum/Missions)-/datum/Missions
	for(var/v in AllMissions)
		AllMissions+=new v
		AllMissions-=v
datum/Missions
	var/ChipSet=""
	var/name;var/Boss
	var/EnemyCount=0;var/ChestCount=0
	var/list/Enemies=list()
	A_Chegada_de_Raditz
		name="A Chegada de Raditz"
		Boss=list("Raditz",1,1.5)
		Enemies=list(list("Saibaman",6,1))
	O_Retorno_de_Goku
		name="O Retorno de Goku"
		Boss=list("Vegeta",1,2)
		Enemies=list(list("Saibaman",5,1),list("Nappa",1,1.5))
	O_Grupo_de_Frieza
		name="O Grupo de Freeza"
		Boss=list("Freeza",1,3)
		Enemies=list(list("Guldo",1,1.2),list("Recoome",1,1.4),list("Burter",1,1.5),list("Jeice",1,1.5),list("Captain Ginyu",1,2))
	Uma_Vinganca_para_Frieza
		name="Uma Vingança para Freeza"
		Boss=list("Cooler",1,3)
		Enemies=list(list("Salza",2,1.5),list("Henchman",2,1.2),list("Henchman",2,1.2))
	Os_Androides
		name="Os Andróides"
		Boss=list("Cell",1,4)
		Enemies=list(list("Android 17",1,3),list("Android 18",1,3),list("Android 19",1,2))
	Me_Encontre_na_Arena
		name="Me Encontre na Arena"
		Boss=list("Cell",1,5)
		Enemies=list(list("Cell Jr",6,3))
	A_Aparicao_do_Mago
		name="A Aparição do Mago"
		Boss=list("Babidi",1,6)
		Enemies=list(list("Videl",1,5),list("Dabura",1,3),list("Henchman",2,1))
	O_Surgimento_de_Buu
		name="O Surgimento de Buu"
		Boss=list("Buu",1,7)
		Enemies=list(list("Henchman",3,1),list("Babidi",1,3))
	O_Terrivel_Tsufurujin
		ChipSet="City"
		name="O Terrível Tsufurujin"
		Boss=list("Baby",1,8)
		Enemies=list(list("Yamcha",1,5),list("Krillin",1,5),list("Bardock",1,5))
	Uma_Estrela
		ChipSet="City"
		name="Uma Estrela"
		Boss=list("Omega Shenron",1,9)
		Enemies=list(list("Master Roshi",1,5),list("Goten",1,6),list("Olibu",1,6))

mob/proc/CompleteMission()
	var/list/PartyList=src.Party
	if(!src.Party || !src.Party.len)	PartyList=list(src)
	var/TotalKills=0;var/ChestsLooted=0
	for(var/mob/M in PartyList)
		if(M.CurrentCP && M.CurrentMission)
			M<<"<font color=orange><b>~! Missão Completa !~"
			PlaySound(M,'VictoryFanfare.ogg')
			spawn(39)
			M.CompleteTutorial("Mission Completion")
			TotalKills+=M.GetTrackedStat("NPCs Killed",M.TempTracked)
			ChestsLooted+=M.GetTrackedStat("Chests Opened",M.TempTracked)
			if(PartyList.len>=4)	M.GiveMedal(new/obj/Medals/PartyAnimal)
			if(!M.GetTrackedStat("Damage Taken",M.TempTracked))	M.GiveMedal(new/obj/Medals/Untouchable)
			if(M.GetTrackedStat("Chests Opened",M.TempTracked)>=3)	M.GiveMedal(new/obj/Medals/LuckyLooter)
			if(M.GetTrackedStat("NPCs Killed",M.TempTracked)>=6)	M.GiveMedal(new/obj/Medals/MassMurderer)
			if(PartyList.len<=1)
				M.TrackStat("Missions Completed",1)
				M.TrackStat("Completed '[M.CurrentMission.name]'",1)
			else
				M.TrackStat("([PartyList.len]xParty)Missions Completed",1)
				M.TrackStat("([PartyList.len]xParty)Completed '[M.CurrentMission.name]'",1)
		else	M<<"Your Party Finished the Mission without You =("
	for(var/mob/M in PartyList)	if(M.CurrentCP && M.CurrentMission)
		if(ChestsLooted>=M.CurrentMission.ChestCount)
			if(TotalKills-1>=M.CurrentMission.EnemyCount)
				M.GiveMedal(new/obj/Medals/Clear)
				var/dividir=1
				if(PartyList.len==2)	dividir=2
				if(PartyList.len==3)	dividir=3
				if(PartyList.len==4)	dividir=4
				for(var/mob/J in PartyList)
					if(!J.ControlClients)
						dividir-=1
						if(dividir<1)	dividir=1
				M.CompleteTutorial("Clearing Missions")
				if(M.CurrentMission.name=="A Chegada de Raditz")
					M.AddExp(50*100*dividir,"Missões Bônus")
					M.Zenie+=350
					M<<"<b>Missão Bônus!\n Zennie + 350! \n Nível + [50*dividir]!"
				if(M.CurrentMission.name=="O Retorno de Goku")
					M.AddExp(100*100*dividir,"Missões Bônus")
					M.Zenie+=700
					M<<"<b>Missão Bônus!\n Zennie + 700! \n Nível + [100*dividir]!"
				if(M.CurrentMission.name=="O Grupo de Freeza")
					M.AddExp(150*100*dividir,"Missões Bônus")
					M.Zenie+=1400
					M<<"<b>Missão Bônus!\n Zennie + 1,400! \n Nível + [150*dividir]!"
				if(M.CurrentMission.name=="Uma Vingança para Freeza")
					M.AddExp(200*100*dividir,"Missões Bônus")
					M.Zenie+=2100
					M<<"<b>Missão Bônus!\n Zennie + 2,100! \n Nível + [200*dividir]!"
				if(M.CurrentMission.name=="Os Andróides")
					M.AddExp(250*100*dividir,"Missões Bônus")
					M.Zenie+=2800
					M<<"<b>Missão Bônus!\n Zennie + 2,800! \n Nível + [250*dividir]!"
				if(M.CurrentMission.name=="Me Encontre na Arena")
					M.AddExp(300*100*dividir,"Missões Bônus")
					M.Zenie+=3500
					M<<"<b>Missão Bônus!\n Zennie + 3,500! \n Nível + [300*dividir]!"
				if(M.CurrentMission.name=="A Aparição do Mago")
					M.AddExp(350*100*dividir,"Missões Bônus")
					M.Zenie+=4200
					M<<"<b>Missão Bônus!\n Zennie + 4,200! \n Nível + [350*dividir]!"
				if(M.CurrentMission.name=="O Surgimento de Buu")
					M.AddExp(400*100*dividir,"Missões Bônus")
					M.Zenie+=4900
					M<<"<b>Missão Bônus!\n Zennie + 4,900! \n Nível + [400*dividir]!"
				if(M.CurrentMission.name=="O Terrível Tsufurujin")
					M.AddExp(450*100,"Missões Bônus")
					M.Zenie+=5600
					M<<"<b>Missão Bônus!\n Zennie + 5,600! \n Nível + [450*dividir]!"
				if(M.CurrentMission.name=="Uma Estrela")
					M.AddExp(500*100*dividir,"Missões Bônus")
					M.Zenie+=6000
					M<<"<b>Missão Bônus!\n Zennie + 6,000! \n Nível + [500*dividir]!"
				if(M.Clan)	M.Clan.AddClanExp(25,M)
				if(M.GetTrackedStat("Damage Taken",M.TempTracked))
					for(var/mob/K in PartyList)
						K<<"<b>Nível por Intocabilidade dos integrantes do Grupo!  Nível + 0!"
				else
					for(var/mob/K in PartyList)
						K<<"<b>Nível por Intocabilidade dos integrantes do Grupo!  Nível + 500!"
						K.AddExp(500*100,"Missões Bônus")
				if(PartyList.len<=1)	M.TrackStat("Missions Cleared",1)
				else	M.TrackStat("([PartyList.len]xParty)Missions Cleared",1)
		M.AddPlPercent(100);M.AddKiPercent(100)
		M.ExitCP()
	for(var/mob/M in PartyList)	M.ShowTutorial(Tutorials["Changing Characters"])