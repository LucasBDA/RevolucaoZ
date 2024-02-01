/*
	Subpixel movement lets you move by any floating-point number of pixels.
	It's also super convenient to have a proc you can call to move by a pixel offset.
*/

atom/movable
	var
		sub_step_x = 0
		sub_step_y = 0

	proc
		PixelMove(move_x, move_y)
			var
				whole_x = 0
				whole_y = 0

			if(move_x)
				sub_step_x += move_x
				whole_x = round(sub_step_x, 1)
				sub_step_x -= whole_x

			if(move_y)
				sub_step_y += move_y
				whole_y = round(sub_step_y, 1)
				sub_step_y -= whole_y

			if(whole_x || whole_y)
				step_size = max(abs(whole_x), abs(whole_y))
				Move(loc, dir, step_x + whole_x, step_y + whole_y)
