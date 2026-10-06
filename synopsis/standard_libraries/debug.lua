-- for k, _ in pairs(_G.debug) do
-- 	print(k)
-- end

--[[
getmetatable
gethook
getlocal
upvaluejoin
setuservalue
getregistry
getinfo
setmetatable
sethook
getupvalue
getuservalue
setcstacklimit
debug
traceback
setupvalue
setlocal
upvalueid
]]

local function print_table(t)
	for k, v in pairs(t) do
		print(k, v)
	end
end

-------------------------------
--         getmetatable
-------------------------------
--[[
function debug.getmetatable(value: any) -> table? | nil

    Returns the metatable of the given value.

    NB: needed only for debugging or bypassing __metatable protection.
    Regular code should use getmetatable().

    - Unlike getmetatable, ignores the __metatable field.

    NB: low-level. Bypasses protection.
]]

-- local t = {}
-- local mt = { __metatable = "protected" }
-- setmetatable(t, mt)
-- print(getmetatable(t)) -- protected (fake)
-- print(debug.getmetatable(t)) -- table: 0x... (real metatable)
-- print_table(debug.getmetatable(t))
-- -- __metatable	protected
-- print_table(getmetatable(t))
-- -- bad argument #1 to 'for iterator' (table expected, got string)

-------------------------------
--         gethook
-------------------------------
--[[
function debug.gethook(thread?: thread) -> function?, string, integer

    NB: low-level. Only for debuggers.

    Returns the current hook settings of the thread.
]]

-- print(debug.gethook()) -- nil

-------------------------------
--         getlocal
-------------------------------
--[[
function debug.getlocal(thread?: thread|level: integer, index: integer)
  -> string? | nil
  2. any

    NB: low-level. Only for debuggers.

    Returns the name and value of a local variable at the given stack level.
]]

-- local function f()
-- 	local x = 10
-- 	print(debug.getlocal(1, 1)) -- x    10
-- end
-- f()

-------------------------------
--         upvaluejoin
-------------------------------
--[[
function debug.upvaluejoin(f1: function, n1: integer, f2: function, n2: integer)

    NB: very low-level. Rarely used.

    Makes the n1-th upvalue of f1 refer to the n2-th upvalue of f2.
]]

-- local a, b = 1, 2
-- local f1 = function()
-- 	return a
-- end
-- local f2 = function()
-- 	return b
-- end
-- debug.upvaluejoin(f1, 1, f2, 1)

-------------------------------
--         setuservalue
-------------------------------
--[[
function debug.setuservalue(udata: userdata, value: any, n?: integer) -> userdata

    NB: very low-level. Only for C userdata.
    requires userdata from C, not available in pure Lua

    Sets the n-th user value of udata to value. (Lua 5.4)
]]

-------------------------------
--         getregistry
-------------------------------
--[[
function debug.getregistry() -> table

    NB: low-level. Only for C modules.

    Returns the registry table (a table that C code can use to store
    Lua values it needs).
]]

-- local reg = debug.getregistry()
-- print(type(reg)) -- table

-------------------------------
--         getinfo
-------------------------------
--[[
function debug.getinfo(thread?: thread|f: function|level: integer, what?: string)
  -> table? | nil

    NB: low-level. Only for debuggers.

    Returns a table with information about a function or stack level.

    what - string describing which fields to fill:
      "n" - name, "S" - source, "l" - currentline,
      "u" - upvalues, "t" - tail call, "f" - function itself,
      "L" - active lines
]]

-- local info = debug.getinfo(1)
-- print(info.currentline) -- line number
-- print(info.source) -- @filename

-------------------------------
--         setmetatable
-------------------------------
--[[
function debug.setmetatable(value: any, table: table?) -> value

    NB: low-level. Only for C modules and debuggers.

    Sets the metatable for the given value. Returns the value.

    - Unlike setmetatable, works on any type.
    - Can set metatable for numbers, strings, booleans, etc.
]]

-- debug.setmetatable(10, {
-- 	__index = function()
-- 		return "hi"
-- 	end,
-- })
-- print((10).anything) -- hi

-------------------------------
--         sethook
-------------------------------
--[[
function debug.sethook(thread?: thread, hook?: function|string, mask?: string, count?: integer)

    NB: low-level. Only for debuggers.

    Sets a hook function that is called on certain events.

    mask - combination of "c" (call), "r" (return), "l" (line)
    count - if given, hook is called every count instructions
]]

-- debug.sethook(function()
-- 	print("called")
-- end, "c")
-- local function f() end
-- f() -- called

-------------------------------
--         getupvalue
-------------------------------
--[[
function debug.getupvalue(f: function, index: integer) -> string? | nil
  2. any

    NB: low-level. Only for debuggers.

    Returns the name and value of the index-th upvalue of f.
]]

-- local x = 10
-- local f = function()
-- 	return x
-- end
-- print(debug.getupvalue(f, 1)) -- x    10

-------------------------------
--         getuservalue
-------------------------------
--[[
function debug.getuservalue(udata: userdata, n?: integer) -> any, boolean

    NB: very low-level. Only for C userdata.
    requires userdata from C, not available in pure Lua

    Returns the n-th user value associated with udata. (Lua 5.4)
]]

-------------------------------
--  setcstacklimit -- deprecated
-------------------------------
--[[
function debug.setcstacklimit(limit: integer) -> integer?

    NB: do not use.

    Sets a new limit for the C stack.
]]

-------------------------------
--         debug
-------------------------------
--[[
function debug.debug()

    NB: dangerous. Blocks execution until "cont" is entered.

    Enters an interactive mode with the user, running each string
    that the user enters.
]]

-------------------------------
--         traceback
-------------------------------
--[[
function debug.traceback(thread?: thread, message?: any, level?: integer) -> string

    NB: needed for error reporting.

    Returns a string with a traceback of the call stack.

    message - prepended to traceback (default "")
    level   - starting stack level (default 1)
]]

-- local function f()
-- 	print(debug.traceback("Error:"))
-- end
-- f()
-- -- Error:
-- -- stack traceback: ...

-------------------------------
--         setupvalue
-------------------------------
--[[
function debug.setupvalue(f: function, index: integer, value: any) -> string? | nil

    NB: low-level. Only for debuggers.

    Sets the value of the index-th upvalue of f.
    Returns the name of the upvalue, or nil if out of range.
]]

-- local x = 10
-- local f = function()
-- 	return x
-- end
-- debug.setupvalue(f, 1, 20)
-- print(f()) -- 20

-------------------------------
--         setlocal
-------------------------------
--[[
function debug.setlocal(thread?: thread|level: integer, index: integer, value: any)
  -> string? | nil

    NB: low-level. Only for debuggers.

    Sets the value of a local variable at the given stack level.
    Returns the name of the variable, or nil.
]]

-- local function f()
-- 	local x = 10
-- 	debug.setlocal(1, 1, 20)
-- 	print(x) -- 20
-- end
-- f()

-------------------------------
--         upvalueid
-------------------------------
--[[
function debug.upvalueid(f: function, n: integer) -> lightuserdata

    NB: very low-level. Rarely used.

    Returns a unique identifier for the n-th upvalue of f.
    Two upvalues share the same id if they refer to the same variable.
]]

-- local x = 10
-- local f = function()
-- 	return x
-- end
-- local g = function()
-- 	return x
-- end
-- print(debug.upvalueid(f, 1) == debug.upvalueid(g, 1)) -- true
