note
	description: "Summary description for {SE_MOUSE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SE_MOUSE

create
	make
feature {NONE} -- Initialization
	make ( a_web_driver : like driver)
			-- Create an object se_mouse with his driver
		do
			driver := a_web_driver
		ensure
			web_driver_set : driver = a_web_driver
		end


--  public RemoteMouse(ExecuteMethod executor) {
--    this.executor = executor;
--  }


--  protected Map<String, Object> paramsFromCoordinates(Coordinates where) {
--    Map<String, Object> params = Maps.newHashMap();

--    if (where != null) {
--      String id = (String) where.getAuxiliary();
--      params.put("element", id);
--    }

--    return params;
--  }

--  protected void moveIfNeeded(Coordinates where) {
--    if (where != null) {
--      mouseMove(where);
--    }
--  }

--  public void click(Coordinates where) {
--    moveIfNeeded(where);

--    executor.execute(DriverCommand.CLICK, ImmutableMap.of("button", 0));
--  }

--  public void contextClick(Coordinates where) {
--    moveIfNeeded(where);

--    executor.execute(DriverCommand.CLICK, ImmutableMap.of("button", 2));
--  }

--  public void doubleClick(Coordinates where) {
--    moveIfNeeded(where);

--    executor.execute(DriverCommand.DOUBLE_CLICK, ImmutableMap.<String, Object>of());
--  }

--  public void mouseDown(Coordinates where) {
--    moveIfNeeded(where);

--    executor.execute(DriverCommand.MOUSE_DOWN, ImmutableMap.<String, Object>of());
--  }

--  public void mouseUp(Coordinates where) {
--    moveIfNeeded(where);

--    executor.execute(DriverCommand.MOUSE_UP, ImmutableMap.<String, Object>of());
--  }

--  public void mouseMove(Coordinates where) {
--    Map<String, Object> moveParams = paramsFromCoordinates(where);

--    executor.execute(DriverCommand.MOVE_TO, moveParams);
--  }

--  public void mouseMove(Coordinates where, long xOffset, long yOffset) {
--    Map<String, Object> moveParams = paramsFromCoordinates(where);
--    moveParams.put("xoffset", xOffset);
--    moveParams.put("yoffset", yOffset);

--    executor.execute(DriverCommand.MOVE_TO, moveParams);
--  }

feature {NONE} -- Implementation
	driver : WEB_DRIVER
		-- web_driver

	json_template : String = "[
				{"value" :"$value",
				"isdown" : $boolean}
			]"
end
