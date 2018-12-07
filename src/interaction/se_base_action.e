note
	description: "Summary description for {SE_BASE_ACTION}."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	SE_BASE_ACTION

feature -- Change Element

	set_location (a_location: SE_COORDINATES)
		do
			location := a_location
		ensure
			location_set: location /= Void implies location = a_location
		end

feature -- Access

	location: detachable SE_COORDINATES
		--Coordintates of the current action, if any.
end
