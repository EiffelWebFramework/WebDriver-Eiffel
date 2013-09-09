note
	description: "Summary description for {SE_ACTIONS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SE_ACTIONS

create
	make

feature {NONE} -- Initialization

	make (a_web_driver: WEB_DRIVER)
			-- Create an object Actions using webdriver input devices (mouse and keyboard)
		do
			make_with_parameters (a_web_driver.mouse, a_web_driver.keyboard )
		ensure
			keyboard_set: attached keyboard
			mouse_set: attached mouse
			actions_set: actions.is_empty
		end

	make_with_parameters (a_mouse: SE_MOUSE; a_keyboard: SE_KEYBOARD)
			-- Create an object Actions with `a_mouse' and `a_keyboard'
		do
			set_keyboard (a_keyboard)
			set_mouse (a_mouse)
			reset
		ensure
			keyboard_set: keyboard = a_keyboard
			mouse_set: mouse = a_mouse
			actions_set: actions.is_empty
		end

feature -- Access

	keyboard: SE_KEYBOARD
	mouse: SE_MOUSE
	actions: SE_COMPOSITE_ACTION

feature -- Change Element

	reset
			-- Create a new instance of composite actions.
		do
			create actions.make
		end


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

end
