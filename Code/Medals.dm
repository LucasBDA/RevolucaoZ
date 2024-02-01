var/list/AllMedals=list()
var/list/AllMedalNames=list()
mob/var/list/Medals=list()
mob/var/ViewingMedal=0

proc/PopulateMedalList()
	AllMedals=typesof(/obj/Medals)-/obj/Medals
	for(var/v in AllMedals)
		var/obj/NewObj=new v
		AllMedals-=v
		AllMedals+=NewObj
		AllMedalNames+=NewObj.name
	CompletedProcs+="PopulateMedalList"

mob/proc/SaveMedals()
	if(fexists("Medals/[ckey(src.key)].sav"))	fdel("Medals/[ckey(src.key)].sav")
	var/savefile/F=new("Medals/[ckey(src.key)].sav")
	F["Medals"]<<src.Medals

mob/proc/LoadMedals()
	if(fexists("Medals/[ckey(src.key)].sav"))
		var/savefile/F=new("Medals/[ckey(src.key)].sav")
		F["Medals"]>>src.Medals

var/obj/ViewMedalPage/VMP=new
obj/ViewMedalPage
	name="* Click here to View All Medals & Scores *"
	Click()	usr<<link("http://www.byond.com/games/Falacy/DBZHU2?tab=scores")

/*
var/obj/ViewMedalStatus/VMS=new
obj/ViewMedalStatus
	name="* Click here to View Your Medals"
	Click()
		var/F="<b><font face='arial bold' color=[rgb(0,0,64)]>"
		var/MedalHTML="<title>Medal Status</title><body bgcolor=[rgb(0,0,64)]>"
		MedalHTML+="<center><table height=100% border=1 bgcolor=[rgb(255,128,0)]><tr><td colspan=2><center><b>[F]Your Medal Status"
		MedalHTML+="<tr height=50><td><center><b><i>[F][usr.Medals.len] Medals Earned<td><center><b><i>[F][AllMedals.len-usr.Medals.len] Medals Remaining"
		MedalHTML+="<tr><td valign=top><table border=1 frame=below>"
		for(var/v in usr.Medals)	MedalHTML+="<tr><td>[F][v]"
		MedalHTML+="</table><td valign=top><table border=1 frame=below>"
		for(var/obj/Medals/M in AllMedals)	if(!(M.name in usr.Medals))	MedalHTML+="<tr><td>[F][M.name]"
		MedalHTML+="</table></table>"
		usr<<browse(MedalHTML,"window=MedalStatus")
*/

obj/Medals
	icon='Medals.dmi'
	//Leveling & Stats
	Ding
		name="Ding"
		suffix="Chegar ao nivel 2!"
	Centennial
		name="Centennial"
		suffix="Chegar ao nivel 100!"
	Millennial
		suffix="Chegar ao nivel 1,000!"
	Perky
		name="Perky"
		suffix="Ganhar seu primeiro Perk!"
	LevelCap
		name="Level Cap"
		suffix="Alcançar o nivel maximo: 999.999!"
	ItsOver9000
		name="It's Over 9,000!!!"
		suffix="Quando tiver um Poder de Luta acima de 9,000!"
	StatCap
		name="Stat Cap"
		suffix="Ter algum Estatu no maximo!"
	PerfectWarrior
		name="Perfect Warrior"
		suffix="Ter todos os Estatus no maximo!"

	Perkfect
		name="Perkfect"
		suffix="Ter todos os Perks!"

	//Events
	TreasureHunter
		name="Treasure Hunter"
		suffix="Achar o Bau Dourado!"
	RelicHunter
		name="Relic Hunter"
		suffix="Achar o Bau Azul!"
	Sponsor
		name="Sponsor"
		suffix="Criar um Torneio de Artes Marciais!"
	Refunded
		name="Refunded"
		suffix="Ganhar um Torneio de Artes Marciais que voce mesmo criou!"
	WorldChampion
		name="World Champion"
		suffix="Vencer um Torneio de Artes Marciais!"
	TitleDefender
		name="Title Defender"
		suffix="Vencer 2 Torneios de Artes Marciais seguidos!"
	IStandAlone
		name="I Stand Alone"
		suffix="Derrotar um Grupo sozinho no Torneio!"
	RoyaleRoyalty
		name="Royale Royalty"
		suffix="Vencer um Torneio de Artes Marciais no modo Sobrevivencia!"

	Flag_Bearer
		suffix="Ganhar um Flag Wars!"
	Flag_Buddies
		suffix="Ganhar um Flag Wars com um membro do Clan!"

	//Missions
	Clear
		name="Clear!"
		suffix="Abrir todos os baus, e derrotar todos os inimigos de uma missao!"
	Untouchable
		name="Untouchable"
		suffix="Completar uma missao sem receber dano!"
	LuckyLooter
		name="Lucky Looter"
		suffix="Abrir 3 baus numa unica missao!"
	MassMurderer
		name="Mass Murderer"
		suffix="Derrotar 6 inimigos numa missao!"
	PartyAnimal
		name="Party Animal"
		suffix="Completar uma missao com o Grupo cheio!"
	Savior
		name="Savior"
		suffix="Salvar um amigo que esta a beira da morte numa missao!"
	Time_Traveler
		name="Time Traveler"
		suffix="Completar a Missao do Trunks do Futuro!"
