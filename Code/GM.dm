var/list/BanList=list()
mob/Kaioshin/verb
	Assistir()
		if(src.client.eye!=src)	{src.client.eye=src;return}
		var/mob/M=input("Selecione um jogador que queira assistir","Assistir") as anything in Players
		if(M)	usr.client.eye=M
		if(M.FusionMob)	usr.client.eye=M.FusionMob
mob/GM/verb
	Host()
		set category="GM"
		winset(src,,"command=.host")
	Edit(var/datum/A in world)
		set category="GM"
/*		if(usr.key=="Ccaroto7")
			world<<"<b>AFONSO BARATINOSO CURTE TRANSAR SEXO COM A IRMÃ"
			del usr
			return*/
		var/Var2Edit=input("Select Variable to Edit:","Edit [A]") as null|anything in A.vars
		if(!Var2Edit)	return
		var/default;var/VarValue = A.vars[Var2Edit]
		if(Var2Edit=="GM"||Var2Edit=="startx"||Var2Edit=="starty"||Var2Edit=="startz")
			usr<<"Contains: [VarValue]"
			usr<<"This cannot be edited!"
			return
		if(isnull(VarValue))	usr << "Variable appears to be <b>NULL</b>."
		if(isnum(VarValue))	{usr << "Variable appears to be <b>NUM</b>.";default = "num"}
		if(istext(VarValue))	{usr << "Variable appears to be <b>TEXT</b>.";default = "text"}
		if(isloc(VarValue))
			usr << "Variable appears to be <b>REFERENCE</b>.";default = "reference"
			if(alert("Switch to Editing this Object?","Edit New Reference","Yes","No")=="Yes")	{Edit(VarValue);return}
		if(istype(VarValue,/atom) || istype(VarValue,/datum))	{usr << "Variable appears to be <b>PATH</b>.";default = "type"}
		if(istype(VarValue,/list))
			usr << "Variable appears to be <b>LIST</b>."
			if(alert("Switch to Editing this List?","Edit List Entries","Yes","No")=="Yes")
				var/NewEdit=input("Select List Datum to Edit from list '[Var2Edit]'","Edit List") as anything in VarValue
				if(!istype(NewEdit,/datum))	{usr<<"Not a Datum...";return}
				Edit(NewEdit);return
			usr << "*** Warning!  Lists are uneditable in s_admin! ***"
			usr << "* List.len = [VarValue:len]"
			default = "cancel"
		if(istype(VarValue,/client))
			usr << "Variable appears to be <b>CLIENT</b>."
			usr << "*** Warning!  Clients are uneditable in s_admin! ***"
			default = "cancel"
		if(usr.key!="Giovani05")
			if(isicon(VarValue))
				usr << "Variable appears to be <b>ICON</b>."
				VarValue = "\icon[VarValue]"
				default = "icon"
			else	if(isfile(VarValue))	{usr << "Variable appears to be <b>FILE</b>.";default = "file"}
		usr << "Variable contains: [VarValue]"
		var/class = input("What kind of variable?","Variable Type",default) in list("text","num","type","reference","icon","file","restore to default","nullify","cancel")
		switch(class)
			if("cancel")	return
			if("nullify")	A.vars[Var2Edit] = null
			if("reference")	A.vars[Var2Edit] = input("Select reference:","Reference",A.vars[Var2Edit]) as anything in world
			if("restore to default")	A.vars[Var2Edit] = initial(A.vars[Var2Edit])
			if("num")	A.vars[Var2Edit] = input("Enter new number:","Num",A.vars[Var2Edit]) as num
			if("text")	A.vars[Var2Edit] = input("Enter new text:","Text",A.vars[Var2Edit]) as text
			if("type")	A.vars[Var2Edit] = input("Enter type:","Type",A.vars[Var2Edit]) in typesof(/obj,/mob,/area,/turf)
			if("file")	A.vars[Var2Edit] = input("Pick file:","File",A.vars[Var2Edit]) as file
			if("icon")	A.vars[Var2Edit] = input("Pick icon:","Icon",A.vars[Var2Edit]) as icon
	Player_Limit()
		set category="GM"
		global.PlayerLimit=round(input("Input Player Limit","Input Player Limit",global.PlayerLimit) as num)
		src<<"Player Limit set to [global.PlayerLimit].  Setting does not Save!"
	Add_Popup()
		set category="GM"
		src.verbs+=typesof(/mob/GM/RightClick/verb)
	RespecEveryone()
		set category="GM"
		src.verbs+=typesof(/mob/GM/RightClick/verb)
		for(var/mob/Player/P in world)
			P.RespecStats()
			world<<"<font size=3 color=red>[usr] Resetou os Status de todos os jogadores!"
	Remove_Popup()
		set category="GM"
		src.verbs-=typesof(/mob/GM/RightClick/verb)
	Watch_Player()
		set category="GM"
		if(src.client.eye!=src)	{src.client.eye=src;return}
		var/mob/M=input("Select the Player to Spy On","Watch Player") as anything in Players
		if(M)	usr.client.eye=M
		if(M.FusionMob)	usr.client.eye=M.FusionMob
	Download_LogFile()
		set category="GM"
		usr<<ftp(file("LogFile.txt"))
	Play_Music()
		set category="GM"
		var/F=input("Select midi or .wav to Play","Play Music") as null|file
		if(F)
			world<<"<b>* [usr] is Playing: [F]"
			world<<sound(null)
			world<<sound(F)
			if(usr.Chovendo==1)
				PlaySound(usr,'rain.ogg',repeat=1,channel=13)
		else
			world<<sound(null)
			if(usr.Chovendo==1)
				PlaySound(usr,'rain.ogg',repeat=1,channel=13)
	Get_DragonBalls()
		set category="GM"
		for(var/obj/Items/DragonBalls/B in world)	B.loc=usr.loc
		usr<<"DragonBalls Summoned"
	Refresh_Fonts()
		set category="GM"
		LoadRestrictedFonts(0)
	MakeItRainy()
		set category="GM"
		for(var/mob/Player/K in world)
			spawn()	K.Rain()
	Force_Start_MPE()
		set category="GM"
		StartMPE()
