note
	description: "Provides coordinates of an element for advanced interactions"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SE_COORDINATES

inherit

	REFACTORING_HELPER

create
	make

feature {NONE} -- Initialization

	make (a_web_element: like element)
			-- Create an object coordinet from an element
		do
			element := a_web_element
		ensure
			element_set: element = a_web_element
		end

feature -- Access

	on_screen: detachable SE_POINT
			-- Gets Coordinates on the element relative to the top-left corner of the monitor (screen).
		do
			to_implement ("Not supported yet.")
		end

	in_view_port: detachable SE_POINT
			-- Gets coordinates on the element relative to the top-left corner of OS-window being used
			-- to display the content. Usually it is the browser window's viewport.
		do
			Result := element.api.location_in_view (element.session_id, element.element)
		end

	on_page: detachable SE_POINT
			-- Gets coordinates on the element relative to the top-left corner of the page.
		do
			Result := element.api.element_location (element.session_id, element.element)
		end

	auxiliary: detachable WEB_ELEMENT
		do
			Result := element
		end

feature -- {NONE} -- Implementations

	element: WEB_ELEMENT
			-- web_element

end
