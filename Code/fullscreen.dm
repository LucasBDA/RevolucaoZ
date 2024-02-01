/*
	Fullscreen Interface
	A BYOND library
	By Tyruswoo "Woo"
	August 4, 2017

	Includes:
	fullscreen.dm								This file contains the verb ToggleFullscreen to be accessed by fullscreen_interface.dmf
	fulsscreen_interface.dmf					The interface file defines the appearance of our game's window.

	For help, see the BYOND Skin Reference:		http://www.byond.com/docs/ref/skinparams.html

	About "Controls":
		"Controls" include anything you want to be visible in your game's window, such as a map (or maps), outputs (such as chat),
		inputs (such as a chat input), or any type of status window (such as an inventory, or a list of the player's health/condition),
		or a list of available verbs the user can access while playing. All of these are controls, which can be changed to your liking
		by changing the window(s) of an interface file, such as the fullscreen_interface.dmf file included here.

	About Menus:
		Within the interface, you can also adjust any menu(s) that are available to the user.
		Menus can be another great place to tuck verbs away, so they are accessible, but with a less cluttered look.

	About Macros:
		Macros are a great way to make key presses activate certain verbs.
		These can be assigned using an interface (.dmf) file or a script (.dms) file.

	About Heads-Up Displays (HUDs):
		Note: You can use a heads-up display (HUD) to display objects on the screen, with which the player can interact without needing
		another "control" in the window. For an example of HUDs, see my Woo.ScreenInventory library, which displays inventory using a HUD.
*/
client
	var
		fullscreen = 0	//Keep track of whether window is in fullscreen mode or not.
	New() //When a new client arrives (a new user logs in)...
		..() //Perform the default new client proc
		ToggleFullscreen() //Then toggle fullscreen to TRUE
	verb //Verbs can be accessed by the macros (using key presses), so we need to define verbs (not procs) for our key presses.
		ToggleFullscreen()
			fullscreen = !fullscreen //Toggle the fullscreen variable
			if(fullscreen) //If fullscreen == 1 (TRUE)
				winset(src, "default", "is-maximized=false;can-resize=false;titlebar=false;menu=") //Reset to not maximized and turn off titlebar.
				winset(src, "default", "is-maximized=true") //Now set to maximized. We have to do this separately, so that the taskbar is appropriately covered.
			else //If fullscreen == 0 (FALSE)
				winset(src, "default", "is-maximized=false;can-resize=true;titlebar=true;menu=menu") //Set window to normal size.
/*
var/area = 1#INF
var/zoom = 0
var/view_width, view_height
while(area>=MAX_TILES)
    zoom += 1
    view_width = ceil(screen_width / TILE_WIDTH / zoom)
    view_height = ceil(screen_height / TILE_HEIGHT / zoom)
    if(!(view_width%2)) view_width += 1
    if(!(view_height%2)) view_height += 1
    area = view_width * view_height
    */