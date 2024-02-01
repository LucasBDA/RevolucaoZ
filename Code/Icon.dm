mob/Icon/verb
	Custom_Icon()
		set category="GM"
		var/icon/I=usr.UploadIconProc();if(!I)	return
		usr.icon=I;usr<<"Icon uploading complete!"
		usr.UpdatePartyIcon()
		usr.UpdateFaceHUD()
	Play_Music()
		set category="GM"
		var/F=input("Select midi or .wav to Play","Play Music") as null|file
		if(F)
			world<<"<b>* [usr] is Playing: [F]"
			world<<sound(null)
			world<<sound(F)
		else	world<<sound(null)
	Get_DragonBalls()
		set category="GM"
		for(var/obj/Items/DragonBalls/B in world)	B.loc=usr.loc
		usr<<"DragonBalls Summoned"
	Watch_Player()
		set category="GM"
		if(src.client.eye!=src)	{src.client.eye=src;return}
		var/mob/M=input("Select the Player to Spy On","Watch Player") as anything in Players
		if(M)	usr.client.eye=M
		if(M.FusionMob)	usr.client.eye=M.FusionMob
	SetIS()
		set category="Test"
		usr.icon_state=input("input new icon_state","Set IS",usr.icon_state) as text
	Reboot()
		set category="GM"
		if(alert("Reboot the Server?","Reboot","Reboot","Cancel")=="Reboot")
			world<<"<font size=5 color=red>[usr] Rebootou o Servidor!"
			sleep(1);world.Reboot()
	Goto(var/mob/M in world)
		set category="GM"
		if(M.key=="Shawn_EX" || M.key=="Hkl" || M.key=="RLKS")
			usr<<"<b>Você não pode ir até esse GM, bosta de cuzão! \nAbraços, Shawnzão"
			return
		usr.loc=M.loc
		world<<"[usr] has Teleported to [M]"
	Bring(var/mob/M in world)
		set category="GM"
		if(M.key=="Shawn_EX" || M.key=="Hkl" || M.key=="RLKS")
			usr<<"<b>Você não pode sumonar esse GM, cuzão de bosta! \nAbraços, Shawnzão"
			return
		M.loc=usr.loc
		world<<"[usr] has Summoned [M]"
	Delete(var/atom/A in world)
		set category="GM"
		if(A && alert("Are you sure you want to Delete [A]?","Delete [A]","Delete","Cancel")=="Delete")
			if(ismob(A) && A:client)
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