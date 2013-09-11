note
	description: "Moves the mouse to an element."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SE_MOVE_MOUSE_ACTION
inherit

	SE_MOUSE_ACTION

	SE_ACTION

create
	make_with_location

feature -- Execute

	execute
			-- Move the mouse to an element
		do
			if attached location as l_location then
				mouse.mouse_move (l_location)
			end
				--| Maybe I need to raise an Exception here!!!
		end

invariant
	location_attached: attached location
		-- Must provide a location for a move action
end
