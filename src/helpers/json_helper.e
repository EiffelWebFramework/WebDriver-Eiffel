note
	description: "Summary description for {JSON_HELPER}."
	date: "$Date$"
	revision: "$Revision$"

class
	JSON_HELPER

feature -- Access

	to_json (an_object : ANY) :detachable JSON_VALUE
		local
			serializer: JSON_SERIALIZATION
		do
			create serializer.make_with_context (initialize_serialization_ctx)
			if  attached serializer.to_json (an_object) as lv then
				Result := lv
			end
		end

	string_to_json ( str: STRING_32): detachable JSON_VALUE
		local
			parser: JSON_PARSER
		do
			create parser.make_with_string (str)
			parser.parse_content
			if parser.is_valid and then attached parser.parsed_json_value as st then
				Result := st
			end
		end

	json_to_se_status (post: STRING_32): detachable SE_STATUS
		local
			parser: JSON_PARSER
			ctx: JSON_DESERIALIZER_CONTEXT
			l_conv: SE_STATUS_VALUE_JSON_CONVERTER
		do
			ctx := initialize_deserialization_ctx
			create l_conv.make
			create parser.make_with_string (post)
			parser.parse_content
			if parser.is_valid and then attached parser.parsed_json_value as st then
				if attached {SE_STATUS} l_conv.from_json (st, ctx, Void) as l_status then
					Result := l_status
				end
			end
		end

	json_to_se_capabilities (post: STRING_32): detachable SE_CAPABILITIES
		local
			parser: JSON_PARSER
			ctx: JSON_DESERIALIZER_CONTEXT
			l_conv: SE_CAPABILITIES_JSON_CONVERTER
		do
			ctx := initialize_deserialization_ctx
			create l_conv.make
			create parser.make_with_string (post)
			parser.parse_content
			if parser.is_valid and then attached parser.parsed_json_value as st then
				if attached {SE_CAPABILITIES} l_conv.from_json (st, ctx, Void)  as l_capabilities then
					Result := l_capabilities
				end
			end
		end

	json_to_se_response (post: STRING_32): detachable SE_RESPONSE
		local
			parser: JSON_PARSER
			ctx: JSON_DESERIALIZER_CONTEXT
			l_conv: SE_RESPONSE_JSON_CONVERTER
		do
			ctx := initialize_deserialization_ctx
			create l_conv.make
			create parser.make_with_string (post)
			parser.parse_content
			if parser.is_valid and then attached parser.parsed_json_value as st then
				if attached {SE_RESPONSE} l_conv.from_json (st, ctx, Void) as l_response then
					Result := l_response
				end
			end
		end

	json_to_se_cookie (post: STRING_32): detachable SE_COOKIE
		local
			parser: JSON_PARSER
			ctx: JSON_DESERIALIZER_CONTEXT
			l_conv: SE_COOKIE_JSON_CONVERTER
		do
			ctx := initialize_deserialization_ctx
			create l_conv.make
			create parser.make_with_string (post)
			parser.parse_content
			if attached {JSON_OBJECT} parser.parsed_json_value as st and parser.is_valid then
				if attached {SE_COOKIE} l_conv.from_json (st, ctx, Void) as l_cookie then
					Result := l_cookie
				end
			end
		end

	initialize_deserialization_ctx: JSON_DESERIALIZER_CONTEXT
		do
			create Result
			Result.register_deserializer (create {SE_BUILD_VALUE_JSON_CONVERTER}.make, {SE_BUILD_VALUE})
			Result.register_deserializer (create {SE_CAPABILITIES_JSON_CONVERTER}.make, {SE_CAPABILITIES})
			Result.register_deserializer (create {SE_COOKIE_JSON_CONVERTER}.make, {SE_COOKIE})
			Result.register_deserializer (create {SE_JAVA_VALUE_JSON_CONVERTER}.make, {SE_JAVA_VALUE})
			Result.register_deserializer (create {SE_OS_VALUE_JSON_CONVERTER}.make, {SE_OS_VALUE})
			Result.register_deserializer (create {SE_RESPONSE_JSON_CONVERTER}.make, {SE_RESPONSE})
			Result.register_deserializer (create {SE_STATUS_JSON_CONVERTER}.make, {SE_STATUS})
			Result.register_deserializer (create {SE_STATUS_VALUE_JSON_CONVERTER}.make, {SE_STATUS_VALUE})
			Result.register_deserializer (create {SE_TIMEOUT_TYPE_JSON_CONVERTER}.make, {SE_TIMEOUT_TYPE})
		end


	initialize_serialization_ctx: JSON_SERIALIZATION_CONTEXT
		do
			create Result
			Result.register (create {SE_BUILD_VALUE_JSON_CONVERTER}.make, {SE_BUILD_VALUE})
			Result.register (create {SE_CAPABILITIES_JSON_CONVERTER}.make, {SE_CAPABILITIES})
			Result.register (create {SE_COOKIE_JSON_CONVERTER}.make, {SE_COOKIE})
			Result.register (create {SE_JAVA_VALUE_JSON_CONVERTER}.make, {SE_JAVA_VALUE})
			Result.register (create {SE_OS_VALUE_JSON_CONVERTER}.make, {SE_OS_VALUE})
			Result.register (create {SE_RESPONSE_JSON_CONVERTER}.make, {SE_RESPONSE})
			Result.register (create {SE_STATUS_JSON_CONVERTER}.make, {SE_STATUS})
			Result.register (create {SE_STATUS_VALUE_JSON_CONVERTER}.make, {SE_STATUS_VALUE})
			Result.register (create {SE_TIMEOUT_TYPE_JSON_CONVERTER}.make, {SE_TIMEOUT_TYPE})
		end

	to_json_value (a_obj: detachable ANY): JSON_VALUE
			-- Convert an object `a_obj' to JSON_VALUE representation.
		local
			obj: ANY
			conv_to: JSON_REFLECTOR_SERIALIZER
			ctx: JSON_SERIALIZER_CONTEXT
		do
			obj := a_obj

				-- Auto serialization, handling table iterable as JSON Object, and iterable as ARRAY. Without typename.
			create conv_to
			create ctx
			ctx.set_pretty_printing
			ctx.set_is_type_name_included (False)
			ctx.set_default_serializer (create {JSON_REFLECTOR_SERIALIZER})
			ctx.register_serializer (create {TABLE_ITERABLE_JSON_SERIALIZER [detachable ANY, READABLE_STRING_GENERAL]}, {TABLE_ITERABLE [detachable ANY, READABLE_STRING_GENERAL]})
			ctx.register_serializer (create {ITERABLE_JSON_SERIALIZER [detachable ANY]}, {ITERABLE [detachable ANY]})

			Result := conv_to.to_json (obj, ctx)
		end
end
