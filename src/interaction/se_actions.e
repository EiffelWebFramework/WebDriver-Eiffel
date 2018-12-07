note
	description: "Object that allows to build a complex chain of events"
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
			actions.add_action (create {SE_KEY_DOWN_ACTION}.make (keyboard, mouse, a_key))
			Result := Current
		end

	key_down_element (a_element: WEB_ELEMENT; a_key: SE_KEY_STROKE): SE_ACTIONS
			-- Execute a modifer key press after focusing on an element
			-- Equivalent to: SE_ACTIONS.click(element).send_keys (a_key)
		do
			actions.add_action (create {SE_KEY_DOWN_ACTION}.make_with_location (keyboard, mouse, a_key, create {SE_COORDINATES}.make (a_element)))
			Result := Current
		end

	key_up (a_key: SE_KEY_STROKE): SE_ACTIONS
			-- Execute a modifier key release. Releasing a non-depressed modifier key will yield undefined
			-- behaviour.
		do
			actions.add_action (create {SE_KEY_UP_ACTION}.make (keyboard, mouse, a_key))
			Result := Current
		end

	key_up_element (a_element: WEB_ELEMENT; a_key: SE_KEY_STROKE): SE_ACTIONS
			-- Executes a modifier key release after focusing on an element.
			-- Equivalent to: SE_ACTIONS.click(a_element).send_keys (a_key)
		do
			actions.add_action (create {SE_KEY_UP_ACTION}.make_with_location (keyboard, mouse, a_key, create {SE_COORDINATES}.make (a_element)))
			Result := Current
		end

	click_and_hold (a_element: WEB_ELEMENT): SE_ACTIONS
			-- Clicks (without releasing) in the middle of the given element. This is equivalent to:
			-- SE_ACTIONS.move_to_element (a_element).click_and_hold_current
		do
			actions.add_action (create {SE_CLICK_AND_HOLD_ACTION}.make_with_location (mouse, create {SE_COORDINATES}.make (a_element)))
			Result := Current
		end

	click_and_hold_current: SE_ACTIONS
			-- Clicks (without releasing) at the current mouse location.
		do
			actions.add_action (create {SE_CLICK_AND_HOLD_ACTION}.make (mouse))
			Result := Current
		end

	release (a_element: WEB_ELEMENT): SE_ACTIONS
			-- Releases the depressed left mouse button, in the middle of the given element.
			-- This is equivalent to: SE_ACTIONS.move_to_element(a_element).release_current
			-- Invoking this action without invoking  click_and_hold  first will result in
			-- undefined behavior
		do
			actions.add_action (create {SE_BUTTON_RELEASE_ACTION}.make_with_location (mouse, create {SE_COORDINATES}.make (a_element)))
			Result := Current
		end

	release_current: SE_ACTIONS
			-- Releases the depressed left mouse button at the current mouse location.
		do
			actions.add_action (create {SE_BUTTON_RELEASE_ACTION}.make (mouse))
			Result := Current
		end

	double_click (a_element: WEB_ELEMENT): SE_ACTIONS
			-- Performs a double-click at middle of the given element. Equivalent to:
			-- SE_ACTIONS.move_to_element (a_element).double_click_current
		do
			actions.add_action (create {SE_DOUBLE_CLICK_ACTION}.make_with_location (mouse, create {SE_COORDINATES}.make (a_element)))
			Result := Current
		end

	double_click_current: SE_ACTIONS
			-- Performs a double-click at the current mouse location.
		do
			actions.add_action (create {SE_DOUBLE_CLICK_ACTION}.make (mouse))
			Result := Current
		end

	move_to_element (a_element: WEB_ELEMENT): SE_ACTIONS
			-- Moves the mouse to the middle of the element.
		do
			actions.add_action (create {SE_MOVE_MOUSE_ACTION}.make_with_location (mouse, create {SE_COORDINATES}.make (a_element)))
			Result := Current
		end

	move_to_element_with_offset (a_element: WEB_ELEMENT; a_xoffset: INTEGER; a_yoffset: INTEGER): SE_ACTIONS
			-- Moves the mouse to an offset from the top-left corner of the element.
			-- The element is scrolled into view and its location is calculated using getBoundingClientRect.
			-- a_xoffset Offset from the top-left corner. A negative value means coordinates right from the element
			-- a_yoffset Offset from the top-left corner. A negative value means coordinates above the element
		do
			actions.add_action (create {SE_MOVE_TO_OFFSET_ACTION}.make_with_location_and_offset (mouse, create {SE_COORDINATES}.make (a_element), a_xoffset, a_yoffset))
			Result := Current
		end

	move_by_offset (a_xoffset: INTEGER; a_yoffset: INTEGER): SE_ACTIONS
			-- Moves the mouse from its current position (or 0,0) by the given offset. If the coordinates
			-- provided are outside the viewport (the mouse will end up outside the browser window) then
			-- the viewport is scrolled to match.
			-- a_xoffset horizontal offset. A negative value means moving the mouse left.
			-- a_yoffset vertical offset. A negative value means moving the mouse up.
		do
			actions.add_action (create {SE_MOVE_TO_OFFSET_ACTION}.make_with_offset (mouse, a_xoffset, a_yoffset))
			Result := Current
		end

	context_click (a_element: WEB_ELEMENT): SE_ACTIONS
			-- Executes a context-click at middle of the given element. First performs a mouseMove
			-- to the location of the element.
		do
			actions.add_action (create {SE_CONTEXT_CLICK_ACTION}.make_with_location (mouse, create {SE_COORDINATES}.make (a_element)))
			Result := Current
		end

	context_click_current (a_element: WEB_ELEMENT): SE_ACTIONS
			-- Executes a ontext-click at the current mouse location.
		do
			actions.add_action (create {SE_CONTEXT_CLICK_ACTION}.make (mouse))
			Result := Current
		end


	drag_and_drop (a_source: WEB_ELEMENT; a_target: WEB_ELEMENT) : SE_ACTIONS
			-- A convenience method that performs click-and-hold at the location of the source element,
			-- moves to the location of the target element, then releases the mouse.
			-- a_source: element to emulate button down at
			-- a_target: moves to the location of the target element, then releases the mouse.
		do
			actions.add_action (create {SE_CLICK_AND_HOLD_ACTION}.make_with_location (mouse,create {SE_COORDINATES}.make (a_source)))
			actions.add_action (create {SE_MOVE_MOUSE_ACTION}.make_with_location (mouse,create {SE_COORDINATES}.make (a_target)))
			actions.add_action (create {SE_BUTTON_RELEASE_ACTION}.make_with_location (mouse,create {SE_COORDINATES}.make (a_target)))
			Result := Current
		end

	drag_and_drop_by (a_source: WEB_ELEMENT; a_xoffset: INTEGER; a_yoffset: INTEGER): SE_ACTIONS
			-- A convenience method that performs click-and-hold at the location of the source element,
			-- moves by a given offset, then releases the mouse.
			-- a_source element to emulate button down at.
			-- a_xoffset horizontal move offset.
			-- a_yoffset vertical move offset
		do
			actions.add_action (create {SE_CLICK_AND_HOLD_ACTION}.make_with_location (mouse,create {SE_COORDINATES}.make (a_source)))
			actions.add_action (create {SE_MOVE_TO_OFFSET_ACTION}.make_with_offset (mouse,a_xoffset,a_yoffset))
			actions.add_action (create {SE_BUTTON_RELEASE_ACTION}.make (mouse))
			Result := Current
		end


	send_keys_current (a_keys: ARRAY[STRING_32]): SE_ACTIONS
			-- Sends keys to the active element
		do
			actions.add_action (create {SE_SEND_KEYS_ACTION}.make (keyboard, mouse, a_keys))
			Result := Current
		end

	send_keys (a_element: WEB_ELEMENT; a_keys: ARRAY[STRING_32]): SE_ACTIONS
			--  Sends keys to the element `a_element'
		do
			actions.add_action (create {SE_SEND_KEYS_ACTION}.make_with_location (keyboard, mouse, create {SE_COORDINATES}.make (a_element), a_keys))
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

feature -- Execute

	execute
			-- Execute actions without calling build first
		do
			build.execute
		end

end
