note
	description: "[
				Move the mouse to a location within the element provided. The coordinates provided specify the
 				offset from the top-left corner of the element.
					]"
	date: "$Date$"
	revision: "$Revision$"

class
	SE_MOVE_TO_OFFSET_ACTION

inherit

	SE_MOUSE_ACTION

	SE_ACTION

create
	make_with_offset,
 	make_with_location_and_offset

feature {NONE} -- Initialization

	make_with_location_and_offset (a_mouse: SE_MOUSE; a_coordinate: SE_COORDINATES; a_xoffset: INTEGER; a_yoffset: INTEGER)
			-- Create a mouse action with `a_mouse' and `a_coordinates'
		do
			set_mouse (a_mouse)
			set_location (a_coordinate)
			set_yoffset (a_yoffset)
			set_xoffset (a_xoffset)
		ensure
			mouse_set: mouse = a_mouse
			location_set: location /= Void implies location = a_coordinate
			y_offet_set: y_offset = a_yoffset
			x_offet_set: x_offset = a_xoffset
		end


	 make_with_offset (a_mouse: SE_MOUSE; a_xoffset: INTEGER; a_yoffset: INTEGER)
			-- Create a mouse action with `a_mouse' and `a_coordinates'
		do
			set_mouse (a_mouse)
			set_yoffset (a_yoffset)
			set_xoffset (a_xoffset)
		ensure
			mouse_set: mouse = a_mouse
			y_offet_set: y_offset = a_yoffset
			x_offet_set: x_offset = a_xoffset
		end

feature -- Access

	y_offset: INTEGER
	x_offset: INTEGER

feature -- Change Element

	set_xoffset (a_value: INTEGER)
			-- Set `x_offset' with `a_value'
		do
			x_offset := a_value
		ensure
			x_offet_set: x_offset = a_value
		end

	set_yoffset (a_value: INTEGER)
			-- Set `y_offset' with `a_value'
		do
			y_offset := a_value
		ensure
			y_offet_set: y_offset = a_value
		end


feature -- Execute

	execute
		do
			mouse.mouse_move_by_params (location, x_offset, y_offset)
		end

end
