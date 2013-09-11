note
	description: "Summary description for {EXAMPLE_DRAW_ON_CANVAS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=Canvas Example","src=http://www.theautomatedtester.co.uk/blog/2011/selenium-advanced-user-interactions.html", "protocol=uri"

class
	EXAMPLE_DRAW_ON_CANVAS

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
			row_selection_using_control_key
		end

feature -- Search by id

	row_selection_using_control_key
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
			web_driver.to_url ("http://www.theautomatedtester.co.uk/demo1.html")

			create wait.make (web_driver,100)

				-- Create a new instance of actions
			create actions.make (web_driver)

				-- Find links
			if attached {WEB_ELEMENT}web_driver.find_element ((create {SE_BY}).id ("tutorial")) as l_element then

				actions.click_and_hold (l_element).
						move_by_offset (-40,-60).
						move_by_offset (30, 20).
						move_by_offset (100,200).
						release (l_element).execute
			end
			print ("%Nend process ..." )
			io.read_line
				-- close the window
			web_driver.window_close
		end


end
