mob/Topic(href,href_list[])
	switch(href_list["action"])
		if("ChatClick")
			switch(input("Select Action:","Player Interaction") as null|anything in list("Adicionar como amigo","Ver Perfil","Mensagem Privada"))
				if("Ver Perfil")	src.Sense()
				if("Adicionar como amigo")	src:Friend()
				if("Mensagem Privada")	usr.PM(src)

		if("Ver Clan")
			for(var/datum/Clan/G in Clans)	if(G.name==href_list["Clan"])
				var/Text="<title>Clan Roster</title><body bgcolor=black link=[rgb(255,255,255)] alink=[rgb(255,255,2550)] vlink=[rgb(255,255,255)]>"
				var/Fmt="<b><font color=[rgb(255,255,255)]>"
				var/MinReqs=""
				for(var/v in G.MinStats)	if(G.MinStats[v])
					if(!MinReqs)	MinReqs="<tr><td colspan=2>[Fmt]Estatus requeridos para entrar:<br>"
					MinReqs+="[v]: [G.MinStats[v]]<br>"
				Text+="<center><table border=1 bgcolor=[rgb(0,0,64)] width=100%>"
				Text+="<tr><td colspan=2><center>[Fmt][G.name]<br>[G.Members.len] Membros"
				Text+=MinReqs
				Text+="<tr><td><center>[Fmt]Member<td><center>[Fmt]Rank"
				for(var/v in G.Members)
					Text+="<tr><td>[Fmt][v]<td><center>[Fmt][G.Members[v]]"
				src<<browse("[Text]</table>","window=ClanRoster");break
		if("Change Rank")
			var/datum/Clan/ThisClan=locate(href_list["clan"])
			if(src.Clan && src.Clan==ThisClan && (src.HasClanRankPower("Promote") || src.HasClanRankPower("Demote")))
				var/ThisMemb=href_list["member"]
				if(ThisMemb!=src.key && src.Clan.Members[1]!=ThisMemb)
					var/NewRank=input("Coloque o novo Rank para [ThisMemb]","Coloque o Rank do membro",ThisClan.Members[ThisMemb]) as text
					NewRank=html_encode(copytext(NewRank,1,26))
					if(!ThisClan || !NewRank)	return
					if(NewRank=="Líder")	return
					var/datum/ClanRank/NewRankDatum=new()
					var/datum/ClanRank/CurrentRankDatum=new()
					for(var/datum/ClanRank/R in src.Clan.Ranks)	if(R.name==NewRank)	{NewRankDatum=R;break}
					for(var/datum/ClanRank/R in src.Clan.Ranks)	if(R.name==src.Clan.Members[ThisMemb])	{CurrentRankDatum=R;break}
					if(NewRankDatum.Level>=src.ClanRank.Level)	{alert("Não dá pra promover Ranks superiores ao seu!","Error");return}
					if(NewRankDatum.Level<src.ClanRank.Level)	if(!src.HasClanRankPower("Demote"))	{alert("Você não tem permissão para rebaixar!","Error");return}
					if(NewRankDatum.Level>CurrentRankDatum.Level)	if(!src.HasClanRankPower("Promote"))	{alert("Você não tem permissão para promover!","Error");return}
					ThisClan.Members[ThisMemb]=NewRank
					for(var/mob/M in Players)	if(M.key==ThisMemb && M.Clan==ThisClan)
						M<<"Seu Rank foi modificado para [NewRank] por [src]"
						M.SetClanRank(NewRank);break
					src.Clan.LogClanLog("[src] mudou o Rank de [ThisMemb] para [NewRank][src.Clan.GetRankLevel(NewRank)]")
					SaveClans();src:Manage_Members()
					alert("Rank de [ThisMemb] foi mudado para [NewRank]","Sucesso!")
				else	alert("Você não pode mudar o Rank desse membro!","Error")
			else	alert("Seu Rank não lhe dá permissão para esse comando!","Acesso negado!")
		if("Kick Member")
			var/ThisMemb=href_list["member"]
			var/datum/Clan/ThisClan=locate(href_list["clan"])
			if(alert("Quer mesmo chutar [ThisMemb] do [ThisClan]?","Chutar membro","Chutar","Cancel")=="Cancel")	return
			if(src.Clan && src.Clan==ThisClan && src.HasClanRankPower("Kick"))
				if(ThisMemb!=src.key && src.Clan.Members[1]!=ThisMemb)
					for(var/datum/ClanRank/R in src.Clan.Ranks)	if(R.name==src.Clan.Members[ThisMemb])
						if(R.Level>=src.ClanRank.Level)	{alert("Não dá pra chutar membros com Rank maior que o seu!","Error");return}
					ThisClan.Members-=ThisMemb
					src.Clan.LogClanLog("[src] chutou [ThisMemb]")
					for(var/mob/M in Players)	if(M.key==ThisMemb && M.Clan==ThisClan)
						M<<"[src] foi chutado do Clan!"
						M.Clan.OnlineMembers-=M
						M.Clan=null;M.ClanRank=null
						M.LeftClan();break
					src<<"[ThisMemb] foi removido do seu Clan!"
					SaveClans();src:Manage_Members()
				else	alert("Você não pode chutar esse membro!","Error")
			else	alert("Seu Rank não lhe dá permissão para esse comando!","Acesso negado!")

		if("Create Rank")
			var/datum/Clan/ThisClan=locate(href_list["clan"])
			if(src.Clan==ThisClan && src.HasClanRankPower("Create Rank"))
				src.EditClanRank=new
				for(var/datum/ClanRank/C in src.Clan.Ranks-src.EditClanRank)	if(C.name==src.EditClanRank.name)	src.EditClanRank.name="[src.EditClanRank.name](1)"
				src.Clan.Ranks+=src.EditClanRank
				src.OpenClanRanks()
				src.Clan.LogClanLog("[src] criou um novo Rank!")
				winset(src,"ClanRankWindow","is-visible=true;pos=100,100;size=512x448")
		if("EditRank")
			var/datum/Clan/ThisClan=locate(href_list["clan"])
			if(src.Clan==ThisClan && src.HasClanRankPower("Edit Ranks"))
				src.EditClanRank=locate(href_list["Rank"])
				if(src.EditClanRank.Level>=src.ClanRank.Level)	{alert("Não pode editar níveis altos de Rank","WeakSauce");return}
				src.UpdateClanRankWindow()
				winset(src,"ClanRankWindow","is-visible=true;pos=100,100;size=512x448")
				src.Clan.LogClanLog("[src] editou [src.EditClanRank]: Nível [src.EditClanRank.Level] Rank")
		if("DeleteRank")
			var/datum/Clan/ThisClan=locate(href_list["clan"])
			var/datum/ClanRank/ThisRank=locate(href_list["Rank"])
			if(ThisRank.Level>=src.ClanRank.Level)	{alert("Não pode deletar níveis altos de Rank","WeakSauce");return}
			if(alert("Deletar o Rank: [ThisRank]?\nTodos os membros desse Rank terão seus comandos removidos","Deletar Rank","Delete","Cancel")=="Delete")
				if(ThisClan==src.Clan && src.HasClanRankPower("Create Rank"))
					for(var/mob/M in src.Clan.OnlineMembers)	if(M.ClanRank==ThisRank)	M.SetClanRank(M.ClanRank.name)
					src.Clan.LogClanLog("[src] deletou [ThisRank]: Nível [ThisRank.Level] Rank")
					src.Clan.Ranks-=ThisRank
					src.OpenClanRanks()
	return ..()