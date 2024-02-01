client
	Del()
		if(src.mob)
			src.mob.ControlClients=list()
			if(src.mob.FusionMob)	src.mob.EndFusion()
			src.mob.SaveProc()
		return ..()

mob/verb/Save()
	set hidden=1
	usr.SaveProc()

mob/var/CanSave=0
mob/proc/SaveProc()
	if(!src.CanSave)	return
	src.UpdateLastOnline()
	if(fexists("Players/[ckey(src.key)].sav"))	fdel("Players/[ckey(src.key)].sav")
	var/savefile/F=new("Players/[ckey(src.key)].sav")
	F["SaveVersion"]<<GameVersion
	F["name"]<<src.name
	F["dir"]<<src.dir

	F["Level"]<<src.Level
	F["contents"]<<src.contents
	F["Aviso"]<<src.Aviso
	F["OldLoc"]<<src.OldLoc
	F["SaveChar"]<<src.Character.name

	F["First"]<<src.First
	F["Zens"]<<src.Zens
	F["Doing"]<<src.Doing
	F["HairStyle"]<<src.HairStyle
	F["Clicked2"]<<src.Clicked2
	F["Exp"]<<src.Exp
	F["PL"]<<src.PL
	F["MaxPL"]<<src.MaxPL
	F["Ki"]<<src.Ki
	F["MaxKi"]<<src.MaxKi
	F["Str"]<<src.Str
	F["Def"]<<src.Def
	F["Zenie"]<<src.Zenie
	F["Title"]<<src.Title
	F["BankedZenie"]<<src.BankedZenie
	F["TraitPoints"]<<src.TraitPoints
	F["PerkPoints"]<<src.PerkPoints
	F["Alignment"]<<src.Alignment
	F["Traits"]<<list2params(src.Traits)
	F["RecordedTracked"]<<src.RecordedTracked
	F["CashPoints"]<<src.CashPoints
	F["CashPointsReceived"]<<src.CashPointsReceived
	F["SlottedPerks"]<<src.SlottedPerks
	F["UnlockedPerks"]<<list2params(src.UnlockedPerks)
	F["PreferredPowerMode"]<<src.PreferredPowerMode
	F["LastWishDate"]<<src.LastWishDate
	F["WishesMade"]<<src.WishesMade
	F["IsDead"]<<src.IsDead
	F["Training"]<<src.Training
	F["TrainingExp"]<<src.TrainingExp
	F["CapsuleChars"]<<src.CapsuleChars
	F["Friends"]<<src.Friends
	F["Materials"]<<src.Materials
	F["LastOnline"]<<src.LastOnline
	F["ItemsInventory"]<<src.ItemsInventory
	F["ClothesInventory"]<<src.ClothesInventory

	F["x"]<<src.x
	F["y"]<<src.y
	F["z"]<<src.z
	F["Character"]<<src.Character.name
	F["CurTrans"]<<src.CurTrans
	F["KbType"]<<src.KbType
	F["FontFace"]<<src.FontFace
	F["FontColor"]<<src.FontColor
	F["NameColor"]<<src.NameColor
	F["DisplayNameColor"]<<src.DisplayNameColor
	F["see_invisible"]<<src.see_invisible
	F["VolumeMuteAll"]<<src.VolumeMuteAll
	F["VolumeEffect"]<<src.VolumeEffect
	F["VolumeMenu"]<<src.VolumeMenu
	F["VolumeVoice"]<<src.VolumeVoice
	F["VolumeMusic"]<<src.VolumeMusic
	F["InstanceLoc"]<<src.InstanceLoc
	F["PreInstanceLoc"]<<src.PreInstanceLoc
	F["TutsComplete"]<<src.TutsComplete
	F["PlayTimeTicks"]<<src.PlayTimeTicks
	F["PlayTimeSeconds"]<<src.PlayTimeSeconds
	F["PlayTimeMinutes"]<<src.PlayTimeMinutes
	F["PlayTimeHours"]<<src.PlayTimeHours
	F["IgnoreDuels"]<<src.IgnoreDuels
	F["IgnoreParties"]<<src.IgnoreParties
	F["IgnoreFusions"]<<src.IgnoreFusions
	F["Muted"]<<src.Muted
	F["MajinForm"]<<src.MajinForm
	F["Talked"]<<src.Talked
	F["Talked2"]<<src.Talked2
	F["Talked3"]<<src.Talked3
	F["Talked4"]<<src.Talked4
	F["Talked5"]<<src.Talked5
	F["Talked6"]<<src.Talked6
	F["Talked7"]<<src.Talked7
	F["Talked8"]<<src.Talked8
	F["Talked9"]<<src.Talked9
	F["Talked10"]<<src.Talked10
	F["Talked11"]<<src.Talked11
	F["Talked12"]<<src.Talked12
	F["Talked13"]<<src.Talked13
	F["Talked14"]<<src.Talked14
	F["Talked15"]<<src.Talked15
	F["Talked16"]<<src.Talked16
	F["Talked17"]<<src.Talked17
	F["Talked18"]<<src.Talked18
	F["Talked19"]<<src.Talked19
	F["Quest1"]<<src.Quest1
	F["Quest2"]<<src.Quest2
	F["Quest3"]<<src.Quest3
	F["Quest4"]<<src.Quest4
	F["Quest5"]<<src.Quest5
	F["Quest6"]<<src.Quest6
	F["Quest7"]<<src.Quest7
	F["Quest8"]<<src.Quest8
	F["Quest9"]<<src.Quest9
