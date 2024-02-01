mob/verb/Change_Character()
	set hidden=1
	set category="Options"
	if(src.icon_state=="transform")	return
	if(src.Breaker==1)	return
	if(src.IsUltra==1)	return
	if(src.Kaioken==1)	return
	if(src.MajinForm==1)	return
	if(src.Quest11==2 || src.Quest10==1)	return
	if(usr.y>=150 && usr.x<222 && usr.z==8)
		return
	if(src.Logg==1)
		if(src.Zerado==0)
			return
	if(src.Mds==1)
		src<<sound('No.ogg')
		alert(src,"Você não pode trocar de personagem enquanto o Aprimoramento está ativado!")
		return
	if(usr.GravityTraining==1)
		usr.GravityTraining=0
		for(var/obj/gravidade/g in usr.client.screen)
			usr.client.screen-=g
			usr.overlays-=global.Gravidade
		if(usr.Training=="Punching Bags" || usr.Training=="Shadow Sparring")	usr.ForceCancelTraining()
		usr<<"<b>A gravidade foi desligada!"
	usr.client.eye=locate(26,392,8)
	usr<<sound(null)
	usr<<sound('Select.ogg')

datum/TransDatum
	var/name
	var/icon
	var/ReqPL
	var/ReqKi
	var/ReqStr
	var/ReqDef
	var/CustAura
	var/CharSpecials/BeamSpecial

proc/cTrans(var/Icon,var/NewPL,var/NewKi,var/NewStr,var/NewDef,var/NewSpecial,var/NewCA)
	var/datum/TransDatum/T=new()
	T.name="[Icon]"
	T.icon=Icon;T.ReqPL=NewPL
	T.BeamSpecial=NewSpecial
	T.CustAura=NewCA
	T.ReqKi=NewKi
	T.ReqStr=NewStr
	T.ReqDef=NewDef
	return T

mob/proc/ApplyTransDatum(/**/)
	if(src.CurTrans)
		src.TransDatum=src.Character.Transes[src.CurTrans]
		src.icon=src.TransDatum.icon
	else
		src.TransDatum=null
		src.icon=src.Character.icon
	src.UpdatePartyIcon()
var/list/AllCharacters=typesof(/obj/Characters)-/obj/Characters
proc/PopulateAllChars()
	for(var/v in AllCharacters)
		AllCharacters+=new v
		AllCharacters-=v

var/list/AllFusionCharacters=typesof(/obj/FusionCharacters)-/obj/FusionCharacters
proc/PopulateAllFusionChars()
	for(var/v in AllFusionCharacters)
		AllFusionCharacters+=new v
		AllFusionCharacters-=v

var/list/AllEvolCharacters=typesof(/obj/EvolCharacters)-/obj/EvolCharacters
obj/EvolCharacters
	var
		Aura="White"
		Race="Baby Panda"
		list/Transes=list()
		CharSpecials/BeamSpecial
	Goku2
		Race="Saiyan"
		icon='Goku2.dmi'
		BeamSpecial=new/CharSpecials/KameHameHa
		New()	Transes=list(cTrans('GokuSS1.dmi',200000,200000,50000,16000,new/CharSpecials/Super_KameHameHa),cTrans('GokuSS2.dmi',400000,300000,100000,32000,new/CharSpecials/Super_KameHameHa),cTrans('GokuSS3.dmi',600000,400000,200000,64000,new/CharSpecials/Super_KameHameHa))
	Trunks_Super
		Race="Half Saiyan"
		icon='TrunksDBS.dmi'
		BeamSpecial=new/CharSpecials/Buster_Cannon
		New()	Transes=list(cTrans('TrunksDBSSS1.dmi',200000,200000,50000,16000,new/CharSpecials/Burning_Attack),cTrans('TrunksDBSSS2.dmi',400000,300000,100000,32000,new/CharSpecials/Super_Masenko))
	Goku_Super
		Race="Saiyan"
		icon='GokuSuper.dmi'
		BeamSpecial=new/CharSpecials/KameHameHa
		New()	Transes=list(cTrans('GokuSuperSS1.dmi',200000,200000,50000,16000,new/CharSpecials/Super_KameHameHa),cTrans('GokuSuperSS2.dmi',400000,300000,100000,32000,new/CharSpecials/Super_KameHameHa),cTrans('GokuSuperSS3.dmi',600000,400000,200000,64000,new/CharSpecials/Super_KameHameHa),cTrans('GokuSSGod.dmi',1500000,1500000,800000,250000,new/CharSpecials/Super_KameHameHa,NewCA="Red"),cTrans('GokuSSGodSS1.dmi',3000000,3000000,1500000,500000,new/CharSpecials/Hyper_Kame,NewCA="Blue"))
	Yardrat_Goku
		Race="Saiyan"
		icon='YardratGoku.dmi'
		BeamSpecial=new/CharSpecials/KameHameHa
		New()	Transes=list(cTrans('YardratGokuSS1.dmi',200000,200000,50000,16000,new/CharSpecials/Super_KameHameHa))
	Future_Gohan
		Race="Half Saiyan"
		icon='FutureGohanAftermatch.dmi'
		BeamSpecial=new/CharSpecials/Gohan_KameHameHa
		New()	Transes=list(cTrans('FutureGohanAftermatchSS1.dmi',200000,200000,50000,16000,new/CharSpecials/Super_Masenko))
	Saiyan_Armor_Goku
		Race="Saiyan"
		icon='SAGoku.dmi'
		BeamSpecial=new/CharSpecials/KameHameHa
		New()	Transes=list(cTrans('SAGokuSS1.dmi',200000,200000,50000,16000,new/CharSpecials/Super_KameHameHa),cTrans('SAGokuUSS1.dmi',275000,275000,40000,16000,new/CharSpecials/Super_KameHameHa))
	GT_Goku
		Race="Saiyan"
		icon='GTGoku.dmi'
		BeamSpecial=new/CharSpecials/Kid_Gohan_KameHameHa
		New()	Transes=list(cTrans('GTGokuSS1.dmi',200000,200000,50000,16000,new/CharSpecials/Super_Gohan_KameHameHa),cTrans('GTGokuSS3.dmi',600000,400000,200000,64000,new/CharSpecials/Super_Gohan_KameHameHa),cTrans('AltGokuSS4.dmi',800000,500000,400000,120000,new/CharSpecials/Big_KameHameHa,NewCA="Yellow"))
	Adult_Piccolo_Gohan
		Race="Half Saiyan"
		icon='AdultPiccoloGohan.dmi'
		BeamSpecial=new/CharSpecials/Gohan_KameHameHa
		New()	Transes=list(cTrans('AdultPiccoloGohanSS1.dmi',200000,200000,50000,16000,new/CharSpecials/Super_Adult_Gohan_KameHameHa),cTrans('AdultPiccoloGohanSS2.dmi',400000,300000,100000,32000,new/CharSpecials/Super_Adult_Gohan_KameHameHa),cTrans('MysticGohanMystic.dmi',600000,400000,200000,64000,new/CharSpecials/Super_Adult_Gohan_KameHameHa,NewCA="White"))
	Gohan_Mistico
		Race="Half Saiyan"
		icon='MysticGohanMystic.dmi'
		BeamSpecial=new/CharSpecials/Super_Adult_Gohan_KameHameHa
	Saiyan_Armor_Vegeta
		Race="Saiyan"
		icon='SAVegeta.dmi'
		BeamSpecial=new/CharSpecials/Big_Bang_Attack
		New()	Transes=list(cTrans('SAVegetaSS1.dmi',200000,200000,50000,16000),cTrans('SAVegetaUSS1.dmi',275000,275000,70000,20000,new/CharSpecials/Final_Flash))
	Vegeta2
		Race="Saiyan"
		icon='Vegeta.dmi'
		BeamSpecial=new/CharSpecials/Galick_Gun
		New()	Transes=list(cTrans('VegetaSS1.dmi',200000,200000,50000,16000,new/CharSpecials/Final_Flash),cTrans('AltVegetaSS2.dmi',400000,300000,100000,32000,new/CharSpecials/Big_Bang_Attack))
	Vegeta_Super
		Race="Saiyan"
		icon='SAVegeta1.dmi'
		BeamSpecial=new/CharSpecials/Galick_Gun
		New()	Transes=list(cTrans('SAVegetaSS11.dmi',200000,200000,50000,16000,new/CharSpecials/Big_Bang_Attack),cTrans('SAVegetaSS2.dmi',400000,300000,100000,32000,new/CharSpecials/Big_Bang_Attack),cTrans('VegetaSuperGod.dmi',1500000,1500000,800000,250000,new/CharSpecials/Big_Bang_Attack,NewCA="Red"),cTrans('VegetaSSGodSS1.dmi',3000000,3000000,1500000,500000,new/CharSpecials/Super_Big_Bang,NewCA="Blue"),cTrans('VegetaUSSBlue.dmi',3275000,3275000,2000000,700000,new/CharSpecials/Super_Big_Bang,NewCA="Ciano"))

	Majin_Vegeta
		Race="Saiyan"
		Aura="Yellow"
		icon='AltVegetaMajinSS2.dmi'
		BeamSpecial=new/CharSpecials/Big_Bang_Attack
