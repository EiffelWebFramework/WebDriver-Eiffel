note
	description: "Summary description for {EXAMPLE_DOUBLE_CLICK}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EXAMPLE_DOUBLE_CLICK

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
			test_double_click
		end

feature -- Test


	test_double_click
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
			web_driver.to_url ("http://cookbook.seleniumacademy.com/DoubleClickDemo.html")
			create wait.make (web_driver,100)

				-- Create a new instance of actions
			create actions.make (web_driver)

				-- Find links
			if attached {WEB_ELEMENT} web_driver.find_element ((create {SE_BY}).id("message")) as l_element  then

				if attached l_element.get_css_value ("background-color")  as l_value then
--					check
--					 Expected_blue: l_value.same_string ("%"rgb(0, 0, 255,1)"%")
--					end
				end
				actions.double_click (l_element).execute

				if attached l_element.get_css_value ("background-color")  as l_value then
--					check
--					 Expected_yellow: l_value.same_string ("%"rgb(255, 255, 0,1)"%")
--					end
				end
			end
			print("%NEnd Process ...")
			io.read_line
				-- close the window
			web_driver.window_close
		end

end