//	F["Quest10"]<<src.Quest10
	F["Quest11"]<<src.Quest11
	F["Quest12"]<<src.Quest12
	F["Quest13"]<<src.Quest13
	F["Quest14"]<<src.Quest14
//	F["Quest15"]<<src.Quest15
	F["Quest16"]<<src.Quest16
	F["Quest17"]<<src.Quest17
	F["Quest18"]<<src.Quest18
	F["Quest19"]<<src.Quest19
	F["Quest20"]<<src.Quest20
	F["Zerado"]<<src.Zerado
	F["Clonagem"]<<src.Clonagem
	F["Skill1"]<<src.Skill1
	F["Skill2"]<<src.Skill2
	F["Skill3"]<<src.Skill3
	F["Skill4"]<<src.Skill4
	F["Skill5"]<<src.Skill5
	F["Skill6"]<<src.Skill6
	F["Skill7"]<<src.Skill7
	F["Skill8"]<<src.Skill8
	F["Skill9"]<<src.Skill9
	F["Skill10"]<<src.Skill10
	F["Skill11"]<<src.Skill11
	F["Skill12"]<<src.Skill12
	F["Skill13"]<<src.Skill13
	F["Skill14"]<<src.Skill14
	F["Skill15"]<<src.Skill15
	F["Skill16"]<<src.Skill16
	F["Skill17"]<<src.Skill17
	F["Skill18"]<<src.Skill18
	F["Skill19"]<<src.Skill19
	F["Skill20"]<<src.Skill20
	F["Skill21"]<<src.Skill21
	F["Skill22"]<<src.Skill22
	F["Skill23"]<<src.Skill23
	F["Skill24"]<<src.Skill24
	F["Skill27"]<<src.Skill27
	F["Skill26"]<<src.Skill26
	F["Skill28"]<<src.Skill28
	F["Skill29"]<<src.Skill29
	F["Skill30"]<<src.Skill30
	F["Attack"]<<src.Attack
	F["Patriarca"]<<src.Patriarca
	F["ItemsInventory2"]<<src.ItemsInventory2
	F["MissionBag"]<<src.MissionBag
	F["MissionBag2"]<<src.MissionBag2
	F["Class"]<<src.Class
	F["Fadiga"]<<src.Fadiga
	F["Mission"]<<src.Mission
	usr<<"<b>~Jogo Salvo~"