//		New()	Transes=list(cTrans('VegetaMajinSS1.dmi',200000,200000,10000,4000,new/CharSpecials/Final_Flash),cTrans('AltVegetaMajinSS2.dmi',400000,300000,30000,16000,new/CharSpecials/Final_Flash))
	Scouter_Vegeta
		Race="aiyan"
		icon='ScouterVegeta.dmi'
		BeamSpecial=new/CharSpecials/Galick_Gun
	GT_Vegeta
		Race="Saiyan"
		icon='GTVegeta.dmi'
		BeamSpecial=new/CharSpecials/Big_Bang_Attack
		New()	Transes=list(cTrans('GTVegetaSS1.dmi',200000,200000,50000,16000),cTrans('VegetaSS4.dmi',800000,500000,400000,120000,new/CharSpecials/Final_Shine,NewCA="Yellow"))
	Alternate_GT_Vegeta
		Race="Saiyan"
		icon='AltGTVegeta.dmi'
		BeamSpecial=new/CharSpecials/Big_Bang_Attack
		New()	Transes=list(cTrans('AltGTVegetaSS1.dmi',200000,200000,50000,16000),cTrans('VegetaSS4.dmi',800000,500000,400000,120000,new/CharSpecials/Final_Shine,NewCA="Yellow"))
	Future_Trunks_Adulto
		Race="Half Saiyan"
		icon='Trunks.dmi'
		BeamSpecial=new/CharSpecials/Buster_Cannon
		New()	Transes=list(cTrans('TrunksSS1.dmi',200000,200000,50000,16000,new/CharSpecials/Burning_Attack,NewCA="Yellow"))
	Saiyan_Armor_Trunks
		Race="Half Saiyan"
		icon='SATrunks.dmi'
		BeamSpecial=new/CharSpecials/Buster_Cannon
		New()	Transes=list(cTrans('SATrunksSS1.dmi',200000,200000,50000,16000,new/CharSpecials/Buster_Cannon),cTrans('SATrunksUSS1.dmi',275000,275000,70000,20000,new/CharSpecials/Finish_Buster))
	Bojack_Trunks
		Race="Half Saiyan"
		icon='BojackTrunks.dmi'
		BeamSpecial=new/CharSpecials/Buster_Cannon
		New()	Transes=list(cTrans('BojackTrunksSS1.dmi',200000,200000,20000,8000,new/CharSpecials/Finish_Buster))
	GT_Trunks
		Race="Half Saiyan"
		icon='GTTrunks.dmi'
		BeamSpecial=new/CharSpecials/Buster_Cannon
		New()	Transes=list(cTrans('GTTrunksSS1.dmi',200000,200000,50000,16000))
	Black_Suit_Roshi
		Race="Human"
		icon='BlackSuitRoshi.dmi'
		BeamSpecial=new/CharSpecials/Kid_Gohan_KameHameHa
	GT_Krillin
		Race="Human"
		icon='GTKrillin.dmi'
		BeamSpecial=new/CharSpecials/Kid_Gohan_KameHameHa
	Teen_Gohan
		Race="Half Saiyan"
		icon='TeenGohan.dmi'
		BeamSpecial=new/CharSpecials/Kid_Gohan_Masenko
		New()	Transes=list(cTrans('TeenGohanSS1.dmi',200000,200000,50000,16000),cTrans('TeenGohanSS2.dmi',400000,300000,100000,32000,new/CharSpecials/Super_Gohan_KameHameHa))
	Goku
		Race="Saiyan"
		icon='Goku Mid.dmi'
		BeamSpecial=new/CharSpecials/KameHameHa
		New()	Transes=list(cTrans('GokuMidSS1.dmi',200000,200000,50000,16000,new/CharSpecials/Super_KameHameHa))
