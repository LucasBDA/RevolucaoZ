#define password 1
mob/var/Input = ""

proc/Input(mob/M, var/Text = "", var/Password = 0, var/Fade = 0, var/CloseOnFade = 0)
	if(winget(M, "Input", "is-visible") == "true") return

	winset(M,"Input.Text","text = '[Text]'") // Add the text
	winset(M, "Input.input", "is-password='false'")
	if(Password) winset(M, "Input.input", "is-password='true'")
	//////Fading Code//////////////////////////////////
	if(!Fade) winshow(M,"Input",1);winset(M, "Input", "alpha='255'") // If "Fade = 0" Show the window, no fade, set alpha to 255.
	if(Fade) M.Fade("Input") //If "Fade = 1" Show the window using the fade in proc.
	//////WAIT FOR THE ANSWER/////////////////////////

	while(!M.Input)
		sleep(1)
		if(M.Input) goto END

	/////////RETURN THE ANSWER////////////////////////
	END
	var/Input = M.Input; M.Input = null
	return "[Input]"

mob/verb/Send(Text as text)
	set hidden = 1
	src.Input = Text ; winshow(src,"Input",0)
	return src.Input