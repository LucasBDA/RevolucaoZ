var/list/AmtP=list()
var/Inimigos=0
var/Saga=""
var/Iniciado=0
var/Contador=0
mob/verb/MPE()
	set hidden=1
	set category="MPE"
	if(Iniciado==0)
		usr<<sound('No.ogg')
		alert(usr,"Miss�o Paralela Especial n�o est� aberta para registros!","Acesso Negado")
		return
	if(usr.Level<50000)
		usr<<sound('No.ogg')
		alert(usr,"Voc� n�o tem N�vel suficiente para entrar no Evento!","Acesso Negado")
		return
	var/Choice=alert(usr,"Miss�o Paralela Especial se inicia a cada 15 minutos. Apenas jogadores com N�vel igual ou superior a 50,000 podem participar.","Miss�o Paralela Especial","Entrar","Sair")
	if(Choice=="Entrar")
		for(var/mob/Player/P in AmtP)
			if(P==usr)
				alert(usr,"Voc� j� est� registrado!")
				return
		AmtP+=usr
		world<<"<b>Evento: [usr]<font color=[rgb(243,92,20)]> se registrou na Miss�o Paralela Especial!"
		usr.Resign("Entrou em outro Evento!")
	else
		for(var/mob/Player/P in AmtP)
			if(P==usr)
				AmtP-=usr
				world<<"<b>Evento: [usr]<font color=[rgb(243,92,20)]> saiu da Miss�o Paralela Especial!"
proc/StartMPE()
	for(;;)
		Saga=pick("Deus da Destrui��o","Retorno de Freeza","Goku Black")
		world<<"<b>Evento: <font color=[rgb(243,92,20)]>Miss�o Paralela Especial est� aberta � registros (O Evento se iniciar� em 2 minutos). Saga:<font color=[rgb(1,1,1)]> [Saga]!"
		Iniciado=1
		sleep(10*120)
		if(AmtP.len<1) // EVENTO CANCELADO POR FALTA DE JOGADORES
			world<<"<b>Evento: <font color=[rgb(243,92,20)]>Miss�o Paralela Especial foi cancelado!"
			Iniciado=0
			for(var/mob/Player/P in AmtP)
				P.EmEvento=0
				AmtP-=P
		else	// EVENTO INICIADO
			world<<"<b>Evento: <font color=[rgb(243,92,20)]>Miss�o Paralela Especial vai iniciar!"
			Iniciado=0
			for(var/mob/Player/P in AmtP)
				P<<"<b>Evento: <font color=[rgb(243,92,20)]>Voc� tem 5 minutos para completar a Miss�o! Vamos, se apresse!"
				P.EmEvento=1
				Contador=0
				P<<sound(pick('Dragon Ball Z Theme 8.ogg','Dragon Ball Z Theme 17.ogg','Dragon Ball Z Theme 28.ogg','Dragon Ball Z Theme 45.ogg','Dragon Ball Z Theme 10.ogg'))
				if(Saga=="Deus da Destrui��o")//src.loc=locate(322,61,1) casa do kame
					P.loc=locate(43,339,8)
				else
					if(Saga=="Retorno de Freeza")
						P.loc=locate(103,342,8)
					if(Saga=="Goku Black")
						P.loc=locate(147,341,8)
		sleep(600*3)
		for(var/mob/Player/P in AmtP)
			P<<"<b><i><font color=[rgb(243,92,20)]>O Tempo est� se esgotando! Se apresse!"
		sleep(600)
		TimeMPE()
		sleep(600*15)
proc/TimeMPE()
	for(var/mob/Player/K in AmtP)
		if(K.EmEvento==1)
			world<<"<b>Evento: <font color=[rgb(243,92,20)]>Tempo esgotado! Miss�o Paralela Especial foi finalizada sem vencedores"
			Inimigos=0
			for(var/mob/Player/P in AmtP)
				P.EmEvento=0
				P.loc=locate(322,61,1)
				AmtP-=P
			Contador=0
