note
	description: "Summary description for {SE_TIMEOUT_TYPE_JSON_CONVERTER}."
	date: "$Date$"
	revision: "$Revision$"

class
	SE_TIMEOUT_TYPE_JSON_CONVERTER

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

	object: SE_TIMEOUT_TYPE

feature -- Conversion

	from_json (a_json: detachable JSON_VALUE; ctx: JSON_DESERIALIZER_CONTEXT; a_type: detachable TYPE [detachable ANY]): detachable like object
		do
			if attached {JSON_OBJECT} a_json as j then
				create Result.make_empty
				if attached {JSON_STRING} j.item (type_key) as l_item then
					Result.set_type (l_item.unescaped_string_32)
				end
				if attached {JSON_NUMBER}  j.item (ms_key) as l_item  then
					Result.set_ms (l_item.integer_64_item.to_integer_32)
				end
			end
		end

	to_json (obj: detachable ANY; ctx: JSON_SERIALIZER_CONTEXT): JSON_VALUE
		local
			jo: JSON_OBJECT
		do
			if attached {SE_TIMEOUT_TYPE} obj as o then
				create jo.make_with_capacity (2)
				if attached o.type as l_type then
					jo.put_string (l_type, type_key)
				end
				jo.put_integer (o.ms, ms_key)
				Result := jo
			else
				create {JSON_NULL} Result
			end
		end

feature {NONE} -- Implementation

	type_key: JSON_STRING
		once
			create Result.make_from_string ("type")
		end

	ms_key: JSON_STRING
		once
			create Result.make_from_string ("ms")
		end


end