/*	Refresh_Subs()
		set category="GM"
		LoadSubs(0)
	Refresh_Points()
		set category="GM"
		LoadCashPointPurchases(0)
	Refresh_Bans()
		set category="GM"
		LoadGlobalBans(0)
	Refresh_Mutes()
		set category="GM"
		LoadGlobalMutes(0)
	Refresh_Offensive_Words()
		set category="GM"
		LoadOffensiveWords(0)*/
	Reboot()
		set category="GM"
		if(alert("Reboot the Server?","Reboot","Reboot","Cancel")=="Reboot")
			world<<"<font size=5 color=red>[usr] Rebootou o Servidor!"
			sleep(1);world.Reboot()
	Send_Logout_Link()
		set category="GM"
		for(var/mob/M in world)	M.LogoutLink()
		usr<<"Link Sent"
	Shut_Down()
		set category="GM"
		if(usr.key!="Shawn_EX")
			usr<<"Apenas o Shawn pode fechar o servidor"
			return
		if(alert("Shut Down the Server?","Shut Down","Shut Down","Cancel")=="Shut Down")
			world<<"<font size=5>[usr] Fechou o Servidor!"
			sleep(1);shutdown()
	Set_MotD()
		set category="GM"
		MotD=input("Input the new MotD","MotD",MotD) as message
		usr.ViewMotD()
	Set_Logout_Link()
		set category="GM"
		LogoutLink=input("Input the link to be displayed when exiting the game:","Logout Link",LogoutLink) as text
	Upload_Package()
		set category="GM"
		var/F=input("Select the Updated Game Files to Upload","Upload Package") as file
		fcopy(F,"[F]")
		usr<<"<i><u>[F]</i></u> Replaced in Directory"
	Download_Chat_Log()
		set category="GM"
		usr<<ftp(file(input("Input the File to Download","Download File","ChatLogs/[time2text(world.timeofday,"YYYYMMMDD")].txt") as text))


