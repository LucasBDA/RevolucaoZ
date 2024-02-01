obj/CapsuleChars
	icon='Items.dmi'
	icon_state="Capsule"
	var/tmp/mob/CharMob
	suffix="Clique para Summonar."
	verb/Retirar()
		set src in world
		if(src.CharMob)	src.CharMob.DismissNPC()
	verb/Criar()
		set src in world
		if(usr.y>=150 && usr.x<222 && usr.z==8)
			usr<<sound('No.ogg')
			alert(usr,"Você não pode criar capsulas no Tutorial!")
			return
		usr.CompleteTutorial("Capsule Characters")
		if(usr.FusionMob)	{usr<<"Disabled when Fused";return}
		if(src.CharMob)	{usr<<"Este personagem já está ativo!";return}
		if(!(usr in usr.Party))
			usr.Party+=usr;usr.PartyID=1
			usr.UpdatePartyHUD(usr)
		if(usr.Party.len>=4)	{usr<<"Seu grupo já está cheio...";return}
		for(var/mob/M in usr.Party)	if(M.InTournament)	{usr<<"Not Available During Events";return}
		if(usr.InstanceObj && usr.InstanceObj.name=="Flag Wars")	{usr<<"Not Available During Events";return}
		var/mob/CombatNPCs/CapsuleChars/C=new(usr.loc,src.name)
		C.Owner=usr;C.name="[C.name] ([usr.key])";C.Team=usr.Team
		src.CharMob=C;C.Party=list();C.JoinParty(usr);C.TargetMob()
	Piccolo
		desc="Vá na missão 'A Chegada de Raditz'."
	Goku
		desc="Derrotar Raditz usando o Special Beam Cannon do Piccolo."
	Raditz
		desc="Derrotar Raditz usando Goku Mid."
	Saibaman
		desc="Derrotar Raditz usando Saibaman."
	Nappa
		desc="Derrotar Nappa usando Vegeta."
	Vegeta
		desc="Derrotar Vegeta usando Goku Mid."
var/obj/CapsuleCharGuide/CapsuleCharGuide=new
obj/CapsuleCharGuide
	name="* Veja como desbloquear as Capsulas! (Clique aqui)"
	Click()
		usr<<browse(src.desc,"window=CharGuide")
		return ..()

var/list/AllCapsuleChars=list()
proc/PopulateCapsuleChars()
	AllCapsuleChars=typesof(/obj/CapsuleChars)-/obj/CapsuleChars
	for(var/v in AllCapsuleChars)
		var/obj/NewObj=new v
		AllCapsuleChars-=v
		AllCapsuleChars+=NewObj
	var/HTML="<title>Guia de Capsulas</title><body bgcolor=[rgb(0,0,64)]><center><table border=1 width=100% bgcolor=[rgb(255,255,255)]>"
	HTML+="<tr><td><u><center><b>Personagem<td><center><u><b>Como desbloquear"
	for(var/obj/CapsuleChars/C in AllCapsuleChars)
		HTML+="<tr><td><b>[C.name]<td>[C.desc]"
	global.CapsuleCharGuide.desc=HTML
	CompletedProcs+="PopulateCapsuleChars"

mob/proc/CheckMissionUnlocks(var/mob/Target,var/datum/Missions/Mission,var/DamageType)
	if(Mission.type==/datum/Missions/A_Chegada_de_Raditz)
		if(Target.name=="Raditz")
			if(DamageType=="Beam" && src.Character.name=="Piccolo")	src.UnlockCapsuleChar("Goku")
			else	if(src.Character.name=="Saibaman")	src.UnlockCapsuleChar("Saibaman")
			else	if(src.Character.name=="Goku Mid")	src.UnlockCapsuleChar("Raditz")
	if(Mission.type==/datum/Missions/O_Retorno_de_Goku)
		if(Target.name=="Nappa")	if(src.Character.name=="Vegeta")	src.UnlockCapsuleChar("Nappa")
		if(Target.name=="Scouter Vegeta")	if(src.Character.name=="Goku Mid")	src.UnlockCapsuleChar("Vegeta")
	src.SetFocus("MainWindow.MainMap")

mob/proc/UnlockCapsuleChar(var/NewChar)
	if(!EmLista(src.CapsuleChars))	src.CapsuleChars=list(new/obj/CapsuleChars/Piccolo)
	for(var/obj/CapsuleChars/C in src.CapsuleChars)	if(C.name==NewChar)	return
	var/TextPath=text2path("/obj/CapsuleChars/[NewChar]")
	src.CapsuleChars+=new TextPath
	src.TrackStat("Characters Unlocked","[src.CapsuleChars.len]/[global.AllCapsuleChars.len]")
	spawn()	alert(src,"You have Unlocked the Character Capsule for [NewChar]!","Capsule Character Unlocked")

mob/CombatNPCs/CapsuleChars
	New(var/turf/NewLoc,var/NewChar)
		for(var/obj/Characters/M in AllCharacters)
			if(M.name==NewChar)
				src.Character=M;src.name=M.name
				src.icon=src.Character.icon;break
		src.AddName()
		spawn()	src.CombatAI()
		return ..()
	verb/Retirar()
		set src in oview()
		if(src.Owner==usr)	src.DismissNPC()