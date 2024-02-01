obj/HUD
	Player_vs_Player
		icon_state="PvP"
		screen_loc="7,1"
		desc="Arenas PvP"
		MouseEntered()
			return ..()
			src.desc="[initial(src.desc)]\nWT Status: [global.TournStatus]"
			return ..()
		Click()
			for(var/mob/Player/P in AmtP)
				if(P==usr)
					usr<<"<b>Acesso Negado! Você está participando ou está registrado em outro Evento"
					usr<<sound('No.ogg')
					return
			var/Choice=input("Select a PvP Arena","Arena Options") as null|anything in list("Arena Vermelha","Arena Azul","Arena Verde")
			if(Choice=="Arena Vermelha")
				if(usr.Traveling==1)	return
				usr.ChangeInstance("PvpArenas")
			else
				if(Choice=="Arena Azul")
					if(usr.Traveling==1)	return
					usr.ChangeInstance("ClanPvpArenas")
				if(Choice=="Arena Verde")
					if(usr.Traveling==1)	return
					usr.ChangeInstance("BalancedPvpArenas")





//obs.: colocar os codes do click() das arenas pvp aqui