/*	Goku_Jr
		Aura="Yellow"
		Race="Saiyan"
		icon='GokuJr.dmi'
		BeamSpecial=new/CharSpecials/Kid_Gohan_KameHameHa*/
	Gohan
		Race="Half Saiyan"
		icon='PiccoloTrainedGohan.dmi'
		BeamSpecial=new/CharSpecials/Kid_Gohan_Masenko
	Goten
		Race="Half Saiyan"
		icon='Goten.dmi'
		BeamSpecial=new/CharSpecials/Goten_KameHameHa
		New()	Transes=list(cTrans('GotenSS1.dmi',200000,200000,50000,16000,new/CharSpecials/Super_Gohan_KameHameHa))
	GT_Goten
		Race="Half Saiyan"
		icon='GTGoten.dmi'
		BeamSpecial=new/CharSpecials/Kid_Gohan_KameHameHa
	Vegeta
		Race="Saiyan"
		icon='ScouterVegeta.dmi'
		BeamSpecial=new/CharSpecials/Galick_Gun
	Baby
		Aura="Purple"
		Race="Alien"
		icon='Baby.dmi'
		BeamSpecial=new/CharSpecials/Energy_Blast
		New()	Transes=list(cTrans('BabyVegeta.dmi',275000,275000,70000,20000),cTrans('Baby2.dmi',800000,500000,400000,120000,NewCA="Yellow"))
	Kid_Trunks
		Race="Half Saiyan"
		icon='KidTrunks.dmi'
		BeamSpecial=new/CharSpecials/Energy_Blast
		New()	Transes=list(cTrans('KidTrunksSS1.dmi',200000,200000,50000,16000))
	Future_Trunks
		Race="Half Saiyan"
		icon='FutureTrunks.dmi'
		BeamSpecial=new/CharSpecials/Buster_Cannon
		New()	Transes=list(cTrans('FutureTrunksSS1.dmi',200000,200000,50000,16000))
	Master_Roshi
		Race="Human"
		icon='MasterRoshi.dmi'
		BeamSpecial=new/CharSpecials/Kid_Gohan_KameHameHa
	Yajirobe
		Race="Human"
		icon='Yajirobe.dmi'
		BeamSpecial=new/CharSpecials/Energy_Blast
	Krillin
		Race="Human"
		icon='Krillin.dmi'
		BeamSpecial=new/CharSpecials/Kid_Gohan_KameHameHa
	Yamcha
		Race="Human"
		icon='Yamcha.dmi'
		BeamSpecial=new/CharSpecials/Kid_Gohan_KameHameHa
	Tien
		Race="Human"
		icon='Tien.dmi'
		BeamSpecial=new/CharSpecials/TriBeam
	Chiaotzu
		Race="Alien"
		icon='Chiaotzu.dmi'
		BeamSpecial=new/CharSpecials/Death_Beam
	Piccolo
		Race="Namekian"
		icon='Piccolo.dmi'
		BeamSpecial=new/CharSpecials/Special_Beam_Cannon
		New()	Transes=list(cTrans('PiccoloForm3.dmi',200000,200000,50000,16000))
	Nail
		Race="Namekian"
		icon='Nail.dmi'
		BeamSpecial=new/CharSpecials/Death_Beam
	Lord_Slug
		Race="Namekian"
		icon='LordSlug.dmi'
		BeamSpecial=new/CharSpecials/Death_Beam
	Pikkon
		Race="Alien"
		icon='Pikkon.dmi'
		BeamSpecial=new/CharSpecials/Energy_Blast
	Olibu
		Race="Human"
		icon='Olibu.dmi'
		BeamSpecial=new/CharSpecials/Energy_Blast
/*	ChiChi
		Race="Human"
		icon='ChiChi.dmi'
		BeamSpecial=new/CharSpecials/Goten_KameHameHa*/
	Pan
		Race="Half Saiyan"
		icon='Pan.dmi'
		BeamSpecial=new/CharSpecials/Goten_KameHameHa
/*	Saiyan_Armor_Bulma
		Race="Human"
		icon='SABulma.dmi'
		BeamSpecial=new/CharSpecials/Goten_KameHameHa*/
	Videl
		Race="Human"
		icon='Videl.dmi'
		BeamSpecial=new/CharSpecials/Energy_Blast
		New()	Transes=list(cTrans('GreatSaiyagirl.dmi',100000,100000,4000,2000))
	Hercule
		Race="Human"
		icon='Hercule.dmi'
		BeamSpecial=new/CharSpecials/Falcon_Punch
	Uub
		Race="Human"
		icon='Uub.dmi'
		BeamSpecial=new/CharSpecials/Kid_Gohan_KameHameHa
