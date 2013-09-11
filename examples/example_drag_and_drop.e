note
	description: "Summary description for {EXAMPLE_DRAG_AND_DROP}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=Drag and Drop Example","src=http://www.theautomatedtester.co.uk/blog/2011/selenium-advanced-user-interactions.html", "protocol=uri"

class
	EXAMPLE_DRAG_AND_DROP


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
			test_drag_and_drop
			test_droppeable
		end

feature -- Search by id

	test_drag_and_drop
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
			if attached {WEB_ELEMENT}web_driver.find_element ((create {SE_BY}).class_name ("draggable")) as l_draggable and then
				attached {WEB_ELEMENT}web_driver.find_element ((create {SE_BY}).name ("droppable")) as l_droppable then

				actions.drag_and_drop (l_draggable,l_droppable)
						.execute
			end
			print ("%Nend process ..." )
				-- close the window
			web_driver.window_close
		end

	test_droppeable
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
			web_driver.to_url ("http://jqueryui.com/demos/droppable/")
			web_driver.frame_by_index (0)
			create wait.make (web_driver,100)

				-- Create a new instance of actions
			create actions.make (web_driver)

				-- Find links
			if attached {WEB_ELEMENT} web_driver.find_element ((create {SE_BY}).id ("draggable")) as l_draggable and then
				attached {WEB_ELEMENT}web_driver.find_element ((create {SE_BY}).id ("droppable")) as l_droppable then

				actions.drag_and_drop (l_draggable,l_droppable)
						.execute
			end
			io.read_line
				-- close the window
			web_driver.window_close
		end

end
