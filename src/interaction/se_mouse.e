note
	description: "Summary description for {SE_MOUSE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SE_MOUSE

create
	make

feature {NONE} -- Initialization

	make ( a_web_driver : like driver)
			-- Create an object se_mouse with his driver
		do
			driver := a_web_driver
		ensure
			web_driver_set : driver = a_web_driver
		end

feature  -- Mouse Actions

	click (a_coordinates: detachable SE_COORDINATES)
		do
			move_if_needed (a_coordinates)
			if attached driver.session as l_session then
				driver.api.click (l_session.session_id, create {SE_BUTTON}.make_left)
			end
		end

	double_click (a_coordinates: detachable SE_COORDINATES)
		do
			move_if_needed (a_coordinates)
			if attached driver.session as l_session then
				driver.api.double_click (l_session.session_id)
			end
		end

	mouse_down (a_coordinates: detachable SE_COORDINATES)
		do
			move_if_needed (a_coordinates)
			if attached driver.session as l_session then
				driver.api.button_down (l_session.session_id, create {SE_BUTTON}.make_left)
			end
		end


	mouse_up (a_coordinates: detachable SE_COORDINATES)
		do
			move_if_needed (a_coordinates)
			if attached driver.session as l_session then
				driver.api.button_up (l_session.session_id, create {SE_BUTTON}.make_left)
			end
		end

	mouse_move (a_coordinates: SE_COORDINATES)
		do
			if attached driver.session as l_session and then attached a_coordinates.auxiliary as l_element then
				driver.api.move_to_default (l_session.session_id,l_element)
			end
		end

	mouse_move_by_params (a_coordinates: detachable SE_COORDINATES; a_param1: INTEGER_64; a_param2: INTEGER_64)
		do
			if attached driver.session as l_session and then attached a_coordinates as l_coordinates and then attached l_coordinates.auxiliary as l_element then
				driver.api.move_to (l_session.session_id,l_element,a_param1, a_param2)
			elseif attached driver.session as l_session then
				driver.api.move_to (l_session.session_id,Void,a_param1, a_param2)
			end
		end

	context_click (a_coordinates: detachable  SE_COORDINATES)
			-- Right click an element
		do
			move_if_needed (a_coordinates)
			if attached driver.session as l_session then
				driver.api.click (l_session.session_id, create {SE_BUTTON}.make_right)
			end
		end



feature {NONE} -- Implementation

	move_if_needed (a_coordinates: detachable SE_COORDINATES)
		do
			if attached a_coordinates as l_coordinates then
				mouse_move (a_coordinates)
			end
		end

	driver : WEB_DRIVER
		-- web_driver

end
