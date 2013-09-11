note
	description: "Presses the left mouse button without releasing it."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SE_CLICK_AND_HOLD_ACTION

inherit

	SE_MOUSE_ACTION

	SE_ACTION

create
	make,
	make_with_location

feature -- Execute

	execute
			-- Holds down the mouse button on a selected element. If this action is called out of sequence
			-- (i.e. twice in a row, without releasing the button after the first action) the results will be
			-- different between browsers.
		do
			move_to_location
			mouse.mouse_down (location)
		end
end
