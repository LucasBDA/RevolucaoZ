/Option
	parent_type = /obj
	Click()
		usr.Answer = "[src.name]"
		usr.CloseWindow("Switch","0")
	MouseEntered()
		winset(usr,"Switch.grid1","style='body{background-color:#58FA58;color:#FFFFFF;}'")
		winset(usr,"window74.grid1","style='body{background-color:#58FA58;color:#FFFFFF;}'") // Give it a green highlight color
		usr << output(src,"window74.grid1:1,[usr.List.Find(src)]")
		usr << output(src,"Switch.grid1:1,[usr.List.Find(src)]")
	MouseExited()
		winset(usr,"Switch.grid1","style=''")
		for(var/Z in usr.List)
			usr << output(Z,"Switch.grid1:1,[usr.List.Find(Z)]")
		winset(usr,"window74.grid1","style=''")
		for(var/Z in usr.List)
			usr << output(Z,"window74.grid1:1,[usr.List.Find(Z)]")

	MouseDown() //When you click
		winset(usr,"Switch.grid1","style='body{background-color:#2ECCFA;color:#FFFFFF;}'") // Give it a blue highlight color
		usr << output(src,"Switch.grid1:1,[usr.List.Find(src)]")

	MouseUp() //When you release
		winset(usr,"Switch.grid1","style='body{background-color:#FFFFFF;color:#000000;}'") // Revert back to original colors.
		usr << output(src,"Switch.grid1:1,[usr.List.Find(src)]")


mob/var/list/List = list()
mob/var/Answer = ""

proc/Switch(mob/M, var/Text = "", var/Options = list(), var/Fade = 0, var/CloseOnFade = 0)
	if(winget(M, "Switch", "is-visible") == "true") return

	//Clean up the interface and write the text//
	M << output(null, "Switch.grid1");M.List.Cut() //Clear grid, and clear the list.
	winset(M, "Switch.grid1", "cells = 0x0") // Another way of clearing the grid...
	winset(M,"Switch.grid1","style='body{background-color:#FFFFFF;}'") //Make sure the cells are not highlighted.
	winset(M,"Switch.Text","text = '[Text]'") // Add the text
	winset(M, "Switch.grid1", "cells = 1x[length(Options)]") // Create the right number of cells based on the number of options.
	/////Lets start adding the options///////////

	for(var/a in Options)
		var/Option/O = new ; O.name = "[a]"
		M.List.Add(O)
	for(var/Z in M.List)
		M << output(Z,"Switch.grid1:1,[M.List.Find(Z)]")

	//////Fading Code//////////////////////////////////
	if(!Fade) winshow(M,"Switch",1);winset(M, "Switch", "alpha='255'") // If "Fade = 0" Show the window, no fade, set alpha to 255.
	if(Fade) M.Fade("Switch") //If "Fade = 1" Show the window using the fade in proc.
	//////WAIT FOR THE ANSWER/////////////////////////

	while(!M.Answer)
		sleep(1)
		if(M.Answer) goto END

	/////////RETURN THE ANSWER////////////////////////
	END
	var/Answer = M.Answer; M.Answer = null;M.List.Cut();
	return "[Answer]"

proc/Switch2(mob/M, var/Text = "", var/Options = list(), var/Fade = 0, var/CloseOnFade = 0)
	if(winget(M, "window74", "is-visible") == "true") return

	//Clean up the interface and write the text//
	M << output(null, "window74.grid1");M.List.Cut() //Clear grid, and clear the list.
	winset(M, "window74.grid1", "cells = 0x0") // Another way of clearing the grid...
	winset(M,"window74.grid1","style='body{background-color:#FFFFFF;}'") //Make sure the cells are not highlighted.
	winset(M,"window74.Text","text = '[Text]'") // Add the text
	winset(M, "window74.grid1", "cells = 1x[length(Options)]") // Create the right number of cells based on the number of options.
	/////Lets start adding the options///////////

	for(var/a in Options)
		var/Option/O = new ; O.name = "[a]"
		M.List.Add(O)
	for(var/Z in M.List)
		M << output(Z,"window74.grid1:1,[M.List.Find(Z)]")

	//////Fading Code//////////////////////////////////
	if(!Fade) winshow(M,"window74",1);winset(M, "window74", "alpha='255'") // If "Fade = 0" Show the window, no fade, set alpha to 255.
	if(Fade) M.Fade("window74") //If "Fade = 1" Show the window using the fade in proc.
	//////WAIT FOR THE ANSWER/////////////////////////

	while(!M.Answer)
		sleep(1)
		if(M.Answer) goto END

	/////////RETURN THE ANSWER////////////////////////
	END
	var/Answer = M.Answer; M.Answer = null;M.List.Cut();
	return "[Answer]"
