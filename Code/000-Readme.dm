/*
Hello, thank you for downloading the interface commands library.
In this demo we will be going threw a few interface commands that I've created to make development a lot easier.
First let me list the features inside this library:
								-Simplistic interface design
								-Fading interface pop ups
								-Custom alerts
								-Global close command: One command to close any window, no need to create a verb for each window now!




										Current Proc in this library:

										-Alert(MOB,MESSAGE,FADE,CLOSE_FADE)
										-Switch(MOB,MESSAGE,OPTIONS,FADE,CLOSE_FADE)
										-Input(MOB,MESSAGE,PASSWORD,FADE,CLOSING_FADE))
										-Fade("NameOfWindow")
										-FadeOut("NameOfWindow")

Please note that this is only v.1 of the library and that there are many other interface commands that I plan to add.


															HOW IT WORKS:

									Alert: It uses the following format Alert(MOB,MESSAGE,FADE,CLOSING_FADE)

										MOB being the mob to who you send the message.
										MESSAGE being the text you would like to send.
										FADE being 0 or 1 (0 = no fade) (1 = fade)
										CLOSE_FADE being 0 or 1 (0 = No fade when closing) (1 = Fade before closing)

									Switch: It uses the following format switch(Switch(MOB,MESSAGE,FADE,CLOSING_FADE))
											followed by the if statements.

										MOB being the mob to who you send the message.
										MESSAGE being the text you would like to send.
										FADE being 0 or 1 (0 = no fade) (1 = fade)
										CLOSE_FADE being 0 or 1 (0 = No fade when closing) (1 = Fade before closing)


									Input: It uses the following format Input(MOB,MESSAGE,PASSWORD,FADE,CLOSING_FADE))

										MOB being the mob to who you send the message.
										MESSAGE being the text you would like to send.
										PASSWORD being nothing or password (password =, text will show up like this ******)
										FADE being 0 or 1 (0 = no fade) (1 = fade)
										CLOSE_FADE being 0 or 1 (0 = No fade when closing) (1 = Fade before closing)


									Fade: It uses the following format Fade("NameOfWindow")

									FadeOut: It uses the following format FadeOut("NameOfWindow")

									winset(MOB,"INTERFACE.BUTTON","command = 'CloseWindow \"NAME_OF_INTERFACE\"'")

										This little piece of code allows you to set a custom command to close the window.
										No need to create manually a verb for each window. With this little code,
										everything was pre-programmed for you. Simply when you use winshow() ,
										add in that piece of code you see above.




More to come soon...
*/
