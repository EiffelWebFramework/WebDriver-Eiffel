note
	description: "Summary description for {SE_STATUS_VALUE_JSON_CONVERTER}."
	date: "$Date$"
	revision: "$Revision$"

class
	SE_STATUS_VALUE_JSON_CONVERTER
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

	object: SE_STATUS_VALUE

feature -- Conversion

	from_json (a_json: detachable JSON_VALUE; ctx: JSON_DESERIALIZER_CONTEXT; a_type: detachable TYPE [detachable ANY]): detachable like object
	--from_json (j: like to_json): detachable like object
		do
			if attached {JSON_OBJECT} a_json as j then
				create Result.make_empty
				if attached {SE_OS_VALUE} ctx.value_from_json (j.item (os_key), {SE_OS_VALUE}) as c then
					Result.set_os_value (c)
				end
				if attached {SE_JAVA_VALUE} ctx.value_from_json (j.item (java_key), {SE_OS_VALUE}) as c then
					Result.set_java_value (c)
				end
				if attached {SE_BUILD_VALUE} ctx.value_from_json (j.item (build_key), {SE_OS_VALUE}) as c then
					Result.set_build_value (c)
				end
			end
		end

	to_json (obj: detachable ANY; ctx: JSON_SERIALIZER_CONTEXT): JSON_VALUE
	--to_json (o: like object): JSON_OBJECT
		local
			jo: JSON_OBJECT
		do
			if attached {SE_STATUS_VALUE} obj as o then
				create jo.make_with_capacity (3)
				if attached o.os_value as l_val then
					jo.put (ctx.to_json (l_val, create {SE_OS_VALUE_JSON_CONVERTER}.make), os_key)
				end
				if attached o.java_value as l_val then
					jo.put (ctx.to_json (l_val, create {SE_JAVA_VALUE_JSON_CONVERTER}.make), java_key)
				end
				if attached o.build_value as l_val then
					jo.put (ctx.to_json (l_val, create {SE_BUILD_VALUE_JSON_CONVERTER}.make), build_key)
				end
				Result := jo
			else
				create {JSON_NULL} Result
			end
		end

feature {NONE} -- Implementation



	os_key: JSON_STRING
		once
			create Result.make_from_string ("os")
		end

	java_key: JSON_STRING
		once
			create Result.make_from_string ("java")
		end

	build_key: JSON_STRING
		once
			create Result.make_from_string ("build")
		end

end
