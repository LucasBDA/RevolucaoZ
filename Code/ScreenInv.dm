mob/verb/CloseInventory()
	winshow(src,"Inventory",0) //Hide the inventory window!

mob/verb/Inventory()
	winshow(src,"Inventory",1) //Show the inventory window!
	var/Position = winget(src, "default", "pos") // Get the position of the "default" window and assign it to a var called "Position"
	winset(src,"Inventory","pos='[Position]'") // Set the position of the "Inventory" window to the same position as our main window.
	for(var/Grid/G in src.client.screen)
		del(G) //Clear the inventory before generating everything inside.
	for(var/Column = 1 to 5) for(var/Row = 1 to 5) //Create a grid composed of 5 columns and 5 rows.
		var/Grid/G = new
		G.screen_loc = "Inv:[Row],[Column]"
		src.client.screen += G
	for(var/obj/items/I in src.contents) src.AddItems(I) //Generate the items on slots.

mob/proc/AddItems(obj/items/Roupas/I)
	for(var/Grid/G in src.client.screen)
		if(G.used) continue
		I.screen_loc = G.screen_loc ; src.client.screen+=I
		if(I.Equipado==1)
			G.icon_state="GridEquiped"
		G.used =1 ; return

Grid
	parent_type = /obj
	icon = 'Inventory.dmi'
	icon_state = "Grid"
	var/used = 0