//	Cells_Nightmare
//		name="Cell's Nightmare"
//		suffix="Completar a Missao do Mr. Satan!"
	Perfectionist
		name="Perfectionist"
		suffix="Completar todas as Missoes do modo Historia!"
	Punisher
		name="Punisher"
		suffix="Completar uma Missao do Nail!"
	Annihilator_Of_Evil
		name="Annihilator Of Evil"
		suffix="Completar todas as Missoes do Nail!"
	Ally_Of_The_Devil
		name="Ally Of The Devil"
		suffix="Completar a Missao do Babidi!"

	//Training
	PBagMaster
		name="P.Bag Master"
		suffix="Ganhar +100% de Exp nos Sacos de Pancada!"
	ShadowSparMaster
		name="Shadow Spar Master"
		suffix="Ganhar +100% de Exp no Treinamento de Reflexos sem Gravidade!"
	FocusedTrainer
		name="Focused Trainer"
		suffix="Ganhar +1.000 niveis numa unica sessao de treino!"
	Lazy
		name="Lazy"
		suffix="Ganhar nivel no Treinamento de Energia!"
	EvenLazier
		name="Even Lazier"
		suffix="Ganhar nivel usando o Perk: Experiencia Automatica!"

	//Clans
	UnitedWeStand
		name="United We Stand"
		suffix="Criar, ou entrar num Clan!"
	ClanContributor
		name="Clan Contributor"
		suffix="Ganhar Clan Exp!"

	//General Gameplay
	MedalUp
		name="Medal Up"
		suffix="Ganhar um nivel por ganhar uma Medalha!"
	/*MeetYourMaker
		name="Meet Your Maker"
		suffix="Play the Game while Falacy is Online"*/
	HopeOfTheUniverse
		name="Hope of the Universe"
		suffix="Se transformar em Super Saiyajin usando Goku!"
	Ascended
		name="Ascended"
		suffix="Se transformar em Super Saiyajin 2!"
	EvenFurtherBeyond
		name="Even Further Beyond"
		suffix="Se transformar em Super Saiyajin 3!"
	SuperSaiyan4
		name="Super Saiyan 4"
		suffix="Se transformar em Super Saiyajin 4!"
	BillsEnemy
		name="Bill's Enemy"
		suffix="Se transformar em Deus Super Saiyajin sendo iluminado por 5 Saiyajins de corações justos!"
	Divine_Blue
		name="Divine Blue"
		suffix="Se transformar em Super Saiyajin Blue!"
	Supreme_God
		name="Supreme God"
		suffix="Fazer a Fusão do Zamasu Gattai permanentemente!"
	Ultra_Instinct
		name="Ultra Instinct"
		suffix="Ser atingido acidentalmente pela própria Genki-Dama e despertar o Instinto Superior!"
	Registered_Mark
		name="Registered Mark"
		suffix="Possuir um Emblema para seu Clan!"
	TimeInABottle
		name="Time in a Bottle"
		suffix="Jogar por 100 horas!"
	OneMonth
		name="One Month"
		suffix="Jogar por 720 horas!"
	Proclaimer
		suffix="Andar 500 milias!"
	Millionaire
		name="Millionaire"
		suffix="Ter 1.000.000 de Zennie no Banco!"
	BeamBattler
		name="Beam Battler"
		suffix="Vencer 10 Batalhas de Poderes!"
	eBrake
		name="eBrake"
		suffix="Cancelar um lancamento 10 vezes!"
	SplitPersonality
		name="Split Personality"
		suffix="Se fundir com outro jogador!"
	EternalDragon
		name="Eternal Dragon"
		suffix="Fazer seu primeiro pedido a Shenlong!"
	Dark_DragonBalls
		name="Dark DragonBalls"
		suffix="Fazer seu primeiro pedido ao Shenlong Negro!"
	Surpass_the_Gods
		name="Surpass the Gods"
		suffix="Despertar a técnica divina do Instinto Superior Completo!"
	Ressurection
		name="Ressurection"
		suffix="Desejar Renascer para Shenlong!"
	Duelicious
		name="Duelicious"
		suffix="Vencer um Duelo PvP!"
	Thief
		suffix="Roubar 1.000 de Zennie!"
	Medic
		name="Medic"
		suffix="Curar membros do Grupo 100 vezes!"
	GhostBuster
		name="Ghost Buster"
		suffix="Reviver 10 membros caidos do Grupo!"
	Friendly
		name="Friendly"
		suffix="Adicionar alguem como amigo!"

	//Player Status
	Player
		name="Player"
		suffix="Entrar no jogo pela primeira vez!"
