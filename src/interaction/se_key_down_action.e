note
	description: "Summary description for {SE_KEY_DOWN_ACTION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SE_KEY_DOWN_ACTION

inherit

	SE_SINGLE_KEY_ACTION

	SE_ACTION

create
	make,
	make_with_location

feature -- Execute

	execute
			-- Key press only
		do
			focus_on_element
			keyboard.press_key (keys)
		end
end
