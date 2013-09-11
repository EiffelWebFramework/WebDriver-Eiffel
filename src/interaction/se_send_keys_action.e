note
	description: "Summary description for {SE_SEND_KEYS_ACTION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SE_SEND_KEYS_ACTION

inherit

	SE_KEYS_RELATED_ACTION

	SE_ACTION

create
	make,
	make_with_location

feature {NONE} -- Implementation

	make (a_keyboard: SE_KEYBOARD; a_mouse: SE_MOUSE; a_keys: ARRAY[STRING_32])
		do
			set_keyboard (a_keyboard)
			set_mouse (a_mouse)
			keys := a_keys
		ensure
			keyboard_set: keyboard = a_keyboard
			mouse_set: mouse = a_mouse
			keys_set: keys = a_keys
		end


	make_with_location (a_keyboard: SE_KEYBOARD; a_mouse: SE_MOUSE; a_coordinate: SE_COORDINATES; a_keys: ARRAY[STRING_32])
		do
			set_keyboard (a_keyboard)
			set_mouse (a_mouse)
			set_location (a_coordinate)
			keys := a_keys
		ensure
			keyboard_set: keyboard = a_keyboard
			mouse_set: mouse = a_mouse
			location_set: location /= void implies location = a_coordinate
			keys_set: keys = a_keys
		end


feature -- Access

	keys: ARRAY[STRING_32]

feature -- Execute	

	execute
		do
			focus_on_element
			keyboard.send_keys (keys)
		end
end
