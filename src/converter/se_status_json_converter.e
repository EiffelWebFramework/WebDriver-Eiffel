note
	description: "A converter for SE_STATUS"
	date: "$Date$"
	revision: "$Revision$"

class
	SE_STATUS_JSON_CONVERTER

inherit

	SE_JSON_CONVERTER

create
	make

feature {NONE} -- Initialization

	make
		do
			create object
		end

feature -- Access

	object: SE_STATUS

feature -- Conversion

	from_json (a_json: detachable JSON_VALUE; ctx: JSON_DESERIALIZER_CONTEXT; a_type: detachable TYPE [detachable ANY]): detachable like object
		do
			if attached {JSON_OBJECT} a_json as j then
				create Result
				if attached {JSON_NUMBER} j.item (status_key) as l_status_key then
					Result.set_status (l_status_key.integer_64_item.to_integer_32)
				end
				if attached {JSON_STRING} j.item (session_id_key) as l_ucs then
					Result.set_session_id (l_ucs.unescaped_string_32)
				end
				if attached {JSON_STRING} j.item (state_key) as l_ucs then
					Result.set_state (l_ucs.unescaped_string_32)
				end
				if attached {JSON_STRING} j.item (class_name_key) as l_ucs then
					Result.set_class_name (l_ucs.unescaped_string_32)
				end
				if attached {JSON_NUMBER} j.item (status_key) as l_status_key then
					Result.set_hash_code (l_status_key.representation)
				end
				if attached {SE_STATUS_VALUE} ctx.value_from_json (j.item (value_key), {SE_STATUS_VALUE}) as c then
					Result.set_value (c)
				end
			end
		end

	to_json (obj: detachable ANY; ctx: JSON_SERIALIZER_CONTEXT): JSON_VALUE
		local
			jo: JSON_OBJECT
		do
			if attached {SE_STATUS} obj as o then
			 	create jo.make
			   	jo.put_integer (o.status, status_key)
			   	if attached o.session_id as s_id then
			  		jo.put_string (s_id, session_id_key)
			   	end
			   	if attached o.state as l_state then
					jo.put_string (l_state, state_key)
			   	end
			   	if attached o.class_name as l_class_name then
			   		jo.put_string (l_class_name, class_name_key)
			   	end
			   	if attached o.hash_code as l_hash_code then
			   		jo.put_string (l_hash_code, hash_code_key)
			   	end
				if attached o.value as l_value then
					jo.put (ctx.to_json (l_value, create {SE_STATUS_VALUE_JSON_CONVERTER}.make), value_key)
				end
				Result := jo
		     else
		        create {JSON_NULL} Result
		     end
		end

feature {NONE} -- Implementation


	status_key: JSON_STRING
		once
			create Result.make_from_string ("status")
		end

	session_id_key: JSON_STRING
		once
			create Result.make_from_string ("sessionId")
		end

	value_key: JSON_STRING
		once
			create Result.make_from_string ("value")
		end

	state_key: JSON_STRING
		once
			create Result.make_from_string ("state")
		end

	class_name_key: JSON_STRING
		once
			create Result.make_from_string ("class")
		end

	hash_code_key : JSON_STRING
		once
			create Result.make_from_string ("hCode")
		end

note
	copyright: "2011-2012, Javier Velilla, Jocelyn Fiat and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
