

turf/Grass {icon = 'Grass.dmi'}



obj/items
	MouseDrag(src_object,over_object,src_location,over_location,src_control,over_control,params)// When we drag it...
		if(!(src in usr.contents)) return // If its not in our inventory...just cancel ...
		var/icon/I = new(src.icon,src.icon_state)//this is so the cursor icon transforms into the item itself...cool little effect.
		mouse_drag_pointer = I // now lets set the mouse cursor to that.

	MouseDrop(over_object=src,src_location,over_location, src_control,over_control,params) //When we drop it...
		if(over_control =="Inventory.Inv") //If its inside the inventory window.
			var/obj/O = over_object
			src.screen_loc = O.screen_loc //Move the object on the new slot.