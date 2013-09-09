note
	description: "Summary description for {SE_COMPOSITE_ACTION}."
	author: ""
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
		do
			create {ARRAYED_LIST[SE_ACTION]}actions.make (5)
		ensure
			actions_empty: actions.is_empty
		end

feature -- Execute

	execute
		do
			across actions as c  loop c.item.execute end
		end

feature -- Access

	count: INTEGER
		do
			Result := actions.count
		end

feature -- Change Element

	add_action (a_action: SE_ACTION)
		do
			actions.force (a_action)
		end

feature {NONE} -- Implementation

	actions: LIST[SE_ACTION]

end
