mob/var/list/MissionBag
mob/var/list/MissionBag2
var/list/AllMissoes=typesof(/obj/Items/Missoes)-/obj/Items/Missoes
proc/PopulateAllMissoes()
	for(var/v in AllMissoes)
		AllMissoes+=new v
		AllMissoes-=v
obj/Items/Missoes
	var/X1=0
	Collect(var/mob/M)
		if(!EmLista(M.MissionBag))	M.MissionBag=list()
		for(var/obj/Items/Missoes/R in M.MissionBag)	if(R.type==src.type)
			R.suffix="";return
		M.MissionBag+=new src.type
	New()
		src.AddName()
		return ..()
	Raditz
		name="Missão Raditz"
	Saibaman
		name="Missão Saibaman"
	Nappa
		name="Missão Nappa"
	Vegeta
		name="Missão Vegeta"
	Patriarca
		name="Falar com o Nail"
	Guldo
		name="Missão Guldo"
		X1=50
	Recoome
		name="Missão Recoome"
		X1=50
	Jeice
		name="Missão Jeice"
		X1=50
	Burter
		name="Missão Burter"
		X1=50
	CG
		name="Missão Capitão Ginyu"
		X1=50
	F1
		name="Missão Freeza 1ª Forma"
		X1=50
	F2
		name="Missão Freeza 2ª Forma"
		X1=50
	F3
		name="Missão Freeza 3ª Forma"
		X1=50
	F4
		name="Missão Freeza 4ª Forma"
		X1=50
	MF
		name="Missão Mecha Freeza"
	Androide19
		name="Missão Andróide Nº 19"
	Androide20
		name="Missão Andróide Nº 20"
	Androide17
		name="Missão Andróide Nº 17"
	Androide18
		name="Missão Andróide Nº 18"
	C1
		name="Missão Cell Imperfeito"
	C2
		name="Missão Cell Semi-Perfeito"
	C3
		name="Missão Cell Perfeito"
	Spopovitch
		name="Missão Spopovitch"
	Dabura
		name="Missão Dabura"
	Babidi
		name="Missão Babidi"
	MV
		name="Missão Majin Vegeta"
	MB
		name="Missão Majin Boo"
	EB
		name="Missão Evil Boo"
	SB
		name="Missão Super Boo"
	Bootenks
		name="Missão Bootenks"
	Boohan
		name="Missão Boohan"
	KidBoo
		name="Missão Kid Boo"
	BV
		name="Missão Baby Vegeta"
	BV2
		name="Missão Baby Vegeta Perfeito"
	S17
		name="Missão Super 17"
	OS
		name="Missão Omega Shenron"