note
	description: "Summary description for {SE_CAPABILITIES_JSON_CONVERTER}."
	date: "$Date$"
	revision: "$Revision$"

class
	SE_CAPABILITIES_JSON_CONVERTER

inherit

	SE_JSON_CONVERTER

create
	make

feature {NONE} -- Initialization

	make
		do
			create object.make
		end

feature -- Access

	object: SE_CAPABILITIES

feature -- Conversion

	from_json (a_json: detachable JSON_VALUE; ctx: JSON_DESERIALIZER_CONTEXT; a_type: detachable TYPE [detachable ANY]): detachable like object
		do
			create Result.make
			if attached {JSON_OBJECT} a_json as j then
				if attached {JSON_STRING} j.item (browser_name_key) as l_item then
					Result.set_browser_name(l_item.unescaped_string_32)
				end
				if attached {JSON_STRING} j.item (version_key) as l_item then
					Result.set_version(l_item.unescaped_string_32)
				end
				if attached {JSON_STRING} j.item (platform_key) as l_item then
					Result.set_platform(l_item.unescaped_string_32)
				end
				if attached {JSON_BOOLEAN} j.item (javascriptenabled_key) as l_item then
					Result.set_javascript_enabled (l_item.item)
				end
				if attached {JSON_BOOLEAN} j.item (takesscreenshot_key) as l_item then
					Result.set_takes_screenshot (l_item.item)
				end
				if attached {JSON_BOOLEAN} j.item (handlesalerts_key) as l_item then
					Result.set_handles_alerts (l_item.item)
				end
				if attached {JSON_BOOLEAN} j.item (locationcontextenabled_key) as l_item then
					Result.set_location_context_enabled (l_item.item)
				end
				if attached {JSON_BOOLEAN} j.item (applicationcacheenabled_key) as l_item then
					Result.set_application_cache_enabled (l_item.item)
				end
				if attached {JSON_BOOLEAN} j.item (browserconnectionenabled_key) as l_item then
					Result.set_browser_connection_enabled (l_item.item)
				end
				if attached {JSON_BOOLEAN} j.item (cssselectorsenabled_key) as l_item then
					Result.set_css_selectors_enabled (l_item.item)
				end
				if attached {JSON_BOOLEAN} j.item (webstorageenabled_key) as l_item then
					Result.set_web_storage_enabled (l_item.item)
				end
				if attached {JSON_BOOLEAN} j.item (rotatable_key) as l_item then
					Result.set_rotatable (l_item.item)
				end
				if attached {JSON_BOOLEAN} j.item (acceptsslcerts_key) as l_item then
					Result.set_accept_ssl_certs (l_item.item)
				end
				if attached {JSON_BOOLEAN} j.item (nativeevents_key) as l_item then
					Result.set_native_events (l_item.item)
				end
	--			if attached {WEB_DRIVER_PROXY} json_to_object (j.item (proxy_key), {WEB_DRIVER_PROXY}) as lv then
	--				Result.set_proxy(lv)
	--			end

			end
		end

	to_json (obj: detachable ANY; ctx: JSON_SERIALIZER_CONTEXT): JSON_VALUE
		local
			jo: JSON_OBJECT
		do
			if attached {SE_CAPABILITIES} obj as o then
				create jo.make_with_capacity (15)
				if attached o.browser_name as l_bn then
					jo.put_string (l_bn, browser_name_key)
				end
				if attached o.version as l_ver then
					jo.put_string (l_ver, version_key)
				end
				if attached o.platform as l_platform then
					jo.put_string (l_platform, platform_key)
				end
				jo.put_boolean (o.is_javascript_enabled, javascriptenabled_key)
				jo.put_boolean (o.takes_screenshot, takesscreenshot_key)
				jo.put_boolean (o.handles_alerts, handlesalerts_key)
				jo.put_boolean (o.is_database_enabled, databaseenabled_key)
				jo.put_boolean (o.is_location_context_enabled, locationcontextenabled_key)
				jo.put_boolean (o.is_application_cache_enabled, applicationcacheenabled_key)
				jo.put_boolean (o.is_browser_connection_enabled, browserconnectionenabled_key)
				jo.put_boolean (o.is_css_selectors_enabled, cssselectorsenabled_key)
				jo.put_boolean (o.is_web_storage_enabled, webstorageenabled_key)
				jo.put_boolean (o.is_rotatable, rotatable_key)
				jo.put_boolean (o.accept_ssl_certs, acceptsslcerts_key)
				jo.put_boolean (o.native_events, nativeevents_key)
				--Result.put (json.value (o.proxy),proxy_key)
				Result := jo
			else
				create {JSON_NULL} Result
			end
		end

feature {NONE} -- Implementation

	browser_name_key: JSON_STRING
		once
			create Result.make_from_string ("browserName")
		end

	version_key: JSON_STRING
		once
			create Result.make_from_string ("version")
		end

	platform_key: JSON_STRING
		once
			create Result.make_from_string ("platform")
		end

	javascriptEnabled_key: JSON_STRING
		once
			create Result.make_from_string ("javascriptEnabled")
		end

	takesScreenshot_key: JSON_STRING
		once
			create Result.make_from_string ("takesScreenshot")
		end

	handlesAlerts_key: JSON_STRING
		once
			create Result.make_from_string ("handlesAlerts")
		end

	databaseEnabled_key: JSON_STRING
		once
			create Result.make_from_string ("databaseEnabled")
		end

	locationContextEnabled_key: JSON_STRING
		once
			create Result.make_from_string ("locationContextEnabled")
		end

	applicationCacheEnabled_key: JSON_STRING
		once
			create Result.make_from_string ("applicationCacheEnabled")
		end

	browserConnectionEnabled_key: JSON_STRING
		once
			create Result.make_from_string ("browserConnectionEnabled")
		end

	cssSelectorsEnabled_key: JSON_STRING
		once
			create Result.make_from_string ("cssSelectorsEnabled")
		end

	webStorageEnabled_key: JSON_STRING
		once
			create Result.make_from_string ("webStorageEnabled")
		end

	rotatable_key: JSON_STRING
		once
			create Result.make_from_string ("rotatable")
		end

	acceptSslCerts_key: JSON_STRING
		once
			create Result.make_from_string ("acceptSslCerts")
		end

	nativeEvents_key: JSON_STRING
		once
			create Result.make_from_string ("nativeEvents")
		end

	proxy_key: JSON_STRING
		once
			create Result.make_from_string ("proxy")
		end

end
