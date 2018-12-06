note
	description: "Summary description for {SE_BUILD_VALUE_JSON_CONVERTER}."
	date: "$Date$"
	revision: "$Revision$"

class
	SE_BUILD_VALUE_JSON_CONVERTER
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

	object: SE_BUILD_VALUE

feature -- Conversion

	from_json (a_json: detachable JSON_VALUE; ctx: JSON_DESERIALIZER_CONTEXT; a_type: detachable TYPE [detachable ANY]): detachable like object
	--from_json (j: like to_json): detachable like object
		do
			if attached {JSON_OBJECT} a_json as j then
				create Result.make_empty
				if attached {JSON_STRING} j.item (version_key) as l_item then
					Result.set_version (l_item.unescaped_string_32)
				end
				if attached {JSON_STRING} j.item (revision_key) as l_item then
					Result.set_revision (l_item.unescaped_string_32)
				end
				if attached {JSON_STRING} j.item (time_key) as l_item then
					Result.set_time (l_item.unescaped_string_32)
				end
			end
		end

	to_json (obj: detachable ANY; ctx: JSON_SERIALIZER_CONTEXT): JSON_VALUE
	--to_json (o: like object): JSON_OBJECT
		local
			jo: JSON_OBJECT
		do
			if attached {SE_BUILD_VALUE} obj as o then
				create jo.make_with_capacity (3)
				if attached o.version as l_version then
					jo.put_string (l_version, version_key)
				end
				if attached o.revision as l_revision then
					jo.put_string (l_revision, revision_key)
				end
				if attached o.time as l_time then
					jo.put_string (l_time, time_key)
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

	time_key: JSON_STRING
		once
			create Result.make_from_string ("time")
		end

	revision_key: JSON_STRING
		once
			create Result.make_from_string ("revision")
		end

end