mob/proc/LoadProc()
	if(fexists("Players/[ckey(src.key)].sav"))
		var/savefile/F=new("Players/[ckey(src.key)].sav")
		var/SaveVersion=F["SaveVersion"]
		src.name=F["name"]
		src.dir=F["dir"]

		src.Level=F["Level"]
		src.contents=F["contents"]
		src.Aviso=F["Aviso"]
		src.OldLoc=F["OldLoc"]
		src.Clicked2=F["Clicked2"]
		src.Doing=F["Doing"]

		src.HairStyle=F["HairStyle"]

		src.First=F["First"]
		src.Zoom=F["Zoom"]
		src.Exp=F["Exp"]
		src.PL=F["PL"]
		src.MaxPL=F["MaxPL"]
		src.Ki=F["Ki"]
		src.MaxKi=F["MaxKi"]
		src.Str=F["Str"]
		src.Def=F["Def"]
		src.Zenie=F["Zenie"]
		src.Title=F["Title"]
		src.BankedZenie=F["BankedZenie"]
		src.TraitPoints=F["TraitPoints"]
		src.PerkPoints=F["PerkPoints"]
		src.Alignment=F["Alignment"]
		src.Traits=params2list(F["Traits"])
		src.RecordedTracked=F["RecordedTracked"]
		F["CashPoints"]>>src.CashPoints
		F["CashPointsReceived"]>>src.CashPointsReceived
		src.SlottedPerks=F["SlottedPerks"]
		src.UnlockedPerks=params2list(F["UnlockedPerks"])
		src.PreferredPowerMode=F["PreferredPowerMode"]
		src.LastWishDate=F["LastWishDate"]
		src.WishesMade=F["WishesMade"]
		src.Title=F["Title"]
		src.IsDead=F["IsDead"]
		src.Training=F["Training"]
		src.TrainingExp=F["TrainingExp"]
		src.CapsuleChars=F["CapsuleChars"]
		src.Friends=F["Friends"]
		src.Materials=F["Materials"]
		src.LastOnline=F["LastOnline"]
		src.ClothesInventory=F["ClothesInventory"]
		src.ItemsInventory=F["ItemsInventory"]

		src.KbType=F["KbType"]
		src.FontFace=F["FontFace"]
		src.FontColor=F["FontColor"]
		src.NameColor=F["NameColor"]
		src.DisplayNameColor=F["DisplayNameColor"]
		src.see_invisible=F["see_invisible"]
		src.VolumeMuteAll=F["VolumeMuteAll"]
		src.VolumeEffect=F["VolumeEffect"]
		src.VolumeMenu=F["VolumeMenu"]
		src.VolumeVoice=F["VolumeVoice"]
		src.VolumeMusic=F["VolumeMusic"]
		src.InstanceLoc=F["InstanceLoc"]
		src.PreInstanceLoc=F["PreInstanceLoc"]
		src.TutsComplete=F["TutsComplete"]
		src.PlayTimeTicks=F["PlayTimeTicks"]
		src.PlayTimeSeconds=F["PlayTimeSeconds"]
		src.PlayTimeMinutes=F["PlayTimeMinutes"]
		src.PlayTimeHours=F["PlayTimeHours"]
		src.IgnoreDuels=F["IgnoreDuels"]
		src.IgnoreParties=F["IgnoreParties"]
		src.IgnoreFusions=F["IgnoreFusions"]
		src.Muted=F["Muted"]
		src.MajinForm=F["MajinForm"]
		src.Talked=F["Talked"]
		src.Talked2=F["Talked2"]
		src.Talked3=F["Talked3"]
		src.Talked4=F["Talked4"]
		src.Talked5=F["Talked5"]
		src.Talked6=F["Talked6"]
		src.Talked7=F["Talked7"]
		src.Talked8=F["Talked8"]
		src.Talked9=F["Talked9"]
		src.Talked10=F["Talked10"]
		src.Talked11=F["Talked11"]
		src.Talked12=F["Talked12"]
		src.Talked13=F["Talked13"]
		src.Talked14=F["Talked14"]
		src.Talked15=F["Talked15"]
		src.Talked16=F["Talked16"]
		src.Talked17=F["Talked17"]
		src.Talked18=F["Talked18"]
		src.Talked19=F["Talked19"]
		src.Quest1=F["Quest1"]
		src.Quest2=F["Quest2"]
		src.Quest3=F["Quest3"]
		src.Quest4=F["Quest4"]
		src.Quest5=F["Quest5"]
		src.Quest6=F["Quest6"]
		src.Quest7=F["Quest7"]
		src.Quest8=F["Quest8"]
		src.Quest9=F["Quest9"]