/*	Turtle
		Race="Animal"
		icon='Turtle.dmi'
		BeamSpecial=new/CharSpecials/Falcon_Punch*/
	Raditz
		Race="Saiyan"
		icon='Raditz.dmi'
		BeamSpecial=new/CharSpecials/Watch_the_Birdie
	Saibaman
		Race="Creature"
		icon='Saibaman.dmi'
		BeamSpecial=new/CharSpecials/Death_Beam
	Nappa
		Race="Saiyan"
		icon='Nappa.dmi'
		BeamSpecial=new/CharSpecials/Energy_Blast
	Guldo
		Aura="Purple"
		Race="Alien"
		icon='Guldo.dmi'
		BeamSpecial=new/CharSpecials/Energy_Blast
	Burter
		Aura="Purple"
		Race="Alien"
		icon='Burter.dmi'
		BeamSpecial=new/CharSpecials/Death_Beam
	Jeice
		Aura="Purple"
		Race="Alien"
		icon='Jeice.dmi'
		BeamSpecial=new/CharSpecials/Death_Beam
	Recoome
		Aura="Purple"
		Race="Alien"
		icon='Recoome.dmi'
		BeamSpecial=new/CharSpecials/Energy_Blast
	Captain_Ginyu
		Aura="Purple"
		Race="Alien"
		icon='CaptainGinyu.dmi'
		BeamSpecial=new/CharSpecials/Energy_Blast
	Henchman
		Aura="Purple"
		Race="Alien"
		icon='FriezaHenchman.dmi'
		BeamSpecial=new/CharSpecials/Death_Beam
	Zarbon
		Aura="Purple"
		Race="Alien"
		icon='Zarbon.dmi'
		BeamSpecial=new/CharSpecials/Death_Beam
	Dodoria
		Aura="Purple"
		Race="Alien"
		icon='Dodoria.dmi'
		BeamSpecial=new/CharSpecials/Death_Beam
	Frieza
		name="Freeza"
		Aura="Purple"
		Race="Alien"
		icon='Frieza.dmi'
		BeamSpecial=new/CharSpecials/Death_Beam
		New()	Transes=list(cTrans('Friezaform2.dmi',100000,100000,4000,2000),cTrans('FriezaForm3.dmi',150000,150000,10000,4000),cTrans('FriezaForm4.dmi',200000,200000,50000,16000),cTrans('GoldenFreeza.dmi',3000000,3000000,1500000,700000,NewCA="Yellow"))
	Cooler
		Aura="Purple"
		Race="Alien"
		icon='Cooler.dmi'
		BeamSpecial=new/CharSpecials/Death_Beam
	Cell
		Aura="Green"
		Race="BioAndroid"
		icon='Cell.dmi'
		BeamSpecial=new/CharSpecials/Cell_Kamehameha
		New()	Transes=list(cTrans('CellForm2.dmi',275000,275000,70000,20000,new/CharSpecials/Cell_Special_Beam_Cannon),cTrans('CellPerfectForm.dmi',400000,300000,60000,32000,new/CharSpecials/Cell_Special_Beam_Cannon))
	Cell_Jr
		Race="BioAndroid"
		icon='CellJr.dmi'
		BeamSpecial=new/CharSpecials/Cell_Kamehameha
	Android_19
		Aura="White"
		Race="Android"
		icon='Android19.dmi'
		BeamSpecial=new/CharSpecials/Energy_Blast
	Android_18
		Aura="White"
		Race="Android"
		icon='Android18.dmi'
		BeamSpecial=new/CharSpecials/Energy_Blast
		New()	Transes=list(cTrans('Android18.dmi',200000,200000,50000,16000))
	Android_17
		Aura="White"
		Race="Android"
		icon='Android17.dmi'
		BeamSpecial=new/CharSpecials/Death_Beam
		New()	Transes=list(cTrans('Super17.dmi',800000,500000,400000,120000,NewCA="N"))
	Dabura
		Race="Demon King"
		icon='Dabura.dmi'
		BeamSpecial=new/CharSpecials/Death_Beam
		New()	Transes=list(cTrans('Dabura.dmi',400000,300000,60000,32000))
	Babidi
		Race="Alien"
		icon='Babidi.dmi'
		BeamSpecial=new/CharSpecials/Death_Beam

	Buu
		Aura="Purple"
		Race="Alien"
		icon='KidBuu.dmi'
		BeamSpecial=new/CharSpecials/Death_Beam
	Omega_Shenron
		Aura="White"
		Race="Dragon"
		icon='OmegaShenron.dmi'
		BeamSpecial=new/CharSpecials/Blaster_Shell

	King_Piccolo
		Race="Namekian"
		icon='KingPiccolo.dmi'
		BeamSpecial=new/CharSpecials/Special_Beam_Cannon
	General_Tao
		Race="Human"
		icon='GeneralTao.dmi'
		BeamSpecial=new/CharSpecials/Falcon_Punch

	Salza
		Aura="Purple"
		Race="Alien"
		icon='Salza.dmi'
		BeamSpecial=new/CharSpecials/Death_Beam

	Bardock
		Race="Saiyan"
		icon='Bardock.dmi'
		BeamSpecial=new/CharSpecials/Energy_Blast
		New()	Transes=list(cTrans('BardockSS1.dmi',200000,200000,50000,16000,NewCA="Yellow"))
	King_Vegeta
		Race="Saiyan"
		icon='KingVegeta.dmi'
		BeamSpecial=new/CharSpecials/Galick_Gun
	Broly
		Aura="Green"
		Race="Saiyajin"
		icon='Broly.dmi'
		BeamSpecial=new/CharSpecials/Blaster_Shell
		New()	Transes=list(cTrans('NightmareBrolySS1.dmi',200000,200000,50000,16000,NewCA="Green"),cTrans('BrolySS2.dmi',400000,300000,60000,32000,NewCA="Green"))
	Janemba
		Aura="Purple"
		Race="Alien"
		icon='Janemba.dmi'
		BeamSpecial=new/CharSpecials/Energy_Blast

//---------------------------------------------------------------------------------------------------
//RAÇAS PRA ESCOLHER NA NOVA ATUALIZAÇÃO
obj/Characters
	var
		Aura="White"
		Race="Baby Panda"
		list/Transes=list()
		CharSpecials/BeamSpecial
