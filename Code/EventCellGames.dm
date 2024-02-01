var
	Inicio=0
mob/var/Kills=0

proc/LoopDeathMatch()
	while(world)
		sleep(10) // Tempo para a abertura. Obs.: Tempo padrão = 600*20 ~ Tempo de 1 segundo para testes
		world<<"<b><font color=[rgb(138,20,0)]> Evento em ação! Guerreiro Sanguinário! O jogador que matar mais vence. Vamos lá!  (Duração: 10 minutos)"
		Inicio=1
		global.StartDeathMatch()
		sleep(600*10)
		global.EndDeathMatch()
		Inicio=0

proc/StartDeathMatch()
	if(usr.z==1)
		usr.ChangeInstance("Labirinto")

proc/EndDeathMatch(var/mob/M)
	if(M.z==1 && Inicio==1)
		M.ExitCP()
		for(var/obj/TurfType/Instances/I in InstanceDatum.Instances["Labirinto"])
			for(var/mob/P in I.InstancePlayers)
				if(M.Kills>P.Kills)
					world<<"teste"
					return
