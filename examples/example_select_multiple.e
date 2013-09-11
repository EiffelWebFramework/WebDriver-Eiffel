note
	description: "Summary description for {EXAMPLE_SELECT_MULTIPLE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EXAMPLE_SELECT_MULTIPLE


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
			test_select_multiple
		end

feature -- Test


	test_select_multiple
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
			web_driver.to_url ("http://jqueryui.com/demos/selectable/")
			web_driver.frame_by_index (0)
			create wait.make (web_driver,100)

				-- Create a new instance of actions
			create actions.make (web_driver)

				-- Find links
			if attached {LIST[WEB_ELEMENT]} web_driver.find_elements ((create {SE_BY}).css_selector("ol#selectable *")) as l_elements  then

				actions.click_and_hold (l_elements.at (1)).
						click_and_hold (l_elements.at (2)).
						click_current.
						execute

			end
			io.read_line
				-- close the window
			web_driver.window_close
		end
end