//	ByondMember
//		name="BYOND Member"
//		suffix="Have an Active BYOND Membership"
//	Subscriber
//		name="Subscriber"
//		suffix="Have an Active Stray Games Subscription"
//	SubMember
//		name="Sub Member"
//		suffix="Have an Active Subcription and Membership"

	Completionist
		name="Completionist"
		suffix="Ter todas as medalhas!"

mob/var/tmp/list/MedalObjs
mob/proc/MedalCorrection()
	while(!("PopulateMedalList" in CompletedProcs))	sleep(1)
	src.MedalObjs=list()
	for(var/v in src.Medals)
		if(v=="Its Over 9,000!!!")	src.Medals+="It's Over 9,000!!!"
		if(v=="Member")	src.Medals+="BYOND Member"
		if(v=="Mission Perfect")	src.Medals+="Untouchable"
		if(v=="Mass Murder")	src.Medals+="Mass Murderer"
		if(v=="P.Bag Mastery")	src.Medals+="P.Bag Master"
		if(v=="Shadow Spar Mastery")	src.Medals+="Shadow Spar Master"
		if(v=="Been There, Done That")	src.Medals+="Player"
		if(v=="On Your Way")	src.Medals+="Ding"
		if(v=="Well On Your Way")	src.Medals+="Centennial"
		if(!(v in AllMedalNames))	src.Medals-=v
	for(var/obj/Medals/M in AllMedals)	if(M.name in src.Medals)	src.MedalObjs+=M
	src.SaveMedals()

mob/proc/GiveMedal(var/obj/Medals/M)
	if(!src.client)	return
	spawn()
		while(src.ViewingMedal)	sleep(1)
		if(M.name in src.Medals)
			return
		if(!(M.name in src.Medals))
			src.ViewingMedal=1;src.Medals+=M.name;src.SaveMedals()
			winset(src,"MedalWindow.DescLabel","text=\"- [M.name] -\n[M.suffix]\"")
			for(var/obj/Medals/O in AllMedals)	if(O.name==M.name)	{src.MedalObjs+=O;break}
			winset(src,"MedalWindow","pos=8,44;is-visible=true")
			PlaySound(src,'BleepBloop.ogg')
			world<<"<b><font size=1 color=[rgb(250,100,0)]>\icon[M] [src] ganhou a Medalha:  [M.name]!"
			spawn(50)	if(src)	{winset(src,"MedalWindow","is-visible=false");src.ViewingMedal=0}
			spawn()	world.SetMedal(M.name,src)
			src.TrackStat("Medals Earned","[src.Medals.len]/[global.AllMedals.len]")
			if(src.Medals.len>=global.AllMedals.len-1)	src.GiveMedal(new/obj/Medals/Completionist)


mob/verb/Select_Title()
	set hidden=1
	src.Title=input("Select Your Title:","Select Title",src.Title) as null|anything in src.Medals
	src.ResetSuffix()

obj/Supplemental/TitleDisplay
	icon='TextGold.dmi'
	layer=FLOAT_LAYER
	pixel_y=-30
	var/DefaultOffset=9
	New(var/px,var/IS)
		src.pixel_x=px+DefaultOffset
		src.icon_state=IS
		if(LowLetter(IS))	src.pixel_y-=2
mob/proc/AddTitle()
	for(var/O in src.overlays)	if(O:name=="TitleDisplay")	src.overlays-=O
	if(!src.Title)	return
	var/Name2Add=src.Title
	var/PixelSpace=6
	var/letter;var/spot=0
	var/px=((1*PixelSpace)-(length(Name2Add)*PixelSpace)/2)-PixelSpace
	while(spot<length(Name2Add))
		spot+=1;letter=copytext(Name2Add,spot,spot+1)
		if(SlimLetter(letter))	px+=2
	spot=0
	while(1)
		spot+=1;letter=copytext(Name2Add,spot,spot+1)
		if(!letter)	return
		px+=PixelSpace
		var/obj/NL=new/obj/Supplemental/TitleDisplay(px,letter)
		if(!src.Clan)	NL.pixel_y+=10
		if(SlimLetter(letter))	px-=4
		src.overlays+=NL