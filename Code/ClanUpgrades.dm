var/list/AllClanUpgrades=list("Leech"=5,"Fast Track"=5,"Cash Flow"=5,"Clan Boost"=1,"Crafters United"=5)

mob/proc/HasClanUpgrade(var/ThisUpgrade)
	if(src.Clan && src.Clan.HasUpgrade(ThisUpgrade))	return src.Clan.Upgrades[ThisUpgrade]
	else	return 0

mob/verb/RenameClan()
	var/datum/Clan/ThisClan=src.Clan
	if(!src.HasClanRankPower("Rename Clan"))	{alert(src,"Your Clan Rank Cannot Rename the Clan","Access Denied");return}
	if(!ThisClan || ThisClan.Exp<10000)	{alert(src,"More Clan Exp Required!","Insufficient Funds");return}
	var/NewName=ClanNameGuard(input("Input New Clan Name","Rename Clan",ThisClan.name) as text)
	if(!NewName || src.Clan!=ThisClan)	{alert(src,"Invalid Clan Name","Error");return}
	if(findtext(ThisClan,"Shawn") || findtext(ThisClan,"Acarajé") || findtext(ThisClan,"Rede") || findtext(ThisClan,"Preguiça") || findtext(ThisClan,"Acaraje") || findtext(ThisClan,"Preguica") || findtext(ThisClan,"Baiano") || findtext(ThisClan,"Bahia") || findtext(ThisClan,"rede") || findtext(ThisClan,"Macumba") || findtext(ThisClan,"Macumbeiro"))
		ThisClan="Clan dos Homossexuais"
	ThisClan.LogClanLog("[src] Renamed the Clan from <i>[ThisClan.name]</i> to <i>[NewName]</i>")
	for(var/obj/TerritoryWars/Territory_Flag/T in world)	if(T.ClanOwner==ThisClan.name)	{T.ClanOwner=NewName;T.AddName(NewName)}
	for(var/mob/CombatNPCs/Enemies/TW_Guard/T in world)	if(T.Team==ThisClan.name)	T.Team=NewName
	for(var/mob/Player/P in Players)	if(P.Team==ThisClan.name)	P.SetTeam(NewName)
	ThisClan.name=NewName;ThisClan.Exp-=10000;src.ClanExpPane()
	for(var/mob/M in Players)	if(M.Clan==ThisClan)	M.AddClanName()

mob/verb/BuyClanUpgrade(var/ThisUpgrade as null|text)
	set hidden=1
	var/MaxLevel=5
	var/UpgradeCost=10000
	if(!src.Clan)	return
	var/datum/Clan/ThisClan=src.Clan
	if(ThisUpgrade=="Clan Boost")	{MaxLevel=1;UpgradeCost=100000}
	if(alert("Buy a [ThisUpgrade] Upgrade for [FullNum(UpgradeCost)]?","Buy Upgrade","Purchase","Cancel")=="Purchase")
		if(!src.HasClanRankPower("Buy Upgrades"))	{alert("Your Rank Doesn't Have Permission to Buy Clan Upgrades!","Access Denied!");return}
		if(src.Clan.Exp<UpgradeCost)	{alert("Your Clan doesn't have enough Exp for that Upgrade!","Too Poor!");return}
		if(src.HasClanUpgrade(ThisUpgrade)>=MaxLevel)	{alert("[ThisUpgrade] is Already at Max Level!","Too Late!");return}
		if(src.Clan!=ThisClan)	return
		if(!(ThisUpgrade in src.Clan.Upgrades))	src.Clan.Upgrades+=ThisUpgrade
		src.Clan.Upgrades[ThisUpgrade]+=1
		src.Clan.ExpSpent+=UpgradeCost
		src.Clan.Exp-=UpgradeCost;src.ClanExpPane()
		spawn(-1)	alert("[ThisUpgrade] Upgraded to Lvl.[src.Clan.Upgrades[ThisUpgrade]]!","Success!")
		src.Clan.LogClanLog("[src] Spent [FullNum(UpgradeCost)] Clan Exp to Upgrade [ThisUpgrade] to Lvl.[src.Clan.Upgrades[ThisUpgrade]]")
mob/verb/Emblem()
	if(!src.HasClanRankPower("Edit Emblem"))	{alert(src,"Your Clan Rank Cannot Rename the Clan","Access Denied");return}
	if(!src.Clan || src.Clan.Exp<100000)	{alert(src,"More Clan Exp Required!","Insufficient Funds");return}
	winset(usr,"Emblemas","size=640x480;pos=100,100;is-visible=true")
mob/verb/Option1()
	usr.Clan.Emblem=1
	usr.Clan.Exp-=100000
mob/verb/Option2()
	usr.Clan.Emblem=2
	usr.Clan.Exp-=100000
mob/verb/Option3()
	usr.Clan.Emblem=3
	usr.Clan.Exp-=100000
mob/verb/Option4()
	usr.Clan.Emblem=4
	usr.Clan.Exp-=100000
mob/verb/Option5()
	usr.Clan.Emblem=5
	usr.Clan.Exp-=100000
mob/verb/Option6()
	usr.Clan.Emblem=6
	usr.Clan.Exp-=100000
mob/verb/Option7()
	usr.Clan.Emblem=7
	usr.Clan.Exp-=100000
mob/verb/Option8()
	usr.Clan.Emblem=8
	usr.Clan.Exp-=100000
mob/verb/Option9()
	usr.Clan.Emblem=9
	usr.Clan.Exp-=100000
mob/verb/Option10()
	usr.Clan.Emblem=10
	usr.Clan.Exp-=100000
mob/verb/Option11()
	usr.Clan.Emblem=11
	usr.Clan.Exp-=100000
mob/verb/Option12()
	usr.Clan.Emblem=12
	usr.Clan.Exp-=100000
mob/verb/Option13()
	usr.Clan.Emblem=13
	usr.Clan.Exp-=100000
mob/verb/Option14()
	usr.Clan.Emblem=14
	usr.Clan.Exp-=100000
mob/verb/Option15()
	usr.Clan.Emblem=15
	usr.Clan.Exp-=100000
mob/verb/Option16()
	usr.Clan.Emblem=16
	usr.Clan.Exp-=100000
mob/verb/Option17()
	usr.Clan.Emblem=17
	usr.Clan.Exp-=100000
mob/verb/Option18()
	usr.Clan.Emblem=18
	usr.Clan.Exp-=100000