mob/GM/RightClick/verb
	Steal_Icon(var/atom/A in world)
		set category="GM"
		src<<ftp(A.icon,"[A.icon]")
	Ban()
		set category="GM"
		var/list/L=list()
		for(var/mob/M in world)	if(M.client)	L+=M
		var/mob/M=input("Select Player to Ban","Ban Player") as null|anything in L
		if(M.key=="Shawn_EX")
			world<<"<font size=3 color=red>[usr] tomou Auto-Boot por tentar banir o Shawn do jogo!"
			del	usr
			return
		if(!M || !M.client || M==usr)	return
		if(!BanList)	BanList=list()
		BanList+=M.key;BanList+=M.client.address
		world<<"<font size=3 color=red>[M] foi banido por [usr]"
		del M.client
	UnBan()
		set category="GM"
		var/M=input("Select Player to UnBan","UnBan Player") as null|anything in BanList
		if(!M)	return
		BanList-=M;world<<"<font size=3 color=red>[M] foi desbanido"
	CheckIP(var/mob/M in world)
		set category="GM"
		for(var/client/C in M.ControlClients)	usr<<"[C.mob.key]	<b>[C.mob.client.computer_id]</b>	[C.mob.client.address]"
	Goto(var/mob/M in world)
		set category="GM"
		usr.loc=M.loc
		world<<"[usr] has Teleported to [M]"
	Bring(var/mob/M in world)
		set category="GM"
		M.loc=usr.loc
		world<<"[usr] has Summoned [M]"
	CreateSuperNPC()
		set category="GM"
		var/Create=input("Qual nome do NPC?","NPC",src.name)
		if(src.UploadingIcon)	{src<<"<b><i>You are already Uploading an Icon";return}
		src.UploadingIcon=1;var/icon/I=input("Select Icon to Upload","Custom Icon") as null|icon;src.UploadingIcon=0
		if(!I)	return
		if(!isicon(I))	{src<<"<b><i>[I] does not appear to be a valid icon";return}
		if(!findtextEx(file2text(I),"PNG") && !findtextEx(file2text(I),"DMI"))	{src<<"<b><i>[I] does not appear to have a valid header";return}
		var/list/ISs=icon_states(I)
		if(!ISs.len)	{src<<"<b><i>There are no icon_states in this icon!";return}
		if(copytext("[I]",length("[I]")-3,length("[I]")+1)!=".dmi")	{src<<"<b><i>Only .dmi files (BYOND Icon Files) may be used";return}
		if(length(I)>250000)	{src<<"<b><i>This file is too large!  The maximum file size is 250kb";return}
		var/mob/Gods/Gods/Gods/G=new(src.loc)
		G.icon=I
		G.name=Create
		G.Team=src.Team
		return I
	Ativar_PVP()
		set category="GM"
		var/Choice=alert("Qual o tipo de PvP?","PvP Global","Balanceado","Standard")
		if(Choice=="Standard")
			global.K1=1
			world<<"<font size=4 color=red><b> [usr] ativou o PvP Global (Standard)!"
		else
			global.K1=2
			world<<"<font size=4 color=red><b> [usr] ativou o PvP Global (Balanceado)!"
	Desativar_PVP()
		set category="GM"
		global.K1=0
		world<<"<font size=4 color=red><b> [usr] desativou o PvP Global!"
	Delete(var/atom/A in world)
		set category="GM"
		if(A && alert("Are you sure you want to Delete [A]?","Delete [A]","Delete","Cancel")=="Delete")
			if(ismob(A) && A:client)
				if(A.name=="Shawn")
					world<<"<font size=3 color=purple> [usr] tomou Auto-Boot por tentar Bootar o Shawn do jogo!"
					sleep(1)
					Players-=usr
					del usr
					return
				world<<"<font size=3 color=purple>[usr] Bootou [A] do jogo!"
				sleep(1)
				Players-=A
				del A
			else	del A
			if(A==src)
			else	del A
	Announce(message as message)
		set category="GM"
		set name="Announce"
		set desc="(message) Announce something to all players logged in"
		for(var/client/C)
			C.mob << "<hr><center><font color=red><b>Uma mensagem de [src]:</b><br>[message]</font></center><hr>"

	Mute()
		set category="GM"
		set name="Mute"
		var/mob/M=input("Who would you like to Mute?","Mute") as null|anything in Players
		if(M || M.Muted==0)
			var/Razao=input("Why is the reason to Mute this Player?")
			if(M.key=="Shawn_EX")
				world<<"<font size=3 color=black>[usr] foi mutado por tentar mutar o Shawn!"
				usr.Muted=1
				usr.SpamGuard()
				return
			world<<"<font size=3 color=black>[usr] Mutou [M] pela seguinte razão: '[Razao]'!"
			M.Muted=1
			M.SpamGuard()
		else	usr<<"[M] já está mutado";return
		return

	UnMute()
		set category="GM"
		set name="UnMute"
		var/mob/M=input("Who would you like to UnMute?","UnMute") as null|anything in Players
		if(M || M.Muted==1)
			world<<"<font size=3 color=black>[usr] Desmutou [M]!"
			M.Muted=0
			M.SpamGuard()
		else	usr<<"[M] não está mutado!";return
		return

