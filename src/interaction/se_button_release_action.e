note
	description: "Releases the left mouse button"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SE_BUTTON_RELEASE_ACTION

inherit

	SE_MOUSE_ACTION

	SE_ACTION

create
	make,
	make_with_location

feature -- Execute

	execute
			-- Releases the mouse button currently left held. This action can be called for an element
			-- different than the one ClickAndHoldAction was called for. However, if this action is performed
			-- out of sequence (without holding down the mouse button, for example) the results will be
			-- different between browsers.
		do
			move_to_location
			mouse.mouse_up (location)
		end

end
