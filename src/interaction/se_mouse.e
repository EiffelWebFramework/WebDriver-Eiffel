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

	click (a_coordinates: SE_COORDINATES)
		do
		end

	double_click (a_coordinates: SE_COORDINATES)
		do

		end

	mouse_down (a_coordinates: SE_COORDINATES)
		do

		end


	mouse_up (a_coordinates: SE_COORDINATES)
		do

		end

	mouse_move (a_coordinates: SE_COORDINATES)
		do

		end

	mouse_move_by_params (a_coordinates: SE_COORDINATES; a_param1: INTEGER_64; a_param2: INTEGER_64)
		do

		end

	context_click (a_coordinates: SE_COORDINATES)
		do

		end



feature {NONE} -- Implementation


	params_from_coordinates (a_where: SE_COORDINATES): HASH_TABLE[ANY,STRING]
		do
			create Result.make(1)
			if attached {STRING} a_where.auxiliary as l_id then
				Result.force (l_id,"element")
			end
		end



	driver : WEB_DRIVER
		-- web_driver

	json_template : String = "[
				{"value" :"$value",
				"isdown" : $boolean}
			]"
end