//SAIYAJINS
//SEM CAUDA
	Saiyajin
		Race="Saiyajin"
		icon='BaseSaiyaijn.dmi'
	//	BeamSpecial=new/CharSpecials/KameHameHa
		New()	Transes=list(cTrans('BaseSaiyaijnSS.dmi',1,1,1,1,NewCA="Yellow"),cTrans('BaseSaiyaijnSS.dmi',2,2,2,2,NewCA="Yellow"),cTrans('BaseSaiyaijnSS3.dmi',3,3,3,3,NewCA="Yellow"),cTrans('BaseSaiyaijnSSBlue.dmi',3,3,3,3,NewCA="Yellow"))
	Saiyajin2
		Race="Saiyajin"
		icon='BaseSaiyaijn2.dmi'
	//	BeamSpecial=new/CharSpecials/KameHameHa
		New()	Transes=list(cTrans('BaseSaiyaijn2SS.dmi',1,1,1,1,NewCA="Yellow"),cTrans('BaseSaiyaijn2SS.dmi',2,2,2,2,NewCA="Yellow"),cTrans('BaseSaiyaijn2SS3.dmi',3,3,3,3,NewCA="Yellow"),cTrans('BaseSaiyaijn2SSBlue.dmi',3,3,3,3,NewCA="Yellow"))
	Saiyajin3
		Race="Saiyajin"
		icon='BaseSaiyaijn3.dmi'
	//	BeamSpecial=new/CharSpecials/KameHameHa
		New()	Transes=list(cTrans('BaseSaiyaijn3SS.dmi',1,1,1,1,NewCA="Yellow"),cTrans('BaseSaiyaijn3SS.dmi',2,2,2,2,NewCA="Yellow"),cTrans('BaseSaiyaijn3SS3.dmi',3,3,3,3,NewCA="Yellow"),cTrans('BaseSaiyaijn3SSBlue.dmi',3,3,3,3,NewCA="Yellow"))
//CAUDA
	SaiyajinCauda
		Race="Saiyajin"
		icon='BaseSaiyaijn.dmi'
	//	BeamSpecial=new/CharSpecials/KameHameHa
		New()	Transes=list(cTrans('BaseSaiyaijnSS.dmi',1,1,1,1,NewCA="Yellow"),cTrans('BaseSaiyaijnSS.dmi',2,2,2,2,NewCA="Yellow"),cTrans('BaseSaiyaijnSS3.dmi',3,3,3,3,NewCA="Yellow"),cTrans('BaseSaiyaijnSSBlue.dmi',3,3,3,3,NewCA="Yellow"))
	Saiyajin2Cauda
		Race="Saiyajin"
		icon='BaseSaiyaijn2.dmi'
	//	BeamSpecial=new/CharSpecials/KameHameHa
		New()	Transes=list(cTrans('BaseSaiyaijn2SS.dmi',1,1,1,1,NewCA="Yellow"),cTrans('BaseSaiyaijn2SS.dmi',2,2,2,2,NewCA="Yellow"),cTrans('BaseSaiyaijn2SS3.dmi',3,3,3,3,NewCA="Yellow"),cTrans('BaseSaiyaijn2SSBlue.dmi',3,3,3,3,NewCA="Yellow"))
	Saiyajin3Cauda
		Race="Saiyajin"
		icon='BaseSaiyaijn3.dmi'
	//	BeamSpecial=new/CharSpecials/KameHameHa
		New()	Transes=list(cTrans('BaseSaiyaijn3SS.dmi',1,1,1,1,NewCA="Yellow"),cTrans('BaseSaiyaijn3SS.dmi',2,2,2,2,NewCA="Yellow"),cTrans('BaseSaiyaijn3SS3.dmi',3,3,3,3,NewCA="Yellow"),cTrans('BaseSaiyaijn3SSBlue.dmi',3,3,3,3,NewCA="Yellow"))
//NAMEKUSEIJINS
	Namek1
		Race="Namekuseijin"
		icon='BaseNamek1.dmi'
	Namek2
		Race="Namekuseijin"
		icon='BaseNamek2.dmi'
	Namek3
		Race="Namekuseijin"
		icon='BaseNamek3.dmi'
	Namek4
		Race="Namekuseijin"
		icon='BaseNamek4.dmi'
	Namek5
		Race="Namekuseijin"
		icon='BaseNamek5.dmi'
	Namek6
		Race="Namekuseijin"
		icon='BaseNamek6.dmi'
//HUMANOS
	Humano1
		Race="Humano"
		icon='BaseHumano1.dmi'
	Humano2
		Race="Humano"
		icon='BaseHumano2.dmi'
	Humano3
		Race="Humano"
		icon='BaseHumano3.dmi'
	Humano4
		Race="Humano"
		icon='BaseHumano4.dmi'
	Goku
		Race="Saiyan"
		icon='Goku Mid.dmi'
		BeamSpecial=new/CharSpecials/KameHameHa
		New()	Transes=list(cTrans('GokuMidSS1.dmi',200000,200000,50000,16000,new/CharSpecials/Super_KameHameHa))
/*	Goku_Jr
		Aura="Yellow"
		Race="Saiyan"
		icon='GokuJr.dmi'
		BeamSpecial=new/CharSpecials/Kid_Gohan_KameHameHa*/
	Gohan
		Race="Half Saiyan"
		icon='PiccoloTrainedGohan.dmi'
		BeamSpecial=new/CharSpecials/Kid_Gohan_Masenko
	Goten
		Race="Half Saiyan"
		icon='Goten.dmi'
		BeamSpecial=new/CharSpecials/Goten_KameHameHa
		New()	Transes=list(cTrans('GotenSS1.dmi',200000,200000,50000,16000,new/CharSpecials/Super_Gohan_KameHameHa))
