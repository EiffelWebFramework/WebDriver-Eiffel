note
	description: "Summary description for {SE_RESPONSE_JSON_CONVERTER}."
	date: "$Date$"
	revision: "$Revision$"

class
	SE_RESPONSE_JSON_CONVERTER

inherit

	SE_JSON_CONVERTER

create
	make

feature {NONE} -- Initialization

	make
		do
			create object.make_empty
		end

feature -- Access

	object: SE_RESPONSE

feature -- Conversion

	from_json (a_json: detachable JSON_VALUE; ctx: JSON_DESERIALIZER_CONTEXT; a_type: detachable TYPE [detachable ANY]): detachable like object
		do
			create Result.make_empty
			if attached {JSON_OBJECT} a_json as j then
				if attached {JSON_STRING} j.item (session_key) as l_session_id then
					Result.set_session_id (l_session_id.unescaped_string_32)
				end
				if attached {JSON_NUMBER} j.item (status_key) as l_status then
					Result.set_status (l_status.integer_64_item.to_integer_32)
				end
				if attached {JSON_VALUE}  j.item (value_key) as l_item then
					Result.set_value(l_item.representation)
				end
			end
		end

	to_json (obj: detachable ANY; ctx: JSON_SERIALIZER_CONTEXT): JSON_VALUE
		local
			jo: JSON_OBJECT
		do
			if attached {SE_RESPONSE} obj as o then
				create jo.make
				if attached o.session_id as l_session_id then
					jo.put_string (l_session_id, session_key)
				end
				jo.put_integer (o.status, status_key)
				if attached o.value as l_value then
					jo.put_string (l_value, value_key)
				end
				Result := jo
			else
				 create {JSON_NULL} Result
			end
		end

feature {NONE} -- Implementation

	session_key: JSON_STRING
		once
			create Result.make_from_string ("sessionId")
		end

	status_key: JSON_STRING
		once
			create Result.make_from_string ("status")
		end

	value_key: JSON_STRING
		once
			create Result.make_from_string ("value")
		end

end
