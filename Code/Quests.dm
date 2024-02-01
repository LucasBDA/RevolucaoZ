mob/var/list/QuestBag
var/list/AllQuests=typesof(/obj/Items/Quests)-/obj/Items/Quests
proc/PopulateAllQuests()
    for(var/v in AllQuests)
        AllQuests+=new v
        AllQuests-=v

obj/npcQuest
	icon='NPCs.dmi'
	var/raca
	var/recompensa
	var/objetivo
	New()
        src.AddName()
        return ..()

// SAIYAJINS
    Saiyajin_1
    	raca = "Saiyajin"
    	recompensa = "Perk e Zeni"
    	objetivo = "Saibaman"
    	verb/Falar()
    		set category=null
			set src in oview()
			if(usr.QuestBag [0] == null)
	    		switch(Switch(usr, "Olá Saiyajin, gostaria de executar a próxima quest? \n[src.recompensa]", list("Aceitar", "Recusar"), 1, 1))
	    			if("Aceitar")
	    				usr.QuestBag [0] = 1
	    				Alert(usr,"Agora vá!",1,1)
	    			else
	    				Alert(usr,"Volte novamente mais tarde", 1, 1)
    		else if(usr.QuestBag [0] == 1)
    			Alert(usr,"Você ainda não completou o que eu lhe solicitei!", 1, 1)

    		else if (usr.QuestBag [0] == 2)
    			Alert(usr,"Parabéns! Você cumpriu o desafio", 1, 1)
    			usr.PerkPoints += 1
    			usr.Zenie += 100
    		else
    			Alert(usr,"Você já completou esta quest", 1, 1)









