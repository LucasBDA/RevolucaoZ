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
		name="Miss�o Raditz"
	Saibaman
		name="Miss�o Saibaman"
	Nappa
		name="Miss�o Nappa"
	Vegeta
		name="Miss�o Vegeta"
	Patriarca
		name="Falar com o Nail"
	Guldo
		name="Miss�o Guldo"
		X1=50
	Recoome
		name="Miss�o Recoome"
		X1=50
	Jeice
		name="Miss�o Jeice"
		X1=50
	Burter
		name="Miss�o Burter"
		X1=50
	CG
		name="Miss�o Capit�o Ginyu"
		X1=50
	F1
		name="Miss�o Freeza 1� Forma"
		X1=50
	F2
		name="Miss�o Freeza 2� Forma"
		X1=50
	F3
		name="Miss�o Freeza 3� Forma"
		X1=50
	F4
		name="Miss�o Freeza 4� Forma"
		X1=50
	MF
		name="Miss�o Mecha Freeza"
	Androide19
		name="Miss�o Andr�ide N� 19"
	Androide20
		name="Miss�o Andr�ide N� 20"
	Androide17
		name="Miss�o Andr�ide N� 17"
	Androide18
		name="Miss�o Andr�ide N� 18"
	C1
		name="Miss�o Cell Imperfeito"
	C2
		name="Miss�o Cell Semi-Perfeito"
	C3
		name="Miss�o Cell Perfeito"
	Spopovitch
		name="Miss�o Spopovitch"
	Dabura
		name="Miss�o Dabura"
	Babidi
		name="Miss�o Babidi"
	MV
		name="Miss�o Majin Vegeta"
	MB
		name="Miss�o Majin Boo"
	EB
		name="Miss�o Evil Boo"
	SB
		name="Miss�o Super Boo"
	Bootenks
		name="Miss�o Bootenks"
	Boohan
		name="Miss�o Boohan"
	KidBoo
		name="Miss�o Kid Boo"
	BV
		name="Miss�o Baby Vegeta"
	BV2
		name="Miss�o Baby Vegeta Perfeito"
	S17
		name="Miss�o Super 17"
	OS
		name="Miss�o Omega Shenron"