/*	Teen_Goten
		Race="Half Saiyan"
		icon='TeenGoten.dmi'
		BeamSpecial=new/CharSpecials/Kid_Gohan_KameHameHa*/
	Vegeta
		Race="Saiyan"
		icon='ScouterVegeta.dmi'
		BeamSpecial=new/CharSpecials/Galick_Gun
	Baby
		Aura="Purple"
		Race="Alien"
		icon='Baby.dmi'
		BeamSpecial=new/CharSpecials/Energy_Blast
		New()	Transes=list(cTrans('BabyVegeta.dmi',275000,275000,70000,20000),cTrans('Baby2.dmi',800000,500000,400000,120000,NewCA="Yellow"))
	Kid_Trunks
		Race="Half Saiyan"
		icon='KidTrunks.dmi'
		BeamSpecial=new/CharSpecials/Energy_Blast
		New()	Transes=list(cTrans('KidTrunksSS1.dmi',200000,200000,50000,16000))
	Future_Trunks
		Race="Half Saiyan"
		icon='FutureTrunks.dmi'
		BeamSpecial=new/CharSpecials/Buster_Cannon
		New()	Transes=list(cTrans('FutureTrunksSS1.dmi',200000,200000,50000,16000))
	Master_Roshi
		Race="Human"
		icon='MasterRoshi.dmi'
		BeamSpecial=new/CharSpecials/Kid_Gohan_KameHameHa
	Yajirobe
		Race="Human"
		icon='Yajirobe.dmi'
		BeamSpecial=new/CharSpecials/Energy_Blast
	Krillin
		Race="Human"
		icon='Krillin.dmi'
		BeamSpecial=new/CharSpecials/Kid_Gohan_KameHameHa
	Yamcha
		Race="Human"
		icon='Yamcha.dmi'
		BeamSpecial=new/CharSpecials/Kid_Gohan_KameHameHa
	Tien
		Race="Human"
		icon='Tien.dmi'
		BeamSpecial=new/CharSpecials/TriBeam
	Chiaotzu
		Race="Alien"
		icon='Chiaotzu.dmi'
		BeamSpecial=new/CharSpecials/Death_Beam
	Piccolo
		Race="Namekian"
		icon='Piccolo.dmi'
		BeamSpecial=new/CharSpecials/Special_Beam_Cannon
		New()	Transes=list(cTrans('PiccoloForm3.dmi',200000,200000,50000,16000))
	Nail
		Race="Namekian"
		icon='Nail.dmi'
		BeamSpecial=new/CharSpecials/Death_Beam
	Lord_Slug
		Race="Namekian"
		icon='LordSlug.dmi'
		BeamSpecial=new/CharSpecials/Death_Beam
	Pikkon
		Race="Alien"
		icon='Pikkon.dmi'
		BeamSpecial=new/CharSpecials/Energy_Blast
	Olibu
		Race="Human"
		icon='Olibu.dmi'
		BeamSpecial=new/CharSpecials/Energy_Blast
/*	ChiChi
		Race="Human"
		icon='ChiChi.dmi'
		BeamSpecial=new/CharSpecials/Goten_KameHameHa*/
	Pan
		Race="Half Saiyan"
		icon='Pan.dmi'
		BeamSpecial=new/CharSpecials/Goten_KameHameHa
/*	Saiyan_Armor_Bulma
		Race="Human"
		icon='SABulma.dmi'
		BeamSpecial=new/CharSpecials/Goten_KameHameHa*/
	Videl
		Race="Human"
		icon='Videl.dmi'
		BeamSpecial=new/CharSpecials/Energy_Blast
		New()	Transes=list(cTrans('GreatSaiyagirl.dmi',200000,200000,50000,16000))
	Hercule
		Race="Human"
		icon='Hercule.dmi'
		BeamSpecial=new/CharSpecials/Falcon_Punch
	Uub
		Race="Human"
		icon='Uub.dmi'
		BeamSpecial=new/CharSpecials/Kid_Gohan_KameHameHa
