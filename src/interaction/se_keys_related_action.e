note
	description: "Summary description for {SE_KEYS_RELATED_ACTION}."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	SE_KEYS_RELATED_ACTION

inherit

	SE_BASE_ACTION

feature -- Access

	keyboard: SE_KEYBOARD

	mouse: SE_MOUSE

feature -- Change Element

	set_keyboard (a_keyboard: SE_KEYBOARD)
			-- Set `keyboard' with `a_keyboard'
		do
			keyboard := a_keyboard
		ensure
			keyboard_set: keyboard = a_keyboard
		end

	set_mouse (a_mouse: SE_MOUSE)
			-- Set `mouse' 	with `a_mouse'
		do
			mouse := a_mouse
		ensure
			mouse_set: mouse = a_mouse
		end


feature {NONE} -- Implementation

	focus_on_element
		do
			if attached location as l_location then
				mouse.click (l_location)
			end
		end
end
