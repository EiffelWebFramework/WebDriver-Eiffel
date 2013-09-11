note
	description: "Summary description for {EXAMPLE_DRAGGING_ARROUND}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=Dragging Example","src=http://www.theautomatedtester.co.uk/blog/2011/selenium-advanced-user-interactions.html", "protocol=uri"
	EIS: "name=Advance Interaction","src=http://selenium.polteq.com/en/perform-a-sequence-of-actions-with-selenium-webdriver/#sthash.2uaD8CFs.dpuf", "protocol=uri"
class
	EXAMPLE_DRAGGING_ARROUND

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
--			test_dragging_around
			test_draggable
		end

feature -- Search by id

	test_dragging_around
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
			web_driver.to_url ("http://www.theautomatedtester.co.uk/demo2.html")

			create wait.make (web_driver,100)

				-- Create a new instance of actions
			create actions.make (web_driver)

				-- Find links
			if attached {WEB_ELEMENT}web_driver.find_element ((create {SE_BY}).class_name ("draggable")) as l_element then

				actions.click_and_hold (l_element).
						move_by_offset (30,20).
						move_by_offset (100, 200).
						release (l_element).execute
			end
			print ("%Nend process ..." )
			io.read_line
				-- close the window
			web_driver.window_close
		end


	test_draggable
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
			web_driver.to_url ("http://jqueryui.com/demos/draggable/")
			web_driver.frame_by_index (0)
			create wait.make (web_driver,100)

				-- Create a new instance of actions
			create actions.make (web_driver)

				-- Find links
			if attached {WEB_ELEMENT} web_driver.find_element ((create {SE_BY}).id ("draggable")) as l_draggable then

				actions.drag_and_drop_by (l_draggable,120,120)
						.execute
			end
			print ("%Nend process ..." )
			io.read_line
				-- close the window
			web_driver.window_close
		end


end