/*	Turtle
		Race="Animal"
		icon='Turtle.dmi'
		BeamSpecial=new/CharSpecials/Falcon_Punch*/
	Raditz
		Race="Saiyan"
		icon='Raditz.dmi'
		BeamSpecial=new/CharSpecials/Watch_the_Birdie
	Saibaman
		Race="Creature"
		icon='Saibaman.dmi'
		BeamSpecial=new/CharSpecials/Death_Beam
	Nappa
		Race="Saiyan"
		icon='Nappa.dmi'
		BeamSpecial=new/CharSpecials/Energy_Blast
	Guldo
		Aura="Purple"
		Race="Alien"
		icon='Guldo.dmi'
		BeamSpecial=new/CharSpecials/Energy_Blast
	Burter
		Aura="Purple"
		Race="Alien"
		icon='Burter.dmi'
		BeamSpecial=new/CharSpecials/Death_Beam
	Jeice
		Aura="Purple"
		Race="Alien"
		icon='Jeice.dmi'
		BeamSpecial=new/CharSpecials/Death_Beam
	Recoome
		Aura="Purple"
		Race="Alien"
		icon='Recoome.dmi'
		BeamSpecial=new/CharSpecials/Energy_Blast
	Captain_Ginyu
		Aura="Purple"
		Race="Alien"
		icon='CaptainGinyu.dmi'
		BeamSpecial=new/CharSpecials/Energy_Blast
	Henchman
		Aura="Purple"
		Race="Alien"
		icon='FriezaHenchman.dmi'
		BeamSpecial=new/CharSpecials/Death_Beam
	Zarbon
		Aura="Purple"
		Race="Alien"
		icon='Zarbon.dmi'
		BeamSpecial=new/CharSpecials/Death_Beam
	Dodoria
		Aura="Purple"
		Race="Alien"
		icon='Dodoria.dmi'
		BeamSpecial=new/CharSpecials/Death_Beam
	Frieza
		name="Freeza"
		Aura="Purple"
		Race="Alien"
		icon='Frieza.dmi'
		BeamSpecial=new/CharSpecials/Death_Beam
		New()	Transes=list(cTrans('Friezaform2.dmi',100000,100000,4000,2000),cTrans('FriezaForm3.dmi',150000,150000,10000,4000),cTrans('FriezaForm4.dmi',200000,200000,50000,16000),cTrans('GoldenFreeza.dmi',3000000,3000000,1500000,700000,NewCA="Yellow"))
	Cooler
		Aura="Purple"
		Race="Alien"
		icon='Cooler.dmi'
		BeamSpecial=new/CharSpecials/Death_Beam
	Cell
		Aura="Green"
		Race="BioAndroid"
		icon='Cell.dmi'
		BeamSpecial=new/CharSpecials/Cell_Kamehameha
		New()	Transes=list(cTrans('CellForm2.dmi',275000,275000,70000,20000,new/CharSpecials/Cell_Special_Beam_Cannon),cTrans('CellPerfectForm.dmi',400000,300000,100000,32000,new/CharSpecials/Cell_Special_Beam_Cannon))
	Cell_Jr
		Race="BioAndroid"
		icon='CellJr.dmi'
		BeamSpecial=new/CharSpecials/Cell_Kamehameha
	Android_19
		Aura="White"
		Race="Android"
		icon='Android19.dmi'
		BeamSpecial=new/CharSpecials/Energy_Blast
	Android_18
		Aura="White"
		Race="Android"
		icon='Android18.dmi'
		BeamSpecial=new/CharSpecials/Energy_Blast
		New()	Transes=list(cTrans('Android18.dmi',200000,200000,50000,16000))
	Android_17
		Aura="White"
		Race="Android"
		icon='Android17.dmi'
		BeamSpecial=new/CharSpecials/Energy_Blast
		New()	Transes=list(cTrans('Super17.dmi',800000,500000,400000,120000,NewCA="N"))
	Android_16
		Aura="White"
		Race="Android"
		icon='Android16.dmi'
		BeamSpecial=new/CharSpecials/DD
		New()	Transes=list(cTrans('Android16.dmi',275000,275000,70000,20000))
	Dabura
		Race="Demon King"
		icon='Dabura.dmi'
		BeamSpecial=new/CharSpecials/Death_Beam
		New()	Transes=list(cTrans('Dabura.dmi',400000,300000,100000,32000))
	Babidi
		Race="Alien"
		icon='Babidi.dmi'
		BeamSpecial=new/CharSpecials/Death_Beam

	Buu
		Aura="Purple"
		Race="Alien"
		icon='KidBuu.dmi'
		BeamSpecial=new/CharSpecials/Death_Beam
		New()	Transes=list(cTrans('KidBuu.dmi',600000,400000,200000,64000))
	Omega_Shenron
		Aura="White"
		Race="Dragon"
		icon='OmegaShenron.dmi'
		BeamSpecial=new/CharSpecials/Blaster_Shell
		New()	Transes=list(cTrans('OmegaShenron.dmi',800000,500000,400000,120000))

	King_Piccolo
		Race="Namekian"
		icon='KingPiccolo.dmi'
		BeamSpecial=new/CharSpecials/Special_Beam_Cannon
	General_Tao
		Race="Human"
		icon='GeneralTao.dmi'
		BeamSpecial=new/CharSpecials/Falcon_Punch

	Salza
		Aura="Purple"
		Race="Alien"
		icon='Salza.dmi'
		BeamSpecial=new/CharSpecials/Death_Beam

	Bardock
		Race="Saiyan"
		icon='Bardock.dmi'
		BeamSpecial=new/CharSpecials/Energy_Blast
		New()	Transes=list(cTrans('BardockSS1.dmi',200000,200000,50000,16000,NewCA="Yellow"))
	King_Vegeta
		Race="Saiyan"
		icon='KingVegeta.dmi'
		BeamSpecial=new/CharSpecials/Galick_Gun
	Broly
		Aura="Green"
		Race="Saiyajin"
		icon='Broly.dmi'
		BeamSpecial=new/CharSpecials/Blaster_Shell
		New()	Transes=list(cTrans('NightmareBrolySS1.dmi',200000,200000,50000,16000,NewCA="Green"),cTrans('BrolySS2.dmi',400000,300000,100000,32000,NewCA="Green"))
	Janemba
		Aura="Purple"
		Race="Alien"
		icon='Janemba.dmi'
		BeamSpecial=new/CharSpecials/Energy_Blast
		New()	Transes=list(cTrans('Janemba.dmi',600000,400000,200000,64000))
obj/FusionCharacters
	var
		Aura="White"
		Race="Baby Panda"
		list/Transes=list()
		CharSpecials/BeamSpecial//src.icon=='Zamasu.dmi src.icon=='BlackGoku.dmi' src.icon=='TrunksDBS.dmi' src.icon=='Hito.dmi'
	Gotenks
		Race="Half Saiyan"
		icon='Gotenks.dmi'
		BeamSpecial=new/CharSpecials/Kamikaze
		New()	Transes=list(cTrans('GotenksSS01.dmi',200000,200000,50000,16000),cTrans('GotenksSS03.dmi',600000,400000,200000,64000,new/CharSpecials/Super_Gohan_KameHameHa))
	Vegito
		Race="Saiyan"
		icon='Vegito.dmi'
		BeamSpecial=new/CharSpecials/VBig_Bang
		New()	Transes=list(cTrans('VegitoSS0.dmi',200000,200000,50000,16000),cTrans('VegitoSSB.dmi',3000000,3000000,1500000,500000,new/CharSpecials/Final_Kame,NewCA="N"))
	Vegito_DBS
		Race="Saiyan"
		icon='Vegito2.dmi'
		BeamSpecial=new/CharSpecials/VBig_Bang
		New()	Transes=list(cTrans('VegitoSSB.dmi',3000000,3000000,1500000,500000,new/CharSpecials/Final_Kame,NewCA="Blue"))

	Gogeta
		Race="Saiyan"
		icon='Gogeta.dmi'
		BeamSpecial=new/CharSpecials/BBK
		New()	Transes=list(cTrans('GogetaSS0.dmi',200000,200000,50000,16000))
	GogetaSS4
		Aura="Yellow"
		Race="Saiyan"
		icon='GogetaSS4.dmi'
		BeamSpecial=new/CharSpecials/BBK
	ZamasuGattai
		Aura="White"
		Race="?"
		icon='Super Zamasu.dmi'
		BeamSpecial=new/CharSpecials/Energy_Blast
