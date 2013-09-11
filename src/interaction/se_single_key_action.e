note
	description: "Summary description for {SE_SINGLE_KEY_ACTION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	SE_SINGLE_KEY_ACTION

inherit

	SE_KEYS_RELATED_ACTION

feature {NONE} -- Intialization

	make (a_keyboard: SE_KEYBOARD; a_mouse: SE_MOUSE; a_keys: SE_KEY_STROKE)
		require
			is_modifer: is_modifier (a_keys)
		do
			set_keyboard (a_keyboard)
			set_mouse (a_mouse)
			set_keys (a_keys)
		ensure
			keyboard_set: keyboard = a_keyboard
			mouse_set: mouse = a_mouse
			keys_set: keys = a_keys
		end

	make_with_location (a_keyboard: SE_KEYBOARD; a_mouse: SE_MOUSE; a_keys: SE_KEY_STROKE; a_coordinate: SE_COORDINATES)
		do
			make (a_keyboard, a_mouse, a_keys)
			set_location (a_coordinate)
		ensure
			keyboard_set: keyboard = a_keyboard
			mouse_set: mouse = a_mouse
			keys_set: keys = a_keys
			location_set: location /= Void implies location = a_coordinate
		end

feature -- Status Report

	is_modifier (a_key: SE_KEY_STROKE): BOOLEAN
			-- Is `a_key' a modifier key?
			-- Key Down / Up events are only applicable for modifier keys.
		do
			modifiers_keys.compare_objects
			Result := modifiers_keys.has (a_key)
		end

feature -- Access

	keys: SE_KEY_STROKE

	modifiers_keys : ARRAY [SE_KEY_STROKE]
		once
			Result := <<
				create {SE_KEY_STROKE}.make ({SE_KEY_CONSTANTS}.shift_key),
				create {SE_KEY_STROKE}.make ({SE_KEY_CONSTANTS}.control_key),
				create {SE_KEY_STROKE}.make ({SE_KEY_CONSTANTS}.alt_key)
			>>
		end

feature -- Change Element

	set_keys (a_keys: SE_KEY_STROKE)
			-- Set `keys' with `a_keys'
		do
			keys := a_keys
		ensure
			keys_set: keys = a_keys
		end

end
