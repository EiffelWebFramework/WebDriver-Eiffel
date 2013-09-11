note
	description: "Summary description for {SE_KEY_UP_ACTION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SE_KEY_UP_ACTION

inherit

	SE_SINGLE_KEY_ACTION

	SE_ACTION

create
	make,
	make_with_location

feature -- Execute

	execute
			-- Release key
		do
			focus_on_element
			keyboard.release_key (keys)
		end
end
