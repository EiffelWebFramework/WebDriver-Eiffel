note
	description: "Summary description for {SE_COMPOSITE_ACTION}."
	date: "$Date$"
	revision: "$Revision$"

class
	SE_COMPOSITE_ACTION

inherit

	SE_ACTION

create
	make

feature {NONE} -- Initialization

	make
			-- Create an empty composite actions
		do
			create {ARRAYED_LIST[SE_ACTION]}actions.make (5)
		ensure
			actions_empty: is_empty
		end

feature -- Execute

	execute
		do
			across actions as c  loop c.item.execute end
		end

feature -- Access

	count: INTEGER
			-- Number of items
		do
			Result := actions.count
		end

feature -- Status report

	is_empty: BOOLEAN
			-- Is the current list of actions empty?
		do
			Result := actions.is_empty
		end

feature -- Change Element

	add_action (a_action: SE_ACTION)
		do
			actions.force (a_action)
		end

feature {NONE} -- Implementation

	actions: LIST[SE_ACTION]

end