//		src.Quest10=F["Quest10"]
		src.Quest11=F["Quest11"]
		src.Quest12=F["Quest12"]
		src.Quest13=F["Quest13"]
		src.Quest14=F["Quest14"]
//		src.Quest15=F["Quest15"]
		src.Quest16=F["Quest16"]
		src.Quest17=F["Quest17"]
		src.Quest18=F["Quest18"]
		src.Quest19=F["Quest19"]
		src.Quest20=F["Quest20"]
		src.Zerado=F["Zerado"]
		src.Clonagem=F["Clonagem"]
		src.Skill1=F["Skill1"]
		src.Skill2=F["Skill2"]
		src.Skill3=F["Skill3"]
		src.Skill4=F["Skill4"]
		src.Skill5=F["Skill5"]
		src.Skill6=F["Skill6"]
		src.Skill7=F["Skill7"]
		src.Skill8=F["Skill8"]
		src.Skill9=F["Skill9"]
		src.Skill10=F["Skill10"]
		src.Skill11=F["Skill11"]
		src.Skill12=F["Skill12"]
		src.Skill13=F["Skill13"]
		src.Skill14=F["Skill14"]
		src.Skill15=F["Skill15"]
		src.Skill16=F["Skill16"]
		src.Skill17=F["Skill17"]
		src.Skill18=F["Skill18"]
		src.Skill19=F["Skill19"]
		src.Skill20=F["Skill20"]
		src.Skill21=F["Skill21"]
		src.Skill22=F["Skill22"]
		src.Skill23=F["Skill23"]
		src.Skill24=F["Skill24"]
		src.Skill27=F["Skill27"]
		src.Skill26=F["Skill26"]
		src.Skill28=F["Skill28"]
		src.Skill29=F["Skill29"]
		src.Skill30=F["Skill30"]
		src.Attack=F["Attack"]
		src.Patriarca=F["Patriarca"]
		src.ItemsInventory2=F["ItemsInventory2"]
		src.MissionBag=F["MissionBag"]
		src.MissionBag2=F["MissionBag2"]
		src.Class=F["Class"]
		src.Fadiga=F["Fadiga"]
		src.Mission=F["Mission"]
		src.Zens=F["Zens"]


		src.SaveChar=F["Character"]
		src.Character=AllCharacters[1]
		for(var/obj/Characters/C in AllCharacters)	if(C.name==F["Character"])	{src.Character=C;break}
		src.CurTrans=F["CurTrans"]
		if(src.CurTrans && src.CurTrans<=src.Character.Transes.len)	src.ApplyTransDatum()
		else	src.icon=src.Character.icon
		src.loc=locate(F["x"],F["y"],F["z"])

		if(src.Training=="Focus Training")
			src.Training=initial(src.Training)
			spawn(-1)	src.FocusTrainingProc(src)
			if(src.InstanceLoc)
				var/list/Locs=Split(src.InstanceLoc,"&")
				for(var/obj/TurfType/Instances/I in locate(text2num(Locs[1]),text2num(Locs[2]),text2num(Locs[3])))
					I.InstancePlayers+=src;I.UpdateName();src.InstanceObj=I
		else	src.ExitCP()
		src.loc.Entered(src)
		src.ClearTournamentRing()
		if(!src.SaveFixes(SaveVersion))
			src<<"There was an Error Loading your Old Character!"
			src<<"This was most likely a Programming Error..."
			src<<"Report it on the <a href='http://www.byond.com/members/Falacy/forum'>Forums</a> for correction."
			del src
		if(src.PL<=0)	src.KnockOut(src,"Load")
		src.ResetSuffix()
		if(src.MajinForm==0)
			src.Revert()
		if(src.MajinForm==1)
			src.AddMajin()
		usr<<"Jogo Carregado"
		src.CanSave=1
		return 1

