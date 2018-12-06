note
	description: "Summary description for {SE_COOKIE_JSON_CONVERTER}."
	date: "$Date$"
	revision: "$Revision$"

class
	SE_COOKIE_JSON_CONVERTER
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

	object: SE_COOKIE

feature -- Conversion

	from_json (a_json: detachable JSON_VALUE; ctx: JSON_DESERIALIZER_CONTEXT; a_type: detachable TYPE [detachable ANY]): detachable like object
	-- from_json (j: like to_json): detachable like object
		do
			create Result
			if attached {JSON_OBJECT} a_json as j then
				if attached {JSON_STRING} j.item (name_key) as l_item then
					Result.set_name(l_item.unescaped_string_32)
				end
				if attached {JSON_STRING} j.item (value_key) as l_item then
					Result.set_value(l_item.unescaped_string_32)
				end
				if attached {JSON_STRING} j.item (path_key) as l_item then
					Result.set_path(l_item.unescaped_string_32)
				end
				if attached {JSON_STRING} j.item (domain_key) as l_item then
					Result.set_domain(l_item.unescaped_string_32)
				end
				if attached {JSON_BOOLEAN} j.item (secure_key) as l_item then
					if l_item.item then
						Result.secure
					end
				end
				if attached {JSON_NUMBER} j.item (expiry_key) as l_item then
					Result.set_expiry (l_item.natural_64_item.to_natural_32)
				end
			end
		end

	to_json (obj: detachable ANY; ctx: JSON_SERIALIZER_CONTEXT): JSON_VALUE
	--to_json (o: like object): JSON_OBJECT
		local
			jo: JSON_OBJECT
		do
			if attached {SE_COOKIE} obj as o then
				create jo.make
				if attached o.name as l_name then
					jo.put_string (l_name, name_key)
				end
				if attached o.value as l_value then
					jo.put_string (l_value, value_key)
				end
				if attached o.path as l_path then
					jo.put_string (l_path, path_key)
				end
				if attached o.domain as l_domain then
					jo.put_string (l_domain, domain_key)
				end
				jo.put_boolean (o.is_secure, secure_key)
				jo.put_natural (o.expiry, expiry_key)
				Result :=  jo
			else
				create {JSON_NULL} Result
			end
		end

feature {NONE} -- Implementation



	name_key: JSON_STRING
		once
			create Result.make_from_string ("name")
		end

	value_key: JSON_STRING
		once
			create Result.make_from_string ("value")
		end

	path_key: JSON_STRING
		once
			create Result.make_from_string ("path")
		end

	domain_key: JSON_STRING
		once
			create Result.make_from_string ("domain")
		end

	secure_key : JSON_STRING
		once
			create Result.make_from_string ("secure")
		end

	expiry_key : JSON_STRING
		once
			create Result.make_from_string ("expiry")
		end


end
