mob/proc/Description(obj/items/Roupas/I)
	winshow(src,"Description",1) // Show the description window
	var/Position = winget(src, "Inventory", "pos") // Get the position of the "Inventory" window and assign it to a var called "Position"
	winset(src,"Description","pos='[Position]'") // Set the position of the "Description" window to the same position as our inventory.
	winset(src,"Description.Text","text='[I.Descricao]'\nTipo: [I.Tipo]") // Add some text to describe that item...

mob/verb/CloseDescription()
	set hidden = 1
	winshow(src,"Description",0) // Hide the description window