note
	description: "Summary description for {EXAMPLE_SLIDER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EXAMPLE_SLIDER
inherit

	ANY
		redefine
			default_create
		end

create
	default_create

feature  {NONE} -- Initialization

	default_create
		do
			test_slider
		end

feature -- Test


	test_slider
		local
			web_driver: WEB_DRIVER
			wait: WEB_DRIVER_WAIT
			actions: SE_ACTIONS
		do
				--Create a new instance of a Web driver
			create web_driver.make

				-- Start session with chrome
			web_driver.start_session_chrome

				-- Go to Page under test
			web_driver.to_url ("http://jqueryui.com/demos/slider/")
			web_driver.frame_by_index (0)
			create wait.make (web_driver,100)

				-- Create a new instance of actions
			create actions.make (web_driver)

				-- Find links
			if attached {WEB_ELEMENT} web_driver.find_element ((create {SE_BY}).class_name("ui-slider-handle")) as l_element  then

				actions.drag_and_drop_by (l_element, 120, 0).execute

			end
			print("%NEnd Process")
			io.read_line
				-- close the window
			web_driver.window_close
		end
end
