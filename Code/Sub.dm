mob/Sub/verb
	Download_Icon_Base()
		set category="Sub"
		var/icon/I='GokuSS3.dmi'
		if(usr.UploadingIcon)	return
		usr.UploadingIcon=1;usr<<ftp(I);usr.UploadingIcon=0
	Change_Name()
		set category="Sub"
		var/NewName=copytext(input("Input New Name","Change Name",AtName(usr.name)) as text,1,25)
		usr.name=NameGuard(NewName)
		if(!usr.name)	usr.name=usr.key
		if(usr.name!=usr.key)	usr.name="[usr.name]"
		usr.AddName(usr.name)
		src.UpdateHUDText("PlayerName","[copytext(AtName(src.name),1,10)]")
		if(src.Party)	for(var/mob/M in src.Party)	M.UpdateHUDText("Party[src.PartyID]",AtName(src.name))
	Font_Color()
		set category="Sub"
		set name="Color: OOC Messages"
		usr.FontColor=input("Select your Font Color","Font Color",usr.FontColor) as color
	Font_Face()
		set category="Sub"
		usr.FontFace=input("Set the font face for your messages","Font Face",usr.FontFace)as text
		usr.FontFace=AsciiCheck(RemoveHTML(usr.FontFace))
		if(!usr.FontFace)	usr.FontFace=initial(usr.FontFace)
		usr.RestrictedFontCheck()
	Name_Color()
		set category="Sub"
		set name="Color: OOC Name"
		usr.NameColor=input("Select your Name Color","Name Color",usr.NameColor) as color
	ColorDisplayName()
		set category="Sub"
		set name="Color: Display Name"
		usr.DisplayNameColor=input("Select your Display Name Color","Display Name Color",usr.DisplayNameColor) as color
		usr.AddName()
/*	Add_Overlay()
		set category="Sub"
		var/icon/I=usr.UploadIconProc();if(!I)	return
		usr.overlays+=I;usr.SubOverlays+=I
		usr<<"Overlay Added"
	Remove_Overlay()
		set category="Sub"
		var/icon/I=input("Select Overlay To Remove","Remove Overlay")as null|anything in usr.SubOverlays
		if(!I)	return
		usr.overlays-=I;usr.SubOverlays-=I
		usr<<"Overlay Removed"
	Add_Underlay()
		set category="Sub"
		var/icon/I=usr.UploadIconProc();if(!I)	return
		usr.underlays+=I;usr.SubUnderlays+=I
		usr<<"Underlay Added"
	Remove_Underlay()
		set category="Sub"
		var/icon/I=input("Select Underlay To Remove","Remove Underlay")as null|anything in usr.SubUnderlays
		if(!I)	return
		usr.underlays-=I;usr.SubUnderlays-=I
		usr<<"Underlay Removed"*/