mob/proc/SaveFixes(var/SaveVersion)
	if(!src.KbType)	src.KbType=initial(src.KbType)
	if(!src.NameColor)	src.NameColor=initial(src.NameColor)
	if(SaveVersion<17)	src.PlayTimeSeconds=round(src.PlayTimeTicks/10)
	if(src.PlayTimeSeconds>=2592000)	src.GiveMedal(new/obj/Medals/OneMonth)
	if(src.PlayTimeSeconds>=360000)	src.GiveMedal(new/obj/Medals/TimeInABottle)
	if(SaveVersion<19)	src.Medals-="Hope of the Universe"
	if(SaveVersion<21)	if("Zenie Collected" in src.RecordedTracked)	src.RecordedTracked["Zenie Collected"]=src.Zenie
	if(istext(src.RecordedTracked))	src.RecordedTracked=list()
	if(SaveVersion<28)
		if(!src.RecordedTracked)	src.RecordedTracked=list()
		src.RecordedTracked+="Levels Gained";src.RecordedTracked["Levels Gained"]=src.Level
	if(SaveVersion<34)
		if(src.TutsComplete)	src.TutsComplete-="Trait Points"
		src.Medals-="P.Bag Master"
		src.Medals-="Shadow Spar Master"
	if(SaveVersion<38)	src.FullRespec()
	if(SaveVersion<40)	if(src.TutsComplete)	src.TutsComplete-="Stat Points"
	if(SaveVersion<48)	src.RemovePerk("Flash Finish")
	if(SaveVersion<49)	src.RemovePerk("BulletProof")
	if(!src.DisplayNameColor)	src.DisplayNameColor=initial(src.DisplayNameColor)
	if(!src.PreferredPowerMode)	src.PreferredPowerMode="Ambos"
	if(SaveVersion<56)	src.RespecPerks()
	if(SaveVersion<58)
		src.RemovePerk("KnockBack Resistance")
		src.RemovePerk("Beam Fanatic")
		src.RemovePerk("Weakling")
	if(SaveVersion<61)
		src.PlayTimeHours=round(src.PlayTimeSeconds/60/60)
		src.PlayTimeMinutes=0;src.PlayTimeSeconds=0
		if(!src.TrainingExp)	src.TrainingExp=0
		src.RemovePerk("Wide Awake")
	if(SaveVersion<63)	if(src.Level>=1000)	src.GiveMedal(new/obj/Medals/Millennial)
	if(!src.CapsuleChars)	src.CapsuleChars=list(new/obj/CapsuleChars/Piccolo)
	if(!src.Friends)	src.Friends=list()
	if(SaveVersion<66)	src.RemovePerk("UnShakable")
	if(SaveVersion<69)
		var/LevelsGained=src.GetTrackedStat("Levels from Flag Wars Capture",src.RecordedTracked)
		if(LevelsGained)
			src.Level-=LevelsGained
			src.RecordedTracked-="Levels from Flag Wars Capture"
			src.TrackStat("Removed FW Levels",LevelsGained)
		src.FullRespec()
	else if(SaveVersion<70)	if(src.GetTrackedStat("Character Rebirths",src.RecordedTracked))	src.FullRespec()
	if(!src.WishesMade)	src.WishesMade=0
	if(SaveVersion<73)
		src.VolumeEffect=100
		src.VolumeMenu=100
		src.VolumeVoice=100
		src.VolumeMusic=100
	return 1

mob/proc/RemovePerk(var/Perk2Remove)
	if(Perk2Remove in src.UnlockedPerks)
		src.PerkPoints+=1;src.UnlockedPerks-=Perk2Remove
		var/PerkSlotLoc=src.SlottedPerks.Find(Perk2Remove)
		if(PerkSlotLoc)	src.SlottedPerks[PerkSlotLoc]="Empty"