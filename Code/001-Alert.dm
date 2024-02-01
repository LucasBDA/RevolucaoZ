proc/Alert(mob/M, var/Text = "", var/Fade = 0, var/CloseOnFade = 0)
	if(winget(M, "Alert", "is-visible") == "true") return
	winset(M,"Alert.Text","text = '[Text]'") // Add the text
	winset(M,"Alert.Close","command = 'CloseWindow1 \"Alert\" [CloseOnFade]'") // Add the global close command that will close your window.
	if(!Fade)
		winshow(M,"Alert",1);winset(M, "Alert", "alpha='255'");return
	if(Fade)M.Fade("Alert");return

mob/proc/Fade(WindowName as text)
	var/alpha = 0
	winshow(src,"[WindowName]",1) ; winset(src, "[WindowName]", "alpha='[alpha]'")
	for(var/A = 1 to 20)
		sleep(1)
		alpha+=20
		winset(src, "[WindowName]", "alpha='[alpha]'")

mob/proc/FadeOut(WindowName as text)
	var/alpha = 255
	winshow(src,"[WindowName]",1) ; winset(src, "[WindowName]", "alpha='[alpha]'")
	for(var/A = 1 to 20)
		sleep(1)
		alpha-=20 // Faster fading out
		winset(src, "[WindowName]", "alpha='[alpha]'")
	if(text2num(winget(src, "Alert", "alpha"))<=0)
		winset(src, "[WindowName]", "alpha='0'")
		winshow(src,"[WindowName]",0)

mob/verb/CloseWindow1(WindowName as text,CloseOnFade as text)
	set hidden = 1
	if(winget(src, "[WindowName]", "alpha") < "255") return
	if(CloseOnFade == "0")
		winshow(src,"[WindowName]",0);return
	if(CloseOnFade)
		src.FadeOut("[WindowName]");return