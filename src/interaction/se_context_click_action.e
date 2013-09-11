note
	description: "Context-clicks an element"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SE_CONTEXT_CLICK_ACTION

inherit

	SE_MOUSE_ACTION

	SE_ACTION

create
	make,
	make_with_location

feature -- Execute

	execute
			-- Emulates clicking on the mouse button that would bring up contextual menus (usually
   			-- right-clicking).
		do
			move_to_location
			mouse.context_click (location)
		end
end
