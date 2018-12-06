note
	description: "Summary description for {SE_CLICK_ACTION}."
	date: "$Date$"
	revision: "$Revision$"

class
	SE_CLICK_ACTION

inherit

	SE_MOUSE_ACTION

	SE_ACTION

create
	make,
	make_with_location

feature -- Execute

	execute
			-- Execute the current action
			-- click an element
		do
			move_to_location
			mouse.click (location)
		end

end
