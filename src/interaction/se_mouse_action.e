note
	description: "Summary description for {SE_MOUSE_ACTION}."
	date: "$Date$"
	revision: "$Revision$"

class
	SE_MOUSE_ACTION

inherit

	SE_BASE_ACTION

create
	make,
	make_with_location

feature {NONE} --Initialization

	make (a_mouse: SE_MOUSE)
			-- Create a mouse action with `a_mouse'
		do
			set_mouse (a_mouse)
		ensure
			mouse_set: mouse = a_mouse
		end

	make_with_location (a_mouse: SE_MOUSE; a_coordinate: SE_COORDINATES)
			-- Create a mouse action with `a_mouse' and `a_coordinates'
		do
			set_mouse (a_mouse)
			set_location (a_coordinate)
		ensure
			mouse_set: mouse = a_mouse
			location_set: location /= Void implies location = a_coordinate
		end

feature -- Access

	mouse: SE_MOUSE

feature -- Change Element

	set_mouse (a_mouse: SE_MOUSE)
			-- Set `mouse' with `a_mouse'
		do
			mouse := a_mouse
		ensure
			mouse_set: mouse = a_mouse
		end

feature {NONE} -- Implementation

	move_to_location
			-- Only call mouse_move if actaul location was provided
			-- in other case the action will happend in the last know
			-- location of the mouse cursor
		do
			if attached location as l_location then
				mouse.mouse_move (l_location)
			end
		end

end
