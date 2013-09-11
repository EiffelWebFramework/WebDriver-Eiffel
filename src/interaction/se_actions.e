note
	description: "Object that allows to build a complex chain of events"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SE_ACTIONS

create
	make

feature {NONE} -- Initialization

	make (a_web_driver: WEB_DRIVER)
			-- Create an object Actions using webdriver.
		do
			make_with_parameters (a_web_driver.mouse, a_web_driver.keyboard)
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

feature -- Actions

	click (a_element: WEB_ELEMENT): SE_ACTIONS
			-- Clicks in the middle of the given element `a_element'
			-- Equivalent to call move_to_element (a_element).click()
		do
			actions.add_action (create {SE_CLICK_ACTION}.make_with_location (mouse, create {SE_COORDINATES}.make (a_element)))
			Result := Current
		end

	click_current: SE_ACTIONS
			-- Clicks at the current mouse location
		do
			actions.add_action (create {SE_CLICK_ACTION}.make (mouse))
			Result := Current
		end



	key_down (a_key: SE_KEY_STROKE): SE_ACTIONS
			-- Execute a modifier key press. Does not release the modifier key - subsequent interactions may assume it's kept pressed.
			--  Note that the modifier key is <b>never</b> released implicitly - either key_UP(a_Key)or send_keys(Keys.NULL)
		do
			actions.add_action (create {SE_KEY_DOWN_ACTION}.make(keyboard, mouse, a_key))
			Result := Current
		end



	key_down_element (a_element: WEB_ELEMENT; a_key: SE_KEY_STROKE): SE_ACTIONS
			-- Execute a modifer key press after focusing on an element
			-- Equivalent to: SE_ACTIONS.click(element).send_keys (a_key)
		do
			actions.add_action (create {SE_KEY_DOWN_ACTION}.make_with_location (keyboard, mouse, a_key,create {SE_COORDINATES}.make (a_element) ))
			Result := Current
		end


	key_up (a_key: SE_KEY_STROKE): SE_ACTIONS
			-- Execute a modifier key release. Releasing a non-depressed modifier key will yield undefined
   			-- behaviour.
		do
			actions.add_action (create {SE_KEY_UP_ACTION}.make(keyboard, mouse, a_key))
			Result := Current
		end



	key_up_element (a_element: WEB_ELEMENT; a_key: SE_KEY_STROKE): SE_ACTIONS
			-- Executes a modifier key release after focusing on an element.
			-- Equivalent to: SE_ACTIONS.click(a_element).send_keys (a_key)
		do
			actions.add_action (create {SE_KEY_UP_ACTION}.make_with_location (keyboard, mouse, a_key,create {SE_COORDINATES}.make (a_element) ))
			Result := Current
		end

feature -- Builder

  build: SE_ACTION
		-- Build a composite action containinig all actions, ready to be executed (and
   		-- resets the internal builder state, so subsequent calls to build will contain fresh
   		-- sequences).
  	do
  		Result := actions.twin
  		reset
  	end

end
