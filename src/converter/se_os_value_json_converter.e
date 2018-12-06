note
	description: "Summary description for {SE_OS_VALUE_JSON_CONVERTER}."
	date: "$Date$"
	revision: "$Revision$"

class
	SE_OS_VALUE_JSON_CONVERTER

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

	object: SE_OS_VALUE

feature -- Conversion

	from_json (a_json: detachable JSON_VALUE; ctx: JSON_DESERIALIZER_CONTEXT; a_type: detachable TYPE [detachable ANY]): detachable like object
	--from_json (j: like to_json): detachable like object
		do
			create Result.make_empty
			if attached {JSON_OBJECT} a_json as j then
				if attached {JSON_STRING} j.item (version_key) as l_key then
					Result.set_version (l_key.unescaped_string_32)
				end
				if attached {JSON_STRING} j.item (name_key) as l_name then
					Result.set_name (l_name.unescaped_string_32)
				end
				if attached {JSON_STRING} j.item (architecture_key) as l_arch then
					Result.set_architecture (l_arch.unescaped_string_32)
				end
			end
		end

	to_json (obj: detachable ANY; ctx: JSON_SERIALIZER_CONTEXT): JSON_VALUE
	-- to_json (o: like object): JSON_OBJECT
		local
			jo: JSON_OBJECT
		do
			if attached {SE_OS_VALUE} obj as o then
				create jo.make_with_capacity (3)
				if attached o.architecture as l_arch then
					jo.put_string (l_arch, architecture_key)
				end
				if attached o.name as l_name then
					jo.put_string (l_name, name_key)
				end
				if attached o.version as l_version then
					jo.put_string (l_version, version_key)
				end
				Result := jo
			else
				 create {JSON_NULL} Result
			end
		end

feature {NONE} -- Implementation

	version_key: JSON_STRING
		once
			create Result.make_from_string ("version")
		end

	name_key: JSON_STRING
		once
			create Result.make_from_string ("name")
		end

	architecture_key: JSON_STRING
		once
			create Result.make_from_string ("arch")
		end

end