mob/proc/RestrictChars2()
	if(!usr.FusionMob)
		if(usr.dano=="Bills")
			if(usr.Talked13==0)
				var/Choice=alert("O personagem que você escolheu é Especial e só pode ser usado ao usar Zens. \nBills custa 200 Zens. \nVocê possui [usr.Zens]. \nDeseja desbloquear o Bills?","Personagem Especial","Sim","Não")
				if(Choice=="Sim")
					if(usr.Zens<200)
						usr<<sound('No.ogg')
						alert("Você não possui Zens o suficiente. Zens são ganhos ao vender Perks para certos NPCs.")
						return
					usr.Talked13=1
					usr.Zens-=200
					alert("Você desbloqueou o personagem Bills!")
					usr.Revert()
					usr.icon=usr.Character.icon
					usr.UpdatePartyIcon()
					usr.UpdateFaceHUD()
					usr.ResetSuffix()
					usr.RestrictChars()
				else
					return
		if(usr.dano=="Zamasu")
			if(usr.Talked14==0)
				var/Choice=alert("O personagem que você escolheu é Especial e só pode ser usado ao usar Zens. \nZamasu custa 25 Zens. \nVocê possui [usr.Zens]. \nDeseja desbloquear o Zamasu?","Personagem Especial","Sim","Não")
				if(Choice=="Sim")
					if(usr.Zens<25)
						usr<<sound('No.ogg')
						alert("Você não possui Zens o suficiente. Zens são ganhos ao vender Perks para certos NPCs.")
						return
					usr.Talked14=1
					usr.Zens-=25
					usr.Revert()
					usr.icon=usr.Character.icon
					usr.UpdatePartyIcon()
					usr.UpdateFaceHUD()
					usr.ResetSuffix()
					usr.RestrictChars()
					alert("Você desbloqueou o personagem Zamasu!")
				else	return
		if(usr.dano=="Goku Black")
			if(usr.Talked15==0)
				var/Choice=alert("O personagem que você escolheu é Especial e só pode ser usado ao usar Zens. \nGoku Black custa 150 Zens. \nVocê possui [usr.Zens]. \nDeseja desbloquear o Goku Black?","Personagem Especial","Sim","Não")
				if(Choice=="Sim")
					if(usr.Zens<150)
						usr<<sound('No.ogg')
						alert("Você não possui Zens o suficiente. Zens são ganhos ao vender Perks para certos NPCs.")
						return
					usr.Talked15=1
					usr.Zens-=150
					usr.Revert()
					usr.icon=usr.Character.icon
					usr.UpdatePartyIcon()
					usr.UpdateFaceHUD()
					usr.ResetSuffix()
					usr.RestrictChars()
					alert("Você desbloqueou o personagem Goku Black!")
				else	return
		if(usr.icon=='Hito.dmi')
			if(usr.Talked16==0)
				usr.Revert()
				usr.icon=usr.Character.icon
				usr.UpdatePartyIcon()
				usr.UpdateFaceHUD()
				usr.ResetSuffix()
				usr.RestrictChars()
				var/Choice=alert("O personagem que você escolheu é Especial e só pode ser usado ao usar Zens. \nHitto custa 75 Zens. \nVocê possui [usr.Zens]. \nDeseja desbloquear o Hitto?","Personagem Especial","Sim","Não")
				if(Choice=="Sim")
					if(usr.Zens<75)
						usr<<sound('No.ogg')
						alert("Você não possui Zens o suficiente. Zens são ganhos ao vender Perks para certos NPCs.")
						return
					usr.Talked16=1
					usr.Zens-=75
					alert("Você desbloqueou o personagem Hitto!")
					return
mob/proc/RestrictChars()
	if(!src.FusionMob)
		if(src.icon=='Vegito2.dmi' || src.icon=='Vegito.dmi' || src.icon=='Gogeta.dmi' || src.icon=='GogetaSS4.dmi' || src.icon=='Gotenks.dmi' || src.icon=='GogetaSSB.dmi')
			usr<<"<b>O personagem que você escolheu é restrito à fusões. Por favor, escolha outro."
			usr<<sound('No.ogg')
			src.Character=new/obj/Characters/Piccolo
			src.Revert()
			src.icon=src.Character.icon
			src.UpdatePartyIcon()
			src.UpdateFaceHUD()
			src.ResetSuffix()
			src.RestrictChars()

var/list/AllBlockedChar=typesof(/obj/BlockedChar)-/obj/BlockedChar
proc/PopulateAllBlockedChar()
	for(var/v in AllBlockedChar)
		AllBlockedChar+=new v
		AllBlockedChar-=v
obj/BlockedChar
	var
		Aura="White"
		Race="Baby Panda"
		list/Transes=list()
		CharSpecials/BeamSpecial
	Zamasu
		Aura="Purple"
		Race="God"
		icon='Zamasu.dmi'
		BeamSpecial=new/CharSpecials/Death_Beam
		New()	Transes=list(cTrans('Zamasu.dmi',400000,300000,100000,32000))
	Goku_Black
		Race="Saiyan"
		Aura="Black"
		icon='BlackGoku.dmi'
		BeamSpecial=new/CharSpecials/Dark
		New()	Transes=list(cTrans('BlackGokuRose.dmi',3000000,3000000,1500000,500000,new/CharSpecials/Rose,NewCA="Purple"))
	Hitto
		Aura="Purple"
		Race="Assassin"
		icon='Hito.dmi'
		BeamSpecial=new/CharSpecials/Energy_Blast
	Bills
		Race="God"
		Aura="Purple"
		icon='Bills.dmi'
		BeamSpecial=new/CharSpecials/Energy_Blast
		New()	Transes=list(cTrans('Bills.dmi',3275000,3275000,2000000,700000))
/*	if(src.Zerado==0)
		if(src.icon=='Hito.dmi')
			usr<<"O personagem que você escolheu é restrito.Para utilizar esse personagem, você deve completar o Modo História do jogo."
			src.Character=new/obj/Characters/Goku_Mid
			src.Revert()
			src.icon=src.Character.icon
			src.UpdatePartyIcon()
			src.UpdateFaceHUD()
			src.ResetSuffix()
			src.RestrictChars()
			return*/
//	else
//		if(usr.icon=='Hito.dmi')
//			usr.DamageMultiplier+=0.5



