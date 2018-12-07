note
	description: "Object that represent an active session"
	date: "$Date$"
	revision: "$Revision$"

class
	SE_SESSION

create
	make

feature -- Initializaton

	make (a_session_id : STRING_32; a_capabilities: SE_CAPABILITIES)
			-- Create a session with session `a_session_id' and capabilities `a_capabilities'.
		do
			session_id := a_session_id
			capabilities := a_capabilities
		ensure
			session_set: session_id = a_session_id
			capatiblites_set: capabilities = a_capabilities
		end

feature -- Access

	session_id : STRING_32
		-- The session id.

	capabilities : SE_CAPABILITIES
		-- An object describing the session's capabilities.

end
