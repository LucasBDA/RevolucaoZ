var/TreasureHunterTag="<b><font color=[rgb(152,155,21)]>Caçador de Tesouros:</font>"

var/obj/Items/Destroyable/Chests/Golden_Chest/TreasureHunterChest=new

proc/EventLoopTreasureHunter()
	while(world)
		if(!TreasureHunterChest.loc)
			TreasureHunterChest.loc=locate(rand(11,389),rand(11,389),1)
			TreasureHunterChest.icon_state=initial(TreasureHunterChest.icon_state)
		world<<"[TreasureHunterTag] Um Baú Dourado apareceu em algum lugar da Terra!"
		sleep(6000)
