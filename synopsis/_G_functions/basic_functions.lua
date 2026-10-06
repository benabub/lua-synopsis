-------------------------------
--         print
-------------------------------
--[[
function print(...any)

    Receives any number of arguments and prints their values to `stdout`,
    converting each argument to a string following the same rules of
    [tostring](http://www.lua.org/manual/5.1/manual.html#pdf-tostring).
]]

-- print(nil, 15, "asd", { "a", "b" }) -- nil     15      asd     table: 0x5771ea059cb0

-------------------------------
--         type
-------------------------------
--[[
function type(v: any)
  -> type: "boolean"|"function"|"nil"|"number"|"string"...(+3)

    Returns the type of its only argument, coded as a string. The possible
    results of this function are `"nil"` (a string, not the value `nil`),
    `"number"`, `"string"`, `"boolean"`, `"table"`, `"function"`, `"thread"`,
    and `"userdata"`.

[View documents](http://www.lua.org/manual/5.1/manual.html#pdf-type)

type:
    | "nil"
    | "number"
    | "string"
    | "boolean"
    | "table"
    | "function"
    | "thread"
    | "userdata"
]]

-- print(type(15)) -- number
-- print(type("asd")) -- string
-- print(type({})) -- table
-- print(type(nil)) -- nil
-- print(type(false)) -- boolean

-------------------------------
--         tonumber
-------------------------------
--[[
function tonumber(e: any)
  -> number?

    When called with no `base`, `tonumber` tries to convert its argument to a
    number. If the argument is already a number or a string convertible to a
    number, then `tonumber` returns this number; otherwise, it returns `fail`.
    The conversion of strings can result in integers or floats, according to
    the lexical conventions of Lua (see
    [§3.1](http://www.lua.org/manual/5.1/manual.html#3.1)). The string may
    have leading and trailing spaces and a sign.

[View documents](http://www.lua.org/manual/5.1/manual.html#pdf-tonumber)
]]

-- print(type(tonumber("asd"))) -- nil
-- print(type(tonumber("123"))) -- number
-- print(type(tonumber(123))) -- number
-- print(type(tonumber(nil))) -- nil

-------------------------------
--         tostring
-------------------------------
--[[
function tostring(v: any)
  -> string

    Receives a value of any type and converts it to a string in a
    human-readable format.
    If the metatable of `v` has a `__tostring` field, then `tostring` calls the
    corresponding value with `v` as argument, and uses the result of the call
    as its result. Otherwise, if the metatable of `v` has a `__name` field with
    a string value, `tostring` may use that string in its final result.
    For complete control of how numbers are converted, use
    [string.format](http://www.lua.org/manual/5.1/manual.html#pdf-string.format).

[View documents](http://www.lua.org/manual/5.1/manual.html#pdf-tostring)
]]

-- print(type(tostring(123))) -- string
-- print(type(tostring("asd"))) -- string
-- print(type(tostring(nil))) -- string

-------------------------------
--         assert
-------------------------------
--[[
function assert(v?: <T>, message?: any, ...any)
  -> <T>
  2. ...any

    Raises an error if the value of its argument v is false (i.e., `nil` or
    `false`); otherwise, returns all its arguments. In case of error, `message`
    is the error object; when absent, it defaults to `"assertion failed!"`

[View documents](http://www.lua.org/manual/5.1/manual.html#pdf-assert)
]]

-- -- condition check
-- local function func(a)
-- 	assert(a ~= 1, "1 not allowed")
-- 	return a
-- end
-- print(func(2)) -- 2
-- print(func(1)) -- 1 not allowed

-- -- variable check
-- local function func(a)
-- 	assert(a, "a is nil")
-- 	return a
-- end
-- print(func(2)) -- 2
-- print(func()) -- a is nil

-- -- variable check in assignment
-- local function func(a)
-- 	b = assert(a, "a is nil")
-- 	return b
-- end
-- print(func(2)) -- 2
-- print(func()) -- a is nil

-------------------------------
--         error
-------------------------------
--[[
function error(message: any, level?: integer)

    Terminates the last protected function called and returns message as the
    error object.
    Usually, `error` adds some information about the error position at the
    beginning of the message, if the message is a string.

[View documents](http://www.lua.org/manual/5.1/manual.html#pdf-error)
]]

-- if 5 ~= 5 then
-- 	print("hello")
-- else
-- 	error("massage")
-- end

-------------------------------
--         pcall
-------------------------------
--[[
function pcall(f: fun(...any):...unknown, arg1?: any, ...any)
  -> success: boolean
  2. result: any
  3. ...any

    protected call

    Calls the function `f` with the given arguments in *protected mode*. This
    means that any error inside `f` is not propagated; instead, `pcall` catches
    the error and returns a status code. Its first result is the status code (a
    boolean), which is true if the call succeeds without errors. In such case,
    `pcall` also returns all results from the call, after this first result. In
    case of any error, `pcall` returns `false` plus the error object.

[View documents](http://www.lua.org/manual/5.1/manual.html#pdf-pcall)
]]

-- local function divide(a, b)
-- 	if b == 0 then
-- 		error("b can't be a 0")
-- 	end
-- 	return a / b
-- end
-- --
-- print(pcall(divide, 4, 2)) -- true    2.0
-- print(pcall(divide, 4, 0))
-- -- false   lua_base_synopsis/_G/basic_functions.lua:158: b can't be a 0

-------------------------------
--         xpcall
-------------------------------
--[[
function xpcall(f: fun(...any):...unknown, msgh: function, arg1?: any, ...any)
  -> success: boolean
  2. result: any
  3. ...any

    x-protected call

    msgh == "message handler

    Calls function `f` with the given arguments in protected mode with a new
    message handler.

    msgh accepts exactly one argument — the error object.
    We do not pass it manually; it is passed automatically inside xpcall.

[View documents](http://www.lua.org/manual/5.1/manual.html#pdf-xpcall)
]]

-- -- Function where an error can occur
-- local function divide(a, b)
-- 	if b == 0 then
-- 		error("b cannot be 0")
-- 	end
-- 	return a / b
-- end
-- --
-- -- Handler function (msgh) that automatically receives the error object
-- local function my_handler(err)
-- 	return "LOG: " .. tostring(err)
-- end
-- --
-- -- Successful call (returns true and the function result)
-- print(xpcall(divide, my_handler, 10, 2)) -- true    5
-- --
-- -- Call with an error (returns false and whatever my_handler returned)
-- print(xpcall(divide, my_handler, 10, 0)) -- false   LOG: b cannot be 0

-------------------------------
--         select
-------------------------------
--[[
function select(index: integer|"#", ...any)
  -> any

    If `index` is a number, returns all arguments after argument number
    `index`; a negative number indexes from the end (`-1` is the last
    argument). Otherwise, `index` must be the string `"#"`, and `select`
    returns the total number of extra arguments it received.

[View documents](http://www.lua.org/manual/5.1/manual.html#pdf-select)

index:
    | "#"
]]

-- print(select("#", 1, nil, "asd")) -- 3
-- print(select(2, 1, nil, "asd")) -- nil     asd
--
-- local function get_last_item(...)
-- 	return select(-1, ...)
-- end
--
-- print(get_last_item(1, nil, 42)) -- 42

-------------------------------
--         warn
-------------------------------
--[[
function warn(message: string, ...any)

    Emits a warning with a message composed by the concatenation of all its
    arguments (which should be strings).

    - warn — outputs a warning to stderr.
    - Does not interrupt the program.
    - Concatenates arguments without a separator.
    - OFF by default (enable with warn("@on"))   - Lua 5.4+ only.

[View documents](http://www.lua.org/manual/5.4/manual.html#pdf-warn)
]]

-- warn("@on") -- enable warnings first
-- warn("Massage", "Cat", "Dog") -- Lua warning: MassageCatDog
-- warn("@off") -- disable
-- warn("This will not show")

-------------------------------
