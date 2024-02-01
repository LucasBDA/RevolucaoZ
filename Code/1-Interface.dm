mob/var/TxtSpd = 1

proc/Text(mob/M,var/Text="")
	var/Blank = " " // This is going to start as blank...and gradually have new letters added one by one.
	winset(M, "output1", "is-visible=true")
	while(length(Blank)<length(Text)) //While we still did not show all letters...
		sleep(M.TxtSpd) //Speed
		Blank = addtext(Blank,"[getCharacter(Text,length(Blank))]")// Add in the next letter.
		M <<output(null,"output1") //Clean up our output from the previous text.
		M <<output("<font size=1>[Blank]","output1") //Output the new text with the new letter.
		if(length(Blank)>=length(Text)) //If this was the last letter.
	//		winset(M, "output1", "is-visible=false")
			return // That's it! We're done.

proc
	getCharacter(string, pos=1)
		return ascii2text(text2ascii(string, pos)) //This proc is used to retrieve the next character in text string.